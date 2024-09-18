Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5613D76
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633886; cv=none; b=IbRqfxr8/RxBHKIzMYP0o45bY1jJytg1mBxXwX4tBn05dQ/i7BlxD8QKr8EP4lAgIgdaDxJ4D3Nbm4TEaf6Pj+BtK4DciysT/4DWZ0UcyeYHs9xE+ynBtUU4iZ5sexNU69uTQdEsKKy1t3EQ+/wc3vl3xtuzy3Xx5pE3TeUzq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633886; c=relaxed/simple;
	bh=zfR7btalq97rf0noXyET1QOLE1LlsxyZ9QekwkZSVos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAIwNkocZHua1gVRhsyBxP49AOSBUmv0zD/55aBwT6O3D86xqmbIEmNI3eblXhR0xvHBjuG1U8smB98RaWryd9GXuOVVDcVaznCgVL5v6baYEahnoUcMONNQgWnjn4klgvzTplES30olU56AN5XE7P4G2Bwsv1X+iteQvSpJBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E0yd8jUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZIzo4v5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E0yd8jUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZIzo4v5"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 68015138026B;
	Wed, 18 Sep 2024 00:31:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 18 Sep 2024 00:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726633883; x=1726720283; bh=G9/twKsfMn
	pAKxzOfkNIUI5Zy8yL8mH13CCdpiJts5M=; b=E0yd8jUwkJeN4VseHh3nlFN/Pd
	z1FbA+Go9EMD6pt8kVSyrvm+OxsFLxNn9fgGH82qJjGOU8ulUCJ/LePAAHs8bEnC
	1oGXPuRqkYrp7BJPuV/Tffu27yqlAk5giVmNE9ewJzUQXpiACQQVsdfoEP8w8pe2
	c1xd/drMM7AgzENTo4072Et146xnONLYc8/lw+yDVFRpBeq0muxF+fp1hcB22hpb
	sUdCzkonVsGcvWvqMVclxTSMy/4UP5nsPO45voB64g9eZfonA1d6e5Ib+zmmS2Ze
	//BmjbT/c9jjOIGiW7//+A3DJDYA/+9XbS8UBX6dGz8ItesTtwn9/kK+UiaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726633883; x=1726720283; bh=G9/twKsfMnpAKxzOfkNIUI5Zy8yL
	8mH13CCdpiJts5M=; b=EZIzo4v5EhXd8qr/iUeOLBMxS5jGEU85GZgWZ6P6n90C
	HhLY75zucrBeL8ykAwPkE7UTGCj5HIpElVLST8ay0cL3mdeVQ3zvq/Aj/PPDtm3i
	N7sAsSpmRBAwfTSf7+ZukTDkf2FIlNf6CmMXyn3Zz2/iDPicUwmD31RjSN8tEalL
	GSS9gsiAgvUc7iSCYzg9V5bikoiEu5XZz4wY1qATMlOo/JVV15ULmGWPNvu4zdGb
	n18xswEaADbWTuqlaOrvV9nRnVzY3g9uLhSdAw7sfDASFPwb8CLGAunoRvaWAbJQ
	kFwQ6xGEougvTpwelPhgKAXUm3odSfYm6CmgLwfJCA==
X-ME-Sender: <xms:m1fqZqOhcWUsw5b-rvCyCdqoce7iUW5vcqzPxOPwmvOpkc8F1qC3AA>
    <xme:m1fqZo9g1OyqPZ55_Lpboj3OWRxwPjcudxxx9SWdQm6hoQvI41a8_18b3FJO_3zm0
    GL8Oi3ApqWQNoP7rQ>
X-ME-Received: <xmr:m1fqZhTvYaLgCj8ZB6YNRUAYrcvM2OgNMcDB2oXJ1_EHTPnaDw9TBy2pLMaE12uK1KHVTTSmEesdnlj5a3CvFv4JOHoZVrC9xPD_Qf44nxnMtrl2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m1fqZqsv0iOLy47z81tiRylZ8K6mliwiIyFdsTMHPy1H7DdvsPVXvw>
    <xmx:m1fqZieyOY8dCu2uEJOVwZEXeEjuU8D-1YcJ6ZrPlmLnaXhMEvmRIg>
    <xmx:m1fqZu2AemDxJm8VhnzOJkQD_z9wQwH87qb0_UDxIYtzMePY18Gmpg>
    <xmx:m1fqZm9kF_e8_xdMw2_hldFKjoBQDyjjWtTUKxtSL2SutATYkNeHKg>
    <xmx:m1fqZjo9hAGRjGVQ8mQkjM9L_k9_s5MYqha6dEi_dCBHnmFztZYm3nS->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:31:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8df6ab05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:31:01 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:31:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] refs/reftable: introduce "reftable.lockTimeout"
Message-ID: <ZupXmXtFzw6GuGGT@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <ca3eab99f7ef86d1b7a5b4d4bdb8d2b0a55566e1.1726578382.git.ps@pks.im>
 <CAOLa=ZTja-nFmKZ8iyyp0szuaAWAnPncy0E6rM5=WWgnr=01uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTja-nFmKZ8iyyp0szuaAWAnPncy0E6rM5=WWgnr=01uA@mail.gmail.com>

On Tue, Sep 17, 2024 at 01:46:39PM -0400, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > +reftable.lockTimeout::
> > +	Whenever the reftable backend appends a new table to the stack, it has
> > +	to lock the central "tables.list" file before updating it. This config
> > +	controls how long the process will wait to acquire the lock in case
> > +	another process has already acquired it. Default is 1000 (i.e., retry
> > +	for 1 second).
> 
> Isn't the default 100ms? As that was what was mentioned in the commit
> message

Oh, yeah. I ended up changing it. 1 second is the default timeout used
by packed-refs, 100ms is the default timeout used by loose refs. The
reason why I ultimately picked 100ms over 1s is that our usecase is
closer to loose refs, because it is our "normal" code path that we hit
whenever we write reftables.

Will fix.

Patrick
