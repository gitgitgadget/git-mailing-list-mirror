Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB829AB13
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927998; cv=none; b=AVvaaRFHm8eL5zyEpDJTFjE7CqCx096hd7H1La69nSZmajK8WVpoZM2y/rLhuO3GYn104h3fb9c4AgCs7Yq8xZON5I8cQPVVnEo0OjBBOstz22okhugKnOuPkGAINPgwJ1Mf5L3leBcDJvCOam5DatKAx0h62WDDgtbSpt9uJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927998; c=relaxed/simple;
	bh=sJxoSxXhIdVYBfkROwpdPar0qiXOXMb0LFCdjApbJS0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ooY5GUPwDMUmt4ua7rNmMCB2jzedem1fRdH2fxPJKv+qvffNz+4HK52vf3XwRBcunH6o8sebUbBqwPo5aFVBreG4OJcSH0/WmCIFo+RsZQUJVy9ogNX1LRs3t0Vr4EBlXpZA3gKQ5x802iSdB8zMWbWKhKc+3Pi7BeAjjHcucLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyIfNTuC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyIfNTuC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453647147c6so7571035e9.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927995; x=1751532795; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1y25I7gTX26GcryuDgA1Y/Slr5M9uln0UfBCE/VEA8=;
        b=CyIfNTuCaFg8n4bq9hNHzsCk/cgHDe+Tj0w1eHACMXvuhnpapqbMYEqFV5okCyHiE9
         nduuSg3nUU8q3auGIP8Ji65FQ/sc5iHzMJdhYK4BbaUXZQ4SVpkACikNg7PJYqQ8i+i+
         OKjfuxtJEQxGGkUwoUyfki4opKR8y/QJPovdFZp1eDUA8DJkb0FNhiIzZBZXEJ9TVt8h
         /RGfM6uQGijPTgwJ0/DP858yCiRKvRZRP9wnvf2PvNmDxQm2VnSJXOM27JRZsauRfVc+
         sTiNw+HLwfOdTD90Ze28UCuD7ZSPS+jyzJbvPcPkkmRICs6k6ahbCuhK+sevt4/1edbr
         5hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927995; x=1751532795;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1y25I7gTX26GcryuDgA1Y/Slr5M9uln0UfBCE/VEA8=;
        b=j+FzNSS+qVy+UyFFnnRk+rziTFZrRfDQRaUop/EGcSfgQCLXzxOPoCpbqwzFa/ZtDK
         IfX2ihOFTnxet2oQKhox6NKIA8jIVFpiAshkxcNNzS+M0IAmqq7hFqyIulLe/cBEGGTN
         nsAzIsfAf628ZEtWz/aL95lL6neSosEIILmGqj4oqPHRTKu4BtpeiP2U2YHBXac5IV2J
         otRjWX1rry6rtt+H6DKz18jTDj+wCV3Uvg7gfrdA9LeJQfV/jdN34QvzCvIPvvVtrRYX
         ULNzNkhdXsZGsv5WVym+1+ecNPFPYrrr7KdCVGB1v74jUh4hwlemy8fyhLgLgdgYnZVO
         iSQA==
X-Gm-Message-State: AOJu0YyAFGkw6fzsgx5BvyBNkSlgJWlIzVLYA7ADPdZkQm1P70raREw5
	tw/aeb/P1PBHYXj0uUnrUH+wOmjXfDvstiGO7JAPU1WfmQVGLSIqo+dqB27wXw==
X-Gm-Gg: ASbGncs2/g3UvOOi7elFWxqp4jQQFC3Z8JBG0xwZrUZB14H/VeCbPh8cy086yndyGkM
	cuBK0tzzgJ8LUBbjRSwDMhvnhahdM6ayLM0LRvXO7Fe7J/dFpwePBhUGuCavs72Y/Cy7Md7vWnR
	ZontRAerGtOUG4S2KfPTahVqtLZOrG1iXypgpkdXlvGfKLKjgLoDz7NDI4hMO8Ya8WKZWRKb9FT
	OqgWZgxzPr72PAY+PWzic7Isi6P6dGfoc3Crdpk3AYR0irlODD+NkxEzyxVSb8DLQq+kxLL/DJ4
	fhvic649OdoRusaslWtbN1mqpGFNHAPhIPtYbs9MhjiZ6dRmjs7swtpFcMZj7gw=
X-Google-Smtp-Source: AGHT+IHxKBUNPVoFsKY7puvgsjaHEGrYUfHUSyqzTsiva1OOSCh4OJOoFZMDLCYuQ7szY2Zy/VCZRQ==
X-Received: by 2002:a05:600c:620a:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-45381b20df6mr47672615e9.27.1750927994860;
        Thu, 26 Jun 2025 01:53:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe0efsm12651385e9.24.2025.06.26.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:53:14 -0700 (PDT)
Message-Id: <851d663be0bda9ecb0e267ab0f85cc1f14cff10e.1750927989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Jun 2025 08:53:08 +0000
Subject: [PATCH v3 4/4] daemon: explicitly allow EINTR during poll()
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

If the setup for the SIGCHLD signal handler sets SA_RESTART, poll()
might not return with -1 and set errno to EINTR when a signal is
received.

Since the logic to reap zombie childs relies on those interruptions
make sure to explicitly disable SA_RESTART around this function.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/daemon.c b/daemon.c
index 155b2e180167..7e29c03e313f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1116,6 +1116,25 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	}
 }
 
+#ifndef NO_RESTARTABLE_SIGNALS
+
+static void set_sa_restart(struct sigaction *psa, int enable)
+{
+	if (enable)
+		psa->sa_flags |= SA_RESTART;
+	else
+		psa->sa_flags &= ~SA_RESTART;
+	sigaction(SIGCHLD, psa, NULL);
+}
+
+#else
+
+static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
+{
+}
+
+#endif
+
 static int service_loop(struct socketlist *socklist)
 {
 	struct sigaction sa;
@@ -1136,6 +1155,7 @@ static int service_loop(struct socketlist *socklist)
 	for (;;) {
 		check_dead_children();
 
+		set_sa_restart(&sa, 0);
 		if (poll(pfd, socklist->nr, -1) < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
@@ -1144,6 +1164,7 @@ static int service_loop(struct socketlist *socklist)
 			}
 			continue;
 		}
+		set_sa_restart(&sa, 1);
 
 		for (size_t i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
-- 
gitgitgadget
