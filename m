Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6B137923
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473322; cv=none; b=aLy8CEYpE7mhKfZf2TsK0WKItng5KHLeTzsPfnS4dWROZzE0ph4bOR+uygA0YTpbN5gQ0zmjAU4REOn9XWOjqnLHnlyjFvpzO4jIMuEhdSMFxLMdKEF5PoHp/qnw436Jxu2moEb4sCP5B8EqlJOnGMa6YEdcCCmFppNDZwjjZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473322; c=relaxed/simple;
	bh=B1Mtr3Hca7uUgy4LhGc827S5vDvIMWQT/siFruicu0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQn3JRSP2dNeFTQ7hAXgdz71lRqKAhOtw3JKZRVkbs6d1Ox5K7JTNpawflN4IqO1Umnya3616XOQlNUk5rTvx2B/njxCb1WU27qBbE5sJDA20KkjGl/jcb+xpYisY0wt9Vbw5cVKyenGhAAgCv/acC2JEQFBA/bWMZ7PrAqKb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFi01G4i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFi01G4i"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00easo56454605ad.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751473320; x=1752078120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8drraLrcVdtpuTpv8s0RrpfNOYkMV8s0VRWH2MrOPk=;
        b=QFi01G4ighrT0ucU8LytXyQot4burjnlREUzFtvQhHcKtYCAGgku7462R4oIMIvS54
         LvdZhVVYbLhZjYeV252xWpXGOnj0ybPGnC5krhtKs92aN0vDKByluEys3bfllDi7pN5r
         A0vZdTWOX+UclV+yh9T+4L9J/exZDT2/aYbj8ZeaU2AiBLsqLV4DVI7o0x0H0thoXEYR
         wNR5wYWpflDDbElLM05JISgSG16XLGVrrDw9tTxJ7yP75vv7xoVliWYfuS/8ySPSj5X6
         YM3QwB5xTLRJsxOZZpci2ctfUiCNnDfkG/OZ+4M/T3TmpZyt9vUDc7aqQgtkUA6JjQYb
         F5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473320; x=1752078120;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8drraLrcVdtpuTpv8s0RrpfNOYkMV8s0VRWH2MrOPk=;
        b=SbkKBMAqa4aeAUqXB8PbFrLUW8PMXE2W+CXbJk84h+g7TJagxre0Xdf+AuEoe+g478
         uq9Y2yHnvZD2IA2QOe8/yR2GXrNJ6i6LxIfHEW63CJU5dKieV9IAN3A55DOGaUAdtUkC
         2QSyhCoTw8iEHOCGg/Wxg03+uD1vKq+8doNC+4fHOJOIH59EkIYpRSynHZRbL1tfo92U
         PmujYaH2fnnKHagUv2E6oRn+JGlWKrKyyV1Amj5/NTbQLw2Ynxjmo2XE1RSCvrdYYEdV
         klJD5+BxNR1v8kc6bjSSMacZR1Gj5qZYdrSnwWQ+1b8OrqSEMBGMd+xz/cp3GuPPPJcs
         DDnQ==
X-Gm-Message-State: AOJu0YxpPAMsbJ+WTdRJOE5dsv1TmHRl1485PcfuvQyvPsPRjBdMfcDp
	bdN0A10lXzkX0an0sjerVi67cjeIvxI5K0zMxeDoWwW/mu0LMYf0CRvb
X-Gm-Gg: ASbGnctbIrzLMxGFPpW2FYwITLdrcH00w0r7v5PIkgJGL7f1393scv8AhV7Z7OoksZR
	0CI2IiYiy+c5MGoYTSrMGlQuBuUtBl/do0e6ZikRVRz54npcKsDY+DD63tVa573ST6vzm6/aC7n
	nr+OhiD3+UfWAK7mjMc5Wd2SDrftcG+gwMfnfnWVsxe8dlcJusn8SUB5HYpFxrowvWsrmsCP73V
	Tlkwe4CqqmkVFv0pDmfmYaX2eMj6xKYVa6uWTAzjZrgNNegp++EzzLQv5zz5e/LUEQklI7jZ88U
	iZLWsCcBmvwba0Fhh9A2n/nMYqKJVeOlU00pIEF3e+XWinTnLLhRgwpimwWFeOGQNDHfrq9FlIF
	bJjdVRA0Qev481CTl59kqNtOz+20x89lEX0sYvQ==
X-Google-Smtp-Source: AGHT+IEDnvwmMe9yfMAxL9h228tPnDFlULcSwiMcrvPIv9pHfm3/gcTKG76kz/WijfpqQE83kQqNwA==
X-Received: by 2002:a17:902:cec4:b0:234:ed31:fca7 with SMTP id d9443c01a7336-23c6e582734mr52618155ad.48.1751473319760;
        Wed, 02 Jul 2025 09:21:59 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb39baf5sm139130115ad.123.2025.07.02.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:21:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  brad@comstyle.com,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 0/2] config.mak.uname: update settings for FreeBSD
In-Reply-To: <20250702093736.36074-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 2 Jul 2025 02:37:34 -0700")
References: <xmqqv7p0bpdl.fsf_-_@gitster.g>
	<20250702093736.36074-1-carenas@gmail.com>
Date: Wed, 02 Jul 2025 09:21:58 -0700
Message-ID: <xmqqtt3uef6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> Modernize config.mak.uname defaults for FreeBSD to prioritize using the
> platform implementation of memmem().
>
> Carlo Marcelo Arenas Belón (2):
>   config.mak.uname: set NO_MEMMEM only for functional version
>   build: retire NO_UINTMAX_T
>
>  Makefile         |  5 -----
>  config.mak.uname |  9 +++------
>  configure.ac     |  8 --------
>  meson.build      | 11 -----------
>  4 files changed, 3 insertions(+), 30 deletions(-)

Thanks.  As far as I (without access to FreeBSD boxes) can see, the
patches look good---the changes are reasonable and well described.

Will replace the single patch from Brad.

Thanks.

