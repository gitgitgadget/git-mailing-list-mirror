Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBD28981F
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176751; cv=none; b=aTKytRVb2VECNCs8ZkllXa5UsYzWDaLxN/2wDawVR4Xi2BV58c4n31q0Yeo5y16rYEwp4Q2khV6X+hmkZNgA0cIGPcBpL882HF6We5jirAuNyruQqrBdbcdJCSTw/2idfpssNwCKeFuh3WrTgdlYbkr24H74HRNaTUxnD4WGuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176751; c=relaxed/simple;
	bh=MS1Bf1gmHepAFdVC1tKGVU9lLYRAaywZq6CwcmXUX3s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Q14l237w3kWtWMdBCx8ptmwUmOqcl1zpcEnLIPOQM3uIeswBjzgvgf5GPc4b8KECRRyvSG+s5oMNEX+jJHLYW1XhgoMhHkSepc6iUKJqnIINNjebPehLI8rdoUg1LJaKxDNm8oc95jmiwiRmFK2m1qCTvn9Fxetg/xFI+HLaFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD4a+KMl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD4a+KMl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45363645a8eso10591265e9.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752176747; x=1752781547; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GmGn0D6YnTKvQMYOoqTp8KdUxZJylivRwopL9LRAz0=;
        b=dD4a+KMlpAlSxMiMUhtODMQvxFHlqPFnE9+XxZKfu942UOy0itLfqwCMLEpi8Rxn6s
         UnmxiRpj+3hVFAD6hPqu86p+AeSjPqIOpO1iPcQBRQDBCXLH9WlM/zdm654/mnyo+46C
         evLDvHWiLW1vVovHMH/o4YXAXNmEBBwSFYSujlRNncBBHdK49kjJWDrtDmqr4l0lr8pu
         nGEV1d8RBk8c+SFa7HW9z/ScxBifsmk7a3EKKns9qrxw57lASdt3EthDvPxKwyeGmYYF
         SpQY+aivGTQ7rZaLv3nbGNSPpvoUfUxYHO5Y+qaNobN9ow6DgZU5CpostZ2DoSb6kIO1
         4L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752176747; x=1752781547;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GmGn0D6YnTKvQMYOoqTp8KdUxZJylivRwopL9LRAz0=;
        b=pmo7V0Lncx0E7ce65FyTgNVtirooUzMU3gVzJFNeJ5T/orVZ4uwkQgvl36Alemjg6T
         3W7vNOuPsVxSaVdm71WOPGA4bRbSlr/1g1JE66zC4ZjqHo7NlYcPbZBkjjpmD1Ti/kLA
         lsvTSY7sImphHwxotu96Tl5yUOESyKaTtH+xaMrs8x23NTjHvo2Lbl3txewBTAF6YuW5
         aX77FQoor0pjUPY/jmwCtRYG1UNXFSreLd5y6L7SGsgU8NzZo2Y3MC0WR70uutkcPTTd
         8gMM8n7s+7jnD8qqsS3OCWfDQ7yPq6xPtUJt43tcTguVmcIQ3zDsUDtO7d3xY6JUp4LZ
         GgqA==
X-Gm-Message-State: AOJu0YzFZ/TyrZfn/qoDp6ycS2vF37CIIjJbBw2pZoFjDlCK9Dq+IfPk
	TwDT6Z/YJnwHTY7GVav/NavuJJae/yoJgEZANu4Fwu46l0bwx7etts0pud1uSw==
X-Gm-Gg: ASbGncvmLzWGxJOVJusYfuGUmOhBddNUvnviAI7d/j9ym7E8ldrtQUnAyobViYxu07b
	hmiTuv6DfbGH7IH4ccQggsyoyccxmN+kLgtx7qNmOh/SWihOHpehEYvS77SrjC0SPPGYvKpwUB/
	+z2jrzVPcjnINYgs1EZw/jx549PgFmMgg3wmcXQ1zfOXfSZ9lEN7fc4Zs2q3rRkI+YeqP/e4G2R
	+nQVr/XbGqswrh4tXG6GP35knkEXxbcYdOvJQJu0SicQ1sB7los9dNWsQ7qdyzsf9FWJtPSW+oL
	0S+KEIeV/BvQ1m0sRlk0365Yt/YpBUZUi3zsUiouCHktIUZwRgTPU+i4i+x3zSc=
X-Google-Smtp-Source: AGHT+IEpjZiqWpa/QAwXNE6ONkcPArJeQAXJOBYVc1m9VnOqsOu40AwsAXAYB0KN3g9zgG5ipKqkuw==
X-Received: by 2002:a05:600c:3e0e:b0:453:9bf:6f79 with SMTP id 5b1f17b1804b1-454f4264b38mr750535e9.26.1752176746920;
        Thu, 10 Jul 2025 12:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd466154sm27474135e9.12.2025.07.10.12.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 12:45:46 -0700 (PDT)
Message-Id: <81c41b43e60ca504be4c5267b335f4585f28941d.1752176743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Jul 2025 19:45:43 +0000
Subject: [PATCH v4 2/2] daemon: use sigaction() to install child_handler()
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

Replace signal() with an equivalent invocation of sigaction(), but
make sure to NOT set SA_RESTART so the original code that expects
to be interrupted when children complete still works as designed.

This change has the added benefit of using BSD signal semantics reliably
and therefore not needing the rearming call in the signal handler.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd5789..28fc19479038 100644
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
+	sa.sa_flags = SA_NOCLDSTOP;
+	sa.sa_handler = child_handler;
+	sigaction(SIGCHLD, &sa, NULL);
 
 	for (;;) {
 		check_dead_children();
-- 
gitgitgadget
