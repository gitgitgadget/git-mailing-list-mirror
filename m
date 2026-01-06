Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D03093B6
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684358; cv=none; b=cPWhRUSCNLRzQq8O7aNngtgEtjDMgzEy9LvSxdtOUMprTHtiNmtYzonW5rg4iylk/pLZgSLAN9BVAXjX8Ise72g87VWkGAQ2w7NuZJtPUOzSCg2GoudMZZ6ravbIzOKE/Md7QyQ2tLHMWuYAegyvThR+UpmeeeMb13ubG9hxaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684358; c=relaxed/simple;
	bh=M292cKXsHHV59juylcdLgVujyaTui9fV5t2hvoBriZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLZDprKivX4wQQln06ytjEgeFqvj3oOu98k1bU/jCx22j+yfmjsIyQEpaV9vMTx20+5tXR8OW8mzbCoeEzb7RwgDY1CjqDPI8dw8YRJLRsOeq3m4UJp1CA5g3v/2OH9CEVm+YFN1AA1LH1kAT0eLOZbwUfU1J0SvoKpyFVL4HMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hld8cVKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vSMA7kqc; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hld8cVKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vSMA7kqc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9CAC7A0021;
	Tue,  6 Jan 2026 02:25:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 02:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767684355; x=1767770755; bh=lzumcH0GVg
	OhM+Vex1U2NeJ18jdhgw3LlqNC18J2u2A=; b=hld8cVKMMr4IwyToBoEs+QG/0I
	Ea2GV4SZ2r/AGXty0TyqIS3jzmLSz8GEo/wfNVC83g0PCLwRViP9hVT/IChrgsOT
	fIQqj2dtyMYRG1zDHN/lbyMB0k4Yer2FUTSh2GU7NmwBRP0Fi0L/huw/vv2Q7gEI
	kUoJFpTFew2WuOE3j5lgCYTQYKaSGHiWP8Zm1DWF0m3TBhTlJAVqwFIgiGMxs3lk
	4HQ7E5UQrFaSWmgGmJO5UFPLOa4FOtCrZvDjoL01771+UTvYh6J2irziNJe0v31v
	Cs0pdPyVZcxCzQgq1iL7LjT1PglvFHUL1ZPc/NdaKsGeeOWOB/FmJGFvRcug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767684355; x=1767770755; bh=lzumcH0GVgOhM+Vex1U2NeJ18jdhgw3LlqN
	C18J2u2A=; b=vSMA7kqcJzrZiUvoYWgrVBJbS8zJruV99DOMbUZEdgS36xEy7l/
	G7vXctuyX4WlnBCUgsupgraAAi26UBlp66JbaPbZhrWuEhmpWAbxzuD5dmJmB4mD
	DwmvYiBq9X3xD6ilRCWWMQczkgqzzL15pf3NQK1W/I4m4SqIejB0dngD9PFZkyNA
	mf2+yqJiaM0hVGGawWKmq04iq2jaMKnzm7GrH+1hYNF3Bz67ayCAo49ahTfivEc8
	/cz3Rr2Q89dqBckCTOKQGTRc8Ky4z38fa7nc4oT/+kqOpPw/hIY2+7IyP2bJ7sdn
	/AzxJtGNo8/aZ5ln66wHHnIWqoGbTUr4zEg==
X-ME-Sender: <xms:A7lcaVK9cS4jayzzo8IaMkePK3LMm5eOVg_DjfD30khHJEysmV8SHA>
    <xme:A7lcaZVYj1yme5vzylgutg6IzswhojhN8s8H97__RhIhP24xytLR1LVsseNZa5zKR
    36Y7X52NbqAldbO31w9mDnr2IiGyhhC8TX672Yh-v2QaJD5nXAtVg>
X-ME-Received: <xmr:A7lcaZRXdZvXQuZSujcwxmFyCaGvPwVmhfMbG2DkkQOqXf1mmsypxUmgNyHz_6a9JARVNMHQm8ifyIz0L-ntjyCGjLX_nIc4RPnh-lhZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmohhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggrrhhonhessh
    gthhhrrggsrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:A7lcaRDIjRRN-2M1byi-YQBaNMr3LWo7kB-Afe7TFCKsoPq9JH0fJw>
    <xmx:A7lcaYLSKmi4d-5zLbC5lNCI4Qg106WhXmpqVDNedJBkNvs5Rzyweg>
    <xmx:A7lcaUBAGZb3ixJeW7QcHDDiv98mTmjKM1vc48GWM2B0TemOoW80og>
    <xmx:A7lcaVv2RCMHTXoO1Mvikp5xktL5HB-OFjy_C4no5jO1zSOvJdHgtA>
    <xmx:A7lcadbBR5cZNC9wYRL-dvuLECXnQ_32gyJ36HkyRO5CnRA1qy2Be3Yr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:25:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c9d7d79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:25:52 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:25:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 05/11] submodule: allow runtime enabling
 extensions.submodulePathConfig
Message-ID: <aVy4_vtbuYlyppXT@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220101528.1227487-6-adrian.ratiu@collabora.com>

On Sat, Dec 20, 2025 at 12:15:22PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> index e45b2a8121..293a2ddbdf 100644
> --- a/Documentation/config/init.adoc
> +++ b/Documentation/config/init.adoc
> @@ -18,3 +18,9 @@ endif::[]
>  	See `--ref-format=` in linkgit:git-init[1]. Both the command line
>  	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
>  	precedence over this config.
> +
> +init.autoSetupSubmodulePathConfig::
> +	A boolean that specifies if `git init` and `git clone` should
> +	automatically set `extensions.submodulePathConfig` to `true`. This
> +	allows all new repositories to automatically use the submodule path
> +	extension. Defaults to `false` when unset.

Nit: I would have called this `init.defaultSubmodulePathConfig` so that
it fits in better with the other configuration we have that impatcs how
we set up repository extensions.

> diff --git a/setup.c b/setup.c
> index 428427d689..3e05fe7c58 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2712,6 +2712,16 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  					  initial_branch, flags & INIT_DB_QUIET);
>  	create_object_directory();
>  
> +	repo_config_get_bool(the_repository, "init.autoSetupSubmodulePathConfig",
> +			     &auto_setup_submodule_path_config);
> +	if (auto_setup_submodule_path_config) {
> +		int version = 0;
> +		repo_config_get_int(the_repository, "core.repositoryformatversion", &version);
> +		if (version < 1)
> +			repo_config_set(the_repository, "core.repositoryformatversion", "1");
> +		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
> +	}
> +
>  	if (repo_settings_get_shared_repository(the_repository)) {
>  		char buf[10];
>  		/* We do not spell "group" and such, so that

I think that this logic woudl be better located in
`initialize_repository_version()`, which is also where we set up all the
other extensions. Feel free to disregard though in case there's a good
reason you don't do it there.

Patrick
