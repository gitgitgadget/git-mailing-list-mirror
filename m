Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50F13959D
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888162; cv=none; b=Y1oY4ur1GZpoWAWYiXUBjADCPMCMsA21Nqp1jcG0h7w4OKquwB3Lxh55lkT1KACVrmM2Y1As7UgzQUHcVO0AlWikRSe2Jj93xeGhSPvYbtVF4+u8S+qLXqBZchZUbBheipC5GSWMaqY5rt5XrAymCtpe3W6cv4qvc8dUZi6AiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888162; c=relaxed/simple;
	bh=hP5AVS+rEogwKOgBQ8zbffM4EfqB6jKArtNqC+qQwCI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJqgBAkLRRGCqSshZmFIg8RAojtHhNLaL8/8l2G5L+TGhrCl4Aa/W6GKXZxKmV2WJE76iME/I/pkI2V/fNuvE9v1U2/D5K8CPaF+Ui+6dKrDgTKsMmxPn64f/YvrTl+EQBOzQmSZQ+ysIWlqsl4rOX9av6WAv7ckvP1B+RpovRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUSEICec; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUSEICec"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b9794dad09so1481398eaf.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720888160; x=1721492960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LLJiIilMBNIySC07erlxqGooGvO6aEpdC+rZF+zGv/k=;
        b=YUSEICecC/0+Dg5t0TcavBxK9d+KcNgBj5afQgYfh4Gk8WtZ5nZcQ31yQANoF1r91X
         6jQQJDLsquWvT9vgJOZOubmLtk0GtFgDROlaNZA4n2QibmYu932L/gpt8qXRsn5VaouD
         cS8VjyetzHH2xAHVPmuOCvmVGOf47bw/X7pKt4rH/ySh7vU1VclJhqRwcVePycLoo8t9
         wxJQtOW9PI0UGP1X8Z3dEyqjcqh+J+uDmaY2Q36APSiZ4TF6eAi+pbRHD2igb0L4jCi3
         dZtsFqxtOJm02TNDGR6/ZuTenW5MdotaNSnHMb1kgE0zyjyuXSTgkHY43LYrKYuYtKas
         h1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720888160; x=1721492960;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLJiIilMBNIySC07erlxqGooGvO6aEpdC+rZF+zGv/k=;
        b=B5eg70v2urldI4iLLT0kitMaTmgK1wMR/C+RUjN2LL11yher1q+LY9s+fF2agKVphE
         rQvMo2X3IX8A2JFOgS95ZxC7qwhOC5obdlak46roslfgPGBC2qt1Yz9eC8i8QLwNqdv2
         fs0G/RlN0e3Ef13X94e0NATwtB5vyhNZ7B2IaaM7zS0RrIHODE/ua3Cy3qtAo3MJ+kZn
         4QCRtdDQMEFW/w8UvA2Zt/lQ0oJL1+a9bWgopM+cllG/4cQXWcmu560kV33HVn1QnvLZ
         GKEStexaMFcRC4P/yYAtuyF0FkrCc0pnPEQm90Jdgl+uSYhCu0mMh7LkdfxtBki1Ywzr
         6Kog==
X-Gm-Message-State: AOJu0YxHEPi4a6P4yDtMGYhvHi/favAtg0mBt05T5sS6t2unVn4Oc9Gx
	O+qn/1VeoOzHK67IF/rHNFlSaHFbhgDKaOszAsl40xvUmhDEG+SJj6K+gA==
X-Google-Smtp-Source: AGHT+IGEphNm9Lb8goOs4RA+MohrF/2qe8dQvbciNW8kNT/7wGXekwkHm8cpFxCml6kbgMtJHIDU+w==
X-Received: by 2002:a05:6359:4c9b:b0:1aa:d4a3:3d58 with SMTP id e5c5f4694b2df-1aade33d6ecmr1549294555d.29.1720888159958;
        Sat, 13 Jul 2024 09:29:19 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd7046cbsm3393034a91.55.2024.07.13.09.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 09:29:19 -0700 (PDT)
Message-ID: <fe7c9555-4147-4649-97de-53ef90b552cb@gmail.com>
Date: Sun, 14 Jul 2024 01:29:16 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/4] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Language: en-US
In-Reply-To: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We send errors to the pager since 61b80509e3 (sending errors to stdout
under $PAGER, 2008-02-16).

In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
2008-12-15) an exception was introduced to avoid redirecting stderr if
it is not connected to a terminal.

In such exceptional cases, the close(STDERR_FILENO) we're doing in
close_pager_fds, is unnecessary.

Furthermore, in a subsequent commit we're going to introduce changes
that will involve using close_pager_fds multiple times.

With this in mind, controlling when we want to close stderr, become
sensible.

Let's close(STDERR_FILENO) only when necessary, and pave the way for the
upcoming changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index be6f4ee59f..251adfc2ad 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static char *pager_program;
+static int close_fd2;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -23,7 +24,8 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	close(2);
+	if (close_fd2)
+		close(2);
 }
 
 static void wait_for_pager_atexit(void)
@@ -141,8 +143,10 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		close_fd2 = 1;
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
2.45.2.831.g9e4974e3d4
