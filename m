Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3202253B2
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313887; cv=none; b=EOVoO8vUyD65y+vGC+Ov7jzxc5Ptz9ftwQOGbFVynK2lIIgWuD9qwh1Nd0gUxj+PdnGGBnkVwPOr1K/iNgBrIh3fzwUV355CGsGkPpTDJF3i0t1CoYU7IEGoIfwVnaKwvHHqZJfeHJBEsx7PGQSv3W+5afPy4GOB7wWxgrgEFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313887; c=relaxed/simple;
	bh=vqUE5sDqcKxgpvqKb5uX++TzgHsup5f/zt3ttpgioKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErKRZJL6Z9V1KND4OcXtbBpBYUabdkCd0kT5flq5Ub2zyOld9GBPzVWOaF3H30R0cRZk8sQzzDpn7J6AfnvjJDeaTLfGDqguDxGY4euU903H4JSOZtVqJMQviSdCOenA8g7TiETmwIt4P/Gam0/rQGMR1WZYRFbQe2h2L+sXBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sp7rBU2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PPWHIM3a; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sp7rBU2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PPWHIM3a"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A16B2540116;
	Thu, 15 May 2025 08:58:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 08:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747313884; x=1747400284; bh=VAlkFfT7/a
	xCD8x502bE2Yx3eKeeCNkL0Qo00heLqbw=; b=Sp7rBU2cBcIOWXdYVzasKADdI3
	1c7cQGU+8RY+CJI4BT3nlIMCQMFzp+Ux6mytXtS/nOVp1qBXD8+akuNr30qPdOP9
	Qg/qwVoExpBT0YtZef+Hqo5CCG9CgGC4XYyTyIKmIX2+UvmlFcC1s/biFyC5kn+T
	P6nPCgseMBfxd+1L/1CNdE4jycjYJ/BANOulsNsuUuqY001fAUCwpKzfb8o7kcQ+
	G6HQyIvHacw0maP6xDDVB9AHUElXSXYCmTY2IL24sXZN5BeVeKcIUS9JXJpdoqd1
	O0unB0WeP8VGiiws7qrj5cgaO+dKfcQwfj9tQGKWWaiZZvKcUd/nlomjstzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747313884; x=1747400284; bh=VAlkFfT7/axCD8x502bE2Yx3eKeeCNkL0Qo
	00heLqbw=; b=PPWHIM3aL8tZEFduWxBiJUQyESsgTmknhRuzCbEUgi/1dPWx0Jt
	JTLcSTTnMRE5t9v70eca4xr+X99UpI/me1x+OUBoGcET9h+9TWtEHdfLBV2R4LcA
	pSZU+21+q4IJHCXQsd8+PjtK5t7ep1tP82aovVdojcHXncIIoqI0DPKtE3Cb7u11
	8qWTyWfqtnaFoBCK29fAK7uDDjyDmcHOty8FECtpUuLqkSwAThPbXf1k+uttRtu7
	Edsp68WAqB9l3cFa793PsRj2u5N2pJd05XljwESuWPPqz5WOSA4/hf5QqRLjWPoX
	zHHemMR8F3uEHZu90B352ouO21BxS2TkpSQ==
X-ME-Sender: <xms:2-QlaHmM2AZnR2cSX6n7ZHrCXPRpbo6-9rvNV1tSMyXM2wHt3DJncA>
    <xme:2-QlaK2h6i1yV9x-ELItSLW4bicOXQh8GExOERIhahaWg2-wMsZR7hQ1iclS2OvKH
    fVSwHUroQhPS7bMwg>
X-ME-Received: <xmr:2-QlaNqcBGMcqEYjuqB024gMOVyJ7b0vFkHSIzJKrvajgN7wFEkZ2zCYdBKzXFrQkcGhTJIrNsyJtELniQKKel8lvapH6tVYRGA37cI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2-QlaPkQvjdbtVS4SK1DKI9w1Pr9FEVjYxB0koMwrggdrbEZVuDLUA>
    <xmx:2-QlaF20_E6S_X6e5tcwtudESfzZ6JO8Lkj0sQHFfnfTsXWjZVWOxQ>
    <xmx:2-QlaOv1RhgGefYedCCNXEsXbFRrd6righeBX_PjNQIslUC37GS_0Q>
    <xmx:2-QlaJVoaQiX994QwBeZ_AwB3hgNt6mmidasZwip5bCd3cDaCCy_3w>
    <xmx:3OQlaADtRBz-ittWeMmHcE0iaMwUOXMKuXOMnTl6twrlGEGTax1Lmttr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 08:58:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH v2 3/4] add-patch: respect diff.context configuration
In-Reply-To: <d878fe4d-163d-415d-846f-f5541cacb22a@gmail.com> (Phillip Wood's
	message of "Wed, 14 May 2025 16:13:11 +0100")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<f16d3de86110ee61599459a25764248b52883b52.1746884789.git.gitgitgadget@gmail.com>
	<f00cdfa1-343a-4fa0-bce5-e06d1ed62c22@gmail.com>
	<xmqqzffgh5rf.fsf@gitster.g>
	<d878fe4d-163d-415d-846f-f5541cacb22a@gmail.com>
Date: Thu, 15 May 2025 05:58:02 -0700
Message-ID: <xmqqh61m3uat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 13/05/2025 16:47, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> On 10/05/2025 14:46, Leon Michalak via GitGitGadget wrote:
>>>
>>>> @@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>>>>    	repo_config_get_string(r, "diff.algorithm",
>>>>    			       &s->interactive_diff_algorithm);
>>>>    +	if (!repo_config_get_int(r, "diff.context", &context)) {
>>>> +		if (context < 0)
>>>> +			die(_("%s cannot be negative"), "diff.context");
>>>> +		else
>>>> +			s->context = context;
>>>> +	};
>>>> +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
>>>> +		if (interhunkcontext < 0)
>>>> +			die(_("%s cannot be negative"), "diff.interHunkContext");
>>>> +		else
>>>> +			s->interhunkcontext = interhunkcontext;
>>>> +	};
>>>
>>> Thanks for changing this. This iteration of the code changes looks good
>> Lose the ';' (semicolon) after closing {brace}s.
>> This is C; you do not need an empty statement after a {block}.
>
> Oh well spotted, I'd missed that

Heh, with enough number of eyeballs, all the bugs are shallow.
