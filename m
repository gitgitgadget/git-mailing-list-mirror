Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FD0C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 16:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiBAQkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 11:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiBAQkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 11:40:21 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B29C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 08:40:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s5so55747662ejx.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nCLI0/C0ud3nHrVPd5zwGrlrW91jH6ddzefKb0AmsA8=;
        b=aXyiVdMXo3OBSa0yEiAalf+5VEZnXHXplrjDY+XLA3SjPtw8Quc/AqtycHuCfa+y6m
         IaFgC5KzGQdt1lV9pO/9kxFAwc6raWIILMOKjDgnmXr3oUTDKjcp7/Nt5UFsYE9dTKI6
         rR+mgp86/OujWlf/RSJWdjlEIv/1peR7r8M1JPViLoNwdoT6x2ONCStJR4GBWyfHN3fY
         VvnZRCrWUjov+d87F9dcrnUOLA7HjvoNlsr7rfdpSSWqw+lG40pJ1xsTXla75+IDlV4f
         43VVGR4t32F0bl4krPkpDSPZbZkydOZculTleCu1l1BElNWKZmvhMpsgm/WhmUUjQw+i
         RmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nCLI0/C0ud3nHrVPd5zwGrlrW91jH6ddzefKb0AmsA8=;
        b=evnRoNQG8d6u4xIWJrtGEWufEev9bma/DzUF+WA+JbEsDuqt7+6xUo1n1MUupR3kFr
         IdTrL/A3UuabIGsYnkR80lGwud8pWqeoJx4Wq1rYRmKan459q7fHodGJXe635JPJIQHy
         T834utt3cWAKuFYWlheRuL0ZUFpnpjBC6p/d2TLKkn/RofbAaUCgMI3gOQiokbO/NXVS
         PzuXx57qWxUIBXOhp/lJ/b67d3GMc2RPHs6UHqU/Wyqk6UUv1CuLIVM0AtyHy+tx9RlS
         uLS3IBkaGSF33DJYOQpPNj+oKy+vGMCQhhF+QwUvS/LEKS+FrDC9FzWxVJXZGdNePLgE
         m/xA==
X-Gm-Message-State: AOAM532Ni8rYMUuhUcMJf6HngD5Z2v2GK6/Gi4Uywzr0AnqLNyKSzmhb
        HnUCOKRhyfLTzde2fTmnH1FJKiHl+EOqhQCCMxzDuF48
X-Google-Smtp-Source: ABdhPJxh5EWJFmki1mxFmp9g2zHoa+uVR1DPnXrBfa11UXrVsJMZAklNeryFfNGr1xgYhqWojrtR9n/ACQDQYXlrt9A=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr15868277ejc.328.1643733619550;
 Tue, 01 Feb 2022 08:40:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com> <0b94724311df34dd10debd43c466695ed406d790.1642792341.git.gitgitgadget@gmail.com>
 <220201.86zgnb9bf9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220201.86zgnb9bf9.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Feb 2022 08:40:08 -0800
Message-ID: <CABPp-BE1p4bvm40-w5UDczSG8Ws+rR5tvjBL4gq_cgvYa92Q+Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] show, log: provide a --remerge-diff capability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 1:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Fri, Jan 21 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> >  ifdef::git-log[]
> > ---diff-merges=3D(off|none|on|first-parent|1|separate|m|combined|c|dens=
e-combined|cc)::
> > +--diff-merges=3D(off|none|on|first-parent|1|separate|m|combined|c|dens=
e-combined|cc|remerge|r)::
> >  --no-diff-merges::
> >       Specify diff format to be used for merge commits. Default is
> >       {diff-merges-default} unless `--first-parent` is in use, in which=
 case
> > @@ -64,6 +64,14 @@ ifdef::git-log[]
> >       each of the parents. Separate log entry and diff is generated
> >       for each parent.
> >  +
> > +--diff-merges=3Dremerge:::
> > +--diff-merges=3Dr:::
> > +--remerge-diff:::
> > +     With this option, two-parent merge commits are remerged to
> > +     create a temporary tree object -- potentially containing files
> > +     with conflict markers and such.  A diff is then shown between
> > +     that temporary tree and the actual merge commit.
> > ++
>
> Re some previous discussion. I really think we should add something like
> this paragraph to this:
>
>     The output emitted when this option is used is subject to change, and=
 so
>     is its interaction with other options (unless explicitly
>     documented). I.e. many of the same caveats as the "OUTPUT STABILITY" =
in
>     the linkgit:git-range-diff[1] documentation describes apply here. In
>     particular other diff filtering options, pathspec limitations etc. ma=
y
>     not produce the expected results, as some of those may apply to the
>     "real" diff of the merge, and not on the generated "remerge-diff".
>
> I think that would nicely give us permission to develop this further
> without having to think about all the option interaction etc.
>
> This is really useful right now, but I'd hate for it to get merged with
> some bug/behavior that's not obvious to us now, and it being hard to fix
> that because we'd have to consider the implicitly promised backwards
> compatibility.

Sure I can add something.  I think the first sentence should be
sufficient though.

> >       int saved_dcctc =3D 0;
> > +     struct tmp_objdir *remerge_objdir =3D NULL;
> > +
> > +     if (rev->remerge_diff) {
> > +             remerge_objdir =3D tmp_objdir_create("remerge-diff");
> > +             if (!remerge_objdir)
> > +                     die(_("unable to create temporary object director=
y"));
>
> I guess the s/die_errno/die/ here is better for now as we won't report
> the wrong errno, but also lose the common case of errno being right. But
> that can be fixed up with some other series to the tmp-objdir API.
>
> > [...]
> > +# This test is ort-specific
> > +test "${GIT_TEST_MERGE_ALGORITHM:-ort}" =3D ort || {
> > +     skip_all=3D"GIT_TEST_MERGE_ALGORITHM !=3D ort"
> > +     test_done
> > +}
>
> FWIW this is still on a more complex pattern that it needs to be, see
> this v1 discussion (which you seemed to ack):
>
> https://lore.kernel.org/git/CABPp-BE+4rZNP-5mT2MNOWR6y6BgEG6mt1r_qcrZtaro=
m6aGsw@mail.gmail.com/

Um, I thought I made this change.  How did I lose it?

Thanks for catching; will fix.
