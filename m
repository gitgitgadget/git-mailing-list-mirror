Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFCD26AD3
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973056; cv=none; b=C0KamHZ1N2Jkdi9RE6O5REKyjBx9rSn42of5+vxZrNFBYfTab/PBnVUSa1spi9eUrKgrDNy+VP1qlEw2BhK055QesYkzWrOHG4hNSlhisogQDu2cZ1arS7UKH8gH1yG9vtLOlkw0iaY0D7hQSPolN5nK5YIazuP4vgZPRBKFj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973056; c=relaxed/simple;
	bh=6xtggBBSXK9R+ENqNDt8rUGoXK92l0OXAbX+5gqW7LA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qQQTnKVGUGNF6ik94smmB/j8GWowiK0a2Xb4kXzkVbQ00ep9Y1/6T8exHfWdpGGZNqaLcAEfxaM4/lJUSdr9ahUZpA17B+wiujwreIQqocfFwrNRuvG7Dy4FewToSlNX8MQ5dN7JLgespIcfAxEcbU2dX3TXOEKy/Fbi0TV7ZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUkuD1ct; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUkuD1ct"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e0d750b73so1523754fac.3
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973054; x=1721577854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2X0OsrWMt8oCzEZ81wBbKSQUtdDGQZc9IH51FDSFSOQ=;
        b=JUkuD1ctn7+zPo2SkfzcyvG43WYEegjXtgD2hyjZTYbCfsqbqp0+zfe+FtQXqstRNe
         KoIpmcThaAHoDtn2rgn4XXNtnvnpfhgWMmZuiqXqqcHPgM+xywT0ZHim7N8Ureryk0wM
         PNyT7OK3EiTdyf55ILUY8b3NvxxDEQwEOdtTy/nMnqCZzDoBMT5h+VG7Izz54Mzsvshl
         TiBRAMSolao+S3XrXfEvP+HJg1tKwXfl2sT5rmyRbUQVEV5XwSIY2g54/BZk4a4vrqCJ
         oArmNsq6kk0r5fmWEC00XyfYWUbYSpwqWZqOSO3bckinQgAl9o3Op9tljorkRQdTCp73
         wRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973054; x=1721577854;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2X0OsrWMt8oCzEZ81wBbKSQUtdDGQZc9IH51FDSFSOQ=;
        b=PM70aVhtAF56c1iDi8UkicPziLnc8XqkYkLURU0TuPOibNGoiBtpeJIN9l5clSAwLe
         aA7PpTpIr63mHq858OixWkxjSQSzpeThFgfX49YcCcXGhQez9WmPyQZ+1lHLCJFQeeuS
         nh5NgqnatCLbZD6rTYGvWSYOcZOZfFH2lThW2yjjg3XbM+AZfyVV1vyM5ZIu+KcCq/7j
         rguIVet7qcPat0kTlCNDbTgaLtk1noLVqqNtmmt7RCGmEumI2VDONexG50zDG05KyVdX
         GJG20lj0B5plS913LZGd0XNCwmuy8g2JfAj+mF65ccD4PXtF5enjGg2yI+sRJ6sSn2MX
         fL2Q==
X-Gm-Message-State: AOJu0Ywo06cNXvppYB122JW84SFTOyHBDuqGa8pMPfBjeRG37/VcWRBh
	R/g1nnhpyy91Rg4csccd0qWs6xaK9KbY0GaW2GAGkW5/GpOQlsOvDdGXLg==
X-Google-Smtp-Source: AGHT+IEUGDA2u34FgTV/cZmY79joATuNmCfos36U/RAs8EQaElm1mY4Fhay1CQyL/Uoy+yHZELELeA==
X-Received: by 2002:a05:6871:2887:b0:25c:b3c9:ecda with SMTP id 586e51a60fabf-25eaebdb520mr13929340fac.38.1720973053987;
        Sun, 14 Jul 2024 09:04:13 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79262e95edbsm266449a12.21.2024.07.14.09.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 09:04:13 -0700 (PDT)
Message-ID: <6649904d-d537-475c-b905-6ec227eb4eb4@gmail.com>
Date: Mon, 15 Jul 2024 01:04:10 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/4] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Language: en-US
In-Reply-To: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
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
2.46.0.rc0.4.g913e7f3d09
