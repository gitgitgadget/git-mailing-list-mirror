Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F52F998B
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933621; cv=none; b=t8CF+a+tbWmr/zy7pQ07AL7xBUCwUiR6m5wJdvqWII/FRvuglfoc34jpocNEPEH1AWsM62UzQHd5kY7dbu/vMRCXbwlAc++26ZGp+iMfDTJ/1W0T99b9Fr6wRDqTD2YqCYmtAarbxY3Wk5+YopQgAgAFeAQu/bd8n8bbSlsB0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933621; c=relaxed/simple;
	bh=u6rpbaQoIqhgoq7pR1Sb1/51qeZwdmRZPNlX1L2DbMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWfzgMLmHCDebdJM23QEBPD2J7lOBzYaRKw8T0cHKDv0WmFluw1rcqR+/xc9sCVf7ml5+5IfFczQB8TVYXp4NfJDsSEBZMf1B45ar3PLekW/aSTq8A1czZUWL9HIY6MM7zoq0LXjkj0Fr74ZuRwOFNnPcsPQ0juzkKihp29JExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YoOE3dYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aE0TOKNg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YoOE3dYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aE0TOKNg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6089314001D3;
	Mon, 15 Sep 2025 06:53:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 06:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757933619;
	 x=1758020019; bh=Lj5vHiopQr8vWi9ttr1goJiEjsRtK5p4EowkxCKwrwo=; b=
	YoOE3dYoBz0+9A1Ts6BgxjfjKTj9a7i6ZVbztk9yX5eUEKHkB4w8QecAdXz3Njo5
	YoRpaBPhj/ehaLGhg4y32B46xFA9gHCzXEMlEacyhBidpcEFnZR+AqazniYWvjfM
	V7PyeiweEeLfhSsobOFpt/ltpXPGZ1n4XKGMq+9SeGDQ7fQgA/P4eAZ/xV+wm6bJ
	sO3pL4NmJfCqEH9Ij4WDZObxjNSLESQNzeibn0dPdUUrPLQAVEPaBHKBlUbvj7Hk
	aI7lct0ktDxqGUmmFLa2YibHJw8aU7OuTsMRangRCpDakgXT/plvsuhkLvaqnBZU
	W1d3hkF4cP09lT2bh2eV6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757933619; x=
	1758020019; bh=Lj5vHiopQr8vWi9ttr1goJiEjsRtK5p4EowkxCKwrwo=; b=a
	E0TOKNgQKbT2ORRiHkmm90aBi68bBag6YBGIoy9kzG01Xcz/+nTZa+Xrm8RHuiB6
	h9rz6LNNZMz75Hz6qo1bHvSu2LLqmQsCBFbPc9aBguYs9R0eany746Kp18SZgD4/
	nfN3aGv96/m6TgmAlagmKlvsSm16blxsAzjO1w7DgiBDhtcFEatyAC4iO98ul8y3
	32OpdiIxrdVu3NE160PM55LS8sBRbmEMQwg/TS/Ark4NgDMqM9u21k1YFkcLEJBA
	kmIFNDWC/8vAwailoFIDRsUzfnSW91etd4rw9Xy4+cAW4Aseb2E4YjBIoe1zpSEl
	ymbof7ZwcCsEow4A4Os0w==
X-ME-Sender: <xms:M_DHaGanHEGQ-GUechn3M_pJ68tV2ZUTb5PflTE5zRjbm4le2YUWfQ>
    <xme:M_DHaKBahJ542vEVedQZT5oIlkRNSoB0xY7OybSZeT13f9GgJDOUevcAiIZG3AKxP
    er6DjK6d_wYvI4x2Q>
X-ME-Received: <xmr:M_DHaMEl2AnxzooaaqRstA0ztsrLzLNALc38ZKb_54hurUShl8Zys5553BdqKB5Oc4uF3BQvx57ZrFB3oFWNuKd2am6dN1lQuhtDV9vSGR2LQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudetheffgeeutdefvefgteehhfegveffffdtveeiffejleeuteekteeujeegkeevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhf
    uhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrgh
X-ME-Proxy: <xmx:M_DHaNODiqnCR0TS29Ab7SxBN_l_50JP6OIiMbHsz4830PPEgWo33w>
    <xmx:M_DHaFgSodaITxoNtTMQmVvnbEtusHqQLBqaINzglRYJmoCE8andFw>
    <xmx:M_DHaF1ngWabWCuWkXym24B7cYYhTHkH0UOZ3bkWnbUbQOvXrkvgPg>
    <xmx:M_DHaKnOOLcuzewhaNU6jB4B5jZncJBkx1VBmcmBVSepFDjpAZwgSQ>
    <xmx:M_DHaKKtYQGoI7Grbswauf2wr6WueqNGfA5036Ew-fWM4mg2hdnlkaaf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 06:53:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed8ba17e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 10:53:35 +0000 (UTC)
Date: Mon, 15 Sep 2025 12:53:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aMfwLCJkvJnRVuqa@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
 <53a9efd2-52d7-4520-81eb-2129ccfd26d4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53a9efd2-52d7-4520-81eb-2129ccfd26d4@app.fastmail.com>

On Wed, Sep 10, 2025 at 11:42:05PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Sep 10, 2025, at 17:35, Patrick Steinhardt wrote:
> > +These changes are meant as test balloons to allow distributors of Git
> > to prepare
> > +for Rust becoming a mandatory part of the build process. There will be
> > multiple
> > +milestones for the introduction of Rust:
> > ++
> > +1. Initially, with Git 2.52, support for Rust will be auto-detected by
> > Meson and
> > +   disabled in our Makefile so that the project can sort out the
> > initial
> > +   infrastructure.
> > +2. In Git 2.53, both build systems will default-enable support for
> > Rust.
> > +   Consequently, builds will break by default if Rust is not available
> > on the
> > +   build host. The use of Rust can still be explicitly disabled via
> > build
> > +   flags.
> > +3. In Git 3.0, the build options will be removed and support for Rust
> > is
> > +   mandatory.
> > ++
> 
> Some minutiae: the HTML output is like
> 
>     3. In Git 3.0, ...
> 
>        You can explicitly ...
> 
> But it seems from the text that the paragraph after (3) should go back
> to the previous level:
> 
>     3. In ...
> 
>     You ...
> 
> You’ll need to put these three list items in an `--` in order to get the
> latter.  Or that’s one option (that I tried).

Ah, indeed. Thanks for your careful eyes, fixed locally now.

Patrick
