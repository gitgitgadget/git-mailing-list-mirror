Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343CBC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 07:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E88206D5
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 07:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBt4j0QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfLHHqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 02:46:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34951 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfLHHqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 02:46:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id k196so3686153oib.2
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSmdg8g9egdefxB7WSyMrEz728wl7NtNXVYsO/drnqM=;
        b=RBt4j0QH3WOCfmkKu4nQ/JGy1G66O8i0PPamiI/ztxdyAimQSLWhzIqe/Ib0xE2S0z
         8gdcGs1HzuQXzneZjN4gXqCNAu1bP0FpUXoEIggeZFxd+xeCnFzzlfEUk7rmz6h200We
         ikfSnS3f7suxWBPBYSMhPQDSOcucioqQgiK/q2vdqTPKC7bjhoEkkjzroRhkjonKTnFr
         j6VB8HbWAuweTiNP33mxR40JaJjBIx+kRqRwSxlUkx/Gjo2rSatAj2E5tAgrMUnCwo3d
         e0QbXPsvav+t0za1QDlEUniHWqP1FQsdMdsz3AgoEReaFWrEGfL4WgPvtXDlgG22m6/A
         dJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSmdg8g9egdefxB7WSyMrEz728wl7NtNXVYsO/drnqM=;
        b=SoyawhUeZpu6D5f9h5xPPHHJOcrVDwQCUpdn3LhPrl68MGgPxAV+eaLAA2laGT+QiR
         PJYPqORZjAYD8adlwbUpzVrSas6a7bfkgBjFpHZcEMz8Mgtgkxn2r4BY7Z/eITMGjpNC
         w1Sn0/ZtPX9XDLyMH0FtpLLZwCvQvNkppStlUpQwxelvzlBamF08L9TVwldzURkQdpUb
         GdYVLm5Ojhcr10/Sars8gDSAkzEP1LdA1G3GSPqM8Xbp64zaLm6hkp3pMXEWJlQqYLb7
         mVS3p7bvgNACKrDOMXY8Sh2j6ToK7+gY+rKx6kwO7YYDriYYenE4kz7XQuHaZWMd1eDF
         Sapw==
X-Gm-Message-State: APjAAAVrERBfK9+Ko+tKjZde63KA5D7PDCk/hkKbkh1rha4dgJGUpq1C
        agcoYdh+GyAQkQldStyAT8HwJjm1xDHq9oQczGShyFVk
X-Google-Smtp-Source: APXvYqxnnbl+l4sBBu6TRUSOrAH4/d5hoGgsEUVK7JWwcHfwVnUNwn2SFDFSMxDskmDuy4z4PI3smAMLGx8AaB6P4OY=
X-Received: by 2002:aca:eb0f:: with SMTP id j15mr18761924oih.6.1575791173939;
 Sat, 07 Dec 2019 23:46:13 -0800 (PST)
MIME-Version: 1.0
References: <874kyf6en3.fsf@kyleam.com> <871rtfv0wn.fsf@kyleam.com> <CABPp-BEvr+wB_yqOAG9oOaONtckYzn-zghyAtx2fWJweg55ovA@mail.gmail.com>
In-Reply-To: <CABPp-BEvr+wB_yqOAG9oOaONtckYzn-zghyAtx2fWJweg55ovA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Dec 2019 23:46:03 -0800
Message-ID: <CABPp-BGpfATCdiat0A6OHx3aG22BzOcC37HG8wBMRrrbLG_Mfw@mail.gmail.com>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 7, 2019 at 9:42 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Kyle,
>
> On Sat, Dec 7, 2019 at 9:31 PM Kyle Meyer <kyle@kyleam.com> wrote:
> >
> > Kyle Meyer <kyle@kyleam.com> writes:
> >
> > > Elijah Newren <newren@gmail.com> writes:
> > >> [...]
> > >> At least my changes in git-2.24.0 made the behavior consistent; it'll
> > >> always traverse into a directory that matches a given pathspec.
> > >
> > > I might be getting mixed up, but the changes in 2.24.0 did introduce
> > > some inconsistent behavior (in the no trailing slash case) with respect
> > > to giving a single pathspec and giving multiple pathspecs, no?  Using
> > > your example:
> > >
> > >     $ git --version
> > >     git version 2.24.0
> > >     $ git ls-files -o untracked_repo
> > >     untracked_repo/
> > >     $ git ls-files -o untracked_repo empty
> > >     empty
> > >     untracked_repo/
> > >     untracked_repo/empty
> >
> > It looks like the "multiple pathspecs trigger traversal" change isn't
> > limited to nested repositories.  It can also be observed with
> > --directory and plain untracked directories.  Assume the tree layout
> > from your example again.  With a single pathspec (and no slash),
> > 'ls-files -o --directory' will not expand the untracked directory's
> > contents:
> >
> >     $ git ls-files -o --directory untracked_dir
> >     untracked_dir/
> >
> > But, as of 89a1f4aaf7, tacking on an additional pathspec will cause
> > ls-files to traverse into the untracked directory:
> >
> >     $ git ls-files -o --directory untracked_dir empty
> >     empty
> >     untracked_dir/
> >     untracked_dir/empty
> >
> > In contrast, on 89a1f4aaf7^ the same command shows
> >
> >     $ git ls-files -o --directory untracked_dir empty
> >     empty
> >     untracked_dir/
>
> Yeah, I spotted that too.  You left out a case, a single pathspec with
> the trailing slash:
>
>    git ls-files -o --directory untracked_dir/
>
> That will traverse into the directory before or after my changes.  I
> also spotted a few other bugs, e.g. try out 'git ls-files -o .git/'
> (with either git-2.23 or git-2.24).  Whoops.  We do correctly avoid
> traversing into the .git directory if multiple pathspecs are provided.
> Anyway, this whole area seems to be a bug factory.  Every time I think
> I'm close to having some patches to send to the list to fix up the
> issues I've found, I find the fix isn't where I thought it was and/or
> find yet another bug.  Quite aggravating.
>
> I'm thinking of just sending the patches I have, since they fix up all
> the issues we've discussed so far (including the .git/ case I just
> mentioned), and ignoring the 2-3 other bugs I found that are still
> broken other than providing testcases documenting their breakage.

If you want to take an early look, I've got some patches up at
https://github.com/git/git/pull/676.  I plan to write a proper cover
letter and submit to the list on Monday.
