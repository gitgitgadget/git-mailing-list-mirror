Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208DC433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618AF2076C
	for <git@archiver.kernel.org>; Sun, 24 May 2020 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEZhWCMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgEXVTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbgEXVTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 17:19:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6EC061A0E
        for <git@vger.kernel.org>; Sun, 24 May 2020 14:19:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r2so4581558ila.4
        for <git@vger.kernel.org>; Sun, 24 May 2020 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ApR268sDB2cjCJYBQqmM4dD1Skifvz4ueKI+yw4HR+8=;
        b=aEZhWCMUsNoxaSVAQsqGbSQ/jHalmb3z8Dq7wKoVU0xU8N9j4eERR7EcAKIA7h0BRF
         42iVGByFX7bHuVliXabZ4BFc41IqZsunYTJnbTA0grxcuPCFY1u5lROvK2bHnBI0B7tV
         ZR1uf6gGqylta9gf7Ag68F/qLLHtRVS8pcHeAffkRsPWL3NFd6+3T8V/trPzkkQTdSMz
         PTXH4baXRvofK8RiIYtevlv3219trTikmLj+4F3o3QyeJavVI92yXbAheHyg6GIR+Sp7
         iy7mzXM1+eCJXb2miWCGFD1kVO83YVQfbcp6fGJilGMUOPYOgW1Ka6Ht11R2Ltq7S9u3
         a8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ApR268sDB2cjCJYBQqmM4dD1Skifvz4ueKI+yw4HR+8=;
        b=Vt2VRe+AN3Y8XUbOAFs5ZWfIf/eDjvoYxR6EzuPacYsYpxNH0D6bjRRICsqmWSN0Ss
         wsfQxcVj/YjKcSYlxmhc6sKizQN2U4j2C09OfYnP9Q6nQCEvSXIK6zwgeq01nU7rSael
         WJQH1lzZwxvWJbDpxoN8AtrPsPhHKeyLdL8/aOcdf/4dkKeqYN2VDKL/CNBGdWf3sTfp
         jOGY1Ts7qhuCxQsh01m1iQYHYTaffSY5aMHJMnAB53tgdyv/zTsR2eE/yxkA0kkUQVAU
         zWSMVviXbilw0FFNPr8Cayu7comy+7ZHa6ml/HLOuXCX4lKOdjm2iV/zoQSW2St8ma/f
         MA3Q==
X-Gm-Message-State: AOAM531YwJL05mMZSrIjAR9xjCrn3ba2pm2dGTAsjEm7T/vKQW8quCFw
        7xU8/HiwUpQhphIZ03T4An1qBqySGLpWO1e4cXDBl/Bj
X-Google-Smtp-Source: ABdhPJwXDDL569qIoQbN/BAGGtnA1lxUMqdOB7Af+31M59ca4C/pO9VyL1qZ92vY4YwlYIHi+V7CFoyrM2ffea7v6ZI=
X-Received: by 2002:a92:d98a:: with SMTP id r10mr20928369iln.127.1590355193727;
 Sun, 24 May 2020 14:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200423070704.39872-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sun, 24 May 2020 23:19:42 +0200
Message-ID: <CAN7CjDD1v+0Rxc-+r=8zusknTgkfR=5ese8cXmWVsoXxt3A9Fw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Finish converting git bisect to C part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El s=C3=A1b., 23 may. 2020 a las 0:09, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Thu, 23 Apr 2020, Miriam Rubio wrote:
>
> > These patches correspond to a second part of patch series
> > of Outreachy project "Finish converting `git bisect` from shell to C"
> > started by Pranit Bauva and Tanushree Tumane
> > (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> > continued by me.
> >
> > These patch series emails were generated from:
> > https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v3.
> >
> > I would like to thank Junio Hamano for reviewing this patch series and
> > Christian Couder for his help.
> >
> > --- Changes since v2 Finish converting git bisect to C part 2 patch ser=
ies ---
>
> Thank you for this detailed summary!
>
> I reviewed the patches in their entirety, and left a couple of
> suggestions, some of them minor.
>
Thank you very much for reviewing.

> Hopefully you find them helpful!
Of course! :)

I hope I can send the next version soon.

Best,
Miriam
>
> Ciao,
> Dscho
>
> >
> > General changes
> > ---------------
> >
> > * Rebase on master branch: efe3874640 (Sync with v2.26.1, 2020-04-13)
> >
> > Specific changes
> > ----------------
> >
> > [1/12] bisect--helper: fix `cmd_*()` function switch default return
> >
> > * Use `BUG()` instead of `return error()` in default switch.
> >
> > --
> >
> > [2/12] bisect--helper: use '-res' in 'cmd_bisect__helper' return
> >
> > * New patch: use '-res' instead of 'abs(res)'.
> >
> > --
> >
> > [3/12] bisect--helper: introduce new `write_in_file()` function
> >
> > * Rename input parameter `filepath` to `path`.
> > * Change `error_errno()` to `error()` in mode checking.
> > * Change error message when file cannot be opened.
> > * Add `fclose()` before error return.
> >
> > --
> >
> > [4/12] bisect--helper: reimplement `bisect_autostart` shell function in=
 C
> >
> > * Reorder patch before `reimplement `bisect_next` and `bisect_auto_next=
`
> > shell functions in C` to use `bisect_autostart()` function in
> > `bisect_append_log_quoted()`.
> >
> > --
> > `
> > [5/12] bisect--helper: reimplement `bisect_next` and `bisect_auto_next`=
 shell
> > functions in C
> >
> > * Amend commit message.
> > * Add `clear_commit_marks()` at the end of bisect_next_all() and remove=
 it from
> > `bisect_rev_setup()`.
> > * Fix if condition.
> > * Add `bisect_autostart()` in `bisect_append_log_quoted()`.
> > * Check `git_path_bisect_head()` with `file_exist()` instead of
> > `is_empty_or_missing_file()`.
> > * Fix return with BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.
> > * Add conversion in `cmd_*()` to BISECT_OK when return is
> > BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.
> >
> > * Note to previous reviewer: suggestion to change `bisect_auto_next()` =
function
> > to return void cannot be done because errors from `bisect_next()` are n=
ot
> > ignored.
> >
> > --
> >
> > [5/12] bisect--helper: reimplement `bisect_state` & `bisect_head` shell
> > functions in C
> >
> > * Check `git_path_bisect_head()` with `file_exist()` instead of
> > `is_empty_or_missing_file()`.
> >
> > --
> >
> > Miriam Rubio (3):
> >   bisect--helper: fix `cmd_*()` function switch default return
> >   bisect--helper: use '-res' in 'cmd_bisect__helper' return
> >   bisect--helper: introduce new `write_in_file()` function
> >
> > Pranit Bauva (9):
> >   bisect--helper: reimplement `bisect_autostart` shell function in C
> >   bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shel=
l
> >     functions in C
> >   bisect--helper: finish porting `bisect_start()` to C
> >   bisect--helper: retire `--bisect-clean-state` subcommand
> >   bisect--helper: retire `--next-all` subcommand
> >   bisect--helper: reimplement `bisect_state` & `bisect_head` shell
> >     functions in C
> >   bisect--helper: retire `--check-expected-revs` subcommand
> >   bisect--helper: retire `--write-terms` subcommand
> >   bisect--helper: retire `--bisect-autostart` subcommand
> >
> >  bisect.c                 |   8 +
> >  builtin/bisect--helper.c | 383 +++++++++++++++++++++++++++++++++------
> >  git-bisect.sh            | 145 +--------------
> >  3 files changed, 347 insertions(+), 189 deletions(-)
> >
> > --
> > 2.25.0
> >
> >
