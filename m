Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5F31E84F
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463571; cv=none; b=ak0KJ4/PDsBEjfZ3PCxrSsvUWEZYJyn+VqwpyvEe2ySL3pNiw21MnkskugOOWG37Jx3wLiV3F2EytKD3hfcjzVQ/73S5nKS+r6DWfMzoVB2FrN+stvOMk9mj1g+pj/VUfufSPWOYb7/4/jjqCpXw/wdKzifaOU0yxRHdlgEe8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463571; c=relaxed/simple;
	bh=HIN+6Z8bGegsgEGtqK86pKqpKPW/nhlPkP4AXm3zQJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KecqCvy9AlZt4RnVZHml2ogMh5YM5AWyZx/q6L+kNLqTJpTGk3M6NHkXW3RMdyp0ZMGH319mi2GdWIwP84eEy4UJDaz4uxbOfC0KIGlDM7Ad9U0y8QE7O0MZLhlfRgTmyVmqr1UxPnR1c9GvuxJY/Q4G90qyucdk6B8BNrjVR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df6DYNJU; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df6DYNJU"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304e83724bfso3645529eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463570; x=1782068370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORZuL5otqGlZPUh9/HR4xS9hIF340E/CEsRCss3eEdY=;
        b=df6DYNJUaIJ4yLBs+Ato2Ee6kMGNosLvQjfn2BXAkPOmQ55LtYmdm3mh2GFj5TkVfB
         ASoQ+Fu5bJGkLiLENtUdhC7xsnauFiTq3q0Fn/aZm/MSyieoU2jwFEEfecq4xaZvvoPQ
         PdK5D0wHOpqYsI3JeZN/pwfWbIo0BaZ40N478ZW5umt2BWlRT2v+5HgBrfsnAXRl4rp8
         EOGpxVAYvUsvnj2YvspswgJv2ltjpnY9JlR/RzOd9CHw5o3LRo2cf4Fey7cvlRKwTkPd
         ka1WiP300G+uCTRwq6qCHuPri4wvjtWsyLL3/Q8edfjwIu+8v0F7s8lsG6Oxc47/388P
         pK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463570; x=1782068370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ORZuL5otqGlZPUh9/HR4xS9hIF340E/CEsRCss3eEdY=;
        b=mNYyOY7Sw4Foit94EMza11BFwYG+zT48feUHc03ErSnV4Penel7UQRJwY9FE+m0DS2
         hXXw+FeFEEyWDuqFbzH5HQtd2F1nvZJINu+7b+GYfjLRjngOR3ims9Vc6lbShYyLUPCS
         G3pwfuLwKuq1vcQyW9FC+fjihXg/t7/uG6hXLORM+QbRUgZGETPZ+E9h26EWvfIvQbkV
         /7OqTVhMFI7RDGuigtyRCv+/kkojEAxGNjp3h1WmsEJ2TQpktP6CMYHklM66GWuJw7eF
         wyZ6voEOdf7OlO550M2ff05sh6Q8/f06LzJCCwDcDTngn/hQ2uPQdor9z3fSXEoJt4SM
         OEBA==
X-Gm-Message-State: AOJu0YwEpNLtDoWrBOdMIEdG02ZcNl4Rc7tZjE6iN8tfIlluyzgeTC5q
	ZSCWOd3BKs1Rz9EeL7V5+6gODMDY5HYvwTHTeNNAaOZfmsK4yo6jlmOBSMcHkQ==
X-Gm-Gg: Acq92OGuGhXPUYbTTKGx94v41PcaNclVnVtZ9fn+aKYGFNJaMYKaWRO78eiBMHmytqT
	/ixnrAdqJT53X94sawQV7NDUmxCvCX1jVvX6XSIDeFV5ZK6ZqEy1reaOzeaF42bJIOihG1apdQc
	moIV1nqvoCXgsNyzt7/Fl4WVcVwDbTaT1f+OE7xKxV0oG+z2b/F7pRgcDChrV5Gz29N8RTUGEGp
	AiK2y3kHu05fZivFhmkdlOFHPqMMAdGVOa8JbKd17GH8m3jSE+Rp3vSEWYlYZ4mLbcmlRDjvSK4
	4NQYNi3r12oljUJ3v0Xp7dlph1WeG0BIlQmeu6LTmZlOmCpCNcFLcAyPw1EKx+58/H9gGoPKvrF
	q5j4870+YwZzevX5mJx2EtxuTAPddS5eAbcJf3KS8iLejZh5ll1DrDCe8ihUf6UZbkJhsf67Cnh
	BfX0pYY9YDPSphrX+IGD2h+jUw
X-Received: by 2002:a05:7300:b905:b0:307:d4e7:b18b with SMTP id 5a478bee46e88-3082004bd24mr6166610eec.20.1781463569422;
        Sun, 14 Jun 2026 11:59:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm11583183eec.22.2026.06.14.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:28 -0700 (PDT)
Message-Id: <459e485e6d9c25c071c4fe27a445250c14da55b1.1781463564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:20 +0000
Subject: [PATCH v4 3/6] sub-process: separate process lifecycle from hashmap
 management
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

subprocess_start() and subprocess_stop() couple two concerns:
managing a child process (setup, handshake, teardown) and
managing a hashmap that indexes running processes by command
string.  The hashmap suits callers like convert.c where many
files may share one filter process looked up by name, but
callers that manage process lifetime through their own data
structures do not need it.

Extract subprocess_start_command() and subprocess_stop_command()
so callers can reuse the child process setup and handshake
machinery without maintaining a hashmap.  subprocess_start()
and subprocess_stop() become thin wrappers that add hashmap
operations on top.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 sub-process.c | 28 +++++++++++++++++++++++-----
 sub-process.h |  9 ++++++++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 83bf0a0e82..5468939338 100644
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
gitgitgadget

