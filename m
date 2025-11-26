Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AF2FE050
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198853; cv=none; b=ASci5+yVW9gy6MTVDhe0yhDiwzDs0llHWsB4pkV6E//nkB1Edlun2WAAUKy2xbI1CHQOdaVAL3wLcKf4Wkgdrp1hMdobfcUQ8v51P9rGj3oTYjFHwpoEwe1pCsSvWceAnOW6Vj1NQmvgngko8bx2Yontg62eo0B4utJeDftBCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198853; c=relaxed/simple;
	bh=D7etFZipBhi6pTeh6sHu5XQ7aj6tWVVLLhP6DdmV4CU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LylVkIMozep08INx8F7FAUL6kHA6MiyvA6fCVv/47JG46uKsCaPXrogTjTTAGCRMfNhrS71AT2QQhMvxQU6i5k8IWgqX4rVCBbpvxyRZp8lvbF5A/zF20zikDQT5+Wo4hrWoqO1lljNPxuaYAU3vgbF/CDwlFyAF9Fviy2xqwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gAUqZC2j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vlPL/oSM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gAUqZC2j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vlPL/oSM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CEF47A0068;
	Wed, 26 Nov 2025 18:14:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Nov 2025 18:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764198849; x=1764285249; bh=BbraIPkoSZ
	sqS22lTIekLFaDVUW+LiY+recj631k5NA=; b=gAUqZC2jhM71FbRZt86/nRydM5
	KydzbClmJf8vuWlnlgjEsOTtIKzSc2C0EWre4NaBUHE9jxpGHOel2OJKSd186x0F
	KEAvAePnSH8gcikmCxvHo0FnWiMCmt1IeSo/lgTS0xHm+b5ctZFK2H1hHspnb4c0
	uNfbKgpzhlhRyPMNE62e/J154gSALJEVlBhZU7K044AnZ33cO8JEoY3RrLpDJpCH
	7pn3j9kR4GVUx6aoDxSDvOIl5d31dXpepTB0jVp1VMv1bMxyizpe7vqxwcEOI1xH
	iMV/knV6zX9mRM2STd+mc5+mb+GMOOnonJSpnjY7Y9B/2YTEo5ke39BGE8fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764198849; x=1764285249; bh=BbraIPkoSZsqS22lTIekLFaDVUW+LiY+rec
	j631k5NA=; b=vlPL/oSMZXlL8VjEbULg/trQV7Po92cXSWIIeuW5LxT9Kaxm+TS
	MVIg5egZRfMxg/Qah1kqnIJ5lriBW6C63dKMqlXIeEaz0vaRZJ1WOOAXRDiSrh/B
	NGtCNqSo87UFHrjR5cnfUd1Cx57eH19RqQNeGzwUWn6Ia8XEHuCK9uppDiC/y768
	Af3ynZ+SrptQhX0XnDX4UH4HynajuLhgaIMlq2o43Yh1ksgibIDi/KYUjoF0Hvb6
	tBLlyxCi+T9lK5yD56nVooHL+bvJYU36FgPtLjGVLlsu0MoKvGLX2MP2A6qinDSm
	naCJ6Phd6jSqD5sh0R6Va+SAgcaRQRMdxZw==
X-ME-Sender: <xms:v4knaUTYKrICVMrm-D1Ge1pYhNgfzQVimnRWDsTjJiaqUKqgDqQEBw>
    <xme:v4knaW90u-FVO0lbBqjtOE9NxudD2KN5IWmHRQqAhRWyTwAykO4yraStah-c-ZXpL
    mBc5627jhNthsZXea1-SulMUAxoawExZAecyE_yji6q2Kl5c13iAg>
X-ME-Received: <xmr:v4knaVPVKj_etWSlEQsBmv2o6nU8KpeRI69Kt0ebIDKp9jbJyXecwe8edfxBVVt3luJXpJrZGCoHmUZ1E-VYVsoxwu3H642tO8dN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprh
    ihsggrkhdrrgdrvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:v4knaXilh6FS93GbeNzNsYLBcez8CAFxxWnBAxhQz0kGdJk_MC5drw>
    <xmx:v4knaYnXhiLEP8vj5PCTf4V1PavVQ9ADhvoBzDhizMvEfoRndkBkNQ>
    <xmx:v4knaUNbO5rPdoku1OzqDk3ZNY0nwLV8T563eVQFU6CfZ8GqW-mw5w>
    <xmx:v4knabGew33ZhGnEdOFgfadllIzFWw9EpFDYBMftuRNg9mOO3F468w>
    <xmx:wYknabDBRGWd-cKn0L15FO-8KjQNlk_qAGWyGWlva2BZdwdavJvT7vtI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 18:14:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <CABPp-BHcCX8LDccRoarsqNO=YVr7a8gp67oc87b7taAmjch4dQ@mail.gmail.com>
	(Elijah Newren's message of "Wed, 26 Nov 2025 15:06:19 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
	<CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
	<xmqq3460ocv7.fsf@gitster.g> <xmqq3460mr3c.fsf@gitster.g>
	<CABPp-BHcCX8LDccRoarsqNO=YVr7a8gp67oc87b7taAmjch4dQ@mail.gmail.com>
Date: Wed, 26 Nov 2025 15:14:06 -0800
Message-ID: <xmqqy0nsl741.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> == Example command lines from your proposal ==
>
>    git replay --rebase main feature~3..feature
>
> This command to me would suggest that main is being rebased, but it
> isn't -- it rebases feature~3..feature onto main while updating
> feature to point at the result.  I find the "--rebase main" part of
> this command line confusing.
>
>    git replay --cherry-pick main feature~3..feature
>
> This command to me would suggest that main is being cherry-picked, but
> it isn't -- it cherry-picks feature~3..feature onto main while
> updating main to point at the result.  Again, I find the
> "--cherry-pick main" part of this command line confusing.

That only tells us that if you want to help users by limiting the
vocabulary to a single set (i.e. both command names, and mode names
used in replay), you'd need to make sure you have the order of
<branch> and <range> given to the replay command in logical order,
in line with the option name, no?  Of course, if you want to say
"cherry-pick", cherry-picked range would have to come near the
option flag that says "cherry-pick", naturally.
