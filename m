Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CD22F75E
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188350; cv=none; b=a7hypue7gVXEH5ugqqsq3+TSu3h7EtZkQ+maDC2f8hMM/vUl2RxZVHXI4RdkUOIs7u7+OzQM33EWQPfCGHT461SgWp2TtsIyJaebzijnZOOlDxn6J46oWqcybzzoiYgsmK0unc99XfXwAvB3Jk4f42hVP+PPBrjbVPX8zvAhiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188350; c=relaxed/simple;
	bh=r/8XtxVYllhdJz35tmVI1msQGKQhnqHr5dmagUrCfAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GN0KwVhM38hpNI+a9zEUkDkxz97SxsbBAkEotPIy8I2QkFCEX+OwoSgXO+iDc29xTwum3+PGpMECLZNeaaPqpsWsU/Xur7cUI6Y3DHoP1gp7CL29dLWYMXQTWEPW1xuKXNAKwp9ERb8sQBtOMf3Ad27EFcVi0UY4dd4JGdzkPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y6dQfFBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tg7m0kyH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y6dQfFBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tg7m0kyH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD9F47A0030;
	Fri, 23 Jan 2026 12:12:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 23 Jan 2026 12:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769188348; x=1769274748; bh=+wzo43oveh
	m8lcvgAfvBLNrVdBvGjxDHVWnSBPxB2SY=; b=Y6dQfFBYDhxaN1BOEAfCuYURz+
	u8qtyKWFcIYKLTKuTup2d1COteM2A3ulCIo2pPcqniU2CiYmpIeV21YW2rs9n97h
	wORbOr2mwg3HYJsp6Rs/1PjOEflY2h1YH8b1kBMUPCTNQ9s+cuXZAJnHSqMd3a0z
	ZIKoLvG0UUPBU3MGfcMwRpccdOmhEo/9cLteuLV5Iqmi1UGdkw8y/rZFtvxkxPbL
	xpKULvyXRwl9XCODoYM0PyO0TbJvJdSnwp+nrsEuWioyurx85VVJhtqJR9YidfA+
	llyRYblKl5i/pw9DHz2XI83lQumYG5QeOmDm1UUNuxUDUbSaWnumLdj1S7iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769188348; x=1769274748; bh=+wzo43ovehm8lcvgAfvBLNrVdBvGjxDHVWn
	SBPxB2SY=; b=Tg7m0kyHgAbthclj09qeT9I1Usiw/8HK658EmJ7dvaWKZvtx/ZL
	v7nymNfk7R0kRRiK+Dfr4H0jPTa0Dfe6kO5PXQWvFBNX4tq0u3mKYAYRk4rDaI0j
	q1oXlktEpRk6bpUjjZ2jlCULyvRwu6uhslHz9q1kArepVx10o+o+w0PCyFYI/pgH
	9awcZgqhyPrQbC7tzqsZI5etzit60T2ysv2FX7S0T6RPhhB44wf2j918S9+u/MQ3
	y6sPHimMH4Q3KKSrFMyQpj97fXznS6Xj3XbTbPaDb79dBeEwLdwxbo5y/g1qjazk
	+hPgwK39HlF2ZjWXQyuo5d0aElMGjMHWPDQ==
X-ME-Sender: <xms:_KtzaU19FDm7kAi0ml76JXPOD3o5V46ja7A5VOBaSXOjYV2-hBGAxg>
    <xme:_KtzaSzJufYfKhG3xApl-FC2qrhkUdxXZpTwLtPNgcsauwffVG3W8UieUO-THxwk0
    qvSCu3m4six-JwWRF3_MHPg-bUQjvDzlwZqLUKiuBo1heC5rCNLsTc>
X-ME-Received: <xmr:_KtzaWuKK91umw_NjEwo1Isq_QKsE3v3LIFSVVWRuHoMx-5kI_WShpBOTPf4A1Sxm_AMR7YKbfZkEjfkvGuvGrkEWYH1AcmEJ9olTR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_KtzaUyBd5Kf8ynBaa-iyR4aZj2Pttey8_ItQ6iyKnIJAr8ujYPzvA>
    <xmx:_KtzaZAkkjtOWcy_CqnY5WyZVpSGmrIa-pL5qCnEjhFPZKr8ZVyt0A>
    <xmx:_KtzaScQA84wP4BpggMqNW9zN32oXGMF2DEhTVCC8BC19YVJsk2BMQ>
    <xmx:_KtzaTlhzTtLrxjRtlPTGKBFxQUnNUvahbZfQn3zMrP-xL8e45xX_Q>
    <xmx:_KtzaRRUr_MFkHfFg47sAaOeM2dqIZYC-RWTP9AqdyM_rUpWuujTdMlj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:12:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v4 4/4] last-modified: verify revision argument is a
 commit-ish
In-Reply-To: <20260123-toon-last-modified-tree-v4-4-86bf97bad4e2@iotcl.com>
	(Toon Claes's message of "Fri, 23 Jan 2026 15:33:04 +0100")
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
	<20260123-toon-last-modified-tree-v4-4-86bf97bad4e2@iotcl.com>
Date: Fri, 23 Jan 2026 09:12:26 -0800
Message-ID: <xmqqcy30i77p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
>
>     git last-modified HEAD^{tree}
>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
>
> Fix this error by verifying the parsed revision is a commit-ish.

Is it "the parsed revision", or what the command line argument given
to the program?  I am wondering if it is easier to understand to
rephrase this to something like "... by ensuring that the given
revision peels to a commit".

> +		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
> +			ret = error(_("revision argument '%s' is a %s, not a commit-ish"), obj->name, type_name(obj->item->type));
> +			goto out;
> +		}
> +
>  		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>  			      &obj->item->oid, "", &diffopt);
>  		diff_flush(&diffopt);

It is somewhat unsatisfying that the result of peeling is discarded
and diff_tree_oid() is forced to peel it down to tree again, but I
do not think of a better way offhand.

