Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01EDDA9
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377315; cv=none; b=QJSx2BPx/+vsi5cVwlQh9ks7sNGCHsQN0bJoNP/62L2C3i5cTNHGhA0FwEP2h15icwOUkcFQDFBGBhQ7JrXIxx430AU4x7gpM5iXTGoro6lwosfNfsxXj8entvVs+La0+3+W/Y+GKIVgap4zW0sVOTu4Y4qNDKdKNNjFlU+Z0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377315; c=relaxed/simple;
	bh=tioEYP/jC+lzuht4R8n3mQg7DGcMqEyq7kCoCE5aZUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQsUwtD+TNOhJhIrCHwKG8p4n7fH3Bi0n5E594LNIlmdAolH6CddzsF+F1DNcA0R5B/KwxMmP/9VDhXUJr6bzGIn9RLR3Jbl+kj6nRkSSOPSwstkMlDGqISrYrVn85Z/00vhNuLJNPCXhKrmHCC9MdyYQ9TdepuXbK6tKtkAOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fck2XV7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW8jxFk8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fck2XV7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW8jxFk8"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 825D811401B6;
	Fri,  7 Mar 2025 14:55:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 14:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741377311; x=1741463711; bh=DdwOiqb5Fw
	LRFQbcVGfxY5W+fKmqiOxBUZ3EK5tU28s=; b=fck2XV7+mH5QaYSdlsCmzieoDF
	FkXs08pMGw2kpxVnoIyrYTYM14hbyJstI4WVaLI02iOn5y0e7wxvVjFC0xsgwfr5
	PoQCI/qRiY9pOihgGvy4/NZhfR5W+Z1ghx6DvIokdOFpBhrSril0mViLJ9tinDDm
	Wi5XpLksc4MPR1sY4lBeCsTI4LfPx3ZqhwCE8Xxj8r1AEKN7NcMPOdG1a7nEF53A
	GuhfX4QXRxhU9pbuXA5KE92GVPtIBc0znWyqpqunUvRBqGbE4t+YFjS8DxINLPCZ
	ZIsGPA8FadZPYEEE4K12D2cU7+CoHC5DkXXfJuN/rHY++2QMa4i5DYlQqVVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741377311; x=1741463711; bh=DdwOiqb5FwLRFQbcVGfxY5W+fKmqiOxBUZ3
	EK5tU28s=; b=SW8jxFk8qFVF1CXsrKQqSqPOewFEUp4R7L03BfHc1sVh4PmD/ss
	rgNWhOJDMFTrJWnxX3l7BjCCd6n/wKNYnt6i8CqzXzuAvxQLxT3gagrFvV/7DloH
	zrqfQZDeiG+A2qj5hvypTFYKbWd6LiR1MjDAcUNhinIGvi9t3URt0KLm6mHEBUiX
	qp20SPNxwLtLa6jYGCX91KV5xo/QBonTyvstya38SwK35exppHaXB/GYAShD0b/j
	mfryWhYq5P6swkvVn6in88vQbhkXsviWnryiHPEgFawCJdWMFIy59zvaDjDiz0hE
	bjXppnQqLGR21ifOs4hqFBhm7xWBGmbZwSw==
X-ME-Sender: <xms:Hk_LZ9NMSnPqe38OI6tWJI0MRa7-Mt3_-jQaOqy59xisteIR2DOwaA>
    <xme:Hk_LZ_9jIuyb5Orhau31iMbbyB7qGZ_sGAZR_mc9bUZLYqSzPpt_Zv3LPH7NWeMs9
    MkutWRKpboXP3d24w>
X-ME-Received: <xmr:Hk_LZ8QF8Limw5k9p-xDW6to9mH1VhEfm0v80ZhffstULA57NuUD-F0Ct9iJ7Tzj9yWM7cbx9KeKB4_iU-b8UM7NrDFiW19nyj17>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Hk_LZ5v48_CSsBsUV_WZzpXiE3ScZl8yJMZq7D7_TeA9S2J8ei6ALA>
    <xmx:Hk_LZ1fgY5784hsp09mXsdxfn8yPdddCvYwElYAbIYaol4oQGWzhSQ>
    <xmx:Hk_LZ11LL-_uhKEz3puRXDqB9L5jQXyC4-t5FDymZf9p17hi9kUkFQ>
    <xmx:Hk_LZx82MudNgr7AwGk76xwQraN9vHrTMgTbAlIGSDUUqnMzKakqVQ>
    <xmx:H0_LZ-H2L5xlPzCkEY23ECv55BDVPUI8dLLNrOQIrS3NJEuZ8lgFAGBf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 14:55:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
In-Reply-To: <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com> (Phillip Wood's
	message of "Fri, 7 Mar 2025 15:07:25 +0000")
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
	<pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
	<xmqqzfhzlbie.fsf_-_@gitster.g>
	<082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
	<56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
Date: Fri, 07 Mar 2025 11:55:08 -0800
Message-ID: <xmqqfrjoehur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I also noticed that while we store the correct value for
> WITH_BREAKING_CHANGES in GIT-BUILD-OPTIONS it is not defined when
> building the C sources and so we still build the pack-redundant builtin.
>
> The diff below stops us from building pack-redundant with
> -Dbreaking_changes=true but still builds the documentation. I don't intend
> spending any more time one this

Thanks.

I am afraid that Patrick's plate may already be full, but I am
hoping that there are others who are interested in getting the meson
build support into a usable shape.  Any takers?

