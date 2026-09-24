Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D71370AE6
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229496; cv=none; b=jtH/a2XxbxMYWVV1DxYrLo1UY6oNzCoB/TGMjOz4kcWSYLoUXSax7WObDI/J3wL2p5bCipADbOAsd0y8G8hVLgHaNk14UVtSktHKnqoXvF3ljeEDszjRaK6W2CJeO6jUDmBUyLFU7C0IwXwFNLWO85FHRHJ2/GnK5+UYIMVVDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229496; c=relaxed/simple;
	bh=aVreMfZpb+aPL0nyIfu8IiAcrTQM7B1GdB0+v45P0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkIyUemMyl+bOX6XrK5MAR+8H9LB1cpSkbC+Gj11zesCgIkF5xCFIE3I79NBg65EIwOtj8wl+7yi3oUjWPekNcmnLYJSd+IsMiwOS6CQamEF7mMJZlnF2RPHrzL03KgBzW89xkBnTVBPC24rdsCWKHfzVHGPJoL90L2syfth/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ByTksdQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fv1PHJgr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ByTksdQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fv1PHJgr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CFD4EC00AD;
	Thu, 24 Sep 2026 01:58:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 01:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790229493; x=1790315893; bh=U75XUTHY/F
	m1BJYmK5EMaYeE7ybl9/EjGM2SZ+ENPtA=; b=ByTksdQzRKWypbTX07iUE/gN8i
	WzA0KEuMfIwKZBvACQZiHDpWxPz0bicen6N7QY3Rw4AakMvFuedl9V07s6U9Jhdk
	j9RcyinvAK3YNKHD/M6AE9oCR5hGJVTI5qWx4NtghiNfWGGm7eFGMekQEYWrxSXh
	LMbsY/2Cl6v6x4O35eabffr6qUdv737m7ZPd9Db0GHVSLZFksUnc2GFTkui/2dZK
	c6uvE86XBVeMKT+A9fnNfMlvGshotibenV5A4bR/D6F6/AamlKOPQVfFGoxPJPVW
	8UubwJx48kmkWR4Ay20+Sh8Np7OmSFi6wxXc8J2h3BdVVhq4r2oMmTKfpaZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790229493; x=1790315893; bh=U75XUTHY/Fm1BJYmK5EMaYeE7ybl9/EjGM2
	SZ+ENPtA=; b=Fv1PHJgrKZ8Kv+sRY8JAZQiD2oLdjmQptjIRHyTof/RMWWPRnqH
	mmF9x8+MpDtZJSgoOniMijiZ+7UjXEk9aPN4BBPXqWDpecpcoDoaUgLXt0yD/iYI
	6Vj2WvfNz+qjDc67WoURQD0pAwtMgaKqslvFRcejc5NgckxxTIiDqYVLlro+gfAZ
	qqvtXZGuvVQJwdIqB2VrS13jN7Pm5E7hd8Aq+u64gVTxo4fM+8piU2KCxfKNJ1jA
	9rWhDZ0XjdcoNazkEtiijgeb/tjqFmAi6CJ8mc4Y7kl4oz5qO8iLwBRfT7L1SPUo
	caPVDYHVF7lL+wYXzxscskBr7B75Ll5WaEQ==
X-ME-Sender: <xms:9bu0atKptmqSjdyXSm0UgbfImUUKlmbsEM9-W80WyVlneQ-aEASo_A>
    <xme:9bu0avKZhA7_tpLCY6ewBBsFqw_Cw7kGLd6I4cypgN7qiejSTOMnINM-CRkrdR88i
    TRICyjQM5CofKMjP8tCQdSYFY0AddPSRD_Ep28CCm8ai3aVso4OLQ>
X-ME-Received: <xmr:9bu0ajXuJUxSDPqGJ2b_yYJc33P8y4X3M8ikw1GOQTa51aTa19USpcOPt6LVvueNf0O0VE4>
X-ME-Proxy-Cause: dmFkZTEqg0GDs/zbbxWRJ+OfNqO97ZyLNyjjl6CrSrj6YsDC0eqc74fh5hADn6zs34fv0z
    EAqsYc3I8BO5KY4fxpUweFyp1sfInL69XEmHw5XvthzgX6QL9qGO7i1xtAHLcUEAQXZhM9
    B2vyD7ge38os3NWsXVA4+rq07EM/RP6aXvp6mLvKVLO8p/LXkJc6541490TNf3EYExbRpu
    AmbZfhHWxJAC1x3HixQx/oynU+NT0E20xlMJtwudZfzyzR8Ww2joPqSIMwhe3JutbyCWIi
    l6Ai5zwfkrLvzhMznTjXben0O0NwHjpvaSYNiHCq/JlbjUhpopoo1WEXw+rXujoJvCqvnf
    wv7cXIsaK0h2KM1eGA8T1bYZUD4oQZJ6s4NRpgQvTuZqUJOvlIk+odpy6crSV7RRvcMpO4
    g+7Ve+9DKZ9tiK762d1repVX4DcHo2iYOGCmpQH0DjHFHXuasp4uDHgwXDLB3R8nqxLRlW
    tw5jzbypy0G0qrd20IKNJx0G67Un1GxsKc1v2MUUXBnPr/Fxtm5jJerlW85pIA64qXivDY
    eMsBen9e7ebOlph9S4PZvywFtLRkke5sKiV8CDnS1eQC+mEklkwC0nYVFw+B+OGZtp3jHL
    elFWKeDvGeIlaz8zZxzaiugjpzhyK5t1BZWIkZOEmroWpsqS9QInWCHlAT8A
X-ME-Proxy: <xmx:9bu0aphT4DbXKfTbNL1v5jplgpabBFnqF5Z45HbcPL9ODN5h3enrvg>
    <xmx:9bu0am-lhLJ1qkNS0sLFWstPX9ZUmabrXDi0p9n0BxXxuFx0goqEZQ>
    <xmx:9bu0arAVCJHkctuaOt-R5PtRUnnVOZ07ieX0gWFkQnjQbKpWtRyiYw>
    <xmx:9bu0arIOwn3Zy3M0vCwDB0wPOcmZBqT-JzuansbHEuXtSjKfyweGKQ>
    <xmx:9bu0au5xKKNh0c450ci6c_JbZH0qkuBaUmXZK5u6GE7ND9SPq0ZV8EIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 01:58:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ac263d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 05:58:09 +0000 (UTC)
Date: Thu, 24 Sep 2026 07:58:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
Message-ID: <arS77zUvWKdjEeS-@pks.im>
References: <cover.1789328612.git.jltobler@gmail.com>
 <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
 <arPQrtYHen3UAvdk@pks.im>
 <arQ8nsUzg9atdCeD@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arQ8nsUzg9atdCeD@denethor>

On Wed, Sep 23, 2026 at 04:04:55PM -0500, Justin Tobler wrote:
> On 26/09/23 03:16PM, Patrick Steinhardt wrote:
> > On Sun, Sep 13, 2026 at 03:26:21PM -0500, Justin Tobler wrote:
> > > diff --git a/object-file.c b/object-file.c
> > > index a4cbf8b081df..0f123b79fad1 100644
> > > --- a/object-file.c
> > > +++ b/object-file.c
> > > @@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
> > >  	 * to zlib compression and is sufficient for this check.
> > >  	 */
> > >  	if (state->nr_written && pack_size_limit_cfg &&
> > > -	    pack_size_limit_cfg < state->offset + stream->size)
> > > +	    pack_size_limit_cfg < state->offset + stream->size) {
> > >  		flush_packfile_transaction(transaction);
> > > +		odb_reprepare(transaction->base.source->odb);
> > > +	}
> > >  
> > >  	CALLOC_ARRAY(idx, 1);
> > >  	prepare_packfile_transaction(transaction);
> > > @@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> > >  {
> > >  	struct odb_transaction_files *transaction =
> > >  		container_of(base, struct odb_transaction_files, base);
> > > +	int have_packfile = !!transaction->packfile.f;
> > >  
> > >  	if (transaction->objdir) {
> > >  		struct strbuf temp_path = STRBUF_INIT;
> > > @@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> > >  
> > >  	flush_packfile_transaction(transaction);
> > >  
> > > +	if (have_packfile)
> > > +		odb_reprepare(transaction->base.source->odb);
> > > +
> > >  	return 0;
> > >  }
> > 
> > One thing that I'm curious about: we don't have any error checking for
> > flushing the object directory at alll. So there is actually a change in
> > behaviour here, where we now also reprepare in case flushing has failed.
> > It probably doesn't matter much, but it does raise the question whether
> > we may want to start checking for errors.
> 
> Regarding the behavior change, I'm not entirely sure I follow.
> `flush_packfile_transaction()` only returns early in the case where
> there is nothing to flush. In both of the above call sites,
> `odb_reprepare()` is only invoked in the same circumstance.

There's a second early return when `tmp_objdir_migrate()` fails, and
that early return causes us to not flush.

Patrick
