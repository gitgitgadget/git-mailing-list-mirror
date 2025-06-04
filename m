Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C817AE11
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010961; cv=none; b=omLZwEVQZb/U/mnrvHbcYQt/E/H7sbLy4uhZM13y2HWiVbeH2HbyE/GVrIk6kGeU9IYQev1spTRWN8xkMB+Uyf0JuC2hkQey7Kwlqbk2mW8t6u/m4UtCWp8GvZDnqHyrIkMeYFbpaVDKMARmpdb8FKATm/++fqcQj24HRzumBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010961; c=relaxed/simple;
	bh=WCJIUOQxEUwni6J0PLL+/x7FxXXEx1CAtH/P5oGEGw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uCBMmstHwNgRt06BHM3PiMNDfpl4JA6qCSddhlch7j8R2VW6wLH+SfmMU3n8JQanoZQkcpVAp37gbE0p0SBxWX3xKOIhvVBx62WxD02ciCnpN7e+fxbNxaSMOS4aGrKnCUllCgmUPfqqaEPqz7p2WNDVA/z3SzLpNqD5GbXJ3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UBi3vbRN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ak3kyZVU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UBi3vbRN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ak3kyZVU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C8CA1140174;
	Wed,  4 Jun 2025 00:22:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 04 Jun 2025 00:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749010957; x=1749097357; bh=GrWlPt3kud
	DO8pjo/wl53Xsb/qjogM6PlEfkeZWQmyc=; b=UBi3vbRNfmuHmeeLKPWQeCwiHU
	CL6Kdq/UdysZGf7drOWnXloy09TdyX32qH3oGnBGN2ypWQPbRhx8NAthiNywCC2D
	BGTMu3yFW1xRb4SmCZ41nJFyIos4DqASNgRwtoTFoyWPWedA3v4F7xQY6ysK1rKt
	EtoUrwvwJ2V+Sc/rp572TpT5V1pzN/MFIt+EhtM5SV7a9LVs4Dlw3mk4KIvtkvhO
	wDTwZQPL4biDgLuPkd9lbUQtFmhcI0me3QBaUgFB55wnLWzk4l6BVp+a1oiRYtOF
	T0jv0HgJ/S5aWnikKxUrKCnZBHR8Y9+1l9QdCD2hplQd/RqLMxJiUrpgFPaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749010957; x=1749097357; bh=GrWlPt3kudDO8pjo/wl53Xsb/qjogM6PlEf
	keZWQmyc=; b=Ak3kyZVU4R8R1Lo+0xJ6LhHC+r2/dQdyRK18PcPMZWhbEItkDU4
	76bOc/muYurrsJ+TpN10I4B0juLe1I3NfCC7m+5zr9y+RBEdoNILve+Ju9SiOYW4
	Fi8TfHuKipQgjyhto77u8lDYcYnRQp8I1ixEHTZ59Ol+Sht60kzS/9pnpDHsxjbd
	AAtS/enwP7yKCf91kTtNnUfXAiibSjWxh+vLwTBlp1ODY5+fOPXJKkB5+zc42pSi
	TeBJgxjSbUpILaFfaV1wVDSA+h9kvtWdgUaewlIte0tqnjz6t/ix35kL4clJgNH5
	NGRjeJ6+fkq7sZRuI3JJKyiLczAlX3PTNlA==
X-ME-Sender: <xms:Dco_aGw1YAgPIzvMVw8v677Z4CVJczSnb_XNs76GVACap8BWt4Dg_w>
    <xme:Dco_aCTjezDS_-_4FLP6eqrlHNuF1zQlAsLIIQWa8-GJrwIj5elhWbmAoYTKQF8wv
    h5zW4FKuvwhDvWnyQ>
X-ME-Received: <xmr:Dco_aIVmYod75mRI7zb31q481yYllIHEc1KCOqWv7rsSyiQF3pgAkGl4osXLiHH-oYOzHlUAd5ma6-my30tJ9-CDJnc81emk1jik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Dco_aMiQgCpVujKf-hcooS32dsYEZynqxvh-7BDQ9jCG2y0e020QAg>
    <xmx:Dco_aIAZdb91eeQ_LcUcACIN3DrATXnZ1xegYOUC-oKX2YIXsCppGA>
    <xmx:Dco_aNJ3q7wdA_Zk1D4GaQOOkz3Lfg9ygbmfBCbLJpMAbMQTPjkkjA>
    <xmx:Dco_aPBB3mbl_RCtUHszIb3ozL1IC0gDRqqvx9GVGO6iWAAX-wj_GA>
    <xmx:Dco_aN8jMQmnLKWPP9o7gveFO7i_SJm1ZXfR1tLKA7coNh65809Q9xck>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 00:22:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v7 2/2] submodule: skip redundant active entries when
 pattern covers path
In-Reply-To: <CA+rGoLfpj2tepMSWLfNeVkwXfzHZB7Vc8_GJ+_=bWkQSzZ+Sjg@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Thu, 29 May 2025 09:53:23 +0530")
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
	<20250524073628.58944-3-jayatheerthkulkarni2005@gmail.com>
	<xmqqcyburu6z.fsf@gitster.g>
	<CA+rGoLfpj2tepMSWLfNeVkwXfzHZB7Vc8_GJ+_=bWkQSzZ+Sjg@mail.gmail.com>
Date: Tue, 03 Jun 2025 21:22:35 -0700
Message-ID: <xmqqh60wf850.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

>> The new helper is a maintenance burden to keep in sync with
>> submodule.c:is_tree_submodule_active(); if we really want to go this
>> route, the patch should extract that "ah, submodule.active is set so
>> let's turn it into pathspec and see if the path matches" part of the
>> logic to make sure the logic is shared.  But I am wondering if we
>> can do this without any new helper.
>
> I've actually done something like this, but I've wrapped the core logic within
> the if else after checking [1]

I do not think I follow what you want to say here.  Care to rephrase?

>> I.e.  Can we replace this if() condition with something like this?
>>
>>         /*
>>          * Explicitly set 'submodule.<name>.active' only if it is not
>>          * 'active' due to other reasons.
>>          */
>>         if (!is_submodule_active(the_repository, add_data->sm_path)) {
>>
>> That is, we ask if the submodule is already active (we are before
>> adding submodule.<name>.active for this thing---if may be active due
>> to submodule.active or submodule.<name>.url) and enter the block
>> only when it is not yet.
>>
>> That way, this codepath does not have to worry about the exact logic
>> that determines if a submodule is 'active' even when its .active
>> configuration variable is not set.
>>
>> >               key = xstrfmt("submodule.%s.active", add_data->sm_name);
>> >               git_config_set_gently(key, "true");
>> >               free(key);
>
>
> I've done the exact thing in a bit different way

I am confused again, as this reads as if it is an oxymoron --- did
you write the exactly the same thing as suggested above, or did you
write something different?

