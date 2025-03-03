Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498A1F0E2C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998008; cv=none; b=ZKYSvBVkdK0/XbI4Wr2kLpUGgPsAf23DD3H4ZmPX/K3DzoNnOIaawhOchJ6UL94axBIxMiJCdISIMS5XKK6A/pUPVMMYqf2nSzUAwnfMTDLqN71baHEP9YaMwjHokyITJ5fBf1i5VQK13y/kCZmLbK/HpZi8IBHfv/Gl9t4cHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998008; c=relaxed/simple;
	bh=CZi+GizP4jVnvo9CQTpir9H43yd3Xc1juevYieoNRNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNUrAPB52IaC508Jqez95SzsLckPCFOiFax1hgBPb1MOjGTZpcCytu83Wtnf2JRmFnr+qFp3IkLCUZr7rwR+IYb2iULOsb54Vtl7EHNNZfIK0ctkEphqon2gvzZ7uNJJmdlCDO+0i0CYbiviJh3bs4mCfY+jj5QzC6vHyA2bxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QfHPc+7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ytTU4dcT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QfHPc+7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ytTU4dcT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 270CB25401C8;
	Mon,  3 Mar 2025 05:33:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 03 Mar 2025 05:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740998006; x=1741084406; bh=d16STzoajX
	Tx2eTcpxcau47Z1FB2Mmrn5KBmH4o4oOA=; b=QfHPc+7VCYbh0waTNdPgcw5LM8
	SjphRkXRG5orK4vux4sKe7Z7TABPf6x9jN0xaJ+4xBo72qJJzb9zZyBMU6tsoKxG
	32NZWF0+QP607iJK0mPcsOL+6y+8Q8IW9kZwfZ+L4qGyyFkdYS5qVBRHFpUFm9O0
	O8aMr3LeavTzPjtKrE4aqT2U9d8SxxcsMMd2bD2jIzwq4tr4lpAMhw5JlV33mo76
	cP7zcmggO5PzuoIcw1Mi+6jKKTo8LvZGu9lBBpaYILdeZZ4rdXPAxkIqb1rJlGeq
	DBCmDc7XK3Ugq91PO5DaZdHkNLR351TBolDNe0u9Nrxl64PW28jmkq4QCL7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740998006; x=1741084406; bh=d16STzoajXTx2eTcpxcau47Z1FB2Mmrn5KB
	mH4o4oOA=; b=ytTU4dcTe9SCkAuDPkRzUEYvKtXvJqlkYMSDOgXzT6QFmGw2c6Y
	/bpOMP5ZClSKja5280lzbTeQ8NKMT9U7Eep9kiEVvKkejH0HTvNIkUqJFnnnfKWt
	O4i4EJfKfM97BVeeqXiKDdqksmlE6Gp+RCJY17iULmbd8msi6Ul3ctIVMIBQ6R9H
	LAZlXZNDgtQiaDwvTqy9AKAF0zkAm9IXVxADcxVqVBtZ5+9Ut0w3aD/CfimgaCIL
	gHsHJ5D/YbpaoGV8RikMTh6LBOfkFFnSfIDfinbJMDPI5BvdCsolxCExs2IHAgM9
	dCF7kRKVLo/SWGNcN/Nqd5sPWVX726Bg61w==
X-ME-Sender: <xms:dYXFZ62gdEevaGIZpkJbdMXjN_hV-S6pyg8EXCvuWeImLyEk63p_-A>
    <xme:dYXFZ9HzdaKxROs3KwaA59dZIoAlctXHKKeUw61PIKi7oQpKnhb3fbEuAfsHcsEPF
    JxTntfreoa85l5msw>
X-ME-Received: <xmr:dYXFZy7uUh9l0UUeSjGk2he21n9oQ2b8rRFgTs9XoFOeN1KvM21yfV0243tj_VgfRFAcDWBVzRCxMB4cIm8dJCpnDZhnn_KY2qul6wQYs1g-CaEn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    ghhruhgsihigrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dYXFZ70pmJMSlpsnHpBLvphzmOfPz6HmmSk7L-g9pllLjWA3gpRUbw>
    <xmx:dYXFZ9FXySkKauWEINFDaC12HlkInrsEPRyHbs2vfT9aEAYZdILNHw>
    <xmx:dYXFZ0_GMmN5vpdtkyKhHzvi6ytOTLKzGR9FSYnkVqECRdzZsHzhlA>
    <xmx:dYXFZyn7OqCB9ysvzv-XzQV4qmwIOZAAhM7bSAJyNAj7CsrQM9e_HA>
    <xmx:dYXFZ9AGyvK-XQ4VbVBtIW952KxOECSqNk-wQgs2GBWcQ64CgJa0n91N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:33:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b3e3ec55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:33:22 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:33:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
Message-ID: <Z8WFcaEtMCD5C0EN@pks.im>
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
 <Z8GVAjwZWOM7c2fR@pks.im>
 <xmqqseny40kx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseny40kx.fsf@gitster.g>

On Fri, Feb 28, 2025 at 06:15:42AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I suspect that most environment variables shouldn't matter (for now), so
> > overall the duplication may be acceptable:
> >
> >   - We need to unset a couple of variables, but we can probably reuse
> >     logic `git rev-parse --local-env-vars`.
> >
> >   - We need to ask Git to not read the configuration, which we can do by
> >     setting a couple of envvars. This should be manageable.
> 
> "Provide a controlled environment where Git pretends this is the
> $HOME and that is the $AUTHOR_NAME and so on" is much more
> preferrable than "Tell it not to read", no?

Maybe. I guess for unit tests it's a lot less clear cut as most of the
tests won't depend on such a controlled environment. So sanitizing the
environment would be a good enough first step for me, and if we see
demand for making specific information available to lots of tests we
could still start to expose those at a later point.

Of course, if the author already wants to do both steps right now I
won't complain :)

Patrick
