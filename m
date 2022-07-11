Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A7BC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 15:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiGKP1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiGKP1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 11:27:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D47275C0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:27:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z81so5284103iof.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3lg+32xuewJxq3zngglD7cqhIYr7TtdNzfqLDIBgPo=;
        b=LZzZd+lfbYSpC/Wm+qUbpK0Z6vrD8YtQEScn5t1fkzO62a4OmERKVrZY6t5CeLYW9w
         RH4qId+jqRuKPtDwit9Jr8UTWGXwAO79rgB70VuxHfMgNhFpxpDfda1IYVByOzEWDV6H
         Bw1aiFt3IRyFLrJgio/TKuzWNUR9MXb95DuN+0Id7Lg2GNC3PMwbwPya2cIzfHC8axdT
         OnMcgZfhWELahZ8nFGNXas51u+FlATl2sjISjsUkW+c0Gi4TuZaRvvTT9odN2YPGu++I
         qzFNFIXvcMRlYOLHXzLCVf24tS8tw0N0t6CCaCgsMZd471iHqLOHWmBY0as7EmdVvjx2
         WVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3lg+32xuewJxq3zngglD7cqhIYr7TtdNzfqLDIBgPo=;
        b=fx7Cw0Cx+YCJYPA+J9PqPT5JJ76UmziZinUm2J58w6KkPPvgSSvEVuzExN8sQhViQV
         1NgKG6NNBy12aEoZIqGisQq99iADgnN4gYOXO9lDh2SIDmshT2ZvrQ4QNT4eu5gRn1hJ
         xQeoSumlZdByn7jt3oa6Xk7/Cms/r8uRwwMSWVgL1UbdUaAm4eBv3bS6k2LR+gDNC1Jt
         7tUkc3V2/+VLOS1XraUCOaJ/xH4nwrYhvcbf/LI6CnAYIQ5s/3X7W+7Pvs5huA21RJ4b
         Xo+ZdCfaLmcNJJkXjE1LlXnOS7E8lowyXpgsag1eU3PnaisIjLUAwwdpJIZhglshntVB
         9ksA==
X-Gm-Message-State: AJIora8uDSO/zbcwHlxHZ7MF/EAlTiRryV102ZNzlLnLx8JDMMy+3ZmI
        mCFMc0tIsX9xYV35XSZbIEwmXw44bdAWKXl1+/4=
X-Google-Smtp-Source: AGRyM1uZBWYzYpTbIFv8ZYi9uO8JDSqhLVrO7T7DhYxn5tOxgysWD+bsJcON7QKTbKEqm6S9l3atNxYLYplfoGSv8ao=
X-Received: by 2002:a6b:6708:0:b0:67b:87d1:bbcf with SMTP id
 b8-20020a6b6708000000b0067b87d1bbcfmr4056094ioc.174.1657553234617; Mon, 11
 Jul 2022 08:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
 <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com> <20220705192839.irfrfx4z6jwimcmu@tb-raspi4>
In-Reply-To: <20220705192839.irfrfx4z6jwimcmu@tb-raspi4>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 11 Jul 2022 23:27:03 +0800
Message-ID: <CAOLTT8Ss53yXw3bo58dHwoTWaX3wS880qKF8AXQ5KbZeTB2eUA@mail.gmail.com>
Subject: Re: [PATCH v5] ls-files: introduce "--format" option
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> =E4=BA=8E2022=E5=B9=B47=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=B8=89 03:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 05, 2022 at 06:32:40AM +0000, ZheNing Hu via GitGitGadget wro=
te:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add a new option --format that output index enties
> > informations with custom format, taking inspiration
> > from the option with the same name in the `git ls-tree`
> > command.
> []
> > +FIELD NAMES
>
> Nice
>
> > +-----------
> > +Various values from structured fields can be used to interpolate
> > +into the resulting output. For each outputting line, the following
> > +names can be used:
> > +
> > +objectmode::
> > +     The mode of the file which is recorded in the index.
> > +objectname::
> > +     The name of the file which is recorded in the index.
> > +stage::
> > +     The stage of the file which is recorded in the index.
> > +eolinfo:index::
> > +eolinfo:worktree::
> > +     The <eolinfo> (see the description of the `--eol` option) of
> > +     the contents in the index or in the worktree for the path.
> > +eolattr::
> > +     The <eolattr> (see the description of the `--eol` option)
> > +     that applies to the path.
>
> This may be a matter of taste, looking at the eol-stuff:
> Should the ':' be dropped and we have 3 fieldnames like this:
>
> eolindex
> eolworktree
> eolattr
>

Let's see the document of --eol in git-ls-files.txt:

--eol::
     Show <eolinfo> and <eolattr> of files.
     <eolinfo> is the file content identification used by Git when
     the "text" attribute is "auto" (or not set and core.autocrlf is not fa=
lse).
     <eolinfo> is either "-text", "none", "lf", "crlf", "mixed" or "".

There mentioned eolinfo and eolattr many times, so let's keep it.

> > +test_expect_success 'git ls-files --format eolinfo:index' '
> > +     cat >expect <<-\EOF &&
> > +     lf
> > +     lf
> > +     EOF
> > +     git ls-files --format=3D"%(eolinfo:index)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format eolinfo:worktree' '
> > +     cat >expect <<-\EOF &&
> > +     lf
> > +     lf
> > +     EOF
> > +     git ls-files --format=3D"%(eolinfo:worktree)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format eolattr' '
> > +     printf "\n\n" >expect &&
> > +     git ls-files --format=3D"%(eolattr)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
>
> What exactly should this testcases test ?
> Does it make sense to set up a combination of index, worktree, attr,
> which are happening in real live ?
>
> There are some tests in t0025, t0027 and t0028 that do more
> realistic tests of different combinations.
>
>

Origin test is not good, But now I decide use Avar's patch version:

-test_expect_success 'git ls-files --format eolattr' '
-       printf "\n\n" >expect &&
-       git ls-files --format=3D"%(eolattr)" >actual &&
+HT=3D'   '
+WS=3D'    '
+test_expect_success 'git ls-files --format v.s. --eol' '
+       git ls-files --eol >expect 2>err &&
+       test_must_be_empty err &&
+       git ls-files
--format=3D"i/%(eolinfo:index)${WS}w/%(eolinfo:worktree)${WS}attr/${WS}${WS=
}${WS}${WS}
${HT}%(path)" >actual 2>err &&
+       test_must_be_empty err &&
        test_cmp expect actual

it can compare the output of git ls-files --format with git ls-files --eol.

Thanks for review!

ZheNing Hu
