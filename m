Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA8329E6D
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731045; cv=none; b=sSi5PEr46oLDvQ38Qq75KI0Sd88EnmOnAAbvpPU+zRDAWk7CChd/hN4QFvRrSvSI4D8UPmuJVlYtl6mrY5j9SWeyVr9+J/AHhoEOkJoKaNo0B2RBlZlSuQmwNUNi1Yq7OBv8OJQPDodO4DBsEDaooykWZsdGm57B7zdsdfSEJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731045; c=relaxed/simple;
	bh=tjSX8juFwoT1FVIZFq7OmU3dOyy00FG4S4p1QJ4RWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Z5BGri5gwNL1fJ71TRRQz8j2JQ0C6pVBG2b0Z1snmNX3sqkLnTPmK6nYWGOX13PKX75SLwkOfisBSVunaAfRkcLcCKiQjqWMNLq5CFhtRKaxO4e3B7gGzDePWe8lroH5cgWD3zT+98DUaeJjmtnrwx4m3P9FjzSEEy+/7YtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bqsaC83Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CXxnznH8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bqsaC83Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CXxnznH8"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 341CFEC075A;
	Tue, 10 Feb 2026 08:44:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 10 Feb 2026 08:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770731043; x=1770817443; bh=iw9PvYi2MY
	iFgOeSORpCMRM3QLQj2NNaGPaFMhRgd+E=; b=bqsaC83ZmCTjjCQPRNANH0h8Bt
	hScKqMrU1pKV18aV7vvfszLVcE8Is1tPzEtSfo5N1SB3tN+nhwsSEVTryL74qjKA
	M/nJFskr5RtdQUoynw+8j9wekyPEvYJBrukGgpzosmRfwmfoOkN6b0YRVFRQFh4x
	UT0wbChmUqdhr9n8SDqlJlcMJjwToVDEW7if0S0IUF3mv2//oYvAqA4Upsfq3br8
	QeJcUvz4ZMeLeRTxz10Tb796vx8Eby94/kZy+xOTd5Is5RaQxgl4KfZN0y5VHo/5
	na35+ak1yuj0OkNHTNjFTOxW9+3io82MFaYBo7vr3XYLgwYBJ1Rx1UPnM6dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770731043; x=1770817443; bh=iw9PvYi2MYiFgOeSORpCMRM3QLQj2NNaGPa
	FMhRgd+E=; b=CXxnznH8NXFmaWDxb4jzRC98UJcslcVxuNVjK1YLZF+25kB+C2H
	TbSnHPrWGTblBGxh4Wfc0XJ9D9ciaZi7563ESlMLt1wTJtxpWfGhyokOA5/E/d5n
	yM/PqXVMHqdWaAHk4qF2fKoU7xcRWylRwmgEKXpv468untFJdBGygGZLLdRiS2PQ
	eRTsP78z88k/kUqLaDmDI6qGVM0b9Pu2RCot7ZpKz0tSo0cP/hcOKPp2CaLrQ6Ni
	vBp1OJwu79Dh6ODQPTUilPFpzVPJADLq/JARgL7MOff+TVc1+8/4D/39Ii2dWy/i
	opm3eDYuxnPi58UXsQZmsLCFrXWm+g7Ushg==
X-ME-Sender: <xms:IjaLaT5NLRUsGnEaO5MrfEvdGIUONr0ZkOL4vE8nOfMR56k761Af0A>
    <xme:IjaLabKbpa__k30WxE60UUxukROy9BqYQs2Efoun-qtRGVE3y_PQJJXyHc-1g3l5f
    6hVqGfuWQ8bcZManH2g_YXrzetpbhG8ASNJW4o4u5Qm2Xkz_evO7T8>
X-ME-Received: <xmr:IjaLacsSwWLKMU069v4TwIW3_Bh0gCDOb-_cIIzZEGvoOoGAJxSr_bgKKU1XIHXNnyrAlxVetkG77BmDrTFI-EuWjw0LfuMEW9N2DObMZXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihsh
    hhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrg
    gsohhrrgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IjaLaaLQ6m7B7HrLNb1jnxFbGyqMScZp2w1_7O21D5EBLNHgGZ2yVQ>
    <xmx:IzaLaV81eUqcRDXhrf2gq1iRo_1nh1KcObSFAZmKWmNa1CXCFhwXpA>
    <xmx:IzaLaTxzcINMsLKzVIWfkTtNnqT4_Cz_HrhPrY0k4WnMTpJmCgBVYg>
    <xmx:IzaLaS5Uk7U1jjM6z-sLBuqGOk4-z95PGYsM704-DyO7gAjLfjZi-A>
    <xmx:IzaLaY9mtcJsA1o66KjkJBI6B_ufCS27dqAEJDKUsTmmKhhDhuIFPt6y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 08:44:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a879d7a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 13:44:00 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:43:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/4] hook: run a list of hooks
Message-ID: <aYs2HiFkEciZkydr@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-2-adrian.ratiu@collabora.com>
 <aYnu7e_hbSBwu9_N@pks.im>
 <878qd1235o.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qd1235o.fsf@gentoo.mail-host-address-is-not-set>

On Mon, Feb 09, 2026 at 08:16:35PM +0200, Adrian Ratiu wrote:
> On Mon, 09 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> > On Wed, Feb 04, 2026 at 06:51:23PM +0200, Adrian Ratiu wrote:
> >> diff --git a/hook.c b/hook.c
> >> index cde7198412..fb90f91f3b 100644
> >> --- a/hook.c
> >> +++ b/hook.c
> >> @@ -47,9 +47,49 @@ const char *find_hook(struct repository *r, const char *name)
> >>  	return path.buf;
> >>  }
> >>  
> >> +/*
> >> + * Provides a list of hook commands to run for the 'hookname' event.
> >> + *
> >> + * This function consolidates hooks from two sources:
> >> + * 1. The config-based hooks (not yet implemented).
> >> + * 2. The "traditional" hook found in the repository hooks directory
> >> + *    (e.g., .git/hooks/pre-commit).
> >> + *
> >> + * The list is ordered by execution priority.
> >> + *
> >> + * The caller is responsible for freeing the memory of the returned list
> >> + * using string_list_clear() and free().
> >> + */
> >> +static struct string_list *list_hooks(struct repository *r, const char *hookname)
> >> +{
> >> +	struct string_list *hook_head;
> >> +
> >> +	if (!hookname)
> >> +		BUG("null hookname was provided to hook_list()!");
> >> +
> >> +	hook_head = xmalloc(sizeof(struct string_list));
> >> +	string_list_init_dup(hook_head);
> >> +
> >> +	/*
> >> +	 * Add the default hook from hookdir. It does not have a friendly name
> >> +	 * like the hooks specified via configs, so add it with an empty name.
> >> +	 */
> >> +	if (r->gitdir && find_hook(r, hookname))
> >> +		string_list_append(hook_head, "");
> >
> > Why is there a check for `r->gitdir` here? Do we ever execute hooks
> > outside of a fully-initialized repository?
> 
> Nice find. The answer is yes, see the last commit in this series.
> 
> I've been cleaning up and untangling this series for quite a while now:
> - It used to be combined with the other parallel hooks series.
> - It used to implement its own linked list abstraction.
> - It used the hook.h string-list APIs AEvar didn't like.
> - and so on.
> 
> This cheeck is just a leftover bit I missed during my cleanups and I
> really should be moved this to the last commit. I've been moving a lot
> of code around to make it as clear as possible.
> 
> I'll do it / test in v2. Many thanks!

That should indeed lead to less puzzlement, great!

> > Other than that, we now insert hooks into the list. It's somewhat
> > surprising that we insert hook "names" here, instead of for example
> > adding the full hook path to the list. Is there any specific reason for
> > this decision?
> 
> I'm also not a fan of this design, as I mentioned in the reply to Junio.
> 
> We just need to differentiate between "new" hooks (from config) and
> "default/legacy" hooks (from the hookdir) and we kind-of abused the fact
> that the default hooks have no friendly name, so the name is empty, to
> differentiate them. :)
> 
> Junio suggested we use a struct/union and a specific type to
> differentiate between the "default/legacy" hooks (from the hookdir) and
> the new config-based hooks.

Yeah, that sounds like a reasonable thing to do.

> That way we don't have to rely on the name anymore and we can also use
> the full path here, as you suggested.
> 
> I'll do all this in v2. Thank you!

Perfect, thanks!

Patrick
