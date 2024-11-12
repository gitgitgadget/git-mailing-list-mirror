Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEA1F7092
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402349; cv=none; b=TlPhEyVR6ywoKumfaatz5POmY+m3F2tzgrCR72iP9YsSDtXD8sXlLfgbonTmKCBgGzaU+2wnBozZqkk32vlXzcPee7yKkYgDuh5Vtukmh2QGidc8WkhUjGROJo6HZqnqwrpijebdQL+idIBkS1Q1/YN2THF8wZpEVDQ8UU0PA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402349; c=relaxed/simple;
	bh=MxHVkqRh+C6YqPBMppjA0aJ2Cph//mnAXeDbmiZXtLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCnMA6Xh+sNrZO1kRQAEcNcSNwYdb3ZyWEjnIZ9Jc/M0KUTRLHvI6xR3VriIBFXVQLWkGhajb3MitWOiRb4PLpEpmSi5VjfiRxtNBZFR+e3K885wtbf3AKFC8gs/QCU77UxTTTjUgw27JI4X5P8j5NwjZVVOGnWURgenEgpERkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cKswGPT5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPbP9REN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cKswGPT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPbP9REN"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D43E92540130;
	Tue, 12 Nov 2024 04:05:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 12 Nov 2024 04:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731402346; x=1731488746; bh=3xJlJodBKN
	5mAt5XYfxQ8RRwbI71PDcEQFCzPwtFWqw=; b=cKswGPT5d7KgeMQr/RER7FjjSy
	NVBUIRkYNRt+pt0ecpIRzwoE1k0YkFxE2Ym2SK5+T85o1+vJ5yr2UWn0ikUBYQgW
	F3yL0VvHFbnThBvz9uu6Eny5AyJ+R1xRo7Hf0YtTG90Ym+BiNp0LbIZUYMuEXGPK
	nbDFWmYwOSlQblIqP0UqzVqmDO182+TSemT2cFKDbytWujASD5h3xs3OOKKTLLeR
	clKzCnmAcI9f05KOY4ROJftMHIZuQyKNNYUfGPZ1+zIeg7+dwxjlS48egTGLpfoC
	UKDMEtxCURdIG9IMnvWZNMHiWtYWJkHO9dQ+1Um3yt1guKgA8z/i2Iog320Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731402346; x=1731488746; bh=3xJlJodBKN5mAt5XYfxQ8RRwbI71PDcEQFC
	zPwtFWqw=; b=VPbP9RENjn4sLHs4wh2jQbrQwRuFnu1fventv8Qia5IHFl9jho8
	KvTbMisdwDKSs8mihX3sae4AkFFyONHibnve8ChkOXcxNX0+136z3pxEqtLWGBlo
	E2wYglf0yWHQbJaDPFNB7tJBmnL9fzLKkqZ68VgQqQF5VZ2hFQxvRX9757xc8pZ2
	w3jR+j9Jdu+ar+7iVIDk2ZRI2HGnJzIaJBtXdmqkGqLoz8WmNrqJzOTYN+S/Znn4
	FRjy+TFC2qxwr1JMdKYcBsZycuwk8WGI95jcoSgO0pud8nPl80lOEk9H4Nf340S0
	un/bUXkzG3j5oh4vwn+8f2VV8mqdFZJbRLg==
X-ME-Sender: <xms:ahozZ8Cbjiw_aeSS2aEqZ91pOZEPWCJtUo5vG98IXfbZ5T8I_mVIEw>
    <xme:ahozZ-jsnHU8KMIOfaM_UtBQJWztQJfyIaTgzkCMWeBCrHvqYWH8DaUZMinK_VBRm
    LZBjsE_6c3jtCOjbA>
X-ME-Received: <xmr:ahozZ_mm6Z1c_3tjKit__XKIcbVbs2yLwkEc34J9F--A0hmOmFQJd-UeYHs7dEF9mMLjOYb6n7Dh2pSgzUogjQIzRcM1BOW71Gj1Kep54OP9FUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:ahozZyw670hmcjF-O5I_-_G3b36gCHrwnvv7SF23wOkq1i0pKcUqRQ>
    <xmx:ahozZxQR8wCvIVrEtgNfcxL3T1qDZ03--FrqFj1FuitWHtWeVOde3g>
    <xmx:ahozZ9bZLGDSkM15UvW4mZtJtEG8z0lxK6MWpUBGv8VhlMZe55s7Tw>
    <xmx:ahozZ6SVtBZygI4C2DwuXmi8NF7o_N9YRLx9khPhkox8_NrydEbL0w>
    <xmx:ahozZ8esn7d3fakukatjl0aPPE9C0ntETpOipkKwi9DPEtFzIb4hcCRr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:05:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 673cbb2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 09:05:08 +0000 (UTC)
Date: Tue, 12 Nov 2024 10:05:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/8] refs/reftable: handle reloading stacks in the
 reftable backend
Message-ID: <ZzMaX8HCj3GO5JUJ@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
 <bab837e3733a982973bb96eedca15d073089693a.1730792627.git.ps@pks.im>
 <xmqqo72l54yb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo72l54yb.fsf@gitster.g>

On Tue, Nov 12, 2024 at 03:41:48PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > -	ret = read_ref_without_reload(refs, stack, refname, oid, referent, type);
> > +	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);
> 
> 
> The following bit is curious.
> 
> > +	ret = backend_for(&be, refs, update->refname, NULL, 0);
> > +	if (ret)
> > +		return ret;
> > +
> 
> We locate one without reloading, and ...
> 
> >  	/*
> >  	 * Search for a preexisting stack update. If there is one then we add
> >  	 * the update to it, otherwise we set up a new stack update.
> >  	 */
> >  	for (i = 0; !arg && i < tx_data->args_nr; i++)
> > -		if (tx_data->args[i].stack == stack)
> > +		if (tx_data->args[i].be == be)
> >  			arg = &tx_data->args[i];
> >  	if (!arg) {
> 
> ... only when we cannot reuse preexisting one, ...
> 
> >  		struct reftable_addition *addition;
> >  
> > -		ret = reftable_stack_reload(stack);
> > +		ret = backend_for(&be, refs, update->refname, NULL, 1);
> >  		if (ret)
> >  			return ret;
> 
> ... instead of directly doing reload on the instance we already
> have, we do another _for() to locate one, this time reload set to 1.
> 
> That looks like doing some redundant work?  I am confused.

It indeed is redundant work, yes. And in fact it is redundant work that
isn't really required anymore. My first iteration didn't yet have the
`reftable_write_options::on_reload()` callback, and I instead tried to
catch reloads via `backend_for()`, so it was required to reload via that
function.

But now that we do have the callback that isn't needed anymore, and thus
we don't have to call `backend_for()` a second time here. I'll adapt
this accordingly.

Patrick
