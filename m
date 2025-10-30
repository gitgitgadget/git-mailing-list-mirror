Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27D2E2DD4
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789535; cv=none; b=gKEYkmWpyxZcPt6HlHZp5Qcjs+86O/sMPOda2aYYsB2p7Nr6q9EyKNKX0IojFcA3hAxYsUST2MBiCpNJKL09X0FgSRLj+T3oJpntxziDASDTjTYSIJ9tMr9eryydtP+BaGUwXqn9Vp4dse1aIlCq1Gq79G535SOcACzPMSedg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789535; c=relaxed/simple;
	bh=Ohq3gGNqSxaRubfrYk1IT6blGcrpEBWqQYA9VkCiZ10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3gU2M9BuY+E4qhhsC2ZhYKAHXowQ2TjajyXGa5v+YQrW/24W+nDWHFhHP8nIkmN1RawxmsYgLd99I/yIp4jlYllsnGKmAAJ1w1ksIO1LyORpIV0O52PglDOxaQrboLayln8xGlPlpAkEybWIcss52KHlD9wGPvmykwp2SRuJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2VPNSrO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2VPNSrO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f5d497692so760960b3a.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761789534; x=1762394334; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUvaize+YyOyDtIfZ2TYw4w8S5dcZ+CWKAN3knK3b30=;
        b=Y2VPNSrOu4Z0ZbZfdN38/yZAeE8x4OkRXFKPShH2grehifJhH4t6wE14I2yEE+rQP9
         +41We+SajDakM7Lgh4cgsgUGps3m0bjPTxCcbrzwwl8aXTk9JyiADoLahYkamByCektK
         PlG6PbTZkUnTDORBlmQRfrH5Zn7nd9ZmvjXN9ddAUhawQ2vRWxmpOLu9LA/nqVXsXFI+
         KlTSyv8edlvMbvtQvHaJaA+mAHJ8iwVK/XOJeXySYtTsqdeO2c21qpUHO6dkwsWEJIdr
         V3Vfmjlqm1OAWFviR/knBeg+/VWmFv1AtiNLHMMSp6wF4WlcbqSSW3nj8uulIN2ra/sy
         prfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761789534; x=1762394334;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUvaize+YyOyDtIfZ2TYw4w8S5dcZ+CWKAN3knK3b30=;
        b=FxSoeEFaP5U8d1b5xcCtp1NgHwYUv/w4kHOqiSM+88fRC5FP0Yqfqkks4VvUkZAw/Q
         TM00x1RnAY6ZvpaDFl9alldnTQbmLqtSNq6357Ud7l4kXB+K809ri7kjE/i2pvKKBL2E
         jgT/r6XuoGqMsCOJdljPxODKeO0zliIbPxC51Y57y3UuHrKQznXXM/FG/GhIooTEqW5f
         EUUJoC327qfzD/+Il8ACW5QFs0uuhd1fMN9A7nsP1CF8V0+FwWalOngX8hrO9e7efetS
         Idw6rK+hprRQqt4M64IDp+hk6/DxObV499O/ltd7th1mi8JTl6YHdd9ptBm3NxLFCIoQ
         Whww==
X-Forwarded-Encrypted: i=1; AJvYcCXjn26/+lExk7LbrIug3O/AsChe8rNi+St9XgmIfBddXCvUDDY8ANfHsLtB8U6sFtx+n/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnNCVPVxyzbmwqH3cswMBYqRvqBJ+WQAzj9IXnLo7HAB4M5ZK
	HgIO2GK8Bir2RWinQoB6b2NKvBWPbEfV6qcZcsGAZd7yN1xGgdmIUp/k
X-Gm-Gg: ASbGncsijsbDe0mB7PcmXsVuGrgPj0cfXaA9WB6uZRnP8oJKE0+Pp5sBLtWTFUguEa3
	FMqRW2ZIKy542MY+EgxEdrYjbyeePM9bvpGxm2KNC3EyoIvYaGL9LCp8jcGMzASPg+NcWb9yOtK
	YA7Lk0+mSnwlyFUnskIp4+hz8MtlrfcaYmE8XyWG6MWGr40MJhBAU3vCuvjkDN0ma5lFNzWbsI1
	0pN9PbpHzm4sKMariHxj31DhHBDcHm/hBxvQ/a24g42OfID4lP4WI/SRjkXfIuMggHFl0H/ARjm
	5Awq0xpoLyvxMtfOC24th8rRA8Vjm7pBFUcjv4Yz3TCKQ1I2kCq0bKjYE2WDzwXBtDlgoiqeZOC
	34hIlfpc7fgpYk3M+emKym2QCYpXtXVFwWGFbSYx73LxQhR9EbPkP4kWE8PNPuUMF4TE3
X-Google-Smtp-Source: AGHT+IHYUlaOv7qEqtmR8tmw3SkRjNhBPP34bS8dIm/kc6pxeE4GD89Ni9WkXD5rwcA+6C5UsYxU4g==
X-Received: by 2002:a05:6a00:3d42:b0:7a2:6a86:c7a3 with SMTP id d2e1a72fcca58-7a62a84c44fmr1620172b3a.8.1761789533656;
        Wed, 29 Oct 2025 18:58:53 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::43bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072487sm16568702b3a.52.2025.10.29.18.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 18:58:53 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
In-Reply-To: <aQKv550C6nXhCzf0@fruit.crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-4-sandals@crustytoothpaste.net>
	<aQCKCfuaEKBArD-g@pks.im> <xmqqh5viddo3.fsf@gitster.g>
	<aQKv550C6nXhCzf0@fruit.crustytoothpaste.net>
Date: Wed, 29 Oct 2025 18:58:52 -0700
Message-ID: <874irh6tgj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Brian,

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-10-28 at 19:33:32, Junio C Hamano wrote:
>> Yeah, I do not very much appreciate change from "int" to "uint32_t"
>> randomly done only for things that happen to be used by both C and
>> Rust.  "When should I use 'int' or 'unsigned' and when should I use
>> 'uint32_t'?" becomes extremely hard to answer.
>
> In general, the answer is that we should use `int` or `unsigned` when
> you're defining a loop index or other non-structure types that are only
> used from C.  Otherwise, we should use one of the stdint.h or stddef.h
> types ((u)int*_t, (s)size_t, etc.), since these have defined,
> well-understood sizes.  Also, in general, we want to use unsigned types
> for things that cannot have valid negative values (such as the hash
> algorithm constants that are also array indices), especially since Rust
> tends not to use sentinel values (preferring `Option` instead).

I don't necessarily disagree with your point, just want to reiterate a
point a touched on in another thread [1]. In some cases it is valuable
to use signed integers even if a valid value will never be negative.
This is because signed integer overflow can be easily caught with
-fsanitize=undefined. An unsigned integer wrapping around is perfectly
defined, but may lead to strange bugs in your program.

> Part of our problem is that being lazy and making lots of assumptions in
> our codebase has led to some suboptimal consequences.  Our diff code
> can't handle files bigger than about 1 GiB because we use `int` and
> Windows has all sorts of size limitations because we assumed that
> sizeof(long) == sizeof(size_t) == sizeof(void *).  Nobody now would say,
> "Gee, I think we'd like to have these arbitrary 32-bit size limits," and
> using something with a fixed size helps us think, "How big should this
> data type be?  Do I really want to limit this data structure to
> processing only 32 bits worth of data?"
>
> In this case, the use of a 32-bit value is fine because we already have
> that for the existing type (via `int`) and it is extremely unlikely that
> 4 billion cryptographic hash algorithms will ever be created, let alone
> implemented in Git, so the size is not a factor.

I guess intmax_t and uintmax_t are probably not usable with Rust, since
they are not fixed width?

Collin

[1] https://public-inbox.org/git/87jz16dux5.fsf@gmail.com/
