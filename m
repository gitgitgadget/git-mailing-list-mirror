Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7377FC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33507650DF
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 14:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhCIOyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCIOyT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 09:54:19 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B514C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 06:54:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so28464060ejc.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CosRbipBS0yms7uQuieNS7RL607YSjtjAQHcxJ/Tbss=;
        b=rO7b9Ns4W3UkP1COgavBimbvTbfy3MVWpKJjJvrzpE4vCsn0D8mcC2oQfIr2t/eIRT
         h5PuUhbzq6doVY+HEvQOKdjXLSDdBbUpJxdAGd0rAwbH0BJ/28IIVxHEvAWHvGXPJ0jL
         9igwDoovtUYs+32uKGR00Rj+DzMXQ3cGry5Y7EqnZ3kydUveKk8dfvN45UbBGJjXLzVY
         fAVjwryCyklktS+GLdVfhAUlY4cugLebbfQv4d56mV6CgQ7y2eqKK1CyAB3bEqC/NEZu
         fqRaku4eVXR/5ipBc31EVcsDjnj9ojSHbGpold1f3ooYYd4oRwwFUC42kBULQrHWVip5
         +F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CosRbipBS0yms7uQuieNS7RL607YSjtjAQHcxJ/Tbss=;
        b=NOOWnq2e+Cij2QsX7ZYT/74kBdvewzL9C7PSo8qTEs7l1OcYAKip2dMXKF9TCdykd8
         eU8XQSqNB+F4oHzpap/eMrpTFnZojo97gUItqTW5wCJGX1rqGDXq7Nx4Bejdxo8J/QuZ
         V6GbtslGeJMOUdOB7LvbhbLX4MJOF+G0pKNIPcoECTqEg2ihraktOiPbDaSKB4E9DeZf
         GaarmpN/zkERVsJfzu53evAniNEeyoC4kUpjTQ3ajnD3DHay7phMsZndUwHJCO5aL7iX
         hWMDZfjuwAtbc9PXfWojYmdd7Sp9ljEOCs02BRWrp+M2NvwCiBW6dBnK7MHUqHwXJz6x
         eFYQ==
X-Gm-Message-State: AOAM5319yWifcAKNdO+1Bd4LQkjkShft1CGgoAyG4LOOZA2igNjB9BF+
        5BmLimtlKQYA3wwwHIDDoBrvFO1rWGWXqJh3YTI=
X-Google-Smtp-Source: ABdhPJw+QKTNwyC7z7TI2OeSCgoWn8RbX6ZYcfvv+HPOQCPeZMxelF1Wg14M9cpKaJt7oGan15ejvQbFpsGrwHcButo=
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr21551134eja.413.1615301657657;
 Tue, 09 Mar 2021 06:54:17 -0800 (PST)
MIME-Version: 1.0
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
 <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
 <xmqqpn1w95dj.fsf@gitster.c.googlers.com> <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
 <xmqqh7n85qwd.fsf@gitster.c.googlers.com> <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2101251650150.57@tvgsbejvaqbjf.bet> <xmqqft2owjb9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft2owjb9.fsf@gitster.c.googlers.com>
From:   Daniel Gruesso <daniel.gruesso@gmail.com>
Date:   Tue, 9 Mar 2021 09:54:06 -0500
Message-ID: <CAFdpPnBUuN0VJ7YBbpb04e-SCK4DXCJ_-CRxMOB=E8fKZZCmhw@mail.gmail.com>
Subject: Re: RES: Can git change?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Patricia B. C." <pati.camsky@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Any repository created on GitHub will have that branch name by default.
> Likewise on Azure DevOps. I fully expect the other hosters to follow at
> some stage, and also for `git init` to change the default in a future
> version (I am working toward that goal).

GitLab product person here, we are indeed planning to change this in
our next major release 14.0, shipping on 2021-05-22.

What is the tentative timeline for `git init` to change in default to
`main` in the Git project? It would go a long way for the git
community.


Thanks,


Daniel Gruesso
On Tue, Jan 26, 2021 at 5:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > And I have to admit that I am somewhat concerned about your students if
> > one of their instructors thinks that their education shouldn't prepare
> > them for more than working locally on their computers. Aren't they at all
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
> > dramatically bigger challenges replacing the default branch name because
> > of the short term disruption caused by it. Nevertheless, a growing number
> > of projects have already renamed their default branch, such as Snowpack
> > (https://github.com/snowpackjs/snowpack) and the react-refresh webpack
> > plugin (https://github.com/pmmmwh/react-refresh-webpack-plugin) but also
> > bigger ones such as LLVM (https://github.com/llvm/llvm-project).
>
> Yes, thanks for giving Patricia and likeminded souls more usable
> ammunition than just us ;-)
