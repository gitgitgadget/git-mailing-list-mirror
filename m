Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DE249F5
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171880; cv=none; b=IhiVdcIR3ijpNIyCB0hY3Q9TD+8fXLCX5sUVRpCvyyhEbV1H+ER/OtK0r9nJgQI64X0o2d7pyDmbeJwVYAtzml3PLCcCRBUaCgBZ7KgC6TiXVaBNtQISE0DmuBFG12gp8BN08Dja7jNiYzJlpgUh7FUXoqSBTKKqmWKijODaYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171880; c=relaxed/simple;
	bh=PNFEp4e9bUa7E/RtEt4SSNWrhSTHSee0mLkpYd8lMqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eWGXm7GZJbhv3maONGk128Lcv/rsT4noD6tzUkTPAbVbJEup3DF0sH9hzX77gHDpWqj+/cbsof9fZtqfHYM6e2aSUpdhMDFUxTOH69hblBx91KPgeSRqcM0uFI8Z3Ksmi9CR/Dbww01r4TRag1h0HboCAhQurigDQo01thvxpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvEZ2I3b; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvEZ2I3b"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5cebf0b37fcso187303eaf.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721171878; x=1721776678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1uPqp0fh3sIF3wG8eBQwaDJVssf8y+Xkb3GmDGjkI0=;
        b=UvEZ2I3bnyGAwraRu8HWuu7wBJX7Pr1WNIguioabOTo30FL9LiAZyvWYKMQzaIW02X
         WttTZqR/PotTl2yG0d4NKHztBKV5qn1vegvTtIRo77wE+l8LUcUdUBBbhok3stUabhbD
         HR1ksj/QvRRIkLE8GmpRfvvFXnh+yFwZgPTdhW4O7zv9lvxtBy3FqNBfTPKtfpzlsvd6
         RlGkAe0wY+1dTry1ypsaZxyrut2JWu4b15qp1qUUsFTrkPYfhvTUPjC9V4HdU4UfQRFe
         oBXNquHJRsjANa73VXlimEMJ0CtBAlF7TauP0klrQeJD29RmDKOMnhbhEZYXxiZ72FEg
         SCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721171878; x=1721776678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uPqp0fh3sIF3wG8eBQwaDJVssf8y+Xkb3GmDGjkI0=;
        b=JUYy7Xt4F8KEJ0kJzVZDPTu1wZlgBEF55c+mDxTpyEyDYdYIP4QKkWo1BHhy7A29Uy
         a4uVVdso003orcEylnqcxeKqpIfPNES8lI7nxYsMpJhapcMlMjFzZvB7AiLTaghxFGzc
         lWQSIQ45CzgqBcnBZQ6m0LrcQy4q/de+b5Vsj0+KPcCJ7U2wGws5cqL/j4EgNssVRyz9
         0jxC2H173DXaQVi2gKcSp8gCHd26c9XVlUI6k2JXyje0DC81KbGe7VNDuJkrtet/lJSA
         4ZiDe7ksETO6xcKRqlR4BFFt8dquE5FX+CIXPr07G9iBucUYhNjTZwSKCA8xPyI8DOK2
         TvRQ==
X-Gm-Message-State: AOJu0YzDQLuBPo7kuQ6K5lb5QqHBr6/Q0dhAn4XQjXYMQHd8Tw9O3AVj
	GvDXpOGWlTMr3Y5jV7dMNxdQk5MVaxiMtG6HPEGhIvUdCVqiL3UiDwApRg==
X-Google-Smtp-Source: AGHT+IH1SixQDoSc66YobhkaoqENaTsWXskbHbG6IDnaEFzY+a6+MqzTi5N8bRLHNrFhshoCf/PDRw==
X-Received: by 2002:a05:6359:5f94:b0:1a6:7604:b2bc with SMTP id e5c5f4694b2df-1ac9e6b2507mr11298955d.21.1721171877856;
        Tue, 16 Jul 2024 16:17:57 -0700 (PDT)
Received: from thubon.lan ([14.191.223.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34f14f53sm5414379a12.51.2024.07.16.16.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 16:17:57 -0700 (PDT)
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH] sparse: ignore warning from new glibc headers
Date: Wed, 17 Jul 2024 06:17:41 +0700
Message-ID: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.45.2.599.g51c0d632d3b6f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With at least glibc 2.39, glibc provides a function declaration that
matches with this POSIX interface:

    int regexec(const regex_t *restrict preg, const char *restrict string,
           size_t nmatch, regmatch_t pmatch[restrict], int eflags);

such prototype requires variable-length-array for `pmatch'.

Thus, sparse reports this error:

> ../add-patch.c: note: in included file (through ../git-compat-util.h):
> /usr/include/regex.h:682:41: error: undefined identifier '__nmatch'
> /usr/include/regex.h:682:41: error: bad constant expression type
> /usr/include/regex.h:682:41: error: Variable length array is used.

Note: `__nmatch' is POSIX's nmatch.

The glibc's intention is informing their users to provides a large
enough buffer to hold `__nmatch' results and provides diagnosis if
necessary.  It's merely a glibc' implementation detail.

Hide that usage from sparse by using standard C11's macro:
__STDC_NO_VLA__

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bc81d3395032a..4b9daca1dcc58 100644
--- a/Makefile
+++ b/Makefile
@@ -1381,7 +1381,7 @@ ARFLAGS = rcs
 PTHREAD_CFLAGS =
 
 # For the 'sparse' target
-SPARSE_FLAGS ?= -std=gnu99
+SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For informing GIT-BUILD-OPTIONS of the SANITIZE=leak,address targets
-- 
2.45.2.599.g51c0d632d3b6f

