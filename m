Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D3C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AB61268
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJACZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJACZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 22:25:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3ABC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:23:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r18so29063997edv.12
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql2qa8XyYzaHl1hYNqHvcsiR/RVJbCHx4Hb6/dWvRSA=;
        b=Pdy0e+j6zYOjeEPsiirv3x2S4bHQh+R/JHG1ooZ7QhRmQBKtR1ostORxNjahBzj757
         nYip/ZEUs2g8t3cyBDPTDtoFYn9haoO4xThql72jB4sEGrpEanUoFlA5wThGS7sdW5HE
         fRmH14Nd+bhf1UzrRrygbL2B8m3JY6Dm1GYZV8fp/uPzJ52sfOI5MbC55dX3KY0XVR8v
         MjIwQv7Aulii7IA1c2ZJur3UzR09SKCLpVNNg8twMR/ogBYi0hELW8/0rqdX20zRIzJn
         CyyCeWv0DLa1BPlZKKmeCwm2GOqP5vAKvcEbv2V5N6HoZtoxsUwlA6CDwBHQ/fvK9JaL
         MVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql2qa8XyYzaHl1hYNqHvcsiR/RVJbCHx4Hb6/dWvRSA=;
        b=aYL/UJid+HD2fdDetRargAz9wdSFx0Xyx0uyWG9Wt30zAwChStjpdtemO1Ii41CHgZ
         qzt0a6XXHmTpKlsFu9zDWzmIFxRIZ4r/7uALMI7PGnWybVNl6R4a1DQg9ezJN8yq/w7w
         XjpLbhDadwv8fs+d6O+YjGms3PAWfytCC7LZ6T59bAy3j1KHyX6kf260nT3ZRvq2C2nA
         2FFO+izPJbFnbtZGNXdZnCiKpwgXxBEeKeYhHIU5CWui4/f350W5ukEYYhNimV0V3yCl
         HORdRjQb062XFQ/tcgFsdkhUwRvb4iceMYafe1JaUDyjQPCaMHoNtwcGD00TEIiFAhuP
         oeig==
X-Gm-Message-State: AOAM531aqn1FpEd1b9DB4yLYtjfmd44/s+lkpKbQr3Ls7iZBpMR8DPPO
        KXHD68HtVibA5rnQm2HOMp4NveVnfQ/SGMI6cY8=
X-Google-Smtp-Source: ABdhPJxnOrI/ffs1wYwz/4EF0g4cPGiKClJ0YbYxUYpVTVuJDviFFtZ9yc6mJZRaI7xRo++3ThLQw6d1XVqySchEQ4U=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr3142375eje.341.1633055006938;
 Thu, 30 Sep 2021 19:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
 <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
In-Reply-To: <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 19:23:14 -0700
Message-ID: <CABPp-BGqxEoMRB4RDty+QzdwXK=1eKdEbQ7UoMPAmwqVsXCz8Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 12:26 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 28, 2021 at 10:05:31PM -0700, Elijah Newren wrote:
>
> > So there are other parts of running `git log` that are not read-only,
> > besides what I'm doing.  That's unfortunate.  Can we just disable
> > those things in this section of the code?
>
> It might be possible for the cache (we'd still generate entries, but
> just not write them). It's "just" an optimization, though it's possible
> there are cases where it's really annoying to do so. I'd imagine those
> are a stretch. I do use textconv to decrypt gpg blobs with a key on a
> hardware token, for example. I don't require a touch for each one,
> though, nor would I use textconv caching anyway (since the point is not
> to store the unencrypted contents).
>
> It wouldn't necessarily be OK to disable object writes in general.
> Though I'd think since a diff is _conceptually_ a read-only operation
> that any writes it wants to do would be in the same caching /
> optimization boat.  I'd also worry about the maintenance cost of having
> to annotate any such case.
>
> > Also, I think it makes sense that textconv caching causes a problem
> > via writing new blobs and trees *and* refs that reference these blobs
> > and trees.  However, I'm not sure I'm really grasping it, because I
> > don't see how your solutions are safe either.  I'll mention more after
> > each one.
>
> Heh. So I originally wrote more on this in my earlier email, but worried
> I was getting too into the weeds and would confuse you, so I pared it
> down. But I managed to be confusing anyway. :)
>
> Here's one mental model. If you have a temporary object store, then
> these are the bad things that can happen:
>
>   1. Some code may write an object to it, thinking the data is saved,
>      but we later throw it away.
>
>   2. Some code may _skip_ writing an object, thinking that we already
>      have that object available (when in fact we'll later throw it
>      away).
>
>   3. Some code may record the fact that we have an object in memory, and
>      then later (after the temporary object store is not in use), may
>      point to it when writing an object or reference.
>
> Pointing the primary object-dir at a temporary directory (like your
> patch does) means we're subject to all three.
>
> Problem (1) happens because unrelated code may not realize we've swapped
> out the primary object writing code for this throw-away directory. But
> we could require writers to explicitly indicate that they want to write
> to the temporary area, while allowing other writes to go to the regular
> object store. This could be done with a flag or variant of
> write_object_file(). Or if the temporary area isn't a regular object
> directory at all (like the whole tempfile / pretend thing), then this
> happens automatically, because the regular object-write paths don't even
> know about our temporary area.
>
> Problem (2) is mostly handled inside write_object_file(). It will
> optimize out writes of objects we already have. So it needs to know when
> we have an object "for real", and when we just have it in our temporary
> store. If we make the tmp_objdir the primary, then it doesn't know this
> (though we could teach it to check. In the pretend_object_file() system,
> it already knows this (it uses the "freshen" code paths which actually
> want to find the entry in the filesystem).
>
> Problem (3) is the hardest one, because we don't really distinguish
> between readers and writers. So if I call has_object_file(), is it
> because I want to access the object? Or is it because I want to generate
> a new reference to it, which must ensure that it exists? One of those is
> OK to look at the tmp_objdir (and indeed, is the whole point of making
> it in the first place), and the other is the first step to corrupting
> the repository. ;)
>
> With the environment variables we set up for running external commands
> (like hooks) in the receive-pack quarantine, one bit of safety we have
> is to prevent ref writes entirely in those commands. That works
> reasonably well. Even if they may write new objects that might get
> thrown away (if the push is rejected), they'd ultimately need to point
> to those objects with a ref.  And because those hooks spend their
> _entire_ run-time in the quarantine state, they can't ever write a ref.
>
> Whereas doing it in-process is a little dicier. Right now the textconv
> cache writes out a new tree for every entry we add, so it happens to do
> the ref write while the tmp-objdir is still in place. But as this
> comment notes:
>
>   $ git grep -B6 notes_cache_write diff.c
>   diff.c-         /*
>   diff.c-          * we could save up changes and flush them all at the end,
>   diff.c-          * but we would need an extra call after all diffing is done.
>   diff.c-          * Since generating a cache entry is the slow path anyway,
>   diff.c-          * this extra overhead probably isn't a big deal.
>   diff.c-          */
>   diff.c:         notes_cache_write(textconv->cache);
>
> this is slow, and it would be perfectly reasonable to flush the cache at
> the end of the process (e.g., using an atexit() handler). In which case
> we'd hit this problem (3) exactly: we'd generate and remember objects
> during the tmp-objdir period, but only later actually reference them.
> This is more likely than the receive-pack hook case, because we're doing
> it all in process.
>
> > > If you remove the tmp_objdir as the primary as soon as you're done with
> > > the merge, but before you run the diff, you might be OK, though.
> >
> > It has to be after I run the diff, because the diff needs access to
> > the temporary files to diff against them.
>
> Right, of course. I was too fixated on the object-write part, forgetting
> that the whole point of the exercise is to later read them back. :)
>
> > > If not, then I think the solution is probably not to install this as the
> > > "primary", but rather:
> > >
> > >   - do the specific remerge-diff writes we want using a special "write
> > >     to this object dir" variant of write_object_file()
> > >
> > >   - install the tmp_objdir as an alternate, so the reading side (which
> > >     is diff code that doesn't otherwise know about our remerge-diff
> > >     trickery) can find them
> > >
> > > And that lets other writers avoid writing into the temporary area
> > > accidentally.
> >
> > Doesn't this have the same problem?  If something similar to textconv
> > caching were to create new trees that referenced the existing blobs
> > and then added a ref that referred to that tree, then you have the
> > exact same problem, right?  The new tree and the new ref would be
> > corrupt as soon as the tmp-objdir went away.  Whether or not other
> > callers write to the temporary area isn't the issue, it's whether they
> > write refs that can refer to anything from the temporary area.  Or am
> > I missing something?
>
> The key thing here is in the first step, where remerge-diff is
> explicitly saying "I want to write to this temporary object-dir". But
> the textconv-cache code does not; it gets to write to the normal spot.
> So it avoids problem (1).
>
> You're right that it does not avoid problem (3) exactly. But triggering
> that would require some code not just writing other objects or
> references while the tmp-objdir is in place, but specifically
> referencing the objects that remerge-diff did put into the tmp-objdir.
> That seems a lot less likely to me (because the thing we're most worried
> about is unrelated code that just happens to write while the tmp-objdir
> is in place).
>
> > > In that sense this is kind of like the pretend_object_file() interface,
> > > except that it's storing the objects on disk instead of in memory. Of
> > > course another way of doing that would be to stuff the object data into
> > > tempfiles and just put pointers into the in-memory cached_objects array.
> > >
> > > It's also not entirely foolproof (nor is the existing
> > > pretend_object_file()). Any operation which is fooled into thinking we
> > > have object X because it's in the fake-object list or the tmp_objdir may
> > > reference that object erroneously, creating a corruption. But it's still
> > > safer than allowing arbitrary writes into the tmp_objdir.
> >
> > Why is the pretend_object_file() interface safer?  Does it disable the
> > textconv caching somehow?  I don't see why it helps avoid this
> > problem.
>
> So hopefully it's clearer now from what I wrote above, but just
> connecting the dots:
>
>   1. Unrelated code calling write_object_file() would still write real,
>      durable objects, as usual.
>
>   2. The write_object_file() "skip this write" optimization already
>      ignores the pretend_object_file() objects while checking "do we
>      have this object".
>
> > Interesting.  I'm not familiar with the pretend_object_file() code,
> > but I think I catch what you're saying.  I don't see anything in
> > object-file.c that allows removing items from the cache, as I would
> > want to do, but I'm sure I could add something.
>
> Right, it's pretty limited now, and there's only one caller. And in fact
> I've wanted to get rid of it, exactly because it can create the danger
> we're discussing here. But I still think it's _less_ dangerous than
> fully replacing the object directory.
>
> > (I'm still not sure how this avoids the problem of things like
> > textconv caching trying to write an object that references one of
> > these, though.  Should we just manually disable textconv caching
> > during a remerge-diff?)
>
> It can't avoid it completely, but in general, the textconv cache should
> be writing and referencing its own objects. Even if they happen to be
> the same as something remerge-diff generated, it won't know that until
> it has tried to write it (and so that's why having write_object_file()
> continue to really write the object is important).
>
>
> Hopefully that clears up my line of thinking. I do think a lot of this
> is kind of theoretical, in the sense that:
>
>   - textconv caching is an obscure feature that we _could_ just disable
>     during remerge-diffs
>
>   - there's a reasonable chance that there isn't any other code that
>     wants to write during a diff
>
> But this is all scary and error-prone enough that I'd prefer an approach
> that has the "least surprise". So any solution where random code calling
> write_object_file() _can't_ accidentally write to a throw-away directory
> seems like a safer less surprising thing.

Yes, thanks for taking the time to go into this detail.

> It does mean that the remerge-diff code needs to be explicit in its
> object writes to say "this needs to go to the temporary area" (whether
> it's a flag, or calling into a totally different function or subsystem).
> I'm hoping that's not hard to do (because its writes are done explicitly
> by the remerge-diff code), but I worry that it may be (because you are
> relying on more generic tree code to the write under the hood).

All blob and tree objects written during merge-ort are done by
explicit write_object_file() calls that exist within merge-ort.c.  So
this approach should be doable, it just needs the external caller to
set some flag saying to write these objects elsewhere.
