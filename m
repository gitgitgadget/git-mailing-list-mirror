Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B33C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C81B61205
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhJVOc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhJVOc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:32:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B61C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:30:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z20so3036573edc.13
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5OUSePdu6Ta1YVEAcPQrGINJGoPaPHDcW0bm8hGrTgk=;
        b=DHR21hN0IRqdHWdkSxuwYrz+6WWEQZ3PenMQVcGyBd3SXm/4gdiOqabt9cbbyTMfQr
         eAZ2OxmTiaEH5xoOBuvkyqbP7xIaJ3igxzBYX1T8f501H+BuOBjj1bl1qh+FxU7FDEWU
         5vZKBNRj6zBTjHRhJEwfjjNz/31Tm8tIBmvSe3FrQbZv3bw0GG23ThKzbZvn8FBLWo1W
         x1nwaA2aVo2LK7QXlPWG99IkCHLX4VcRZUv3H+vli7daj/0olvhrRTGv8tsUdNsCwGZe
         dJasShrS6pLwvhvt1/wu9Ddq4GHgApckb55Bhak8pp7VaVh+ezQpR/omrHZKnn4vB3qr
         UmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5OUSePdu6Ta1YVEAcPQrGINJGoPaPHDcW0bm8hGrTgk=;
        b=gu2WO/v7KqMkTekiVeWnDS7pm8cTqMrmpc7i3+MMJkuWbHGLXKwsPo7ZUsT8VPoa7F
         aJao+mxnm+5WVVooA7MFFQ5r8MscI0eFlav8q8zQY2w4iBdSX+GP9Wxmk3zoYRR7GuGD
         laHxLdzmxxl2pO1Rlo6pv9q4IIGug3lqVffKoZJDsdB4AdTpd4y5MMO30krmKdB7XSDV
         Q9gHkKIisoFpwXudGyo1Gi3iOVmknA/cH6/Ns78oWeBU5Q8XCCxqJFCosyhsYjKaJHMt
         HJgbg7y0b+Fp+B71CqwEMpiJVIhhFEtRjhhMBUo3YXcEGQSJLg3Mpy3OvKg9QLnpU6kl
         oT2A==
X-Gm-Message-State: AOAM530Cqo79u9MeGzIY4yf5oOulBF+6A4yTZa1GYqzzRhfZ5RYD3lXZ
        MvzsyBrvexNC1PR4jXMjRJUYMpDLDyF3VA==
X-Google-Smtp-Source: ABdhPJwhb9LOjhzrNRkUgU26m5Q/wECWyqfn03tH3XaMCxez6i+IP3Z44TjGjA8shTOD+wpmu85I7Q==
X-Received: by 2002:a05:6402:94c:: with SMTP id h12mr408442edz.21.1634913037716;
        Fri, 22 Oct 2021 07:30:37 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m9sm4556563edl.66.2021.10.22.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:30:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdvZ6-001EQC-V0;
        Fri, 22 Oct 2021 16:30:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     martin <test2@mfriebe.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: changing the experimental 'git switch' (was: [Summit topic]
 Improving Git UX)
Date:   Fri, 22 Oct 2021 16:24:49 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
 <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
Message-ID: <211022.86v91pjfn7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, martin wrote:

> On 21/10/2021 18:45, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> E.g. the "-n" option to "git fetch" comes to mind, which isn't
>> a synonym for "--dry-run", as in most other places.
>>
>
> -n
> is only used very few times for dry run. I found
> git add
> git rm
> git mv
>
> But
> cherry-pick =3D> no commit
> pull =3D> no stat
> rebase =3D> no stat
> merge =3D> no stat
> fetch =3D> no tags
> clone =3D> no checkout
>
> In any case, "-n" has always a "no" meaning (even dry run, mean "no
> changes to be recorded").
>
> So IMHO -n is a really bad idea for "new"

Good point. I think I've changed my mind on that, but can't think of a
good short flag for such a thing.

FWIW one reason this would be needed is that "switch" intentionally did
not take "git switch unknown-name" to create "unknown-name", but maybe
we could relax that if we just e.g. printed out a notice saying a new
branch is created (which we probably do already...).

I.e. then the worst that'll happen is that the user has to "git switch
-" and "git branch -d -", except I think the latter doesn't work, so
"git branch -d <that-name>".

> About "-b" branch:
> That does give no indication something is created. I find it highly
> confusing for checkout already,
> because the word "branch" could also mean "check out to existing
> branch" rather than doing a detached checkout.
> However, others may be perfectly fine with -b only referring to
> branches that will be created.
>
> -c of course is also used for config in clone.... :)
>
> If 2 letters could be used, then -c could be given twice for "create copy"
> -c=C2=A0 =3D> create
> -c -c=C2=A0 =3D> create copy
> -cc=C2=A0 =3D> create copy

Hrm, that's interesting. But probably better to have a long-option. Some
short options (notable -v for --verbose) often work like that, but I
wonder if people wouldn't just be confused by it.

Maybe not.

> ----------
> Also, will move/copy for switch actually be the same as for "git branch"?
>
> I haven't used them, but from the docs, I take it that a
> [new/replacement] branch will be created, and this branches tip points=20
> to the same commit as the origin branch.

Both of them can take an optional "copy/create from". So I this is the
same for both already, aside from one not supporting "copy".

> But in "git switch" a new commit for the top is given. So that differs.
> Maybe someone can educate me ?
> - For move, where is the diff between
> =C2=A0 git switch --move existing_branch=C2=A0 commit
> =C2=A0 git switch --force-create existing_branch=C2=A0 commit
> Afaik only that the reflog will be copied/kept?
>
> For copy what does it mean at all?
> =C2=A0 git switch --copy existing_branch=C2=A0 commit
> Does not make any sense at all.
> Because "copy" means that "existing_branch" is to be kept. So copy
> needs a name for the new branch.
> I see 2 possible copies
> =C2=A0 git switch --copy existing_branch=C2=A0 new_branch commit
> =C2=A0 git switch --copy existing_branch=C2=A0 target_branch
> For the latter, it switches to the existing "target_branch", but
> replaces its reflog.

Maybe I'm being dense, but I'm not really seeing how a:

    git switch [some create option] <new> <old>

Would have caveats that we don't have already with:

    git branch [some create option] [<old>] <new>

Aside from the confusing switch-around of the arguments (which is
another UX wart...).

> Unless there is more, than the copying of the reflog, wouldn't it be
> better to add an option "--copy-reflog"
> Then you could do
> git switch --copy-reflog=3Dbranch =C2=A0 target_branch=C2=A0 # replace re=
flog of
> existing target branch
> git switch --copy-reflog=3Dbranch=C2=A0 -c new_branch=C2=A0 target_branch=
=C2=A0 #
> new_branch will get the reflog / this is "copy"
> git switch --copy-reflog=3Dbranch=C2=A0 -C new_branch=C2=A0 target_branch=
=C2=A0 #
> new_branch will get the reflog
> git switch --copy-reflog=C2=A0 -C existing_branch=C2=A0 target_branch=C2=
=A0 #
> existing_branch will keep the reflog. / this is "move"

Yes, I think "should it copy the reflog" is a thing that's arguably
either a missing feature or a bug in the "git branch" copy mode,
depending on your POV.
