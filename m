Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA5C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 19:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05A9613D7
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 19:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhDVTiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhDVTiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 15:38:13 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C246C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 12:37:36 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso20771702otl.0
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NE+36DdzHYh3463T3TPXqaJLNY4cu2fzD2MY/xE5r/w=;
        b=A8tGyDjdCBFmlym3hpP5sAUT5LFIhzd009Wr8t8be4r1m7nt+rEAH7hStIECA6yNub
         jhp8XXsR6OUPcQI3qgVBSXQJHi+xs/6LV8msOZXufmlQYEsYiaH6Q2SVN1EXSUls/icc
         xATV/yqnwHX3gor11YcxzHsXEWpWvjzKUTwImydRVab+noaydBLAcKPnSikZfdbGHh8k
         mpl+834yICreJuFHiykSNS+n14afOUHhterjF8tDmd+6tmjMlZX1S3fM+9dKPdbNbpyu
         +dCsZmV6CgTEehQ4z11dkHE7tigP2K1/dQzk1Lmu0wHpDIovp1Z8LFlpfyBaqVurXQ1N
         UxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NE+36DdzHYh3463T3TPXqaJLNY4cu2fzD2MY/xE5r/w=;
        b=QFpZoPrr0u0Gal5/iCFc/qqImkW6/T5KsVrZswXI6oTspNA/iQZ1Dcr1Oxsv8KA+vi
         as4lSxuZXw6W4aZ9W31TIROI0AUhYzlXxlsUzVPJkd3D+FsMXWQunqCpKdn/bEA3IOTh
         tVEyn6hUZkqrX5TnVAkOJOwQDKQn4zVztd0ilevT6hztxnkpU4UzOgfmj47g91jPw7t1
         RQNTyKn5H/biryXZ7UGZBiU20CkfVRLTdRVimvTu85phXI8d5JRj77mFnIiQTj/e3D9/
         qemtkK8AMRLRnp14V/Qpate3dtdaiEiBe/8MuGcEuvRv0AcGHojx/brina19AsxW9cjr
         yDAA==
X-Gm-Message-State: AOAM532C8cFVCsDGP4BoZv6+7p74HCSfOd9A3a63xIOdJyagT0sA/Ezl
        5/tth7DGUEMiz+KB2kTisy5l4gdTGruKzszK3J3O2qoX
X-Google-Smtp-Source: ABdhPJz78kxEMfEZZVBJ9uLZUjHFXox7B2OgZTUaCO8QmD4+Oknl4sqyaGWKhQJwq/KrN+fM/Ekn25OqJO9/RrkmiGQ=
X-Received: by 2002:a05:6830:906:: with SMTP id v6mr125440ott.345.1619120255686;
 Thu, 22 Apr 2021 12:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210420190552.822138-1-lukeshu@lukeshu.com> <xmqqa6ps4otm.fsf@gitster.g>
 <CABPp-BF-rHnxvz0sAFAujXkiNwSjtpRQA4uvxT=a3z8v_sYbAA@mail.gmail.com>
 <xmqqy2dbxybn.fsf@gitster.g> <CABPp-BF373j2BbyTgTJbKzDP9Y5R2jZVNqWeOqLtypdz6VZRMQ@mail.gmail.com>
 <871rb23dj4.fsf@evledraar.gmail.com>
In-Reply-To: <871rb23dj4.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Apr 2021 12:37:24 -0700
Message-ID: <CABPp-BFqHjcn1iFTZhvx8+GTOXiu0S+RL+mYBy8SuWXxzkgKnA@mail.gmail.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 1:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Apr 21 2021, Elijah Newren wrote:
>
> > On Wed, Apr 21, 2021 at 11:54 AM Junio C Hamano <gitster@pobox.com> wro=
te:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Tue, Apr 20, 2021 at 2:40 PM Junio C Hamano <gitster@pobox.com> w=
rote:
> >> >> ...
> >> >> +The `<refname>` is prefixed with `refs/tags/` when stored
> >> >>  in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` woul=
d
> >> >> -use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will wri=
te the
> >> >> +use just `RELENG-1_0-FINAL` for `<refname>`, and fast-import will =
write the
> >> >>  corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
> >> >
> >> > Going on a slight tangent since you didn't introduce this, but since
> >> > you're modifying this exact documentation...
> >> >
> >> > I hate the assumed "refs/tags/" prefix.  Especially since ...
> >> > ... The special casing reminds me of the ref-updated hook in
> >> > gerrit
> >>
> >> Gerrit and fast-import?  What is common is Shawn, perhaps ;-)?
> >
> > :-)  To be fair, though, given the number of things he created for us,
> > it's inevitable there'd be a few small things causing problems and
> > these are small potatoes in the big scheme of things.  ref-updated was
> > fixed years ago, and it sounds like Luke is about to fix the tag
> > prefix assumption for us.
> >
> >> > broken given the fact that the name inside the tag didn't match the
> >> > name of the actual ref.  (To be honest, though, I was never sure why
> >> > the name of the tag was recorded inside the tag itself.)
> >>
> >> The name of the tag and the name of the object has to be together
> >> for a signature over it to have any meaning, no?
> >
> > Oh, I guess if you treat the signature as affirming that not only do
> > you like the object but that it has a particular nickname, then yes
> > you'd need both.  I had always viewed a signed tag as an affirmation
> > that the object was good/tested/verified/whatever, and viewed the
> > nickname of that good object as ancillary.  I have to admit to not
> > using signed tags much, though.
>
> The current behavior leaves the door open to an attack where say git has
> a security point-release v2.31.2, and you have my hostile repo as a
> remote, and I've sneakily replaced v2.31.2 in that repo with the object
> pointed-to by v2.31.1.
>
> You "update" (but not really), verify v2.31.2 with Junio's GPG key,
> which is all correctly signed content. But the tag name isn't what you
> expected, and thus you don't get the security fix, I use this
> information to attack you.
>
> This already unplausible but hypothetical attack was sort-of-maybe
> plausible before my 0bc8d71b99e (fetch: stop clobbering existing tags
> without --force, 2018-08-31).
>
> That was released with v2.20.0, before that I could more easily sneak
> such a tag into your repo knowing that you were doing a "git fetch
> --all" and had my evil git.git clone[1] on github.com evil remote. Now
> that's unlikely to happen, in practice the "fetch --all" happens in
> order, you'll have your "origin" remote first in the file (it's the way
> git config adds them), and will get the good tag first.
>
> Hrm, I suppose with --jobs and a race condition that might not always be
> true. Aside from this mostly imaginary issue maybe having --jobs be
> deterministic (i.e. "fetch content in parallel, apply ref updates in
> sequence") might be a good idea..

Ah, interesting.  Thanks for the explanation.


> Anyway, getting back on point since no release of git has cared about
> the "tag" field I'd be inclined to say that we should explicitly
> document that we don't care, and perhaps document this caveat.
>
> 1. Disclosure: I know of no actual evilness except a bunch of crappy WIP
>    code in my git.git fork on github.
