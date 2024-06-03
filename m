Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1F13B58D
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447097; cv=none; b=GaKyVnX9EtStoGa+B3h2/mCdy8DqPED1k5Nsnk2u2ozzywt8PoxTbEYSVBASMePnuzLTAPTufExvv1I3P9DVSgLOnLsQWNq12kadccFhbSAcJXjHA+30zGgcYI8bNhRGpL+6grbgOBOQPT0yhC81xG7ybOP7FBL+G5TZGqug6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447097; c=relaxed/simple;
	bh=l1hFnB7hjMo+R9NFQ1wAFHjh/EWSDSrKSZjZES1OWWo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YiPS6qaReRUwisTqnz9hd9j0stmwpfJeHyzIA7bWWxLWE/S3/xYo0dUWafuD380Tgi7Y6sDxtrEhP0EekNw+pkRgodZpZpl4FYOVIx+ag0DKoTLc9BVYzlZLvd7H7oZbUvjwVr6Y+9rC08fFd6owSWFJo4sDTAF2+f1VEJ9YJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep8CtGCO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep8CtGCO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42120e3911eso43833925e9.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717447094; x=1718051894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnwEsJIRw29CX5M5TLsclc2ankgX6+NZGX3GYp/OdlA=;
        b=Ep8CtGCOKvYL7S94L255xgscqW5YmB1d7/4BEGqQ5yC4OsVXT60iJ1qFm6fn1FH98N
         krppEQCs81D8cJ6aWRzjwtOn2caRSqdwuiJDlE3dJh8yQRhaoEAcMk20LiZV0rttOteR
         XWLudcomzvIFT6TzKGj6YaHPfPXYqAUhFB1QOKMfkDpCbf8n9gO7wU4P6srmnRZ1UkXC
         uHkaFgcRjdyCHCM7h8CcVY6PGYUDRVfdSW5Jx+SVzn211+cMbIAHZmSYTBBp9HAA8uG+
         jeCAmG40ep2+VNqHHgL9SpiEz3sg8fjkQreHM4J03HbsPU0RiT24x5U0Jq240SGfn3cZ
         MbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447094; x=1718051894;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnwEsJIRw29CX5M5TLsclc2ankgX6+NZGX3GYp/OdlA=;
        b=V96+HBzhWaXFVdI/0y7JJmSGH/wSTkXt5VpgcfcW7wiia0rPPSgFhL/vEEwEL9cYwv
         0bb956l173dnDZYIBqRbcFdyK1a0ksv/FVlvjyP5p18RBNuX+ZARRopUPNsZC5OgrKpK
         FD1RStwi4hAcHx6Y2FYHwRZil/yWWMB5tYpGNrrGpwaUgfvEAsI+kD1q2ANxL7kz48km
         7cgYewT1BpHdg+v+EFdmIPdmRHL1B1Qpq6u5HahzbdaXQITOa2hxn5TC6Ysp1IO1XsBX
         9hEO8YGfPoBH0sGqHJSyWcu+HNeAUpkPsKggjkLVCwBF/tPK9845QAgmYzmy9uCh+vTT
         v5hg==
X-Gm-Message-State: AOJu0YyMfJVvZup00I988mo39+TP7emE6ioypaUHJ1rLe38i8BHBUQ88
	PVfR4B8ERrwr2BcivYOF9KcENLyoPGLSaIViesGxkSecxaV/PeGSfVliRw==
X-Google-Smtp-Source: AGHT+IElzvjKe0dz4roz/C8lqKaIRK+lhNC5iRXxHDsR6Z0O9ps5OKgZneLQODdgmE7OqjdHvJtLyw==
X-Received: by 2002:a05:600c:35d5:b0:420:fb99:ed02 with SMTP id 5b1f17b1804b1-4212e04492amr77039815e9.6.1717447093610;
        Mon, 03 Jun 2024 13:38:13 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b83d479sm130835225e9.3.2024.06.03.13.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:38:13 -0700 (PDT)
Message-ID: <e98dc7b1-3c93-41d2-a2ef-7f9f69789886@gmail.com>
Date: Mon, 3 Jun 2024 22:38:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/6] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Language: en-US
In-Reply-To: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
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
index b8822a9381..b786601074 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
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
2.45.0.97.gb691764a17
