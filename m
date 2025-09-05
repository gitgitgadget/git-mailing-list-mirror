Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D21171C9
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068296; cv=none; b=h894g0eaXAWwCluPGND2wU8r4BoKVPUklldxE5sL0RuS/VgPcMFc26z3cPwFzD2UTt8abQx7WCavEterK403TOPRD8V1QbMFYI1ZGJsOfovhyStsGHYNWrpydEcM/0gvWHrpkuJNlGS4md217HK6YL6TuhSloO/M+qKSu1AZ5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068296; c=relaxed/simple;
	bh=NJRAUeLg2IDmRVJcAwXs3pHQ6qiP27U1XHOMrKvkDKw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nPnxgr05QwOhG6M81NFoSypaFzMYOk/uOl0YVp7AQjar0w3c1aCOki6mJEss22KwKIFL/MFPNwoNaARzh+82dM+cjccNVcDlHTgA7y4O7Xcllc+fg/DJaBJ8KZv/JjwVWmxtK1pnUTJXf82ECiag3520Z0GrcRCExQfWpi9c8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn1owEtG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn1owEtG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9853e630so18404565e9.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757068293; x=1757673093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxFgUDtZ4FZl5Y54Xv2BhGOAGfk7g7Ew1zzjKcGQQLg=;
        b=Rn1owEtGziSYraTDj6HA84fxnuuMzTSZY4cl4UPBBsFWRpMZ+BwllYlOnIc3IJxBAo
         5KIMln2TNkuwDmka+8YKs5sm3UxfaPK4L+W2WmTrpCdoSx3Y/NXQCn+7tS7Rip6QWHdN
         ZuIXozH0Z3FiT14wPLpa59eGogR68+bgb7/1rKzswDU7X2V/Y54Rv11iXvQ4Y5TzM0rO
         Jg6vlPuZidll0/MhoqtG9ut/FPwVK/43+EcrwofNatfQtXKHFDcqRu76Hh78khh1Xd+R
         oEkhtGxPcy8n/4lKQUDQX6WvHpmZKmGnOCuu0Bv8YEjDLi6i9W+hVoHUMkUHTBMk5Mpa
         t34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068293; x=1757673093;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxFgUDtZ4FZl5Y54Xv2BhGOAGfk7g7Ew1zzjKcGQQLg=;
        b=nwrH2lA9VO5Are/ABmhQNhz7N99Ny6jGSBigDB5p+x1P/+M9DI1VPiLp6PG57hWj4h
         H95L14mUq4vA8U1TDvY9XH129i+5CTs7/w5DADXfdDYbO/l1cXETKZMjSWaGXnFF2ZfI
         ZJT9AEtb007TxVnBtsJJvMsKehhYS/i1ChhNLRe08hYUHsV7yhR2w0pZ5kRA3MiCpdCT
         coWN1tLg/V5aVt7kiI5wCMsYOKEEm+WZKvdD5DxGUJmf46CcXfQSjJ+OizpuQS8CkXnI
         8sfa7njm2m/tAx15XoubKihjcN0cb7Az+yb0Jz1SIxSocPwdW1jhk2MfcAngyuBC1MCd
         iffA==
X-Forwarded-Encrypted: i=1; AJvYcCWuNiWhuz459Wj8tkhpzVX14iNy1aGVX154EqD1zBoUoudVvyyIKDxjNEVI+8Pw+4K3680=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyix7bSCDxc3hlO5Y2KKIXaAojSbSb/jaj2eb9seZYVEUp6Yj5T
	rKazAiTpe5jIqUO3kE4N1rw8ash0O0rYwLkWznDPKQpTyl8LfL6Gonly
X-Gm-Gg: ASbGncuF67gysvtHx6AypDMOakrNdUZt/8mdc9ljs+Bo7+EYtVgKM8QasUYxKA6BvpX
	IxQA1iSNoBJlA0JUVOpSSwrgNvhimSdBF9EYNXxYL4Qe4DxsyOyJrEeye3kUjmFH3k+jM4L0pqO
	5SSpuwng4DcoocjFW90ovCuZtl2kt+wjFmjkLhp880QkZ4lZJeCH+by5zGhyJVW9F4taZByIaHV
	SHchI7/WsPTJ/vZbGVg0AbNbFCubS8/0PRx/Fmu3pvW5M1rdwIUc2fmRkDRlbPSBVW712TgV68g
	v8iUjGmnMJx9EuP2+OuXjgHGNG1/rW1OOlOK7J1EGmGunPJkIJ50K37LyTZIbDYD7IFNLdCwzik
	HVbendGEmfWh5stzz3m6knkhDUKlEUuAtdSbFKOgiF5l+U3mgl0ZK+NBNHpyVdT0BA90Y5ze2Kj
	w1dthYiXmOXGr46EU=
X-Google-Smtp-Source: AGHT+IFOE8FuTEhmi8c9iHvpdyc0eTqq/DUhMgdo/QIrDAklrMmdHw5h4PalW+Ujo6Ud8XoYMO++Vw==
X-Received: by 2002:a05:600c:458d:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-45cb6fa37f7mr73854675e9.18.1757068292547;
        Fri, 05 Sep 2025 03:31:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfc3e11esm39163465e9.0.2025.09.05.03.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:31:31 -0700 (PDT)
Message-ID: <ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
Date: Fri, 5 Sep 2025 11:31:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 rsbecker@nexbridge.com,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Christian Brabandt <cb@256bit.org>, Eli Schwartz <eschwartz@gentoo.org>,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>,
 Mike Hommey <mh@glandium.org>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>, Josh Steadmon
 <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local> <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 05/09/2025 04:54, Elijah Newren wrote:
> 
> (1) "without advance notice" was already pointed out to be inaccurate
> in this thread, including in the exact email you are responding to;
> you could argue that there hasn't been _sufficient_ advance notice,
> but then there should be more details about what is and isn't
> sufficient.  Merely repeating this claim which brian just barely
> pointed out to you as false almost feels dishonest.

I think there is a difference of understanding of what constitutes 
"advanced notice". While it is true that there have been discussions on 
the list for a couple of years where people were clearly enthusiastic 
about adopting rust those discussions have always petered out after 
concerns about portability were raised without us actually adopting 
rust. In those discussions there has been no clear conclusion about 
whether rust would be mandatory or optional. I think from the point of 
view of an outsider who was following the mailing list it has not been 
clear exactly where the rust discussion was going. For someone not 
following the mailing list but just reading the release notes there has 
been no indication that we're thinking of rust mandatory for building 
git as opposed to offering rust bindings for our C code.

> (2) "pull the rug away" seems hyperbolic.  I would have liked some
> explanation as to how a transition period is expected to help, and how
> the existing transition period has been insufficient.

I'm very unclear what "the existing transition period" has been

 > [...] > (4) you suggest that adding Rust as an optional component 
should avoid
> the problem, yet we've already had Rust as an optional component for
> the last three releases, going back to 2.49.0.  (libgit-rs and
> libgit-sys).

Right but from the point of view of someone trying to build git on a 
platform without rust support there is a world of difference between 
having some optional bindings for rust external projects to use, and 
making rust mandatory to build git.

I would like us to adopt rust but I am concerned about the implications 
for platforms without rust and think we should give some notice in the 
form a clear announcement in the release notes once we have a concrete 
plan. That plan should include a decision on what commitment we can 
realistically offer with regard to security updates for platforms 
without a rust compiler so maintainers on those platforms have a clear 
idea of how long they will be supported.

Thanks

Phillip

