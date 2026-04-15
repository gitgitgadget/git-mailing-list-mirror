Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193A3793B3
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276443; cv=none; b=VTWkz8XY1kRgHYE0OopBvcnxbcHO8196nCZRS7qG33urCDca970cWWOVx0UljN2LynA2gobzWmG3X2Sqzhd3inpJ1NXPo6oOp5Nsa92NrQcNmsIJhAjjaq6JAnrkcikz2KzA9pEOEYhnbDAxkplK4wPdo9StGzmjpUdPinYgBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276443; c=relaxed/simple;
	bh=PxSzZEJu8SF7IWivb/mz+V0yEDwOS8VZD2FX3F9TdTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7tACJvzigdhpGsoA49QMVrWQhKb8XOXk8pS0tlUP2NDqelMRxz6SQ2bQjtwYzzpZvXNn6GGC1nWDnOcYENXcp5ss0Elm7c23m9C8Kod5NrEAlSq01gYmAQLjQHP1WyC3g1KsOEDa4voJ4U8tNTVnxK6nCvuTim5rGS5aL74PDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UmPauJi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4D61L/t; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UmPauJi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4D61L/t"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C4CD7A0185;
	Wed, 15 Apr 2026 14:07:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 15 Apr 2026 14:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776276441; x=1776362841; bh=Wma+YqV5pS
	Dno+mVY7Tye09mGI0EAiYjGSlxfsMdsbA=; b=UmPauJi36qPsMxTSvVLgnjOITW
	HtPsBf5c93zLGAI06Vc6NqTrqHs7K0MjD5XK/F9Le/F30OebPOEbroiPheCNZKwj
	B8BxgrVY746Srh81D1L2/q11k2b3E+4ldn0jMSzE8935H9IMePc0xc8maj2o/n1d
	vvnJJ//3kUbJEjvezZYAS/ZBGuRgi0Oitt7bpKHFFKXNm09eK3YYSV/vvOgwh0SN
	Enf3dgWY/WDPTuLtuwEVovthfHkiKqoWF7SPkQAcjcJ0uJSRDDzitdSg7sKLsdj6
	9mgLekyvv+1kkYBh3vq/LRG3qwLMOYbBdJFZkXAnQzLmLJ5KhMgPaPNONNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776276441; x=1776362841; bh=Wma+YqV5pSDno+mVY7Tye09mGI0EAiYjGSl
	xfsMdsbA=; b=W4D61L/t6ybCMnb3rlBIZRPJKwmKgOWSlxl9ahogS++EP0LY/sn
	NJSd4i1btCRjWJccNvpftSmVFxOW1D+/EVGuvx6V0uORkNDlf2dqUN//SuEsyUMk
	f8JfYjT/lqLYgf4+OWGmbm9StlhWG7smktobqfU7yOIHibFiFU+LbXjuRzMHALfE
	ZIv3PvsfiAdPFjQ+EhLwdy0MHq76Vdzwn3Lf9AU90GD8RJwbIO/0l5jL2siZZpY3
	Y3AOiVJ2sYSUratIg2v6JgzbsbkNJ4dCnNPzCHSkZTmIEij2rzv/J/bV1SuJrLIC
	kRSEfSbC3RQKVmzZ+KVw2kfTSZbrbkG0dCg==
X-ME-Sender: <xms:2NPfaUudahOPoITuQBMDMOxWCwrefx2WnRrV0SDEHlaxon0Dpq-eNg>
    <xme:2NPfaQhWQ6dspoJ9t7_sBKuoCxOs1YF-fODAIMkeNtHVyqOeBb7af-Tdu2WFM-Eut
    OQJF8HEFcuCCvy-vGpC_NyusW3AGVJQT9frauQwo-Anu4n4UJpDqg>
X-ME-Received: <xmr:2NPfaV-P44mAFvBORWpnRbEGS-Jev7W0AgSBpFX4h5INNyfID9FTyD86T4-bVKPFp3QpjGKXgwFZFo79HasVwdwOj0nDi_Cc8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehprghulhesphgruhhlthgrrhhjrghnrdgtoh
    hmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhthhhusgesphgruhhlih
    hsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2NPfaTuDMCvdgQyXMFsbcmKWisQ3YxFgSs7GgqvEZ6dkzCxQhU6Qng>
    <xmx:2NPfaZpwMUaFV1Nj9cl8b5vM38hjLDd5m2ZhYXcAEXjudRysMcDRCw>
    <xmx:2NPfaXpL54iexY1C1oOyi0YQPYlcMv-32823nLhvU18q_xCrVqZD7g>
    <xmx:2NPfaYYPhvsSMb9Fz8iH-GtR2PWfPbPTWC9XZ9v-f5HWvUIo4oAsUA>
    <xmx:2dPfaYZMa7yLhsjm18cAlxg8CtxlDIP-Hmmj-K1qchV20ilGYM7J90yJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 14:07:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Jeff King
 <peff@peff.net>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v15 00/13] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Wed, 15 Apr 2026 13:27:24
	+0000")
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 11:07:19 -0700
Message-ID: <xmqqeckg6qso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v14:
>
>  * Fix stop_daemon_delete_repo: test_might_fail doesn't allow maybe_timeout,
>    replaced with { ... || :; } per SZEDER/Peff review, restoring broken
>    &&-chain

I verified that this is the only change since the version this
iteration replaces.  Will queue.

Thanks.


