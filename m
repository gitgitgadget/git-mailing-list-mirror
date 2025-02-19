Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36C286291
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965933; cv=none; b=bfPtt2FApZKGIl7v9x892wr1NotHVsMTHIw7i/Tjb/I2C4jtkapgSLfKPSIx824kaf4po49zLFwxUU7RzXhEBEBL/h0EcmdGw6N1OVLAkncKowx9vFiboirRfZgK9ry2P3KyFtdkxzbGk4xTDiR1sF6K7kGemdgoW1F7ranbZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965933; c=relaxed/simple;
	bh=17dSJEdIEJLOW3JseYhsKfRTyAhhfSwzU5yvrcUMcUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg0M0XkWcUv7v3jYurmqxyUJ/Rlkr7RGZs9bWTevVnjSVORUeU+5lcMRoexbf3YIZmYLIi/XVrllb+rKDDaGpu+zWziRK6LYx0nYnoWAwkL87UkW3rja8nagI7Ij08jh3JpCtKlf1T1UaG71UMXSU1W9JEJCrzuPxqzGllso9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QaEqgPbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Faj/GLxf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QaEqgPbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Faj/GLxf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 699931140113;
	Wed, 19 Feb 2025 06:52:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 06:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739965930; x=1740052330; bh=mWchN78AVT
	0fOy8dX6LsbVE2FzAhmqsneLq6LwAL88I=; b=QaEqgPbP8zOrR/XUiT+ZEY24EK
	EP68bUTkWeoCYTKewuW9//CLL1ys2+3h9wSdlfryzZObGwbMqncdEManiWJKniL0
	EzLpPtq37qVAWhG68vt5gvfxFsHkwPU+bk6hG0qnAqoewPmIuAI4iJdTxEskn40O
	F7lOUj7kZEKmYYHrb2RAKz7IoJWwnGARjrAIMXiIcbf4SAb5STC34XNd1Hpmye4Z
	zoKkeiLfimjdJ5Txp1+uP55HjG/sPk2i9eUU0XoLTfU+7SxTGqYgPN062PWzCX2P
	BHNTI6vLNOiEesIOJEzgu4c2xQGSobQz/iRZAq95m15Z2De19tfbQiakOVEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739965930; x=1740052330; bh=mWchN78AVT0fOy8dX6LsbVE2FzAhmqsneLq
	6LwAL88I=; b=Faj/GLxfnCGYUhBEqYW/mhJJ0Sy3H5WLrhQSPe7MWMVS8McGE4F
	Z2HyT2ef+zKcG2cmDJoNY7uDw9OTEjCv1FXXfNMO3CP0WlFvuuacjCP+uQWpTdDK
	0XgAIPzwMSkc6Tw6FD5KXkrvI7olOVr6BvYQN1lKqeJINgDC/BGSdvNPaKdxwoL6
	tb5cUw1psfGIkJ4H63SsB71eMy3LQW8iI0Ej1Dk5rlb4ul5FGLoLeeA1BAhmgV8n
	avJ3WK2DyVxYxsEuKg4YJJyVhKdAXVvNL+zprrcApVPy1lj1Vhra9eBmPnqct9HQ
	yVmcqPObpinZ4BZYA9sT+hX0T4kxEEBpojg==
X-ME-Sender: <xms:6sW1Z-nik3Ccm6AHonkRRmmD-NuBqXDS90QV_8C6Yg2zKG9Q9YANtg>
    <xme:6sW1Z10Pl1FzM3_SG0eGy9SZgXJFGN6OrRMJIlCMseOE9b4RNK_Vy8TsPW48MS0nk
    zWgOZk1i_F05YIekQ>
X-ME-Received: <xmr:6sW1Z8pwOzzJkj4XX2ps1rcRD1NCg9B9B-ktwOKJdAlBvajt9EAEi0805mW2dpZF7KDF4O5NIthD039BHegb2rfSUdTWzVp8-yc-f59Um-7ooOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnh
    gurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6sW1Zynuv3fivzcIpwcEPLxFyRlNAfB20Z8sQ2w5xNdkGEXGuf-zQg>
    <xmx:6sW1Z80BwcQb_VwmZofJhU4xwbqAm6pqQpBkRsqva6eBpfz2DmwVKg>
    <xmx:6sW1Z5uOrh1YQxxh2Az63OHodmmJHLhHgd0VKBXIpRQkfV8f3ECKBg>
    <xmx:6sW1Z4WL88qVAz91u2q-HOMEPOhKgdmyaE6tsN0iKnL1oYBe0gweAQ>
    <xmx:6sW1Z9kqB66xayP_aS9auinPB7h0NoamOUMyQ4zaNcffjLeN4VnRbXbK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 06:52:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8978943e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 11:52:07 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:52:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XF5pGsa42jrIcN@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7S6xzmPb3lK-SdT@ArchLinux>

On Wed, Feb 19, 2025 at 12:52:23AM +0800, shejialuo wrote:
> On Mon, Feb 17, 2025 at 04:50:21PM +0100, Patrick Steinhardt wrote:
> > The ref and reflog iterators have their lifecycle attached to iteration:
> > once the iterator reaches its end, it is automatically released and the
> > caller doesn't have to care about that anymore. When the iterator should
> > be released before it has been exhausted, callers must explicitly abort
> > the iterator via `ref_iterator_abort()`.
> > 
> > This lifecycle is somewhat unusual in the Git codebase and creates two
> > problems:
> > 
> >   - Callsites need to be very careful about when exactly they call
> >     `ref_iterator_abort()`, as calling the function is only valid when
> >     the iterator itself still is. This leads to somewhat awkward calling
> >     patterns in some situations.
> > 
> 
> In what situations, the iterator has been disappeared when we call
> `ref_iterator_abort`? Why is this awkward? When reading, I am really
> curious about this.

It leads to patterns where you have to call `ref_iterator_abort()`, but
only in a subset of code paths. You need to be really careful about the
lifetime of the iterator, and I had several occasions where I was doing
the wrong thing because I missed this subtlety. Compared to that, it is
trivial (and less code as demonstrated by the patch) to unconditionally
call `ref_iterator_free()`.

> >   - It is impossible to reuse iterators and re-seek them to a different
> >     prefix. This feature isn't supported by any iterator implementation
> >     except for the reftable iterators anyway, but if it was implemented
> >     it would allow us to optimize cases where we need to search for
> >     specific references repeatedly by reusing internal state.
> > 
> 
> So, the reason why we cannot reuse the iterator is that we will
> deallocate the iterator? So, below we want to detangle the lifecycle. I
> don't know whether my understanding is correct.

Yup, your understanding is correct. A deallocated iterator cannot be
reused.

> > Detangle the lifecycle from iteration so that we don't deallocate the
> > iterator anymore once it is exhausted. Instead, callers are now expected
> > to always call a newly introduce `ref_iterator_free()` function that
> > deallocates the iterator and its internal state.
> > 
> 
> A design question: why do not just introduce a variable, for example,
> `unsigned int free` to indicate whether we need to free the iterator?

Because that would make the code even more subtle than it already is.
Doing things unconditionally is always easier to reason about than doing
them conditionally.

> > diff --git a/dir-iterator.c b/dir-iterator.c
> > index de619846f29..857e1d9bdaf 100644
> > --- a/dir-iterator.c
> > +++ b/dir-iterator.c
> > @@ -211,11 +211,11 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >  			int ret = next_directory_entry(level->dir, iter->base.path.buf, &de);
> >  			if (ret < 0) {
> >  				if (iter->flags & DIR_ITERATOR_PEDANTIC)
> > -					goto error_out;
> > +					return ITER_ERROR;
> >  				continue;
> >  			} else if (ret > 0) {
> >  				if (pop_level(iter) == 0)
> > -					return dir_iterator_abort(dir_iterator);
> > +					return ITER_DONE;
> 
> Instead of calling `dir_iterator_abort`, we just return `ITER_DONE`.
> However, this does not make sense. We break the semantics of
> `ITER_DONE`. Let me cite the comment from "iterator.h":
> 
>     /*
>      * The iterator is exhausted and has been freed.
>      */
>     #define ITER_DONE -1
> 
> However, we don't free the iterator here.

Oh, yeah, I'll have to adapt that comment, thanks for pointing it out.

> > @@ -266,7 +265,6 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
> >  	free(iter->levels);
> >  	strbuf_release(&iter->base.path);
> >  	free(iter);
> > -	return ITER_DONE;
> 
> I am confused that why we don't provide `dir_iterator_release` for dir
> iterator? For other ref related iterators, we will rename "*abort" to
> "*release" and drop the operation to free the iterator. However, for dir
> iterator, we rename its "*abort" to "*free".
> 
> I think this does not make sense. It causes inconsistency. Although dir
> iterator does _not_ have "peel" method. But it does have "advance" and
> "abort" methods just like ref iterators.
> 
> I think you have already considered this problem. I guess that's the
> reason why in the below comment you typed `dir_iterator_release` instead
> of `dir_iterator_free`.

The `dir_iterator` itself is already being inconsistent with every other
iterator that we have because it is not a `ref_iterator`. It is _used_
to implement ref iterators, but doesn't provide the same interface. And
because of that we cannot rely on `ref_iterator_free()` to free it, but
must instead provide `dir_iterator_free()` to do so.

I have amended the commit message to explain why this one is special.

> > diff --git a/dir-iterator.h b/dir-iterator.h
> > index 6d438809b6e..01f51f6bac1 100644
> > --- a/dir-iterator.h
> > +++ b/dir-iterator.h
> > @@ -27,10 +27,8 @@
> >   *             goto error_handler;
> >   *
> >   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
> > - *             if (want_to_stop_iteration()) {
> > - *                     ok = dir_iterator_abort(iter);
> > + *             if (want_to_stop_iteration())
> >   *                     break;
> > - *             }
> 
> Is this correct? If `want_to_stop_iteration()` is true, the `ok` will be
> `ITER_OK` and then it breaks the loop to jump to check whether the `ok`
> is `ITER_DONE`. Of course it is not, it will call `handle_error`. At
> least, we should assign `ok = ITER_DONE`.

True, fixed.

> >   *
> >   *             // Access information about the current path:
> >   *             if (S_ISDIR(iter->st.st_mode))
> > @@ -39,6 +37,7 @@
> >   *
> >   *     if (ok != ITER_DONE)
> >   *             handle_error();
> > + *     dir_iterator_release(iter);
> 
> I think this is a typo. Should `dir_iterator_release` be
> `dir_iterator_free`?

Yup, fixed.

> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 29f08dced40..9511b6f3448 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -919,10 +919,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  		return ITER_OK;
> >  	}
> >  
> > -	iter->iter0 = NULL;
> > -	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
> > -		ok = ITER_ERROR;
> > -
> 
> We don't abort the iterator in `advance`. Is this because we want to
> reuse this iterator?

Exactly, this is basically the gist of this whole patch.

> > @@ -935,23 +931,17 @@ static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
> >  	return ref_iterator_peel(iter->iter0, peeled);
> >  }
> >  
> > -int ref_iterator_abort(struct ref_iterator *ref_iterator)
> > +void ref_iterator_free(struct ref_iterator *ref_iterator)
> >  {
> > -	return ref_iterator->vtable->abort(ref_iterator);
> > +	if (ref_iterator) {
> > +		ref_iterator->vtable->release(ref_iterator);
> > +		/* Help make use-after-free bugs fail quickly: */
> > +		ref_iterator->vtable = NULL;
> > +		free(ref_iterator);
> > +	}
> >  }
> >  
> 
> So, when calling `ref_iterator_free`, we will call corresponding
> "release" method to release the resources associated and then we free
> the iterator. Would this be too complicated? From my view, we could just
> make the `ref_iterator_abort` name unchanged but add a new variable such
> as "unsigned int free_iterator". And we change each "abort" callback to
> avoid free the iterator. This would be much simpler.

I think adding a separate variable to track whether or not things should
be freed would make things way more complicated. I would claim the
opposite: the fact that the patch removes 100 lines of code demonstrates
quite neatly that the new design is way simpler and needs less logic.

It's also simpler to reason about from my perspective: you allocate an
iterator, you free it. No conditionals, no nothing.

> [snip]
> 
> > diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> > index 02f09e4df88..6457e02c1ea 100644
> > --- a/refs/ref-cache.c
> > +++ b/refs/ref-cache.c
> > @@ -409,7 +409,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  		if (++level->index == level->dir->nr) {
> >  			/* This level is exhausted; pop up a level */
> >  			if (--iter->levels_nr == 0)
> > -				return ref_iterator_abort(ref_iterator);
> > +				return ITER_DONE;
> 
> As I have said, simply return `ITER_DONE` breaks the semantics of the
> `ITER_DONE`.

It doesn't: `ITER_DONE` indicates that the iterator has been exhausted.
The current comment is stale though, as it claims that the iterator will
also have been free'd.

> > diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> > index aaab711bb96..27ff822cf43 100644
> > --- a/refs/refs-internal.h
> > +++ b/refs/refs-internal.h
> > @@ -292,10 +292,8 @@ enum do_for_each_ref_flags {
> >   *     struct ref_iterator *iter = ...;
> >   *
> >   *     while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> > - *             if (want_to_stop_iteration()) {
> > - *                     ok = ref_iterator_abort(iter);
> > + *             if (want_to_stop_iteration())
> >   *                     break;
> > - *             }
> 
> I also think here we have problem, at least we should set `ok =
> ITER_DONE`.

Yup, same as in the other comment indeed.

> Some my thinking after reading this whole patch:
> 
> 1. We somehow misuses the "ITER_DONE". We either need to adjust its
> meaning (we just delete the iterator is freed part) or introduces a new
> state to represent that the iteration is done but we don't release its
> resource and free the iterator itself.

Yup, addressed.

> 2. I don't think we need to make things complicated. From my
> understanding, the motivation here is that we don't want to `advance`
> callback to call `abort` callback. I want to ask an _important_ question
> here: what is the motivation we rename `abort` to `release` in the first
> place? As far as I know, we only call this callback in the newly created
> "ref_iterator_free". Although release may be more accurate, this change
> truly causes overhead of this patch.

We have to touch up all of these functions anyway, so renaming them at
the same point doesn't feel like it adds any more complexity.

> 3. If the motivation is that we don't want to `advance` callback to call
> `abort` callback. I think we could just let the user call `abort`
> callback for the following two situations:
> 
>     1. We have exhausted the iteration. It returns `ITER_OK`.

This is impossible because the caller wouldn't be able to discern an
exhausted iterator from an iterator that still has entries. We have to
discern `ITER_OK` and `ITER_DONE`.

>     2. We encountered the error, it returns `ITER_ERROR`.

Yup.

> And we give the freedom to the caller. It's their duty to call
> `ref_iterator_abort` which cleans the resource and free the iterator.

Yup.

> Writing here, I have always thought that there is a situation that we
> just want to release the resources but not want to free the iterator
> itself. That's why I am wondering why just add a new variable to do.
> However, if we just want to make the lifecycle out, we just delete each
> "abort" code where it frees the iterator. And we free the iterator in
> the "ref_iterator_abort". Should this be enough?

As mentioned, I don't think a new variable would lead to a simplified
architecture. With re-seekable iterators the caller is the one who needs
to control whether the iterator should or should not be free'd, as they
are the only one who knows whether they want to reuse it. So making it
the responsibility of the callers to release the iterator is the proper
way to do it.

I also don't quite see the complexity argument. The patch rather clearly
shows that we're _reducing_ complexity as it allows us to drop around a
100 lines of code. We can stop worrying about whether or not we have to
call `ref_iterator_abort()` and don't have to worry about any conditions
that leak from the iterator subsystem to the callers. We just free the
iterator once we're done with it and call it a day.

Thanks for your input!

Patrick
