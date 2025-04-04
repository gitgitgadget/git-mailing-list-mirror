Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F4847B
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767308; cv=none; b=UNZSMprYIQNkJPVvz2xkMlk7PSuD+5fGTQXCsKdP7HvoMrdDk544VQYjixOl6Gs1/DEmVAREVOCpYOvbXFIuofgMkf0hSD9GRZZLg+m6wONktOYh1KJWePA2DuoXgZJwVckRMOAO8lBrMK+eykNYHzob/zQNYB5RYQCcTbPG+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767308; c=relaxed/simple;
	bh=s00rfgsvDpplmqvSKBRC//Cp57SL8yCxYVM4TmnXqhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DASCi1KGU4MCSBagWaabeC5g4pyg6ycH9omN36oWzu6joHlZT9+YpBWfg3G67yqd3DaZFZHKCpK+rGnJFs5j4Vln3OcTYMV5CDl0n9nIO8UbpviDLtp/wGW2njAqPvcox6YNiuX+CKlwX7ZGrr50U8kcpuh9WiFLkADhkpLiknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kStfTd4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uuiBLZrM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kStfTd4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uuiBLZrM"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 445222540150;
	Fri,  4 Apr 2025 07:48:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Apr 2025 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743767305;
	 x=1743853705; bh=j5lEtAoXpVOnCQkpMUEdNCZh8OZlGWuESis26ehC5+Q=; b=
	kStfTd4gapvdOWDazoqgIOUtRgjojoz1ff5cojjarq3sHIED5LaqxIzLqhzf5zlA
	DW9TjYlLarPQni5L6dHABcPwixKJoEJQSfKp5u8e0Hf4PO0todh4FK0Kzt6mBRSk
	ov6ZXSP4CISgwEhQLFcQGHh5cKliyfqkcuVpGLKr3Mbf7s+LKq4Hz+dDiyrCRPFQ
	YVAdnd0eUY5DY3vhXS60oQOuSVIEpKXO9/NJ7i0HfxoOe6ZQ1SZOPn45aJQ4XDxH
	9DiFuJgNNntm4WelDTSxKSE2weeh5eWnPmcVDLJn9NWpO+08I9WkuyVM4mUAbARm
	80Tj+x95A/o7Yl116MnQQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743767305; x=
	1743853705; bh=j5lEtAoXpVOnCQkpMUEdNCZh8OZlGWuESis26ehC5+Q=; b=u
	uiBLZrME9x/y4gGjhDGDrku/gLcUznRof1JSqNY4YjGO4vmNqA4jl35MRekDszIK
	rb8yPhH1JhQ1iOX0hpEgXzX6+i87j+Qx0IZPewhqSimJcN3Ez98EgtA5EI6v0AZc
	S7FSS8KbvkrsHTO9JfplOTE2II6tBcuq6oSYS/4T1DuGSwDci4enIU4zrWRaQNsO
	ex5Uu0f95amhJVYbP6nsjrpmupLBBmDWEBioPq8gygCwBj035IeezYBazxBFQ/PF
	C6PEUUSN6+uu3wmyPqVNr9lAurKYqO6oVX3b0DysmvcW3waqpgZ/eYmF9N0mgK2J
	Htvu0vH9W1pvdrua7x7Cg==
X-ME-Sender: <xms:CcfvZxhyeWEaRoFzeFluHWe7KGDJAv0cq8Q0SoqoKdqSHELDHfyGYg>
    <xme:CcfvZ2BATeNPiR0XPzgcnM9KXMf_qq1BZU_Kx1p4oPHBhIuCgNqgY-WirVGy0pk2p
    FGCHt67cNHjaoFduQ>
X-ME-Received: <xmr:CcfvZxEBm78J2sYb0CBOxQZmHQoa2eEAWTsXswmWqdOXR254S34w_wS4jnXd_ybrOL-gw0Z4BgA-kwrrkpUqKPpZqWFrd5VcTBPyubFHNm2DDjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeegkedthfduteekudefuedtveetveelleefhedu
    udffgfehgeehveffieefieehheenucffohhmrghinhepghhithhlrggsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigr
    mhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CcfvZ2QmhNY-QjzkgXvD4VVrBiRRnyUO1PRUY20pKb5VvP7cExWD0A>
    <xmx:CcfvZ-z0NWnnyKwPhRC5-edVZOqd5t-Fnmnw1ea31hgg0xnnwwolcg>
    <xmx:CcfvZ87sezhU-mj9iEOMSYmWqA2W4Pzb80UYVhFEJdVIObzZkhAiWg>
    <xmx:CcfvZzx5CshMX9L8AL78jfWI9OQpBaSnu2Av1Hzb9kqAFHqArJp7kA>
    <xmx:CcfvZ-4Pzo93tmIj0moNDEgo37IYTlZ8alEohgIrUYb-OXiYVC5V_cFr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 07:48:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e46cfca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 11:48:22 +0000 (UTC)
Date: Fri, 4 Apr 2025 13:48:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, shejialuo@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [GSoC][Proposal RFC] Consolidate ref-related functionality into
 git-refs
Message-ID: <Z-_HBe1lOu6_oRbr@pks.im>
References: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
 <CAOLa=ZQ4nTP7Ls=JsnQSbvpvw+OhjXqqoQxpsTKA0x-HxaDH5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLa=ZQ4nTP7Ls=JsnQSbvpvw+OhjXqqoQxpsTKA0x-HxaDH5A@mail.gmail.com>

On Fri, Apr 04, 2025 at 04:46:58AM -0700, Karthik Nayak wrote:
> Meet Soni <meetsoni3017@gmail.com> writes:
> 
> [snip]
> 
> > Command mapping and naming:
> > ---------------------------
> >
> > I have taken reference for potential names for these subcommands from Patrick’s
> > suggestion (https://gitlab.com/gitlab-org/git/-/issues/330):
> >
> >   # Replaces git-show-ref(1) and git-for-each-ref(1).
> >   $ git refs list
> >
> >   # Replaces `git show-ref --exists`.
> >   $ git refs exist
> >
> >   # Replaces `git show-ref --verify <ref>`.
> >   $ git refs show
> >
> >   # Replaces git-symbolic-ref(1) to show a ref.
> >   $ git refs resolve
> >
> >   # Replaces git-pack-ref(1).
> >   $ git refs pack
> >
> >   # Replaces git-update-ref(1).
> >   $ git refs write
> >
> >   # Replaces git-check-ref-format(1).
> >   $ git refs check-format
> >
> 
> One other command that I noticed, which we didn't talk about it 'git
> reflog'. I would think, it would be nice to also fit this as 'git refs
> logs', but it doesn't have to be part of GSoC.

Wouldn't that become awkward though as you now basically have
subsubcommands? `git refs log expire`, `git refs log exists` and
related.

Patrick
