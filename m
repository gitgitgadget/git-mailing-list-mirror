Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC836C56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75754223BE
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3vNob39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgKTQAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgKTQAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 11:00:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF4C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:00:40 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so10587561wrw.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1lRGxGxOv0kle8/bI1u0+UFsQ67nSk83h0UWUQZoTF4=;
        b=f3vNob39m0rHWQXGoPNIiYisU2R7ufpaPROZXJ4UmIYGuNYZ1f+r7gezHWcexI8JGs
         bHug25NXJ4as5zXJL09nQ/N6SdFbYPVQZ096yfCMGdNisVXMayGXhyjWiyT7q20Mf869
         elz5vD1cb59vawYsgjk1AMAk6kSSxXTwefjuHUBXUihXK0PfYCB6HCox7eSGR214CKV+
         ijbXyMlSndAsMc2/yT1jZoI3jk2l/lssD+7kWEY2b2hKVkiInqttqjslxitsn2kPVHri
         GP6jGnBEwWwNmeVVKqqFnfovCvmD9FNW3HZj3bZoMYfkjQKx9PsdMYmhP2ukqHj+4KKx
         WEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1lRGxGxOv0kle8/bI1u0+UFsQ67nSk83h0UWUQZoTF4=;
        b=uBpO+D1+UiVCS50eLSkObsMXQiWqfG0AXjI3+Kg0OB61jp9AjcKf/xejng/nKAWHEZ
         ZghB9bYZjHOmQfGryHiVkVGVAeIH6Hh7la849MZ8a4S+a27bNhQK4hIpaP/rp9lUzXKo
         kqWBzWorahi1JwXFdlE4yTRu/B3JZxAqi67FdnZFToBLQQEwDuyuZ0C7atqr3PB8Heq1
         ALDkdU52diChipYM10RSehpdm7XGIIle9lgozRNlEbMezthuAkwY2hfA/JcUQ73kd/dy
         ptZzaWi5MQtuG8uqxSGTnceTBF7HHcD7VNMBSkNjeJo1zMofjmGksPrMxUsaD9aVa/VM
         CIVg==
X-Gm-Message-State: AOAM531GdGvf/OUwHYrfP/K10o+qFT31qs5JvuwceXc5v6frLbLp1R0D
        cP1s5fYPaycVlXDm62oRDzxsRPNEnaIgL7bezTE=
X-Google-Smtp-Source: ABdhPJxAEQnPsSpljy2h4M9IlGnpaPRoftJs2Ok0Ac4QPZmrKAcqAyVpq/iye3jciGVrGYcWxuPrd0w49P3SCUc5fG0=
X-Received: by 2002:adf:e788:: with SMTP id n8mr16315202wrm.84.1605888039114;
 Fri, 20 Nov 2020 08:00:39 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
 <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet> <87ima2rdsm.fsf@evledraar.gmail.com>
 <CAMP44s2Uf4tkBdHWFV6e3K3VqCksJxwz52kgWzTBN_SAHnof-w@mail.gmail.com> <87pn48p8eo.fsf@evledraar.gmail.com>
In-Reply-To: <87pn48p8eo.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 20 Nov 2020 10:00:27 -0600
Message-ID: <CAMP44s2b7y0WJeJnJG3QoPq5b7yFF2+R-5T0SEx31v=zv1tNvQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 5:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Nov 18 2020, Felipe Contreras wrote:

> > That's a problem for GitHub et al. Fortunately they can tell their
> > users to set init.defaultbranch to whatever they want.
>
> I think this and what you mention in another thread[1] about GitHub's
> instructions for creating a repository takes a narrow view of our
> responsibility for creating a sane UI for users.
>
> For example, right after the instructions you note there GitHub's
> current instructions are:
>
>     git remote add origin $url
>     git branch -M main
>     git push -u origin main
>
> Now, put yourself in the shoes of a novice user who's just been
> introduced to this "git" thing for a job they started 2 days ago. We
> don't take the s/master/main/g change in git.git, GitHub keeps
> theirs.

I am.

But that doesn't change the instructions. The "git branch -M main"
would still be there (for older versions of Git).

And the "git push -u origin main" would still be there, because you
need to specify the branch you want to push to. Although I would have
used HEAD instead of main, or even better @, which apparently doesn't
work, but should work. If GitHub cares so much about these
instructions, they could have fixed this so "git push -u origin @"
works, why haven't they? Because they don't care as much as they claim
to (see the obvious inconsistency below).

> You followed some tutorial or read the manpage to create a local
> repository and made a few commits, then to upload it to GitHub or
> another provider that uses "main" by default you copy/pasted the above
> commands. Now the thing changing from "master" to "main" is one more
> thing you're confused by.

What if the project uses "trunk"? Or "default"?

If a project uses a non-standard name, it's their responsibility to
teach their users how to interact with that project. If GitHub chose
"main", it's *their* responsibility to tell their users that this is a
discrepancy from most of the online documentation, including online
documentation specific to GitHub.

The best way the Git project can help is by not hard-coding any of
these names, so the documentation doesn't have to use "master", or
"main", but can use @, or @{upstream}.

But right now the documentation *has* to hard-code these names,
because of poor triangular workflow support from Git, something I
tried to fix many years ago with my @{publish} patches.

If we had proper @{upstream} and @{publish} support, and taught users
how to use them well, there would be no need for anyone to do "git
rebase -i master" ("git rebase -i" would do).

> That's my motivation for supporting this change. I think most git users
> by number are (hopefully) in the future, yes, as you note we'll have
> version transitions where that's more confusing than not, but the same
> can be said about the dashed command transition.

The number of Git users in the future directly depends on how we treat
Git users in the present. And the Git users of the present would not
appreciate that 99% of documentation out there uses "master", while
Git does not, especially if in their mind it's due to bad (political)
reasons.

What's wrong with *first* fixing the interface so we don't have to
type "master" so much (e.g. by properly supporting triangular
workflows), and *then* consider changing "master" later, *after* a lot
of online documentation has stopped using the name "master" directly
as well?

> Whatever mistakes we made in that transition and should learn from a
> typical git user in 2020 has never used a dashed builtin, just like a
> new user in 2030 probably won't know or have to care about their local
> default being different than a $BIG_HOSTING_PROVIDER default.

That's *if* the current project survives in its current form. Perhaps
in 2030 there will be a libgit with more than one user interface.
Nobody knows the future.

> That *is* our problem, not just a problem for GitHub et al. To claim
> otherwise is to just bury our head in the sand.

It is our problem to improve the interface so users don't have to type
"master" (or "main), so much.

It is not our problem that GitHub decided to get ahead of itself and
change their instructions without first considering other options,
like improving the interface.

> Are we on balance going to not make the change because e.g. we don't
> want various paper books and tutorials to be confusing? Maybe, maybe
> not. But just dismissing those concerns by saying e.g. "that's
> O'Reilly's problem" would be as nonsensical as us pretending that
> perpetuating an (admittedly rather minor) UI difference in perpetuity by
> our inaction is purely GitHub's responsibility.

GitHub can fix that UI difference *today* by retracting their
instructions and instead come here and discuss with us ways to improve
the interface first.

They chose that action *unilaterally* without discussing it with the
Git project. That's on them.

Yes, GitHub users are our users too, but we have many more users, we
shouldn't hurt them just because GitHub has no patience.

As an example of GitHub's impatience, look at GitHub's Hello World
[1], the text has been updated to "main", but all the images say
"master". It's their *first* guide, and it's already inconsistent.

https://guides.github.com/activities/hello-world/readme-edits.gif

Additionally, GitHub cannot say "implement X or we will hurt our
users". That would be manipulative tactics, and the Git project should
not succumb to those. Regardless of what GitHub does, the Git project
should implement X on its own terms, if and when it has determined
it's in the best interest of its users.

Moreover, you have not explained precisely how the issues will be
solved by changing the default name. All the documentation out there
would be inconsistent with "main". Even GitHub's own documentation is
inconsistent at this precise moment.

Take one of the first results you get when googling "github how to"
[2], it says to "git push -u origin master". By keeping the name
"master" we are helping those users that are not using a github.com
guide, and are using one of the hundreds (or thousands) of guides out
there that assume the name is master. In fact, the *only* thing that
is hurting GitHub users right now is those initial instructions they
chose, which you can ignore, and instead use an external guide.

It is very likely that by doing this change we would actually hurt
more GitHub users than not doing it.

Cheers.

[1] https://guides.github.com/activities/hello-world/
[2] https://opensource.com/article/18/1/step-step-guide-git

--=20
Felipe Contreras
