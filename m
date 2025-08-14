Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47AF319866
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197516; cv=none; b=CHbQl4qX4nu07U8gNg345dLwHBfY8LnweyVir4UVYeKikcLDHFIcYAUUPi3OkckoYsQ1EUFYnKcfGfGnhSNje1gM0dlbw4su7kaCAjoTQ8olFH2IPFfWZ6FeRp2q2fomaJp3/7+5Lrv/loAi9UQh6xLdGoEJRa050zEtjbAyuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197516; c=relaxed/simple;
	bh=zX2hwgAUMEuRbrosjhCk9brnZNoWZ2FST/+K34ika+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHVTE40KgXNP7vgfahhGwvT8+mteBAYu8e/RbkqWo4dOBoBC1+3B+leiz61CNtUqGCumtzATrzkHpyXwIRnQOwyQfvMD4tgSIf/uI2GibfLpgG05mA2bXDrz5WqZpfXovFkPLbcCJfKJ69IOMcekXchSLugsLNBdn0/qdy7yte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4XiJYVp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cD23NMpq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4XiJYVp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cD23NMpq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CCC7DEC00CC;
	Thu, 14 Aug 2025 14:51:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 14:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755197512; x=1755283912; bh=VeubV3aZiW
	saEKEclAO4XJJuVwOwf7WDB1ywuHwIkCs=; b=X4XiJYVpe2oKKL1fUE08v8VSwT
	MfXXXidHIoeTuMRI/O0+wMbqsXFh0MsqWIQUyaHdFi5GYo+l1kU2DZNKp3poHJUY
	WKWxxMFhakj306HKsybanLIFAd2p1uaateMTguECiKPeULhgdJZWCoO2CXfebcNn
	Kh2cDZJCVtHmdjRe19S4jrpwiXk/MZ1qTUpvC+aZKS7CAZKn/nKYc57BOpSIO5p+
	Wq+2FuWbvc+eUpRZt1TJ594YVTtnOdHTFuoLL6dbkcW7nbt/EG5DNPKDstMb+6ld
	xzVHg1cJ0A8O2fbggUyuD3Ps0RpeSk8w2BtNX50eyRwBYpg/RGPvmL7JtGdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755197512; x=1755283912; bh=VeubV3aZiWsaEKEclAO4XJJuVwOwf7WDB1y
	wuHwIkCs=; b=cD23NMpqTkdjvGEATFEao6G8vyKr+lT5S4vOLw6t0g8PfAs196E
	IAIZSfrjUn/oLXJKMQ0PrYf2wSI6ADuTtrNYC4zraY3HvhoFnv2az+HmYeSgWEiX
	+LDh/qhxw2KlV11ouVIWjGRc5S9k+sM+M4ofwa76TaQFDU9tVdU417+T3IhXQd69
	qpPNOEZoRHmsMjXE56gLaNlS8yVQSNIYYwNanTsv5q/iDmgLHQHjBBc4B4y3d63l
	903cHwgTwaJYfC48uNjs1VAptL8VtNnVu2acxZRsVlezGp4itj95Ka64kHB5g9z6
	QpS2Bhh3pqAZvav0/3qB3X5UB5V2xNrfX5Q==
X-ME-Sender: <xms:RzCeaH7I1ensTXSW6qn1OSIPcFQ8Yhlbq-3pu-lLzVFq18KmQBjG8A>
    <xme:RzCeaFjVnbHbEuQHJakM3b2fSfvjeA-3Qx9cJAyGPTGyVG1G5an5d0eJ9FADQiSBX
    dv8QnaiqG_o8QcMcw>
X-ME-Received: <xmr:RzCeaF655WEwEld05hVJpFPNEEW8wCUv1SZDiTwX56MFD5L2Q17vpYOT98TSIr8H6-hAwlR75UNTXf3qB6ZM4HAqhJchZM6AYe64yiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedukeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RzCeaCF8zUk3CerDH898la1MNkEr5NBJbTA4bovTpd3ZloPtvftzpQ>
    <xmx:RzCeaPLqoNOOoeEQuxcbJp4ZsYqxuJDwKguRI9I5GpUvGujEuyl1jA>
    <xmx:RzCeaHiuAupnyNbZMg-SPGN8bX-zIT2P0PMjJacDFN5HUUINXXQ2hQ>
    <xmx:RzCeaFlWMiX562SV8tQo9tSdAH4jhXFy1qwOXxvvJQzrrNxzgG4PgA>
    <xmx:SDCeaOU8tLVG4JUi4FYG3xs03ulg4vsU26DDJyyuJ_3ktthW2A6KJEWz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 14:51:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,
  jn.avila@free.fr
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
In-Reply-To: <CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Aug 2025 14:32:27 -0400")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-4-lucasseikioshiro@gmail.com>
	<CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
	<BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com>
	<CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
Date: Thu, 14 Aug 2025 11:51:50 -0700
Message-ID: <xmqqfrdt3feh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> test_expect_success 'the values are returned in the same order they were requested' '
>>         printf "references.format=files\nlayout.bare=false\n" >expected1 &&
>>         printf "layout.bare=false\nreferences.format=files\n" >expected2 &&
>>         git init --ref-format=files same-order &&
>>         git -C same-order repo info references.format layout.bare >actual1 &&
>>         git -C same-order repo info layout.bare references.format >actual2 &&
>>         test_cmp expected1 actual1 &&
>>         test_cmp expected2 actual2
>> '
>
> Rather than the above, I think a more satisfactory and meaningful test would be:
>
>     test_expect_success 'values returned in order requested' '
>         cat >expect <<-\EOF &&
>         layout.bare=false
>         references.format=files
>         layout.bare=false
>         EOF
>         git init --ref-format=files ordered &&
>         git -C ordered repo info layout.bare references.format
> layout.bare >actual &&
>         test_cmp expect actual
>     '

I do not think the second "layout.bare" should be line-wrapped.

Your point that it is more obvious when the expectations are shown
in HERE-doc may be valid.  Overly long printf with \n indeed is
harder to follow.  Even though there is no reason for a real user to
do so, asking for the same piece of information twice would
demonstrate that there is no deduplication.

I also care about future-proofing, though.  When Git is built with
WITH_BREAKING_CHANGES=YesPlease, this test would break as the
default reference backend will be reftable in that alternate world,
wouldn't it?
