Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E6C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18262076E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5r/3mcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDGS3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:29:32 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46603 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGS3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:29:32 -0400
Received: by mail-ot1-f44.google.com with SMTP id 111so2785190oth.13
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZR2K4XmXpicNbJxdFyOz6yR7Qk2pox+fwo+cuQPNWCg=;
        b=V5r/3mclNN/dX5WUd6Nx1eD4wx7c0VoFFNbDsyI5kIQwN2AlxOwE45rHTp032zRYbs
         4fzYn5yOmT15nYxD8YH3ODPqAUDhrBcmpVgUZqgx5BcezVFzY+ZVHpzA0Ui72CbeKNbu
         pp1n3hJeu6zt3l2ZD1q4Ry064bU1cX3pgiOOpFb5YB/u8s/nrUqyK1/igtrVdTfS6pHH
         3vdUptdcn2TVkPSVsOU+a+Fl19g6Gc1lcGT/Oi8EJdYfrRVXXYONszMbuYgurZWTzazn
         nkif+9jsg8VnZ1klQBWTNv7+goGLD0U9e7PmlN5NQe+gi9QEC0ca121z4sJgWYihR8bo
         lmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZR2K4XmXpicNbJxdFyOz6yR7Qk2pox+fwo+cuQPNWCg=;
        b=WJsl6CpFwWHbPBFrzKTPIorlMirxYnfxVame+EyvpMyPzjDqtSJxQEPt8GrwGaIIms
         BhesHqfk2ycFnUNpeR9sch/YhuDt4tv95Lg2gDejF34D2wPid7371va3wB2CxEy+KY9R
         s3beELxT8rLoGae6843mqR6ki39cT/1qsEvYqVsHVeSt+iYNHy94QdBi1pwCmC+0atyj
         1A+Lh9tBsjX9mnV+PDxvK3V6pV8hecIRQz8Ahd9TqBLsTdLo4qyRKxRq3u5jl8IgtBNq
         fkLrq78VSwlSb6wdUqT2lr51r+YgPgFdit9ATJ5JRJ8HI9Bumndr3D5LU7Q4DIueTZTL
         aJSQ==
X-Gm-Message-State: AGi0PuYItQaOfxin/jbrV27ZxxjvNYDTuVN8Itz6MQmwqaRJ1HzUTmvd
        uNKPN8luswDMrnqr2KoEW/QORwJFR4qNa/N5zQGgEMik
X-Google-Smtp-Source: APiQypId7FDSkwpdqVKPN0eNxq2QIkCaVundk8KTqxjPiGV/kRuZoY3oPkwrJy6DbYamEYPF9v/KRa0/XVmepdWOhtI=
X-Received: by 2002:a4a:3b50:: with SMTP id s77mr3029955oos.53.1586284171262;
 Tue, 07 Apr 2020 11:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
 <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com>
 <CAAb+AL-95RKhTghJX4uLxiM3dqZW6U914XBXaLcwK+gC_FezWw@mail.gmail.com>
 <CABPp-BE1mDQYcj6nRfS4osn8-E_WdV-Nenn9dQSA+JCr+pjKLQ@mail.gmail.com> <CAAb+AL9KaFbOk2eMPbn0zCKC4KfX-chx4O3ndLz=zpdgpq_MVQ@mail.gmail.com>
In-Reply-To: <CAAb+AL9KaFbOk2eMPbn0zCKC4KfX-chx4O3ndLz=zpdgpq_MVQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 11:29:20 -0700
Message-ID: <CABPp-BEVaA8fnsOF9LX3x12LgYp2fF5aT_Wb3oAOtgOk6XxwMw@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Sami Boukortt <sami@boukortt.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 11:16 AM Sami Boukortt <sami@boukortt.com> wrote:
>
> Le mar. 7 avr. 2020 =C3=A0 20:03, Elijah Newren <newren@gmail.com> a =C3=
=A9crit :
> >
> > On Tue, Apr 7, 2020 at 10:28 AM Sami Boukortt <sami@boukortt.com> wrote=
:
> > >
> > > [=E2=80=A6]
> > >
> > > Sadly, that is somewhat inconvenient, as those commits are not
> > > actually =E2=80=9Cintentional=E2=80=9D from my viewpoint (though I un=
derstand that git
> > > has no way of knowing this), but rather created by another tool
> > > (git-imerge), which means that I have to check each commit
> >
> > git-imerge creates non-merge commits?  Is this in the case when it is
> > acting like rebase?  If so, is this possibly a bug in git-imerge (in
> > that it doesn't drop commits which become empty)?
>
> It is indeed with `git imerge rebase`. I don=E2=80=99t know enough about
> git-imerge=E2=80=99s internals to know how easy that would be to fix, but=
 it
> does seem as though that would be the ideal approach.

I don't either; maybe Michael Haggerty (cc'ed) can chime in on this
side of things.

> > > individually and risk mistakes. The old `rebase -i` behavior, where
> > > such commits were automatically commented out, would be an acceptable
> > > compromise, or even a comment added at the end of the commit line (so
> > > that they are still kept if the editor is closed without changing the
> > > rebase list). If there are plans to eventually remove the =E2=80=9Cap=
ply=E2=80=9D
> > > backend, could that workaround be considered?
> >
> > Automatically commenting them out is bad; that causes frustration for
> > people having to uncomment all the commits they intended to add.
> >
> > But we could add some kind of option.
>
> Instead of automatically commenting them out, how about automatically
> annotating them while leaving them in the rebase list, like so:
>
>     pick 8441f42 Commit A
>     pick e3fcaf8 Commit B  # empty
>     pick af34c53 Commit C

That seems reasonable.  Of course, that would make it specific to -i;
I'm curious if that's good enough or if there are other cases out
there that need more.  We could at least start with this, though.

> > > Alternatively, I could also use `git filter-branch` (with
> > > `--prune-empty`), but apparently, its use is heavily discouraged.
> >
> > You could use
> >    git filter-repo --prune-empty always
>
> That does seem like it would work, but wouldn=E2=80=99t it process the en=
tire
> repository (as opposed to filter-branch which can take a list of
> revisions)?

By default, yes it processes the entire repository.  You can pass
revisions to filter-repo with the --refs option.
