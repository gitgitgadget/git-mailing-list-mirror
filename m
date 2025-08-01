Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EB19C556
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066302; cv=none; b=Rc3I/vyCv3aDP6oT0i5Eavv5ctIKGLtLzElBVFMKlYxpNugLonvS2VwaO2JS1YCXisNrksj2v6PqDcrijUp+bvpEp4wXpIk2XHaSU2ynNv6OMrCEjEyRn6X90XlxAMlfc5XV11GvFCstFD6bG6OVNO7T5WoeuL4ExSElbY7wfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066302; c=relaxed/simple;
	bh=zQfeTYLcvv7BoT+5/2bGQPpzlnkIP90pPX76/hMgtkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tPI+wWfwAgxxmqHFio9JDgOu+HCkosjlQw06FSgDjfwkP/0DxgS855PwwPaWQlToaa5vcemPbb5mRmsM7ggOtTBfJyorPDKuETiQXoesw8M8mOvSUfBCummW0bUDMr+gw1Vah3bvG+2HaR+1fbjWtGVv8QjPkDI4Z3WIopAK940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PDoAfNpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dD+X9vYy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PDoAfNpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dD+X9vYy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FF407A0094;
	Fri,  1 Aug 2025 12:38:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 12:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754066299; x=1754152699; bh=GIdLYkS3t0
	d8CcDxJpQTzis+8KHf/Eqjey7BeGEtpME=; b=PDoAfNprfHLyyRupwYgVCmmErj
	hQc4OsQEJTghRfsvxs9l99LUXvBL35/F/V9BgbnO8pQSXKjw/CErU8/69TRqD/LT
	r1hab4OwFWZuHZHaMLsgHS+gwgZ48h5NmhF1k34EkKJKfeZ8IR4SSb6K7TgvaSq8
	2O5fSo03Qgws3KIUkiANxEPqESSy8zEOgI3gqg02Mh4+4T8JtEBMOmiSISkGIIQp
	cohB8524KXKgoyB0KrddTPrs4GEK954Xr/J1OtJs3OL8OLX1oZDgX3m+9yJkY2Np
	JgGr5YRsYAGphpKsvg9s5zTXu9Ltel6wvK/s+Ti10u+5M5pCXex+Wzp3XlUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754066299; x=1754152699; bh=GIdLYkS3t0d8CcDxJpQTzis+8KHf/Eqjey7
	BeGEtpME=; b=dD+X9vYyjsy/qAxbH8Bt9gv2hLewezAl/suWsD4Xk9n3Lp6PXvJ
	cgq/IDQHouPlMmNOpkVTg8+jjPBBSTrzSh+lA0WOIrXA4wkkeWvT2QPQ9vOyhvk2
	9ET/Uwqf596rECBSyJuHW0CLwMy7T7IR8tsWlxHw3DwWEGV2MOL2j3eJFOR3gBCZ
	sn32OUZqPzDWwadWgkX8GGN8oRMhhCuAYzl5FFr2J+PFM5KkTC+4x4oUpfdQI1Gh
	aZ2LwUU8y3seb2wRGwMc1seBjyC0OfKQtXyvNt1d+wYVuYDTiLBnVwJ7tub4M2sT
	om5FiDupc2xr7b57X+ZcA5n8AFasBxfclHg==
X-ME-Sender: <xms:e-2MaOSudth4dRX9k4T0h7HuiSB57jcA7Yn0Qd28jgXLa4moLNe2gg>
    <xme:e-2MaHBXV_Jc3vxszwuC1DS3X5r3PCp8aybemATxos83mkaBivlpmgPuT-p8ihB8C
    q27vI90vjgDrWEOog>
X-ME-Received: <xmr:e-2MaFReyUseZ7Wa5j6JiT2mctRCjeLLs-Q2OYUulH3ectIgvTrnkpd04cLn0cL4nsp45MHgq-LNERDDAbvWZrildH5OOBSDCgiUih8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:e-2MaFodTmfGpqTTgwJ3WI9FzsDEkDNLG0JYF9vR7Eyorfc5596oyg>
    <xmx:e-2MaHzcKlAW52qoRrMhM67DlhkiN11cAkSa5Xe45Eopqieklnz-UQ>
    <xmx:e-2MaKJSety75YYKaOEwQJTd-iFGXFxW-VYqMC-kYFUD0GbYJraAiQ>
    <xmx:e-2MaJJ72dIoO_8mzJLQgEnvkEGPyo4v_Opuul4qwLkODeE3ahz2qg>
    <xmx:e-2MaGmabELW1wvDDGZ8SgqYxo8W6JxYHaOIjHe8fpq7bHox-csFPlEf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 12:38:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 6/7] string-list: optionally omit empty string pieces
 in string_list_split*()
In-Reply-To: <aIx_KAhKhGedQ0mV@pks.im> (Patrick Steinhardt's message of "Fri,
	1 Aug 2025 10:47:36 +0200")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731224607.3942417-1-gitster@pobox.com>
	<20250731224607.3942417-7-gitster@pobox.com> <aIx_KAhKhGedQ0mV@pks.im>
Date: Fri, 01 Aug 2025 09:38:17 -0700
Message-ID: <xmqqzfcjm1za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	if ((flags & STRING_LIST_SPLIT_NONEMPTY) && (end <= p))
>> +		return 0;
>
> Okay, this is where the return value of `append_one()` starts to make
> sense.
>
> The condition for `end <= p` is probably overly defensive, as it
> shouldn't ever happen that `end < p`. We could make that a `BUG()`, but
> I'm not sure that's really worth it.

Correct.  I'd leave it to be defensive but without overly
pessimistic BUG, as this is a leaf function that, once carefully
vetted, is unlikely to become buggy (which is famous last words).
