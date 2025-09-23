Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5F1FAC4B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637040; cv=none; b=fSS7qgrMb1Sp6EH7rQu4RnutQFTu9AEbGQRCwMMuXOHxBUEI3aioS6xL8lxzB9G3Paz8RLJazzH1XhCdJy4XG0yNgVPDOoXHBC5nXm7NKvR3q3C1gW9XO+HOCcnfoLjuBEuLQdBOF4fJPZbNtCnP75Q8f8dA25WcoZCtL3g4ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637040; c=relaxed/simple;
	bh=sPUged5ZmEspWQkztVrqXpdA418CGdBY+KGG6SG+qVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYjZglU1Rh4ygRVNytdnAQO7n4vmw5xDraZZUUIO+H6hBgyTcDmHfsMOfjhLYAjJAqPBDf4Ni40Q4D7TdRPO/AQKCzw2Hc9IP1x8dOQC2WO4C5051fdpXg2k8Rp6PjEDHWGA/8IgjouDFfg1yCxOnLYkE/HI3fFOzRaKWslemac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FNNs9hCz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJh8ZBqG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FNNs9hCz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJh8ZBqG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E7A47A02EB;
	Tue, 23 Sep 2025 10:17:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758637036; x=1758723436; bh=eLo0DYFRrU
	ruJJ+MvBDrdQjhzr5sgjl4YyTjX0cB2Ew=; b=FNNs9hCz6fdzvsyy9ltkFQq2l4
	Gw99+BhYM/WeQ0q86MvN7S9XTUUJDeNTl5k1xuuJVnUDEyppcfIs8ajqLp1saY64
	vxuXRnwe5PekmUZuJNZ1Hwgfu6bsOTLR2HeYj5mJ2HwFGM00vnQH1h8Xx6qbAj1b
	ZGnP7iM42tm0Veq7e8SFHNKxTF4kMj9ciRYUJ+qLiT6N69uemlr9xEsjh5MpjzsW
	TU1LI2ShMwpjPmt0kxT5YA/ptUBXzW7f0E9pSJ0bBLWR77jOFVAOIdTZ1h51edRQ
	UQ3HSTPsvn4FnnRl8ypYvPiQIb/iC6L6DsTRNM2VxcVzyD/YvHKkuhREG/eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758637036; x=1758723436; bh=eLo0DYFRrUruJJ+MvBDrdQjhzr5sgjl4YyT
	jX0cB2Ew=; b=OJh8ZBqGtXsIqhtotPqEKXMepUJPA70GDxDMgF7eQljTEO7Bv7Y
	+HVLim5g7FDQvcLvce3gXBrL1ehUg9WVMpB/tzTaAsqTqIKWTp9QDJUz9FfwDlrQ
	9NAd55e/z0SAZPqgPCyh2JtZgVDse+ViMZlW29ZbpCyw1ktdwcIXCiiGz4WM31Me
	eMZ5l1mo12KBFL/FtVTItmf+IZEx3/i/BUlmQ5WgwS+24KJCtvPwbtLHIS5bq0Pk
	Y0/E8Kq3DdJlc835Ttzy8yOkCbD+PRjPw/CkHCLK7B+0t47kvDXfjOWnLW3k8wtC
	sTK3tbGzol7JaOhxupVNK7uK4wG9YE6eNQA==
X-ME-Sender: <xms:7KvSaKhXF64Q6zUNoJHN1sjV9RssShtGcdfjDFiyxnEvFjI4q23QHg>
    <xme:7KvSaHUME0VC5KMZlYSSzuZFKK5YSllkvO7G3QgkUTy19Vq7ExowpFzMnF05NfqgB
    jnBCQmPjuNyDy5s0XtKS58TGkSLAv13rTz3snvRoV5rNNH8d_2c>
X-ME-Received: <xmr:7KvSaDsOHzJ-WmKAYaJ2IVKxfJmlhXc0IcyNrJPIT5pIbVmmmmy8obt1OINcmjmMbdBkf1IcXWjyqTQ6fzoKk0VCZFUguMmy6CGS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehsiigv
    uggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdr
    mhgvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhk
    udesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrgh
X-ME-Proxy: <xmx:7KvSaAbQqs9WdfMGG2o7U57bfBOVzKp8meySLMeA-hkdBmlEr7dS8A>
    <xmx:7KvSaM6SCZ9HJ437itm-BRYYH6PUP-kAtxqZM2d8V-L-euBCcWLQbw>
    <xmx:7KvSaIluhm2medQwGhCBkiy2FSRWOhXU7_h6tyt6JR6JZSeA9CebCw>
    <xmx:7KvSaCHZlyrnmAr6GrhYDibcbeHOWlDKpeGKPwPMJ4Vz0qsD6ux14A>
    <xmx:7KvSaGInuGe3D5xZwnb7HE1g2bnxjVBWxtfd62CDRcDUrm_Sb92UjCgT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:17:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor?=
 <szeder.dev@gmail.com>,  git@vger.kernel.org,  "Haelwenn (lanodan)
 Monnier" <contact@hacktivis.me>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
In-Reply-To: <aNIoFePhTc5vGc_-@pks.im> (Patrick Steinhardt's message of "Tue,
	23 Sep 2025 06:54:45 +0200")
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
	<20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
	<aMsxhp6ZO2Cdz7+k@szeder.dev>
	<aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
	<aNGkt/DdnbjNu3s8@szeder.dev> <xmqq348etd9n.fsf@gitster.g>
	<aNHKdFkiGLPcLEjP@fruit.crustytoothpaste.net>
	<xmqqplbiqeol.fsf@gitster.g> <aNIoFePhTc5vGc_-@pks.im>
Date: Tue, 23 Sep 2025 07:17:15 -0700
Message-ID: <xmqqy0q5p82c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have made other breaking changes conditional on the wider ecosystem.
> For example, using reftable by default is conditioned on the ecosystem
> having catched up and supporting this new format.
>
> Do we maybe want to do the same with Rust? We can for example add
> something like the following paragraph:
>
>     We will carefully evaluate the impact on downstream distributions
>     before making Rust mandatory in Git 3.0. If we see that the impact
>     on downstream distributions would be significant, we may decide to
>     defer this breaking change. This will also take into account our own
>     learnings with how painful it is to keep Rust an optional component.
>
> The intent would be to alert distributors, but not "blindly" pull the
> trigger. Instead, we should take a step back and evaluate both how the
> Rust ecosystem looks like at the Git 3.0 boundary and how painful it is
> for us to keep it as an optional component.

I have always been assuming that we are prepared to change course if
that is necessary and though that something like that goes without
saying, but if you want to add it to the document, I am perfectly
fine.  It should apply not just Rust but all other entries we list.

Thanks.
