Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3C33998
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566289; cv=none; b=E5exzTpOEYJC7BKfFshtTbGLBexYidX8IMJv5QU6pA+UYknFx2Qa5KI00ggWo3FPDDeZNFV+6KZ/AWskvwpnD1zqXuO0afu6CZI+FKbnywHr+dER5aHxnbxVGm3OKAnpcOWrAnu9v6g0ie0HpadBnfEzDZXptgVrFhAvXl1gnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566289; c=relaxed/simple;
	bh=cQiizlkFnKJDQU/yThLASaTamTM1FfYRvMMpy5Eq9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTd3R9hS8RY1bR/5+VR9n95+8Oaxl9ncyH4ECDi1OrO/vCzo3GiZTXH/LEuKoaI8UbPl+53uIhCmRkPQhAxEirz5a99svPswuNUj3JtSsv8kpK9yBpwjt0spTyhrYcdp5A3oHmgDsZIiAa7PbklA6JwiDnnjEj2CQlpkbm1ZwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wn1W5+3u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSGyRoWD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wn1W5+3u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSGyRoWD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 98AE113803CD;
	Tue, 17 Sep 2024 05:44:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 17 Sep 2024 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726566286; x=1726652686; bh=F9BEaUqpZI
	1K5seVFm67E/z3tHgqYoKEbrVsYg9lg7Q=; b=Wn1W5+3uBVAz5JMghZMj4rChfO
	85VvktFsFre31NuU36XgsC1N2faoqYrIXOKOC6lNF9+FtrlFwBVW90lRBhNk/pwB
	IfRhDKz996QSOXZD8Yt+WD0lbepIbuTdLCIYlckNtCPz8cRy32HDc8Naagy+WcNc
	FGr2tIrelaKMlEqYRv2Arone5dxxJj1ec8BDlJR7mLN/p8rrU6FwGJxki/7m3KbU
	5jGV5PnOs2CpbJEnhniMqAM9zC/O+JPEazj1Crfc8wgmgaqjv8O4xmQ7fPSyGeRC
	Dlfh87uZZpAKMSlaDa+s/HMMaJeA2ZvNjsN/0h1BcsLo2uiHMojCp2zl1edQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726566286; x=1726652686; bh=F9BEaUqpZI1K5seVFm67E/z3tHgq
	YoKEbrVsYg9lg7Q=; b=WSGyRoWDKnpD2ZoJRKHSHTrz9PYK/S7GWqDjWjId8AQP
	986orwHHenNXYihXj43GyNu4yD3i+r9AT0OPZGG4hpoUuDn6sSwv3Cyxl6DSr9OD
	QdyIKcCPUy6tK9zCynJPVL6TK7WfVIXNJROoOYiZboxKGy8SLZU8v6pcjOD0qwe7
	cIhkq+73ts0TZlpC4OSoQJXx6hcn7HJt1v04EKeqhBgqxhEsGIeeWUE1ml6EDyO/
	cdI0jvItDLuIP75yeaI5Cg7kQTtR3MOvLHChYvyQIz95gbTAtjv+Z3VmNM1uVj6H
	lv5zzrykxtB+hrcPc4tyDSFDUebToii9wNkj+bQV8Q==
X-ME-Sender: <xms:jk_pZkZ9UohO4x_v2gKhmoD_JLzni5MeTZHJf6ecxPlRBq7Nr435kQ>
    <xme:jk_pZvZWKqCNRuyo9gTDkcXiJG554vWZ-MiSzgxz0Mt8rsroUhgy937ETJOE_o0-M
    RRxtrqFbXgfVZFc4Q>
X-ME-Received: <xmr:jk_pZu9iULKffo7Lbhq-ebuyN2dQGvITpYaj_Bwu9X5UZUE890kh9y9WyQEFmqL9VJsrAaly5K96f9cM3w66JwlJ7BU4Vc5jnnUzgHCTMiKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:jk_pZupFVOBzKBnjB5Ju_hFhWu3gThAdxN4djQ4MpFl1_S-U43mM5w>
    <xmx:jk_pZvrErdb4tkVRXrJUDEHWeDaqvjB591o2Wgn-Ccd_xMuURe7Y6Q>
    <xmx:jk_pZsQWVGrLyBnZna7HgNSMpHvPXdHDCbxA3wsWxAqYFo-pjklLCw>
    <xmx:jk_pZvpajzmQxSoiYICuO2l-XXC-Rno5Akq34lNtdcXDDHvUpd-KBA>
    <xmx:jk_pZuUQ99oTEM90OO1Mnf-o_VaofOeMyelLiLEmM5_VsHtnQQR7jeVm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 05:44:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9b633f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 09:44:25 +0000 (UTC)
Date: Tue, 17 Sep 2024 11:44:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/6] refs: properly apply exclude patterns to
 namespaced refs
Message-ID: <ZulPhat5pavpiuXT@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
 <ZulIB7k18+4CzwZb@nand.local>
 <ZulM4BU7zSn_NHMl@pks.im>
 <ZulOK5GAWYbPlYeO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulOK5GAWYbPlYeO@nand.local>

On Tue, Sep 17, 2024 at 05:38:51AM -0400, Taylor Blau wrote:
> On Tue, Sep 17, 2024 at 11:33:25AM +0200, Patrick Steinhardt wrote:
> > On Tue, Sep 17, 2024 at 05:12:39AM -0400, Taylor Blau wrote:
> > > On Mon, Sep 16, 2024 at 10:50:03AM +0200, Patrick Steinhardt wrote:
> > > > diff --git a/refs.c b/refs.c
> > > > index ceb72d4bd74..b3a367ea12c 100644
> > > > --- a/refs.c
> > > > +++ b/refs.c
> > > > @@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
> > > >  	return hide_refs->v;
> > > >  }
> > > >
> > > > +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> > > > +					     const char *namespace,
> > > > +					     struct strvec *out)
> > > > +{
> > > > +	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)
> > > > +		return exclude_patterns;
> > > > +
> > > > +	for (size_t i = 0; exclude_patterns[i]; i++)
> > > > +		strvec_pushf(out, "%s%s", namespace, exclude_patterns[i]);
> > > > +
> > > > +	return out->v;
> > > > +}
> > > > +
> > >
> > > Is it safe to concatenate each exclude pattern with the specified
> > > namespace? If I'm reading this correctly, I think we silently do the
> > > wrong thing for exclude patterns that start with '^'.
> > >
> > > I guess we reject such patterns in the hidden_refs_to_excludes()
> > > function, but perhaps we wouldn't have to if this function stripped
> > > those prefixes for us when the caller does or doesn't specify exclude
> > > patterns with a '^'?
> >
> > Yeah, as you mention, `hidden_refs_to_excludes()` drops excludes
> > completely in case there's any pattern starting with '^' or '!'. So the
> > current assumption should be safe because we don't use excludes in this
> 
> Right... but can't exclude_patterns be arbitrary here, as it is a
> parameter to the function which is exported via the *.h header file?
> 
> IOW, I don't think we can claim at all that we have passed the excluded
> patterns through hidden_refs_to_excludes() before calling
> get_namespaced_exclude_patterns().

I think the important thing to realize is that we're talking about two
different things:

  - We have exclude patterns. These are _patterns_ only and do not
    support '^' or '!'. These patterns are handled by the ref backend.

  - We have hidden refs, which are a mechanism of our transport layer.
    These _can_ support '^' or '!'.

To use hidden refs as exclude patterns they need to get translated to
use the exclude pattern syntax, which does not support every feature
that the hidden ref syntax does.

So every caller that uses exclude patterns must already make sure to
filter things accordingly, and they must make sure to use the correct
syntax for exclude patterns. And if they do, I think that the conversion
to namespaced exclude patterns should be correct.

Or am I missing something?

Patrick
