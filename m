Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99BF510
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624529; cv=none; b=jwHxywJdRiAwcgW523AhTFsQggg+usoDaQw2HQYzebadV99SPuAFi6CoDWslyvKlgDN6S4sHK3Dvo5QeKuCREHLrsr1JGAorjkiPTyEQFpd0clWklH0GOnVyZ4+sT6NbH5Q8deDLTDE+RkPXvBkr945PQj9ksnyRBAMoeBTQdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624529; c=relaxed/simple;
	bh=aEEIfa7TupGVVR+18BWBoPLxVo9vOfq8L9kvtM/jhC0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DncWQGexg2nly6EBzDtrK8nh2ecDhcYAg0eXyFeUyMXzh/rblGcJF0nn6YYcEKY7vHqDLti2pT4CgX4cHTGrhL3YNaYl6C52qVKGv8diSvTwJJAOsOSUqEgzSlp64eZT/6P7uesBZmhBHxaIsaF6IxWUduUNqIjTQkzfvoFuNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=XMPOfUWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MORp6Zf0; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="XMPOfUWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MORp6Zf0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2D287A0195;
	Thu, 16 Oct 2025 10:22:05 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 10:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760624525;
	 x=1760710925; bh=wb7jMm+LwXsqo34P3PMxYvgUR26EaQ0As4zIQNwcQD0=; b=
	XMPOfUWasso3noepGFquKQnXn25+A0+lNHoyJwTappU3ixF+TADYeYc/yPnMGPWu
	MZeUBqxfS1/B8ONL71lOKt2fMJbkLOW3M+dMDH19k8D3sBxdv787pWk31vibuK4S
	PLjAED6RTsuUkxypjXC4rzv1KTZCwmcx2VuJ66IH5aB4sE7ed3YMgWqfJvMLcQrc
	7mbMjda6MuE/f355GamJMOEl36DydNA7Kt8/uze/jMUj0ILB92RINmk1a8BzEA2b
	XmjN9MUbcYm5WHIpqtfU3HXrq+WLvsr4eybLsY926Cc2jWwwIOGxJeSOyhE4YiLI
	ehxHIPS+oH+7P/eCCwBl7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760624525; x=
	1760710925; bh=wb7jMm+LwXsqo34P3PMxYvgUR26EaQ0As4zIQNwcQD0=; b=M
	ORp6Zf0GhcXmJla4bnU7tgVMtjA+qVujG3GKM/usR8FJSwuGG0oJaG2PDtmliCoZ
	RuI1GAv4Xsit3iyFfKDdHM7ntctBeWMGhxOkFWppYU5v+GNZLYgyfPFM1U7+Yzy3
	8H+eA/pIEL3lOUoDJ3SE76l6be0HkFD7iXNUKJmt7TsDOl0XehoWaIB90Wj+i9Hz
	C0U8vRERI6CXVHTohJe2YeDSJBd6V5NXGBUZapI/gn3s5eK/u6RpokEPFyndr0Aq
	YFTcQqiLSxoXlGVL3MvNkf5E/dLVxN+zd9SXHudKv1elWuZzd4yPkuSd64a1gpZ2
	dCwmYB69mExVZPoAyoYJw==
X-ME-Sender: <xms:jf_waO4pZoiNINp8E3hNkutqdynv670-WLQTzt9LX2RGQKtG7hOAtQ>
    <xme:jf_waCuCIsRXeArf1zCO3deB8FZI_Mj5pi6_NvP9q7EzxLstSRtHm-R-B0aTBwkxF
    p7sOGrpBd9pcfQLN_aA5EfHEE0filhOApFlWuzE9eX2ui-Pf5lOEGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jf_waGlNbE8EG2VndUQB3KOshYqg9QGI8O3q_w9c-dEpadoyn2F4vg>
    <xmx:jf_waHK7Ym0ihQzcE6dbmSO2dL7EMBVGz5aihd8z42g7E92LmBZ9Ng>
    <xmx:jf_waL4KAFfpOLVL6XZ53cIijFWf3v1n4iGKZvK5lMaeERGe2PZ2oQ>
    <xmx:jf_waL1lA0_Gu8iTrr6jQC4Ec13_znMPS5kpMLNRgL9eG4Nl1f7oLQ>
    <xmx:jf_waD9yJn4500G5kJWSMJVzheUV1Z2x8lOYEuoYbRKF_FYZSfnfP6vF>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C98C780076; Thu, 16 Oct 2025 10:22:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Thu, 16 Oct 2025 10:21:45 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <52e9036f-6432-46ed-b606-056e5cafe3b9@app.fastmail.com>
In-Reply-To: <xmqqecr3ucba.fsf@gitster.g>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
 <aO8-NtJPNBAM2tVn@pks.im> <xmqqsefkuqkv.fsf@gitster.g>
 <353916d3-c977-40e5-9251-1535b226cc9e@app.fastmail.com>
 <xmqqecr3ucba.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 15, 2025, at 4:42 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> I'm still not clear on why you think we shouldn't mention that how
>> references behave depends on which filesystem you're using.
>
> Simply because the main purpose of this document is to give a
> data-model.  A case insensitive filesystem limiting the set of names
> you can use depending on what other names are in use is a quality of
> implementation issue, which I view as a mere distraction when we are
> giving overview at the conceptual level.

Okay, I'll delete the note.
