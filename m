Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AC18991E
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753772; cv=none; b=WUADC7F3AwAle1KEeQIlb2m/qsFY0k5tju11Vjjp3NRWDBEmmw+764ffVCRIwlqinbvXv5Upp91+7gfw+cahkireAZRgEsWnwoI4tGDtg+jOexEHrC45IJ+7CzysQ5ethMhEUlr2jvqqGyIDr4sR2VLR+ChX+8s8CyTXqMftFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753772; c=relaxed/simple;
	bh=plPs+CWMXiqZCmV1zI0RmTeQzy1rzDiLJ0cdPnkRtSQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VRlwPgcySL8mqx+SL7xjd6YBK3j41pcxzddRpOSkNyH/7O/GBdQ/Gmq5dkl4BtCZ6mVwxAQRTRSzEq8gCaJTJ9tIvTrGpSlchLHqwMVYCXId9l7Y8jQcIkkrGAuvfuieIx7SvJj/vCItH0bXkpKaobKY0zSf3u+zKVm1CyT/xlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwOn3HhI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwOn3HhI"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78617e96ae1so737937b3.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753770; x=1762358570; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsjvwpRUs1Sn/2O1i2XAxJgwBaB/LM8Yh9J5o7fCuZ4=;
        b=TwOn3HhIWUcrf1nz4zHdUBA4qKu/4SyaOevM5iXh9XpOPWdpuuaDLPv6yf7fS7RbSn
         +sJIaV0+GDzN1ZhZGdstdfGYwY2mpxZZrtwz1u5d/vvsu2HQJmSkh34rWHmx6Kd3HGaQ
         gLHD6OcXXs/7yHfX1GVtZdQKbqDaL0m7lVbaE5o93QjGgANHG+E7p15QshJGt5xttuZo
         QOP1jWUgTvgDdab/XqSUpjAxa7kRca8VHGRdxkdw96EFriU/cTryUqZ6MyQThZ0F9yO8
         WHHWKqm3GERAeyORZ06TwsnnUENRVkGaV3y5pmVn0yrpKpx1OgyZ1KZfkMXml90eh+/r
         MCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753770; x=1762358570;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsjvwpRUs1Sn/2O1i2XAxJgwBaB/LM8Yh9J5o7fCuZ4=;
        b=RWeoVq+ga8p7rFwQfA2IY8rTOX2GL2qgf/hlVRPMVqDWryZjkaYgyg/vmkHPxwmZzh
         aMb+VmFWPSPEecdrfNGdQ3f5euajxtYT4zqUsSdL3JTQhmaq9XMebpUNotW9BjddAte0
         xGx3lFP0qmBsJmiv61UeIRmaYupX+VvOtDmQMQB+ohxlLjZryrqb2wb+OeBuHHtr04yU
         Z0nsYlyvZq4C4PlO8jBeclEY+F9pQZ0a4s7ZmQmdQh5QyZ9MsQgH2Dlf9PBNpqVZYgZ8
         PBeYy6bgVv7sgnEMqoFKHJoIkcgDkTmwz6CgFj1wSCLyYLnDYpGrm7MouEwbe8b9QnLW
         k2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCI9n1gnaPasZZGiSMmr6F+KzvJ8nOxIabfPwixWO4XcDgAZNS/JVfYYRse6xSUqdxjbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKobXz1FezsbbLUiTsGI3ctyuwduvua5Uodw9Vr6LAJzELMA2
	2eZcJsl6uioExSdNGCnh03C7pcnG0F5ulphPeeu6nYnTyU/D3v/fH621h7uciA==
X-Gm-Gg: ASbGnctrP/m0EuQ177R4FE/7OTl6GQ9cydyWEpyp0uvEz2Uxc3H0YWidXdq4LcbiI2f
	cUJ3AfX+BElEIVOAlt9/Af8Tl6h84nby351aQs//sA1S6f9ds/QrUE9Ie7YFzmnnkcNHh62mdXh
	ChDDutTl81al36ewHCpTh9jpoZjh2XCCagKDOQdGpBicBevSiKISL5KOWfJvsqAZHFOyiCAInKq
	JM3IVfELw7BoVQ+REC4ZN8UrRTsS51Nce7ONS32rsLEO91G+Es3vd/+Vao3PkR9Ypo60h1386ZZ
	FQNKxn2qgGaYbxusBzm1AQKhkgbPXEGzgEtzTdeWB8IYxvP/SgCjfA+Eg9043WOSD7jNY1QXOJo
	ig7zbxwNGG8nst0nbTN7iaAVM2C8JMk8lztzsdJmyt3i/ZgXyfqkSFOCjNkPFXUNU9A6mzs7M3q
	lhgi6HCH2bfvrjp/DLwiP654Wdmg==
X-Google-Smtp-Source: AGHT+IFguUhdjBwdDBbw3/iLQNRi+qXI5Q+nbe84WEGZUXD5wuM350vLZ4r+7/OXXiSTPTU5k3iX2Q==
X-Received: by 2002:a53:c05a:0:20b0:63e:3c2a:c33a with SMTP id 956f58d0204a3-63f76cf0474mr2628109d50.12.1761753760516;
        Wed, 29 Oct 2025 09:02:40 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e43d:9f0:7b52:4db])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed140812sm37083267b3.9.2025.10.29.09.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:02:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 11/14] rust: add functionality to hash an object
Date: Wed, 29 Oct 2025 12:02:29 -0400
Message-Id: <6F7696A3-A984-4736-9C2C-D0766443A817@gmail.com>
References: <aQFoWoyj7FyGlB-h@fruit.crustytoothpaste.net>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
In-Reply-To: <aQFoWoyj7FyGlB-h@fruit.crustytoothpaste.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (21F90)

> Le 28 oct. 2025 =C3=A0 21:06, brian m. carlson <sandals@crustytoothpaste.n=
et> a =C3=A9crit :
>=20
> =EF=BB=BFOn 2025-10-28 at 18:05:59, Ezekiel Newren wrote:
>> The name _Hasher_ is already used by std::hash::Hasher. It would be
>> preferable to pick a different name to avoid confusion. Perhaps
>> CryptoHasher, SecureHasher?
>=20
> Sure, I can pick a different name if you like.  There are also myriad
> `Result` values in Rust: `std::result::Result`, `std::fmt::Result`,
> `std::io::Result`, etc., so I don't see a huge problem with it, but as I
> said, I can change it if folks prefer.
>=20
>> I don't understand the point in being able to query whether a given
>> hasher is safe or not. How does that change how this hasher code is
>> used? If the functions are safe then you wouldn't wrap it in an unsafe
>> block. If the functions are declared with unsafe then you'd always
>> need to wrap it in an unsafe block whether it's actually safe or not.
>> Using unsafe in Rust isn't like error handling where you do something
>> different on failure. If something fails in unsafe it's usually
>> unrecoverable e.g. segfault due to invalid memory access. My
>> understanding of unsafe in Rust means "The compiler can't verify that
>> this code is actually safe to run, so I've made sure that it is safe
>> myself and I'll let the compiler know what code to ignore during
>> compilation."
>=20
> This is not like `unsafe` in Rust.  We have some SHA-1 functions that
> are safe (the default ones) that use SHA-1-DC to detect collisions.
> People may also compile their Git version with a faster version of SHA-1
> that doesn't detect collisions and that may use hardware acceleration in
> cases where we're not dealing with untrusted data.  Taylor benchmarked
> it and got some pretty nice performance improvements.
>=20
> My preference personally was to simply say, "SHA-1 is slow since it's
> insecure; use SHA-256 if you want hardware acceleration and good
> performance," but my advice was not heeded.
>=20
> So this allows us to do something like `assert!(hash.is_safe())` in
> certain code where we know we have untrusted data to make sure we
> haven't been passed a Hasher that has been incorrectly initialized.  We
> have some code paths which can accept either (and, depending on which
> mode they're operating in, do or don't need a safe hasher), so separate
> types are less convenient.  We could do that, however, but it would make
> things more complicated and we'd need a trait that covers both.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
> <signature.asc>

Given the confusion on the names, perhaps some docs in the code helps? Or ma=
ybe it=E2=80=99s already doc=E2=80=99d over by the FFI type, in which case a=
 note may suffice=E2=80=94

    =E2=80=9CSafe=E2=80=9D here is about the hashing algorithm and (un)trust=
ed data, not Rust memory safety. See XYZ for more details.=
