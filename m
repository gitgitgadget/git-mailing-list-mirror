Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C32FD1CA
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815532; cv=none; b=bnjN9s7TssiQjXGS3V7nAbepzoxcdFxfAbdwGvcTe4aNiFzHb7+0aTFCZARftj4jFIE/UipxEBDopf76CMKD30qOUCDZOPknEZdHSIZI+P/06I9C2lYB9f8fhkv6f0LUOCHe77lHtM0aQIUJPHaYZOoS/F42Z+wYtoimO2IrgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815532; c=relaxed/simple;
	bh=miVjIgmpvOAH8qnQtRHN61p1ywamkPkUEwUn6U42BMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7AiDpTys67W5KgEzcVVMJFHw1Q/A+A47CqX1kDNQNXAnaQ+o9A4hIA9LBfPOR077SfVCK6rxlolAk8BTi17ga6ueFs5T7TBX95rP3hu6iH7d15xveEWX/JjilmaUchI8NMJx5C2TBxWMgrG+YKo2Gd0HZFti+Yfs5E5dcD2GgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u1GpVc31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcZtEKck; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u1GpVc31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcZtEKck"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D10A1D00118;
	Tue, 30 Jun 2026 06:32:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Jun 2026 06:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782815530; x=1782901930; bh=SzFyRhgXAE
	Ds/hv4kMvupps/dwoSem1zep6OsURof6M=; b=u1GpVc31IHkzMWtHYQtjoDDDFx
	Ztvcg3aEokzdwL8iCsO5tlP5gY6Z7fZISDSgNhbEl6wzrKtcApG8xLYVmIn4fzkY
	zQu97sTW5nKlEr/959xBZke5XIrxiP8EXJ6xVLb9PoFK3oDZrN6LxpSYWcS3d4qb
	fXk4ZikGZZWjHUjE/zezoZknNWCbo2wyQ2h6QDVQX6J2zmrt67+wAK9d3Ri8i9Di
	eJBQSWVeSssh54ZmgzSdmwKRGF6bmOtROqWjJgNSSglfb6pV3mtkKe4q16jzQWRE
	zGDB9dhcvUwmKPPw8JiYBeogbRHF1jtHOLBZ2anBVWjruaTyGaA8M3i2Iusw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782815530; x=1782901930; bh=SzFyRhgXAEDs/hv4kMvupps/dwoSem1zep6
	OsURof6M=; b=BcZtEKckMQ/uOIyQ6aPKql9EkiiJrTALpXH6vp9C8jah3emKxGk
	Xh1wxtL712gUCqV+sr6VMJ9A1u7yRVP5nuDvKnHNb87DCLhDlgNYrGqnOdrbRhX3
	ZCxS8cYBvk4f/WYl0fKVeAwAA2AglFn99O/OppVnkYl0XfuLjYHR0b4ak3CsJD9U
	mXJE2bzbcNzHRR+UcunpANGWwSshBHm7pOY1jw6KqCpzTb4Kvzpz8OnylZlhkqHm
	A0wOcDYVKXD/l/TeHcH0sUhWXIvY/Wx2BChF67hMj6pUTc8GhXYOOHSrqLzkL/CZ
	+Oa9/OHYvTcxEW3C4Pl0QcA6dec5h/Y6wKw==
X-ME-Sender: <xms:KptDanGjgJt-xqmcYPxTSUMdFoVz66vAR1ml6Cs-h5OBZgWbGRHuCQ>
    <xme:KptDaqW8XEule8JOYO8FBPFmdeSWjY0e7Q6GeEcrFZhAYBleJP_DplpHJLUrj6vBQ
    6uHHlu770XrA8PdmV0yJAYriTAV0DxtvWsDqdSRTplbaWw3cNG6>
X-ME-Received: <xmr:KptDamyGXZpV8-krJTAueUu7BP8p0LvA4i8bWTBhpcvXXQne8zGucZdlIRC93wVwPLbyAxMLF52IbFXspmdP2GTf8aavogAncpHah2NdhVHuZg>
X-ME-Proxy-Cause: dmFkZTFJpKq1R28qSetCIhdJ2/ZEOltLIHrYTMJhLgvFZh9BfMf1fogeEXd1Ijezpac6iG
    AYf7dulPRdJXsOrYofiCa+ZZez4a68HcUI2pJCEwQngABdHBZyJBJchzKxf3oimJ/72Bzj
    fwcZ0edGg4TSseNMdjIpC35Cuzx/SMzjgSX5oqqF4SPUhzDw0mh/gegQZBLjjjShkl47Cg
    /mXtTqqH12pAd5T/8YU7N5s+DJsjrxz6xMimnNa35T1TTlLO01AFAH58u15EWp0z1dgBNe
    FRz5YYo7f4y7ZWYZEzYPu/krPpXw+4rYPNBBh+GgSxLDO4WeUscuDvKzVgHTafOS+WTnQJ
    RkZ+QLK5csahyILdS7Dd3c2EsjhzEE120pQz4yyvES6bxUyQEVF2BlTi6ciSOqItEFJNbN
    4cKjLocN34BRxZchX1i7qoSuhfvygW/0f2XLgz0z3Bvl5TGUrXu34No4+wie/TZy42+ke4
    evqPXN1m7GIRxF8TSJUf3OkZHlR2Q7/kXOaMHdFb/mT75N15i0FNscB1gL2TOxVYv0llqA
    Qax/gLPn4rlsJcsq2wjh1ESz4ZSTxVTOybHVejqor22DXSkcmx9oMkWHlh6IvfOwMB8+NY
    2rOyupkK9ChKMcgZyMEO1Zj3DFs2J80V3z1EMxKVyiDnAe5M34zkHjkaUYjA
X-ME-Proxy: <xmx:KptDagONAXxNkmXeL-w6EzAwFQxp_ZyYSl81Z6PEvoPbSJU27mkkZA>
    <xmx:KptDav455LN7jDul7nIDYL_qfg7coE8c7agaPSzO1s-D4JduN8S4Uw>
    <xmx:KptDapPQBvxqxL4YJxxGQUlo6X5yfKosFSf81WH4AFW3BG9wDwDGwA>
    <xmx:KptDalmTYwuWSNlEk8i5swNIP7ky9LXNddj2HpIq1YKKooHc8S1OEw>
    <xmx:KptDaic-iYgmvFw81UxIp_QO9V98710kIdTH7wJfhAoWANXpkkp5qHS5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:32:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38206b03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 10:32:02 +0000 (UTC)
Date: Tue, 30 Jun 2026 12:31:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] builtin/refs: add "create" subcommand
Message-ID: <akObH7ZVSKcc9n7z@pks.im>
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
 <20260617-pks-refs-writing-subcommands-v2-4-07f3d18336f9@pks.im>
 <xmqq5x31ukqv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x31ukqv.fsf@gitster.g>

On Mon, Jun 29, 2026 at 01:58:32PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +	if (repo_get_oid_with_flags(repo, argv[1], &newoid, GET_OID_SKIP_AMBIGUITY_CHECK))
> > +		die(_("invalid object ID: '%s'"), argv[1]);
> > +	if (is_null_oid(&newoid))
> > +		die(_("cannot create reference with null old object ID"));
> 
> An apparent typo here, "with null old" -> "with null new object
> name".
> 
> Other than that, I think this one is good.

Yes, indeed, good eyes.

Patrick
