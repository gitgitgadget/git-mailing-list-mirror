Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37FC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 03:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjDFDeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 23:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFDeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 23:34:16 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75367D85
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 20:34:14 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id e12so27062097uaa.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680752054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96WFspE0HhXjFyB/6FnQvPUdU0xiTPkzL5hyF85J0NM=;
        b=Gm935+YWu8H0XyGD9qpwRShjz9KxbjlvxLFnrkafMpicNeTEDuokaxbIaMo+hj9Kc6
         YRWEeFbxId/GldMdvaulhcd1RC18Vp23s5ZhzXS5qAuFd8YkT2/eSgB50iLtnxzKXAJQ
         RcafenqxV3TzvKPAG0KRXQzbBfp4kiEaMEcK5oVD1W9+wqsVBrHgEC3NXSG0UsFYxJLL
         FiwWpz6Y8fUOQU1LDuZl8andIK1uRzhhEiZj1G9uBz+aaUeqcXTbLGFusuWv7sFAM/z2
         ehmTxfmTL4eq0X3dCojQYDeGiBVXSRIjbcaX8ewrqXLFU8HZir6Ec8j3kEMMXEkjzn5O
         l7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680752054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96WFspE0HhXjFyB/6FnQvPUdU0xiTPkzL5hyF85J0NM=;
        b=CAbV2yzPbc40fKXPHk0bCYkGSqkNEh/u8MGiuPBZpm09en5mefo+gfsuNypUktlrzf
         DAjAxPWEWNyZZMbtkSviTs/9nnv9ZP5NGBXAV54f0ZsVTTWnlGemoEwnvY9qTgz4ya2X
         hsSD8UMtRTnSkJkBHIr4/lPhsS+txsnw2ls3OElCfCN4KCffKRFos2oVj/rCC+b48sdq
         gP9BsdE5xfC6qq6/Sf09zCAcsbibnvKJ7wdKQgTeQz8N/wZSwHedd6MmNpIttPXp6fbB
         S/VK0/r2rSl5FDi9eLw91kYTlgjpYQSd0/Ib7EQvzoS4xfJ4DR4vaeWERU+5IohIUqWU
         reRg==
X-Gm-Message-State: AAQBX9cWZ4lrfT2Tg/qPob8zy7dwIBHPlVwGaLaug7RJtK9NHKGnHDd0
        Osjv/qtvFnP+0asOBcuBh0nIUrwkFtgx2CLukBnnmg4R
X-Google-Smtp-Source: AKy350aHd/6OWsMLkeScAFWr5G68GPH8i2JAJFeTtLupK5Zg5rnL4tGvA0/Rdy+szjgjQzUto/xIcEH+yx6PHea0xEE=
X-Received: by 2002:a1f:2997:0:b0:42d:7181:7c63 with SMTP id
 p145-20020a1f2997000000b0042d71817c63mr6290815vkp.1.1680752053874; Wed, 05
 Apr 2023 20:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
 <pull.1381.v4.git.1679153263217.gitgitgadget@gmail.com> <ZCvx/REMF69xkXJg@gmail.com>
 <CAPMMpohtL2dG_Ody5zALhS5kOuLLTTRw7L0vc6SnpWym+usppg@mail.gmail.com> <xmqq355fz8pe.fsf@gitster.g>
In-Reply-To: <xmqq355fz8pe.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Wed, 5 Apr 2023 20:33:37 -0700
Message-ID: <CAJDDKr53xaMyTVWOwBT=sjKuRf78SkNCcfdS99sRF3-CPV4=Lg@mail.gmail.com>
Subject: Re: [PATCH v4] mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 1:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > If you get it wrong, an inconvenient or even bad
> > thing happens: If you're in a GUI context and you forget to say
> > `--gui`, then you get the CLI tool - not the end of the world, you
> > might argue. If you're in a non-GUI context and you say `--gui`, you
> > get a (hopefully intelligible) error about not finding a display, or
> > worst case, you hang - and git doesn't know what happened, the
> > messaging has to assume you aborted explicitly.
>
> The worst case I can think of is if you have a machine that allows a
> persistent virtual graphical session (remote desktop).  You can go
> there, open a terminal and create a screen session, which captures
> the $DISPLAY in effect.  You may disconnect from the screen session
> before you disconnect from the remote desktop.  As the remote
> desktop is persistent, the $DISPLAY would be valid even after you
> disconnect from there.
>
> Then you ssh into the machine and connect to the screen session.  If
> you say "xterm &" in that screen session, a new window with a
> terminal will open and be shown on that remote display session,
> which you cannot see until you reconnect to the remote desktop.
> Running "git mergetool --gui" would be the same.
>
> With the proposed patch, the experience would become even worse in
> that scenario, I am afraid.  "git mergetool" (without "--[no-]gui")
> would detect the presense of $DISPLAY and start a GUI mergetool that
> you cannot view or interact with ;-).  You need to explicitly say
> "git mergetool --no-gui" in such a case to force use of cli tool.
>
> Even with that caveat, I think the proposed behaviour would be a net
> improvement.  I almost always work in non-GUI environment, but I can
> see many people work in both and depending on their environment wish
> to use the best tool for the situation.
>
> > If there were a way to get git to autoselect "--gui" by presence of
> > the DISPLAY, as it does for the *default* mergetool, then this kind of
> > flow would be much more intuitive, usable, etc.
> >
> > I'm not sure whether I'm explaining better, or just repeating myself,
> > so I'll stop here :)
>
> Hopefully your explanation was clear enough.  Others may be able to
> offer solution better than "look at DISPLAY and choose --[no-]gui
> when neither is given from the command line", but I think at least I
> understand your motivation behind this change.
>
> Thanks.

Thanks for the thorough explanation. With that in mind, this all
sounds good to me.
--=20
David
