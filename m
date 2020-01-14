Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB1C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9185324656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a238stLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANUkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:40:01 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39901 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANUkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 15:40:01 -0500
Received: by mail-ot1-f45.google.com with SMTP id 77so13987245oty.6
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1BqGxqpsdNUKM5q7N1yhAgHc03VbY3RSLWLez8DPPw=;
        b=a238stLKm/FBi0ZCfZjQ4ApAxvgKHvNmOF2ucqarZdcrtkF+baErsneCGSeELzmmOC
         ZvvgG0w0ta+QJ7cgfhKQbIRvRX8xhsmcRHpFxHZxo5TEolGBMPkJ8trhxy4OHA/j1XUN
         g6oQ2rWe8dhMQv6mLB/WCbTVqxZtwNwo5/92xal+1wTgD8aZB+zq7pQMkAeYfn7FGdWt
         htncNzgvlya7lvFJShP4KFGossllhZzkAALefN6zvlUfOZa2NierxCaPmR/U1mSXd+f9
         8csmIr3jDcHmHPby07eBJbyE3NHG9GVrpLDNN0KY8oj5oXL+y01zYHBMlZ7fGUuUy2ia
         nj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1BqGxqpsdNUKM5q7N1yhAgHc03VbY3RSLWLez8DPPw=;
        b=dqyWAfe72TphaCJqjHW0iaSWLFgCKeCiZOUNx4e2gMFsXqIHCmBbFiyzk4QK38yJyc
         T6TQg8go92MbDXYvdQwXSfWMcn8OcD9/Y8TzZp2P2qC6o9Ye+wdcscOoVZJnUmL7CpME
         +7aQWMeXPi/Gedf9H0NfkO5KsY+jN9dhvR7FpFwNf8Yy0I1gbnILS1MeYdUFr3w9gSCo
         aJUr1pWsXs8kinx/ZCW5+blZh4ls42wh29x9s+rKVEzFn1wrbgkRXztstALynYTCp611
         JVT8YYLre7CHrqVci6nx/9bKM1BEHvRkwMGISVDVE+YT+IudXf3nHVF8/V0EOMDG+qsz
         zN0A==
X-Gm-Message-State: APjAAAXIW6D42HtzPHxgCjB2y4TrFY1aJBfsYzUuOKNSgSM7a3lXRY7t
        nabdiSF5BD2mC6UmPlKlTMHLsUinVG1w/zQZlb8Djg==
X-Google-Smtp-Source: APXvYqyaBRjQOEaqTtT7JzlE34mhNTgHZE+KryL98lfnyrQNPhv/fcJlC61kr66RKGvb8blGUI75iIhsi04TzQqM4c8=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr147855otp.316.1579034400158;
 Tue, 14 Jan 2020 12:40:00 -0800 (PST)
MIME-Version: 1.0
References: <d4361b6d34513a3fdefa564d10269f60d4732208.camel@novalis.org> <20200114190339.120452-1-jonathantanmy@google.com>
In-Reply-To: <20200114190339.120452-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Jan 2020 12:39:49 -0800
Message-ID: <CABPp-BF8OHoHo73doekKzf0CmO09_PyAfe4q__DvoftQ+BeY2w@mail.gmail.com>
Subject: Re: [RFC] Extending git-replace
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     novalis@novalis.org, Kaushik Srenevasan <kaushik@twitter.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 11:05 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > That is, would it be sufficient if every replaced file were replaced
> > with the exact text "me caga en la leche" instead of a custom hand-
> > crafted replacement?  I guess it's a bit complicated because while
> > that's a reasonable blob, it's not a valid commit.  So maybe this
> > mechanism would be limited to blobs.  I thought about whether we could
> > a different flavor of replacement for commits, but those generally have
> > to be custom because they each have different parents.
>
> Since the original email just discussed blobs, I'll confine myself to
> discussing blobs. (Commits are trickier, as you said.)
>
> > And if that would be sufficient, could promisors be used for this?  I
> > don't know how those interact with fsck and the other commands that
> > you're worried about.  Basically, the idea would be to use most of the
> > existing promisor code, and then have a mode where instead of visiting
> > the promisor, we just always return "me caga en la leche" (and this
> > does not have its SHA checked, of course).

Maybe; it doesn't necessarily need to be the same object returned, and
these replacements could be user-specified via replace refs...

> Missing promisor objects do not prevent fsck from passing - this is part
> of the original design (any packfiles we download from the specifically
> designated promisor remote are marked as such, and any objects that the
> objects in the packfile refer to are considered OK to be missing).

Is there ever a risk that objects in the downloaded packfile come
across as deltas against other objects that are missing/excluded, or
does the partial clone machinery ensure that doesn't happen?  (Because
this was certainly the biggest pain-point with my "fake cheap clone"
hacks.)

> Currently, when a missing object is read, it is first fetched (there are
> some more details that I can go over if you have any specific
> questions). What you're suggesting here is to return a fake blob with
> wrong hash - I haven't looked at all the callers of read-object
> functions in detail, but I don't think all of them are ready for such a
> behavioral change.

git-replace already took care of that for you and provides that
guarantee, modulo the --no-replace-objects & fsck & prune & fetch &
whatnot cases that ignore replace objects as Kaushik mentioned.  I
took advantage of this to great effect with my "fake cheap clone"
hacks.  Based in part on your other email where you made a suggestion
about promisors, I'm starting to think a pretty good first cut
solution might look like the following:

  * user manually adds a bunch of replace refs to map the unwanted big
blobs to something else (e.g. a README about how the files were
stripped, or something similar to this)
  * a partial clone specification that says "exclude objects that are
referenced by replace refs"
  * add a fake promisor to the downloaded promisor pack so that if
anyone runs with --no-replace-objects or similar then they get an
error saying the specified objects don't exist and can't be
downloaded.

Anyone see any obvious problems with this?

>  Maybe it would be sufficient to just make this work
> in a more limited scope (e.g. checkout only - and if we need different
> replacement blobs for different object IDs, maybe we could have
> something similar to the clean/smudge filters).

>
> > This could work together with some sort refs/blacklist mechanism to
> > enable the server to choose which objects the client replaces.
>
> In the original email, Kaushik mentioned objects larger than a certain
> size - we already have support for that (--filter=blob:limit=1000000,
> for example). Having said that, Git is already able to tolerate any
> exclusion (of tree or blob) from the server - we already need this in
> order to support changing of filters, for example.
