Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB64C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 00:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhL2AQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 19:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhL2AQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 19:16:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DDC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:16:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so10907861wmb.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Zvnl8qvV0WRrcFDOTWdJHx3wEXoS6V6Sf90yCo/6pk=;
        b=Vgz3iTMdGiap0sqkbW5zM+xiT0I+V2hQ+A/nS9F5RD9VGpSiLuQNs3ICyPBf92LXwp
         USgcV5J1zltZvF3TxFFsGzUiM+Ly9TUt6vlTqczIUydHkXbkrFnNZGNaqn3TnQ/FdKu2
         2I7L1znUa/DpSoa7LcNB+KXy9JX0bbXpxXJEgBRIYXzze3XUeqgTJABC0oppPrgXPIXX
         D2Jxga1fAbig7USb9DivYTJRZ956DVA7WOZ5H+UJOkduqTzTklOe9HrIOaU5O5xpcSet
         LbHbvrXFkVcuagsHAbw/bMOr4koCWEvIOOfVyPhTIPXjVTFzD6g23ox11XSKlgSzyyzU
         DYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Zvnl8qvV0WRrcFDOTWdJHx3wEXoS6V6Sf90yCo/6pk=;
        b=RmtGC5uSW6HoQWHk3DyGAfClqio5wiFkjrM9Zu1JYY58ApYc9HAcQ+w5zFYlRTsZqB
         /Re35yh1pKLrN6CgGWVHAR/Jlb3NZE7XTSimnwF/cm1qnGiuAnfNqJiUPwjKcgOiwttq
         F8sU55htwlTK5GBG1fRq0bMvIt7KKrmUBI56LY42ggol/1pXTNciWSP95zE54t/5ujbB
         fjW3AP/R3UVE4vikxXa75fPyL/fYmmfOHfj/RsX8ea8x9RbT+IILVEzVEavGJCi0MX9a
         IYMi/292Vy6sDG7u8scHhpQUt92Lq8rABJKpv9jJ4Uozx6pOfN+Y1CUKRtCH4s9uazR3
         iTzA==
X-Gm-Message-State: AOAM532MFkyVpE0bED6hoNRuyxHBO5QyjcxTyM5cVPrQ1vcVj5qVajH1
        /RGPNw6H1yUMzTOfH7cU3Cw=
X-Google-Smtp-Source: ABdhPJzRGA8OVtE05Gn2/mNifu4uO+vONuHp1SObZvtkRV5ag38PKnlmyFMiVcelkPAb9MqAo5UfYA==
X-Received: by 2002:a1c:4644:: with SMTP id t65mr19364989wma.116.1640737009751;
        Tue, 28 Dec 2021 16:16:49 -0800 (PST)
Received: from gmail.com (62-47-8-46.adsl.highway.telekom.at. [62.47.8.46])
        by smtp.gmail.com with ESMTPSA id j26sm22325070wms.46.2021.12.28.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 16:16:49 -0800 (PST)
Date:   Wed, 29 Dec 2021 01:16:47 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 7/8] diff: add ability to insert additional headers
 for paths
Message-ID: <20211229001647.6pv5damtyt3dsiyr@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <e94706513038adc85e818e8736ad713b2e6b6be4.1640419160.git.gitgitgadget@gmail.com>
 <20211228105733.lomkg23htd2kjtii@gmail.com>
 <CABPp-BH5XUsmTo=BD7osUgi4o=eFWgaQkN1qYDky6uqb9SykHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BH5XUsmTo=BD7osUgi4o=eFWgaQkN1qYDky6uqb9SykHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 01:09:57PM -0800, Elijah Newren wrote:
> On Tue, Dec 28, 2021 at 2:57 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
> >
> > On Sat, Dec 25, 2021 at 07:59:18AM +0000, Elijah Newren via GitGitGadget wrote:
> > > +     for (i = 0; i < q->nr; i++) {
> > > +             struct diff_filepair *p = q->queue[i];
> > > +             char *path = p->one->path ? p->one->path : p->two->path;
> > > +
> > > +             if (strmap_contains(o->additional_path_headers, path))
> > > +                     strset_add(&present, path);
> > > +     }
> > > +
> > > +     /*
> > > +      * Loop over paths in additional_path_headers; for each NOT already
> > > +      * in diff_queued_diff, create a synthetic filepair and insert that
> > > +      * into diff_queued_diff.
> > > +      */
> > > +     strmap_for_each_entry(o->additional_path_headers, &iter, e) {
> > > +             if (!strset_contains(&present, e->key)) {
> > > +                     struct diff_filespec *one, *two;
> > > +                     struct diff_filepair *p;
> > > +
> > > +                     one = alloc_filespec(e->key);
> > > +                     two = alloc_filespec(e->key);
> > > +                     fill_filespec(one, null_oid(), 0, 0);
> > > +                     fill_filespec(two, null_oid(), 0, 0);
> > > +                     p = diff_queue(q, one, two);
> > > +                     p->status = DIFF_STATUS_MODIFIED;
> > > +             }
> > > +     }
> >
> > All these string hash-maps are not really typical for a C program. I'm sure
> > they are the best choice for an advanced merge algorithm
> 
> Agreed up to here.
> 
> > but they are not
> > really necessary for computing/printing a diff.
> 
> Technically agree that it _could_ be solved a different way, but the
> strmaps are a much more natural solution to this problem in this
> particular case; more on this below.

Oh yeah, I agree that strmaps are the more intuitive solution.

> 
> > It feels like this is an
> > implementation detail from merge-ort that's leaking into other components.
> 
> And I disagree here, on _both_ the explicit point and the underlying
> suggestion that you seem to be making that strmap should be avoided
> outside of merging.  The strmap.[ch] type was originally a suggestion
> from Peff for areas of git completely unrelated to merging (see the
> beginning of https://lore.kernel.org/git/20200821194857.GD1165@coredump.intra.peff.net/,
> and the first link in that email).  It's a new datatype for git, much
> like strbuf or string_list or whatever before it, that is there to be
> used when it's a natural fit for the problem at hand.  The lack of
> strmap previously led folks to abuse other existing data structures
> (and in a way that often led to poor performance to boot).

Right, all those rename-detection performance fixes were pretty dazzling

> 
> > What we want to do is
> >
> >         for file_pair in additional_headers:
> >                 if not already_queued(file_pair):
> >                         queue(file_pair)
> 
> Yes, precisely.
> 
> > to do that, you use a temporary has-set ("present") that records everything
> > that's already queued (already_queued() is a lookup in that set).
> >
> > Let's assume both the queue and additional_headers are sorted arrays.
> 
> That's a bad assumption; we can't rely on *either* being sorted.  I

OK, I hadn't checked if the queue is sorted

> actually started my implementation by trying exactly what you mention
> first; I too thought it'd be more natural and clearer to do this.  Of
> course, before implementing it, I had to verify whether
> diff_queued_diff was sorted.  So, I added some code that would check
> the order and fail if the queue wasn't sorted.  7 of the test files in
> the regression testsuite had one or more failing tests.
> 
> I think the queue was intended to be sorted (see
> diffcore_fix_diff_index()), but in practice it's not.  And I'm worried
> that if I find the current cases where it fails to be sorted and "fix"
> them (though I don't actually know if this was intentional or not so I
> don't know if that's really a fix or a break), that I'd end up with
> additional cases in the future where they fail to be sorted anyway.
> So, no matter what, relying on diff_queued_diff being sorted seems
> ill-advised.
> 
> Also...
> 
> > Then we could efficiently merge them (like a merge-sort algorithm)
> > without ever allocating a temporary hash map.
> >
> > I haven't checked if this is practical (better wait for feedback).
> > We'd probably need to convert the strmap additional_path_headers into an
> > array and sort it (I guess our hash map does not guarantee any ordering?)
> 
> Right, strmap has no ordering either.  I was willing to stick those
> into a string_list and sort them, but making temporary copies of both
> the strmap and the diff_queued_diff just to sort them so that I can

But you already sort diff_queued_diff at the end of
create_filepairs_for_header_only_notifications(), so sorting a bit earlier
in that function, before enqueueing the new entries won't change the final
result, and allows us to work with a sorted queue; no need for a temporary
copy (we'd only need to copy the strmap).

> reasonably cheaply ask "are items from this thing present in this
> other thing?" seems to be stretching things a bit too far.
> maps/hashes provide a very nice "is this item present" lookup and are
> a natural way to ask that.  Since that is exactly the question I am
> asking, I think they are the better data structure here.

Yeah that makes sense. In theory if we ask
"What is the union of the queued pairs and the extra pairs induced by
conflict messages?"  we could abstract away the "is this item present"
lookup but in practice that's hard.

> So, this was not at all a leak of merge-ort datastructures, but rather a
> picking of the appropriate data structures for the problem at hand.

I think we have two viable solutions to this problem
1. use a temporary strset to figure out which pairs to add
2. use a temporary array, sort it, and "merge" the two arrays

I agree that 1 is more intuitive and natural for humans, and it's probably the
way to go. But it is a bit less elegant because it adds a strmap entry for
each pair in the queue, whereas 2 only needs to add an array element for
each pair with non-content conflicts, which are much fewer. (Okay that's a
minor detail.)  With the right abstractions 2 is pretty simple as well:

	j = 0
	extra_headers = sorted((key, val) for key, val in additional_headers)
	for i in 0..len(queue):
		while j < len(extra_headers) && compare(extra_headers[j].key, queue[i]) <= 0:
			if compare(extra_headers[j].key, queue[i]) < 0:
				enqueue(file_pair_for(extra_headers[j]))
			j++

where

	def compare(key: str, pair: diff_filepair) -> int:
		other = pair.one ? pair.one.path : pair.two.path # Mimic diffnamecmp
		return strcmp(key, other)
