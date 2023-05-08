Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50BC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjEHQ7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHQ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:58:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D34EFB
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:58:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965d73eb65fso691178766b.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1683565134; x=1686157134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E+CyPuDxCH+8GIGaixOyIucVh3NA9XkZRCrsYk4CUI=;
        b=Ii5Pg+M94w+u8cx1CY/1Suf2qUFoL6Q9pBGWP2LDKFUl+8m/05IH/dSml1c3m7fY8N
         ktf6HxDN7NE/goaKNItRcX3g1MZTZiAkvTDnqUamwsqSGGpTD5+yCWprcIpPh0m+LAAS
         G53MftzyFXdOCagS+iqoJZO+jMUP2u8OW46Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565134; x=1686157134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E+CyPuDxCH+8GIGaixOyIucVh3NA9XkZRCrsYk4CUI=;
        b=Pb/JQaRVN9LIDT0A/9E1FvugPrTuY5JeP7tCWQFjyDuKupjhHfcvmGx8RT3Bn6NLwd
         921JMWRXdfdwTG5vvjdqVW0Lwjt3oIEcVzf+HSBzz4zWuL/zW1FRcbCrhw7cfLx1jeEQ
         VJxn5gDWiwqHqQvutuKx6hiMTCVBfZBR1J+3RQ2yKrbzwBSf7mwj2ql0dPpZs37F0Nvb
         GPsNic9oEzinI2b66qQEVEj6RIyvwycokhezIav2dYdvht7maK9zwtPwa9HwBcKJQY5v
         C0kn/2gUhhZ9NXzi9l/gwEIDMdEp8Q46jZ86aHTdwVO66VuQdXHjHr7bKWePSKsIoQ9B
         0M1Q==
X-Gm-Message-State: AC+VfDwEZIXBI2p9W2ZVTh28yDoJAOpRm3n4ScT1V35Ct7QmaFoRJ8cU
        lVDm7Rt5ONTcRHD9BwmzOo49Xt6a9Na8n2+sCmoIag==
X-Google-Smtp-Source: ACHHUZ4soJ+sZ7c59TCKa1YZxXnYo8QQ55c8VpNHTwW2wsjwG9S3N2FTYNZi04UdfrxgHrEVZJUJ848ZYOEJOyHFKJ4=
X-Received: by 2002:a17:907:1c01:b0:94d:57d2:7632 with SMTP id
 nc1-20020a1709071c0100b0094d57d27632mr10639329ejc.31.1683565134076; Mon, 08
 May 2023 09:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
 <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
 <64581fc358ede_4e6129442@chronos.notmuch> <CAPMMpojTjFn7JCo8QsDcOJf6NoJYASbV1bL_JxDhUr7DS12DJg@mail.gmail.com>
 <64591fbddaf2d_7c6829457@chronos.notmuch>
In-Reply-To: <64591fbddaf2d_7c6829457@chronos.notmuch>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 8 May 2023 18:58:42 +0200
Message-ID: <CAPMMpoi74RFBptKkv23FSK-fQsnuan9EK5HodUBRLNtxLYdr_w@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 6:13=E2=80=AFPM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Tao Klerks wrote:
> > On Mon, May 8, 2023 at 12:01=E2=80=AFAM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > > Elijah Newren wrote:
> > > > On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz>=
 wrote:
> > >
> > > > > If we are comfortable changing the behavior of branch checkout to=
 be
> > > > > safe-and-limiting like switch, then that should be almost as simp=
le as
> > > > > removing that condition.
> > > >
> > > > I've never heard a dissenting vote against this
> > >
> > > Here is my dissenting vote: I'm against this change.
> > >
> > > If I want to use a high-level command meant for novices, I use `git s=
witch`. If
> > > instead I simply want to switch to a different commit and I want git =
to shut up
> > > about it, then I use `git checkout`.
> >
> > Thank you for your perspective on the relationship between these comman=
ds.
> >
> > I don't fully share this perspective, in two ways:
> > - In my experience most novices don't see or know about "git switch"
> > at all - the vast majority of the internet is still stuck on "git
> > checkout", as are existing users. Google search result counts are of
> > course a poor metric of anything, but compare 100k for "git switch" to
> > 2.4M for "git checkout".
>
> Yes, but that's something for the Git community to fix.
>
> Why can't the git developers communicate effectively with the user base?

Emm... I'm going to take that as a rhetorical question, since you've
been around these parts for a lot longer than I have :)

(I have opinions, but they are not pertinent to this thread, and I
don't have meaningful solutions)

>
> > - As far as I can tell, "git switch" and "git restore" have exactly
> > the same power and expressiveness (except specifically the lack of
> > "git switch --force" support for bulldozing ongoing merges) - they are
> > just as much "expert" tools as "git checkout"; the main way they
> > differ is that they are clearer about what they're doing / what
> > they're for.
>
> That is not true, you can't do `git switch master^0` because that would b=
e
> potentially confusing to new users, but you can do the same with `git
> checkout`.

Ah, I see your point - git switch requires you to be more verbose in
this case, specifying an extra --detach.

>
> > > If there was a way of doing:
> > >
> > >   git -c core.iknowwhatimdoing=3Dtrue checkout $whatever
> > >
> > > Then I wouldn't oppose such change.
> >
> > I know I keep wavering back and forth on this, my apologies for my
> > inconstancy: *I once again think adding support for "--force" (to
> > checkout and switch) with ongoing operations makes sense.*
> >
> > This does not achieve exactly what you seem to be suggesting above,
> > for two reasons:
> > 1. It could not be implicit in config, but rather would need to be
> > explicit in the command
> > 2. The outcome of using --force is not exactly the same as "git
> > checkout" without it (but that's a good thing)
> >
> > I would (and will) argue that not achieving exactly what you propose
> > *is OK* because the behavior of "git checkout", without "--force",
> > when there is a (merge, rebase, cherry-pick, am, bisect) operation in
> > course, especially the way that behavior differs from when "--force"
> > is specified, is *not useful* - even to expert users.
>
> OK. That may be the case.
>
> But it wouldn't be the first time some operation is considered not
> useful, and then it turns out people did in fact use it.
>
> I would be much more confortable if there was a way to retain the
> current behavior, but if we are 99.99% positive nobody is actually
> relying on this behavior, we could chose to roll the die and see what
> happens (hopefully nobody will shout).

It sounds like you're distinguishing here between "options for
experts" (which should be valuable to warrant influencing the
long-term design) and "behavior that users and systems may have come
to rely on". As I've argued here, I believe that the current behavior
is not *useful*, and thus a "but the expert users" argument doesn't
sway me at all... On the other hand, the "we shouldn't break existing
(scripted/automated) uses" argument seems much more convincing, and
more in line with what I was fishing for in my first question about a
"breaking changes process".

I haven't found any use cases that I could imagine anyone credibly
automating against, but I did find some tests in the suite that were
doing (in my opinion) "the wrong thing" and need to be modified:

```
# fails for some reason other than conflicts, eg commit hook
git cherry-pick XXXXX

# previously succeeded, removing cherry-pick state but leaving modified ind=
ex;
# will now newly fail with "you need to --abort first"
git checkout main

# cleans up modified index state
git reset --hard
```

I can't imagine this pattern being used in real-life automation, but
like anyone my imagination is limited.

Making this behave correctly, after my planned changes, is very
simple: replace "git checkout && git reset --hard" with "git checkout
-f", or even just with "git cherry-pick --abort". But it is still a
change in behavior that *could* cause breakage if anyone implemented a
corner-case cleanup process in the same way those particular tests
did. I believe this particular example is vanishingly unlikely,
*because it doesn't deal with conflicts*. If the cherry-pick had left
any conflicted files, then the checkout would have failed.

The question, I understand, is whether there should be a "git -c
core.suckycheckoutstatemanagement=3Dtrue checkout" option *just in
case*, so any affected automation users could set it, fix their
affected automated processes, and then remove it, before we finally
remove the "core.suckycheckoutstatemanagement" option in a subsequent
release.

Here is precisely where I don't know how to judge "breakage risk and
value of being able to revert behavior without downgrading git" vs
"complexity of implementation and communication". Obviously I would
prefer not to do a bunch of valueless work implementing and supporting
an option that no-one would ever use, and removing it a couple months
later. I wonder, for example, whether there is any recommendation that
automation users be willing and able to downgrade git temporarily, or
not. That would be one way to make the risk of this kind of
"corner-case breakage" more acceptable.

>
> But if that's the case, I think this is something that should be a
> conscious decision that is extremely clear in the commit message.
>

I will do my best :)
