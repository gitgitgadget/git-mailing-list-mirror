Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816713E40F
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448748; cv=none; b=CVyR3H0qsQHDqPjr5thjhg10MBgghKlTOln09NQnSB4mxYS3oky0XELZ03074zFxhZ+0Mvz592UKZ3X3w1Oiy7mJFysHtuLivUcmkX/B6MM8QrnrN32tx/MeWBel7LkUE4zmYUMfrghgM8NZD+BbMbwGOaqitJLB1oQWk/2mv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448748; c=relaxed/simple;
	bh=7jVrWvckkAdue90irfiECZl5mOCMx961f6wFdTqGLrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDq/P6gSFXLVJn3dIvIl1Tetq6OabpUJGvRMgwETElcU5XEJsHbTKOX9fvzqhpnUM58Hbmgv8h+Ua0JZj14t2sESqG0gN96IAghVPBJI12BNLawIWDrFFZIPsIcHVFpvuoZ9c6ITtKm+LyHMzQNrEW8foZz5Dhmor1USRWkFZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R0ULAl9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGzmlqON; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R0ULAl9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGzmlqON"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EC89411471F2;
	Mon, 12 Aug 2024 03:45:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Aug 2024 03:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723448744; x=1723535144; bh=s6IZg6+fd9
	m/WfG9IucHKE6+ben3HvQGh1quKWZ1R2c=; b=R0ULAl9BMaXghoEYQNXj0muU1D
	utn8TzuisIHQi5ICiOv91aIIGlMSQgMoNwF42rynK1TZwruht+TH2MnY3cWpkyjk
	NOgFXqukO97zYfJ/jyE8XnG5E0Q+JczQl1XgqiBDVV5qPv8n4moLAjl4JcmuMzsk
	qg1BwshA3545PFo6L8Hgs2PSfw2eCWJpF4ZHwuOqaVp2rpBnoSq5ZYKJg9Mmxw+F
	DT0/fRpLaCiUd7KOQZQe/sel+xxCqOVEDb0IxlY/bkqQUnDdjx7E6/0QwfP1SLCd
	RYoUACEFSNKhZ0uMIByHMCfnpqC8/mFlRRmPEfRAghL9Hcwvl75vSSdxaXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723448744; x=1723535144; bh=s6IZg6+fd9m/WfG9IucHKE6+ben3
	HvQGh1quKWZ1R2c=; b=HGzmlqONsK/zINs0hax30YNHF7mVyprp1MazLAjOeBGa
	drY6gv8a4cwfYBKJXxyfnfm6ZDWC+rJ3F42ulEY+9o0For01HEf8HQn+LFFs5kNU
	p6qnRQZiAkKyEkKCNK/FKu4ljbQIAMpkXD1FG1cTHZFOqP+pwhOP/sxzshi9TfFu
	GRnZsRN0gH9Vs/SEyI2LkZYG/n/xF1i3/CA2OyL1YKHe4eHYxfETlkzInR6SGgW+
	Dz8JUk8b8cewbC78MCoGPl/GRrVJpb7MwtrL6sti6oX1n1iHR7aWahauJno8WDtz
	FvRyFtU6j5nch/g+33M39kxfi5r7GWPVP2yTMagGMw==
X-ME-Sender: <xms:qL25Zq7aIA8A_BeIetunMVZxzppn2uDQEgkQPn1PKzYNzQfGO5j4KQ>
    <xme:qL25Zj6M07kfMIHkQAGKY-2_3PGrpIgAwnWeUGKQWHKgMPOjoCGDmF8McSEM7gH4X
    IDBFvhluI1MzAbCUQ>
X-ME-Received: <xmr:qL25ZpfCmjOtW2Kc0E2lHY83pgnI9B2Pf6svnpPHME2A_p76OSfe90IyFxlQH8bH_sHh86wkLGThy4h1g_GRHBVuQchPTIaMDlSwL7a9ZeAK5j4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qL25ZnLwz50k8bsSTu6Utzsr_qFGPFEQzNypKsk2V1Raiac48Of7lQ>
    <xmx:qL25ZuKQ68RtzQNZGmFfiRppFo_tKWY649YbDyJQijtDqCu7uLUHLw>
    <xmx:qL25ZoxYtonKiLCNbTEwfpVw0j3vKvK5aSyGeFip1jE-y6ZYXrG9yQ>
    <xmx:qL25ZiIN3_G-iKg1gtTM5S6g-Vjle7SzfF1hXOT74OFPgLmuCSBkAA>
    <xmx:qL25ZjFexA-MhaBjWjuEJCWqDUUeyAO59Mz15cgdd0bHAJzWeksCHFHL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 03:45:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e2d1973 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Aug 2024 07:45:27 +0000 (UTC)
Date: Mon, 12 Aug 2024 09:45:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 08/22] config: fix leaking comment character config
Message-ID: <Zrm9ix5aN_g76Qxq@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <8fbd72a1002d1a285847c62b5524041927a7b4d4.1723121979.git.ps@pks.im>
 <xmqq34nfhrb9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34nfhrb9.fsf@gitster.g>

On Thu, Aug 08, 2024 at 10:12:26AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/config.c b/config.c
> > index 6421894614..cb78b652ee 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1596,7 +1596,9 @@ static int git_default_core_config(const char *var, const char *value,
> >  		else if (value[0]) {
> >  			if (strchr(value, '\n'))
> >  				return error(_("%s cannot contain newline"), var);
> > -			comment_line_str = xstrdup(value);
> > +			free(comment_line_str_allocated);
> > +			comment_line_str = comment_line_str_allocated =
> > +				xstrdup(value);
> 
> If you are to follow the _to_free pattern, you do not have to
> allocate here, no?  We borrow the value in the configset and point
> at it via comment_line_str, and clear comment_line_str_to_free
> because there is nothing to free now.  I.e.
> 
> 			comment_line_str = value;
> 			FREE_AND_NULL(comment_line_str_allocated);

Only if it is guaranteed that the configuration will never be re-read,
which would end up discarding memory owned by the old string. Which
should be the case already, but to the best of my knowledge we do not
document the expected lifetime of config strings anywhere.

> I still think the approach taken by the previous iteration was
> simpler and much less error prone, though.

I personally prefer this iteration. I feel that it is way more
discoverable to have an explicit indicator that something needs to be
freed, which the `_allocated` suffix brings us. With the old version,
the caller needs to become aware that the constant string may sometimes
need to be freed, and that sometimes is figured out by comparing to a
magic variable, which feels worse to me.

Ultimately, both solutions are okay-ish, but I don't consider either of
them to be great. As mentioned elsewhere, I think the best solution
would be to adapt the `struct strbuf` interface to have an initializer
like `STRBUF_INIT_CONST("foobar")` that allows us to initialize it with
a string constant. There wouldn't be any need to have two variables
anymore, and the `strbuf` API would handle the lifecycle of its contents
for us. In any case, I'd say this is a #leftoverbit and is better done
in a subsequent patch series.

I don't really think it makes sense to reroll this version to swap out
the patch for the first version again, but am happy to adapt if you
prefer that.

Thanks!

Patrick
