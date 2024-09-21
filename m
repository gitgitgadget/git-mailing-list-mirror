Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DBBF9F8
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726925156; cv=none; b=KHJycE66HDheWzk7p738Eww+rTeFaG630mtwT3Vg9OI57ZyB89cFtk2jQMiHkNjrHwQReQXcjB3EraDMU4YIQLd6VZFwPXKtrMpajaeKJnVyhzDEHwjCmrCF7iLRU8SakICdUDVDoS3IWfk+U9AHHEgL0D3tRCu2+TGhcLwNQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726925156; c=relaxed/simple;
	bh=I4JWmpl8Kor2Ghi1eC/XOPtnRZiCPkqLrQUbfkBcx40=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tSeqFHbhbhAbVaGsetfNPLGEVqVkiIUBjnICW31glQXsnFIw2vFZv6x3FgxrQwZD6+my5uqp653+m+8Cl22qEivDybZNRwj0QummuSI7dbV8GsCr9Xfls31jT4D86D2K9Iz90PNs5Z45Cf2I01CVdChKR5Po2bUwc/EvZJqDUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxD4pdl+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxD4pdl+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so390026166b.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726925152; x=1727529952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzBJ+QEc9yKmZBuoqIkhyiSaZkKwfeSPONS/roIACBg=;
        b=LxD4pdl+wA1amFoAci6IP/fb8dwojZ6qvwxMbUQXinGn9gOPtxhICH4hdCwphSU7WQ
         ajqWX+yskOfGDwGyPFnoBQZITe8/F+LoryJGk418jKV494kKLezWy7n0dQ1J4emsXuKD
         /Aahi0T0cBl639ANOSyabRg13vJXFGfHd1s459CsJPDhl3ks7TyUo2h4zBM8s/RWUrzF
         bTCrl0wUVf0diYMwLm6s03Yb23xCLitIMnPDMSY7KvxwdN8PGdwilHpyPOsjCjFBHG8N
         Te4ng39zXOZdNWnmr9u7Q9xMZxCc+Kz+LsN1wT3wAHSBO+sLNsYXA5jvnBO1hvfTYKJ9
         D/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726925152; x=1727529952;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzBJ+QEc9yKmZBuoqIkhyiSaZkKwfeSPONS/roIACBg=;
        b=LJFuNrfYN6Vdy1opc3l4qCKdbij+DTP2H02bctHteGrze/Kup6GVjmrip9CVBB3pR3
         1R6hVB53RNHmsq3FJBTrijKmOh+SCtDb8tqy8cJZ0116RJdh9o2oKZo7ZF1CklO38GtJ
         YqFyWQ1w4MZXTwSOChgwguMtXpg/mV5zZb3rTbus10HAglZAHSVz7eUk98GXnuRLF3HV
         GbwLa0xTEnYMU4/2sUzugJY8CU1QZKcVIQ/7nWnHO5NdtsF856mcCqts77pvqlTFMzPU
         /a3t8IeQ6eoZ70leU8BIM4dv/c8K4r75kLUWU1KS008qp3UufzgsicA/CVUGH8z2FYcW
         clEQ==
X-Gm-Message-State: AOJu0Yy9OwKH7rKKJ6FIKzuAHub/wM/Db6GV+NokCf0Sagc/2x+1DAWb
	4gM/5L29aXBV7h0BKkzN2ZqfmJMKijroR8rSHFajoqmwnFUVPufaTm3zUw==
X-Google-Smtp-Source: AGHT+IGpRvSpLJbKeZf2rXUgNJFKs5wOpod5v30hh2GLuVPbTpzfP8YgGQi9uknRwEOSk06VCUyoIw==
X-Received: by 2002:a17:906:bc08:b0:a8d:29a2:47cf with SMTP id a640c23a62f3a-a90d50d03a8mr589449066b.40.1726925151346;
        Sat, 21 Sep 2024 06:25:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b39a2sm971680666b.106.2024.09.21.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 06:25:50 -0700 (PDT)
Message-Id: <pull.1799.v2.git.1726925150113.gitgitgadget@gmail.com>
In-Reply-To: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
References: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Sep 2024 13:25:49 +0000
Subject: [PATCH v2] submodule status: propagate SIGPIPE
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>,
    Matt Liberty <mliberty@precisioninno.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

It has been reported than running

     git submodule status --recurse | grep -q ^+

results in an unexpected error message

    fatal: failed to recurse into submodule $submodule

When "git submodule--helper" recurses into a submodule it creates a
child process. If that process fails then the error message above is
displayed by the parent. In the case above the child is killed by
SIGPIPE as "grep -q" exits as soon as it sees the first match. Fix this
by propagating SIGPIPE so that it is visible to the process running
git. We could propagate other signals but I'm not sure there is much
value in doing that. In the common case of the user pressing Ctrl-C or
Ctrl-\ then SIGINT or SIGQUIT will be sent to the foreground process
group and so the parent process will receive the same signal as the
child.

Reported-by: Matt Liberty <mliberty@precisioninno.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    submodule status: propagate SIGPIPE
    
    Note that I haven't checked if any other submodule subcommands are
    affected by this - I'll leave that to someone more familiar with the
    code.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1799%2Fphillipwood%2Fsubmodule-status-sigpipe-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1799/phillipwood/submodule-status-sigpipe-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1799

Range-diff vs v1:

 1:  64233d5ee0a ! 1:  169e2c06f1a submodule status: propagate SIGPIPE
     @@ Commit message
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/submodule--helper.c ##
     -@@
     - #include "advice.h"
     - #include "branch.h"
     - #include "list-objects-filter-options.h"
     -+#include <signal.h>
     - 
     - #define OPT_QUIET (1 << 0)
     - #define OPT_CACHED (1 << 1)
      @@ builtin/submodule--helper.c: static void status_submodule(const char *path, const struct object_id *ce_oid,
       
       	if (flags & OPT_RECURSIVE) {


 builtin/submodule--helper.c | 6 +++++-
 t/t7422-submodule-output.sh | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a46ffd49b34..4daca494b80 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -695,6 +695,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 	if (flags & OPT_RECURSIVE) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
+		int res;
 
 		cpr.git_cmd = 1;
 		cpr.dir = path;
@@ -710,7 +711,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		if (flags & OPT_QUIET)
 			strvec_push(&cpr.args, "--quiet");
 
-		if (run_command(&cpr))
+		res = run_command(&cpr);
+		if (res == SIGPIPE + 128)
+			raise(SIGPIPE);
+		else if (res)
 			die(_("failed to recurse into submodule '%s'"), path);
 	}
 
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index ab946ec9405..c1686d6bb5f 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,4 +167,11 @@ do
 	'
 done
 
+test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
+	{ git submodule status --recursive 2>err; echo $?>status; } |
+		grep -q X/S &&
+	test_must_be_empty err &&
+	test_match_signal 13 "$(cat status)"
+'
+
 test_done

base-commit: ed155187b429a2a6b6475efe1767053df37ccfe1
-- 
gitgitgadget
