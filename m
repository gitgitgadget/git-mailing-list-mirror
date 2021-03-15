Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD7C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6459D64E81
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhCOIVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhCOIVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 04:21:43 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789EC061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 01:21:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so4700839otn.10
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iYrT67mUaxWTvi/zIXbQpN+x2oH6kz+7jmCcTKwxC7M=;
        b=Gf/XNcQVSs9tUcFMwXu+/fr9qRAlSgmRdBeuOg+CYev46/i3vY991XHyCX1IM6HMor
         Dw+WEHuALPOQPgy6jvwdLhGWyP0rW9cNUw3gfyCE5veggyl0FH4rXqgYOQDFDqx6DbKJ
         x5jvgtj4ZPnG+3iaDhZVbSOhDSLY2DV2Ur+60pxuY6UtRJBZndanEyAJyJ2tERENpcuc
         Ft0Beu9lOvxfng/8eG6A7xdOObd/8w4RynKHweUVv8tyQ/C9z7WAdi3UZeqTJwfRJw22
         HwHq+tbuXPUaX/1WTZtRmN7hpmwSh3eYw/IZCtuekhv77wS5WGZJ6cmph1gyv4jKgDFg
         r+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iYrT67mUaxWTvi/zIXbQpN+x2oH6kz+7jmCcTKwxC7M=;
        b=kIBsn9Q2P0e86EmnWLRBnDjTrvlTZ+NcZ0XoiIqPj0I6VglAibgE2s831Wmqgk3hkc
         0wtfXsUXgJKIFGnXWyXjJLJLH1pQ5vUbQn0+FdxkfIkDJTPmSmfuhW8X+M4fK2Ox/eGQ
         hkc4YYuRuoPocVbeYc9H21vQnSUUfBIjqdccHIlABBCknTnQkE5vscxauWcVAbfdhhQy
         ayM2Wksy1/sBVXJ42DGoJFSNu9jhzdQi9H/ZZP8uPO3FM7goxaVTKrsxTmL4urFsZ5wc
         iIq7vgsI3U6n7QFoZTgNRmf98XRtA6Y2sQFAlRxx/hG2fYvzaM+Y0KJrhQIsaywts5TR
         VE7g==
X-Gm-Message-State: AOAM533GNOpOJpt9/qsjaWFXDAaoFTbQb5AW1qVy2HwLP4oGiV64D4WW
        EP//lKOYCDuLY9pbbpLipJU8lDiywPAhlTDqgtk=
X-Google-Smtp-Source: ABdhPJxUbHuGne4zZqYEr192N/AS/xy7IIHDts+QGtgT05yJzK8qnqfGjknrGNWJLMdAppRUWhfxIQLBHbJ1I7DL4Lo=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr5666597otq.160.1615796502889;
 Mon, 15 Mar 2021 01:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com>
 <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com> <CAP8UFD1W+oPwXzjq8SFVRTusJiw-3jvMTmBjLzK6PH6=GN+QwA@mail.gmail.com>
In-Reply-To: <CAP8UFD1W+oPwXzjq8SFVRTusJiw-3jvMTmBjLzK6PH6=GN+QwA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Mar 2021 16:21:30 +0800
Message-ID: <CAOLTT8SFnnyfYvNJxApujw3-3eJyPEKXYOyoiM7QqCf8CzTD3Q@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:03=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 15, 2021 at 7:35 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Historically, Git has supported the 'Signed-off-by' commit trailer
> > using the '--signoff' and the '-s' option from the command line.
> > But users may need to provide other trailer information from the
> > command line such as "Helped-by", "Reported-by", "Mentored-by",
> >
> > Now implement a new `--trailer <token>[(=3D|:)<value>]` option to pass
> > other trailers to `interpret-trailers` and insert them into commit
> > messages.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] commit: add --trailer option
> >
> >     Now maintainers or developers can also use commit
> >     --trailer=3D"Signed-off-by:commiter<email>" from the command line t=
o
> >     provide trailers to commit messages. This solution may be more
> >     generalized than v1.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2=
Fadlternative%2Fcommit-with-multiple-signatures-v6
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlt=
ernative/commit-with-multiple-signatures-v6
> > Pull-Request: https://github.com/gitgitgadget/git/pull/901
> >
> > Range-diff vs v5:
> >
> >  1:  ca91accb2852 ! 1:  c99ce75da792 [GSOC] commit: add --trailer optio=
n
> >      @@ builtin/commit.c: static int config_commit_verbose =3D -1; /* u=
nspecified */
> >        static int no_post_rewrite, allow_empty_message, pathspec_file_n=
ul;
> >        static char *untracked_files_arg, *force_date, *ignore_submodule=
_arg, *ignored_arg;
> >        static char *sign_commit, *pathspec_from_file;
> >      -+struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> >       +struct strvec trailer_args =3D STRVEC_INIT;
>
> I suggested added "static" in front of the above line, like this:
>
> static struct strvec trailer_args =3D STRVEC_INIT;
>
> You can check with `git grep '^static struct strvec' '*.c'` and `git
> grep '^struct strvec' '*.c'` that we use "static" when declaring a
> 'struct strvec' globally.
>
> [...]
>
> >       + if (trailer_args.nr) {
> >      ++         static struct child_process run_trailer =3D CHILD_PROCE=
SS_INIT;
>
> I didn't suggest using "static" here.
>
> >      ++
> >       +         strvec_pushl(&run_trailer.args, "interpret-trailers",
>
> Thanks for working on this!

Well, I was too eager to submit it.
There are many rules for git projects to explore.
Thanks.
