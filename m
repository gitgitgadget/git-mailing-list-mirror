Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAA7260D
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550065; cv=none; b=M4BbH+CiRZ/Zpz0J2PeckaOVrofT+wCSboY3F9bwP4EcHzhOaWOEtRsoJMybxE2dPyiv2XbOGcWL91WxcHp/lTUoqhG9WqZZicgAZWKMsFj5RZO5XXtFzQ3tm8fPISadQ0j3NGCklwQon2YbECcOFrGFrMblGYt3QlyIyVgMcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550065; c=relaxed/simple;
	bh=Hp6nV2vsAMg/WzFPG0BcMV62CDJWntrw01BGs14R+Ng=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pG41nI9GFotPZ8BNDBUAMcC3o7pfOM1TDsmMjjhgiSnFUsGSCVbzNiPOuY9ugK3BsjNc0eW2z3cbqF5dNpTZChplvPBWNX58Bl/6iFhFBVfZt0TEvoW8eMaQrPAZ5DCVyl7DvDQiaf3L/TiV/+6Y2xRHgpMyyD+yEiJ0LzyFEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUt6+fcR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUt6+fcR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1262562f8f.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758550062; x=1759154862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qd8IVm+mhWkmlzTBb/WtqBuBz98igubHfA/Y1FUw3h4=;
        b=lUt6+fcRLno0H4HPGBOh05l5I0d88mv10flmZdEEsTvuNiCgNplE48Fmyz9PgNF8pu
         t4ejx5D3/XHPejyStjaXkLPVoP3/VDbyoICbYnjEahJkPsoz3hP407OSK6/B9F5CSiRM
         aRkWgyh8BLgD8KYLomRoyh82ouaekNdk3puIUIVU0idau0+IvF0ILohvHUNkdOFRGq+J
         /esQ/pCanMYBtdbGZT58YrrmFJKuXA71pZdvL+kp1vP38VFEnbgDSfPJkf2jpyVcP3NX
         yk3NenKXiY2AavMroBBKmebuiHc3AciNXGRnBSMCrPD30c6/nUF2PJRQUUyYyAmUKvYb
         ZyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550062; x=1759154862;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd8IVm+mhWkmlzTBb/WtqBuBz98igubHfA/Y1FUw3h4=;
        b=iQ50/tI1D8gJ9pQl+iyBH3qDSlb4pibBNT1Ysu5xA+7lsi8dVYJrsnR0CWYTjunFEs
         U3TPvTzgXvhJhXBY5BKTGPcDu6vjk0ONW0ZEyTr5R9vImH8M91DNTMKshhwTVTBa56bA
         WTujbYcnvzWR/+IF/EjPVpQgizvamAANM2ypz7vPa/4vPLRu9X95NyOdfPtVkDR9LcRS
         NQZ5ljwnBHzRrd63vPKo1rtGS3YiSgUqkEzzpn6Yt2hMjsSmUFOs0Vds1fwmypUrFazH
         Bel7cRXEPIseV6to6seEqGT9msk+bCgi62hl/7Uv6aI4Zsq0vHdowzgpROZZie7As/Xo
         3q3Q==
X-Gm-Message-State: AOJu0Yxd+2WnR7cPlc7CgbJktvjxQZVHaZZasdo4mlRi2wMu1NL3CU6T
	ezecr2bZlwVcVG1GVMlqAq5iocmHRLWzulub/Aw8coo3SHC0kbOtxW7f
X-Gm-Gg: ASbGncs4DOKK+rxI5hqT8D8Oo3N+JTWZ8qVdeO91+xzj2F0R9/FnaGJ3X+hcFNiGaLx
	JpR78U2dxv1Z8wZhoUaqb3FVuHdaNh27yIuRAUiE7mA/JA2U5kxe3FHTwxRidZUBu6jqw5UU5FJ
	Z+d+pdAPQiadjs9LgtLqvMaNBVJnSy2n6Asu98+586loCz1FAg8bNk9ZwlFuBmXMDUQdL/MP9pV
	qVV77wZlAFwRyJIz1ZaWXr+1nKmdd+R8WQHic/vh25N6b1pj9SYv11RBmMX7ilkMLZlRJgIyx/g
	ZG2A9tzeYjbtbfV53DIOlzlueCznhZA8lvTdNzUifwckPQ9kMELb/7hlSNCHxKkzgo3uibBtGcL
	XNNh1w4CV4TDtxYU2Or1JSDtqogeym45nrqe+Yg+aNCFrUiRyms5oKXbmdghktNJ8iRyoWmlEA5
	s=
X-Google-Smtp-Source: AGHT+IGe/eYs/kudJUjOgh7gEAz/7C+s+BGOBmCW4pGbPy8ZSTLsoUUCzJdgXlRqnri7uhXE9LO5HQ==
X-Received: by 2002:a05:6000:238a:b0:3fe:34ec:2f8f with SMTP id ffacd0b85a97d-3fe34ec3351mr3089274f8f.40.1758550061636;
        Mon, 22 Sep 2025 07:07:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f4e4sm228808135e9.13.2025.09.22.07.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:07:41 -0700 (PDT)
Message-ID: <f23fb338-3039-4c86-a36e-439d68d14acc@gmail.com>
Date: Mon, 22 Sep 2025 15:07:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <72d0a316-ee3d-45a0-8122-77c52911614b@gmail.com> <aNFImn9toejLzIJR@pks.im>
Content-Language: en-US
In-Reply-To: <aNFImn9toejLzIJR@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 22/09/2025 14:01, Patrick Steinhardt wrote:
> On Fri, Sep 19, 2025 at 02:59:58PM +0100, Phillip Wood wrote:
>> On 15/09/2025 12:22, Patrick Steinhardt wrote:
>>> 
>>> +You can explicitly ask both Meson and our Makefile-based system to enable Rust
>>> +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
>>> +respectively.
>>
>> This is helpful but ideally before Git 2.53 we'd make the Makefile and meson
>> print that information if they fail due to a missing rust compiler.
> 
> The intent here is to allow us a bit of time to iterate on the build
> infra before making either of the build systems error out. Ezekiel has a
> bunch of follow-ups that we'll want to land to also unblock support on
> Windows and to implement things we don't yet have, like Rust-accessible
> C bindings.
> 
> Is there any particular reason why you want to accelerate this timeline
> and make the build systems error out right from the start?

I'm not suggesting that. I'm saying when rust is enabled by default in 
Git 2.53, if the Makefile cannot find a rust compiler it should print a 
message that says how to build git without rust so that users do not 
have to wade through this document or our release notes to find out how 
to do that.

Thanks

Phillip

