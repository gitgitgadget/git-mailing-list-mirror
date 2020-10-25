Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B40EC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 07:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10FF208B6
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 07:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR1lRV2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767634AbgJYHnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764543AbgJYHnw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 03:43:52 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9DC0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 00:43:52 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id l26so504821oop.9
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/BRdUoKfJHTJFSVhDz/GWQPzK/sm00kNxQmYIoP7b2A=;
        b=gR1lRV2jBGpwmSrXgFXi+gGET3cGVF4RcJiVBdd/+FtOqjKiNKirFxYAfN797Jozlo
         froylU2XMu2n1RYCZIL0Ub4Ll2suWXlgQzc4GRAUWuda4cJPgIdvdVgxazDkd4qqu82i
         udEoRyYOh1ns3wA6GbxYBs/hA8w2yQCG4FKsNHvEXt6zpxBJHhUaRfx6AOBiS+NLyXNQ
         TmodavLRZEEEmoUhnmPBokcbNUe82RL907Qse9Pk4n5SK24vOIgqluJtdBbOPTNo8phK
         ZsAtBziYsuiJBdKcUGQdAae4a1Ab8YQQMg3J/peosmA+t5cfLJHM9nukBwJH57zFkBes
         fpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/BRdUoKfJHTJFSVhDz/GWQPzK/sm00kNxQmYIoP7b2A=;
        b=Wr4u2rWRPfCF3FSRBaFFnaI+RORxZBREaQMLuDz1LKg39bVhhDHXEiMdbuaYSwoF6e
         HpmA4aSkgvfPBp/603pKVbXr4HKTBi+lI9LuXHu57ljr0lsvy9PffPjUmgQaRha335TR
         J5DIys0rQGP50JkK7dxlSDSBtPtr8IHGakGv7LH3G4BNTkWjPYTVoW3EoTKSNHtufTrm
         lFJ0uqxUNTGNFAu24T3vOWg2HXzbAisIFs5D2tTvhrYlsEuqOvoSsJQQJVpWY9QbX7NR
         E0TQiVq9iQJC+Gs0s2MXzLzdGUkNjFcB6K2VY5B86mJqCLSCC3Gb/8xfx1yirquPnqhe
         CQpg==
X-Gm-Message-State: AOAM533gwrr9KG/dZiVfPGvwl2q8eEdj+GsP33S86hitdqvRJXzTLfFy
        EzW20u6DSw7FUrYGS2JYEdQUaFgnow+FbrTjliXIi0AN8rbvVg==
X-Google-Smtp-Source: ABdhPJzs+/GGvgFTwu5d02tVxRcOycyJyLkz4IV1eW89JxadtTJ+3CQRlYHX6bGiTGYEVJG9qnTHGgeLQPHTzEjrFZM=
X-Received: by 2002:a4a:e09a:: with SMTP id w26mr8849933oos.18.1603611831681;
 Sun, 25 Oct 2020 00:43:51 -0700 (PDT)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 25 Oct 2020 13:13:40 +0530
Message-ID: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
Subject: [Outreachy]: Help for Outreachy Application
To:     git <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

It has been about more than two weeks, since I joined the mailing
list. Till now I have contributed to the microproject - "Modernize the
test script" [1] that is accepted by Junio. Also I would like to Thank
you all for the help and feedback on my first patch series. I learned a
lot about the git command itself, how to work in a community with the
mailing list and will try my best to get involved in the review
discussions.

I have read the Outreachy projects and am interested in the project
"Improve droping and rewording commits in Git interactive rebase". I
spent some time understanding the project and have gone through its
detailed explanation in the issue[2].

As mentioned that the first task is to implement --reword option in
'git commit'. Regarding this, I am unable to understand how it will
work upon rebase --autosquash?

and regarding the task to include --drop option. In issue[2] it's
clear to add this as an option in git revert but at the Outreachy page
in the Internship task section, it's mentioned to implement --drop
option in git reset. So, there is a bit of confusion regarding the
correct way to implement.

I also looked into archives of the mailing list and found the
patches[3] submitted by Philip for --reword option in git commit and
need some more pointers about its status and how to start with its
code ?
Also, in the issue[2] as commented by Phillip regarding the patches[4]
that implements reword. I would like to know if I can start with that
mentioned work, if available.

Thanks and Regards,
Charvi

[1] https://public-inbox.org/git/20201021124823.2217-1-charvi077@gmail.com/
[2] https://github.com/gitgitgadget/git/issues/259
[3]
https://public-inbox.org/git/pull.736.git.1600695050.gitgitgadget@gmail.com/
[4] https://github.com/phillipwood/git/commits/wip/rebase-amend
