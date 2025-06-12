Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682F19A
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689035; cv=none; b=YOJvpbQOueZDbme331KBgSpcqHEVGe+lIYe/glPxM+cncgyL25+3xLu816F8vVZPKxEuNGSNK5kbB52U88f0+tmtJV1QGq/9MuKDCwIEWJkenUWJ4Xd66x8gxjypm2y4fgH270keXOyLageJqNHVss8l3MNpO1aQd5uTjWsvX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689035; c=relaxed/simple;
	bh=Khiko8mIbiDnYSkvAsRw8HYai9LxvdXpt/WlpgZ9RzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P6l0IzNszm0aXmsvKbJJXWk3L06ISxOrAIA5LZQXsuhMjUtkEicg4pxsc62ilyT9y/1fL0IqdniAkPvpQ9I9Qn8I2He/vIipTCSGl++JNoboWkRcJiaX5FTvPL8Onkk9+gUjIEwMf8skkz9whc0SNd/1srEGEzIOTxdBJlvyYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtvG6z98; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtvG6z98"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so435746b3a.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749689033; x=1750293833; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErFLimwGvY3u1VtSV8oLAABthH+3iXq+Ah8Xl9J92MM=;
        b=jtvG6z98y+/s8zxfeM+awFmqz3O7YJJ9udia5qU8UNA8d5VQRwuDsoEmvtBcNUrfhx
         LvqS1XM1bpv6rgjbr7TLRBMbBuUVQqjjWNGIu04myYwg+0skDol2LjUyv283ks9XGnkl
         zhJidQYnCIVTAqbjCfPCHcaRYqt5k9DRgzG/TpbrYSSL/olgZU3ndM+9QOhszVRtGpsX
         AJ+z68D/oFsiA2sKhqmH4TgcwywGxL3lF/i0lvAQQF5bWface/vtJz1Xw+SXWCBEcKLd
         dGVoQm0SWCq66KXxhrfKz1JpwX2UGf4tS2R8Waa4bX3vDBWpaN+om3xC8vcXyxQBWy2D
         RT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689033; x=1750293833;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErFLimwGvY3u1VtSV8oLAABthH+3iXq+Ah8Xl9J92MM=;
        b=GiwYx+L1TgajMJIKQpdkVMulIXI7TFA9Ue1LNKOkzCtdih6Tcdq/Xo4x0iKAyyV4ES
         IONymIbU3/0CfKNmBagT+ZrOE6OUVWkIthvrKU3Vo5H3b0JOwoOsI/tBfADXfbpj7agK
         eIVUnwKjs6A5aEL0EzkTAOTP4YKbDvlpCuzg8kxoX+/iWWKHAp7bj1DL2ITSVdigaPlw
         qX4FTkzSWNtq5NMbD6WDxk6P5jKA5zvWO+LcG+8B8ltmUjD8D/Bnllo7ZS9bLTtQ9EfJ
         nNgZ6sS3tsk/8SWlEyvHrHggCX61xYQfgaWt/NA63PAAPmk0fU81pTZtDQnXLFFxdH5C
         EGNg==
X-Forwarded-Encrypted: i=1; AJvYcCVltZibWM5RpWQ/3FmDbNwquyHO4GnsWH7i7OpMp5M7RwgTMOImKPKir9DmEXqKktZf8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjMPPr6ciJsJWKIXsKUKGgF1Xng3bop6WTFbnTXvzomna7Bbw
	ZEmpoxXWO9z90BcX24O3JBQDqfYAJF7Ne8vg9HzCPaRSPWs5rdI5d8aKOJl+ZQ==
X-Gm-Gg: ASbGncuC5H9JNxgwTj8t/bPZO4JH7S/H0d3hEaj4BacfzAG2SozSCsIB7Xwt1Fn3Rwd
	Gg2+kvW35SVlberFcaRLUeC+oQmhSKD3+XySot901ZRSKug/t1IWgU8lTalSbua24Hh2ML9g2M1
	UnQYEkXj/FkPFxD9mW/RpnHimh8EqzWUxsL2Tomt+i+ak2jvxRFhbvTh9pu/y4XEz7iI890pfUs
	TuSxPJEV4GiBPHKKOniFREVxy2nn7+1hBwuI+WVV9nWM9UQiePohImVh2nTlAXfkpV8MUraV4K1
	vKDbAXHCwe7HgzkPXIHnAQBAyUfonuHZ8mLVFFMd0jI=
X-Google-Smtp-Source: AGHT+IFsdA84yPTbMZ1RXZk8BWDiKn52j4waG9w/gPYTPRFrMLc6lnRo5w/ujJdhNqixkeqwM6KjfA==
X-Received: by 2002:a05:6a21:8cca:b0:215:d4be:b0b2 with SMTP id adf61e73a8af0-21f9b93f637mr1149301637.34.1749689033412;
        Wed, 11 Jun 2025 17:43:53 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd611b9d7sm219964a12.11.2025.06.11.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:43:53 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bswap.h: Add support for __BYTE_ORDER__
In-Reply-To: <aEoeUCcXYByjU5HR@fruit.crustytoothpaste.net>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
	<20250611221444.1567638-3-sebastian@breakpoint.cc>
	<aEoeUCcXYByjU5HR@fruit.crustytoothpaste.net>
Date: Wed, 11 Jun 2025 17:43:52 -0700
Message-ID: <87wm9hkcvr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> One additional option you can add if you want (it's completely optional)
> is that if `__STDC_VERSION__` is 202311L or larger, then you can
> `#include <stdbit.h>`, which has `__STDC_ENDIAN_LITTLE__`,
> `__STDC_ENDIAN_BIG__`, and `__STDC_ENDIAN_NATIVE__`.
>
> That will work on a modern GCC or clang with an appropriate compiler
> flag.  I don't know about MSVC, but it might be an option for people who
> want to use more esoteric compilers which support standards but aren't
> very compatible with GCC and clang.

Another standard that is too new to be common, but POSIX.1-2024 added
<endian.h> with BYTE_ORDER, LITTLE_ENDIAN, and BIG_ENDIAN [1].

In practice, some systems will have it because glibc had it for a long
time.

Collin

[1] https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/endian.h.html
