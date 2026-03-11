Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF542C08A2
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242393; cv=none; b=I+zN6yzx/yABM5J+UeX7fzfvOwMw5N44AWc+IdLJkoLtCU1kgFzjwKlgmP2c9DacgLkWyLRAmRDV4T0lMllTCXsjFAIZOUAmi56thgdiqahOSN/SR0QQsgjNPKz90Ct+2jcLCDljKUy0EXqBwaeq5N0ZyIunc9KVvlbFBx/Udcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242393; c=relaxed/simple;
	bh=vZIWc5NGUtbNDFhT4v8DudMor+Brpu+9E1ZYUBgogD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGhFriLBJNmXM06T/MJX95IY5mhE3ChZDLw0QLvCQKLidIObPq54MJboN8guWc7GehSQz5oHHYi3U2YZ7EGZfPwp6frtE9JV4PEhK41qQYyXiGKhVjQPqZv0yJu0vbjWv43J7Wc7+UovuUT8YIML43xnHgFB6bUvwaR0kmvtl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZRwyR+h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZRwyR+h"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso48701725e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242391; x=1773847191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvRSG0oY5SxYCYFj4Z22GMt8UA/K7ENFmohjzqFYwUQ=;
        b=iZRwyR+h/MKGUKbZrCteT6A+f/P/q4jUyv0JKy+ptAp0X7bEgbnGHbLLUAYlzDKK17
         vYk2pra2CLVsbjX+1GFY8qFswxd61iV6FRUZvbyCD20gfD7/xpVtCXNH42xcl5F5Zc7c
         1i6doGDpxcbgR8BrNW6cStpHLLh0SPI6mv4XGiotrDPSd3YTUIkljE1Y4ECKVxKpdaif
         2REgcBUrCvVg3ugHElV6dI8pt3Hi1pVIVHkfyTOIARBWMLURJLZnAjVn9N8Rxg6+Bx9G
         aJHRY1KbqBMYvgN39RZ5K8Ys3oldhDGSjuVAa90MtR0DNBQFUK3wJNwFAFlEyrbUXgWC
         r1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242391; x=1773847191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvRSG0oY5SxYCYFj4Z22GMt8UA/K7ENFmohjzqFYwUQ=;
        b=EUaYUqs91MUyxDQSaOnVPE7mks2BSSvcX80WZg7aSu5OzlwH4662wyMO7h0SP28ZkU
         swzd9nmOkXBnWN+yjrByPqBPtiR/kRKH8tVtJmQqkQ6qlyf60BRUxB6zdT/YPFB/n/B7
         W6zECdYb06dqCTHkCmZ1i0LwgTJ06fgg4ZfS8QS0b7R4z+bEUGTEW9961REKFX/PHG9V
         YwoImWrepWClWI1L7tW4bXiomKaDhi67IPbhH46DB8dAI0MaIdlkzFfrs4Pjzc2TMhLM
         5MqaWoV9AXF+n0jkHyQu8hWjB0akr/ijq2asAFvQeB/fxm0EgUTmnTaIQm3e2lOEZn/m
         7sog==
X-Gm-Message-State: AOJu0YyAYviK9gM+WjK30/C0hHH1mw7svMNX2s/Ev5jJaG4sW0kdB+YS
	hBehjEpFUUleNtIyArMM1rv7Se8yPE2oVj1P+tElyU16r4qpE7VCJ1FKLp1FWVR9
X-Gm-Gg: ATEYQzznHAHEOUU3bdZDZBSdMSL/27cQlX2uvAtOV+2PLdbJXPxVWYGXKPyoFbrMJQd
	ZhQENazEL2mi5XmF9MCmMbAm0pUvL87utgeOQhaIs5xQVN9nacGMelUNxPhVGHWRq6skPyT0cQ7
	awGrZ/YIe9AfMFsMBYwz3MA0og+A4Ng238bLMN9zsdbCWH33NGVIQ+kxRiElqFv/sHbM67Z9ftb
	w3XkzJrk7Bf9kMq6nzqGdRkygC+JqI77CpMylvV99S0uoH7bdTGhv9H8yPBvK9yYnJHJebOOA20
	Kjdi1GKTilHPquVCcgfV1qG657qyp3TjFe7Z4G4/Gwb6rvPCzxoWsvbwTybHsigjfgCHCYxZMOG
	uMT5tVMrbitl2xYyBvs0hbkBAawiAvgXGBqSEitj99OTf+fguckV5qJGT5ZhqUm7+jQNsUdXb1f
	ZZWi3pm30VqV8gKv8=
X-Received: by 2002:a05:600c:46d2:b0:485:38fc:7080 with SMTP id 5b1f17b1804b1-4854b10ef23mr46242195e9.28.1773242390555;
        Wed, 11 Mar 2026 08:19:50 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm62743975e9.10.2026.03.11.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:19:50 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH 3/4] run-command: redefine start_command() as a wrapper macro
Date: Wed, 11 Mar 2026 18:19:22 +0300
Message-ID: <20260311151923.4178655-4-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the commit introducing 'repo_start_command()', 'start_command()' was
redefined as a wrapper function.

Now, redefine 'start_command()' as a wrapper macro to make 'the_repository'
dependency explicit at the caller's site. To successfully build, expose
'the_repository' dependency at the call sites by defining
'USE_THE_REPOSITORY_VARIABLE' or including 'repository.h' where necessary.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 builtin/credential-cache.c  | 2 ++
 builtin/remote-ext.c        | 2 ++
 column.c                    | 1 +
 credential.c                | 1 +
 midx-write.c                | 2 ++
 prompt.c                    | 1 +
 repack-cruft.c              | 2 ++
 repack-filtered.c           | 2 ++
 repack-midx.c               | 2 ++
 repack-promisor.c           | 2 ++
 run-command.c               | 5 -----
 run-command.h               | 2 +-
 sub-process.c               | 3 +++
 t/helper/test-run-command.c | 2 ++
 14 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 7f733cb756..fb17aa87ba 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "credential.h"
 #include "gettext.h"
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index bd2037f27d..ed2d551753 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "transport.h"
 #include "run-command.h"
diff --git a/column.c b/column.c
index 93fae316b4..998b2ab458 100644
--- a/column.c
+++ b/column.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
diff --git a/credential.c b/credential.c
index 2594c0c422..a513355105 100644
--- a/credential.c
+++ b/credential.c
@@ -1,3 +1,4 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
diff --git a/midx-write.c b/midx-write.c
index 6485cb6706..a53f77f13a 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/prompt.c b/prompt.c
index 706fba2a50..20a8c34438 100644
--- a/prompt.c
+++ b/prompt.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "prompt.h"
 #include "compat/terminal.h"
+#include "repository.h"
 
 static char *do_askpass(const char *cmd, const char *prompt)
 {
diff --git a/repack-cruft.c b/repack-cruft.c
index 0653e88792..0bfc77792a 100644
--- a/repack-cruft.c
+++ b/repack-cruft.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repack.h"
 #include "packfile.h"
diff --git a/repack-filtered.c b/repack-filtered.c
index edcf7667c5..2f5d1dd709 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repack.h"
 #include "repository.h"
diff --git a/repack-midx.c b/repack-midx.c
index 0682b80c42..8b4c0d95e3 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repack.h"
 #include "hash.h"
diff --git a/repack-promisor.c b/repack-promisor.c
index dba161a11a..70ef19d04f 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "repack.h"
 #include "hex.h"
diff --git a/run-command.c b/run-command.c
index fadc3d5283..af26c636a9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -674,11 +674,6 @@ static void trace_run_command(const struct child_process *cp)
 	strbuf_release(&buf);
 }
 
-int start_command(struct child_process *cmd)
-{
-	return repo_start_command(the_repository, cmd);
-}
-
 int repo_start_command(struct repository *repo, struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
diff --git a/run-command.h b/run-command.h
index 654ca659b3..890d7c5d72 100644
--- a/run-command.h
+++ b/run-command.h
@@ -206,7 +206,7 @@ char *git_shell_path(void);
  * See below for details.
  */
 
-int start_command(struct child_process *);
+#define start_command(cmd) repo_start_command(the_repository, cmd)
 int repo_start_command(struct repository *, struct child_process *);
 
 /**
diff --git a/sub-process.c b/sub-process.c
index 83bf0a0e82..ae7493eb5c 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -1,10 +1,13 @@
 /*
  * Generic implementation of background process infrastructure.
  */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "sub-process.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "repository.h"
 
 int cmd2process_cmp(const void *cmp_data UNUSED,
 		    const struct hashmap_entry *eptr,
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 4a56456894..dcd58f228c 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
@@ -18,6 +19,7 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "wildmatch.h"
+#include "repository.h"
 
 static int number_callbacks;
 static int parallel_next(struct child_process *cp,
-- 
2.53.0

