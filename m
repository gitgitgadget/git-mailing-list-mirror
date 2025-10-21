Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D13257821
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070530; cv=none; b=qZMyo1C8yW1Mfl7W3ZZPK7P1biN0mseLlnQg8KtvQDvCpTh8SL7Ean9YDblhkRuP5GPLx8rd+eKvqJ7h/nurjsbPz+ucKHVEzA+4C+p0iKlgBPNZdMPQ3FIAXkj6xXhEwRgMWZ4nJt0YIrnW5Tua3CzL5HsMJVjh41W+btdAonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070530; c=relaxed/simple;
	bh=OuIsm/S7r0u5wSZUSd5WEive6kOQC8oVR00B7ppetcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFIpK0RaogLpyZBXhZ8u9siebV5j0CtqmRsSk1mtlc4wzQaCcsXV+pW87CP5ogUPkvkepyUq94BaHFLIiYO0QIRptMsqc7/Afd/MqLPwWHHs1zzRaA0P1E387UFRB7aT0wnD+sC9qe+TvbQayV+FK+pekCpVlJzoR2zooWBdFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I+2ryZA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwMPag8P; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I+2ryZA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwMPag8P"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 877451D0008E;
	Tue, 21 Oct 2025 14:15:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 14:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761070527; x=1761156927; bh=avZCAYvRK9
	42Aca48ATRyczQ06dXyU5sSvm3ByVt+20=; b=I+2ryZA2xoCYgYEx+f7wQCAs6Q
	5XWkmAW2scZbgdo1VBtuAyuLi+Uwghu30ZK/z2T8++09d/BtwGXMizXBbDdcbjmB
	RWbs5VUiul3CklghjUgf3JODk3hqOri/6J9Hb6oWRWWa+fZ35wZC2IUoVLc4YKFf
	AqLbgUQSEzZQ4jsuMRe3urD2F6ylaZkY5uDUA2ScvcPoKCIJQCcTEbcn0nc+yykS
	TnGKyGh1nyF16I8XiI8HwnX5qn3h4zd6p1UerY2qq032EM0G6JQ1B7Rk41hDinIM
	+lET3AFDZL6Y8lpLpLnGg6s+saV1AO8zi6BB9/ZmnAGC/2f20WZYlRKj1KxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761070527; x=1761156927; bh=avZCAYvRK942Aca48ATRyczQ06dXyU5sSvm
	3ByVt+20=; b=DwMPag8Pt8igEhgByyieHsLJS+yCthkhnE0Es2f6quwnePh2gXy
	cLUprKf66i4rw9CVi4h/0BxhxuangLwPrApDiRIc+E0BNgNhlZSF1GayNX82VyRv
	svliZLaLpugGAH2I4AVVz0eaeSwJwRjvldtobbknxC+eEt4VxXTAupsWQWlic6i6
	JLd0ARkmS3uf/lWCfP9xM76gGI+Tg+hUgBNO9VjH6TZ/PGvIlwOZkoWXvVxn34VJ
	dKC6jj71q2OjkPfo2yT7I9LUP/96aQrSLu1w5uTXzNvqyR1YrFooh8SQvTJtr0k5
	5tsqpCfDNu8GljBLqa2qj1zFFU3hW56iN/w==
X-ME-Sender: <xms:v833aF87OVMJGh1J-dA1ld5876nhZ62GtiWXvbn09vtJrc_Vg69UhQ>
    <xme:v833aNbiuu_LT1pWnQEYUEZRs1oa02vljDdpfTl2ZnRnBvaJGd9nwsgm7uoKY0G4j
    ZjeqUwRwFbx7qMkwHlrwRsEbIXBKL7kEVGt5J1s1foTY9bvRv831A>
X-ME-Received: <xmr:v833aM0zavRoiPIKP7YMVzDeGF_udSffY9KHtTB8dsOeVTOV3VP-xO1detFrxaA5uNOlMOP5SG08RNKgGoPdUqb3xfxs864MRJL5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    iivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v833aAasq-Z4suVLSnZ-XzgF10Cm7wHl3R-m9f6Z8VrvX7NO819XzQ>
    <xmx:v833aMJxo6OSt5HrklTE4RTGfFpubYpxStX6LR9sGNpgapZxQdsbkw>
    <xmx:v833aHHa0y73tdGugkTXbrdANS45HIH8QDgrf8M2T9DAzbf2X3_OJg>
    <xmx:v833aLv-qbJ_tTyz2DRFYIfeRjV69akR4GI5nc-KQ412CSrEXGrhHA>
    <xmx:v833aGgcgi3xVfSOBUcqCx0g5Y_c5dknHaX71isfuYl8aerGP2Cp0_Vj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 14:15:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
In-Reply-To: <786d6c19-0a13-4e55-8f4b-39b57dd6ea28@gmail.com> (Phillip Wood's
	message of "Tue, 21 Oct 2025 14:13:52 +0100")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
	<786d6c19-0a13-4e55-8f4b-39b57dd6ea28@gmail.com>
Date: Tue, 21 Oct 2025 11:15:25 -0700
Message-ID: <xmqqplagunnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> It C "char" never refers to a unicode code point so I don't follow the 
> reasoning here. Isn't the reason you want to change from "char" to 
> "uint8_t" to match rust? Given "char" and "uint8_t" are the same width 
> why can't we use "char" in the C struct and "u8" in the rust struct as 
> the two structs would still have the same layout?

And forcing u8 makes sure both sides of the ffi agrees on the
signedness (C "char"'s signedness is implementation defined),
which is a good thing.

I 100% agree that being honest about the motivation to sell this
change would be a good thing to do here.  I do not think "in this
series, I want to match the types used at the interface to be of
Rust's" is a position to be ashamed of ;-)

> I agree with Patrick's comments on this patch - it would be nice to know 
> how you decided where to add casts. Given that rust is going to be 
> optional for at least a year we should take care to leave the C code in 
> good shape with a minimum number of casts.

Thanks.
