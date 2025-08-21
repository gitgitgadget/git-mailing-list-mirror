Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02D2BE650
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758451; cv=none; b=BKBNDJqQd/hko8D7BE8KQC65qDLDqmUFK5ipxMFOy2wypnOFebUCxuvEo16LfiZBbb5DIj0uDo8ewpWyWrdwifwVJLUmr2v2FxXyY078DFXZy3iSv/fGo+ZcpPyBxG5iHSIIz0maQlzcxsOofXEBhPb2bJw1QRZs7r1BTHQUcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758451; c=relaxed/simple;
	bh=s1oz24eWmDSSUWh19c1xbk1WjUgQLl9/B8HFlVTX+ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brUy6zQCDpCAYoT8xttVMN7KZ3oYES6icnwXn21o4sZhB0bi5DhR35fgeXz3TQdHkOJP0ctzlxhQfUnyXLtl5P/Glvgwq1ENsZ1AN0L1JYNpsGVS4pPwAc4SlRpPrXjcehF6Y7+wNUeba0Whg0pawm4XWDc7Bjuo1Z7t1/rKsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UmaPBdGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kjyyojOm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UmaPBdGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjyyojOm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A1C5140005C;
	Thu, 21 Aug 2025 02:40:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 Aug 2025 02:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755758449; x=1755844849; bh=IGH9kL3f13
	3t8V4nPco8kYtNOUNuTspB8i4QjNmRUTM=; b=UmaPBdGQLrqcMQdfVYlb/XUbOr
	lubPfSvYEHZjbE6xx8icHZbP4ep90O7Un5ffEG6LksT/jP0IV4qphQrsK1V2O0Of
	9sesMeunJQ8q5kfzvbvZkYUjtJiwG1ClpN96ZbDoPUj7GfUYGtTK8VTD25wkwwOg
	brOOSIvluQYg0JmV2Vv8Sw4owstuT8Cwy4YdnT3CaClyOgrkMEACNXmWt/uGJjyZ
	En3hBTMuXUs6lPaHqQkgyKi0nwSRDAmyP7ce6eYGB3PL2xbJnzQFv02+ky9KOuYI
	MlFF1zAWvbtL3TFPY2W+F0PkY5+stFsh4ocU9jB/j4Kk93r9YEE9Rd9elyzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755758449; x=1755844849; bh=IGH9kL3f133t8V4nPco8kYtNOUNuTspB8i4
	QjNmRUTM=; b=kjyyojOmrLd2bVoBVTMDtNGeLaBh+QamR4IYVp3n9xNZ6hmN9A6
	QPoCCkReF1szMIAuDfqQXayMAiS9tbJnGootRtNY/nw6TcSOseUxPI0bigj5H2zV
	MjeeLQP8UXsrGKdS2HzT3f1M1q8bCOaFfCdDIqOwXcSvjSY03lDpKu52CvBCmHFH
	RwqyeSDxOnYRiPm89pm9yYXVqlRle6lXjDJTse6fY+6OpF5WGkVYrHs4bNB0HQFv
	VOCxGuwm4M3B2VRxzBBZONWeW3e9jncuB0p/CFWp+LRFQwNl31Y/bk5sZnqCJQ7w
	pqdV5bnUvxxcMc4VssctIBOCRToVr25JWWw==
X-ME-Sender: <xms:cL-maJYIb5SMrnd4VbqiN2AkvaGfSHqm9agLodLWujZv-oAHDTlh7A>
    <xme:cL-maAlijid9QS8MkzMJlCBcAVpgfNKPOcD9dmsQlLcfgm2T7yzDNzWzR7hPgnSQn
    iTyfbnY1X8jtXyeOw>
X-ME-Received: <xmr:cL-maNwc2hnC3zuuMbPBl7ROYHf20eTR7v1yRFw0oGYNg9-eQOUgxBAARfxHF_Jz6uuXSRODHLY76yg7HJatCp0yPL-Y0aBvVgJY2YMDPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cL-maGNvYkSoF49lV2dkaD3_vFCu0y7-RNqCsaZkpZilOJVK_QnRbg>
    <xmx:cL-maJRK2LSWA_smpq7fi-QQRtY5cwEk5ebrf6C290PJaq2bHvzsBA>
    <xmx:cL-maMZrHUeMCIW_8ylg2V8ogiLWJfqB2bDlB1Dsrhh7pFbgUPJv2Q>
    <xmx:cL-maO2-tHY7QbPV55JY-jafrplBsFBPJ0w-_3tM2-1KIFyLheWGmA>
    <xmx:cb-maMquI-F5Lh2JECk9zI6O8qxd7-5zM2HoDrVttAK9VTnOwAImig1D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 02:40:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db0fb033 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 06:40:47 +0000 (UTC)
Date: Thu, 21 Aug 2025 08:40:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/16] packfile: introduce function to load and add
 packfiles
Message-ID: <aKa_bE1661JSNjQ7@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-12-1660842e125a@pks.im>
 <CAOLa=ZQ7MXCRbLk1S53urSxE8CmLza17684Yg2S6rhOSo+tyTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ7MXCRbLk1S53urSxE8CmLza17684Yg2S6rhOSo+tyTA@mail.gmail.com>

On Wed, Aug 20, 2025 at 06:41:23AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index e9d82b31c3..a26e79689d 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -897,11 +897,11 @@ static void end_packfile(void)
> >  		idx_name = keep_pack(create_index());
> >
> >  		/* Register the packfile with core git's machinery. */
> > -		new_p = add_packed_git(pack_data->repo, idx_name, strlen(idx_name), 1);
> > +		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
> > +						 idx_name, 1);
> >
> 
> I assume that the 'packfile_store_load_pack' function here returns a
> new/existing packfile.

Yes, exactly.

> > diff --git a/packfile.c b/packfile.c
> > index 8b5e6b96ce..f7916543a6 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -793,6 +793,33 @@ void packfile_store_add_pack(struct packfile_store *store,
> >  	list_add_tail(&pack->mru, &store->mru);
> >  }
> >
> > +struct packed_git *packfile_store_load_pack(struct packfile_store *store,
> > +					    const char *idx_path, int local)
> > +{
> > +	struct strbuf key = STRBUF_INIT;
> > +	struct packed_git *p;
> > +
> > +	/*
> > +	 * We're being called with the path to the index file, but `pack_map`
> > +	 * holds the path to the packfile itself.
> > +	 */
> > +	strbuf_addstr(&key, idx_path);
> > +	strbuf_strip_suffix(&key, ".idx");
> > +	strbuf_addstr(&key, ".pack");
> > +
> > +	p = hashmap_get_entry_from_hash(&store->map, strhash(key.buf), key.buf,
> > +					struct packed_git, packmap_ent);
> 
> I was wondering from an earlier patch too, is there a reason to simply
> not use 'strmap' for 'packfile_store.map'?

Hm. I cannot think of any, no. I'll leave this as-is in this patch
series though and move it into the next one where I'm revamping how
packfiles are stored.

Patrick
