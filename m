Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490932451C0
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897778; cv=none; b=fYSJwjT5ycHVWerjfoxhqfyVXYrnBLFplKY+5FVz0aiv0M0bdiUytfyh+AKTdIZ9SaeJ9s0Fa+0tTeSuHw+3AV3AIELya/DyCXJKY36SgCLoYPrHOTVhJ22dU4aR0ipTlCqa8xOvjHw9oVHPyjxn0xQurG/iIgsocOE3Ejeki4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897778; c=relaxed/simple;
	bh=xYh6wNCUR1NS+t1KjnLlFwlyPDcTJExHBqnZSR5HewA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ljMVacR2KvBB3gms+lH0S7QMGgEltHSuNA77zRiIuXIYrIZ5xV+l0j0+8uqq4n1WkVgOdKKxoTT0upVS+NtRkYr57N1LFaig0Xg8QaHx0Uw7cLLegbJ7FuJTIfYhGpOQmGfeBdw/URlx2Ebp7jbLOMQXsOabLXZ3Wc5TAeMdHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QNkxKJIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WlXGb8zu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QNkxKJIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WlXGb8zu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D099A1140164;
	Wed, 11 Dec 2024 01:16:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 11 Dec 2024 01:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733897774; x=1733984174; bh=w8tDQb4Xhu
	CAfoyfgYbV5sZo6BPNi0aEOCmhHahjuNI=; b=QNkxKJIgO7A10h1cAHI8qNlXY6
	1pM2YZzUgQUfTzyg3fW2o5vVu4+iaaS7DFNZJhI+LfziA5OSrMFKXyiEgcORJQZO
	a7FEddj6OnuQ3CoNzdqwiXAM6EZrpJkHgR3LY3gyjfRs4E0rusyAloz1dL0AfkM3
	qhTrbVStdNpUnFgacrp+lR9pFwPoY6avvA7mb5LfWBjE/17AgJ+teeH5HUBGsVSA
	DWVEq0F4HANySjyGlAHLtynL7gbV3NqRxMOo7KPMFtkHIDNk8uVOnizJSd3+4jez
	5PyUkaTPKHyBb7JiZ3WrIYtnIlFrlVPNv5dt2qKXp8/ygYtTkFeF8AFLbvFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733897774; x=1733984174; bh=w8tDQb4XhuCAfoyfgYbV5sZo6BPNi0aEOCm
	hHahjuNI=; b=WlXGb8zuSoPup5NwQLqbD1i7PdIX/pQBWRJIUXtDpnE1vgbGSox
	2AxET4C+5M/aMIbf+TEWPEWo7NNCUS7woFxGuDUMhiarFan3r4VutXRFWmcmFEEG
	te1KZ8BWEpM+6s4Mu+lsdHkS5iTE8lmSsTTsn6yklm27XT6RxwqtD4OEuiJB+1sK
	ydqFDMG7FraEs3B2MwGKIngc2Eli4HqRKvYWKdoTCq/qmAlzmykcJuFoXJOyfsD5
	TsWE2t0FAPfH5G+BtY9am37yL4Lth77SpQ3Q7i/FvPp8/P4OUO5GpD/04dahoWJb
	1zAvvzmR2Z7uvF87PR+6/Sb+SjRe+t0Ma9g==
X-ME-Sender: <xms:Li5ZZz7iCuP8wYixNYYN2SG4l_-5k2bKwkELdA9tOnXTdJy0B4iiXQ>
    <xme:Li5ZZ44kBBDA9Rq3QdRZbbNepJt6G3FReApuG7lObHDM78x4VCPeGrGv6oOOEJOcs
    69WqebKN3_FuB36aw>
X-ME-Received: <xmr:Li5ZZ6d841hwfVEezeZe8OtXdz7N4NOXDtlaFEoFhoo5O88jhZF-A3jMqAPhyaNW2FLXWWdMCL685cv6xUY1eZDJGQjojcEYbmWUr0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohihvghluggrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptghonhhguggrnh
    hhqhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Li5ZZ0KJsTseURrxeIoGAXfoyuSXN86Djw_E2foM7YZV-p7Nhe71bA>
    <xmx:Li5ZZ3KBBO02AtHgiBHjjeq5VmMtNb-F8xGSL-NCXzw8UQZRnKbe3Q>
    <xmx:Li5ZZ9wlNqnayw2t6c7tqpDQayZZj96Clw6DztNn7ePV1zgwxHW6hw>
    <xmx:Li5ZZzJYf9PNj0C5a-sq996CT6PvOwkOn0qCLii2g3QDWghEKEn2-Q>
    <xmx:Li5ZZ0ruF9wtsqlt27KEEWKp52yl-DvrLlhZkwl71D4flDj4cAmL-Vft>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 01:16:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy E <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>,  =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh
 <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
In-Reply-To: <CAOfFam=_G=EPkw-fCQD___gFc3U7rwnVr_uteKG9-USK8=veRA@mail.gmail.com>
	(Roy E.'s message of "Wed, 11 Dec 2024 08:13:38 +0200")
References: <20241207135201.2536-1-royeldar0@gmail.com>
	<20241209165009.40653-1-royeldar0@gmail.com>
	<xmqq1pygo2ti.fsf@gitster.g>
	<CAOfFamkEmJgUUj8C_TGbjgKs35vSBzNCDpLvK+utqnTtxd5iHQ@mail.gmail.com>
	<xmqqikrrjdds.fsf@gitster.g>
	<CAOfFam=_G=EPkw-fCQD___gFc3U7rwnVr_uteKG9-USK8=veRA@mail.gmail.com>
Date: Wed, 11 Dec 2024 15:16:12 +0900
Message-ID: <xmqqzfl2iw2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roy E <royeldar0@gmail.com> writes:

> All of the options with arguments of git-submodule--helper can be
> passed as "--foo=...",

That part was what I was cautioning about.  I suspect it is true as
it should be using parse-options API but didn't double check myself.

> and spaces (or other misc characters) that
> appear in the option value shouldn't pose any problem whatsoever;

The latter is consistent with what I gave you.

Thanks.

