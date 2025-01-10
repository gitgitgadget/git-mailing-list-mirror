Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F520C022
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502594; cv=none; b=CsAkPhRL36OUwBfzoJBZcE9z5zddvIdk4/HDnCOB7a0p4pqbiATQHhRcUhhW/BntgPew4jE1Tibc5Id2upHHUtCA/cwJNPnm+dU/DHoqDRSTFBNoGod5fEaZdioGEjYf5RsXrIpbmFqDPkGxyktehsktkmQ6ckx2BhYjQ5sUBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502594; c=relaxed/simple;
	bh=DpWvhotPov4KqjU8AnZF/ksog4wTmTi2cIyNZrdbhRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaVtXAk2VObdEGschhPBMjf7TZPXrqjqCiwXGGBPsLgkZF2MamPBehz8JJcXMH6Bu3XvcQa60jurrcv3RiYoU7VF3l65fyY3UFPrmeszS4hERsTfgcmIwZIWiHgv+ERpdwx1eVMH1aVW0Id7VMHwYTUrlUABbwhSNuihb1yflFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kdax3+BU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cdw7WQ/D; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kdax3+BU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cdw7WQ/D"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A9281140167;
	Fri, 10 Jan 2025 04:49:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 04:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736502588; x=1736588988; bh=zzUL2R/1Sc
	/eIGtWa+r7zPJ+LqqNmP7IGpyVurN7BXQ=; b=Kdax3+BUYwAi65pjB8/q5lrwiO
	7bKRFJTcRGypWlQh3XKncy5ve90lBeOzaijlIMf93UkAljqdzU02/7QQ/aTMeNo8
	ZjUplji4mIGn1x1S42eyf8mWTYyPthzJmB0NILfEj5t5eHDbUKVGFKqBlFR49tmV
	BMHuyUuujzfXOqFgx45FM4vIRKuKFbrLP7/GScBaUEmOd8YI07a/a4tvKwEyhSbS
	uMS3FvrfTSq22xHABE3+iYOsbB35NzBBiT66bE+6i6igO7+blP14oD+QBA2i+m3M
	84Tp8/XvWD9KsRbgfKzx9jOF+eQx/4X88B1DwDdJeV0pT5sK2V10P2bn5Ovg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736502588; x=1736588988; bh=zzUL2R/1Sc/eIGtWa+r7zPJ+LqqNmP7IGpy
	VurN7BXQ=; b=Cdw7WQ/DghWgVxIpOhNWUyifWZPt4ZPrPJTZnB1OtWmsnGNPRZs
	3Y+Meu69mONQv/iWP6nAHjdmVrIwMA3XdVxe469SD54hZGOWhAQumFfguxrElp2l
	3pPhz/lAzcCylyYc2SUrVpAnex7pZWfj7B/VoRrhTrTnWePjRxdoSDYLZ4vF+2d+
	KIFXmHs8HgDamzyckmGmct2xwt8Qi1oGhpBLA4oJcjimwHlIAlswadf6rZgOLEb1
	3ZYDud3AWWB4Efkc1j+G1kAudEbVoiknMNv2+xVbMVNJ0vdorsbtXBaQCPLIwvlt
	T2DLl8qwORKexeMAt2/JTEPWY4o3DCvqP+g==
X-ME-Sender: <xms:O-2AZzMfUJgobdPUO8UKSJ84yi0CF4PJ7akSLl-Chlrbz1F-1W-MLg>
    <xme:O-2AZ982Hxs8TPXdP2JzA-pHmrKZ3n13RoQ1UmgcMcLy4MvgjqSiw-8Klt-_keVmF
    d6ti1HWqAMJ7KZoAg>
X-ME-Received: <xmr:O-2AZyQPi4Y0idu2_gM7t8ti9q950DBjuuPBaNrxSAOD5BXDxEk02EitDjzEGNtNVD0yQ2E1WRq-wBBeWELZfIWNaPNiiG9Q84XGhNEUlbsj8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepheduveehgeejvdevjedtiefgtefffedttdeuteffgfet
    feeikeejfffgtedtueetnecuffhomhgrihhnpehhhihruhhmshhlrgifrdgtohhmpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:O-2AZ3s246rDAICmZA_FjK_dFbWs_yfGqimjowRtpF7ZQTiSJ_NeNw>
    <xmx:O-2AZ7d4WAW8onx7hlafPdIgWh9l4yuutHjvuxtAUSRM1m3CjwGPNw>
    <xmx:O-2AZz1suj7E5D7nXpsD4cC3ECdfmnOLWMR3vViaD0lzj4Jsn-h1fw>
    <xmx:O-2AZ391eFOklRSma2p7u57N-1Xod2OKwI2TIb93HEHhFFYGUlt-5A>
    <xmx:PO2AZ8pFn3sZlCkl3auWy49CLfPY3vgdkyCsjQnu-lq-zoJHJouUDRfn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 04:49:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e570e1d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 09:49:43 +0000 (UTC)
Date: Fri, 10 Jan 2025 10:49:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
Message-ID: <Z4DtMPN_sK4Hqxs3@pks.im>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
 <c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de>
 <Z3-vpLHvxoQCTjY1@pks.im>
 <02ab59c0-a495-9f96-6323-af73cb483f38@gmx.de>
 <48ca0114-124b-e3f5-af80-1e302bf9ce52@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ca0114-124b-e3f5-af80-1e302bf9ce52@gmx.de>

On Fri, Jan 10, 2025 at 10:27:23AM +0100, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Thu, 9 Jan 2025, Johannes Schindelin wrote:
> 
> > On Thu, 9 Jan 2025, Patrick Steinhardt wrote:
> >
> > > On Thu, Jan 09, 2025 at 11:49:43AM +0100, Johannes Schindelin wrote:
> > > > > diff --git a/builtin/blame.c b/builtin/blame.c
> > > > > index 867032e4c16878ffd56df8a73162b89ca4bd2694..ad91fe9e97f90625dd2708fbd44bf2dd24a337a6 100644
> > > > > --- a/builtin/blame.c
> > > > > +++ b/builtin/blame.c
> > > > > @@ -475,6 +475,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
> > > > >  		char ch;
> > > > >  		size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
> > > > >  			the_hash_algo->hexsz : (size_t) abbrev;
> > > > > +		if (length > GIT_MAX_HEXSZ)
> > > > > +			length = GIT_MAX_HEXSZ;
> > > >
> > > > This causes a subtle change of behavior because there are a couple of
> > > > conditional code blocks between this change and the `printf()` call
> > > > decrease `length`, i.e. specifying values larger than the maximal hex size
> > > > causes potentially-desirable, different behavior (and think about
> > > > https://www.hyrumslaw.com/).
> > >
> > > Alternatively we can move this until after we have done the
> > > subtractions. Then we don't have to do weird gymnastics.
> >
> > Or we can even avoid assiging a maximum altogether:
> >
> > 		if (length < GIT_MAX_HEXSZ)
> > 			printf("%.*s", (int)length, hex);
> > 		else
> > 			printf("%s", hex);
> >
> > Or be more consistent with Git's source code style which often prefers
> > ternaries, favoring succinctness over readability:
> >
> > 		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), hex);
> 
> Coverity noticed a problem with this approach, looking at
> https://github.com/git/git/blob/v2.48.0-rc2/builtin/blame.c#L493:
> 
> 				memset(hex, ' ', length);
> 
> If the `GIT_MAX_HEXSZ` guard is moved after this statement, then we can
> easily overrun the `hex` buffer.

Oh. That's even an old-standing issue that wasn't caused by the
refactoring, right? Your proposed fix to set `length = GIT_MAX_HEXSZ +
3` to account for the old behaviour wouldn't fix it either, as we could
still end up overwriting two bytes.

I'll send a new version with another commit on top to fix this.

Patrick
