Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACDC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiAXQzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiAXQzI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 11:55:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A1C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 08:55:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m11so57611849edi.13
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4HVAxSBfX6TFuE0dIAEFo+nW/5TPiN7zmCJweMxpRmU=;
        b=kXednMahxbH2tG/2M+VFdbnNDb5d8Ej5XTam88BsB4VJkL7yjnGIqpETZip4K5HueK
         JS3aM7b5KSfWi0hmGaO8Al2f/JkLlgk12YWiDz1f2w2RnvIuP8GaJywSI9BIh2VrGjiT
         GzeyD2Juzeem1lg562KCYF/IzXLr2tktZW+fSUsI0j+T9oKLntV7Jy2eMCFWmPazdbNQ
         wVgEfwmSvA8CxBF65TzLpW6PBKPxLx4MREHkCKgwUq1l8esN5y2MjuCgsFycoJmTx/R7
         980p3GccRUZc805ooZ3+D5jr6iWk2uFtB0w8Q8FD2AVRc5u1QJ4tMjEFzdBDH0h7KaaN
         NsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4HVAxSBfX6TFuE0dIAEFo+nW/5TPiN7zmCJweMxpRmU=;
        b=Rsswhj+WW5ckF4bzikNzlfdN5jpGJ2xs9zz6x0lZ4Dq+bwx/QCA2FlIrWyon2/pqos
         OGUWO9a4e6AjviGd3UPgXCMdMlEYIdkFLdK2LSL4quNTd/uxxBmS4qsVLfY79wfqbBJr
         2bD2uv4txHJ/mXysbmQ/tCQgCqLlXvgx7Ng6GZuUvRXx6Ujh23K90BDgYzF20q1Hp5Mx
         Y5cBWLqNujwOmfr0PaaxwE1aY4psjtm7dzJrc6xt99bzeud2zc5yTdjxAq+uTWGe1a5T
         kvIfTDGAryxso/vHCLaeQ62jmxMFS5CXIxYSfy7ScEVDzaFQ+3/eBfGMToxs1OVEhT7e
         s/4A==
X-Gm-Message-State: AOAM533s3mvxhg76b1ovkhIyIUxxa9hEoT2r0deulQX4tbBYomihDI+e
        ebaUMMTffaf0O6gHXMHVb9d7DqC5ywTsMQxCKDyA1NhxFHg=
X-Google-Smtp-Source: ABdhPJwRhUlC+mrGtivsOkqdgQgGNS4Y/jLPxciTx+sbj8z68+fMlSIT8DixMx0wc1dtRJGzZ/dQH0JxeY2fq1NqqSU=
X-Received: by 2002:a05:6402:b06:: with SMTP id bm6mr15858068edb.94.1643043306364;
 Mon, 24 Jan 2022 08:55:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
 <220124.86lez5ihso.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.86lez5ihso.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 08:54:54 -0800
Message-ID: <CABPp-BG1UXDLVh4_F_TQJmiM4=fFMOLFo5k27=MghbBPWPkL7A@mail.gmail.com>
Subject: Re: [PATCH 03/12] merge-tree: add option parsing and initial shell
 for real merge function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 1:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:
>
...
> > +     /* Check for a request for basic help */
> > +     if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> > +             usage_with_options(merge_tree_usage, mt_options);
>
> Is this bit cargo-culted from something else, perhaps
> non-parse-options.c usage? I don't think this is needed, the
> parse_options() below intercepts "-h" by default.

Yep, sure was cargo-culted from somewhere else (my parse-options usage
always is), but I'm pretty sure it was from another place also using
parse-options.  Probably one of these 15 places:

 $ comm -12 <(git grep -l parse-options builtin/ | sort) <(git grep -l
strcmp.*-h\\b builtin/ | sort)
builtin/am.c
builtin/branch.c
builtin/checkout-index.c
builtin/checkout--worker.c
builtin/commit.c
builtin/commit-tree.c
builtin/gc.c
builtin/ls-files.c
builtin/merge.c
builtin/merge-tree.c
builtin/rebase.c
builtin/rev-parse.c
builtin/sparse-checkout.c
builtin/submodule--helper.c
builtin/update-index.c

> > +     /* Parse arguments */
> > +     argc =3D parse_options(argc, argv, prefix, mt_options,
> > +                          merge_tree_usage, 0);
> > +     if (o.real && o.trivial)
> > +             die(_("--write-tree and --trivial-merge are incompatible"=
));
>
> Shouldn't those two just be OPT_CMDMODE()? Then you get this
> incompatibility checking for free. See 485fd2c3dae (cat-file: make
> --batch-all-objects a CMDMODE, 2021-12-28).

TIL.  Thanks.

> > +     if (o.real || o.trivial) {
> > +             expected_remaining_argc =3D (o.real ? 2 : 3);
> > +             if (argc !=3D expected_remaining_argc)
> > +                     usage_with_options(merge_tree_usage, mt_options);
> > +     } else {
> > +             if (argc < 2 || argc > 3)
> > +                     usage_with_options(merge_tree_usage, mt_options);
> > +             o.real =3D (argc =3D=3D 2);
> > +     }
>
> And this can also be done like this, but I wonder if using
> PARSE_OPT_STOP_AT_NON_OPTION and then routing to a sub-function wouldn't
> be better, i.e. to treat these like sub-commands if they've got
> different arity etc.

Not sure what you mean; I already route to sub-functions.  But I
should definitely add PARSE_OPT_STOP_AT_NON_OPTION; it's unfortunate
that it's not the default.
