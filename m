Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C93C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 02:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AC7610A1
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 02:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhHSCIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 22:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhHSCIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 22:08:23 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECFC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 19:07:48 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so4335181ilm.11
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 19:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DO9ipCAJdEDoEWnAJuIfnGnZFGHGKXJVAOLNLK/2s8U=;
        b=rdhnFUPHv3vVK84QR/04MGnk0WZD1KTcpPr2IFfUJH7Mv5o9bECWg9+4b4tAmgIe5b
         UUQQ8nq0nyc67oN8MnIGnz3bwe7GwoP9INIe0bXvYlHwfJvjiwQP7k15kPGb4sexZz/9
         YSwG7yTzpkNyZVGf5ly/nwSWm0DRqKU7aWFO+WahOSlqFfEeAxtozexv35yPUXcXlJ0/
         nvNMygUU6E6brL3AQVQJNKnNTdUXmD9ODVrONl3RlXb4tVMZuQBSMf7MmJ8EwMMGXAaK
         Uzq7FKUMpwuMo9QOy2H+sr6iDZ6c7ChP4jndRmH+19MemTEaPcJMlnU+PQlROC52slEz
         jh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DO9ipCAJdEDoEWnAJuIfnGnZFGHGKXJVAOLNLK/2s8U=;
        b=q+jRQvL4PWACDcWO2d4qX6XY1folqKW5Fft70F3MEEAbLATaVthX7JSz8UlUDaanAj
         OMW/xcmHNwwnXNDjmoGHODlQHTeXihUrSOBqxL5Q5nkrHZLCmYdTl+P1wRa/js0zktTr
         k29DGd8VRbeJcpsic0Wy9bYngNCdK3/d+QWpnTyifU6HnRsrpOcRo8aAaoEX8kiezyxO
         yajO7SlE7baXmpZ5utumNlvOikwXnsIV/rGp9Z24OC6PG1jWA1jk7ZwoPylOAdBbIX7W
         eLCseZYc3BnorkGKqMksrM8PuhfKPrASOX0qY4fBpT4v+lDr8Dm5YrtLt86cCnbNrT52
         +2hA==
X-Gm-Message-State: AOAM531pPAGlfWQ2tx9/8bidrHtKyGTLl49GVl/HwYvfc4Q4W0Fra9Bl
        KcA2QhP4L81C+FWhZIAEnk1kdM5vE5oDnui0LUCSehwDipTkk+PY
X-Google-Smtp-Source: ABdhPJyTgdN13pjtiabm4lcD4yjcWtI1pSAa6ZUsyGUoZ0snAehKS+W0at2OmDDe3q54+3os0/qDWZkBBGinSuiKNW4=
X-Received: by 2002:a92:d282:: with SMTP id p2mr5970515ilp.259.1629338868066;
 Wed, 18 Aug 2021 19:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
 <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com> <dcccd4af-e8b1-31e2-f271-4161ec4853d0@gmail.com>
 <CAOLTT8T0A5_5sSxpJBSLgbbCWW61q6tVSesAAzf5SrhDxf1bcA@mail.gmail.com>
In-Reply-To: <CAOLTT8T0A5_5sSxpJBSLgbbCWW61q6tVSesAAzf5SrhDxf1bcA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 19 Aug 2021 10:07:23 +0800
Message-ID: <CAOLTT8QuL-yws77-N9j6Qu2r_1ALPiYasj+6EO_J0v0QcmcCmw@mail.gmail.com>
Subject: Re: [PATCH v5] [GSOC] cherry-pick: use better advice message
To:     phillip.wood@dunelm.org.uk
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=88=
18=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:51=E5=86=99=E9=81=93=EF=
=BC=9A
> >
> > Thanks for making the revert advice better as well
> >
>
> Thanks for reviewing too.
>
> > >               else
> > >                       advise(_("after resolving the conflicts, mark t=
he corrected paths\n"
> > >                                "with 'git add <paths>' or 'git rm <pa=
ths>'\n"
> >
> > I think this last else arm should probably be a bug now as anything
> > other than cherry-pick or revert should be setting GIT_CHERRY_PICK_HELP
> >

GIT_CHERRY_PICK_HELP should be set for other commands except
cherry-pick and revert.

> >         else
> >                 BUG("unexpected pick action in print_advice()");
> >
>
> Maybe you are right, If no one else will touch it, it may be
> reasonable to set it as BUG().
>

--
ZheNing
