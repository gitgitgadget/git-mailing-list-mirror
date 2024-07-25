Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66712199386
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915084; cv=none; b=FwMyBwR4rGs0J5UclYoXSJNVwNZ8sWXrBrEv/k1i7yQaGfL/aoKDmf7xLyWaVeTXl7+HzJfwGd0fUrVJzn6IBeDHVnt52PABDMyF81XS/QrHAO3C6f3cIgifPqW+Gp6f9JnAuZEfsNdPF5/ZOWxzER5XDv6P8kA3QzFpvPgbIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915084; c=relaxed/simple;
	bh=Omf/eaV5LL5iuQcAXAPsgxBSSP9sAiaZ8oHmHevmAL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A8hISVztMS/CegyqrfBWbEy7b8GqPp0Lwg3Vbcs8MOnSFeCGBykkBec87w3XtvOGmZv+/Cgj5098kWUq0YSDSdXTajqODp2euxUFJlZTqyqQRttbocCxCIFfzrwulcOD0uVZSR0+BEy5ww61NqJB7fd9fYHsGpX58JUHE1njI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdcYxAJO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdcYxAJO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so7153705e9.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915081; x=1722519881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2OT0opVs5PMG17etEgNDPC4DiGev5Ba7/9NVk+bnF54=;
        b=QdcYxAJOCvWukwC1ZhwNkw0EoRRnkbGaA1MYkU4vmolx6XrlfrQNuF9g56PEkefaYT
         fXQmITkOYJVyqvafbNID6qEJIrlxSMIUQ0ZLzotMacJqptaZpIu4z7+wTi8DtCoYa+jG
         oCd3QHXmwMmDBSVkZ+dWYL7UaOff25bZ31yGqAB2p6mjgRCDZ2jFc76HJNi0fFiI7LXY
         93oF47NTN7VMI05ooaBxB+Hnjmsqqttqd9Jk73Y4BwYWeNqCBw9dWAcD0/RVc50rMY5w
         ZbtfP5O1vUidcS3IutLPXv6xmoi4iruFyENIMFNS4pCMsFtJobEikRGJSXuZg3HpIUdr
         TIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915081; x=1722519881;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OT0opVs5PMG17etEgNDPC4DiGev5Ba7/9NVk+bnF54=;
        b=BM4Cq+A+3dkhLqYE3zTAdMOSJ6d8XWAmiOBGCn414MoXCX08IPiQtUjlLSXUWkwN2G
         QjQimTiuwoPJJ2vzUO0sxMbco2ESAx3RAaChjRku10Nt/z1g/fOQIQ1E7EgAYphE2Nfi
         Qagwyx0N/7jXgmbeB3v1TYrntRHRGQ3y8Q1Y7Wsv68dJ1qPTpdEl7xkhlibHOIrFO72l
         8qmnKnk48wN2d88oIQ5qd4k6aoG4wjIYmJnWR8bYzO40i/kSLST8f/OaBV9EA1tQlf1l
         EME0sf7JbMwgNJek39FF8xl1VW8znQ6zrD7lFYFtLtCPJBuw2kG/fsWPOsxLyMz1B8l9
         v6bQ==
X-Gm-Message-State: AOJu0Yy0mvv5PH8L2KdS9baAzJbjGV5A90yqad5YAEe6OAytUxHRpKLg
	6FM+rjdt3AVP3igGld9qT/naqVnWBQQTxPf/3pHHmGmIqlFUe2hemnsIOg==
X-Google-Smtp-Source: AGHT+IFlb9dN2Y9c9J+snS4g9S6uNjAVd/kYtVLuKC4AxVufQEa63WwVwpLYuzWrsnnfIVNiDwouyQ==
X-Received: by 2002:adf:e810:0:b0:367:434f:caa2 with SMTP id ffacd0b85a97d-36b35ff1e21mr1373824f8f.0.1721915080731;
        Thu, 25 Jul 2024 06:44:40 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm2251332f8f.85.2024.07.25.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:44:40 -0700 (PDT)
Message-ID: <934b8247-a5e7-4919-8ccb-08ceb23c03ff@gmail.com>
Date: Thu, 25 Jul 2024 15:44:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
 <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
 <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Language: en-US
In-Reply-To: <76936fb1-446d-455f-b4e7-6e24dda3c17d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
2006-02-28) we have the machinery to send our output to a pager.

That machinery, once set up, does not allow us to regain the original
stdio streams.

In the interactive commands (i.e.: add -p) we want to use the pager for
some output, while maintaining the interaction with the user.

Modify the pager machinery so that we can use `setup_pager()` and, once
we've finished sending the desired output for the pager, wait for the
pager termination using a new function `wait_for_pager()`.  Make this
function reset the pager machinery before returning.

One specific point to note is that we avoid forking the pager in
`setup_pager()` if the configured pager is an empty string [*1*] or
simply "cat" [*2*].  In these cases, `setup_pager()` does nothing and
therefore `wait_for_pager()` should not be called.

We could modify `setup_pager()` to return an indication of these
situations, so we could avoid calling `wait_for_pager()`.

However, let's avoid transferring that responsibility to the caller and
instead treat the call to `wait_for_pager()` as a no-op when we know we
haven't forked the pager.

   1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
                   2006-04-16)

   2.- caef71a535 (Do not fork PAGER=cat, 2006-04-16)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 251adfc2ad..896f40fcd2 100644
--- a/pager.c
+++ b/pager.c
@@ -14,7 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static char *pager_program;
-static int close_fd2;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -24,11 +24,11 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	if (close_fd2)
+	if (old_fd2 != -1)
 		close(2);
 }
 
-static void wait_for_pager_atexit(void)
+static void finish_pager(void)
 {
 	fflush(stdout);
 	fflush(stderr);
@@ -36,8 +36,37 @@ static void wait_for_pager_atexit(void)
 	finish_command(&pager_process);
 }
 
+static void wait_for_pager_atexit(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	finish_pager();
+}
+
+void wait_for_pager(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	finish_pager();
+	sigchain_pop_common();
+	unsetenv("GIT_PAGER_IN_USE");
+	dup2(old_fd1, 1);
+	close(old_fd1);
+	old_fd1 = -1;
+	if (old_fd2 != -1) {
+		dup2(old_fd2, 2);
+		close(old_fd2);
+		old_fd2 = -1;
+	}
+}
+
 static void wait_for_pager_signal(int signo)
 {
+	if (old_fd1 == -1)
+		return;
+
 	close_pager_fds();
 	finish_command_in_signal(&pager_process);
 	sigchain_pop(signo);
@@ -113,6 +142,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
@@ -142,16 +172,20 @@ void setup_pager(void)
 		die("unable to execute pager '%s'", pager);
 
 	/* original process continues, but writes to the pipe */
+	old_fd1 = dup(1);
 	dup2(pager_process.in, 1);
 	if (isatty(2)) {
-		close_fd2 = 1;
+		old_fd2 = dup(2);
 		dup2(pager_process.in, 2);
 	}
 	close(pager_process.in);
 
-	/* this makes sure that the parent terminates after the pager */
 	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager_atexit);
+
+	if (!once) {
+		once++;
+		atexit(wait_for_pager_atexit);
+	}
 }
 
 int pager_in_use(void)
diff --git a/pager.h b/pager.h
index b77433026d..103ecac476 100644
--- a/pager.h
+++ b/pager.h
@@ -5,6 +5,7 @@ struct child_process;
 
 const char *git_pager(int stdout_is_tty);
 void setup_pager(void);
+void wait_for_pager(void);
 int pager_in_use(void);
 int term_columns(void);
 void term_clear_line(void);
-- 
2.46.0.rc0.4.g6f4990c0d4
