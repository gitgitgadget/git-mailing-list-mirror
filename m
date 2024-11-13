Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE935885
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483432; cv=none; b=T2XV/rSCzI64UZPHPfv8ddhOAclu25z5qrgtEykM1iC6GH1GSb4Tx1PRfVisGZzhdzYW/lKqMxpQk74xg2UzKGuAez1STBrF27k/HuyDEByKLW1OqDbPGWLZNqlPLqTmZDudz6XklgLzyGMidd6X/CDJMgCxlRxnKO2yV5950Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483432; c=relaxed/simple;
	bh=FrfP1DDKF0buCy24TrR4n7Ilz2p/TyKe+XkISi4qyoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqWaRikksWFpM2x6MRWFjUftRwBfhXXrIcgaw15E7siewm9/gT+6qDDX7EC2w/4FY512RU3iXxdExIYnT8FdzqdqUHo5Ht7m1M+gvT5I/GIuDRB/pOnjldCF+s3TzHYNcA7e+LirPZU81X+4gk2RkqpzGlGDRjiac6d6f9BhCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wpIurWBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMN5UZfZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wpIurWBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMN5UZfZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 407E51140190;
	Wed, 13 Nov 2024 02:37:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 13 Nov 2024 02:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731483429; x=1731569829; bh=HgF82wIqNK
	8oBKmE63oX7VbXqEhX3KsQqj2s9LBgo4Q=; b=wpIurWBrRRmlPYw9VjVzHeZScW
	nI0nm51A9Rnj7fuyQoASCsgO5MAjbWhhMBjc0TISCCkslBhhPjjhKOJqWNLco/rD
	Gc7raChtXxeiwm+6hO/2C7JSQ5dkQUrXRKUFZlHP5oS+EYa8U7qsgwVtiX1/VNp4
	VEtru4Ah4rCJTiB6PQkd+naTJZJXfVCItzk0b7U/n72rRUzz1bHOH8rqZaB2m2BP
	a6y1rZrryzY1Yde/z2sDgsBNcW6DihNZShiYsGsuRtK2tcxRxV6jcT3Q6aZqKbFU
	88y6p6IkaW5zhgX7+D1n0LGDaNnm9m/kWvNYFIJpp8n7Ji1K+ygV600rANDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731483429; x=1731569829; bh=HgF82wIqNK8oBKmE63oX7VbXqEhX3KsQqj2
	s9LBgo4Q=; b=TMN5UZfZtK/5YtQkUHCnGpUBbjL/wAnaJ+mTJzVtwqNFIMIXGFj
	ymYFrEAIfRg1lzkPWaqbJGXyh6QzhDTYaGiA2g+RR07Iprhn1pMigZnQ6/NCMKsz
	Bjx5rVccmfo/FI78fFdp/93IJS2j3pCA9kC8AKqj9QUjIq0lxCVvE/YjXNeDFrDu
	PP29KaRYv16NsglbChpqBzPYVPe3gOpJ5qKR3NxFoDP+xQG/2YIICKYRJVBd9+uO
	kPGfuOSO7BVwVdzcW0f4ehtvQurfB/hrGcNw9llJYwswhni9wCycydDon+G3w6vi
	UovylEenQs/KmPAjpDvQVZ/nLRLrWecDGPw==
X-ME-Sender: <xms:JVc0ZwAuyzV-uRob70X_fF2JAdeSsWvo9YuSCkVA_asBgDwlmCncZg>
    <xme:JVc0ZyiyzCJEuJvP1YUm7qnKKxmUxGHoORj0ArrSb_XM8tpCO1KSYlYUB2p0EHoEq
    EJhMSntsr_Ir7O4zg>
X-ME-Received: <xmr:JVc0ZzkjeJ3r25ro2sXX4w0lCuS75mhG3Mr6IviOTgAVc9MYiIL7qLDfPEV8-MtwK3dzw489s_3n2TzZdL_9owa8LIhBFz3u2pWKoS5j9gTe7xE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeefvdehtdegfe
    evtdegieffvedvtdeffeelueefgfeffeeiheegtdetfffgkedunecuffhomhgrihhnpegv
    tghlihhpshgvshhtrghtuhhsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopeihvgifohhnsehrvghvihdrvghmrghilh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JVc0Z2yhOye7k7whIdSmvcWEis7X0YnhchCGNGqw-upkGY_Dn97B5A>
    <xmx:JVc0Z1SHPvuvfvG2ODxAZcB0oPOQEhZUuIIQDHoUoAsQDFthMqxNjg>
    <xmx:JVc0Zxazi0Fi5_SlMGtTElhvzbY5k1UaKy3c_-_5rzeSnMcscnIxog>
    <xmx:JVc0Z-SVRgrf5UGd7t3L84Gn5YwaRvP2ICoZku_7cnQ4y_Loa4-j8w>
    <xmx:JVc0Z3clE6ljdCWNSmJZmbGoajBGoUjtPPKV5RBAMEn9_uswQgRce4pt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 02:37:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 949e0a40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 07:36:29 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:36:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Yongmin <yewon@revi.email>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: update to jgit 7
Message-ID: <ZzRXGi_c2ncEJNu4@pks.im>
References: <xmqqmsi3262e.fsf@gitster.g>
 <ZzRP7cR6S6YCWIze@pks.im>
 <653fd6b0-0351-44ec-ba31-dbae0e2d3ca5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653fd6b0-0351-44ec-ba31-dbae0e2d3ca5@app.fastmail.com>

On Wed, Nov 13, 2024 at 04:35:44PM +0900, Yongmin wrote:
> On 2024-11-13 (Wed) 16:06:21+09:00, Patrick Steinhardt <ps@pks.im> wrote:
> > Seems like all of the downloads result in a 403 now. I was digging a bit
> > through the mailing list archives (jgit-dev, eclipse-mirrors) and
> > couldn't find any hint as to what is going on there.
> 
> It could be [this]?
> 
> [this]: https://www.eclipsestatus.io/maintenance/456545

Oh, that I didn't spot. Very much looks like that would be the root
cause, thanks for the pointer!

Patrick
