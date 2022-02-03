Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E6C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 16:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbiBCQUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbiBCQUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 11:20:48 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C141C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 08:20:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id s5so10417172ejx.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NDSP8t7/E4TLhw/wIka7+gghaOfiEwhA/CmB15LpXqQ=;
        b=UF55ArvVhxm5VvQn8Z3gWb1RwFSWMTVKIkARLEY47qy6TtrtysJrMbRnvjYF+ZTuYW
         yPA+/mGInxlTLgSiizUvv8PD+GmeQCShRr1iW5yGqSoqBNYcx0xeVfKhuANZaFAc4ItP
         LdiSu4HI4NIyQwS1GARWfmaW8MjU3yrYG2a9iGjM7YnyXcJyV4R4Q+d/O2c+HR6yS2LN
         YHtl6hAmhg0eHhnKYb18rBvlelEyg7zj2I2LNMGOpuvatG1FFJMnh3N5K7JUWNvyfbn/
         CpImp67L/EumkgXRaRelG0ZYUvdnLSogbZmF6yZOXJ//X/y5xnebZkz8qcgXFZqj5IlM
         GAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NDSP8t7/E4TLhw/wIka7+gghaOfiEwhA/CmB15LpXqQ=;
        b=F9rSqWYSF6jDs8of2+xt+nt4pvOrmSE/r9OONxAsBTxr8BY6mloEw5TgxSUrSTzGAB
         yxr9oLZnKrR58G98R3gvapNhXDQZ8btI9tDPZyrPomOsYGP8njmzQ2iy/MJQE8k6XiEE
         FQwFmBcliW2s/NnYs1mnfPgB9gxRqYYDq9b7FChQBCUUNSVhl0XzSFCcUxBGUKiQ8rua
         6wxUBzqT6fmnGxuS/ZgiqyVXfkpYt9klDLo9vw6vl09TKM8IAnLyA/N1TfP7KwJtLJJW
         Z5x8ZWlGFIuyEiX9GLXrP+OfsgL0wBzydYEkUbmgiwjR4/KvYF8knPK+gyhlBmBPAn9w
         o6Fg==
X-Gm-Message-State: AOAM530ypglsK12I4BgsCK+g72zc3/ZIHKhqqigtUjZA4Q26qs2/jl8i
        M3bYK2QJIgO5JXvGzKMhASmunBPSjk1xAoXoR0M=
X-Google-Smtp-Source: ABdhPJwATbB2DqxrHk85RQunh0dETkZc2iril/G3FoACpjrhAcLXkHrzUGr5GTZ2mvs+PONTKVkc1Zy2J0vRwniW2Oo=
X-Received: by 2002:a17:906:4c47:: with SMTP id d7mr23094196ejw.192.1643905246722;
 Thu, 03 Feb 2022 08:20:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com> <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
 <CABPp-BHZYUmWBvzgFkRYddnUJQWrtah=JJ-yaW9Km8+qWcCfUw@mail.gmail.com> <220203.86wnic5lba.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86wnic5lba.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 08:20:35 -0800
Message-ID: <CABPp-BF8VoQ7F7yvfzrpQEZwErxHzb9x8M_R9PrrM7vWzw=wSw@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial shell
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
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 1:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Feb 03 2022, Elijah Newren wrote:
>
[...]
> > ...also, even if we did require the `--write-tree` flag, we'd still
> > have to look at argc.  Since the option parsing handles both modes,
> > someone could leave off --write-tree, but include a bunch of other
> > options that only make sense with --write-tree.  Individually checking
> > the setting of every extra flag along with write_tree is a royal pain
> > and I don't want to repeat that for each new option added.  Simply
> > checking argc allows you to provide an error message if the user does
> > that.
> >
> > (And I think it's sad that in Git we often forgot to warn and notify
> > users of options that are only functional with certain other
> > arguments; it makes it harder for users to figure out, and has in the
> > past even made it harder for other developers to figure out what was
> > meant and how things are to be used.  I think I've seen multiple Git
> > devs be confused over ls-files --directory and --no-empty-directory
> > options, assuming they'd do something sensible for tracked files, when
> > in fact those arguments are simply ignored because they are only
> > modifiers for how untracked files are treated.)
>
> There's a much simpler way to do what you're trying to do here which is
> to only parse --write-tree, and as soon as you have that pass off two
> one function or the other, and have those functions call
> parse_options().

But that makes --write-tree a mandatory argument when trying to use
that mode, right?  If so, that is not a simpler way to do what I'm
trying to do at all; it breaks my intended usage.

--write-tree is a documentation-only construct that users should never
have to pass.

Also, what happens if we remove the --trivial-merge flag and its whole
mode after a sufficient deprecation period?  Would the --write-tree
parameter remain required in your model to select the only existing
mode, simply due to us having gone through a transition period?
