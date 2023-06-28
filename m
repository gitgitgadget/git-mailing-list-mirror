Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E3EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjF1UZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF1UZk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 16:25:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F475E72
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:25:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso103061e87.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983937; x=1690575937;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVZS8HR3n2MRmQfJQKoV5T3S4YCgPDDprG4YXpE/ldE=;
        b=mfgtVAkeglDt9kDXw1bKtmlSgeiE66o46wtgTSVG139fp6ycJ4BW8VYxuO0jElPvJY
         YeFmho65PfN/p9Xw7+kuc/EgmXqHru0D/ZEka69jPyor4991DdQvZ5fMdUAwwBeYZStP
         ctTWL1SbrjVHD5+eIwzzmqBFWsQinNSHcVRgTwHhL+crLjz5oTnvILUbVGRzFQS5CaHB
         Tb4T40F9rfCv7OzrOgZjJg9Tex1fAmQaq7F5aMU1OwbEtCAbXdOuNTXO6x13y3FFsaLw
         9OPUfm/NzPH8lrJSb4ydiZvNDL5g1ZhRfB2/SKqpK9ib7sb6+fBfsMhGWZPWuUWAWAg/
         mnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983937; x=1690575937;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVZS8HR3n2MRmQfJQKoV5T3S4YCgPDDprG4YXpE/ldE=;
        b=AlRhdrq7qjglvA1Gl48kAr1TnP85PB2lZ6wnFbM4ggtBruneWBRlYZiSoCvQf3FlMD
         i7ebOnFNdFsI35rYSEqLXcaJ5rFVz03UNYGl9whL7KTxRk3NbeSuIamfzkxB45rLCymP
         jsZcDcOEfM56spAUoUW4CXYWmYmJ0pf7g7Q8U8pYTsYtbDHuaxlnmAd/0lRoLNG4uUji
         tlRCXTHs/nyWr4HfyMsKSXypNYhE3zkiaj/Wgz3riP2bPlXrTCskbi8L8v6BBK640b9e
         p/AVmOdaYq2HS+dCywo89HatIb5g9pA9JAByybV3upi/U4Sv7SANWh0pBHh9LoyBC9jG
         D/lw==
X-Gm-Message-State: AC+VfDyVY7brOK9y1bIurcbWjFkkjz9oQEWLTWzm2iOP2N9nRV5EINoK
        1/PETcqLd5Mi5tPsNLfIJ+pgKfkyg2aqHhSe4PbcNoKJ9Bc=
X-Google-Smtp-Source: ACHHUZ5jDH75kR/C4J5x01vqVR4q5+Tpvv4kpk0MvSYNWWTOr6XFFYOBWSD+TwZ9BpMWv9UQog5d65RnGMPn3a3gwZk=
X-Received: by 2002:a19:4402:0:b0:4f9:5a61:194f with SMTP id
 r2-20020a194402000000b004f95a61194fmr13995398lfa.11.1687983936991; Wed, 28
 Jun 2023 13:25:36 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Jun 2023 22:25:25 +0200
Message-ID: <CAP8UFD0cDwFE-i16w0gabyVv9fUfxSUAznnK84wLdNzit_NopA@mail.gmail.com>
Subject: Draft of Git Rev News edition 100
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

(Before the usual announcement, just a last reminder that our Reader Survey
is only up until next Friday, June 30th, at:

https://survs.com/survey/jo07oxsaom

Thanks for taking a bit of time to help us improve Git Rev News!)

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-100.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/647

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on
Friday June 30th.

Thanks,
Christian.
