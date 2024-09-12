Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5611A3054
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139833; cv=none; b=Pez/kmh7SmvTKh7l+SE8HXL2EAKiOPBv8PCGl+V9R68YijPTbFJFzWXBeJrxoE6h9MaSYR1oABUQdwSo6wysmuDTHg7H9efRrCdM9jgSv46+KVgz7FiVtA5GnjPmtY7MrO59pcpiEprf3Jf2k53UgKYepzzIvG/npmZ2yGeaTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139833; c=relaxed/simple;
	bh=nkLQ4r6Pc+24o56iwOlS/gZxgZkjIfFlcSbcii8LsxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg+f/pQRd9dv7OfmUUfs5ymAxOwpM8dXA73boxcD5Pa7izGMl9/tay6LvpkEMEi0ZMBKbgTojyhCHbX7zcsvqcA02wnOZKs6IG+F5AFAp+dcXOGcf8cLAWWpXWVBcKHnA5ST0T8wOKOxjjOCTj4Cgcnjhie9CmLMmN+auo/F5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d1tZsoj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=namNG2ic; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d1tZsoj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="namNG2ic"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 231F21140598;
	Thu, 12 Sep 2024 07:17:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Sep 2024 07:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726139831; x=1726226231; bh=lho6/ZGWMu
	l0hwzfzZRW7BQljxRD3P00q+P5JnRvJhY=; b=d1tZsoj1r4r4HTOwJt/i7zdsw4
	DnzszmXQD6WRm+H6lQCKJb9rkB9iaQ7kwVPsQDWTKmS5ipJpTyBhMh1LJnjPPx0O
	1kwbR8O1B2BH3uDVkzw7+LqRlUNQ9uvwAryq6TBceH4snnSZ2bx0JfEsisG050lv
	kuN4z5BddP5U/G7HLrAObuE83a2ufKlHhfsjaHiQZBfxpdIs+EpnRl8YyAD3jiEw
	yeGrRbVUCCbvkpqvyPB4RzR5NwibLg8Q9R4vSHNmgJVepMby+tkNha3KzNWdxXNg
	OCBYo6NUrD25qYsElcyVD08yHzZOUDeq3e0Ge5wYnT/K0Ape51EQYWP33EYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726139831; x=1726226231; bh=lho6/ZGWMul0hwzfzZRW7BQljxRD
	3P00q+P5JnRvJhY=; b=namNG2icU16dROgSN9eXGPppGi/SIH5Q0H269p7ClHSR
	WkNJeSKS9ElNtrN5/fMiWLoApadnO+PLHc41FcD/cJi03s/P9YZif2URx3V4Ch/A
	4rCd69qq2PsVbK7isRWK2n3YurkIddCVZQmOvSHUjNei/MtZgYfZqkmY3wmuPDl+
	uiKnM/qAgWsX2lCtNihXcJz8xhOUKh3H6wLTNluDfMIR/eiiclLFe4s9KVWLQ/rA
	ubfKxucKWb2+T6J4Siv8/fvKg/a1203GlXt1SSjgts+TOfv/zy/+kZHOSpbCUvzf
	tlyFDrhOWGROdkLEVC08wreLxM87/r4xh7kQgRt/VA==
X-ME-Sender: <xms:ts3iZiDLscVrzseq8zq3OdCC1LZx8NvPvqOvhKLNLhFSIFaMIJO8dw>
    <xme:ts3iZshYqDIFa5zBNVv4j_KfNEzxROx1cZ6OQ8A14mlBpU24IWUDDNtOfCj9NKAtq
    7DocAyjgmvA9hsazA>
X-ME-Received: <xmr:ts3iZlnVMRFlaiJTbJAjzbApLxHmTjsUM9u-DSxmGc0y5D4_SLMyJ8XbdxFoFQhgZlCXTp_z0Y2WSXq3SV1Kv7JuD4dir5HR2YsorXP5TMa3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:ts3iZgw51Tj-MdbcfKIJC3Kd2wW5-lp3eDKk3o8vgNVypdZKwI-PYw>
    <xmx:ts3iZnTWXf8pr0-to_CgrmTLKgnidexWYyh-w8ssGfDPyhYkmhpduQ>
    <xmx:ts3iZrYjd9UjbwDxEoK5ag5Oz6SqG0g1VdfoRmpmXB-HOO9cEdpqhQ>
    <xmx:ts3iZgRKNSC760EdnJ52pLJerL0uLVQspgXQXFY-FcxPAji6LUrimw>
    <xmx:t83iZoIcYTOnJYdvixicTFAAu1PpXjm8NHF1WhRDLLf4CXwH9XYRzOIi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:17:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d5afe1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:17:00 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:17:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/21] environment: make `get_git_dir()` accept a
 repository
Message-ID: <ZuLNtdd_jIbJaZZE@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <a1969c5b0734cacd0316c34ef3d3b1939f521cd4.1725008898.git.ps@pks.im>
 <CAOLa=ZQxVtFrZqFJ+Q+0ifj5h+x-7-ZE6viD9OUyNr2CvE7s-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQxVtFrZqFJ+Q+0ifj5h+x-7-ZE6viD9OUyNr2CvE7s-A@mail.gmail.com>

On Wed, Sep 11, 2024 at 02:12:51PM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/repository.c b/repository.c
> > index 9825a308993..6f43f2e8344 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -91,6 +91,13 @@ static void expand_base_dir(char **out, const char *in,
> >  		*out = xstrfmt("%s/%s", base_dir, def_in);
> >  }
> >
> > +const char *repo_get_git_dir(struct repository *repo)
> > +{
> > +	if (!repo->gitdir)
> > +		BUG("git environment hasn't been setup");
> 
> Shouldn't this message be more generic now? Since this function can be
> used with any repository?

Good point indeed. I was initially worried that changing it may alter
user-visible behaviour. But in theory, calls to `BUG()` should be
unreachable and thus never be encountered in the wild.

Patrick
