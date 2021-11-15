Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A405FC4332F
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E033619EA
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbhKPAou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343671AbhKOTVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:21:35 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A5C061227
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:22:31 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id b17so36936621uas.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfxC/cXFTYaAVRQj+TlubHdBtMEMKXjb8G82KKtJZys=;
        b=lWv9R09/Mo5YUZateSrLdYmdNYwilhDBmGCPeKpf3+6ci0RFPfUrrFaqchCuy1rnFZ
         8N0lrRNurBestFNNrfCZqzX4ob3vOOuA4zAHCrD4fYLc4gWU9MAdfYsy3H/79vCVBqpd
         YsU3Im9VsoGqyNSyzpCBMye3Gd+gSn81FIHOZIbKVuQMVFuDcKlHRB1kFWd2pUQn8+gM
         Wl/DH7mSrUEmXym7KwV0BLdklcWp9ykJ93l1H+Fpa3HnLZ9HTB1Xeuf0Ks9WTvsFosmq
         FFeAX4YGwgVkiySK5jW00Gthc1PPL0RB8y8NSzdp2l58HANXlNFfUyT2oPH43/5lGojw
         kj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfxC/cXFTYaAVRQj+TlubHdBtMEMKXjb8G82KKtJZys=;
        b=8MQpvq9no3wDuFCAgdtrABA4plZm8Zm5YfZ/mr/EeT78GFsvy+p5x9B+hFBM0f5u6F
         GO1yZZV1lfc4eJEWdWvP9PgXTfM7VwWGaQYbb9RNOl3gSTC9OeHPOZ07xlB2M4SNhOOU
         UK0SGCk2r+IH9Q36BElRgP+oR9FfPIb7jVCYt3fCJ6KCW1Ah5aTVEPnQ3PF9MX5HKZGN
         Gl14FezFvpm6G27e2hDHZuBy81KXZc/oGzNLE7P1bxleweevo6T4blIn28ggHC5LgzJp
         XlN2ACfXGmhoN/+p3bnQHgoyeYHTRKxhcSg+yThFZKWNdIrmoNf+X0Fvjunk6/QLKVsk
         RxfA==
X-Gm-Message-State: AOAM533951p5Q1DH5AIl/CDJO+V/vHP4Rdya/iDmxBM9wJL9S+Bahffn
        Hvo8ZiK6ElMkK1UkDpdA1db/+fX6KpHCLmpws6A=
X-Google-Smtp-Source: ABdhPJwvDy0SR747REj49m7ItYijQ2wX/sBp5apN8OS4gF+IKuOCt0ySZvJEfZ5vbOOUulUe2d1IW/OWpam9U8wBd3Q=
X-Received: by 2002:a67:d80c:: with SMTP id e12mr45094647vsj.18.1637000550140;
 Mon, 15 Nov 2021 10:22:30 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com> <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
 <0bd032c1-f90b-1892-693c-518a01b3b671@gmail.com> <CADL96rs0M15E+CnycBsDqGbiibDFx4KeMthLspQH1=Bw3PS3gg@mail.gmail.com>
 <CADL96rtX_uw6fJEVq2u9bkPNhYXwaGT13F+cMiGgZrHQr5TP7A@mail.gmail.com> <CAGyf7-GjoU7VqN3bhRcoQ1xJM==h2aNm9fm_5HxDJk_hgGop1Q@mail.gmail.com>
In-Reply-To: <CAGyf7-GjoU7VqN3bhRcoQ1xJM==h2aNm9fm_5HxDJk_hgGop1Q@mail.gmail.com>
From:   Erwin Villejo <erwinvillejo@gmail.com>
Date:   Tue, 16 Nov 2021 01:22:18 +0700
Message-ID: <CADL96rt-UiPkezYBWwFk--Fy0ekUYy7DzUfhpSXwo6E+2VNbBw@mail.gmail.com>
Subject: Re: git pull bug report
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sure, if you insist:
```
 I  ~/c/database-sandbox main =E2=86=911 =E2=9D=B1 git fetch
 I  ~/c/database-sandbox main =E2=86=911 3.3s =E2=9D=B1 git log --graph --o=
neline
--decorate main github/main -n 3
* b73d3e1 (HEAD -> main) init activity api
* d370bf2 (github/main) refactor partitioning migration
* 5124511 wip pg
 I  ~/c/database-sandbox main =E2=86=911 =E2=9D=B1 git status
On branch main
Your branch is ahead of 'github/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
 I  ~/c/database-sandbox main =E2=86=911 =E2=9D=B1
```

I did some more investigation:

```
 I  ~/c/database-sandbox main =E2=86=911 =E2=9D=B1 git pull --ff-only
fatal: Not possible to fast-forward, aborting.
 I  ~/c/database-sandbox main =E2=86=911 3.4s [128] git pull --ff
Already up to date.
 I  ~/c/database-sandbox main =E2=86=911 3.3s =E2=9D=B1 git pull
hint: You have divergent branches and need to specify how to reconcile them=
.
hint: You can do so by running one of the following commands sometime befor=
e
hint: your next pull:
hint:
hint:   git config pull.rebase false  # merge (the default strategy)
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a defa=
ult
hint: preference for all repositories. You can also pass --rebase, --no-reb=
ase,
hint: or --ff-only on the command line to override the configured default p=
er
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.
 I  ~/c/database-sandbox main =E2=86=911 3.3s [128]
```

As you can see above:
- `pull --ff-only` aborts with "Not possible to fast-forward" error
- `pull --ff` succeeds with "Already up to date."
- `pull` only (unspecified `--ff`) aborts with "divergent branches"

The --ff-only case was recently fixed by
https://github.com/git/git/commit/361cb52383fb986f76a34506bdec9a1dd11133f0

The unspecified `--ff` is the bug that I encounter and I have started
a fix here: https://github.com/git/git/compare/master...erwinv:master

Best regards,
Erwin

On Tue, Nov 16, 2021 at 1:15 AM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Mon, Nov 15, 2021 at 1:40 AM Erwin Villejo <erwinvillejo@gmail.com> wr=
ote:
> >
> > $ git log main github/main --graph --decorate -n 3
> > * commit b73d3e132f9638afbf5b98b0c278ed6b93a3ae50 (HEAD -> main)
> > | Author: Erwin Villejo <erwin.villejo@gmail.com>
> > | Date:   Mon Nov 15 15:22:53 2021 +0700
> > |
> > |     init activity api
> > |
> > * commit d370bf256a756a777c14609c8ad4184aa7e9e60f (github/main)
> > | Author: Erwin Villejo <erwin.villejo@gmail.com>
> > | Date:   Sat Nov 13 19:18:45 2021 +0700
> > |
> > |     refactor partitioning migration
> > |
> > * commit 5124511d287f1a6c384ff9766fdcc0e3e07043e8
> > | Author: Erwin Villejo <erwin.villejo@gmail.com>
> > | Date:   Mon Nov 8 17:24:19 2021 +0700
> > |
> > |     wip pg
> >
> > $ git remote -v
> > github    git@github.com:erwinv/database-sandbox.git (fetch)
> > github    git@github.com:erwinv/database-sandbox.git (push)
> >
> > Link to the [upstream branch on
> > GitHub](https://github.com/erwinv/database-sandbox/commits/main) so
> > you could see for yourself that my local is ahead of upstream and that
> > the upstream has no commits ahead of local.
>
> Certainly looks "ahead". There _has_ been at least one confirmed bug
> in 2.33 related to how "ahead" is handled[1], but it doesn't seem like
> it's related to what you're seeing here. The "git pull" output
> suggests you don't have "pull.ff=3Donly" set.
>
> Are you able to pull down either Git 2.32 or the just-released Git
> 2.34 and try one of those?
> My suggestion to try "git fetch" could still also be useful, to see if
> your "git status" output changes.
>
> [1] https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH=
2PR06MB6504.namprd06.prod.outlook.com/
>
> >
> > Best regards,
> > Erwin
> >
> >
> > On Mon, Nov 15, 2021 at 4:19 PM Erwin Villejo <erwinvillejo@gmail.com> =
wrote:
> > >
> > > > the remote mainline have three commits ahead
> > > Where did you get this info? This is not true in my case.
> > >
> > > * local is ahead of upstream. confirmed by `git status`:
> > >
> > > ```
> > > $ git status
> > > On branch main
> > > Your branch is ahead of 'github/main' by 1 commit.
> > >   (use "git push" to publish your local commits)
> > > ```
> > >
> > > If remote was ahead, `git status` would say so. And this is my
> > > personal repo in GitHub with only me as the sole developer/contributo=
r
> > > so I can assure you that the upstream has no commits ahead of my
> > > local.
> > >
> > > Best regards,
> > > Erwin
> > >
> > > On Mon, Nov 15, 2021 at 4:12 PM Bagas Sanjaya <bagasdotme@gmail.com> =
wrote:
> > > >
> > > > On 15/11/21 15.56, Erwin Villejo wrote:
> > > > > There is nothing to reconcile since the branches have not diverge=
d:
> > > > > local is ahead of upstream. So I think it is a bug, no?
> > > >
> > > > You have the situation like:
> > > >
> > > > ---o---a (your mainline)
> > > >     \
> > > >      b---c---d (remote mainline)
> > > >
> > > > Your mainline only have one commit ahead of base point `o`, while t=
he remote
> > > > mainline have three commits ahead of `o` but unrelated. In this sen=
se, your and
> > > > remote mainline is divergent - you need to either merge or rebase.
> > > >
> > > > Next time, keep your mainline pristine (don't commit any local chan=
ges on it,
> > > > instead branch to the topic branch and commit there).
> > > >
> > > > --
> > > > An old man doll... just what I always wanted! - Clara
