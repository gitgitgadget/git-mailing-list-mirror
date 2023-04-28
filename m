Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C6C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 20:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjD1U1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346347AbjD1U1L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 16:27:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF841FEA
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:27:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so227040a12.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682713628; x=1685305628;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFq6YQLcG/HEU5KQ+NwUgn4IITBDgJZVMEnFncXvF8A=;
        b=ruYUQORskxB+aA+Pj5dwTLpdNoemaW1bSke1Tzi4ykMU3Q/yvcqB7T4nMQwwKeOvzP
         06i5gTvhwqKfJTs7x63ABv1GP5zREM0ainHB7xw5kUFfqu/B35CRjWbqa/sgXBtYRR4T
         tZGAFX6ONN3Tu+fPaN9Krm45woN4Fg+Nbm925STiE8W8SZy1FJyjDxe0Y3qPKIco3Zyp
         KGw7eQ1/6Xol6x+nCbml/fBz56pfpwjP3ivZvbiMjTdUQGAdrla+fTGPoopv52uqvJpO
         /HphNsHtNYwE0KWLobqrvRFX1BSgQefCf7opQfF3phxueBC8Et++W4LwFdr5La7vTmvy
         UOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713628; x=1685305628;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFq6YQLcG/HEU5KQ+NwUgn4IITBDgJZVMEnFncXvF8A=;
        b=iroIb3EOYY/03+t6TrY61BDhbDzXs52vNbR9tu3/NP/uTqcX8gxAPOO4tY8BYZiNev
         hfWhDHd5zfKfu+V5zsPcWBRZkbT+t3mNd9nqYH98RDA41sz/gW2UqDJ18gVYmNw8W7iu
         wUQqsa1mJ4SYCxMnV5/mf6eyKFRzB+pVJxqSdmQWfd5OqsHRx7fgX3rLcWQ/MvFue7cn
         mZbyMjO5ISlNJnG30mVPuGsyVcgzoMzUaMgetpvI9FUUNGxOMwO94qlkXwW8iRvEixWX
         9WEpAyuYnM6ziwAhA980Zfp9PZpEgrQMHmIKeQLA5gHbvzLovxyLv9Y6MdwVySPEuRXP
         vc8w==
X-Gm-Message-State: AC+VfDzwM+OxluXP+zfz+N5C6dRqAgd5fGhs3edlrFn1KTK0Ad44HIKZ
        DNicZronfP4yiaKooFfFPdSR0q5hnsKvO2KyxxUKNYryNN84UQ==
X-Google-Smtp-Source: ACHHUZ4CNTEcwi4d3CTCw++6dn3BF6YBn/cFD5Ox2dpL8GcKxEyCmIFz9AD9iX2VwfIxZJ04deAI0vBsrVVbnItwWTE=
X-Received: by 2002:aa7:c3d9:0:b0:4fb:78a0:eabe with SMTP id
 l25-20020aa7c3d9000000b004fb78a0eabemr77661edr.14.1682713628439; Fri, 28 Apr
 2023 13:27:08 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 28 Apr 2023 22:26:55 +0200
Message-ID: <CAP8UFD3-8tvJpu=-=55Lfkty1pnafbcK0_i_9pahe7RkQYNMKw@mail.gmail.com>
Subject: Draft of Git Rev News edition 98
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Mathias Krause <minipli@grsecurity.net>,
        Stephane Odul <stephane@clumio.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-98.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/639

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Sunday
April 30th in the evening.

Thanks,
Christian.
