Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065A339A8
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962285; cv=none; b=eclXYGhbB10EN+Djh9ejj5EHMlWbzbXFsEHzjo7m3I8ZA7hSnSQW6OG0HtlqzSxU484QsKDuBgMUcKokoRy+e4nQqbS4GcvaBqD111f3yvNEu7HJ4QuU4tFlu4HK6ahobwySlhmf/Zf6q7b7SdN5KsNR+d6lHekTeJWb57OPBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962285; c=relaxed/simple;
	bh=KvRJQG7zopCrWZToVrL3V/h17eLScO3NH/Xhhn9P5Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncc3rilwTqiQZsZa4vjy/gOhxdtPUrZx5i5FCq73xaLVo7inhW7p1QOgb5hZ6MT0W5+xoNHKd9DfDUh0afCm1lQpz8qyZdaiPLcz9DxclhiNDuWbiYoZxY33Oo2+COHyhaF2mmh5mR80A6tqb3mkEvaQEXZsb+2dnwsd8qxg2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6f8klEG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6f8klEG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2360ff7ac1bso11689885ad.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750962282; x=1751567082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fVjLUw2LmVkuCmoGLzfjDflgLjdyIsNOAYHjaxvR40=;
        b=k6f8klEGpTI3esAauVkZ3bH2b+WMtj3/iarsx39vToawaTVK0yCorU/LRoSq7PG1Vd
         SXJd1hqjrIacWVu1jRysqqSzEKYzfb7c/1+o3opzPF/yJ3qZ81kkqOFSsNfQ81k1pire
         EFzMXROEGBty4n8CG3LSWumPXJFxmdHfW/BYW3jV2ZvSgOiDu6cEhWuakWg/tZKItwEd
         94SOrZV47/coaKWNWKx4i2a3zP9PJjAX+Mws9ctchC+e21JL9NgzuRAhmpECDpK7SHBm
         kxwcKMC92aorkBdhLh2nOSKANkiF93/OitegHs3gPSQ+HOP91+YaozZ0wTzw84+8i6pT
         q/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962282; x=1751567082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fVjLUw2LmVkuCmoGLzfjDflgLjdyIsNOAYHjaxvR40=;
        b=b+iKCCwDbx35CEn1UcZnNufiZR+5LgjkZpS2+5AAxr2tCej1LA0OCNpnD+b3ID9L61
         HWZNE90xrit/eVcGJ3bsDhxHzAbpXkeqfJkN5+lJYGQskTvfQRV6tXY9v24aeGo1CRq9
         vIz+D4OBHHgR+2lJumBU3jdNwjnGaA6GGKd5BCGPaS9Y2i2rScNx+PL5aTQNRZoVR5lv
         iybxO3TiQ4y5fFoaMXO9Vb5ZUFpUPucvPP/i2m3uTCe8PKGRyrtlrKd2m6IK5fJk5pdm
         Y440/3ITWpseBMZbRcdwIr/6W4tkw6dmvxrsyfyihWIr3mrjTj9JtJCmccKC3qaucFm+
         lC3Q==
X-Gm-Message-State: AOJu0YzyBZD2Cdnn6IHr/+zbSU5d+CVVNAddXrIGV6sFTQpObDV5BbAT
	TrhX81SitBhzYc6Q35tTnm2z3f5Db8ziykvON8ikirt8uJpTB5mZ3dsTyAUCKw==
X-Gm-Gg: ASbGncs9wNZCQWsAY88obp44Arrr++XO5hLB3DprJHa5vhXS7psw/u8wpQSVWiUEXKQ
	ixEkyLE870BsmQKGvfA8tYfpf9m+LGvZrFdbxhaGVwqNnXOmxOpo1py6vSDu/MSUp04EniQrHjE
	SR7a5c0AvueTjJkSgJNI/NCL4TG2TckSGh8nn3c3S8cSh0pnucd15jFwz/6WSRBJ/IloarUbtIp
	Tn51X15QW0TPVjbZX9M63zCRDNshSoWlU5e3Z8SZ5Wuoe32xvuFE+a2I4foJ4S/6GcS2kkjxcdC
	LIfU6l6wtq4HhSiP0Sw5EZV/4M8i+r+ZNspCbG39ETjRX5LDAddCUVYoefDBCi0zhCJ/2shiXDs
	ho8wuTDMm8pvx9DtO
X-Google-Smtp-Source: AGHT+IGo1rBzA694E36kAOq/eqnVQsTrkhsmHUUnRkeDvSMRIug2So29Ntn6xsNR/WYSXYQDs5aSSA==
X-Received: by 2002:a17:903:190d:b0:231:e331:b7df with SMTP id d9443c01a7336-23ac45e3799mr4268515ad.29.1750962282305;
        Thu, 26 Jun 2025 11:24:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe314043sm3672155ad.7.2025.06.26.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 11:24:41 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: chris.torek@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [RFC PATCH] daemon: add a self pipe to trigger reaping of children
Date: Thu, 26 Jun 2025 11:24:32 -0700
Message-ID: <20250626182432.87523-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.131.gcf6f63ea6b.dirty
In-Reply-To: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
References: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There has always been a small race condition between the time a
children status is checked, and the arrival of a SIGCHLD that
would alert us of their demise, hopefully interrupt poll().

To close the gap, add the reading side of a pipe to the poll and
use the signal handler to write to it for each child.

Suggested=by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Implements the "self pipe" trick Hillip suggested.

I tried to make self healing and optional, as I also presume the race
condition it is meant to address is very unlikely.

An obvious disadvantage (at least of this implementation), is that it
actually doubles the number of events that need to be handled for each
children process on most cases (ex: when `poll()` gets interrupted)

I suspect that if fixing that last race condition is so important with
the current foundation, it might be better to reintroduce some sort of
timeout to poll(), so that they will be cleared periodically.

I had a prototype (only the bare minimum) that I thought was more
efficient and that would instead remove completely the need for a
signal handler which I would post (only for RFC) later.

 daemon.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..d3b9421575 100644
--- a/daemon.c
+++ b/daemon.c
@@ -912,14 +912,17 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		add_child(&cld, addr, addrlen);
 }
 
-static void child_handler(int signo UNUSED)
+int poll_pipe[2] = { -1, -1 };
+
+static void child_handler(int signo)
 {
 	/*
-	 * Otherwise empty handler because systemcalls will get interrupted
-	 * upon signal receipt
 	 * SysV needs the handler to be rearmed
 	 */
 	signal(SIGCHLD, child_handler);
+
+	if (poll_pipe[1] >= 0)
+		write(poll_pipe[1], &signo, 1);
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1121,20 +1124,43 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
+	unsigned long nfds = 1 + socklist->nr;
+
+	ALLOC_ARRAY(pfd, nfds);
+	if (!pipe(poll_pipe)) {
+		for (int i = 0; i < 2; i++) {
+			int flags;
+
+			flags = fcntl(poll_pipe[i], F_GETFD, 0);
+			if (flags >= 0)
+				fcntl(poll_pipe[i], F_SETFD, flags | FD_CLOEXEC);
+
+			flags = fcntl(poll_pipe[i], F_GETFL, 0);
+			if (flags < 0 || fcntl(poll_pipe[i], F_SETFL,
+					       flags | O_NONBLOCK) == -1) {
+				close(poll_pipe[0]);
+				close(poll_pipe[1]);
+				poll_pipe[0] = poll_pipe[1] = -1;
+				break;
+			}
+		}
+	}
+	pfd[0].fd = poll_pipe[0];
+	pfd[0].events = POLLIN;
 
-	CALLOC_ARRAY(pfd, socklist->nr);
-
-	for (size_t i = 0; i < socklist->nr; i++) {
-		pfd[i].fd = socklist->list[i];
+	for (size_t i = 1; i < nfds; i++) {
+		pfd[i].fd = socklist->list[i - 1];
 		pfd[i].events = POLLIN;
 	}
 
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
+		int nevents, scratch;
+
 		check_dead_children();
 
-		if (poll(pfd, socklist->nr, -1) < 0) {
+		if ((nevents = poll(pfd, nfds, -1)) <= 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
 				      strerror(errno));
@@ -1143,7 +1169,17 @@ static int service_loop(struct socketlist *socklist)
 			continue;
 		}
 
-		for (size_t i = 0; i < socklist->nr; i++) {
+		if ((pfd[0].revents & POLLIN) && pfd[0].fd != -1) {
+			if (nevents == 1 && read(pfd[0].fd, &scratch, 1) > 0)
+				continue;
+			else if (!read(pfd[0].fd, &scratch, 1)) {
+				close(pfd[0].fd);
+				pfd[0].fd = -1;
+			}
+			nevents--;
+		}
+
+		for (size_t i = 1; nevents && i < nfds; i++) {
 			if (pfd[i].revents & POLLIN) {
 				union {
 					struct sockaddr sa;
@@ -1165,6 +1201,7 @@ static int service_loop(struct socketlist *socklist)
 					}
 				}
 				handle(incoming, &ss.sa, sslen);
+				nevents--;
 			}
 		}
 	}
-- 
2.50.0.131.gcf6f63ea6b.dirty

