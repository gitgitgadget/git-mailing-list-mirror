Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B63CF1F4
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149334; cv=none; b=TO0E33/wzJQ04OKEQcVs4qc9aS0v+zQNsiRwOcIBMNWBduMWBeN3STfOzDzhzY0Nwh/4/89JCD8x/67AcdafAg7KyirrZCN/jI8MqeqkvQLJgYsQLikUq503UbU8Dl/KJbPbmICTojEIMgQYBowduV8WD0BV7IoEyiyD0SQ1ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149334; c=relaxed/simple;
	bh=FpmGFaowwYvGSYkaweoMbr27hwoZoJhzh5GqvL6nwE4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KiXPMMi/oBuyuKCKBw4YoiIXA0HCAPhNPFLVnUp6k/nCc/4cWhDVW50cYA58UdGm/v/mp38M3NjkBydkPWWArS+WHpoR8cvCxH9+Brw7c6H1BiaIajbtrnVyGPMktAD9+2/fjkHloHTXg6Lagl0N//0q+HEQnEFRsDBAvhsfk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJF2TmWW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJF2TmWW"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eeb4508f29so60471116d6.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149332; x=1784754132; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VeMVjSPrT5Gj9ucdk/TKnQl8UXXlTYP39tfP9XG0sfg=;
        b=OJF2TmWWM3OiFrUy5pQzvJtzyCU96wnhUlq8DKk5zKu2alCL8PR76Ar6DHX+eNNu6f
         dvPpGBf6MjMg8cB/2BJyeA12+hJQUyETwdUVu+Hpf9aEI6+N5d2tMjCp0hKnblZSLS7w
         rhST8qBP5cK1bFVa5IBu1TXT1hqcZxdIcbzneu5oPMmdh9WDQImVLgYDCJJDaLPJIhcD
         eST5a1RV/aORENnXgHjCss3C4SLvLu1UnR4c3e+drgv4nQH+SORu9Kql0AMYbQ7UrfOP
         hVAhZZQTe30kHB2Qs2a49/3L34yp1Uirletmc2ppWtJFxtOHy30z3MjSvT8DKRmF5f/U
         HY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149332; x=1784754132;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VeMVjSPrT5Gj9ucdk/TKnQl8UXXlTYP39tfP9XG0sfg=;
        b=aChHLfcXl8MRvojSqEJWwX80fjg0WruQXs94AJUCKae+owi5L78u00LKoDTP7+R+dT
         Ln4C4UCyVRqL6CD1oyeQmRjcz2QYZ6j5npTnue5JFHeMWQoWtdgyy3WbgvH5QVsPhiyp
         VzGbtsNREpYlTJ+14kxRbsS+uVL9mTSonapue/HiA0W7zY6uU9oRrdcLCppaUNCDuupc
         YaC4thShSkJhVohG6FAgXv09WBoaDzK72lpuA8cWjhtynLwAZ2iiRMzQZ7tOMu+NIp8O
         hK111csl4dGoyohduRYwbb7bRnBsbOP6WwEfemZLRQzptkRuRlusNPaoQbHBhstvV/AY
         Z/Ag==
X-Gm-Message-State: AOJu0Yzq/fFrf2sqq3YA+osz6TVx434ZN0Zry/i+Rc5CAO7Q1Isaj0OS
	ajpynKNXJgkKxIEYhuaYpAPybpyT/HQROvgRLA6CmEXlNKigN6/IZctR7SaaNA==
X-Gm-Gg: AfdE7ckT7n1JMMfcfjFc04D3TJF41/mEX3IyJzVDLm4GUdPop8UeE63m4KwbQwBeAk5
	yUSEV4LGeGeBJI0Q4K9f48XB+wSyR0Z3/VD+dD7jR17+qCbNcUql/GuxCE4XKafYCt7l48MxAHi
	02/T8OEVbm3bzOV3cqi1oNT3k3t6oUMu1LdQHteK4oyjmTxXRaPotV5Qd1RMmHC8pkt17OV68A5
	DGHgpVneuHJSFIp1nNUwbrUVnz/LtG2HnfVw+oTGV8eOOrq1kd9eg+nS1p7/3XfGpqK96gbikqj
	CfElLlq+2eeBXOyTh9fA21EGTM/1fX+VRATcCDBMNByWYlYWrYthNtSnoBIgc7ZF3pVIQ0GJzah
	o2WzlSu9NGSkL2jXans89r1trRHoMrap3KYncwXNM0aFymlkabfW8Mwe3QUVPOxO3xvd28k5NYP
	RHGyYB9A==
X-Received: by 2002:a05:6214:3381:b0:8f0:63b6:5881 with SMTP id 6a1803df08f44-90758d0de60mr50851486d6.26.1784149332345;
        Wed, 15 Jul 2026 14:02:12 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-904116650b7sm181239206d6.8.2026.07.15.14.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:11 -0700 (PDT)
Message-Id: <363d459ff6bf75bf5cf59bc35e93f23bdb9bdd36.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:57 +0000
Subject: [PATCH v5 4/9] sub-process: separate process lifecycle from hashmap
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
gitgitgadget

