Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F60405FB
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917170; cv=none; b=Om5aS3oB5QkpxzxccNqwrVSoYqibRFL+6cAPzpqQ1xgAE9MNpsXxBsgi/2rq/ucGgfQfyLDYwFzxFvLuKt0VOiSKFu5fO57dOF7+COFgyZosspsGgKmTlzOZB7DEpL5Fzr4l6rCbZ74nhJoiDAjB3zcSuPDwrtImVwzkYOaTb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917170; c=relaxed/simple;
	bh=PyFX7/otq8Mno9pVUg9pu7HlMj+6W/aGnr+iHc+g5hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NunYaaQ4vWLtt6MQqYpW/nXX/A56tOsuj19rhTYD5xWWQj+/W596AfzPOv+OUbRdSKgQdIXkWJ8+XrTZXAEtQFwYvtFkNStwIj9bFolYcpbvuV3znob3Ja52+0u0vsR1syRP2mFlp7n+m4w2YAKev/PTo5WfNNiWQCv3jwKTUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rkf1OEQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaO9FL6a; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rkf1OEQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaO9FL6a"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9A3F2540123;
	Mon, 18 Nov 2024 03:06:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 03:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731917166; x=1732003566; bh=bBKRrq0WYA
	dDVCZjwvgEcFrAPnkFLgpceQnY2hdZEy8=; b=rkf1OEQoCKYgaOOzDL9UI65HFZ
	kY2DZIKBCSQ4Hy0ztazsJNTYvs8BrVcaF6TPS6s1jUnJ4WfvpMURbgbwKKLDu8qX
	p9y8ngRl9jbU5ozMRDfMpi7oVKzeaSm1IIR+fQRns5hOuEQg2HHW4qeMzHuBkL3Y
	/CcHUO23hMKGhraAyXyQkejwfbGDQb/0rphJid7smIMkKiI4a8AGvjftYEZIbjGF
	uV6Kc5JBDyNd7EiFS4c2dNR7QLEKV8Tou7qDFf5WkHG9h8JHVDU6MThx4zNc4a5b
	/6/XHph3EPqJCTs/sRT5ualqXf4ZKRs0uHpHD5xQFFt3uIE7RSzcaTwL2/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731917166; x=1732003566; bh=bBKRrq0WYAdDVCZjwvgEcFrAPnkFLgpceQn
	Y2hdZEy8=; b=TaO9FL6ai2N/QdVvOS8nW2RNQ+hWcBbDm6QtK2hHI64fPQbtfL1
	lPEz41yeOwPm2vk4vxJXJ9T9q84TEZqBndWmvb12gOudtdwbnDKVj/6UeBpW+De4
	KByo83GkBl+Ay+8mI+EwCDCRmwR9dr5YpIC4uRtRa7+y84u83UxfM1jvcPBi2FrW
	oB+TiBcYfJDZTeeWKSyIkaIoHi1Oezu9Wle2E3mxyHqjcyHiDKq5gWvhGAhsjj3I
	Zq2gT48b7FMFG4r7hKPAEL81YmUClx8sv3rFtWVe4RaNYFm5WmX10Y/1AqQGZVxh
	lE17db+KSh5P5Tc59X+CZtCEFop6Qr+Q/ig==
X-ME-Sender: <xms:bvU6Z52A0EjOAxk96xRoUH1y2EhfUp6vtgjdHdv1IJDOBFrj7MIc5A>
    <xme:bvU6ZwHtBVOfrejjyzPzPn-FoEVFLdhKRMQBHlsBCSDKVVZtnHpgcL1VIJ4aqf4ht
    sRencEA6rwGeK246A>
X-ME-Received: <xmr:bvU6Z54nwf6aL6JQEN8lrRx4veqnfI-y-w2Cs3kC5IZ67OvW81nSq9avOSjrQypTH137S_AXICUfyHdRvanIVqssavLcwAs0Bh_bup5nfc-QRXb2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bvU6Z20-YdBkQDojZUwsM90JTJnwHhaUTDkZ-Y-op3belex_EinZhA>
    <xmx:bvU6Z8FGPWaV2GaHVoDRZndR37Q71_qieZSMV_OazB-WDL9aDbuCzA>
    <xmx:bvU6Z38ie665MHt2C3f9JugVhO8IsnXxxGvZ_Tnswn4L5B-Dhrdd8Q>
    <xmx:bvU6Z5lbHU29didkqKVuBoiV7Blra8ly7DZeD_E_BSRTGGuhUSWDyQ>
    <xmx:bvU6ZxP0xF7M19A7MgY7p_xk5iNNU9HOUzCi6XVkwF4llygDSp4o-vF->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 03:06:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 354e26ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 08:05:15 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:05:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 1/8] builtin: pass repository to sub commands
Message-ID: <Zzr1YaDIjweaMOm6@pks.im>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-1-761f8a2c7775@gmail.com>
 <ZziU3wmP0pigGRRr@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZziU3wmP0pigGRRr@ArchLinux>

On Sat, Nov 16, 2024 at 08:49:35PM +0800, shejialuo wrote:
> On Fri, Nov 15, 2024 at 02:42:14PM +0100, Karthik Nayak wrote:
> 
> [snip]
> 
> > diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> > index 5250913d99eba18a28878d3904cb7b2399670d02..e5b1fe287e3ec94f0d8a3a99adb68842d52992f6 100644
> > --- a/t/helper/test-parse-options.c
> > +++ b/t/helper/test-parse-options.c
> > @@ -1,8 +1,11 @@
> > +#define USE_THE_REPOSITORY_VARIABLE
> > +
> >  #include "test-tool.h"
> >  #include "parse-options.h"
> >  #include "strbuf.h"
> >  #include "string-list.h"
> >  #include "trace2.h"
> > +#include "repository.h"
> >  
> >  static int boolean = 0;
> >  static int integer = 0;
> > @@ -282,14 +285,16 @@ int cmd__parse_options_flags(int argc, const char **argv)
> >  	return parse_options_flags__cmd(argc, argv, test_flags);
> >  }
> >  
> > -static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
> > +static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED,
> > +		      struct repository *repo UNUSED)
> >  {
> >  	printf("fn: subcmd_one\n");
> >  	print_args(argc, argv);
> >  	return 0;
> >  }
> >  
> > -static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
> > +static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED,
> > +		      struct repository *repo UNUSED)
> >  {
> >  	printf("fn: subcmd_two\n");
> >  	print_args(argc, argv);
> > @@ -319,7 +324,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
> >  
> >  	printf("opt: %d\n", opt);
> >  
> > -	return fn(argc, argv, NULL);
> > +	return fn(argc, argv, NULL, the_repository);
> 
> Do we need to pass the real "the_repository" variable here. From my
> understanding, we could just pass `NULL` to avoid including the
> "repository.h" and the macro. However, I am not familiar with the
> "test-tool" helper. It my comment was wrong, please ignore.

It certainly is surprising. If this really is required I'd expect an
explanation in the commit message.

Patrick
