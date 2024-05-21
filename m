Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719A763F1
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324732; cv=none; b=j0VtSdzbdHmmYAN8YQInR+ZWvfNxzrTbTz22EmGWAxq1iVejj+lkGy4SF6h08V9sHi+rT9KJwC/a6CbnGvSBJwqZjos2KHaBI/k6jV4RfZWX8BiIBzqpxpE6E/CbKQl+XqZv+TP3Gu2BpsdrRICZBwhVuMnQaGXqGluj/jCQZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324732; c=relaxed/simple;
	bh=BNJ5T1JZd4+3KdiVVs+HIbFcw+mS1zdQIi4pe6WfMUY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gRh+IrlyTTKhtSL+AcvOWJkQRxb/QPtsUE3f+Rnw+1KKXwQpCrxifIYRtpL5CTdAULJG/cW1S+8kP4HNxH/f4ch2PIm35CUSBoROEizRk+j+QdO8Hz9hTd5H/TuMb0nWsSa3SNFgd5AHZ9u5HyE8oeRlhyijbd0/MDlnCcOSfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up8SrkXk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up8SrkXk"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d7a32bdd3so95327f8f.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324729; x=1716929529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln8cyu6a9BQrRItELhEb+T5yR/EqMX5oV9d9Tsbom+4=;
        b=Up8SrkXkegLb9Dq2wzvLNRBOJymlAw4169Lzvph28jjK0JIpML+vLCIbyYIiPvplW3
         9gyvnkpyYgt/dydOij6iRapOtnmd5xoVYwBHkNxI3vsqYCcsFvhwQ+Myhh9Pi5vQeSlN
         YW/7HKkKICCaueuTm0bMwbnX2AiVxttxuy8LejV1RuNTu3ul4iv+1FZZdNEeQUQcR/8u
         k1yh9zpmQDuliK94HN0mZbLPDg3ICeZm9Ysl5+Mo+CQ5L+AG2mCm9YIDTsyY8HM/81Q1
         ofkYY/VJqjTByTaEm+awM5EGRtOYjvrx0jBS4ftDQD2pyAUEO82zLhD2FHySnS3a7M+E
         u+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324729; x=1716929529;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln8cyu6a9BQrRItELhEb+T5yR/EqMX5oV9d9Tsbom+4=;
        b=KMIcs9o+e7HsDoEMbljlAxUpd0n69lm0InJNJtkAnOyeVvMykSQOy16MPkQp2E+qHM
         IfhVfwrdlFB9RDCqZIjiNAJTzPXCoARNUlkt5UfK9EARAiGQ2HJQAS6LukEV6X3AFxoO
         GdOh4qjKq/zH8Dmh59//B/hbOETz2np/9nbnFdfZew5X6udyhGSPPC8yZqb7mVxqgJu3
         QA6iDXXz7Y3/ht8nV7V86y799Z3xENNYp8t15zXrsI9QRHP5rkNDIKpW6/lHJ9s8z4Wl
         av9KYgMVmUoq7PScKuJIMRw2ekAKJy0ShD0GFxn56jRTxO8gPGsugm1d2LmrgOz9lzK4
         KvzQ==
X-Gm-Message-State: AOJu0YzsftOtyXGjG3vj0U1MU/chn6mASYaPk+7pBPYRXsJi/B5+7xeM
	86cUHuuJ2IyYe22NQeKTkZRdGikahxk+Wnq/Xc1/IIagA41FrNhwhiCIdA==
X-Google-Smtp-Source: AGHT+IE9uKPee5aFXnBdMMXwy/KsXWR6XxWbf7VmtYiVc/7XwV8kaN8m1gAK7LVz4Kv3b50iV1H/Lw==
X-Received: by 2002:a5d:4bc1:0:b0:354:4eb4:576 with SMTP id ffacd0b85a97d-354d8db4269mr30698f8f.70.1716324729000;
        Tue, 21 May 2024 13:52:09 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351da4ad444sm15155276f8f.107.2024.05.21.13.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:52:08 -0700 (PDT)
Message-ID: <0a6c38fe-8feb-47c3-804c-44d8535a278d@gmail.com>
Date: Tue, 21 May 2024 22:52:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/5] pager: do not close fd 2 unnecessarily
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
In-Reply-To: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
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
that might call close_pager_fds multiple times.  With this in mind,
unconditionally closing stderr will become undesirable.

Let's close(STDERR_FILENO) only when necessary, and pave the way for the
comming changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index b8822a9381..3ef6798f7e 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
+static int old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -23,7 +24,8 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	close(2);
+	if (old_fd2 != -1)
+		close(2);
 }
 
 static void wait_for_pager_atexit(void)
@@ -141,8 +143,10 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		old_fd2 = 1;
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
2.45.1.221.gd3c11dbb1d
