Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E913A879
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720205476; cv=none; b=E/252s7c+JVgJJFDLPDVS17DcNCfw+w2DORyN2PXyOl4h0F8G/3n42S7priAxvWCCc9G3HAxrrPqXroK8IT6kFLkp+KeuASIaOfNEhzTcNIGnAcyp//aX931iaChk4d2JaWw+xTwxeWShbyY2YJdrnXFYZwJsZb5rHrdRoAggsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720205476; c=relaxed/simple;
	bh=83y8HxdIHbwXVRGudH20XE6BYQubLRefas/FRr/SJiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bL6hfodw79rd9/Hmla9vs/HhXGHII2vQH7V32rG8KP5pecgqt1UE+s3tdAnj2b/WjqHhZXmQCRYpRsapsurY5HpicEFg6nf8blN0klCTx5uTor8/kHCLnIIw4hEqeSpWt2fjF1m3KaiHzn8SYjMNA9TcE075e0MbY218uwjo0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kryqgrYC; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kryqgrYC"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-701f3ca4c8aso1079672a34.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1720205473; x=1720810273; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1BDWoYjuCLMSoQZcIHXnKJgtRMhNza4ITWQNtlNTp4=;
        b=kryqgrYCK0KO/W+8Ocn7FLowUcWcp6l95bLfDJR0KxVrTiyY/dq9jeHRh9VmPMY8aL
         8GgxZitkpfjr7KXs+t3UOfhCvY6mcpE3YvlnwYJrIabQ0hBqwCtWx0+zQvcTXurLB8ZB
         QC8dTYC58PnHNgJFTOkvPCPFEmuIiyAaVqjzAoHNQkQqdhxGePqcQJP9v2azkidOqy28
         DsvvD0+zABs11WMdYzwesM6is8z7go0/+DdpGvJ51BN6uUmgzur1ao/Sg44Z7wKBtclZ
         C9njY85GROTcdAy9JZpbXkAEomFvZsxnRt6F8h1lf2/j3y0ZX/9EfG0qZ92CK45RK6qC
         9BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720205473; x=1720810273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1BDWoYjuCLMSoQZcIHXnKJgtRMhNza4ITWQNtlNTp4=;
        b=TgnAA5HE7tPmPuBYIi5algbZgp4l1/+JU+AmicB65Mbhpuory0A2S1zdyOmIWIopxc
         6AjcyEqMFFrFc93O7wW0FTBjsoRkFHRzdTWHdfNOy/gRhhZFrPM8O4iGIRVuyAKrsbGB
         3pQAPLu2uaJlsfqCsYuLz6xQ5gE07wyQv42jWyzlyACuLT6ZhCBRInPiGrISmLmAZnnD
         SqX/Cj5FVaZH1eM3vMyLG4WeT9IE0U5zm7lSt49TlFb+EO7Q0Jiua6lTOxCIslLp/2Sx
         hu4q/XE5NKKKiOyc7sLGZfecbggRjZ3tkccWbpf6u9UlGGDkRi4evTGhnZvnjb1Knw+T
         Mo2A==
X-Gm-Message-State: AOJu0YxYxpa1ZLCLK1CO3WezmB+5lxVBhuV0c4kTXAJkQSgmGOszOB3c
	v/bFI9mkCChXaw6DWsLTcZb7SWQfLxSuS9kRsc630SrzvANIiWGSdvIh+JCGEZOAvD+o3SD1qSm
	PIO8=
X-Google-Smtp-Source: AGHT+IEU7X0dgDdhtkI0elkYa/AeloheDf2BUjvL/n8jnlNyO5aL1ymk6SmKIBk5rF0jVctsl6SzFg==
X-Received: by 2002:a9d:5f1a:0:b0:6f9:9a98:a6a6 with SMTP id 46e09a7af769-7034a7709demr5910058a34.19.1720205471885;
        Fri, 05 Jul 2024 11:51:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692f255esm796190885a.87.2024.07.05.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 11:51:11 -0700 (PDT)
Date: Fri, 5 Jul 2024 14:51:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: [PATCH] config.mak.dev: fix typo when enabling -Wpedantic
Message-ID: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In ebd2e4a13a (Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format
better, 2021-09-28), we tightened our Makefile's behavior to only enable
-Wpedantic when compiling with either gcc5/clang4 or greater as older
compiler versions did not have support for -Wpedantic.

Commit ebd2e4a13a was looking for either "gcc5" or "clang4" to appear in
the COMPILER_FEATURES variable, combining the two "$(filter ...)"
searches with an "$(or ...)".

But ebd2e4a13a has a typo where instead of writing:

    ifneq ($(or ($filter ...),$(filter ...)),)

we wrote:

    ifneq (($or ($filter ...),$(filter ...)),)

Causing our Makefile (when invoked with DEVELOPER=1, and a sufficiently
recent compiler version) to barf:

    $ make DEVELOPER=1
    config.mak.dev:13: extraneous text after 'ifneq' directive
    [...]

Correctly combine the results of the two "$(filter ...)" operations by
using "$(or ...)", not "$or".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.mak.dev | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 1ce4c70613..5229c35484 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -10,7 +10,7 @@ endif
 DEVELOPER_CFLAGS += -Wall
 ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
-ifneq (($or $(filter gcc5,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
+ifneq ($(or $(filter gcc5,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
 DEVELOPER_CFLAGS += -Wpedantic
 ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
 ifeq ($(uname_S),MINGW)
-- 
2.45.2.705.gad6bdba207.dirty
