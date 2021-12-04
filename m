Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC38C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 22:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhLDWYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLDWYC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 17:24:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F318C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 14:20:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x6so26568178edr.5
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1Mtke6k+G+isoKrJZigmBY1a4lBoLk9FAEpjpxs2V0=;
        b=fwAMGuOUStMzuw86PBwdyJQH8TYRVa9YYxxaFkxLiI7SckVrbJOw2EMWCxT0MG5iPU
         AZhlXPC7BNnpD0hQkkrZ5n3XDYsOtIM7FaG6MKCZhi2BuKwM4RGf2fkXd0HGeEoHWJIh
         KxS2+LbM/oDf+iCOT6fsydtdaqzXxw7JA5SC3NbGAetDZkCS6r2YIAimlCxbwFUHbNEl
         13pn2+MLS3X5xA5I8cLRXl8yogBdLpmFjp1nY+hk+k8Pysrjvi2FmWcGoqE4UzAKky4m
         oj+E+dlQAilFudze+I5m+IlZy27lfEkP9QhDS6qvq/foWGo2E63aW/a6c2UMd2bpXD/1
         190Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1Mtke6k+G+isoKrJZigmBY1a4lBoLk9FAEpjpxs2V0=;
        b=rgPmuPhVzibHUJfVjUH0H/kRvZKueOvjSE19GjTNcPQTBaxyBtAwbYcEUWXM9M0ngn
         VttYUU2T35o3qvvcnNOC9/Bm8IH9a6OnWahDXbol2924WwTeVwfh9zRMdD4QYrjDnQqM
         pCHDaUYpqULrZZuqJTBs7yf4rOuINx3YpxlpG2w6AMx9bDmgrb8lI9UQFRay9wa1zrv6
         7G4izXrF3hGzQVAL3bT+OYEB1kZ5QEsHIi/kzlUVxxS/tIQ/LnjGEb9XCSQzABoxdoq7
         DkdEKVx/IOi/0CXy3WGhN87oRLiEbD1w/VnKQ3xLiTfv1mkqM7moCTbMKgsxStDwPitg
         YXWA==
X-Gm-Message-State: AOAM530Qdk3kWqwkryj3+aOEfiTsa93UMTD+QbFywxhluSkn8BBnil0n
        vqraMUC96Ko/o9u2gGwUs9AEYKIVDjJgOmaGAhTa5uQy
X-Google-Smtp-Source: ABdhPJxqP0EGKg/AXZFoPnh9k0EfaQ39qFQhy45wfrc7N2XQZ+TL6JlEZFY02Iezkpvi1uSue3/uuq+U3VPUy8U8010=
X-Received: by 2002:a17:906:3a4a:: with SMTP id a10mr33670846ejf.253.1638656434537;
 Sat, 04 Dec 2021 14:20:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638224692.git.me@ttaylorr.com> <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
In-Reply-To: <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Dec 2021 14:20:23 -0800
Message-ID: <CABPp-BGW3t1LnUGNSLSzYtQfAJuAQKxpHJMJOdh5T2pUyaDWAw@mail.gmail.com>
Subject: Re: [PATCH 01/17] Documentation/technical: add cruft-packs.txt
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 7:29 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Create a technical document to explain cruft packs. It contains a brief
> overview of the problem, some background, details on the implementation,
> and a couple of alternative approaches not considered here.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/Makefile                  |  1 +
>  Documentation/technical/cruft-packs.txt | 95 +++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/technical/cruft-packs.txt
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index ed656db2ae..0b01c9408e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -91,6 +91,7 @@ TECH_DOCS += MyFirstContribution
>  TECH_DOCS += MyFirstObjectWalk
>  TECH_DOCS += SubmittingPatches
>  TECH_DOCS += technical/bundle-format
> +TECH_DOCS += technical/cruft-packs
>  TECH_DOCS += technical/hash-function-transition
>  TECH_DOCS += technical/http-protocol
>  TECH_DOCS += technical/index-format
> diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/technical/cruft-packs.txt
> new file mode 100644
> index 0000000000..bb54cce1b1
> --- /dev/null
> +++ b/Documentation/technical/cruft-packs.txt
> @@ -0,0 +1,95 @@
> += Cruft packs
> +
> +Cruft packs offer an alternative to Git's traditional mechanism of removing
> +unreachable objects. This document provides an overview of Git's pruning
> +mechanism, and how cruft packs can be used instead to accomplish the same.
> +
> +== Background
> +
> +To remove unreachable objects from your repository, Git offers `git repack -Ad`
> +(see linkgit:git-repack[1]). Quoting from the documentation:
> +
> +[quote]
> +[...] unreachable objects in a previous pack become loose, unpacked objects,
> +instead of being left in the old pack. [...] loose unreachable objects will be
> +pruned according to normal expiry rules with the next 'git gc' invocation.
> +
> +Unreachable objects aren't removed immediately, since doing so could race with
> +an incoming push which may reference an object which is about to be deleted.
> +Instead, those unreachable objects are stored as loose object and stay that way
> +until they are older than the expiration window, at which point they are removed
> +by linkgit:git-prune[1].
> +
> +Git must store these unreachable objects loose in order to keep track of their
> +per-object mtimes. If these unreachable objects were written into one big pack,
> +then either freshening that pack (because an object contained within it was
> +re-written) or creating a new pack of unreachable objects would cause the pack's
> +mtime to get updated, and the objects within it would never leave the expiration
> +window. Instead, objects are stored loose in order to keep track of the
> +individual object mtimes and avoid a situation where all cruft objects are
> +freshened at once.
> +
> +This can lead to undesirable situations when a repository contains many
> +unreachable objects which have not yet left the grace period. Having large
> +directories in the shards of `.git/objects` can lead to decreased performance in
> +the repository. But given enough unreachable objects, this can lead to inode
> +starvation and degrade the performance of the whole system. Since we
> +can never pack those objects, these repositories often take up a large amount of
> +disk space, since we can only zlib compress them, but not store them in delta
> +chains.
> +
> +== Cruft packs
> +
> +Cruft packs are designed to eliminate the need for storing unreachable objects
> +in a loose state by including the per-object mtimes in a separate file alongside
> +a single pack containing all loose objects.

I had the same question as Stolee here: why not use the cruft-pack's
mtime for all the objects in it?  Much later below, you make it clear
that a repository will generally only have one cruft pack which kind
of answers the question, but the repeated mention of "cruft packs"
throughout the document subtly made me make the opposite assumption.
It might be nice to address the almost-always-only-one-cruft-pack
earlier on, which may also help answer the question about why you need
to store individual mtimes in an additional file.

> +A cruft pack is written by `git repack --cruft` when generating a new pack.
> +linkgit:git-pack-objects[1]'s `--cruft` option. Note that `git repack --cruft`
> +is a classic all-into-one repack, meaning that everything in the resulting pack is
> +reachable, and everything else is unreachable. Once written, the `--cruft`
> +option instructs `git repack` to generate another pack containing only objects
> +not packed in the previous step (which equates to packing all unreachable
> +objects together). This progresses as follows:
> +
> +  1. Enumerate every object, marking any object which is (a) not contained in a
> +     kept-pack, and (b) whose mtime is within the grace period as a traversal
> +     tip.
> +
> +  2. Perform a reachability traversal based on the tips gathered in the previous
> +     step, adding every object along the way to the pack.
> +
> +  3. Write the pack out, along with a `.mtimes` file that records the per-object
> +     timestamps.
> +
> +This mode is invoked internally by linkgit:git-repack[1] when instructed to
> +write a cruft pack. Crucially, the set of in-core kept packs is exactly the set
> +of packs which will not be deleted by the repack; in other words, they contain
> +all of the repository's reachable objects.
> +
> +When a repository already has a cruft pack, `git repack --cruft` typically only
> +adds objects to it. An exception to this is when `git repack` is given the
> +`--cruft-expiration` option, which allows the generated cruft pack to omit
> +expired objects instead of waiting for linkgit:git-gc[1] to expire those objects
> +later on.
> +
> +It is linkgit:git-gc[1] that is typically responsible for removing expired
> +unreachable objects.
> +
> +== Alternatives
> +
> +Notable alternatives to this design include:
> +
> +  - The location of the per-object mtime data, and
> +  - Whether cruft packs should be incremental or not.
> +
> +On the location of mtime data, a new auxiliary file tied to the pack was chosen
> +to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
> +support for optional chunks of data, it may make sense to consolidate the
> +`.mtimes` format into the `.idx` itself.
> +
> +Incremental cruft packs (i.e., where each time a repository is repacked a new
> +cruft pack is generated containing only the unreachable objects introduced since
> +the last time a cruft pack was written) are significantly more complicated to
> +construct, and so aren't pursued here. The obvious drawback to the current
> +implementation is that the entire cruft pack must be re-written from scratch.
> --
> 2.34.1.25.gb3157a20e6
>
