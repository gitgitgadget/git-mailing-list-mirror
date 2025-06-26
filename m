Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4754296170
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927997; cv=none; b=ce6jTwhHwwO3il0yMD586TfBhG8EKrA21zI8WTE+ZD5ulOrosXVaLRWnYj8BfveX78ehHzMRRO5wAlAnv0++j77tAlZCf047gXt8pR/QvZZojHCl5cUExVElKzvUE7H1veXkpP1BIfPFdveuvOyfIzoTGP2uuAT2Jz+WmrB6HYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927997; c=relaxed/simple;
	bh=jKg/Hk6ZfBWpkr6RuP4PngUeryYsfq8wME34DTQP3Gc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=L9Rkp1PmIFQyK9VUhH98mITYyBUlWsKAxSIqcJweHMSnF10faO9k7uw3kegSiFXPi98C4kB/4UGAV1BOyL5NvQnvxQQqU2c+N32xhUW1DSc8BUZgCtx2EaV7u2qM57uCsscSXaqpAp5HeyE7kQEQ9b2RYBV18P6SSdMrAbMc6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJY0pXGu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJY0pXGu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45363645a8eso4436275e9.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927994; x=1751532794; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGCKwxbjVF6xYDQwkPRM1p/JTPBzRXNWwezDIjxMu7g=;
        b=ZJY0pXGun/XkEtJoH7uUk6Wmr6juOLygKtgBW8wbRMkt0DG+3Kg32XVFQIQwBq916m
         +QYExVyuX+7I0TERh8+x5y4HRmdpm2VAj51TsGgqMRtUX6ikY3ubIZIVgxF4wdpy4Al8
         iLaKUeQWpICmOvtgfMXrPuEE18WOlHYAfe7gY38n/IljoZPRimQZhumhuHkx7y+aYhll
         c+Iwxio1gAHa4AVNjSc+yHePk110HN+hWkf9ULVVlhoxW8FlPAxO+i5QYIfUaddXGa50
         fobW6eZsovyM1CkzpuMDxTyHFqGAY2YCBGej888KOUJTPIaTu2T1iPTzYliMGsAocuCJ
         6bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927994; x=1751532794;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGCKwxbjVF6xYDQwkPRM1p/JTPBzRXNWwezDIjxMu7g=;
        b=tjDOkVs4eKXAwg0WCRETqAQWATlltXvDakA9UdyYnJ8LKdDz8qFru1t1/HQbeA2x7J
         ZzcOXBFXPMsPh08SAuTYGhJz1/C9Jc9NBMEU2zfb0xvfXJSqLKP4qFY4oYjM8XwfHMDP
         L+I6LZh2unqQ4YFiVRerCihuyNvkqf6L4zrIXzU9vW8jECZS6DrYDHZ3Z57lKgOvB8Fn
         4TnJHN75ZOYhXYPey+3JxyJsEUwWIt6FCkwwhO68k7aEcZ+pZy42uWOP+jXlwi7XxNmb
         RaS4NiTG6e6G1SFzolrr1hJVVPlZqXsYEGHQdtEInruLCtN58yoiz10aFyLiOQzCYq9G
         ORGA==
X-Gm-Message-State: AOJu0Yyc0bsF1O6rzm8uIP3MQHYclfbQ3xd5uiH8TIdzn6wFxaQTrVhj
	MWAkqYIMuqE7w+isgXA8UfEOVIMr3Tr0xrnpwaNkoSoLLuhg3JcchzEniZXsBw==
X-Gm-Gg: ASbGncuq1mLDpULATkNf0VxeCAv+5ycjvDJ+4tsGaAuLN0lDnhahVVQktbsFwUE/qf+
	50FID+yW7RreUcsv/src28adOS34cTcFJou8tYHJUVC2JKYtqwMNGK49RO0z/iGo4MFFxT/EiUb
	eL+dsVE4FP2+rt4z73+ka/JzPPPjO2cCjQl8mQiEAp27RNk8voX3u6PmVjVC8d1ksE04rOlwUpQ
	PIurIwnWxscmmPHiuXYqrLptwaG3R9KezuHIp/vpOjVYPYrn+hwOIYT83c4hhVFlUvBFFZwtNPG
	u0Orx7n3R/2i9qPG+Obt0Ic45wXy2SJMGNsqq15f6UsaAyEM3mm0mprwz+R7pLI=
X-Google-Smtp-Source: AGHT+IF2fUwGBNt/NwDbmskaEa3CKKJvWq4dV49zmfbjxA9gV3/03rYT4SjgKuC55wPII0Abw/Pebw==
X-Received: by 2002:a05:600c:3545:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-45381b0af07mr56076775e9.33.1750927993784;
        Thu, 26 Jun 2025 01:53:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a72dasm12790695e9.16.2025.06.26.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:53:13 -0700 (PDT)
Message-Id: <c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Jun 2025 08:53:07 +0000
Subject: [PATCH v3 3/4] daemon: use sigaction() to install child_handler()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

In a future change, the flags used for processing SIGCHLD will need to
be updated, which is only possible by using sigaction().

Replace signal() with an equivalent invocation of sigaction(), which
has the added benefit of using BSD semantics reliably and therefore
not needing the rearming call in the signal handler.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd5789..155b2e180167 100644
--- a/daemon.c
+++ b/daemon.c
@@ -915,11 +915,9 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 static void child_handler(int signo UNUSED)
 {
 	/*
-	 * Otherwise empty handler because systemcalls will get interrupted
-	 * upon signal receipt
-	 * SysV needs the handler to be rearmed
+	 * Otherwise empty handler because systemcalls should get interrupted
+	 * upon signal receipt.
 	 */
-	signal(SIGCHLD, child_handler);
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1120,6 +1118,7 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 
 static int service_loop(struct socketlist *socklist)
 {
+	struct sigaction sa;
 	struct pollfd *pfd;
 
 	CALLOC_ARRAY(pfd, socklist->nr);
@@ -1129,7 +1128,10 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	signal(SIGCHLD, child_handler);
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
+	sa.sa_handler = child_handler;
+	sigaction(SIGCHLD, &sa, NULL);
 
 	for (;;) {
 		check_dead_children();
-- 
gitgitgadget

