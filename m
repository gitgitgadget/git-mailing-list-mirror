Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD541C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FA46105A
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhDNK45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhDNK4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 06:56:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5CC061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 03:56:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so30749285ejr.5
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UAMBZSg9BPza+9BO+WPgdYOfKA0AcbDNYEf00hNk48Q=;
        b=P2XPooQFbnuLeCHC/Gu7b91a/lLDhuajQHei2hgBUpEcoUywj4EwyPdktxNDtWVkBQ
         QjEgCC8Ept6rKfgA9W9sULl+76wcP8W50s+d166ofmHxEpNQrxURfZaavRIUk7lHn065
         4sUQIlrVDUdiM706Ybyl9PsiO8M2JiI2ZwI5FNe4JFPU3sbaF0Y8jmsKZvc1mFe3jO9s
         ZNwdmUXrVOSiLr2g2mMY36lU1PLZEtOSFuJCVbUnFS30S1edSRDZox0m3Kp9HYWsLeo0
         UINR76tI3KKq+fi2Fu7788o+Kecl9tdduc5YyarNTh115DLu/eW2JsjxjwWP3dDTH9SN
         AgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UAMBZSg9BPza+9BO+WPgdYOfKA0AcbDNYEf00hNk48Q=;
        b=EBOkxrUD6oSVTJREozUXeomtxYRGEQk2aE594RdPQC765NG/hME2/uK3Npc1Pk31Jt
         oS/U8DusDjlWyDKrNRe7qe8crR71s81DW1ucsAa2PzrBwM84wrDNxcgdKzzeYzcYsixJ
         yHEKQYExA6wqUOlUX4qD3uq2tPNLk4VcfXdNgSBP/F+EDbyXBb+YcFvQ8ESNr3OObhWa
         eKlYbOOV0MphWQOS8IGZ+1FNvKuKT7JbGIoF/4jTCoCK5uoOFu7rHI79bHEGyi3qaYPo
         0I6x5o6nfdbOY5tceRZ2zHKQemQSvQZ2nPpCQ6qrqF816QOu/4oE6kxuhDHVIKbNpRmc
         XyIQ==
X-Gm-Message-State: AOAM531g2PNu10JtPEPHPI5xo7pi/ZtiJafVZZrcr15yyfMjSy4QHDLk
        V9cnbEknKLDe67VnQCM/KU8=
X-Google-Smtp-Source: ABdhPJze3xn6srECjKtRghDbDZia6YGIeHA9EYHUUvEHvNeTbHsb9X/z3wCgUQKyytaUCOD/bTzJ5g==
X-Received: by 2002:a17:906:2b94:: with SMTP id m20mr36769241ejg.297.1618397789104;
        Wed, 14 Apr 2021 03:56:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g10sm2198675edf.82.2021.04.14.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:56:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Sam Bostock <sam.bostock@shopify.com>,
        Git List <git@vger.kernel.org>
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
 <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
Date:   Wed, 14 Apr 2021 12:56:27 +0200
Message-ID: <87sg3t16ec.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 14 2021, Chris Torek wrote:

> On Tue, Apr 13, 2021 at 5:18 PM Sam Bostock <sam.bostock@shopify.com> wrote:
>> Long story short, it seems to me that `git fetch` should update
>> "refs/remotes/origin/HEAD" when the upstream HEAD changes, but it
>> doesn't.
>
> It's never been the *intent* to have `git fetch` update
> the corresponding remote-tracking `HEAD` ref.  To make
> that happen, you must run `git remote`:
>
>     git remote set-head origin -a
>
> for instance.
>
> I have, however, often thought that this is the wrong
> *default* way for things to work, and that at least by default,
> `git fetch origin` should update `origin/HEAD` if the
> fetch result indicates that it should.  See also Junio's
> reply.  I think a configuration knob (similar to `fetch.prune`)
> would be reasonable here.  Users could then be encouraged
> to set `fetch.prune` to `true`, and `fetch.update-remote-HEAD`
> (or whatever) to `true` as well.

As you'll see from the previous linked thread I happen to agree with
you, but let's not step past that agreement and (no doubt subtly and
unintentionally, in this case) misrepresent the other side, which also
has a legitimate argument.

Which is that this notion that "[a client should update its view of a
remote to what a] fetch result indicates that it should" isn't something
that exists, and that we ever had it is only an emergent implementation
detail.

So first of all, a "fetch result" doesn't look anything like
that. Rather the server presents refs it has, and the client decides
what it wants.

Which is the start of the disconnect in mental models around this. What
you see with "git ls-remote origin" != what you should expect to have at
a local refs/remotes/origin/* after a fetch.

Nothing in git itself actually needs this remote HEAD past clone time,
and with 4f37d457065 (clone: respect remote unborn HEAD, 2021-02-05)
there'll be even less reason to pay attention to it.

We don't even always get it on "clone", we don't do it with "--bare",
since the reason we do it is to one-time setup the default branch, which
we then hardcode in the config in the non-bare case:

    [remote "origin"]
            url = https://github.com/git/git.git
            fetch = +refs/heads/*:refs/remotes/origin/*
    [branch "master"]
            remote = origin
            merge = refs/heads/master

So arguably the bug is the other way around, that we should never save
this information at all in the ref store at "clone" time, which would
make "init && config && fetch" and "clone" consistent.

I haven't looked, but wouldn't be surprised to discover that this was
originally needed back when we needed to ferry information between
shellscripts, and was just diligently retained when the relevant parts
were rewritten in C.

But I digress.

Now, what people *do actually* legitimately use this information is a
convenient local cache of "what's the main upstream branch?".

I myself have written local scripts that used that, and been bitten by
this information being stale / not there (in the case of
init/config/fetch).

But why does anyone need that? Well, I don't think they actually
do. What they actually do want is to push or fetch the "main"
branch. The "what was HEAD that one time I talked to this remote" is
just a roundabout way of getting that.

So isn't this whole thing just wart that we should fix in the protocol?
Wouldn't the use-case for this be satisfied with something like:

    [branch "master"]
            remote = origin
            merge = HEAD ; does not work as you might expect

Right now that will just push to refs/heads/HEAD, but what if we had a
protocol extension to intercept it (or rather, some merge = <a name
incompatible with a current push, maybe "$HEAD">, as an aside setting it
to ":HEAD" has some very funny results) wouldn't that satisfy the
use-case?

After all, who's really interested in what the remote's idea of their
HEAD when they last fetched is?

Don't those users actually want the *current* idea of what HEAD is for
the purposes of fetching or pushing?

If we supported "I want the tip of your HEAD" (which we do) or "I have
this ref update for you, on top of your idea of HEAD" (we don't) you
could "git push" and it would do the right thing whether the primary
branch was renamed from "master" to "main" during your "git push" or
not.
