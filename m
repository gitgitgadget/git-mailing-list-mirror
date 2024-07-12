Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849C4683
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746032; cv=none; b=c06LTxMIPU+pD7r1TCkTm3l17TmS72BD5koGvyrhW9SSmp353lYCDEf8iIKXWvA04fO+p4w9M8Kg0M4mH7eyfNUt6Yz2YRKBFC+h3oPyqqwIUcC9ncUL2hvvFgu460+LESLaUprLQ14SJJazFMY0ibI12wQlZ0nAj8LJs/Ihg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746032; c=relaxed/simple;
	bh=iqUiVv0Yqg5SWoVHc9Yv5Yl4jHtgJmjPVsqHRbIV+kE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PvyflevbsUzG5UquSvfyil7JuGzg8jFx4bhAJCkl9rqTLEOyCjHMpzH1gw7ui5k/FTemz0y9NVPsMv8R8wGT/Szf4jAEwj2c24Z9dsUTptIezFZfSwUEtUZng7a4j+BsUNVf0FeUs0BFbVodUSAHRwqm5uY+DQcwwmeLmcMfznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXZuz2nF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXZuz2nF"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-78512d44a17so1097578a12.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720746030; x=1721350830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BFxswcx/RrenzxZ4sRz8feABOlquJty3kOtp1I+k7Q=;
        b=FXZuz2nFL/4+SgMvOJT+oa7ESPqaWG4jnwrHMnqiyY5Dn+DvM3Qss+g+Dq30ki8LcR
         G15tumGBQ97Yo8X7XS05uRVUkqeF+j6o8jTZ7YKl9FBS/BLlHVYlGCHiH7eUgrbsKVX7
         uVkmvHP28vQZeocqlhfeEUzumpaMueEChSCS1gOmQdK+4QHyF8J+l9mx5xHPWaCynfrK
         uERSlauQw0KIEeCuf2CfU/BGM727iZ/vqm89O0O7QIeUfwUJcP5zSfraf2AXea55Sqsx
         earrA0OmOWdBFiOIGlnjT/mT+xdL9563HJuMqeqpIye23PgKmQG2PesNR4Ekfz+ALF3G
         UQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746030; x=1721350830;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BFxswcx/RrenzxZ4sRz8feABOlquJty3kOtp1I+k7Q=;
        b=BUiqrmse8lwL7EnhUHVHe4kL2beypT0ZJBdQs1K8IJYBFJzL/y4VDgayGbsX4KcdSk
         WGXZgF81H9Dhu9bij8lVvMnhhGGuRqp8YdC6Xyd4Bblbq3EVd/GCZ4souKSi+RW4v037
         GZ5iARDi76jHllEa8aZhcbCv5sM3pu76fJqA+EOk73miik99N5+R8/eI7S+BYn0x/kua
         Q3R7fkqMkIENR1j6hi63zKnycIDVh3NomHfDoQWew67x8nKo0oiAhlX5OU+1dOEBHVYB
         d9E3yYqlMBSJBETSn4N2Z2tvdAlx+HpYhpvH4mxqUbNB87FXKwPyzsg3NeITOlhqyghY
         Nmew==
X-Gm-Message-State: AOJu0Yw+tDNemRh/bpjWkUyuTvjYHGjGR7W8uYQ3N67k+5zwX/eE0qsP
	gIWNHkIDXqYMDfuHLHzzHi0hdJLS8OLLwjlwhDQ34yHpx/mr7eEnPoslag==
X-Google-Smtp-Source: AGHT+IEnMKq43RcLkyUCw0g4RLII2GoI/fNl0hUuo5H9F1oWzC1MGyYa0ob7I7Wrj2g7VrrHQflKMA==
X-Received: by 2002:a05:6a20:9f0a:b0:1c0:f2ee:7dc0 with SMTP id adf61e73a8af0-1c2984c9dc7mr10351105637.55.1720746029727;
        Thu, 11 Jul 2024 18:00:29 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad028dsm56318045ad.272.2024.07.11.18.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 18:00:29 -0700 (PDT)
Message-ID: <fd00e664-93bc-4dc0-b032-f6d9b56a5e44@gmail.com>
Date: Fri, 12 Jul 2024 10:00:26 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Language: en-US
In-Reply-To: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
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
2.45.1
