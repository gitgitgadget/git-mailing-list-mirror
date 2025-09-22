Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C31CBEAA
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551928; cv=none; b=AOFpmHXhwz51kVekx0N1kkpdJDRdC+P6bUoQsisfmlpzRpLPqirUbmUzOV5feIuWwQaa4m2kexYf5s3bb/9lSoXsFBWc7uJjsX9e0j9F53RW5ravvxJ5m4gykvTKGsg5nCmJOl5ZciXU2qPzLaRd1VZme6EfL9dWhPHVcbfbENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551928; c=relaxed/simple;
	bh=rz6+SC4wtzmx1arJU8Z+4qaQPf81eBxxSryzc8lYPaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVikNl48CkiWeSzKMtZuPTp0rL5ysbZ0pcofztucZVwcY1CGswZm6iZdaAzBkNM5F0OBXxGo9qhUu5FPbNPq8vlQloz2TSyAeNqnAenlks68rbHmHgP+SFLj96uH0iLMO14ExMvZ2eqsGFuPfrM3JL1IBm0C3O2YGDLNvpWIlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IGD63DqG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUC1v69x; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IGD63DqG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUC1v69x"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CF051D00238;
	Mon, 22 Sep 2025 10:38:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 22 Sep 2025 10:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758551925; x=1758638325; bh=XLfUCZuCzf
	MU2LIQea88PRxWMkGtVKawoberzSIyc0w=; b=IGD63DqGI1WpiIcxh1itJ1JkvZ
	9pSvemtlaCV4OsXmvdYupfascDnp4Fr0Z04izXARYe1+IyljEJBoJS443x1Q1UFh
	/GLiscMeC0RWkcEAr1BtHGLU+WlLcR3f1AsWyfbLZUxlJnntnNjfoCXXiruW2lyS
	1iFVaABB8sDyS+KpxU59xpnE3FgkBBjRDPXb6+MkuUI+KgwVun7HnXLY6Ky3eMCR
	y17ieEBnWpXPsNwaVsFZ/1e/mDgpvQtWUnfVemY2GfdRZOtoQEdBDJHkC9GSk1En
	pNQWm+N0PORgu97m8OZ+kIo46qSpOD9mhW0D465SYZBD42DfaxzahAS8S0kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758551925; x=1758638325; bh=XLfUCZuCzfMU2LIQea88PRxWMkGtVKawobe
	rzSIyc0w=; b=RUC1v69xMAu5heW3WdDTtE6+QvXui2BADPuoiIFNHMWBrJKDOu6
	qDGkSFf+vZYHPxn2P22f1GdxaqJKC2llHn5d3EAdQ86zwD4K+JRaYI12CwLfs1P/
	2inR3SgnD131G+pPiSavrCiE1H/b2zLsQ0qopu3HXGNk7iyWd0r285pJsZE6VRk6
	eOcnvkO0GYVvk9oJk30+6wjffrP+INWDYQeXSrsydqmC20kiSBBYbeAmEvlNIq1W
	jcjWAyENfhirs8/JALYstTvJ/KBYS3epIN6p1ogv8F2gmmoBU4Y9eTnAc0Du6edK
	GGmmMuds/xS/cL5gRBg8+TH/st4P6jEbmNw==
X-ME-Sender: <xms:c1_RaCXc3kTnJBA8L22ddRNNZyw1QUo9M97ONo4Jm63BnfkLmv9WNg>
    <xme:c1_RaGLJWusZtE3Mh5AW1u-DixvYQ4Inp_BO606aenESVH-dw0z8fIZVBYm7x9Yiu
    NlHYqqQPx7JoZH7TpyhONia9gmjympeDdTdGVD_xxJmCr7fBelzdTQ>
X-ME-Received: <xmr:c1_RaGDVmINVeWYC2J9eFBmkdhd5Zie4JruiNBT8IzqivgYWZFkx-uU_hN2ux27PR91HFfqq172XL6-_TzY9HtwNxIiS6KlGhMg15ivSWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhm
    pdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:c1_RaGF5-v_As0te_c8NI5yTe9r_d2oxJWuf6kG8Acx88pqo6772hw>
    <xmx:c1_RaDJccB68xuaZgbWVO76rI3kjRrJRkogqUFiqPDncggJKelMogA>
    <xmx:c1_RaFprSiKz8236LQh6f6UoJuW1PvjjNBeBAMDcQ5li-nNrYEHEaw>
    <xmx:c1_RaCitFu-Vv0m5aFF3JL2sOiH3CQYoS4_9nD30WUCbcaC_RTnkrA>
    <xmx:dV_RaGshbb6HBcntqSuNlyzxceQ0nCQEh2wyHx5Oby5u9s8yccyn05Zi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 10:38:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b3be8ec (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 14:38:40 +0000 (UTC)
Date: Mon, 22 Sep 2025 16:38:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aNFfbGWbOl5ziCJV@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <72d0a316-ee3d-45a0-8122-77c52911614b@gmail.com>
 <aNFImn9toejLzIJR@pks.im>
 <f23fb338-3039-4c86-a36e-439d68d14acc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23fb338-3039-4c86-a36e-439d68d14acc@gmail.com>

On Mon, Sep 22, 2025 at 03:07:40PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 22/09/2025 14:01, Patrick Steinhardt wrote:
> > On Fri, Sep 19, 2025 at 02:59:58PM +0100, Phillip Wood wrote:
> > > On 15/09/2025 12:22, Patrick Steinhardt wrote:
> > > > 
> > > > +You can explicitly ask both Meson and our Makefile-based system to enable Rust
> > > > +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
> > > > +respectively.
> > > 
> > > This is helpful but ideally before Git 2.53 we'd make the Makefile and meson
> > > print that information if they fail due to a missing rust compiler.
> > 
> > The intent here is to allow us a bit of time to iterate on the build
> > infra before making either of the build systems error out. Ezekiel has a
> > bunch of follow-ups that we'll want to land to also unblock support on
> > Windows and to implement things we don't yet have, like Rust-accessible
> > C bindings.
> > 
> > Is there any particular reason why you want to accelerate this timeline
> > and make the build systems error out right from the start?
> 
> I'm not suggesting that. I'm saying when rust is enabled by default in Git
> 2.53, if the Makefile cannot find a rust compiler it should print a message
> that says how to build git without rust so that users do not have to wade
> through this document or our release notes to find out how to do that.

Ah, sorry, I misread what you were saying. This would be a useful thing
to do indeed.

Patrick
