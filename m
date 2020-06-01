Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD8AC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E9A206A4
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4aZvqtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgFAHff (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgFAHff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 03:35:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B602FC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 00:35:34 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n123so4709268ybf.11
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=664V4ORxn5twmBOFc9YgKdEqX78qGXRHxXPy1xqoajY=;
        b=J4aZvqtSFDRK4Cjuxcb6aApUBuZr0tePbqC5dvfMvs4GpAhns02aknYPXlrF8dftqy
         VSK1zuBt31s3XXMTyU21uWy07lKz0PhUiZCyHjZdjnB0jda02kzjrtQppAI4nMihj7Oo
         Wc0ecM8QZ1ANrDwQJ6fzAvI3tgc1T0OSNG6wADa342PBIAkv1VeAvOA+NIkIm3qMjPuJ
         7G/jD17OhUs0rbeIDj3wmcY1ETIaiaObolko6wyBpUwTHDtYk8bvTPNJQhzUoM7TUPrV
         4W3KEIztvleWKoTuuLqehf8nWJK5RiQEgV16gw5Gh+2oPW+Cwgbs1vKJoF1ezZhhqXGv
         OyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=664V4ORxn5twmBOFc9YgKdEqX78qGXRHxXPy1xqoajY=;
        b=I3FKGdwkZGr0upKvc+1jcJ20RORiH4W5vEHzpFADm49BNyWdVquM9RpzAgzs/C+pka
         z+4ogkcR/70g8gcLr2Qym/grQUbMzF3w57vkNvruYefZIjMCG0XlDG5EH68GwEzrhNiA
         cuqyjIcl2OIjvnLd9JawhnWLa+U3MoYPEFAf5xo98Oa/gAnQQZyjT8fmZYgxKMl/bJAm
         1BXaVdhyAlWlpaFckA+H/jGHUp1F1veHPVng8a9f0c34UV/g4jGICOGUtHKWzIxYgWb9
         ifl9frq6dioiCgCOBvE4JXUVk1VvH0iKalWNaaKDj1LYH7BEdq7OsRjY77wS7wMNfGwe
         +tdg==
X-Gm-Message-State: AOAM530R1VmgBNedNL5ifVI13OvobW5pxDsi5N64omZGtPYW7RwlgOli
        3DgALfPScSDqzSDAOcHmGuh/74x61M6l5uDluBI=
X-Google-Smtp-Source: ABdhPJyp4juAFi1c3UfMDhjuXC7tLb8tqo1aBfMbwdPe3WrSHZtiELJZZsCV246pLAH/wXD+2dyQVKdyw3P7BNyeUOs=
X-Received: by 2002:a25:98c2:: with SMTP id m2mr11267688ybo.155.1590996933365;
 Mon, 01 Jun 2020 00:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200531051726.9793-1-worldhello.net@gmail.com> <xmqqy2p8ug1c.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2p8ug1c.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 1 Jun 2020 15:35:22 +0800
Message-ID: <CANYiYbH0DzFriPU3AUBfyvADc7OD8r_qjFVp0C2pSVfWk0Zw6Q@mail.gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.27.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Emir_Sar=C4=B1?= <bitigchi@me.com>,
        Jan Engelhardt <jengelh@inai.de>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=882:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Hi Junio,
> >
> > Please pull the following l10n updates for Git 2.27.0.
> >
> > The following changes since commit 2d5e9f31ac46017895ce6a183467037d29ce=
b9d3:
> >
> >   Git 2.27-rc2 (2020-05-26 09:38:13 -0700)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:git-l10n/git-po.git tags/l10n-2.27.0-rnd2
> >
> > for you to fetch changes up to cb26198ec6b3fa0bc58d210ea0338f4e972f9f50=
:
> >
> >   Merge branch 'master' of github.com:ruester/git-po-de (2020-05-30 11:=
26:53 +0800)
>
> Thanks.  Swapped GPG key recently?

My pgp key has expired on April 6th, so I generated a new one.  Which
is the best practice? Edit the old pgp key to extend the expiry time
or generate a new pgp key?

--
Jiang Xin
