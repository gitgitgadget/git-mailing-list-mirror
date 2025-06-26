Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9925E80D
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972977; cv=none; b=WB1zbalbsVi7Seyia5K/Z39xzejoFA3wi9Rg9pr4wybniQAix8V1veKS3mOY4flTUBQiP2h/dIvQGojTJYQcnNjZZ4N1qT6QQivwAXcmOVgJZLh4ff8VMbOVVQiWduAoCJrhSHBNszqrcwctefxgfRsFmpgFKP2bgXUursSm6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972977; c=relaxed/simple;
	bh=w5Dtam9cZMaHzjM7LUq+p7YKL4PdQfTje07/+myFQY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzYlKedWfadzazuJwTc3ySgsdrF8SjP2tQiRlpdYtFlj+qYz5rPagfOdVqc3F/woaAk+Q0k2Ug49AMaLsdiCCZpDohY1sLnocCqs/cxX8EciaZRJFCHF/LDPIeCAWNzJjeZ1UzIsVfHVCau3ssTCoNQXiWnqRUphDx0AwyHp4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak1r70Kf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak1r70Kf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234fcadde3eso22639295ad.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750972975; x=1751577775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m63GIG7MghUmjfxiXViv5SdgKqeC1epRS2rEm35q24=;
        b=ak1r70KfsvBLzQo4oYDxf+SIdKOSKSZxXDFctRka62MxCDyyS+zKfDgRqwsEpQ3Dlp
         1imFsVxrF6nzQnmkQ6NSrvZ+DDCplTJ5yQj5cHFn7xtYr/TGVDoR4HMK5H/fRIgGPBFB
         y+rP2Nez7bgicq51pg1Pchp6jE+NDY7g0R4BPZtqT+Vvct4G2B8mkIpHnFzX+0QLRfgs
         rM5lZGdJ6Ba4yusWuEUY1GsQxhWHDUpa/V1VEJIsw4W0LNgMNfJG53/YbHftcXUibzRL
         kq8CimED/OVtLjvqPgONI/BrAKwJfuMLs8p6T1GBed8J47ggahcJwBGK5UWPzTzDiRSK
         7tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750972975; x=1751577775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m63GIG7MghUmjfxiXViv5SdgKqeC1epRS2rEm35q24=;
        b=ZDYnXrxX/rkHlyZr+X6HhzQjrGZcFaMtd8FlOC5UTwAQB3lvJur7wE5bJWXMGxCW/0
         trIzmDjj8TFWLD8DXdKbbXuotQZDot1phjlCRd6w/JkW2kZv0d7Xb/8XwCQadpAjaw09
         2m9rBg19DpZXuujPL5R8oLfcFaDJOoihfvEa4KKOZ3HWJBulvFhKqJ5LXd35/45vHNJl
         U/YGfQf30QmvnqipRh5J1Ko3vE9g6wLvQj6B1l/hjxHWwobvB2cLOmYLeUzJ1eqJdabt
         Lpx4YJeHiEDnqmmI7U0VUPgGlPt9x6aUO6eYcBM3bmm5BNZmxXLfu8qIlCM3zqu0aJT9
         Pl3Q==
X-Gm-Message-State: AOJu0YxJWo737g9zk+abhdHw/JbUmMZZD4ijRCR0Ikb4CwKyEiSsB9Zy
	u/DuW9Kurz8qWc0rKBsN2sZ/f+o6qZByCr0QnYjHtsmoKWSp7foifKxCQlf+WA==
X-Gm-Gg: ASbGncvEmeIZ6ek/Sum6MNKyQYa8P/Q10JiLKjDMw2ZCVvniKJ51QBldQyK3xlLYrkW
	n8BmO3pzWWQkER5lCE6t9jJLXQ7LufcFmx/oDeQAKIKFYxXsihQ5QLF3O03L9v/BtDVMruaDN+/
	DxNz9uVlxT01XMZ9T5CqIB32JbOLMWEEAhEUYIKiKZT0vWtPZVdkvEJqarmGznxkpboWuBw8FxT
	K/vZu4Q4J7PxurxvUZMWp67wzxFBy2KH0oBIdZMuyoqD9QzJ17+CxpqUmwgNSNwYfyAvQCOcxhe
	pX1pzNn2aigVF1+dWnE0bVwJKvoLDTs5HRocFd52jFO8mniUUKDmRgdwIB1CkCWbOdHpIJsx2rj
	TE0mPCoXxPwPmPGev
X-Google-Smtp-Source: AGHT+IEVR7MbrfZhEWl/rA1FOrqyqkNQPY7K+S3yem495sx0FuZ1pGATqnNDFdVclntev8jaF43kbQ==
X-Received: by 2002:a17:903:188:b0:22e:3c2:d477 with SMTP id d9443c01a7336-23ac462468amr9517705ad.25.1750972974968;
        Thu, 26 Jun 2025 14:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1bc3sm311995ad.28.2025.06.26.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:22:54 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: chris.torek@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [RFC PATCH 2/2] daemon: poor man's pidfd like POC
Date: Thu, 26 Jun 2025 14:22:34 -0700
Message-Id: <20250626212234.88570-3-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250626212234.88570-1-carenas@gmail.com>
References: <20250626182432.87523-1-carenas@gmail.com>
 <20250626212234.88570-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a pipe for each child, and let the write side leak into
the children, then add the read side to the poll and wait for
the pipe to close (presumed to happen when the child is done).

There is no need to change the children code, since the OS (at
least in *NIX) will close all fds on termination.

This implementation is suboptimal, as it shouldn't need to
scan all children once a notification is received, but does so
to minimize changes.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 74 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..c78556be97 100644
--- a/daemon.c
+++ b/daemon.c
@@ -811,9 +811,19 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
+static void add_child(nfds_t *nfds, struct pollfd **pfd,
+			struct child_process *cld,
+			struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
+	struct pollfd newfd;
+	nfds_t size = *nfds;
+
+	newfd.fd = cld->parent_ipc_in;
+	newfd.events = POLL_HUP;
+	*nfds = size + 1;
+	REALLOC_ARRAY(*pfd, *nfds);
+	memcpy(*pfd + size, &newfd, sizeof(newfd));
 
 	CALLOC_ARRAY(newborn, 1);
 	live_children++;
@@ -846,10 +856,11 @@ static void kill_some_child(void)
 		}
 }
 
-static void check_dead_children(void)
+static void check_dead_children(nfds_t *nfds, struct pollfd *pfd, nfds_t base)
 {
 	int status;
 	pid_t pid;
+	nfds_t size = *nfds;
 
 	struct child **cradle, *blanket;
 	for (cradle = &firstborn; (blanket = *cradle);)
@@ -859,6 +870,20 @@ static void check_dead_children(void)
 				dead = " (with error)";
 			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
 
+			for (nfds_t i = base; i < size; i++)
+				if (pfd[i].fd == blanket->cld.parent_ipc_in) {
+					close(blanket->cld.parent_ipc_in);
+					size--;
+					if (size - i) {
+						MOVE_ARRAY(pfd + i,
+								pfd + i + 1,
+								size - i);
+					}
+
+					*nfds = size;
+					break;
+				}
+
 			/* remove the child */
 			*cradle = blanket->next;
 			live_children--;
@@ -869,14 +894,16 @@ static void check_dead_children(void)
 }
 
 static struct strvec cld_argv = STRVEC_INIT;
-static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
+static void handle(int incoming, nfds_t *nfds, struct pollfd **pfd, nfds_t base,
+			struct sockaddr *addr, socklen_t addrlen)
 {
+	int ipc[2] = { -1, -1 };
 	struct child_process cld = CHILD_PROCESS_INIT;
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
 		sleep(1);  /* give it some time to die */
-		check_dead_children();
+		check_dead_children(nfds, *pfd, base);
 		if (live_children >= max_connections) {
 			close(incoming);
 			logerror("Too many children, dropping connection");
@@ -902,24 +929,22 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 #endif
 	}
 
+#ifndef GIT_WINDOWS_NATIVE
+	pipe(ipc);
+	cld.parent_ipc_in = ipc[0];
+#endif
+
 	strvec_pushv(&cld.args, cld_argv.v);
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
 	if (start_command(&cld))
 		logerror("unable to fork");
-	else
-		add_child(&cld, addr, addrlen);
-}
-
-static void child_handler(int signo UNUSED)
-{
-	/*
-	 * Otherwise empty handler because systemcalls will get interrupted
-	 * upon signal receipt
-	 * SysV needs the handler to be rearmed
-	 */
-	signal(SIGCHLD, child_handler);
+	else {
+		if (ipc[1] != -1)
+			close(ipc[1]);
+		add_child(nfds, pfd, &cld, addr, addrlen);
+	}
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1121,6 +1146,7 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
+	nfds_t nfds = socklist->nr;
 
 	CALLOC_ARRAY(pfd, socklist->nr);
 
@@ -1129,12 +1155,10 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	signal(SIGCHLD, child_handler);
-
 	for (;;) {
-		check_dead_children();
+		size_t i;
 
-		if (poll(pfd, socklist->nr, -1) < 0) {
+		if (poll(pfd, nfds, -1) < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
 				      strerror(errno));
@@ -1143,7 +1167,12 @@ static int service_loop(struct socketlist *socklist)
 			continue;
 		}
 
-		for (size_t i = 0; i < socklist->nr; i++) {
+		for (i = socklist->nr; i < nfds; i++) {
+			if (pfd[i].revents & POLLHUP)
+				check_dead_children(&nfds, pfd, socklist->nr);
+		}
+
+		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				union {
 					struct sockaddr sa;
@@ -1164,7 +1193,8 @@ static int service_loop(struct socketlist *socklist)
 						die_errno("accept returned");
 					}
 				}
-				handle(incoming, &ss.sa, sslen);
+				handle(incoming, &nfds, &pfd, socklist->nr,
+					&ss.sa, sslen);
 			}
 		}
 	}
-- 
2.39.5 (Apple Git-154)

