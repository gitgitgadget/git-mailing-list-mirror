Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFC1F0995
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016531; cv=none; b=MNtukwDgghIRCgbGFhu/3rR4Mw98WoRBK5Ko8sqzijZ63SpshhoyYFlFPO1NctINktBICP/a7gPNairCJrCB0f55xMC43x51RZXOW0/4MohvdF2tIKlDuZ5KaKtZ0MVBeN1bNMyTt9UM+Uerg/N65Z3N25JlQoWXuOK7jzJ7vNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016531; c=relaxed/simple;
	bh=NGZxHKpoy2iAWjBqfCm7u9AD/pDI8y6kkuZHm0HfbPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNJKYz9bEGFkMR67ABjiEMhwrjidpO1S8KzdyDknulquRRBo93eg6cSEa0XTZQvm1mvGO0tVOx0Zy2N5v1s/W+xtQ8Xgsx0uC/l0AC27pktvUnFLnGxF8VunmgS/UKcimCpn923FfzKfxlLOBY0taHMvSzxcYuZaxgqDhDhFEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SPAfK3un; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFgvRFar; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SPAfK3un";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFgvRFar"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A38537A01E6;
	Tue, 16 Sep 2025 05:55:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 16 Sep 2025 05:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758016527; x=1758102927; bh=Ye1BOHErl4
	cIRfsZ3K2Ng3fyAV0q3/8ypFckpYB4T8g=; b=SPAfK3unuBgwVbxJedo5wxlfWE
	EoJ3D3gx0ED0b+RS6T9DR/EkR1PSlA5Kc0gV8olUy5GdFZp1M8BAdrnM5CkrCsIF
	5eo2WAHQBRJzkwWvn0WfwCHSszfEl/eQuag8seH/e4pHZ8fxei8A/1fStQrSGSVT
	OA7uGHWzfhlC4pzmwwS2b5Pb/zRqGnnpjmbQL6zvnj2ETe8mNDzX7AuErO7Rq2T0
	uyACNEnakpOPi/Qj6oakvNlHarSIf0/whj7O1anpCegZVHShK0I+AVoraXNR+SlW
	iSWL2wr9y+mEBsoagGhxAoPPrxNNfDts6T1yOm8XXP8PCZeFUlDDbwLXUyjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758016527; x=1758102927; bh=Ye1BOHErl4cIRfsZ3K2Ng3fyAV0q3/8ypFc
	kpYB4T8g=; b=lFgvRFarmnGrwIMiRWat6mZE2uPs9jKTcaqpFWR3o4J5a2IuGql
	7b+mKwo17csp2JhJVTqOQI4S4bvhS3FkXaU3hrCYDCbxorkapYTcLAAV3nrcQ9ab
	H620w3DMj/xZ+i3hhCrnQnFtsnRkp8tSZcx10pxLyVPtxIDXxCpmwfpj7xL4jlwM
	xMPFwLVvwBcDTDMbXrkQOd799cKnjb250/Rnwmr79sN5T21sWCowTdN/9ry4utAC
	31C14FDPeLKYw48m97WcnmKJORAK+Du/1wektroqhP3BOKDEbgBsYoCZMpgm7Frh
	wVqIURp1qFIajWPbXLCp1C5xjUOP+fOIOpg==
X-ME-Sender: <xms:DzTJaDTdVlhm0jvWTOsp76qVCjp4gF3cgS75KZP5KQkpFATkR_I0lg>
    <xme:DzTJaMhqc5TuKaXy5k9CbY4Mi8d-rPsZio9_X8kJu7D4f8tYkIFh0e7Zi-m1F84TM
    MBwv_z5aOUVTp9isw>
X-ME-Received: <xmr:DzTJaL6i1TEHDZaRfx82ZwkfiPyRYIdxB20t_R6Roz6FDGWBClFr9eEKsiAfi-VJpx0jf1AD6n7iaD6ZqvIIB4uFX97PfEL5TDLela7Kkw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evffeuffduffekudegleeggffgtddvgffgudeftdeujedtheevgfeftdefvdelueenucff
    ohhmrghinhepthigthdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DzTJaBCA5v1VLopdGZanc_hjGEb31VG3JgPjoscCKu8_3RdeTqPnRw>
    <xmx:DzTJaKbwxY4weWqmSPs48RWTg27Fbn2kinUIGmU0g8JipTFgcHiBEQ>
    <xmx:DzTJaEZbs9B92dWROYbe9Y_ByFyyo8K39fnhOiV1bChsRPFvMg3KIg>
    <xmx:DzTJaJ_O0Ea16sErK5navISprz8rFdmcRBFq437QIr1CkpPadF3ayg>
    <xmx:DzTJaIj4v_qbP5ECHSp-N7mlK2Z7WOaWnJaDjlIkX4y4LZbjH_TL99Mb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 05:55:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1bdf33a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 09:55:24 +0000 (UTC)
Date: Tue, 16 Sep 2025 11:55:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/3] meson: introduce a "docs" alias to compile
 documentation only
Message-ID: <aMk0CdaN8pzEPf7m@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
 <20250911-b4-pks-meson-docs-target-v1-1-a92c666ecef9@pks.im>
 <CAOLa=ZRVaBp6DAM4gYXFjCRORYxObvWn5egrPAOcGZ42mxnsgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRVaBp6DAM4gYXFjCRORYxObvWn5egrPAOcGZ42mxnsgg@mail.gmail.com>

On Tue, Sep 16, 2025 at 04:14:56AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/meson.build b/meson.build
> > index b3dfcc0497..40b2a2dc54 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2101,11 +2101,18 @@ endif
> >
> >  subdir('bin-wrappers')
> >  if get_option('docs') != []
> > +  doc_targets = []
> >    subdir('Documentation')
> >  endif
> >
> >  subdir('contrib')
> >
> > +# Note that the target is intentionally configured after including the
> > +# 'contrib' directory, as some tool there also have their own manpages.
> > +if get_option('docs') != []
> > +  alias_target('docs', doc_targets)
> > +endif
> > +
> 
> Shouldn't we also add it to 'meson_options.txt' with default set to
> true? That would ensure that `meson compile` would also build the docs.

We already have the "docs" option in "meson_options.txt". In fact, it is
not even possible to have an option that is _not_ declared in that file
:)

The option accepts an array of choices, where the choices can be "man"
or "html" to build manpages, HTML sites, both or none. So as soon as the
user made at least one choice we enable the "docs" target automatically.

Patrick
