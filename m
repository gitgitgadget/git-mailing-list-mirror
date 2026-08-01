Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7D3B8111
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606129; cv=none; b=FA0zIWSEI8FD+x0B9ibA57PzB/tBCTAJMyy54B92WmEiy7gMvN9MWXtrYQ+2mffNf2qwZo42FmD+ms4ZIP1G7CsjFMLHgfasTBVrN5ytb2SndujhjQfHwP+EhfaR0lRVC0OPHTEEyn8qkFeacJPExBbhnkPJ8kloOEdvyu6PEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606129; c=relaxed/simple;
	bh=DBTdIPrBu3ahEIBmqCGbJQSWFOYxebbrpRp0fowU7c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKicPKxE4mTDhpUcJQ/rjbKjoA2txjxp3Og2nAks2GZrgDtOzjue0QiOn9ARnb5qBL7XL05AnUeTlwzxte/UmFAtOZtCh4vC8x5yuZRC3hyCddjwxCKpaHC+ZGDJfKq6lJvqRie1ZkzocnfrPq1Y3+hFQNpST4JIbsshettZ+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFcENdYc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFcENdYc"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1168702a12.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606127; x=1786210927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Otu9k6JcphVvV1GK7SfU8z+N3pKlNMqCy7jeTYGdmn8=;
        b=SFcENdYc6Y7jRcPEbDjjBcHurvlHga3aV5P7Oo9rhioB0NQ4w60wiaAgQNAN3jG5c7
         24PyWcN3CWyQ4PRlxIwtvP1BB5857uF21ggWfdHl4Jav+hK0Daqbj1Illn4nIId3B7Vl
         oaZf1t2P2W1aq2qtNVt7fundZ49IBtIzygxaUKJ4iSPRn5hhgbalfHW+aYJbpceJRhvh
         58WGEVFVap9yOGsz5XraWGqyfDeXC0JWmg2bxVbuB/aAX5N+0PLYKn9d0YOMHyf35PUm
         dv1JwEIoepUvtKqqzVKD2+ETVJD9/d68Hi770WmNuh3E2eLW5hD/mB+l5AVia0fo2hmC
         owww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606127; x=1786210927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Otu9k6JcphVvV1GK7SfU8z+N3pKlNMqCy7jeTYGdmn8=;
        b=eMKNneBMj4SsViKBhxmQEoc0zO3vAQk1IN9Qmp1vvSGyBr6JrPz5fE/MaiplbJTUKV
         5zio86ahoByP9DMAs4F3/2lwjk/Y/GyZFGhw5RJq4V/ztRZSjB8pXlSShys3nVPEz8/x
         zwzsjO6V6HLjJJO41qoZernpHRIAGHL+0fjh6C7PZKbyNwtvvY/hhQv5CC9edsepeM4q
         6uWi1IzNIHugk44M0dHG4rHbXyZl2x5zkB+tmsUa3afmBIUG3BeknyX4wQOSX7frAk9h
         0klcXjZhNKx7yjv3QhT4LxPkchE7TxuIGLfkAw2FDiChSrYARn1Ey65xTdqkffVLRyv2
         oS0g==
X-Gm-Message-State: AOJu0YxigmUvPhI/9RkqCzFsFcPAI4FBp1dMaqBfqshKj9RGuImZvic3
	0XY9iFT2XvXTnrtJTxLohDI2zMkRYjBitRtNl1jeVnwPstFGltqMAUsabpVrQQ==
X-Gm-Gg: AR+sD12GYGKN+pNBOaVM3S2MG7UuWZmEoa4BF/fpQS3tly+WSjb10edNoR4HtlhXdNB
	6/ifSX8ioPTch3N9rhoi72KCBWvuNokE4cd0zljTd4yTEiXQId5L48S/Sro0E76KFovYcQAw9jx
	3/wwwfbvusSXu3lUkDPZKWb7UCfUl3t4A6eVRzhXOPBIr59FmlEPTsg1IfK9SZ/pZyMCpRDvRgX
	QomlaWZliA9puQb0rb55GIY0K7tv3SXTg/5RGuGlQQRIy1C9Gq5JJ+cqBXrlmbr6+Nnj2GM3w24
	1RYZyzX2qrA53AvKimXrMUn2Q1J+2SvPPZhLPVKEsEcyqOFcGQwgx6nz4HLfWdlGvrRZnzUCioM
	jWj21YQCiB9h9dC4TxevJsi2fXmfm/feS+h0raoLg7CGnt2b4hhnXQ4p0NvTVPLScV0965Dze7r
	5DaFinv/8MJuUlQiIzUztkLHxuvQguqAETTmolQut28BWMRC97bgkyXTowYBb5dZvqq5KxUjUbt
	Lvvl+m6rHCjI0jnCXnL+gyZVjLp9jN765s32XTh1GUCMouPiYQHUSxIjJQ6WzmoygLYf7xBu5ho
	6Y/04uAOjUxZYMp+3m+pMQeoGWxXdH/kLNrNyZdZMkYjEg==
X-Received: by 2002:a05:6a20:6a21:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3c92a75b25cmr4005014637.8.1785606127064;
        Sat, 01 Aug 2026 10:42:07 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fc98sm19245133eec.21.2026.08.01.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:06 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 07/10] sub-process: separate process lifecycle from hashmap management
Date: Sat,  1 Aug 2026 10:41:50 -0700
Message-ID: <20260801174156.2998808-8-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

subprocess_start() and subprocess_stop() couple two concerns: managing a
child process (setup, handshake, teardown) and managing a hashmap that
indexes running processes by command string.  The hashmap suits callers
like convert.c where many files may share one filter process looked up
by name, but callers that manage process membership under their own
rules do not need the coupled operations.

Extract subprocess_start_command() and subprocess_stop_command() so
callers can reuse the child process setup and handshake machinery
without the map operations.  subprocess_start() and subprocess_stop()
become thin wrappers that add hashmap operations on top.

The diff process support added later in this series keeps its processes
in a pool owned by a per-repository provider object, and an entry for a
failed command must stay behind there so the command is not retried.
That membership follows rules subprocess_start() and subprocess_stop()
do not know.  The pool therefore uses the _command variants for process
lifecycle and manages its own map.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 sub-process.c | 28 +++++++++++++++++++++++-----
 sub-process.h |  9 ++++++++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 2d5c965169..3cef42b088 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -49,7 +49,7 @@ int subprocess_read_status(int fd, struct strbuf *status)
 	return (len < 0) ? len : 0;
 }
 
-void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
+void subprocess_stop_command(struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -57,7 +57,14 @@ void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
 	entry->process.clean_on_exit = 0;
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
+}
 
+void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
+{
+	if (!entry)
+		return;
+
+	subprocess_stop_command(entry);
 	hashmap_remove(hashmap, &entry->ent, NULL);
 }
 
@@ -72,7 +79,7 @@ static void subprocess_exit_handler(struct child_process *process)
 	finish_command(process);
 }
 
-int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+int subprocess_start_command(struct subprocess_entry *entry, const char *cmd,
 	subprocess_start_fn startfn)
 {
 	int err;
@@ -96,15 +103,26 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 		return err;
 	}
 
-	hashmap_entry_init(&entry->ent, strhash(cmd));
-
 	err = startfn(entry);
 	if (err) {
 		error("initialization for subprocess '%s' failed", cmd);
-		subprocess_stop(hashmap, entry);
+		subprocess_stop_command(entry);
 		return err;
 	}
 
+	return 0;
+}
+
+int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+	subprocess_start_fn startfn)
+{
+	int err;
+
+	err = subprocess_start_command(entry, cmd, startfn);
+	if (err)
+		return err;
+
+	hashmap_entry_init(&entry->ent, strhash(cmd));
 	hashmap_add(hashmap, &entry->ent);
 	return 0;
 }
diff --git a/sub-process.h b/sub-process.h
index bfc3959a1b..45f1b8e5e3 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -52,10 +52,17 @@ int cmd2process_cmp(const void *unused_cmp_data,
  */
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
 
-/* Start a subprocess and add it to the subprocess hashmap. */
+/* Start a subprocess and run the startfn (typically handshake). */
+int subprocess_start_command(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn);
+
+/* Start a subprocess, run startfn, and add it to the subprocess hashmap. */
 int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
 		subprocess_start_fn startfn);
 
+/* Kill a subprocess. */
+void subprocess_stop_command(struct subprocess_entry *entry);
+
 /* Kill a subprocess and remove it from the subprocess hashmap. */
 void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry);
 
-- 
2.54.0

