Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A00C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47BC208B3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMOGdoLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgFPT2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgFPT2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:28:15 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC72C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:28:15 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id g129so12126275vsc.4
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZW3gbJmx7/8nzJUwNlQYaQhwC2jHS01KL3k1HTUHHxo=;
        b=pMOGdoLI5hfioDlPlo/0dnfXQOEuBuxuDMNJeJWXEYPtvhbiGo1rmvUepyqnu1+6wr
         Yxqmp/YLJQF2/41xpKjWSsBPe3eJUmcHzGnKLRKfdZ1Sa+/NmbWZz74ebdWroM/tREyy
         HA+IN5UX+tua9Txub2A/1we7ZR4Y8wGk5sy9pDRSFhvXAHrlyTnxIRsMmVRLrCmmVEio
         L2J/F4DFkLLxTqaRD860pNgtpxKxFZdXk6SIkDtOZOdYYvtmf3AmBEs8Vdda2ddz60cs
         zo1CZSxep4VlOqjg9OwLIzJfmPy+KDyuqDMuJpgwQQzYqXA1tjwWArgKQn28PK0Zl0Ze
         q/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZW3gbJmx7/8nzJUwNlQYaQhwC2jHS01KL3k1HTUHHxo=;
        b=mKyL7FuiSIhSA8h9KY0TvmeaD2UJMFJz28B5WEbLNP/I0ABgXEo589DqFsb9oS0vOa
         qe7bHc7DDa3XUTJ6FBec6LT1Hwkcs7JtRQsX3WWpUTXsFNnKm+Ef2Y7k3pHyT39VQTch
         gThUGUZPqdopbNpXa1zP3qC3V9RYnB8K/3p0iQOILawgSKio4uF3zD3iu0HWRyPYfCEX
         OFWxqzIwacx+5oumrzJI15sRPcI8W8av+dyAkmW8KPvXOh0W0s7DDV2jem3GGhRVt4f1
         f/GhC15urg9jkKYRqGFaJ7rLDC5TFMSOEf1yyUfdzC4K4gNAzxZl2rwbdMAcwTg1AE6u
         ngLA==
X-Gm-Message-State: AOAM5338+tvWGDUCkmxUdcRbkM/BXuTxV+SW7/ZC77enWZbSN3eX9Z0S
        SfCWsVLrdgQhKNtQpl+AFiMDOVhyai1EU/I0R2cPAOUDyyU=
X-Google-Smtp-Source: ABdhPJyzVbQiNkbahlRmdfi75W8X4zSJ+0DFFuWkZJhxicyDoEXy0iaypYBpW9LlbeyJ2rtHMCBuj93v9oG51Hwss48=
X-Received: by 2002:a67:b647:: with SMTP id e7mr2971269vsm.63.1592335694432;
 Tue, 16 Jun 2020 12:28:14 -0700 (PDT)
MIME-Version: 1.0
From:   Kaue Doretto Grecchi <kauedg@gmail.com>
Date:   Tue, 16 Jun 2020 16:28:03 -0300
Message-ID: <CAMWmj-w3Z4176kvNi3GQTfCSDBzMMay33ki4xmdPwC3sFqbdzA@mail.gmail.com>
Subject: git-for-windows supporting public shaming and repressing community's opinion
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently I've been blocked from the git-for-windows Github repository
because of this
(https://github.com/git-for-windows/git/issues/2674#issuecomment-643795833)
comment. At the same time the following user was not blocked and his
comment hasn't been marked "off-topic" until the issue was closed to
"only collaborators" due to the high rate of people disagreeing with
the motivations of the issue.

(https://github.com/git-for-windows/git/issues/2674#issuecomment-642049938)

> mlvzk 6 days ago
>
> Agreed. On a side note, GitHub should maintain a repository with a list of developers that still
> use the master/slave terminology. Perhaps that'd be enough of an incentive for some to change - > name and shame!
> We could also have an icon on their profile page that'd flag them as dangerous.

It is appalling that the repo's maintainers kept this comment and
allowed the user to continue interacting, while suppressing and
blocking users who were on-topic, having a civil, respectful
discussion but happened to disagree with the issue's author (dscho -
https://github.com/dscho) reasons.

I am sending this message in the git mailing list because the
git-for-windows project is very closely related to it and because I
wasn't even able to defend myself there.

I don't even want to be unblocked from that repo, as this is the way
things are done there. But all of you should know what's happening and
be aware that "community" doesn't mean what it once used to. Now it's
just "people who agree with PC reasons for doing stuff".
