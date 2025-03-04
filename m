Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C81F4E27
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127629; cv=none; b=fnumO4gXDYHroSOjYHqqzisz8tvhAGo3e99lYJDtPpeI2DzMcG1F1Q/+9yE4fAmqnHJIcBW7XwR5g5iPiA/loVCuf5SFuG8VJDJBZ8UR+LjVHCUpPsYyDnMWBCM6t17SIWZoWQXLx/WlBZtcgHnJe5ouUk2e7syzzh8+Ma7DD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127629; c=relaxed/simple;
	bh=mlz5ve3BTm8vkOaXj2m8R9zVM3nHWBuMynHxq/5CZX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0Z3+3iwEg1yOaBPxNyQbl69iLngJfp5dWNPeGn2mNTqyo/phNOcqXbHdLLTRUNI8D2JTXRTZJTwZnj1IpzKAmCRoeP1CndVnt8P9T+9hhihtvK0gf6Zj0uCLkdc4CTr6eqg9SpDF37PeU0k1dD3KeId3EF5+KnBgW52GEDJRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mVQDRp8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evNNYq8a; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVQDRp8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evNNYq8a"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8683F114019B;
	Tue,  4 Mar 2025 17:33:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 17:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741127626; x=1741214026; bh=p9tHWLSiGq
	3tjut9KUpyPifvkMdqJJGiHAM6DGjZXfg=; b=mVQDRp8hntvdo+zNaKWWXT539m
	ArYy4J7XhCr0/2Qh5dK2CDBztuFJaCSo8WZPdk0WKRweUXf3vtGRWnU4SgRlgX9w
	9t7b25b+k6xEpWBtPGuhUaj6fCW3H2cgk4bZ8PCsHgbKEc9eEoUBGrgnIOTBN1wa
	3ewRQEreWNEiM8VLKLWHDegIOdNqS2BbFZdQXvaAbCSCGT8Bt5314LcQOjwaEDPi
	zy41CFRiLaGokzih/9OYMTiQAT1a+kXMbL2cs1DWGwEaFmuY/CG6Z60HPbXi9JTr
	ttchHCWXh99d/YhAVSgQhrvADQVf1Idat/tS0EBRb6rW+BQY830ZOnIfPpyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741127626; x=1741214026; bh=p9tHWLSiGq3tjut9KUpyPifvkMdqJJGiHAM
	6DGjZXfg=; b=evNNYq8aTGWl9eVplWoZ2gXweqwUYitwwq90jfKMqlFMb3MAqut
	bsn0ERKqNolf9vDMSizbhARtUH97L9NLhVuvgYqDMN6pT36CvVUlBSSAkZX/LGo4
	xO4O1nw36zA/Cw+11N08JSZ1McoGfXSIlaKR4+ZnHqszvPekj489JkrySBq/burE
	MwIVPKeABsa/ArgRy9A7k01977kkPzmhz2008VfxX+J1V0S/WQyVv7hf/NxhBHY/
	q15n7O3Y7hmZ9DZCD79WQwHRP84BasEpDl9QZXJMxgNtAR+QEPyl5BUV+bhstS1w
	lywLH2gWPzof+loM240UwoEK5MT6XWaZrww==
X-ME-Sender: <xms:yn_HZ8uxunGVklgifIMlAbj5k5fucWJ693Lwzzo3BYKCKeS6zTEZBw>
    <xme:yn_HZ5cxVGG6eJiuaP1Xfotmpy-gTj2zQd3ZD5F_arVHVg_XxsmrCmAekvJwy-GBG
    1yaeIdK_tHhFnvzRg>
X-ME-Received: <xmr:yn_HZ3wf-7XrCKKO12GHt3fm9ICleC17NoSfiTuFAmcB-llNdzOddiNFdt5_nFhHVjuN8_QaJcrdSOiKCulxHDbPoEOyAguVZoEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhohiflhgvth
    httdelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yn_HZ_M7ae0D_253JjdWY_ltQgKKhblOfrJjQIZa-zqvko18L8AfyA>
    <xmx:yn_HZ8-c8ttYGK33w7AkXbzdIP_NuzAu_WmEBiN1dmI6BY0u5CmydA>
    <xmx:yn_HZ3Va6TBne0nZBORBC6GqyP6FKVU0pMNnwKXu-VmpARXmqhZ8kw>
    <xmx:yn_HZ1czGscV3PEQuWuxexQgmpdqXU42LnXrazNr8DPLnf-g7c5fzA>
    <xmx:yn_HZ7lamTBd_XEjAY_wjvDgXe8iwHaLbY8tJd-_fpIoKYZvmDkibvZp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 17:33:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Howlett <chowlett09@gmail.com>
Cc: Chris Howlett via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PREVIEW v2] help: add prompt-yes setting for autocorrect
In-Reply-To: <CAJVagJm36-Z8CtdDFgFXgQfmqGCD7i2rufoErGUc_ou2094How@mail.gmail.com>
	(Chris Howlett's message of "Tue, 4 Mar 2025 21:41:23 +0000")
References: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
	<pull.1852.v2.git.1739801702034.gitgitgadget@gmail.com>
	<CAJVagJm36-Z8CtdDFgFXgQfmqGCD7i2rufoErGUc_ou2094How@mail.gmail.com>
Date: Tue, 04 Mar 2025 14:33:44 -0800
Message-ID: <xmqqzfi0mnnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Howlett <chowlett09@gmail.com> writes:

> I've not seen any interaction with this patch since I posted it a
> couple of weeks ago. Has it slipped under the radar, or is there no
> interest in the change?

I personally do not find the cause so compelling, and am not myself
interested in a patch that pretty much has to duplicate the lines
needed to support existing AUTOCORRECT_PROMPT.  But others may feel
differently.

Around here, people do not react to everything they see, and some
may change their mind when asked the same question twice with some
interval in between, so it is a good idea to ping after some weeks
to reconfirm.

Thanks for pinging.
