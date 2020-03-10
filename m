Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA51FC10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C844222C3
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPrh49Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJVmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:42:12 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45839 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJVmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 17:42:12 -0400
Received: by mail-pf1-f201.google.com with SMTP id x21so9999706pfp.12
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EXWyWWRIU49imSeVIWZ4oNs8yhpwObY1y2GU/uQNE4M=;
        b=dPrh49NjF7S9DPNg5tIUY4Ba54GiytWuPKRutlZvlz7NI8d3zH983jNEOaX1jGBQ6U
         oVV3p0Vz8cSEbR7AAAd/XMS+56hfQiP/7ec9IWRMOkMg8q2U/E3c8ANx15zII7bXVK4M
         mgA32X/LqV+sioCYS4z0EOY8JvE7NoTIhF/K/kG7B5uXVbUJxZ0x7UVWK/IGCsmAC6A2
         Yxa+JlK/N9yHLwI0PTxmUUZwkHgI8iTUusCq3QJB8zoVXspBa0uCv7O7sgymp09YAJwv
         CE7mnJZsjZKMPpzlsOIuBJaFxRMjK6nexMdBb/bBNXbwL1v/az0ZJFYCySEUXXz/oJUD
         VbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EXWyWWRIU49imSeVIWZ4oNs8yhpwObY1y2GU/uQNE4M=;
        b=Gm8AxT83BLpRf0fTkXGMLx/FH47oTyCn2idM8+FZgpY8nuGmLdT1A4wDfpg9Sw6xS1
         ZJr/+f/xb1QSkKCbS42y0U2X0cZ1CoEfONpqMIOO6KXhiLjRYP7a+jQdJcJ9zzzdcNNp
         toZNnhJWLVYP1S9jkJ16bQY6i+CAJcUzE8v6OiBiT/rCcZfb2GVuOcxcxLNXXeTzSLj0
         BRCO0YIht3Oxy6Q8ZFrqbz/D1RaVK3U4l8XANXuxrumIzhawgDJfoGi9A+EXbRxSwuwC
         gu5faho+sHUZOW2ULYyAyt9hy9uNp4tIaMIHA2Q9nfj/JqypF3mJWG8CIbeGxfuSAO2F
         HTfA==
X-Gm-Message-State: ANhLgQ3fR/IXlvksPvmtToCnEE8febjrfVrdZWT09DCAAPyWRdZYDwmG
        lX1DfcZpPYyfzXHfocS4W0/Qhtwjx/oT7JnPv1Di
X-Google-Smtp-Source: ADFU+vuX3MZAX91iWVVK1Dw31TO4uOCJp5NGN1czvZp8Wflg9S45lVCaerjr6JrggpvuThtnGhQYgf5a0PgLteQ3QdOn
X-Received: by 2002:a17:90a:4d43:: with SMTP id l3mr3571176pjh.165.1583876529207;
 Tue, 10 Mar 2020 14:42:09 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:42:06 -0700
In-Reply-To: <20200228000459.GE12115@google.com>
Message-Id: <20200310214206.81606-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200228000459.GE12115@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH v2 7/7] index-pack: make quantum of work smaller
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +/*
> > + * Stack of struct base_data that have unprocessed children.
> > + * threaded_second_pass() uses this as a source of work (the other being the
> > + * objects array).
> > + */
> > +LIST_HEAD(work_head);
> > +
> > +/*
> > + * Stack of struct base_data that have children, all of whom have been
> > + * processed or are being processed, and at least one child is being processed.
> > + * These struct base_data must be kept around until the last child is
> > + * processed.
> > + */
> > +LIST_HEAD(done_head);
> > +
> > +/*
> > + * All threads share one delta base cache.
> > + */
> > +size_t base_cache_used;
> > +size_t base_cache_limit;
> > +
> >  struct thread_local {
> >  	pthread_t thread;
> > -	size_t base_cache_used;
> >  	int pack_fd;
> >  };
> 
> Seeing several new shared variables made me paranoid about whether or
> not these were thread-safe. There are already five mutexes in this file,
> but there are no clear descriptions (apart from hints in the lock names)
> about which locks protect which variables. It would be nice to make this
> a bit more explicit.

I think that this patch set should confine itself to the work mutex and
what it controls (since that's what this patch set is affecting), but
admittedly, that is already more than a handful.

The work mutex controls work_head and done_head, and all the struct
base_data contained therein, except for data. However, data is
controlled by the semaphore retain_data (and the semaphore is itself
controlled by the work mutex, as described in the previous sentence):
when retain_data is positive, data can be read from but not written to.
The work mutex also controls base_cache_used but not base_cache_limit.
The work mutex does not control any struct base_data outside of
work_head and done_head, so it is possible to generate a struct
base_data outside the mutex, take the mutex, and add it to the list
(reducing time spent in the mutex).

This scheme seems rather complicated to me, but I couldn't make it
simpler - I was hoping for advice on this. If this is the best we can
do, I can try to document it in code comments.

> I wish we had something similar to Abseil's "GUARDED_BY" annotations [1]
> so that we could ensure thread safety with static analysis, but that's
> obviously out of scope for this series.
> 
> [1]: https://abseil.io/docs/cpp/guides/synchronization#thread-annotations

I think what we need is more complicated than what these annotations
provide, but anyway, Abseil is C++-only, I believe.

> > @@ -1065,33 +1011,128 @@ static int compare_ref_delta_entry(const void *a, const void *b)
> [snip]
> >  		work_unlock();
> >  
> > -		resolve_base(&objects[i]);
> > +		if (parent) {
> > +			child = resolve_delta(child_obj, parent);
> > +			if (!child->children_remaining)
> > +				FREE_AND_NULL(child->data);
> > +		} else {
> > +			child = make_base(child_obj, NULL);
> > +			if (child->children_remaining) {
> > +				/*
> > +				 * Since this child has its own delta children,
> > +				 * we will need this data in the future.
> > +				 * Inflate now so that future iterations will
> > +				 * have access to this object's data while
> > +				 * outside the work mutex.
> > +				 */
> > +				child->data = get_data_from_pack(child_obj);
> > +				child->size = child_obj->size;
> > +			}
> > +		}
> > +
> > +		work_lock();
> 
> This part made me uneasy at first, because it looks like we might be
> doing work on shared data outside of the work lock. But just prior to
> unlocking, we parent->retain_data, so we know it won't be freed.

That's correct that it made you uneasy (I think the usual solution is to
make data refcounted, but we don't have a refcounting implementation in
Git), and that's correct that my solution was that parent->retain_data
prevents data from being concurrently written to (in this case, freed).
I didn't know how better to implement this.

> And the
> only part we modify is child, which I don't believe is shared with any
> other threads.

Yes - in the part you quoted, child is a whole new object (created from
resolve_delta() or make_base()). It is only added to the list within the
mutex (the work_lock()).
