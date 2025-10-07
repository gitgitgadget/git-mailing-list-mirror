Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EC13FEE
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855098; cv=none; b=U18UPGR+KwEK0nCaHAiMExsMCDE2uAvkPxBDpJLaToZzAlcuO0YJPV9H0WIbfhQhEqYnk+D0dhy3AVcfWEGjsftJxzuiKYNzm6da1iAInbdZb2okpTv67Ar4jb8MS6zwli2vFRrCfP0gwbB/SqtmFYCMHwOglOiA0/72VHw9XiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855098; c=relaxed/simple;
	bh=TLWib6UbDUh2Cd9xQIQDXQuoweT8cLwi38IQ7FyEcJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enakS7ucXCxPhwo/cdEcbcl3IyfSmcCv0KVh4kFmkOYaMYMajVT96fkNETo6hdPjRmRBNgW+icUZCIfGlOT6wOxFDmzptkYWuMr+/xemQErgo5MjIZt1k2vDsSNqfD2NorivzNSfpuiaRVSu9OaJvuQ7tK77V4mfzPrU9gDeCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=asSGQCxE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AAF/S+yu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="asSGQCxE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AAF/S+yu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DDDB7A01D2;
	Tue,  7 Oct 2025 12:38:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 12:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759855094; x=1759941494; bh=BvQoPMPFvA
	2aPrbTfbbCcJROb25+l5qZtS4khakJCCU=; b=asSGQCxE96xDWuZHcksaLEW6bv
	QaNYKaQafuyggEomdDRCmvP6pMfdcDRu4WqlQzmR4S+Vc2AE3W+6seCBzrGelJQO
	+9ddDs+A87M0rAdzAZ7zWe8DWpBnRjEoWC/BD3HRqEmcQO/lDM7WcesC1aUHD5vE
	KmKezlN0nk2ZhgKzem0vGelwDKVGED+6tRvUtUrVhKmPYthbSfijI1/7DDROh9+W
	LV+Ew3pKYynNctez0I09PqzlsJJ4hrlmaxuovhKZK0JWdmgh/XGT1GZT8EmRdj+8
	8uTT5iJGIbPzga9gJjAdvbJ9YUSlX6Vd/Qa+ms68VZZpuxRYGsWN9myuDVBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759855094; x=1759941494; bh=BvQoPMPFvA2aPrbTfbbCcJROb25+l5qZtS4
	khakJCCU=; b=AAF/S+yuvi0HeAkqJi/pvIgvsVRjl0ncnBgSAcZJIytVeCxuEGY
	lFIvzLtlNTeyNHabeccmEG9jmKErxncWEs+0C7hkxJxVWsntyMTPTG9pobjUtSqP
	B2ddfc1NoHBjaBSdqmbe584qPfaHI3x7eb0AnuyKB+Eq6hVVGZON0M8l1AevkV5z
	D35NeERQ/PLy9X9m2siGYWNacsW/98wC5eqDKQ5/BMoICkBNGAycMzwsbRdbuzWq
	G5qJwzqn5NPs83v/hNhycyiD2+Y7ouvVGp0670rhjX6mA12xdPQyUL1gorjEQAbq
	sbknuyYR0nLxvttXDLxeE+kiFOo5piNbN4Q==
X-ME-Sender: <xms:9kHlaMW_vfY3A69p7-8LEFBfjdRnbffsR52dPBKuZhjG6tupoQAruw>
    <xme:9kHlaHeL3kN_1oN2_hdYuJrisjQATzfZgdAL-q1LNX5w_mx2rRxWm1DYbJUvzX38h
    yapgyVkQu7F6-PgaoNnCCyQiemKmKf_IBhsWER1IovPWhftRyRS>
X-ME-Received: <xmr:9kHlaIve1D2UAMKRtyDuSPX_XA6n4FXVybBcJDBQIq26TAmMFDV3OCArnhDs1PIbREqmMPcCZ-zeoGyviWc6ZD2p5ljKQ6gUCVn1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:9kHlaG_NWMuVHQPQDqE1E-kfmvjQS5q79Dd4NMW7KguBUFoaoEk7mA>
    <xmx:9kHlaD3vyjYNd0lRd8VWIMqRZDRLJq7KTUn5xuvjCVPE6wh4bVzLpQ>
    <xmx:9kHlaLAEkR3x50srrKU7jPsZH_QoXdTne-aeikPEqMEKgkC5BataiQ>
    <xmx:9kHlaPdmbinRcdScMy9LKfOMsz9_WLlICMBjZCyzqOlto_0naO0B-A>
    <xmx:9kHlaGOwpS_JYABFxBzbYus9C3i_gHQAtn9ZDlvrbJXfj-_keoJ_eEx7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 12:38:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Julia
 Evans" <julia@jvns.ca>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
In-Reply-To: <93b30d1e-7d49-44cf-b29b-69e8055bccbc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 07 Oct 2025 14:37:26 +0200")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
	<xmqqy0por9g7.fsf@gitster.g>
	<93b30d1e-7d49-44cf-b29b-69e8055bccbc@app.fastmail.com>
Date: Tue, 07 Oct 2025 09:38:13 -0700
Message-ID: <xmqqbjmillai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Oct 6, 2025, at 05:32, Junio C Hamano wrote:
>> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +MAN7_TXT += gitdatamodel.adoc
>>>  MAN7_TXT += gitdiffcore.adoc
>>> ...
>>> +gitdatamodel(7)
>>> +===============
>>> +
>>> +NAME
>>> +----
>>> +gitdatamodel - Git's core data model
>>> +
>>> +DESCRIPTION
>>> +-----------
>>
>> The above causes doc-lint to barf.
>>[snip]
>> You can check locally with "make check-docs" without waiting for my
>> integration cycle to push to GitHub CI.
>
> I think you meant `make lint-docs` for both of these.

The former is a typo for "causes lint-docs to barf", but I did mean
"make check-docs" as the recipe for local checking.

You could also do "make -C Documentation lint-docs", but that is a
lot more to type ;-).

Thanks.
