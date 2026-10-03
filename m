Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15739CD00
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054043; cv=none; b=RYvnUFWuRhL2OV9jPUH4ndgdrM7e/vSE4pne1xFR6wrH5x/SW1smj1+dqJhC7fmSa2mzOR4P+JANHqu9FrtVwPqQqrcDKMcXMKk85+eDwkgtU1OIFNahimpNLvo2blLejitHY52NJ4h+BrsfQtNCPBsm6asnVvbflzG4wH05SA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054043; c=relaxed/simple;
	bh=w9iooeRHQPR6vUqHETtKUOwYN1togmShOQ986bFYjPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkFP2Ag8ysu9gyywO3+3gQAicS2SRkbvlzCa8Ax7qC4a6bE3Pv3g8KBZQwiFdcQPz4ztf3gVito645BgLqiK0YryXKTPDgM94MWZ/7xpE+ExgsmAQiVvYD9vEsIUg74R1hd0s0WJslTSCMdrY7ylkyaKuhha6uxgoqLZlUzqpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McAoWCWO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McAoWCWO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2e36c3478aso99342466b.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791054023; x=1791658823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QHRLBcat9AzTfNflwAZxjA3y8p7xXdV4zOOgZLwqHx8=;
        b=McAoWCWOpnA40j0xkC434XeL3zm4MqPxtitKUH6sb4u+8BxcsFPRRgdbn7tIBck/3i
         I5cvVlnnTYXG/7Xr+QCoctXIXLvRBjuC9WaMk+AiMJCvkz05bOr2QR8j4GPo2R96HvNY
         RU+PxFGji/ozomvflm98ZW32/DvYtLLEzb4puDW1VZAu4QVw+kyv22M6KhSME2bPk+XQ
         SVBAzPWH0MQeCaT1ksTP8ZK2VflXQ9BlUI0q4nXudSnqlbqU65RkHZ3tNk/Q23Tp1VRK
         JtPENcFX83/Qrk4X3qCvaWRIlxeVueOQInqvijOg4gcHUsW7vFPpBr8Lp7RElYzNN6P0
         D+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791054023; x=1791658823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QHRLBcat9AzTfNflwAZxjA3y8p7xXdV4zOOgZLwqHx8=;
        b=PCjHzsQJsq1K5DG6OQXnZcLGGSIStOFouQIx1mmBbgizUcUJEOUqP2R2cOD6atZ0R4
         juvgS9/r2Y6TPcLm4YDLLHPSgANnn5rwNiA05G0OgMXgMiTbaheqIhZbOoSEcLwxpwa+
         TPKtTdbVsDLGIo84BBUnDcawK6X/5hbqIjcF3BAsmLB54lqRDTY3SQiyNEpx6N+BexeT
         A7OykFWbFZxR/ckLAY+uh9EYUMadAO/B6sNVZ9/izsE6Xj+mkMvFm8sJyjsKHmczK9ps
         RpQvHJievMhcyeNzou8ZdJUqJocDTMS9nrBPzGZlDHA1FP4cHL029xtCQsUU1oQ2SY8h
         pJjQ==
X-Gm-Message-State: AFq9FYLppsoKMugmiwE7DkZ6jfn5BhdHTKv/NUHc2C8j1U2A7WeYO/HK
	SMNiLiiyzAoyjlly52+Rm7jwML01wU3srXysivvpeEtTk6fXsAU7Zo+3850fIg==
X-Gm-Gg: AYBFou0nznDPJWAUEMAh5rxPzCk/7ZeueOC19L7Lyy5uq17+DpxsPHOA4jWKe2SlprL
	UXW2v4D9igZ8S7JScCZ6N/z9DnywpvDNX9rQmfV29G+GqkjPM/vgEWhP405eV7Qe4OZDJsycTj/
	U05LNj3lGFxPV5RTbaq6nzdjj0dk66C33lrO1yGX+FWKr2pjhNjz9PS+CLv0NMND9DofTz1JeK2
	W4DdlvWPmaFiONtTm9a80JBozk83/5GWu9MM2KLyxcU3PacYsn+Mqq3k74CcubgZzvST+uXotKt
	ji5CshxdKlOVoyDfGEQrrmeAMGVRvAyWFa3lZSj4Fj1Fok9a3xR5WUWi9NY9KA9Z/p2wVoTxYbe
	4BdlBLvRznWiaCw+/Ny5ljuLRIjTRLMubsVtOdLWK1N2ugW0mYv1bSIJGUMD5JEmdDllufPJGh5
	A0nPgOUlvICBV21IW4zlX/UvKtWGW9fsLIvvOeLeZKD78QV8Par7oW0TRy6tD13TMvV5czLqgzG
	Rda5bQj/GG/Ef5/tivlVjmiWfK3GPDSmA==
X-Received: by 2002:a17:907:6d06:b0:c20:53c7:488d with SMTP id a640c23a62f3a-c2e6ed157cfmr241653266b.14.1791054023017;
        Sat, 03 Oct 2026 12:00:23 -0700 (PDT)
Received: from localhost (94-21-29-91.pool.digikabel.hu. [94.21.29.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd26a38sm218062266b.32.2026.10.03.12.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:00:22 -0700 (PDT)
Date: Sat, 3 Oct 2026 21:00:21 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] Makefile: precompile "git-compat-util.h"
Message-ID: <asFQxeh+IUGrlu6W@szeder.dev>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
 <20260915060952.569535-5-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915060952.569535-5-szeder.dev@gmail.com>

On Tue, Sep 15, 2026 at 08:09:52AM +0200, SZEDER Gábor wrote:
>     - The precompiled header should not change what actually gets
>       compiled.  Therefore, use the precompiled header only when
>       compiling source files that start with including
>       "git-compat-util.h" (directly or indirectly, e.g. via
>       "builtin.h"), or its inclusion is only preceeded by #define
>       directives that don't influence "git-compat-util.h" between its
>       include guards [2] (currently DISABLE_SIGN_COMPARE_WARNINGS,
>       USE_THE_REPOSITORY_VARIABLE or GIT_TEST_PROGRESS_ONLY). [3]

Well, it turns out the precompiled header does change what gets
compiled, and it causes a visible behavior difference, though I think
it's really minor.

The crux of the issue is that without the precompiled header the
compiler processes "git-compat-util.h", but with it, for some reason,
it processes "./git-compat-util.h".

This is visible when expanding __FILE__ in "git-compat-util.h", e.g.
in the assert macro in regexec_buf().  When the assertion is
triggered, e.g. with this diff:

diff --git a/common-main.c b/common-main.c
index 6b7ab077b0..dd2a90c849 100644
--- a/common-main.c
+++ b/common-main.c
@@ -5,6 +5,9 @@ int main(int argc, const char **argv)
 {
 	int result;
 
+	/* Intentionally bogus regexec_buf() call to trigger its assert() */
+	regexec_buf(NULL, NULL, 0, 0, NULL, 0);
+
 	init_git(argv);
 	result = cmd_main(argc, argv);
 
Then without the precompiled header we get:

  $ ./git
  git: git-compat-util.h:1002: regexec_buf: Assertion `nmatch > 0 && pmatch' failed.
  Aborted (core dumped)

But with the precompiled header:

  $ ./git
  git: ./git-compat-util.h:1002: regexec_buf: Assertion `nmatch > 0 && pmatch' failed.
  Aborted (core dumped)

Similar could happen when the ALLOC_GROW_BY() macro is invoked with
bogus parameters to trigger a BUG().

(Sidenote: While this assert does prevent us from invoking regexec()
with nonsense, the source file name and line number in the resulting
error message are not as useful as they could be, it would be better
to show the caller's filename and line number.)

Since in "git-compat-util.h" __FILE__ is only expanded in error
messages that should basically never happen (BUG() and assert()), I
think this is acceptable.


BTW, this is also visible in compiler error messages:

diff --git a/git-compat-util.h b/git-compat-util.h
index a0f901ce79..00c1f26911 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,8 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+trigger_compiler_error
+
 #if __STDC_VERSION__ - 0 < 199901L
 /*
  * Git is in a testing period for mandatory C99 support in the compiler.  If

Without precompiled header:

      CC daemon.o
  In file included from daemon.c:3:
  git-compat-util.h:4:23: error: expected ‘;’ before ‘typedef’
      4 | trigger_compiler_error
        |                       ^
        |                       ;

With precompiled header:

      CC tools/precompiled.h.gch
  In file included from tools/precompiled.h:1:
  ./git-compat-util.h:4:23: error: expected ‘;’ before ‘typedef’
      4 | trigger_compiler_error
        |                       ^
        |                       ;

