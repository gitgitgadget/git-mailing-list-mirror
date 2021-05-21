Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A282C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F91613DD
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhEULkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhEULkm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 07:40:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDEBC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:39:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s22so29770950ejv.12
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jyDTtRv5CSKtxEJeQy1y9cr+qBIB6HYkgXupXXfoykU=;
        b=ia3Vi8VUYVhW9TW15XD6Pdt4uUFvXndBwJkYfQ2gPVd8rwrSEogHau2I4fR1FVL7sY
         5xVQctgigeGPq51UOAiw7NU9OzB/rd1NT1cG+t6Umq/HK0vaPh29ro5isE/b0U70PEFd
         kg93pRY9W2qzhGfs59IWiUKNbvlLx/AJTtI2N3prWl0S1/CAcBM+8ef3y9/A8vjOA9vG
         b40NfSAOsDrGQpzRPScLdVcYs0HjNUWJEkY8vahmtTYXVoo0aHo35MjhC/QYs/MhzNP2
         +hui0vZ+WgnxGtC038vO0SvQJjWDkGn65OE19mLiwN65mzKFXrTT6Nc7X2CA1KIUchqo
         S6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jyDTtRv5CSKtxEJeQy1y9cr+qBIB6HYkgXupXXfoykU=;
        b=tYb4T/58YDDZ8ZU44yfdwLq497HOEATKPHzvYIYVB1n1btKME4AgUzcwJLrkINfm6K
         qfxokOPxfDfZBtzI05y6NU+JK+rueZW2p8WQPevITtGUc/vKobMlcM7Dah28MTKkWyM6
         djMTp8ItdG5t1alKvOSfWlrgoxsIpw4Xg0hyw4coljV8Mj0HXwoM7hN3esYLwIbMRGR/
         c7UVnTMEMlwpEuTKJh2dFFBLEO/vBUjkFKmAP1uhpwi/o1xambJYJW4NXZC6PbmYaq4J
         hZJgPlTuyu9mgQSoC2Ej4aB9AGm+sg082jpX3jzvy/gILe39sAcljQqdSQuXUwM8fqJ0
         8hng==
X-Gm-Message-State: AOAM530pgRdFeumwMDUNt61Y9BOv+zOIrieS7PU+7pkSH8bVV9frZtGr
        a1aAp++eu05GG5E6qoACSZwhi0l3je8=
X-Google-Smtp-Source: ABdhPJycshhxELCKhk4eQh/43Wo4QWPTxX5P6SygVHhR/9WJg5b5ezzgdwhfeZIQ/ueGKl2p9WiSMA==
X-Received: by 2002:a17:906:d89:: with SMTP id m9mr10306826eji.191.1621597156439;
        Fri, 21 May 2021 04:39:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g13sm3396109ejz.24.2021.05.21.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:39:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] Speed up connectivity checks via quarantine dir
Date:   Fri, 21 May 2021 13:20:58 +0200
References: <cover.1621451532.git.ps@pks.im>
 <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
Message-ID: <87zgwonwnw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 20 2021, Jeff King wrote:

> On Wed, May 19, 2021 at 09:13:18PM +0200, Patrick Steinhardt wrote:
>
>> One of the issues I've found is the object connectivity check, which may
>> run for a significant amount of time. The root cause here is that we're
>> computing connectivity via `git rev-list --not --all`: if we've got many
>> refs in the repository, computing `--not --all` is hugely expensive.
>> 
>> This commit series thus implements an alternative way of computing
>> reachability, which reuses information from the object quarantine
>> environment. Instead of doing a refwalk, we just look iterate over all
>> packed and loose quarantined objects any for each of them, we determine
>> whether their immediate references are all satisfied.
>
> If I am reading the patches correctly, your definition of "satisfied"
> is: the referenced object exists already on the receiving side.
>
> But that's subtly different from the current rule, which is: the object
> must be reachable from the current ref tips. The invariant that Git has
> traditionally tried to maintain (for a repo not to be corrupt) is only
> that we have the complete graph of objects reachable from the tips.
>
> If we have an unreachable tree in the object database which references
> blobs we don't have, that doesn't make the repository corrupt. And with
> the current code, we would not accept a push that references that tree
> (unless it also pushes the necessary blobs). But after your patch, we
> would, and that would _make_ the repository corrupt.
>
> I will say that:
>
>   1. Modern versions of git-repack and git-prune try to keep even
>      unreachable parts of the graph complete (if we are keeping object X
>      that refers to Y, then we try to keep Y, too). But I don't know how
>      foolproof it is (certainly the traversal we do there is "best
>      effort"; if there's a missing reference that exists, we don't
>      bail).
>
>   2. This is not the only place that just checks object existence in the
>      name of speed. When updating a ref, for example, we only check that
>      the tip object exists.

Hopefull you mean "when we update a ref locally", i.e. update-ref, not
receive-pack.

I think that's fine, and we should consider these corruption detections
to have two different classes, there's the local update-ref, mktag
etc. which typically only do skin-deep checking, and the full check we
want to do in receive-pack and other transport.fsckObjects.

It's fine in practice for the "local" case to be fast and loose, but
when you're accepting foreign objects over the network we should always
be as paranoid as possible, both to prevent accidental corruption and
deliberate attack.

None of that goes against what you're saying, just a bit of an
elaboration.

> [...]
> There's another related change here that is actually a tightening of the
> rules. The current code checks that the ref tips proposed by the sender
> are valid.  If there are objects in the pack not needed for the ref
> update, their connectivity isn't checked (though normal senders would
> obviously avoid sending extra objects for no reason). Your "iterate over
> all quarantined objects" makes that stricter.
>
> I'm of two minds there:
>
>   1. We could easily keep the original rule by just traversing the
>      object graph starting from the ref tips, as we do now, but ending
>      the traversal any time we hit an object that we already have
>      outside the quarantine.
>
>   2. This tightening is actually important if we want to avoid letting
>      people _intentionally_ introduce the unreachable-but-incomplete
>      scenario. Without it, an easy denial-of-service corruption against
>      a repository you can push to is:
>
>        - push an update to change a ref from X to Y. Include all objects
> 	 necessary for X..Y, but _also_ include a tree T which points to
> 	 a missing blob B. This will be accepted by the current rules
> 	 (but not by your patch).
>
>        - push an update to change the ref from Y to C, where C is a
> 	 commit whose root tree is T. Your patch allows this (because we
> 	 already have T in the repository). But the resulting repository
> 	 is corrupt (the ref now points to an incomplete object graph).

We should also consider not closing the door to some future
optimizations and features by being overly strict with #2 here. Maybe
I've misunderstood things, but I think tightening it would prevent
things like:

 A. I'm pushing a ref update for X..Y, the server is at X, but I happen
    to have a pack (e.g. from an earlier pull) that contains objects
    from W..Y. The server doesn't need W..X, but I just sent the whole
    W..Y set over saying "please update to Y".

 B. I got halfway with patches to make clients aid servers with
    server-side corruption of objects (the root cause was some NFS
    shenanigans + our non-fsync()-ing). A server would have an empty
    loose object, to recover I needed to manually scp it from a
    client->server. This happened a few times at odd hours.

    With the not-accepted core.checkCollisions patch I hacked up for
    related reasons[1] I found that we were actually quite close to
    learning a mode on the server-side where we'd just blindly accept
    such objects (the client would also need to learn to do a hail-mary
    push).

    Strictly speaking we could support such a recovery mode while still
    having the #2 under discussion here (only accepting such objects if
    our own repo is corrupt), but I thought it was rather neat that it
    would naturally fall out of the general rule that we didn't care
    about "redundant" objects + my tweaks to make the "there's a
    collision" check less anal (in that case it was a false alarm, our
    local object was corrupt, but not the one the remote end tried to
    send).

1. https://lore.kernel.org/git/20181113201910.11518-1-avarab@gmail.com/
