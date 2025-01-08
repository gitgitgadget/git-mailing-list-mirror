Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213419F133
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350135; cv=none; b=R7Lb8XA41dmneV0ZaBZ/Ga8CjnqzOLdDqN2dne42DEcOv+Ddy9+CPKEl+1/NSrbiL1k8dDcZRaSfq5porpgsj3aRbb0RJgJ/GSjnKOY5JzqkoGvo9nYfRfmKVayvWcWHtkejY0lvSJm1ZpfAaCff++VMctSsjoYNTQBTokhhOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350135; c=relaxed/simple;
	bh=yK8YxcQKe/hvmF8fEXkpkXWhyUueQ61JJIJtixYhs68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YO/66EpsVQ+6ekogUMOaDCyX+cQ3v5osfHz4Z5j8lgmuaU9FyeXoVHUTJDsSr29BzijCPfDgtiYbWlPN2Us5NTBew16oVL1rGoQvBlBZ3K6+kMiefUlUb2JL/NT3T0vXu63wtNaC3rv2vbGPdPhBSdAVO67mFXNn5XYUlBV6eI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTAQnouS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKYU4yvY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTAQnouS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKYU4yvY"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 87B66114008D;
	Wed,  8 Jan 2025 10:28:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jan 2025 10:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736350132; x=1736436532; bh=yK8YxcQKe/
	hvmF8fEXkpkXWhyUueQ61JJIJtixYhs68=; b=KTAQnouSdnLQ7hf/+wINgRzTsi
	U3B2I7MmVIE3ozlIsoQGEtrVFfqWXHLpCjgcf0B/ksS0OeqOar82mAiKTcANhAPM
	/nTckwXfADea/JOPb5aH5qxhYvyzNTxgqg5fqT/sU3Qn3ScuU928xMwq/m4XZmlV
	jpc9ghT2h02f5KQi8aiuzMEMef9+3qcqWuDL2YRlMMfGS+4ZXb6celi4B6I7hvze
	17WkEn3vwwnTR27ADjze5DV/XEhLRq4vqWYAoj1Y8FZx05UKaNJdoFORHe7eYuxp
	l29IIDQ6UN5FAIKlB5SM9WAE1xAtaxSE853MvpApbeECwyDE11BiR1Xm4ZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736350132; x=1736436532; bh=yK8YxcQKe/hvmF8fEXkpkXWhyUueQ61JJIJ
	tixYhs68=; b=lKYU4yvY9o7/9JqFBHdMvr5QB4wlE5XA94p5ido8GU11tG6w5Q8
	6pY/E14/uoqEthnTUsH+vj/T6rdNoAcgk+wZS9KMhVLtveM8Iuhjag7wtPxa0BBP
	LzI68G6DBlLdGNXHwwwqUL8Gufig4X/BcV977petGLRqVj5NAM9WRIPkBXKrWu0+
	iQ6hFFYcp6V5eNeVSGkphCFOPkPdkQn3BhLE8Get9bQjsjqXL9fLtdae33PnK21P
	mv5H5aCl9x9fSxFCr3XgcbrxknKJR1jfMvoIxWfZGAu267/cn/FBcWhAQU+YxYTP
	7pGpyrPcMbDVX3UvF+weEO8nrwqxccBb+vA==
X-ME-Sender: <xms:tJl-Z2v9fzcmJgIpg6YkWmXzmcGu-IaHiUQMgCsFRdKusZ8Y72QNTQ>
    <xme:tJl-Z7ckx084-R-9VX4WK86_tf3TbBBFBeZxaPEbixsWw8mzciFIIRmDm4Y7W0lso
    pwFFFhlblwDRZoVKw>
X-ME-Received: <xmr:tJl-Zxxk22TQZLh4WMcen46uMLtdJWiq1quss2U5O8oVN9VuUFP-3_Jbs6nqClkbGhZJynRawj3tt_Y5Jx5KMdpQJhmqxn5HEjMD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhile
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:tJl-ZxM0DuTA1p6psA2mrQAFt8nIv5MdVFeBNmLNmaSTXs4jCD45iA>
    <xmx:tJl-Z28CnZTrOr5-_7JVodaPjWI3fSOneRzF4a--TmW_5JDPec-5FQ>
    <xmx:tJl-Z5VfRFjUWMObEMXwYovUmtmRlbgkZ37SGW75H2KVhZ-aKsTOcg>
    <xmx:tJl-Z_ch9siWEvrgVhswd7iIEFISR63slpeUx9nP81oLazXFeKq2aw>
    <xmx:tJl-Z9nYxrbbmnFd8FrqJjK8jnGAOtBMmCbmYmhVwvnVwc89_vPxfuwg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 10:28:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/1] t/unit-tests: convert hash to use clar test
 framework
In-Reply-To: <20250108120339.225596-1-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Wed, 8 Jan 2025 13:03:38 +0100")
References: <20250107091932.126673-1-kuforiji98@gmail.com>
	<20250108120339.225596-1-kuforiji98@gmail.com>
Date: Wed, 08 Jan 2025 07:28:50 -0800
Message-ID: <xmqq8qrlpbnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Hello,
>
> This small patch series transitions the existing unit test file t-hash.c
> to the Clar testing framework. This change is part of our ongoing effort
> to standardize our testing approach and enhance maintainability.

Thanks; this is no longer a series but a single patch ;-)
