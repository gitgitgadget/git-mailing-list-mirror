Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075653D5674
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091899; cv=none; b=O3vtyN5khiqIIxXOa6LDAWWA0QfhqTSiFd+1pJQoT+qhwbykVoUcNh6c3O4JdjfjsmE0110d6q2tUOgWHqKNW+BKUAXEw5Q4mEOQKNFpHhyFMPQ+Rc0zJy1CkMIDT0TcJS2vekeog7rVhzcagU4Z8gEqn0prAj6sAjEhde5dz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091899; c=relaxed/simple;
	bh=HIN+6Z8bGegsgEGtqK86pKqpKPW/nhlPkP4AXm3zQJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mMoa7kPx1joWNnlhkRaqcwwkiu8MT39JMkkNip7eMkKmSmimgnQwC0Jfdcg7XgP0xucavgJSx7o/EUqPqsLUz5itSpksAD4nraZ//6261oZhtCRD6z9KtzDzSh9h00U5mVemf5JpQj7IRxNZnnd6iNnilrg+7dztINO9WEQsodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmcjW+KP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmcjW+KP"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so1504876a12.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091897; x=1785696697; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ORZuL5otqGlZPUh9/HR4xS9hIF340E/CEsRCss3eEdY=;
        b=LmcjW+KPAmdig1V62ypElvvSAPuXJdXsBbmLR6mt03xfqhpI7OV+hqNDsWFPY5O9/5
         x51YVQ3JkCUkrdqixDyWbOzIDnQurWYbw9y1JKBUK20ZOELary2Pc+DXJGrnwWb8BmZz
         yQ9ugYsnBf2bVkYGY4CVTS3g9Vo24fHpjEadUfckaA0MABpfkfVT9ptmkTBLw91/HAFP
         I+IEydQ12XXKlqdvUGMvlONi527ie+K6D1z7uNIQk8UzIf7oI2rlpLaeIschB5SmDssw
         +yJISgjeuzjFUGvxB+bm2W+h0r1BdDCLUf8rBoifOZwKT3rSmY0QCc0PJuCrXBz7o2bP
         nRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091897; x=1785696697;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORZuL5otqGlZPUh9/HR4xS9hIF340E/CEsRCss3eEdY=;
        b=VPXMCbaB2mxekzeaPp7bE8ZUvHo44GXNMbCxCFsMckeOcAZJVtjPcEPDeOGP/BX0/8
         y13cdKG6Ez1TAsLPteMtaIFuS0Nr6yVEtJ2AsNUnOhtQ4hyVZoxgRPfqvzTshgDN/exh
         8lW8xn3UO7nSMJ2BO5+oAmh6LJjkpV+OtP+ZedV3J+Gt7z6zo28lyluHTS8BYIr0+GKM
         qFxOcjUh5Ae7Yt4RJf4KriYKE1TH5i5S5NEguzm1x9x7EbpbimzKI+oC/q5dPpyuXU/W
         V2R5StUBq5eMjWyHf5pgCOYct9kNeDBZ3Y9IqJ7/+HU4JH3PLQfVBQR8K5CeSABcXYjZ
         3+vw==
X-Gm-Message-State: AOJu0YyXkzN6jDqZdplfNQIMw2yD4u63BxqrM+sVr6STJhsTlzwi3+7u
	lIFE0PS+2jhaBZc1jVpz95RxFDZon/BHpam2mPWnEyJUMAJFrZd3EvqfDxdj6g==
X-Gm-Gg: AR+sD10hFQYdrQPMyKOoelbpQympX5bntmllHv97aZ6geHM5H9jQzCTKNBH5o7VaQU8
	8YjHJqDjlczmuGPxJ5Rt699EHqEGZSmvqpHZDw/ftTF9s/bIa66HETjxj6xpNt9/t1DjvqSygOu
	gkZbIBM0jx2e0A9emY6A719nukkiDGBv0cRbEgd68J1Jis/r3pFnOz5bidjrCZ5EkoheQJ3IBty
	JADzl48IqVy10QdtIJ4BIjaww5atK9qgKvWoksfrUb3wPZ16+lg8y6NZ/vvQaV4477jtpYUUf66
	8gbBij+cnOuUVcOEaIceEGuAbCX4J1EkiGHT2tpTbfkkUOxW9MroF4JCzmNocEvF8TsJl0U5SIj
	0DpgHzByFMJROzJywwwcMEuLZoYSNP1V2gErYYZWjWXnwrbvQCw978QlRN64mqU8xBAFyDr1EoH
	eXUfjU
X-Received: by 2002:a05:6a21:7a45:b0:3c3:8980:e844 with SMTP id adf61e73a8af0-3c67e13e32amr5691680637.57.1785091897300;
        Sun, 26 Jul 2026 11:51:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm32553688eec.31.2026.07.26.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:36 -0700 (PDT)
Message-Id: <850c7cbcf5d6c029e184c056d45e1a6769541494.1785091889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
	<pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:23 +0000
Subject: [PATCH v6 4/9] sub-process: separate process lifecycle from hashmap
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

