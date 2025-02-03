Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58872054E8
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588899; cv=none; b=apS5YN/1lXxXa7JZQpN0iTlliYZh0MHMUbQ6WOU7L65bGa5laV9k9J1XJgVjbYjpVNUEACsgJTsfiuhl2eesW8jR3VVNaYVrGu7r3xHNHPgeNLdHX6x6lGsxi2rk8VP7iQmc1Urf3RfenmCM1drwWMoIOxvJkGDMqKeB8FLkhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588899; c=relaxed/simple;
	bh=v4D09zux9Ok1a+c7K+s3aLmRdLnIGR1MAgGAIWzMW8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R7tqEWxz3vUjtiKtUDdEYdhVQ7V3puT0Z38Q2qeqMCkuDYPCchUAdneHtZkTG9eIzHWuI6mVATrgkNi2aOSfj96Zb/etO8XGLqFfw2rSMyigdJCKUmBooLzbGbkJyakmkwshQSWwYvhMPXCJLazucttGgRQjFyLKgI2IoMU0ymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vyfasWwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDv+knPj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vyfasWwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDv+knPj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A044B13800EF;
	Mon,  3 Feb 2025 08:21:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 08:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738588895; x=1738675295; bh=3ZPhrwce4t
	nRYx7NyeTGB8H9jX0ymRvPdtszvt0QAmk=; b=vyfasWwqYgrkfr5yW7Y/cqGvor
	s951NuY2Vr/fqMMzwE4qEWctaOrXOcnnManLTEX6ZxLhEEPiAuIengRgDJysPx14
	dZcZsX/9tjD8/chkk5smqsIBEEnHrxUfFwmHNNJeLvNjHc5+ERAlR98PeK1QLEsY
	4uU+69G5yJnm4gq5k73gR4YK+Ouxi/KQwFa758zfQ/lZQFqpO4775V0NqziXvt9S
	kRatg4NPDSfGkNWJmBBzI8BB5ObOyQMbsByMEApm67+IyV11UuVysEDJ07n7rtgi
	CF9jRa8kxXrzxGWLX/SGno0Rgad7TbV/p+gUamFU3JmfL+8wPdJWCv2LvQ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738588895; x=1738675295; bh=3ZPhrwce4tnRYx7NyeTGB8H9jX0ymRvPdts
	zvt0QAmk=; b=gDv+knPjI3Nkq4tG+MCjwGaT8zAyNHDwae4gepzn0mXfDnfXrFg
	r92yhpmidsn0cn+QO+tNAU3VmNNZJHEfxp3+ZwOjDbFAtSct8qRVS0ssb4joAE16
	THcRBeIvf5/j+esfoQZKpw0Dx9rfVf8EfIrqIq2nt0uRetYXrS+adaVkIRkVi1eS
	YPTJDpwtglMzOFq7Wy+ti/d8Sm+ZzfpxPKItO3387X1w0Ovnz5DybOpk6mdCOUY5
	V82bRNVo5jWc2yjUxLZI7qvg85IrWCMQUZNKxtBI4wslJcdkRHOP/EBhsE/bPw7c
	m6hNiEKZqgvUyYJ4esNL6+og/WNaiicOySg==
X-ME-Sender: <xms:38KgZ1avY4Gm300F1Ff-Av75v4Hx3GelrJdT8U0N_CeSaZlZCkP4Ow>
    <xme:38KgZ8YHNyYpApoijk3m1K25Qj1OfzOpc2iAZgWw-qW6_JaWcjxylpJmK2pOm_-xW
    1A8a6Pqt4EpiUffFw>
X-ME-Received: <xmr:38KgZ3-LUoxh2ZaLmq7zOSo3WxOlUGlbXnw6ng6h8iyNP2jLNMyUKkkSl_mWDZRzXJ8DFeKetjd_RZgXPRZVWeS1aZ1w9SsiIzxl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:38KgZzrrcOi2CcklZnl1S_T-QdR0UuQ6kRDfTTtsP3M63li-tzZD_w>
    <xmx:38KgZwoIJs0VG2Bqqlnag5QuNnISOwZ5x1usqA_IVULYTRySbS21eQ>
    <xmx:38KgZ5QEiRp45f-KQs6U5Rz2UXvHW1_UKVZRUe6bNGlxhBfJL8USNA>
    <xmx:38KgZ4p8gWnshIndZvKjZLpnNX_2ZVCXlPK7jyLgC7UdwoiBf1bxgQ>
    <xmx:38KgZ1CXA1tmJthqjesjUAJuIh5ctwu8ZfSMOKhzqZ6zWU42iVPvUoMD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 08:21:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
In-Reply-To: <Z44u7od-mDiKcKVZ@pks.im> (Patrick Steinhardt's message of "Mon,
	20 Jan 2025 12:09:34 +0100")
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
	<CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
	<Z44u7od-mDiKcKVZ@pks.im>
Date: Mon, 03 Feb 2025 05:21:33 -0800
Message-ID: <xmqqtt9byxia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was wondering whether it might make sense to also move the list of
> microprojects into the Git project itself, e.g. as something like
> "Documentation/Projects.txt". This would make it easier for us to update
> the list of long-running projects whenever a new project is added and
> makes it easier for people to discover it.

I am starting to have a second thought on this.

Stepping back a bit, if we were to do this, it is very likely that
I'll let the patches (to add or update entries) sit on the mailing
list until the discussion beats the horse to death and then apply
the final version _directly_ on 'master', as such a document is
really not worth spending our usual "cook in 'next' for a week to
shake out problems" mode of operation that eats quite a lot of
braincycles out of the maintainer and to a smaller degree, other
authors that make overlapping contributions.  And this thing, being
a single document, is *DESIGNED* to force all authors to make
overlapping contributions (and an "easy to enter" contributions at
that) that will cause conflicts.

But if we are to have a single document that records a list
discussion consensus *after* the consensus is reached, it does not
really have to be _me_ the maintainer to do the record-keeper.  And
pushing as much busywork as possible out of my plate would be a good
thing to ensure that the project scales.  Even today, we have a lot
more folks who generate patches than those who can process patches
by vetting, polishing, finding problems in, making sure they play
well with other topics, etc.

I wonder if this is better managed as either a separate tree (like
the 'todo' branch that houses "What's cooking" reports among other
things) with history disjoint from the main project, or even a
separate Wiki?

Thanks.


