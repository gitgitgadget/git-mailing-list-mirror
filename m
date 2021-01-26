Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC4C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 12:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE912311F
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 12:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbhAZMdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbhAZMc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 07:32:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9FBC0611C2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 04:32:17 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u25so22501321lfc.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTsghDDqHvmKYwJeS7YoD+SnXzbhxYQ1Z0VxvZZPUtk=;
        b=Rjlp1ckG8xXnu9yAbujmdg3u9LnEWteA3pNcWlyHMXWu3soc+3nrmPWFXrQ7KjXxLE
         lbI8KBLX0ZTOf11K9SLbVbpHn4djNumdAJ99sKBn+UtvpOBDaLy3HEMIl18uP+YNaocl
         mkKFgWLrWikZMQ6+SxHOkk9edxSU4/WRWfErwGlLdR12RrxfEIQj82tAItzkX+NOPXMk
         pDM4BEpPVePiYX39Pl42JVRdOWoPBUYwDMZNIjnUlJJ/8JEgOStBTZ89RhMnVznNZWnk
         HYl+OeJBQICtGJHwiXIb4RhWaXC/arQYJK+fUgEtN/exyxCp5peEqoRKvbhYpeNEFIQY
         lQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTsghDDqHvmKYwJeS7YoD+SnXzbhxYQ1Z0VxvZZPUtk=;
        b=RybSQ2y/1oAyIXriX2CvkF69AHsQZVmU8pHUghLfOsiw93/wTgSMrdK+r8HDHaax5f
         VELJ3YweViirGU6p+A/8U+1h6Ttkx4NoVztRi0+0NFYqQRQm9C3Mwj4fC6rpnGHDEYZ/
         Jzvtv6xQH6Uetn6Ag8takQABWXGsL7/NkNFcvWwfRBrc2tQVGEup67abkwng1jAUguX7
         e59/heGTkcjdje/vGxbzgYEBSZ8hB+gHPCIcV0ZkNNxu4uFHilBGiQijtPRAWLv5yNG8
         /9iyUyVSZnMdRgbYIwbk/zZMOGeIJoHo6jk8z0+gkrGS+bvyAlOMPhuGO/QTXD6yMkVu
         3qag==
X-Gm-Message-State: AOAM530ykAGYZNyLaZ2rkLtSZUzjm+7hiXHOI/+7OzFNney3qLPme5pI
        3jPaKuds/NgZ5865y5NApb5xM5rhgo46n7+u9xYXom1q8TiksHD6
X-Google-Smtp-Source: ABdhPJwOCB9rjMnSZ8zajhHd4VkUKHGNuG2B/i5QQMQqHy7y5fq9Pnxuq5CjNEn0+sXLTVnJ4HF/U/2qsky3spMxfBg=
X-Received: by 2002:a19:5052:: with SMTP id z18mr2642290lfj.554.1611664336181;
 Tue, 26 Jan 2021 04:32:16 -0800 (PST)
MIME-Version: 1.0
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
 <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
 <xmqqpn1w95dj.fsf@gitster.c.googlers.com> <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
 <xmqqh7n85qwd.fsf@gitster.c.googlers.com> <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2101251650150.57@tvgsbejvaqbjf.bet> <xmqqft2owjb9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft2owjb9.fsf@gitster.c.googlers.com>
From:   "Patricia B. C." <pati.camsky@gmail.com>
Date:   Tue, 26 Jan 2021 09:32:05 -0300
Message-ID: <CAK8LAYVp0XtdFbnVB6fzpje5a3RkU6+pFW81VpCFBPMe46m7fw@mail.gmail.com>
Subject: Re: RES: Can git change?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!
Thank you very much, guys, for the detailed explanation, I will bring
those points to the discussion topic :D
I do agree with you that we should prepare the students for "real
world" projects and not only working locally.
Hopefully, there will be more people who agree with me than people who
want to stick with the old fashioned way :)

Thanks again!
Patricia Camiansky.

Em seg., 25 de jan. de 2021 =C3=A0s 22:58, Junio C Hamano
<gitster@pobox.com> escreveu:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > And I have to admit that I am somewhat concerned about your students if
> > one of their instructors thinks that their education shouldn't prepare
> > them for more than working locally on their computers. Aren't they at a=
ll
> > interested in preparing the students for life after university? If so,
> > they will most certainly be affected by GitHub's decision.
>
> GitHub's decision will most affect projects that haven't started
> yet, simply because they won't have to incur any "transition" cost
> the existing projects may have to consider.  And given enough time,
> old projects die out and there will be more new projects than the
> projects we currently have, hopefully.
>
> Until that happens, they would be affected more by decision by the
> projects they interact with, as it is most convenient if your local
> name matches the name the upstream uses.  And the versions of Git
> way before people started talking about 'master' and 'main' have
> long been prepared for that, and we've been closing possible gaps in
> the recent versions.  "git clone" would notice what name the upstream
> uses and uses the same name locally.
>
> Even when they work locally, they'll start getting 'main' from their
> Git soon, and that would become consistent with the name that their
> "upstream" projects are likely to choose due to this "industry wide"
> push.
>
>
> > Any repository created on GitHub will have that branch name by default.
> > Likewise on Azure DevOps. I fully expect the other hosters to follow at
> > some stage, and also for `git init` to change the default in a future
> > version (I am working toward that goal).
> > ...
> > Maybe Git itself is not a good example for that. Bigger projects face
> > dramatically bigger challenges replacing the default branch name becaus=
e
> > of the short term disruption caused by it. Nevertheless, a growing numb=
er
> > of projects have already renamed their default branch, such as Snowpack
> > (https://github.com/snowpackjs/snowpack) and the react-refresh webpack
> > plugin (https://github.com/pmmmwh/react-refresh-webpack-plugin) but als=
o
> > bigger ones such as LLVM (https://github.com/llvm/llvm-project).
>
> Yes, thanks for giving Patricia and likeminded souls more usable
> ammunition than just us ;-)
