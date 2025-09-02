Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C69E573
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803050; cv=none; b=MY4xk7eoURtdkOdbg91gNrDu7CffplLbNohDHcB52G4CJCBG4sP0AVPhQhwsn4WBL6D1KkpfNkRLfrOojjaia9YKUOlIS0zNiC/XzOJ8zM0rRMeQc6ruff9y5lLQCL8vhw0SLp+5GFGxAkwc6/n7zJKNQmB2OrRWLXlsAXn50NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803050; c=relaxed/simple;
	bh=XuO13f0ozE0iYBRf5cVGcMQPUNgswOYPJYdOv9ON7Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhWfATD0vIP/Y9aoj4a/SlcWXOaJ37xdG0v2VmvLeaad5s5soFDDeaeg/SCaaEPBAdYXhS1upUX7PUED6w0euCoG+YgseczZu/ofHJwVhodVpTayGYjHaLyGBp+fjyluA2UYofVXwKkROQUx7kx6bMKwUycgYt9GDFeQ7SmQ2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CZXtabcW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cX2jE/e2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CZXtabcW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cX2jE/e2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7EC4FEC054D;
	Tue,  2 Sep 2025 04:50:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 04:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803046; x=1756889446; bh=Yu6hMZm4b8
	IuD14R+IUk4lKktaud4OPi+8YpPhF9OV8=; b=CZXtabcWTnKoaYAy+NmnevGM2I
	3mYR/QDuWHHz9NN5FfJzxPJ+zNaVqS8uwXPUCbD4BR/WF0RcZgz4UZEMN3BjxClm
	wAJsyvhWhoEzBlOOySXhyQikv475eruwWz+KNwuu/NZOJf1ODsdbbHxa8i8Gy1MT
	6xYvO7A7tzci1mcIAULJ/OH6vIX3g5xM/gpmzgWPsEZFwqVsJKVnF/pW9Vzv+ERf
	FZmgH5Syl3AKaZnccTe6Hf8E4beJF5V8+rjIOq84HJpRXJAf1/483ozJES16FHe1
	UmHdSuVDNXWmwhU+xSWDK22XKZ6zwRKAXy0Z0RabpI8k6H7zbktRNzfpjXGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803046; x=1756889446; bh=Yu6hMZm4b8IuD14R+IUk4lKktaud4OPi+8Y
	pPhF9OV8=; b=cX2jE/e2uMsAAoci3rbaZIDdB/dEBloWFAm5oe+XzQZGCozHXXa
	11GA8Ud4UfeMDR1A0KZKLYkRRGvcGMDXTocW6CI/6jXRD2EIeAj08qXGiH0Wccvs
	2qNmMfSGwUkRwJZSpJtbOYubg1tNQcQdEL4vipGSEb+4X/0d8e9H1QXvzfCcx8U8
	gM4/RA2+DX4uHMcTdkxvQEqwXtI+5QlcjaKAkzG6x74cdslOyfjTmsCCGb/zMoEZ
	VBYdgcAkUrWhDjsRp1TMpJtlF6hlAPBoyYq4cFoXoLSlqshri0TWcuy84nVvGMVP
	Dv2rSid32JDo+K5vxFhjPKbqWbft2jB3PNQ==
X-ME-Sender: <xms:5q-2aAJhwFXt7hbjZypwebw5kKrKZ5ossCea77VH56oULhv9IKq1Zg>
    <xme:5q-2aKsn0_EUNRQR49AFaSKjPHDUw53KLbk8Bmc9mswnxa8wPFpwdB2XVzgP0nfOD
    tH58b-rKjKZLkGAkQ>
X-ME-Received: <xmr:5q-2aNSTT2Hz7AbAziKo7lOsTZL1_9m9lzdibmi5jpyQcC3Ru0nrznNWDk6i3wDEqikzMqb51MLXFRhn119zVtU0k7ui0arFuY28ner74QBLGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5q-2aAOfY7oeWwvYjS-Pfmid7-C0MYgTICvd6AzIZi7vxF0SVCMIhg>
    <xmx:5q-2aCa0oVyIBrulDjy8ANO1wBNj5oGjHR42AeBBblqgaKvfumyEug>
    <xmx:5q-2aKzrpkfV8UERKXqj-vwA0eeisgzKUusfCiqVTp4Oi5CCZTsgUw>
    <xmx:5q-2aNLGi_8cUw4Ti43GGHW_hMRddjIWRIyXN9UCCKEmg9z9c3HSsQ>
    <xmx:5q-2aEhlRqUHk3s9d9K2R60_naPzX13v_L_1JHhxRxI6oapVg2CEHY_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:50:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1223a12 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:50:45 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:50:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aLav4UAcfQjvNzMF@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
 <aKz0/WNu/GRYh3/W@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKz0/WNu/GRYh3/W@nand.local>

On Mon, Aug 25, 2025 at 07:42:53PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:00AM +0200, Patrick Steinhardt wrote:
> > The object database tracks the list of packfiles it currently knows
> > about. With the introduction of the `struct packfile_store` we have a
> > better place to host this list though.
> >
> > Move the list accordingly. Extract the logic from `odb_clear()` that
> > knows to close all such packfiles and move it into the new subsystem, as
> > well.
> 
> Not a comment on this patch itself, but as a meta-comment, I really
> appreciate you taking such an incremental approach here. The packfile
> machinery is quite fragile in my experience, so breaking it up into (what
> are so far) easily review-able chunks makes it much easier to build
> confidence in the correctness of these changes.

It certainly is fragile overall. I stared at code for way longer than I
really want to admit in some cases.

> > diff --git a/odb.c b/odb.c
> > index 34b70d0074..17a9135cbd 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -1038,16 +1038,7 @@ void odb_clear(struct object_database *o)
> >
> >  	INIT_LIST_HEAD(&o->packed_git_mru);
> >  	close_object_store(o);
> > -
> > -	/*
> > -	 * `close_object_store()` only closes the packfiles, but doesn't free
> > -	 * them. We thus have to do this manually.
> > -	 */
> > -	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
> > -		next = p->next;
> > -		free(p);
> > -	}
> > -	o->packed_git = NULL;
> > +	packfile_store_free(o->packfiles);
> 
> Interesting. The movement of the for-loop here all looks correct to me.
> But I think the new packfile_store is creating a new awkardness here
> that we should consider.
> 
> In existing implementation, all of the ->next pointers here point to
> heap locations that have already been free()'d. But that's OK, since
> they aren't reachable at the moment that we do "o-packed_store = NULL".
> 
> Having a separate packfile_store changes that, since (from my reading of
> the code) o->packfiles will still be non-NULL even after calling
> odb_clear(), *and* those pointers will refer to free'd heap locations.
> 
> That seems like a potential footgun to me. I think that we could either:
> 
>  * Change packfile_store_free() to take in an object_database pointer,
>    and NULL out the ->packs pointer after free'ing all of the packfiles.
>    That would make it more similar to the existing behavior.
> 
>  * Leave packfile_store_free() as-is, document that it does NOT clear
>    out the top-level pointer, and so callers are encouraged to NULL it
>    out themselves after calling it. Likewise, we should change
>    odb_clear() to do:
> 
>        packfile_store_free(o->packfiles);
>        o->packfiles = NULL;
> 
> Let me know what you think.

Good point. I think it's unlikely to ever become a problem, but I don't
see a reason why we shouldn't NULL out `o->packfiles`, either. So I'll
do the second approach.

> > diff --git a/packfile.c b/packfile.c
> > index 8fbf1cfc2d..6478e4cc30 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
> >
> >  	if (current)
> >  		scan_windows(current, &lru_p, &lru_w, &lru_l);
> > -	for (p = current->repo->objects->packed_git; p; p = p->next)
> > +	for (p = current->repo->objects->packfiles->packs; p; p = p->next)
> 
> Not a huge deal, but I do find "current->repo->objects->packfiles->packs"
> to be a bit unfortunate. I wonder if we should rename "packs" to "head"
> or "list_head" or similar since it's clear from
> "current->repo->objects->packfiles" that this is a list of packfiles.

I'd like to keep this part as-is for now if you don't mind. This is
mostly because I've got a follow-up patch series that _does_ introduce
`head` as part of making the `->next` pointer go away.

> > @@ -2344,5 +2339,23 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
> >
> >  void packfile_store_free(struct packfile_store *store)
> >  {
> > +	packfile_store_close(store);
> 
> Seeing a call to packfile_store_close() here was a little surprising to
> me. The code that you are moving has a comment that says:
> 
>    * `close_object_store()` only closes the packfiles, but doesn't free
>    * them. We thus have to do this manually.
> 
> , so I would have expected to preserve that behavior.

This behaviour is preserved though. Calling `packfile_store_close()`
does not free the packfiles, it only closes them. And we continue to
call `packfile_store_close()` in `close_object_store()`, so nothing
changes.

The only change in behaviour is that we now also know to close packfiles
when freeing the packfile store.

> I *think* that
> this happens to be OK, since close_pack() is a noop if it is called more
> than once (though I had to double check through all of its leaf
> functions that that was indeed the case).
> 
> I would probably strike this from the new function, since the sole
> caller above already calls close_object_store() before calling
> packfile_store_free().

Calling `packfile_store_close()` is idempotent indeed, so it shouldn't
be an issue to call this function twice. To me the question is whether
there's ever a use case where you want to free the packfile store, but
don't want to close the packfiles stored in it.

From all I've seen that is never the case, so I think it's sensible to
ensure that we always close the packfile store before we free it to make
things a tiny bit more self-contained.

> > +void packfile_store_close(struct packfile_store *store)
> > +{
> > +	struct packed_git *p;
> > +
> > +	for (p = store->packs; p; p = p->next)
> > +		if (p->do_not_close)
> > +			BUG("want to close pack marked 'do-not-close'");
> > +		else
> > +			close_pack(p);
> > +}
> 
> And likewise this looks good to me. I do find the braceless for-loop a
> little hard to read, but it's (a) correct, and (b) consistent with the
> original implementation, so I don't feel strongly about changing it.

Agreed, it is a bit awkward. I feel like our coding style should be
amended to say that we only do braceless bodies in case the body is a
single statement.

> As a side-note, you could inline the declaration of "p" here into the
> for-loop, but I can understand not wanting to to make the diff more
> readable with --color-moved.

I wouldn't mind adapting this while at it, too.

Patrick
