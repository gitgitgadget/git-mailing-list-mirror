Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA415099C
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678422; cv=none; b=GzaH30kn2fvHpbfDaJ4k6Fu1hJkVsDBUbefWc/uJKg40LBOjLMcx9nVUMNK+S1a8oWT2dWo497ekxnss8XNXyFzI/0oMwmv0Z9WB/S2yY12WFyngU4bf3uIpr/ZXTpLh0ebDL50wha6ffL4fQBgW/n1gRc4a/JUlqarI/OKdcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678422; c=relaxed/simple;
	bh=TiJEyjqN3ZU2ACeCa0X9yBIa0jo0i8N0RBIEkzqr9co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNowZU9IgIUyKjZiqldJmlHfYI3zxMjM+GGWwkDdTaqAIUnRlyAzYY4dCfABc/0hXpXVqw5g3hbk/1exlWWlqb1exg+1fr8qq/BZdlepViEcjUa//WfXaipP9krqbVtEecAbQFRoQLZfV5wN6eY6czvSzONfhUhYATQEGBx6/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PkFcNXig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9McjN+W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PkFcNXig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9McjN+W"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB4D411401E0;
	Mon, 30 Sep 2024 02:40:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 02:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727678418; x=1727764818; bh=eKtTStIKbx
	0wo98qEwadoH3lulyM4473BnD+2BsiZfo=; b=PkFcNXigLwTBAEp/5bQYbqyp71
	AARNSsr0wzckD0wLeu7PZVvmWhxm4IbJ+Wm/Fey8fUU26j3Ur5BLZ2aH7aBileJ/
	Mf0SFZ5TVARaMwe71/+YJl0idu6U+91vjDj/edBNnDiOypTpLJlzMGrF2fK2JSub
	gsAqold9EQWHBP4sEhy0dHGGAnWwFJHwGVkPpuiXlIpZ7jBj3/OEkNInvCMlc22o
	5I/CTFcvyiPeqgyIzTL/Qq1/7GJx4UzegcTa2RZNyG4ZZwYeTsGJXZxGfB9TkWrl
	czm07svvpbbSi6lYG53dKKjOLrGCAe4Uk/AfuCns7y3mVCnGT4pRZLyRXHSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727678418; x=1727764818; bh=eKtTStIKbx0wo98qEwadoH3lulyM
	4473BnD+2BsiZfo=; b=i9McjN+WRXIFdUzDkwkCLMAlMfGJXcr8smmHWGT8G5Qg
	WuUM8VWxH16qzeWyKoMqymEGoTHo0ghZdmNs+D67nFKIhPT2zBr7/bw124vMqc2y
	Lpf5MYNvN30JNi8h57WVKnxdnWlNyBDic3O8kyqms310sb7sIuVRKeXrU45M45yg
	9BcKohS5Q1WAeqIwaXHl7lTArqYhaOxwA7bEsub5azUjhr1PY+mEs6rwKZGk1iu4
	TAZqt80b3PqAefiD3aML1GfmaXudHoIEdYyB0dMKFobe4/ghgka4yRT7FeEGJBBU
	o3D/3hjIbyp1t/gb3y+/nr/GhgZ93Bve4m+WXpKQyw==
X-ME-Sender: <xms:0Uf6ZrP9QeakDgiJQMVoPuy-77PaKMx26MC_SwVnl9ksiINpGW_HtA>
    <xme:0Uf6Zl_zAbc9RZlGVu1n806nM-4cEk5NzmPIVElptil8TYll6pktfJbRCp6iMzmeu
    l8RfMokjr0s2yry0g>
X-ME-Received: <xmr:0Uf6ZqRRcGGwHpHZbot4QUuNfFTpn7dqG0O7C0DIjFEf4Yk0lMMRPcwfORXLymr2dQRnXFdvLe2fO2dp73cD6lLcwf7FFJEAZLM_QbLDb4USSDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhm
X-ME-Proxy: <xmx:0kf6ZvuGPybtySVbvaCDrObiu4oyInB79Cw5z-RAKS7fzSJElJGnVw>
    <xmx:0kf6Zje_-bHExATlsXEutjCq9jDdO9LM6BqAwXGdKD4ZgeNv_Lw1PQ>
    <xmx:0kf6Zr1wvKJ8GCwGcgLJbjgbkRsb6zvwPXHL-NPV0GeJSERfR17_vg>
    <xmx:0kf6Zv9fX96pUMU49JWgHmrZ6sJPyC2k6iphIfECyKVUkrBASGz86Q>
    <xmx:0kf6ZlsT21S__K0bpT7T05dMtmKGaDZCKHyg6WgYDr4tfxfAMT3ksC_C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 02:40:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5040f2e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 06:39:28 +0000 (UTC)
Date: Mon, 30 Sep 2024 08:40:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
Message-ID: <ZvpHxsPc8IABtIDo@pks.im>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
 <20240919121335.298856-2-bence@ferdinandy.com>
 <7fecc442-8d5e-4542-8ce8-907c35db870d@gmail.com>
 <D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com>
 <D4J51ZYZXBTV.60W3NPNVL78L@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4J51ZYZXBTV.60W3NPNVL78L@ferdinandy.com>

On Mon, Sep 30, 2024 at 12:58:05AM +0200, Bence Ferdinandy wrote:
> 
> On Sun Sep 22, 2024 at 00:19, Bence Ferdinandy <bence@ferdinandy.com> wrote:
> >
> > On Sat Sep 21, 2024 at 15:40, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> On 19/09/2024 13:13, Bence Ferdinandy wrote:
> >> > Add a new REF_CREATE_ONLY flag for use by the files backend which will
> >> > only update the symref if it doesn't already exist. Add the possibility
> >> > to pass extra flags to refs_update_symref so that it can utilize this
> >> > new flag.
> >>
> >> I'm not sure we need a new flag to do this as it is already supported by
> >> the ref transaction api.
> >
> > Thanks, I was not aware of ref_transaction_create. It also seems to return with
> > TRANSACTION_NAME_CONFLICT so we should be able to see from the error code if
> > indeed the existence was the problem or something else went wrong.
> 
> Unfortunately, it seems that my reading of the code did not pass practice. When
> using ref_transaction_create ref_transaction_commit will return with -2 if the
> reference already exists, but it also returns with -2 for various other issues,
> like if the lock file already exists. I could parse the error message to see
> what was the cause, but that doesn't feel like a robust solution. Since fetch
> should _not_ error out on this, I think the REF_CREATE_ONLY flag is warranted.
> As it stands, it would serve a different purpose than ref_transaction_create,
> i.e. a "silent" create-only. 
> 
> I'll send a v4 tomorrow hopefully.

I don't think that is a good reason to introduce this new flag though.
If we need to have a proper way to identify this specific failure case
we should rather update the already-existing mechanism to give us useful
signals, shouldn't we?

The problem with this flag is that it basically duplicates functionality
that already exists, and it needs to be wired up by every ref backend
that we have and that we're adding in the future. Your patch for example
only implements the functionality for the "files" backend, but it must
also be wired up for the "reftable" backend or otherwise it would be
broken.

Another issue is that it gives you more ways to create nonsensical ref
updates. With it you could for example create requests with a non-zero
old object ID, and if it has `REF_CREATE_ONLY` set it would never be
possible to fulfill the request. There's probably other cases where you
can create nonsensical ref updates already, but we shouldn't add more
ways of doing that.

Mind you, if we go the way I propose and improve the error reporting
we'd also have to adapt both backends to do so. But that would be
plugging a gap for which we have no proper solution right now instead of
circumventing the current design by duplicating the functionality that
we already have in a way that makes us able to handle this.

Patrick
