Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F36333744
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137885; cv=none; b=kSXqR2FlMQV0lrc0XJoOExQeKT4V/BraIZe210A5zUQQzbvbY2S87YHY4SfrtbW+Vtjtb4LR4A6gJeHWdFG6aqbDjAeoRU9JcBNvV8cW17E8w9lFVRsOflo+5I2lbJ1xnvd0KlLsl1qEveRSBcTJyR/8Kkw6+bH2/Y/cr6IHTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137885; c=relaxed/simple;
	bh=huhgjxkgTOQHbOwYhgJShwkVSEp+BXP+QuxWeXFHISg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVT7ERjGrqq3QJkho2+fW38c0WofxiDhQ2IgjMwyCAEt89Hr4Zlbx7u2q8QvU+XWwdwhFqsrwLwCDoqbupJgZlVpcIMyIPLYKJAEeFOa8co24hy+ZNaVb0NvlN6/OWOkqxuBRPcLBocRLq/xM1utPAyRc/eQ++h2B/5ecQ/frd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q6V1abcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jd/LOXPD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6V1abcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jd/LOXPD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 808AA7A0044;
	Fri, 14 Nov 2025 11:31:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Nov 2025 11:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763137882; x=1763224282; bh=huhgjxkgTO
	QHbOwYhgJShwkVSEp+BXP+QuxWeXFHISg=; b=Q6V1abcMMnbIK5GEv0yDxmHjXl
	Q1mNPCvPNlhZhimfwX1dfupxxLK+t2FPnm4iShgArNRUXOz8VujetoZiwqhq0/Fx
	5Hcb6/ICXjkB+ZLa09sdPabUzIfbXxtXjXhmH2rg1U3TZMz2cYj324EGyrQEG8GM
	CyyEDuxSvVe2kAuAML+o49rWfUIJAgojLhlES9c8jEzzwMorHBnyN3KlmbNQOfnX
	1MMTGdxwWFtBLb26ytGYmMdANgYRfaY8oZkfUy0VdlThi3LCVFxpP4cV2K5yvi81
	IelRK0o0S3E0f1+R+VrkRjEhwlS+yzkV03dVRinx6llBaaA5cCxdnFGOZAdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763137882; x=1763224282; bh=huhgjxkgTOQHbOwYhgJShwkVSEp+BXP+Qux
	WeXFHISg=; b=Jd/LOXPDTguK7eQN7/g5TW1TGzOCo1dt+gR82GJXQaGRKz5oC9P
	9rnu/Not34g08DyNI1w+4aY57RdUAgADYaLPe0oBYRZQEokqdBxDh0Ud+XIl4tq6
	tfsXpya+q27KIWcKHMK5Dm4qyP8zAuQu3Y0BJFLYIGMEwHYYvPp50l7UsTSHoTMu
	I7ZwDlZAHfcN7X+3DXfD482vfhwYZutfuRqFugmy8mDsEajXXZAJYDbo7Nyn84Mt
	Qh6mWqGepGBEmhyaVbHdJjrf69gsL6h9ZOCxxHp5JjcH7W7UD4jSRsSAmNlbi3C4
	OE73Adp05MVfNfFX44fuT8bnGxcHG4cwlqw==
X-ME-Sender: <xms:WVkXaUJnw03U71qRJltH1zJHOI-5afwEGQ9wS380-jTH7mppRwrfJw>
    <xme:WVkXaTM-OaatZodIJd92Ymkn-WWO-chSpm9lAVir9u8kBUpPTf1NV1YXuYYNWTlDC
    w01RTsqhNJsHMFG4q97Aa5z9yiBJE6KR12oXWhCu8kd9IFlK9O7>
X-ME-Received: <xmr:WVkXaa4L0lihoqYsRIr0JJAxQmtosnA9ovakOAWvgLLmi2l6AdjiFfPNIsRhrhmRvBqgj7wt8spBdOGXTT4UO3WhII1PsbqvNDs->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WlkXad5qPqXtPLe5KHZKS3j_Zm2LdTFSR41LUkoCQ2VEL90LJ8PoNg>
    <xmx:WlkXaQGDfaDcUpR4ju2BJaJtSIwKDGL18d4A0oPuhJII9szFztgr8g>
    <xmx:WlkXaVWrx5xalL2NCtw4V0BdR-CQz5L0UUsCPDG7Wuf7nnVnu0ijKg>
    <xmx:WlkXacWhEVCBApBMopv09UA4NpcvcbVHc1FeB3B1TvMYC7HGcZr84Q>
    <xmx:WlkXaYKQlvD-AXUEL679Lb_shdN5P8ud1Rtk049s24zu3F0MVnvybvo7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 11:31:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>
Subject: Re: [PATCH v3 04/10] xdiff: use size_t for xrecord_t.size
In-Reply-To: <CAH=ZcbBNSNqU3i4DSruVixvYzCEs_MxLCvX6D5W7FsXRqpvALw@mail.gmail.com>
	(Ezekiel Newren's message of "Thu, 13 Nov 2025 23:02:16 -0700")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<da2b80ea0be3470cbfe04ff4d39727e6d5921a9a.1762890152.git.gitgitgadget@gmail.com>
	<xmqq346kupzm.fsf@gitster.g>
	<CAH=ZcbBNSNqU3i4DSruVixvYzCEs_MxLCvX6D5W7FsXRqpvALw@mail.gmail.com>
Date: Fri, 14 Nov 2025 08:31:20 -0800
Message-ID: <xmqqecq0k23r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Tue, Nov 11, 2025 at 4:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> ...
> mmbuffer_t holds all of the bytes of the file in memory, so the number
> of lines referenced in mmbuffer_t has to be less than or equal to
> that, which makes the point about long vs size_t moot for this patch
> series.

... because size there is still "long"?

> I don't like the current state that Xdiff is in either. That's why I
> intend to keep going with my xdiff cleanup series.

Great, and we already have seen improvements; an intermediate state,
as we already discussed in this thread, may be noisier with casts
but that cannot be avoided.

> I agree. It's nice to see some clean code in this patch series.

Thanks.
