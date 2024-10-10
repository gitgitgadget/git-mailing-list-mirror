Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D131CB511
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573166; cv=none; b=edyzGm/zd7s9WIJHJKeyWW5Ei+a8ilCBwvuvUI2S12aS5xo+M0OoGtP+writFsD4ECSmgLe3n6w/iNJ1vIlL8Nw7oXashCLCOCvQErtx+9axQvVWtnbuYVvCnXFbDyXEID+iU6IEfPW/lZHmePvX8JAuhYwk79l2yWS2znQzAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573166; c=relaxed/simple;
	bh=Iok3X+IQIRHdMnDCMkRJ8c4sIcwRDiS+AOIq+iskYBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR4/4z+KaWUJ79xcNeSxuLC2yRVXikP/SRshk0Nwwve6WULAGcRYPeKIIb2NgtHVJLDv2H0kXNvnyn8M8q/fkeE2izU1fF8uEZRg/dTP8BSA11FbMRrBOyp+FdwUaL26sYwgmFXa0AxdbWMeF7i158i1eUfbss5E7K8WeA45x20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c57FvAJm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c57FvAJm"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86e9db75b9so185514966b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573163; x=1729177963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYlOnGzWx/8/zl7cUJXuBpArmUWlb9HDj6HXp7fQmAg=;
        b=c57FvAJmr7dZIdiLTQFtErXh2GHv1B18PuCcsetmxthTgdDrUw7DBD7CnIMA0g2nZu
         FC62izIqRj3PT+fUDjHC+404iFkmygNYjVrPWiJJh9lxHkIb5XiEqIG+IcVplL4iAx67
         P3Tn8PGiIU0M9NxV1/z0M0zW1Qf6cOIZBIWNqcWHS4tU4Y43oAvyCizlGjbDC1lxQbEx
         4d0DmYtsk6oPHgIRB4remQ5snoGoJAss9eBcoVKXcgX9Ow17vRpcnatHOkJz9xB7663i
         ctd02iODuwN9+9ceVIZXKpE6qosk4KujY9JMNQxCVNqHK0G8XKonTKOEYa7Wom52h0HE
         BOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573163; x=1729177963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYlOnGzWx/8/zl7cUJXuBpArmUWlb9HDj6HXp7fQmAg=;
        b=fKjb9d1PF8+CEh84b+RxlTiBWN2SbekooSeEgiQbOpzfm77DhrRw11i2IPFGARz3f7
         nTM0/aanSsPNh8V/zRkFVu8m8AXZUcK5kxIYwaCdmgSROngAKGIy/v7RUjo72zmOH6f2
         EthHcjOeNEW4FLRTcsQwpGD28+8yMPdCXxtIRhec55IysiFUZha2kIrm9BoKmeJAdYRB
         aD2gcUHsuGJng/WGunrEyvMCVhPrT6ZfKIV/LZdGIDlhpJywlln2EQBJyG1HF5vset3y
         47d5ZqRE4UGaQYAl3f+QKvzW9HhGlhltz7Um4VE18R3+PUzlC6sm1+sW4N74lqz8EV21
         YFcQ==
X-Gm-Message-State: AOJu0YxVt+2fOdTJtpjCfD8nQhXxXZjZyLTHhU31X8CALp6ZS32PiyFW
	D8X0xTtzA/WeSG9lSDvEb5e3fSvMiuG20sCa10gLGstXkw10jAqrK52qp+dQR1Q=
X-Google-Smtp-Source: AGHT+IHeBj7vaw1gZ9d2PDdQi6btTzvzCusmPjVZA1PuleoH+v6oZ5F14l7hFmLzGhitp1/HO6iMpg==
X-Received: by 2002:a17:907:970e:b0:a99:89ea:593e with SMTP id a640c23a62f3a-a998d117e60mr629267266b.13.1728573162886;
        Thu, 10 Oct 2024 08:12:42 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:42 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/7] compat: fix typos
Date: Thu, 10 Oct 2024 18:11:19 +0300
Message-ID: <20241010151223.311719-2-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos and grammar.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 compat/fsmonitor/fsm-listen-win32.c | 4 ++--
 compat/regex/regexec.c              | 2 +-
 compat/simple-ipc/ipc-unix-socket.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 5a21dade7b..e24d312f30 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -431,9 +431,9 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	 * but I observed ERROR_ACCESS_DENIED (0x05) errors during
 	 * testing.
 	 *
-	 * Note that we only get notificaiton events for events
+	 * Note that we only get notification events for events
 	 * *within* the directory, not *on* the directory itself.
-	 * (These might be properies of the parent directory, for
+	 * (These might be properties of the parent directory, for
 	 * example).
 	 *
 	 * NEEDSWORK: We might try to check for the deleted directory
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index e92be5741d..2eeec82f40 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -292,7 +292,7 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
    concerned.
 
    If REGS is not NULL, and BUFP->no_sub is not set, the offsets of the match
-   and all groups is stroed in REGS.  (For the "_2" variants, the offsets are
+   and all groups are stored in REGS.  (For the "_2" variants, the offsets are
    computed relative to the concatenation, not relative to the individual
    strings.)
 
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 9b3f2cdf8c..fe8d3fe1eb 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -712,7 +712,7 @@ static int accept_thread__wait_for_connection(
  * Block SIGPIPE in this thread for the life of the thread.  This
  * avoids any stray SIGPIPE signals when closing pipe fds under
  * extremely heavy loads (such as when the fifo queue is full and we
- * drop incomming connections).
+ * drop incoming connections).
  */
 static void *accept_thread_proc(void *_accept_thread_data)
 {
-- 
2.43.0

