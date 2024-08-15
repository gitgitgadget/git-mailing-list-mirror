Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8021AC8A4
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720277; cv=none; b=tgFx0w9dOf/uFdx3A2BULa2Uw57eHSc45PLaO7XDbGMWHn1NTR6Qvs8DFuW86rTYsXS3hsujVsno04R6gGqj/863VR69K8RbuQ0ZEJMfNJYCqNE3aVkfWwzeIcZz8FqSUAU9NOZiejhrG99V1hvoVYhFIBuOIwzsHo/dnzDBG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720277; c=relaxed/simple;
	bh=3DlzTMaFuwlN1t8Wa/0yfNs4iQfKhO+SngYj3DmKxhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gElYXmKyQ8n7TktmqCcXe+u5noRnzDA1M/996GE7sTA3tUl6Ux2cEUiGp0uu6teqAGSrJSO06n+IAJ0qdhUCd8pwfefcoU2BhmHrWKUHx9Dn+JJI6Oq5lkcTYnOO4A7rlSU3CqF+0IBpYhe3HTG9mDgqs4PhDMz1WVvpUnkcmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FmlK4He+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQevtpeg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FmlK4He+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQevtpeg"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D0B8C138FFC9;
	Thu, 15 Aug 2024 04:18:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 04:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723709888; x=1723796288; bh=7SLyCShncY
	cQTGShqN/rZ9H2tFLFdPqSFSJlqetv3oc=; b=FmlK4He+XPV4ovj/5ZWHKZlabE
	0uhu9026zkf++demkYo9mwGmSmIKKdaYrZLoJggqioNVGveHKalPpgRXdZa0ynwL
	KurZafsIwmRg+HCSaMyMKdFiszDf90Y+wGmxEo9GqNGRTbdCQbAcfnPT/nEPZquI
	lu3BQOcAoknRDtlJX73bhesWQS7V22aycUq4iUU05vhZgSdY35Li+bpIDSvzyqjq
	kr8C4eVnJznvC4SS2ACQVYSU4JDxlf1ug8qe9xjdx3Zm9/ws1gVfk7UUPOvSq92L
	4MG8fiFMxndrH/+y5pnOEkbhyz+DwzBTFIqKSRE4W2b4I5gfjFXXbW0KmA3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723709888; x=1723796288; bh=7SLyCShncYcQTGShqN/rZ9H2tFLF
	dPqSFSJlqetv3oc=; b=WQevtpegPWVIGf/P+somimfq+xMksvG3/TuY7oEsZ4vW
	/rjrlUgvu0ibjNUIEiZTomIJKZPbMqLPazVY9Oq9tLtDnycgpBsgh5HAhL3UarPd
	UtNiLYOSAs7LKN9uV8S9ZJgrH3v+LS1Snn+hAE0u7MtGV6aPTriSFKahYHwMwHB+
	tofrT/rMWN+5sWHRzgRmqd7V93kAmVnalnlcX0JzPm3xz77wdcgEHYm9LKfam7b1
	xXLvQP/hxPJfZs1QdKsYpJwj3x9o4KImMNYd+FiNrTu2TuPITdZvx+ybfArkVvNs
	zK75US9SsJ675qT+/CIyblaMnNbRXgS8LC7w8oExKA==
X-ME-Sender: <xms:wLm9Zk2ht13N-QFi3tSw0ZBQxQJP1QIVG_we3yFoIuONnv-Q4w_m1w>
    <xme:wLm9ZvH3DKPAmnfzZTAl0sZhGkO_CPztJVG0AYbtxkept23EGNua-_WCbYJoXctoz
    nDxTao24Z-BYaMKTA>
X-ME-Received: <xmr:wLm9Zs5v1JqhtCZTlKRy3pimKLFlLaIYG51-Ks8JLcZ-jPLz7liRn6GynRBz3KtYEXqf6MiADIo80BvzoYw58t5xYrvMNQUepIUxxfHkCfmfag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wLm9Zt0assNJdcozPEIfN62Iru0f7gPABI8hu35bPUMCmvw36h1kVQ>
    <xmx:wLm9ZnHC9_wS2zWEgATE32DyFcsTsSM1YjywSOAbjASnCN2A28y1ng>
    <xmx:wLm9Zm_sQQ3CysjJmTvN2029PG9HbC9u_J9LxX5J9527woyIBJV0gg>
    <xmx:wLm9Zsn2boqq414toSsQba-L-Z1a5WJTd3vafGtjwMdri3bMGim0AA>
    <xmx:wLm9ZsRM1IMCfAmLbfNneBiSC-PMQ5eXyO9yHktlHU6HQcK5fjG1piX->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:18:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77650f05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 08:17:47 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:18:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] builtin/gc: fix leaking config values
Message-ID: <Zr25vm8cLhS0_sKV@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <310e361371efc156c3aaac94439bdbeaa965155f.1723533091.git.ps@pks.im>
 <D3G8EY3R09BC.2BKB6UND5J5MA@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3G8EY3R09BC.2BKB6UND5J5MA@jamesliu.io>

On Thu, Aug 15, 2024 at 03:22:04PM +1000, James Liu wrote:
> On Tue Aug 13, 2024 at 5:17 PM AEST, Patrick Steinhardt wrote:
> > Note that there is one small gotcha here with the "--prune" option. Next
> > to passing a string, this option also accepts the "--no-prune" option
> > that overrides the default or configured value. We thus need to discern
> > between the option not having been passed by the user and the negative
> > variant of it. This is done by using a simple sentinel value that lets
> > us discern these cases.
> >
> > @@ -644,12 +673,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >  	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
> >  	struct maintenance_run_opts opts = {0};
> >  	struct gc_config cfg = GC_CONFIG_INIT;
> > +	const char *prune_expire_sentinel = "sentinel";
> > +	const char *prune_expire_arg = prune_expire_sentinel;
> > +	int ret;
> >  
> >  	struct option builtin_gc_options[] = {
> >  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> > -		{ OPTION_STRING, 0, "prune", &cfg.prune_expire, N_("date"),
> > +		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
> >  			N_("prune unreferenced objects"),
> > -			PARSE_OPT_OPTARG, NULL, (intptr_t)cfg.prune_expire },
> > +			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire_arg },
> >  		OPT_BOOL(0, "cruft", &cfg.cruft_packs, N_("pack unreferenced objects separately")),
> >  		OPT_MAGNITUDE(0, "max-cruft-size", &cfg.max_cruft_size,
> >  			      N_("with --cruft, limit the size of new cruft packs")),
> 
> I was wondering how the `no-*` options worked since they're not
> explicitly defined in the `builtin_gc_options` array. I guess
> they're handled internally by `parse_options()`, and if the `no-` prefix
> was present, it leaves that argument unset.

Yes, this is being handled by "parse-options.c". But With the `no-`
prefix it won't leave the argument unset, but will explicitly unset it.
So if the argument was already set to some value X, that value would be
unset when parsing the `no-` variant.

Patrick
