Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56AC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07866117A
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhKJTS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhKJTS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:18:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406EC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 11:15:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u17so3810247plg.9
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZUuWAQB1bZMnx1+QYf51unusejOHaYswxW+nvhgvAjs=;
        b=TkVqyGTJG/JFyOeK2AA25NmBe/5TOWICHorKWur+KrdbBZJA9GZiJIEM+rvFpBYPXy
         DzWSPh0sIbzMhmTnyBdrQE10jd3CR3NNfZHfnI36b9Iw6vg9kqo2OtH0UhId4ImYuUj/
         oHW4FJ8xfKNtCBKlc3eK/X5JaWnJ0xhRzVC49GWktKrlQjYosmAkpHAPHYi4KZWdLOd8
         r3czBjGfzgsCfZehQE5IG/avHQVTKvFxX8E9CdqQSWW4URbW+EhNLuihTTeOyOl49enD
         Vw7QDsKkfqx7NSzZsplWlIpNpnoi80im8mqU9fE7IImwHhtdoz4ICN8+S2LXJRZMjNqO
         RzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZUuWAQB1bZMnx1+QYf51unusejOHaYswxW+nvhgvAjs=;
        b=i5Bif73AqIg7PsT7J2pJ1qSJ/KZ4rOkASaqRyaz7xm3h9QqEX3K8/45K1FSWUOSaMp
         afaOqgeqsco0Jj2efRIuARMzPd6D64Uoim0YUMMJE6nJMTaUATxKZsFrcab/zdxeDvV0
         IYk1nvBGx0JLpg+gnKXtzyPRzhe+K++V7mws9nnZWIkUZgoyTlOjZfmPYh0e+ma33khX
         RpLrGH655kjKUBS0RE6uq1mXilRsNQc+PmHIWM7H91KRH9SVyyOXZjTrR7VKfGjOJBol
         ZiKoLQIRyZOwAr6p6U6WmwJLVjNrX0ti5AU8baGv5eQY+F5I9S5e7H1ixLhmQ2zB95Ba
         gfZQ==
X-Gm-Message-State: AOAM530xzcga721Fb5izq6sBgSw9jFJ9seDYQgBVpg7eqDy8BxUycpXg
        z+VLLyGlyRzXrp5MNvkpuXQ=
X-Google-Smtp-Source: ABdhPJzHLE08tj3jPzEJg1VcOFPcrcI2cN9IJBFV9XQpMBALj9y+XqXUQXXu3KNOtAbH7boeuot6jw==
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr1515497pjb.114.1636571738753;
        Wed, 10 Nov 2021 11:15:38 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id d9sm290771pgd.40.2021.11.10.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:15:38 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:15:33 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Message-ID: <20211110191533.GA484@neerajsi-x1.localdomain>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
 <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 03:49:02PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Nov 10 2021, Patrick Steinhardt wrote:
> 
> > +	shutdown. This setting currently only controls loose refs in the object
> > +	store, so updates to packed refs may not be equally durable. Takes the
> > +	same parameters as `core.fsyncObjectFiles`.
> > +
> 
> ...my understanding of it is basically a way of going back to what Linus
> pointed out way back in aafe9fbaf4f (Add config option to enable
> 'fsync()' of object files, 2008-06-18).
> 
> I.e. we've got files x and y. POSIX sayeth we'd need to fsync them all
> and the directory entry, but on some FS's it would be sufficient to
> fsync() just y if they're created in that order. It'll imply an fsync of
> both x and y, is that accurate?
> 
> If not you can probably discard the rest, but forging on:
> 
> Why do we then need to fsync() a "z" file in get_object_directory()
> (i.e. .git/objects) then? That's a new "z", wasn't flushing "y" enough?
> 
> Or if you've written .git/objects/x and .git/refs/y I can imagine
> wanting to create and sync a .git/z if the FS's semantics are to then
> flush all remaining updates from that tree up, but here it's
> .git/objects, not .git. That also seems to contract this above:

We're breaking through the abstraction provided by POSIX in 'batch' mode,
since the POSIX abstraction does not give us any option to be both safe
and reasonably fast on hardware that does something expensive upon fsync().

We need to ensure that 'x' and 'y' are handed off to the storage device via
a non-flushing pagecache cleaning call (e.g. sync_file_ranges or macOS fsync).
Then creating and flushing 'z' ensures that 'x' and 'y' will be visible after
successful completion. On FSes with a single journal that is flushed on fsync,
this should also ensure that any other files that have been cleaned out of the
pagecache and any other metadata updates are also persisted. The fsync provides
a barrier in addition to the durability.


> >       ensure its data is persisted. After all refs have been written,
> >       the directories which host refs are flushed.
> 
> I.e. that would be .git/refs (let's ignore .git/HEAD and the like for
> now), not .git/objects or .git?
> 
> And again, forging on but more generally [continued below]...
> 
> > +	if (!strcmp(var, "core.fsyncreffiles")) {
> 
> UX side: now we've got a core.fsyncRefFiles and
> core.fsyncWhateverItWasCalled in Neeraj series. Let's make sure those
> work together like say "fsck.*" and "fetch.fsck.*" do, i.e. you'd be
> able to configure this once for objects and refs, or in two variables,
> one for objects, one for refs...
> 

I agree with this feedback. We should have a core.fsync flag to control everything
that might be synced in the repo.  However, we'd have to decide what we want
to do with packfiles and the index which are currently always fsynced.

> ...[continued from above]: Again, per my potentially wrong understanding
> of syncing a "x" and "y" via an fsync of a subsequent "z" that's
> adjacent on the FS to those two.

I suspect Patrick is concerned about the case where the worktree is on
a separate filesystem from the main repo, so there might be a motivation
to sync the worktree refs separately. Is that right, Patrick?

> 
> Isn't this setting us up for a really bad interaction between this
> series and Neeraj's work? Well "bad" as in "bad for performance".
> 
> I.e. you'll turn on "use the batch thing for objects and refs" and we'll
> do two fsyncs, one for the object update, and one for refs. The common
> case is that we'll have both in play.
> 
> So shouldn't this go to a higher level for both so we only create a "z"
> .git/sync-it-now-please.txt or whatever once we do all pending updates
> on the .git/ directory?
> 
> I can also imagine that we'd want that at an even higher level, e.g. for
> "git pull" surely we'd want it not for refs or objects, but in
> builtin/pull.c somewhere because we'll be updating the .git/index after
> we do both refs and objects, and you'd want to fsync at the very end,
> no?
> 
> None of the above should mean we can't pursue a more narrow approach for
> now. I'm just:
> 
>  1) Seeing if I understand what we're trying to do here, maybe not.
> 
>  2) Encouraging you two to think about a holistic way to configure some
>     logical conclusion to this topic at large, so we won't end up with
>     core.fsyncConfigFiles, core.fsyncObjectFiles, core.fsyncIndexFile,
>     core.fsyncRefFiles, core.fsyncTheCrapRebaseWritesOutFiles etc. :)
> 
> I'll send another more generic follow-up E-Mail for #2.

In my view there are two separable concerns:

    1) What durability do we want for the user's data when an entire 'git'
       command completes? I.e. if I run 'git add <1000 files>; git commit' and the
       system loses power after both commands return, should I see all of those files
       in the committed state of the repo?

    2) What internal consistency do we want in the git databases (ODB and REFS) if
       we crash midway through a 'git' command? I.e. if 'git add <1000 files>' crashes
       before returning, can there be an invalid object or a torn ref state?

If were only concerned with (1), then doing a single fsync at the end of the high-level
git command would be sufficient. However, (2) requires more fsyncs to provide barriers
between different phases internal to the git commands. For instance, we need a barrier
between creating the ODB state for a commit (blobs, trees, commit obj) and the refs
pointing to it.

I am not concerned with a few additional fsyncs for (2). On recent mainstream filesystems/ssds
each fsync may cost tens of milliseconds, so the difference between 1 to 3 fsyncs would not
be user perceptible. However, going from a couple fsyncs to 1000 fsyncs (one per blob added)
would become apparent to the user.

The more optimal way to handle consistency and durability is Write-ahead-logging with log
replay on crash recovery. That approach can reduce the number of fsyncs in the active workload
to at most two (one to sync the log with a commit record and then one before truncating the
log after updating the main database). At that point, however, I think it would be best to
use an existing database engine with some modifications to create a good data layout for git.

Thanks,
Neeraj
