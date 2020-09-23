Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3FFC4727D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DB92076B
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0InTls1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIWH1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWH1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:27:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8FBC061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:27:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a19so19857211ilq.10
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MSTvBX6OwuaM25X6z4/gDv1n3CbAWTVpJ+K1z8YwXZU=;
        b=F0InTls1BnpTz6e4ccEd4ORJz5Z9RKNyiW6sTyXi1EQKwJasgkMZiOl65/CmAL8M65
         2OXeXQlmj3Ir1am6PcteC4OcgHKli5fVRPkrzjybZvO6jFANbnAHzac9v0UxZowdTRg2
         nu9x7/h77QcIkuBMjfT2oPDqRnOxnGRqQSAaY7TRZam3kKIPEj6t9xs49DbtyHA7OmMa
         k9PrG5obDoR1fXtvXcaRTXdE/5wEEuymsKSE62udCZBPKJGWd+tYEJLFw97ydT3Quhjv
         lhznEJPj+H+ZvrmS5/d7fEGs8r+Ly1/d2a/npOV9TS0pJ2eVH3a1c2DbILMcBzQL32tE
         E3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MSTvBX6OwuaM25X6z4/gDv1n3CbAWTVpJ+K1z8YwXZU=;
        b=Wo+5gsbBAmZF0PXQw11IkI6QHIqkHRVxy4DjMTM+8G+EOEKRoxKtjqg3dlcn7loqxY
         /UaQMzwCNyDkkXMeqLmUHdVsmghez4hd1hBNpEdt9h2sQDRHx5at1/ZPam8Se3VmoOEG
         vAIc5pw1bjXH0HlKmuZIqNYY091mSmc5cwgQaCvnISrMjAXq1MGamNg+tGlyyk7WhQvi
         acjfg39O0xgFuG7amb/CpsRwORsPKZ5yoZg/zGC2+IQUpLmWm9Tg/V9unHPxhBVmIFbH
         LV9aMEgu033t6HMEQi0x/1mBbN4wUlvL6CeSILHovasF4iWx7CiqZ5j5gsHCpkKgbZUL
         bU+Q==
X-Gm-Message-State: AOAM5333oaI7WDXuYS8kqWQQexktrSDn8KWWnD9Q8MCq2EkUmMT5NqA+
        aJZzQaiTw3OitMnRkG3H7y59AkHr4hk85kB1zSPDcAlj
X-Google-Smtp-Source: ABdhPJzP0OAaWqmIbAvwMJbfj32JNMjnOngLGfoEaFjX9Qi0ZTzX+QblMkhn1Xrm3v9P++yZIH6mJbw4Y1/Jjbq5PaQ=
X-Received: by 2002:a92:9944:: with SMTP id p65mr4284487ili.127.1600846029382;
 Wed, 23 Sep 2020 00:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 23 Sep 2020 09:26:58 +0200
Message-ID: <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El jue., 3 sept. 2020 a las 22:29, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
>
> On Mon, 31 Aug 2020, Miriam Rubio wrote:
>
> > These patches correspond to a second part of patch series
> > of Outreachy project "Finish converting `git bisect` from shell to C"
> > started by Pranit Bauva and Tanushree Tumane
> > (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> > continued by me.
> >
> > These patch series emails were generated from:
> > https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v7.
>
> Excellent progress, and thank you for your patience and diligence working
> on this patch series. I think we are _really_ close to being ready for
> `next`.
>
Thank you for your comments and encouragement.
Applying some of your suggestions related to removing some 'eval' in
git-bisect shell script, a bug has appeared. It seems it is related to
a previous code merged before my internship.
Christian Couder will take over this fix, but in the meantime I will
send a subset of this part2, with the first six patches of this patch
series (and that are not affected by the problem) in order to move
them forward and be accepted, hopefully .
Best,
Miriam




> Thanks!
> Johannes
>
> >
> > I would like to thank Junio Hamano for reviewing this patch series.
> >
> > General changes
> > ---------------
> >
> > * Rebased on e9b77c84a0 (Tenth batch, 2020-08-24), to build on the
> >   strvec API (instead of argv_array) and adjust to the codebase
> >   after the "--first-parent" feature was added.
> >
> >
> > Specific changes
> > ----------------
> >
> > [1/13] bisect--helper: BUG() in cmd_*() on invalid subcommand
> >
> > * Amend commit message.
> > * Remove casting to int.
> >
> > ---
> >
> > [2/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
> >
> > * Amend commit message.
> >
> > ---
> >
> > [3/13] bisect--helper: introduce new `write_in_file()` function
> >
> > * Use saved_errno variable.
> >
> > ---
> >
> > [5/13] bisect--helper: reimplement `bisect_autostart` shell function in=
 C
> >
> > * Fix bug using empty_strvec instead of NULL in a `bisect_start()` call=
.
> >
> > ---
> >
> >
> > [6/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next`=
 shell
> >  functions in C
> >
> > * Remove unused `no-checkout` variable.
> > * Move a comment to more appropriate place.
> >
> > ---
> >
> > .iriam Rubio (4):
> >   bisect--helper: BUG() in cmd_*() on invalid subcommand
> >   bisect--helper: use '-res' in 'cmd_bisect__helper' return
> >   bisect--helper: introduce new `write_in_file()` function
> >   bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
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
> >  bisect.c                 |  13 +-
> >  builtin/bisect--helper.c | 442 ++++++++++++++++++++++++++++++++-------
> >  git-bisect.sh            | 145 +------------
> >  3 files changed, 380 insertions(+), 220 deletions(-)
> >
> > --
> > 2.25.0
> >
> >
