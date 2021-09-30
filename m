Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BBBC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A4C61A08
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347278AbhI3T1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347267AbhI3T1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 15:27:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B66C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:25:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so7557369pjw.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RWtAkM9iRwj7RKCAzlIZ53g9EtkpcTrAWnk3JihDBiM=;
        b=grrSUjXNW/h9+Nz+YC6947Ny1UjckZAvzZn7o651sCMHZdX1y594ZelVWoUNw2EK28
         EAZE2KklaNOVJIinDlY5h/LzEG5DyG5MJhYa/IhU4yMBJNpviRsVkjn8AGnNUT2Hej/0
         Uikzb6EboSUqF1sZ4a+rzJEedsS3rECvU2xh+2rk/guwnDipDFHuh9B4o1rIU+gEPMA/
         Pa3raF6jje/lEzVx/htEhYVYxXvdCoAS75cY+YEoud9zqhPt6l2pIt1Em0Ogx2d9Uezv
         ygIHhB3fDrbyj6RgWjavAKMTPUtMapo1MXOfd2Sb/Tsof7AHI/osnro0V/bqPMggfDai
         dSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWtAkM9iRwj7RKCAzlIZ53g9EtkpcTrAWnk3JihDBiM=;
        b=bnsVD6KcdjZT7x9ZpR66B1fAaXHMMfPMHXnpXdFdMGArViPr94xM/Q3lDfJWvDztpE
         GuZsc6CPtkPoPU+ewofFHkMPlTd78XerxviJm1bzPIm3lSUNABVgQP4Hx3owboP+yz3p
         3pR9HU1fE4N4ciFRq9ig/e1SAA3R/KCPPbGKv9QKPnKTLeKRf18tuNqjfuVvGz1FVb4o
         RcS15uKI+GvGMERLjvYvqAASldjFl/uSqgXqrwdgpOZ5bJ7vUW7QJemu1KL8bigQhdvS
         6psSjoJlGl7ttDFckce+l8ht5jyGsuujvr3veV22N+aWz7pIJNCbYfhb47yD2D5/nSog
         ZgnQ==
X-Gm-Message-State: AOAM532majByOdWcacXopqPMRH/XocXAUJKrXVhlIgvUm4EZ36ZNhQUt
        /3WEwmSRgWoFcg9aFWat820=
X-Google-Smtp-Source: ABdhPJwbZ34aiIuB2/Yaq8OYsWupebn+RzS4U+57ZQNguHMRspCtr18ZhRKSZTxvnAGjDUXzb2Llog==
X-Received: by 2002:a17:902:ab5a:b0:13e:24:cc61 with SMTP id ij26-20020a170902ab5a00b0013e0024cc61mr5873002plb.80.1633029939927;
        Thu, 30 Sep 2021 12:25:39 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-227-232.customer.broadstripe.net. [24.56.227.232])
        by smtp.gmail.com with ESMTPSA id v4sm3289891pjr.32.2021.09.30.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 12:25:39 -0700 (PDT)
Date:   Thu, 30 Sep 2021 12:25:37 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Message-ID: <20210930192537.GA4151@neerajsi-x1.localdomain>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
 <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
 <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 03:26:42AM -0400, Jeff King wrote:
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

This is a good taxonomy. I think these problems apply to any transactional
system. If you keep state outside of the transaction, then you may wind up
with inconsistency. Problem (3) is the worst and kind of subsumes (2). If
we think an object is durable with a specific oid, we probably are going to
write that oid out somewhere else that is outside of the transaction. If
we write it to the ODB (e.g. in a tree or some blob) without first caching
it in memory, the references in the ODB will be equally durable as the referees.


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

Is there state we care about besides objects and refs? Maybe we need to
introduce a transactional system for the entire repository like we have
for the refs-db.  In-process code that cares about oids that might be
only transactionally present can register a callback for when the transaction
commits or rollsback.  I'm not volunteering to write this, btw :).

Right now, disabling Ref updates is a pretty good compromise, since that's the
one definite piece of durable state outside the ODB that can point in. In memory
state is generally hard to solve and could wind up persisting in either the ODB
or the Refs or both.

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
> 

There is something nice to be said for having the cached state go away
with the ephemeral objects, since that caching refers to objects that
may never be seen again.

Any solution which makes in-flight transactional state visible (either as
the primary writing spot or as a readable alternate) will suffer from state
leakage for non-transactionally-aware readers/writers.

The bulk-fsync code has some advantage in that it is more constrained in what
it's calling while the tmp objdir is active. Also, in typical cases, the
tmp objdir will be committed rather than discarded. But I believe it suffers
from the same essential issue.

Can we press forward, and just try to make sure all the in-process stuff
is aware of temporary object state?  Maybe we can hook up the temp odb stuff
with the refsdb transactions into a single system.

We can make the tmp object directory stuff more prevalent by using it in
git-apply and the merge stategy, and by using bulk-checkin while writing out
the cached tree and commits. This should flush out any issues and keep other
parts of the codebase honest.

> It does mean that the remerge-diff code needs to be explicit in its
> object writes to say "this needs to go to the temporary area" (whether
> it's a flag, or calling into a totally different function or subsystem).
> I'm hoping that's not hard to do (because its writes are done explicitly
> by the remerge-diff code), but I worry that it may be (because you are
> relying on more generic tree code to the write under the hood).
> 

I don't think that really helps the trickiest problems. The textconv cache,
for instance, may now be writing notes that refer to nonexistent objects.
That's fine from a correctness point of view, but now we're polluting the repo
with state that won't be gc'ed and won't ever be accessed.

IMO, it might be better for the textconv cache to have a single notes root
tree (rather than a notes 'branch' with a commit history). We would want to
put a ref to this tree somewhere inside the object directory itself so that
it's transactionally consistent with the rest of the object state. For instance,
we could store the current textconv notes tree root in .git/objects/info/textconv-cache.

Thanks,
Neeraj

