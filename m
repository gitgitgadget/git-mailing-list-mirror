Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8521D7E5B
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074434; cv=none; b=FO3uyG9p3QtPE3fasz9FmN9ZNXLH0wipJxoBcAbKOtBkMj1aTEXEac30WAn9oZ3UGA4OPUrjhx3H92kuoCthVVkT/rsfJlPO4i8DP56EttBIiF2QdMFd2duTibKiZ5Iq41nUFLCgKoeMFEyi2bFFhHKk3GYh6QP/j2+X8dEbGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074434; c=relaxed/simple;
	bh=CMWl7HEbVDFCpmX5f/SxVphaU2j/kUX4NXTaxXHa7Ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jVHzf+Uw+XVppElUSzizbZ0BOZBj7/WFHOJXDx64aWFwXl3uI+BhCLREAqa6CA5eUP8nzL+TVGyYuMWO+kBPFBpA3gSTXZFKkHiw7ZcC/OqM544BvmQno79OrUHKgUCxhP5arkd8hds+opdz/jx5VNNp0hkYuYzO8sCxC5d1clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GvY1Hnzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJf1BeFp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GvY1Hnzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJf1BeFp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B027113801E0;
	Mon, 12 May 2025 14:27:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 14:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747074430; x=1747160830; bh=rFC0UeI052
	llS5BWI3itJhHa0fjwIz1wqbhfIVAJE2Q=; b=GvY1HnzmCEM7PCz2T7CwAGZmvq
	4WaXuZcJJCnvFcsBr70x2S5va7pg9/6CA+y6G4g1uZImj5cdjUlc2mPrTVJY1EpL
	0Bthjf11Sd4GOYfXuniknNO4wAL2s9TaujU4Phb6bj0/CEABbpeis4Ru26MFCaQ0
	MQl+7Ee/uYv6ctLkLMX61T5wQeSMO+PgM3JMKgVq9VLicg06siKwR6BN28P3X41q
	9BDMMmwtSeg5L7uGGK9HVXdPLYsB4tIPBfFxorFCN3pMIqMrUkP3LZqfnHa4VBf1
	XPSO7UhQeqHm5KL2QoLpspXyLVqwoUwCNgqbxMBKwUGvz0v5SmUgAuIholGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747074430; x=1747160830; bh=rFC0UeI052llS5BWI3itJhHa0fjwIz1wqbh
	fIVAJE2Q=; b=rJf1BeFpWAy755INyPdqqDPiAQ9kZvUkQFjPxHbzeVbv67JNAv3
	GEDSWOq0pu5kp0brZlI//3uY8WeijDjr/L1YzkZlR6wfm0SyKjQGlqstFPtWfrxp
	zhec8mA+2RDNJ7xse58ZfdtFW4DS6pwiV/SzxlSIJL0bbarJrFwN9PByZmf2omao
	+z9G6FzAUDc/XHcY2jVmqRMGqGDB9xqUi7uR55QzjAHXKQbokI+YrTZPmcQaESoe
	t0f829S9gYPqgAFO2ol3S3JLEae798KV/E+xvaXgGV19W++U0O5Nnolir4xrzZQ5
	XKPxoumusuFFIhFMuYRT+Ue/oWKfiTE7nzg==
X-ME-Sender: <xms:fj0iaPPEisS6sTmEHx1N5w0iCYxpjOjMK3LdUeD1SIn3rL5v0uanHg>
    <xme:fj0iaJ9JAu4evkH1oG1zwvGHOCY4AeDmsdysn3pKoYL6gMJIHbZEl_zfTSAjePYW2
    eSyot6_9mIAsMcl0g>
X-ME-Received: <xmr:fj0iaOSKEh3YlYLvJL4hMZLe8wH27I8xcpgDe0hu82eFJV86G_uM9rmoZJ-X7w1PGA-E1fVg0J14tO5W90fmaoO-Jy-BS_OZDcnqKzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fj0iaDtnwRBt_qvB3UWk6OQEtk9rk6Ug7kcY_q9Nf4e-cg9te-p6TQ>
    <xmx:fj0iaHe6v3U7pjlJmTU8Og0xESy8Wr8xFc0BJs6ROJd0BcruAmuF5w>
    <xmx:fj0iaP3qw_yCkbv3nqVRUrdISSIv_AhFQfQlTyJQng9E8h5ggsXWMA>
    <xmx:fj0iaD_tYx7J-90cOP56RPf9YtqQdxqsM6OUb6oz3AL8NBUueufSFg>
    <xmx:fj0iaKLwDjHpsf9oUMH61SWU7-tNXFs7p3_1qohtHoNPxzkWdeKA_j0q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 14:27:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] merge-tree: add new --mergeability-only option
In-Reply-To: <CABPp-BEJrkq4A715pV6WY-t-M205oheNABdGHy6HLmrxhNrk+g@mail.gmail.com>
	(Elijah Newren's message of "Mon, 12 May 2025 10:41:01 -0700")
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
	<xmqqplgdu5ex.fsf@gitster.g>
	<CABPp-BEJrkq4A715pV6WY-t-M205oheNABdGHy6HLmrxhNrk+g@mail.gmail.com>
Date: Mon, 12 May 2025 11:27:08 -0700
Message-ID: <xmqqldr1sn0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> I thought about that, but I was worried that folks would expect
> "--dry-run" to not make any changes.  This mode does not prevent
> writing objects to the object store, it merely avoids it in the "outer
> layer" of the merge.

I think we have already precedence to call something that creates
new objects in the object database, as long as the resulting objects
are not made reachable ("git fetch --dry-run" probably falls into
that category).  The idea is that it does not make a change that is
"observable" by end-users (and what "gc" sees is not part of what
the users would be observaing).

We have "--check" (in "git apply"), which is an exact counterpart in
the patch based workflow to this thing.  It reads

	Instead of applying the patch, see if the patch is
	applicable to the current working tree and/or the index
	file and detects errors.  Turns off "apply".

I feel that `apply --check` should have been `apply --dry-run`, so I
would not recommend calling it `--check` for `merge-tree`, though.

Thanks.
