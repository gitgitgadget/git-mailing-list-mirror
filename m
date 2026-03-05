Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E29460
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717007; cv=none; b=ev7WPgo8ov6RiRRbo9zQJuTDfchbKtbYvnI2C2f9nhE0EOWnrnxC+Tt0CU7VJoxe3AXyTnaLVabezqbpHyvW8fTTQfadVNTBWx81jcOu6U8m4P9KwiC/m5wAl00kj4qPv1xxO06jWHYWhCgkFJUc1SWm7feYFMZblI/acbTlZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717007; c=relaxed/simple;
	bh=nj3lIF2reBEO23k/d1utF29urEL+So8tdsSUG/p9w00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSfCTvoIdfM5kCvr8PlMJKowvn2WlaKBbcLUyuy6OdBOVrI33J0AQdxAeTrX68u5AW3t2RqAspzdMCITmxQNo9/ggNtOg0UWv6N4eZ+tzKQ3DWXCX7QabaYiDquixqTBipx55T336dn7osqdCbcaV9nthXnRub2bGn2/cX1mIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SwVvJQcc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOnxGvlO; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SwVvJQcc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOnxGvlO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 28A001D0019B;
	Thu,  5 Mar 2026 08:23:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 05 Mar 2026 08:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717005; x=1772803405; bh=feDuI8NBW/
	aqT9hd1UM/T6nF27XpBQnilThFPp7Rn5Y=; b=SwVvJQccvI3OfoKddEPO8Q1GsM
	TQ5ifs5VvGw3c0GwIo8XeNUk2eedNdQmcJMalhduaG43sCjYItUvEVs6UVAciduy
	PwvpNH7mf9eUOawLPYsnviL1aNaYgtAoPH5VmP/CViR3IffjtHj0owTCuPJvnuhv
	bS/t0MJwS01gwDwNceC9OCf4sWElZnkYPDyO6AfvHhZJWx5YF6UQsPpONh0FDrfL
	sDNy3Oy1mAuRw0JzUHijOXEDOHlzmnPifjaJMo58vxnwpc3dN1e0wVUSd65kdi++
	7u6J9+pq7U5MMJ2NCDXx5lECpQpF7B40r2IBTAyv+T8nK24VvfzVcJ4eiaag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717005; x=1772803405; bh=feDuI8NBW/aqT9hd1UM/T6nF27XpBQnilTh
	FPp7Rn5Y=; b=gOnxGvlOS+whDudDcKf1Y0VwgTgR+zlLKQfxFpf+qf+tzF9NavY
	k/q88smz+JEzeKqD1Q9XxJxf1G8jhAPuMR27lAFiEaQoBLa1OTlYE8fbiXxv1sb8
	FNrkrGQfPiQ6QMKBpXaBEF5T4KO5y6YAu3NPhWzYGAVgy4AWnPGx/Udkrs3hqofy
	4aq/eeeHKSgPDiOLHE70HPKkhVeMNZOAnQuPte1RtRG40AbCr0cFttGNO3UzEdW/
	eg4xKxc7RT2FFLhEFKZrP1PIIogQ16pGTGgodeeri+9SKtOfiB5WBeoNdMdKRsTw
	U0E9c1cn9nzRCer2084/ZJ8ILl7JWIop1vQ==
X-ME-Sender: <xms:zIOpadAhb0mbge0isI3flfwouy9CiKayM-lMPD6MstOIfHYwFQAeIA>
    <xme:zIOpaRjlBYHYZXnLIp8du1oyLQtD83Gj7PtBVxX-8vndnPunDO7HHsl247g4YnJam
    EzAAE3j3xboLhfn62HFsCFraP0ydi8QgbirgEBsPMnK-ykmsEnjBw>
X-ME-Received: <xmr:zIOpaWMRv3G51IRshXRltGbHEjlg8i2NKlnLk7Ep8-TmpzR9qbRq0j-OmILzIZBMCMCmRiooiqDZtdSCuIyCSnjFL6siHUMEiaQlGCTm3Sc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zIOpaS6iFyH1vyyxK_f3FaGLGMqwpmIj13Dsy-Ktid95lvkrX--Vxg>
    <xmx:zIOpaU3f86JtRxWUaARSFcBvNeZrkjyUhUsedRAYJ_3qJoZ9h5FEaA>
    <xmx:zIOpaTYtCbuqiuXyCe006EB92mf4vnZa5jy5z3_t96MoUIJ1ZbyOAw>
    <xmx:zIOpacB24z4b5irmqI1f3Ypk51Ub_5GdaMaFoeHUib3NXDl5aHdh8w>
    <xmx:zYOpacy5lxU_dwdXnpYe2E1O85mIHhq3ZHHL6Ul8X4j6XszV52gXC3KW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07d143af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:23 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/17] odb: embed base source in the "files" backend
Message-ID: <aamDyLxTYQdh9igw@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
 <aahkh1ICViKjP6Il@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahkh1ICViKjP6Il@denethor>

On Wed, Mar 04, 2026 at 11:40:47AM -0600, Justin Tobler wrote:
> On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > diff --git a/odb/source-files.h b/odb/source-files.h
> > index 0b8bf773ca..58753d40de 100644
> > --- a/odb/source-files.h
> > +++ b/odb/source-files.h
> > @@ -10,15 +11,26 @@ struct packfile_store;
> >   * packfiles. It is the default backend used by Git to store objects.
> >   */
> >  struct odb_source_files {
> > -	struct odb_source *source;
> > +	struct odb_source base;
> 
> Out of curiousity, was there any reason to the reference ODB source in
> the prior patch? Seems like we could have just added it here.

Good question. The reason why I stored this pointer in the preceding
commit is mostly to demonstrate that we're actually using the source
that's passed to `db_source_files_new()`. I didn't want to have to
change the signature of that function in this commit again.

So the field was unused indeed, but intentionally so.

> >  	struct odb_source_loose *loose;
> >  	struct packfile_store *packed;
> >  };
> >  
> >  /* Allocate and initialize a new object source. */
> > -struct odb_source_files *odb_source_files_new(struct odb_source *source);
> > +struct odb_source_files *odb_source_files_new(struct object_database *odb,
> > +					      const char *path,
> > +					      bool local);
> >  
> >  /* Free the object source and release all associated resources. */
> >  void odb_source_files_free(struct odb_source_files *files);
> >  
> > +/*
> > + * Cast the given object database source to the files backend. This will cause
> > + * a BUG in case the source doesn't use this backend.
> > + */
> 
> In the commit message you mention that eventually
> `odb_source_files_downcast()` will BUG() if the source doesn't use the
> backend. But, it doesn't appear to do this yet. Should we still have
> this comment?

Good point, let me move this into the patch that introduces this.

> > diff --git a/odb/source.h b/odb/source.h
> > index 1c34265189..e6698b73a3 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -53,7 +48,31 @@ struct odb_source *odb_source_new(struct object_database *odb,
> >  				  const char *path,
> >  				  bool local);
> >  
> > -/* Free the object database source, releasing all associated resources. */
> > +/*
> > + * Initialize the source for the given object database located at `path`.
> > + * `local` indicates whether or not the source is the local and thus primary
> > + * object source of the object database.
> > + *
> > + * This function is only supposed to be called by specific object source
> > + * implementations.
> > + */
> > +void odb_source_init(struct odb_source *source,
> > +		     struct object_database *odb,
> > +		     const char *path,
> > +		     bool local);
> > +
> > +/*
> > + * Free the object database source, releasing all associated resources and
> > + * freeing the structure itself.
> > + */
> >  void odb_source_free(struct odb_source *source);
> >  
> > +/*
> > + * Release the object database source, releasing all associated resources.
> > + *
> > + * This function is only supposed to be called by specific object source
> > + * implementations.
> > + */
> > +void odb_source_release(struct odb_source *source);
> 
> From a naming perspective, I do find the odb_source_new() vs
> odb_source_init() and odb_source_free() vs odb_source_release()
> interfaces to be tad bit confusing. I understand that odb_source_init()
> and odb_source_release() and only intended for use by the concrete ODB
> source implementations to facilitate initializing/freeing the base ODB
> source. The comments also do help clarify this, but I think it is still
> rather easy to get them mixed up when reading.
> 
> Maybe we could rename them to odb_base_source_init() and
> odb_base_source_free()?

I think for `odb_source_free()` it's a definitive no. This will be the
way to free any source, not only the base, and this will become clear in
a subsequent patch.

For `odb_source_init()` you have a better point though, as it really
only cares about initializing the base object. But I think it's still
sensible to keep the name as it _does_ act on `struct odb_source`, and
it would be the only instance where we have the "base" infix.

Patrick
