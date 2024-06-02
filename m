Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C942A9E
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342997; cv=none; b=hzScwh/9Aoe1McU/sRb1k9+p/H2YuGLSCYBiDkkJY/DRBnjGMafkrT1sPKoKtuAhfvxM6comdGp093a0eORGXx4wOjkzusYIjwfjrtyH8l/23JibNqbnsZDCIJHybkzHmWGRvhg3YBIk3OFa0sdJvBGXOK/egWRcrMvWoMruHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342997; c=relaxed/simple;
	bh=0tYWSD9R7BQez/k0e1abyPHU6KdOtWFM1PFtZm4OS8Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VOHPh4vVbbyQnVi/U3TOJsomsbrYBSOxYDKlvxqS4Yboua55uNbyMiRDd4w9KflfXGAJYr9v1T5ttQGDoorFxUqz05mR7nHMcf4nBmMc6UM3+cDuiWtPWByBZEBHYtK3zGDCwuN4zqNXSDy81xY6jfQ2OpRq4k2NtHuc+irFQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7tMqG2z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7tMqG2z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dc36b107fso2602961f8f.1
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342994; x=1717947794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hT2qPcKwiAeZCNLZ5PJuOrdUflulvofvVQeb0kISpxc=;
        b=M7tMqG2z6MLKGCiPfrzvnbI/9h+Yy3B9NsWeRQc4CAsmooAbWUzwHxeis+8yPLOO9/
         z/DMg7+mTHim8ongOrhrpxEGP6/wSZKEJQ2nvV8URnb0nCZ03ZDEYDGvNZBBo7kTisYg
         u67Qo3LZmoIsuitfGygIR36yjO+J0pFfb82DnA3AWv7T5RfkHRfUQeSwp7RQsl9BrHiQ
         odt1di4wSb460rCBduUl9/lHYYEyX2mWYyKg8qtVSajf8hGAxAIkJpoA12SAto5IZbfu
         PBNRWZkW5RG4okVT0NhuNOdrLANv7Nw/CquRpW78uiGQhob1n+9ueqCT51LtIjy8GPA1
         R7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342994; x=1717947794;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT2qPcKwiAeZCNLZ5PJuOrdUflulvofvVQeb0kISpxc=;
        b=I/t8BH5HdpxMPkD9/9csi369oTD1Aepqba7VDZIbWN/GpvlomYJs5YqiIx06Um1oSo
         p425E148Sngt5+XRlz6b2hnEYr5FZj50uEHyCfOp22zSiwNYD37Ydoq4+LnIW0dZUJaB
         +z/N0JcXi6hyjIQ9UJcpvgPi/EzO3kbx3olspfVYpzrUiwGqMKnx5nC1rZOWhLowUFY7
         L6ktSZbRkZ6CUdTSxI2/qDAuTKjqi+91xGV08XDzBKiKxqUY5ZyBgM4RFqWgvlxR065U
         ABTwq4Iut9yjz9JpYqiyu+C0XsANVflPlqkVD1YpbY/zyWCvBCUqVgN2f/SgCBQFDebg
         V5Fg==
X-Gm-Message-State: AOJu0YyxAslxBTA46iixJTfP6pa95qKnRgdViolyUM6tcrXe9y0rm4M4
	XQBKIcum3f1i0SzYsLj5iakJFHVc9OvV3YECwE/Y/LrrGrw0FPTtqLjV4w==
X-Google-Smtp-Source: AGHT+IHFf0j87YvcrVZkpTjfNpa5Rn/C7RMKz1FNnkk1X59RDCrK6nFn19LGLAdqD4KT3NC1CxhDeQ==
X-Received: by 2002:a05:6000:1754:b0:34d:7f9a:ecbd with SMTP id ffacd0b85a97d-35e0f25e11amr4313064f8f.1.1717342994339;
        Sun, 02 Jun 2024 08:43:14 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd06499d8sm6502398f8f.90.2024.06.02.08.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:43:13 -0700 (PDT)
Message-ID: <6176a476-6afc-4513-abfb-280b0dee5be7@gmail.com>
Date: Sun, 2 Jun 2024 17:43:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/6] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Language: en-US
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
2006-02-28) we have the machinery to send our output to a pager.

That machinery, once set up, does not allow us to regain the original
stdio streams.

In the interactive commands (i.e.: add -p) we want to use the pager for
some output, while maintaining the interaction with the user.

Modify the pager machinery so that we can use setup_pager and, once
we've finished sending the desired output for the pager, wait for the
pager termination using a new function wait_for_pager.   Make this
function reset the pager machinery before returning.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 36 ++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index b786601074..925f860335 100644
--- a/pager.c
+++ b/pager.c
@@ -14,7 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
-static int close_fd2;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -24,20 +24,41 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	if (close_fd2)
+	if (old_fd2 != -1)
 		close(2);
 }
 
 static void wait_for_pager_atexit(void)
 {
+	if (old_fd1 == -1)
+		return;
+
 	fflush(stdout);
 	fflush(stderr);
 	close_pager_fds();
 	finish_command(&pager_process);
 }
 
+void wait_for_pager(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	wait_for_pager_atexit();
+	unsetenv("GIT_PAGER_IN_USE");
+	dup2(old_fd1, 1);
+	old_fd1 = -1;
+	if (old_fd2 != -1) {
+		dup2(old_fd2, 2);
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
@@ -113,6 +134,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
@@ -142,16 +164,18 @@ void setup_pager(void)
 		return;
 
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
-	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager_atexit);
+	if (!once++) {
+		sigchain_push_common(wait_for_pager_signal);
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
2.45.0.97.g9fa538478d
