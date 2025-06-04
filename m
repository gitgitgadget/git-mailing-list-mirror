Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9290221FD2
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037932; cv=none; b=hTCHaSnF/jW3lGOlZghnCalVUPtf8C+hC7M9relVkHmAlWTXy/z9rQvM3Qx2pQola6mZXKQ4zxXgnm2zHdNUogntyDChch4/pkbRwctIlgZrqPJqPxiG3tHShxydGpW5ccEfV+NQHT4FSHhosM47z5bczTuxYo8pwFqTbS1Bmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037932; c=relaxed/simple;
	bh=unol3GfPxSyvcAk2SoknwCf6JV+iYdqsYD/6nT6isco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTyMEgy+h6gcZuky2PEmX+OU1r9sQ9c+P4yfJDcbn7JreAPq33YSM6m6h4vlzkGNGOFJEDd+h7LglhRMNvKKNFM/Gu9Vg4/UJ482zBL1CmoHNt0jk0Nt+xLevXgwOq33OOLp2xjIPI6YLlzRAc/QGUNKqsKaogFRmy+3BPiZrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MsOfX7vb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbsaTzTp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MsOfX7vb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbsaTzTp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 868531380404;
	Wed,  4 Jun 2025 07:52:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Jun 2025 07:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749037929; x=1749124329; bh=4PJy9EJ7Bb
	7+Ex443WtXXue1ZMMJTVjzK6fmeuOn2WI=; b=MsOfX7vb/sErVsdaehr1u+Q6Fr
	1qyPOPrFQeudC/XWMcXCmozGbncR8UPr/gz3z7wHyxp733sn4iRxhkoxxh7qFCLa
	c0jSBwhi3KSf0++PA8b5jbD7pxLfT1kE/rEf6Ko2ZaiQKpY9ZZNnyYO6ps3vpcOR
	zDwRpgmcTbfmv/poN1kOegnAoRrzTySp9lg5Jdni63YrqBL3lIPs1CVsmdiBaRyM
	a0VDMrZpDDvSSzVeGri/U++R2HTmaaQncGKd5UBphf/mlubr9NvPAuz5MnCtPYAS
	hpnnWsa723o/46aJ4h7Tmz4LH9s1kEmie94d/IV62tGoRADmLpXTL6VygwnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749037929; x=1749124329; bh=4PJy9EJ7Bb7+Ex443WtXXue1ZMMJTVjzK6f
	meuOn2WI=; b=LbsaTzTpGPT8baHG6feXt9PMtKJ+jF2AsxLGpFem55UmyPVycDg
	SSfeEwOaqfYFN5FoFQdPLRLEd+Z5VrmAGq9P+MwjCn7OXMURfTULZlOGm48XMbdd
	1FJ5rEbzQpewL1hGcBNznLgeZuMVH/SO+E/mm1dtk0VHuoo6nP/cpp9jhWxZl3gl
	aD361EPOOqtOK4WPl3AnTNMUCU4n/d98hbhaS2tCtzg+tpnsAorBieVxvDfk90BP
	dha9sxkQJ1G5tfmtHZQe74U556Ox5ZQEGA7jy1JdYkNUaKM/2dLFDW38CxPEkuto
	/M4Z3ew10fbi8k93J2mrq9RoY8/m/slMZQg==
X-ME-Sender: <xms:aDNAaL3InKfbLnW3gCH6JdwtjUv-r2mvUQaln6v9cT4DP8u6P1XbiQ>
    <xme:aDNAaKFiTXbPkuMFVnwzbQHqWALs6SZ5_HdVoo7FbUc9_j39SOjIMvtybqtbg0iJE
    M5kC1LtQ9GbiMipeg>
X-ME-Received: <xmr:aDNAaL78W2fJwAj4-NJqnbuzV3c16New7ndJSep2vKEfx-1r8QCX4iG7jqn_MQSKBypmfW9zd_3ZrBpRtCxT5eXOpw9OFxCEXhn5RdT9jOF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:aDNAaA29SK9t6PA5EaNrS-gyt4lkPeeSULAXf5Pwp8FrVAnjDn5EUQ>
    <xmx:aDNAaOHwEcZl9iwqOlQHRSya-EYnn_kD3I7lCSV7nRtzgTVfwjTJEA>
    <xmx:aDNAaB9SYCKzJdXwFFQ0OWqMCx-ES9IBmtsCfPks7vj4ltJsJQtgrw>
    <xmx:aDNAaLli_DVGfDBEY-Lv-EGG6PCDgUpo9jq5F0XH5w8unjpIeD5w_A>
    <xmx:aTNAaEee4_9uy_MdAz8gxV_DPtUGMn0jc85BRDen-yYy_I2lMwGy3lEO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 07:52:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63ae2ecf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 11:52:05 +0000 (UTC)
Date: Wed, 4 Jun 2025 13:52:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 01/17] object-store: rename `raw_object_store` to
 `object_database`
Message-ID: <aEAzZLgPWCGwdpiE@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
 <20250602-pks-object-store-wo-the-repository-v4-1-e986804a7c62@pks.im>
 <87a56n3myb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a56n3myb.fsf@iotcl.com>

On Wed, Jun 04, 2025 at 10:55:40AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/object-store.h b/object-store.h
> > index c5890085352..a3be27d1171 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -87,7 +87,12 @@ struct packed_git;
> >  struct multi_pack_index;
> >  struct cached_object_entry;
> >  
> > -struct raw_object_store {
> > +/*
> > + * The object database encapsulates access to objects in a repository. It
> > + * manages one or more backends that store the actual objects which are
> > + * configured via alternates.
> 
> This still uses /old/ terminology. I think the "backend" should be
> called "source", and we can keep the "alternates"?

The term "source" doesn't yet exist in this commit. The next commit
touches the comment, but _that_ commit still uses the old "alternate"
term to talk about the sources. It's correct to say that those are
configured via alternates, but the alternates do configure sources in
the ODB indeed.

Patrick
