Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1B1E481
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604648; cv=none; b=bpWVlgBxOBS1Af6C4Kfq07IZ1F1LAiC9TpzqloaftRZLbqw1YrkHMgCEqLHNMtJj6HM+Cr3zVpE1p5qOKvRqmB6NGCnXeSy5vVYL/j9fnBlGKmcZIRjo0zlCx6PdFnzebDGRAql6VkMfpB/tklRfylhMg2utI4UvI7SqSr3DJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604648; c=relaxed/simple;
	bh=6+dZyWH/nP4My0VMFtmnEdRKzrR0RYxDWj342+4j+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW77MKtZRVOO0pzcx93+QpyQET/r98uEWunfoiNpG3kJkBhhcPx7XJVQ1HZizD4cF5Z9/0RDKacs/b9C5KxVG3t1jxC7epa2rtxqZZt7Z+/F++NAuvK5j9AlnIfwkYeEnAQj3O9NyGI16xulRKwboZ8+8mSrmLxOGtKoBZ2ha3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kj1ugy3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/B6Iuzz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kj1ugy3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/B6Iuzz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DFA111401B7;
	Tue, 22 Oct 2024 09:44:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Oct 2024 09:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729604645; x=1729691045; bh=aGFOqzA/Ed
	iLAI626XegR+yqVkUdXZErmvjtMLcSwzY=; b=kj1ugy3xkGjbHkTxYG93BIc1sn
	kv8jwy7ng0fIHWwwCMWLoATUxPWLWe73ZZ1FndxuByApotq1692rn7Q2vagfL/De
	DEA/ckbMWyAFzXQAbaq2KKHkGQNOEueERGNzDj2/HfAJInGNWl8B+zdq7/TqloUv
	Yk201D7d83MnajTOCFSFz+JzrCWQAcTQYouEcKOqJ/IVw4JMmIYOm0tapIQoXLXa
	wACucyWPtQngV2+QSV1DzFU006E/yjDFbB1t6gTdhB1Bs3jkgx1UL1PVYjBUnyjl
	cbV/VvT3J05NwrsFEcz2pzd72/QKbW1tbs+PI413rA0RjNwQ2lvltjiV13IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729604645; x=1729691045; bh=aGFOqzA/EdiLAI626XegR+yqVkUd
	XZErmvjtMLcSwzY=; b=X/B6IuzzVSX1F6/R9BU1bUz+nDC2CPDrUMIqRIJj7Aon
	+DZ7i0xPNHu90Ks8UuIAmaCW18gfrLBtfepN9O0aJrGg1igvZVVY6laUJ8IDxI7u
	ojGrbG4OQhza8hWIrubbAX2stX5bflbrorn4pKTDYJTAkcKlhUny56By3Afs558i
	Dndnzlrj09jM22bLTuD548KfDahePN4p73PNH6X6FJuE8W7h3YF4vI6yUFtrddoP
	lfY4y1SYMTYVrSu/YmXw+QHifKeAcEs3UWS9T3lqAnRTPQEIUX72MSA/o8OBprjd
	JhjwIlksvxRQsxgsZ7iEBVUAGVDiaZZjsu0LbjiBTA==
X-ME-Sender: <xms:JawXZwWC5v7s8REoU5_JENDjUH55Bgsc7RrVUmPwQAzPfOaQ-LoVFA>
    <xme:JawXZ0n2hxtGkeK9Ta5dGbvmrpFeUfFWQLHg1rMHR9e1g8hHh_8Uz7zOyvmQ-lR4L
    QJLTsnJtRYMkjnG4Q>
X-ME-Received: <xmr:JawXZ0bL1TDRNVa5v6AM185VSkdqWjEyRa0dDPwoxutlKlJ8UXUQPeBdBt4vBo1z9W4wA9ayLwhixUzP85Tm4itNatdopQ18NQ5unv7GRIPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JawXZ_XcEz0Q3UlxbZTRwT02CuL9VH9-hlR-jHCth8rKDRd2_4c-yA>
    <xmx:JawXZ6n2GD54rjaVDB_IID1bcslqlB5Z2WODDXNmA3ULQLmIu2iOLg>
    <xmx:JawXZ0d471B8q_1Kl1lr1YhFsLcfctIpcw-DroMcosJe4pnzoHuxGw>
    <xmx:JawXZ8GRF4KpMfZrmgYJYzNsOWmWQxNDHiS-mkLOXEK8wESX0a5a7A>
    <xmx:JawXZ8j_fYsdt0kTig9dFPVa-P2jCv13CdwECUeMQDRy4swXq9nIq_Yg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 09:44:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d0a08f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 13:42:32 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:43:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
Message-ID: <ZxesG0kk3S7BBMWx@pks.im>
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
 <ZxeWDTFHpHmVePdF@pks.im>
 <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>
 <ZxelBccIFk1aXP3l@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxelBccIFk1aXP3l@pks.im>

On Tue, Oct 22, 2024 at 03:13:52PM +0200, Patrick Steinhardt wrote:
> I've asked internally whteher this is okay and will get back to you once
> I've got an answer.

Quoting the answer I got:

    > Yes applicants are allowed to apply to multiple projects.
    > 
    > Though we recommend that applicants contribute to not more than
    > two projects as it can be quite overwhelming to balance
    > contributing to that many projects.

Patrick
