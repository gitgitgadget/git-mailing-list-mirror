Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF4AC83F1C
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjH3S3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245739AbjH3QH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:07:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAB193
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:07:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500cefc3644so797691e87.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693411642; x=1694016442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=89Gy/A9o8dNKMD6Z4/baVc08wKQIS7a0WLppWENLhEk=;
        b=TxI53zWsGM2cbBvaOGlhul60PW9oIWjFHFjZgJmzPO5DpfUvfxqrNl1NHfUn1h1oTo
         Os+uoHuYuZwsAry4WXBWP/mVNJkn0+rVqCt7HEEVR0F4S9k9mMnnJUpr8fcumC2AzRD8
         w5YSADo/x294KAR0zX7G7wKshrFKqelfFVHBUXlqD5y5Zk2sSJVy95BQODPrWSoY35b9
         RYGHPh7tj5t4DbE+ZUAN5/BmiZBkE2a4rUqBHti39zGj3BEMWZxeNl0FIo6ZA0zJASCP
         8U3l8/CId6+hpkwwKFdFA90JZ2ttePbOKhhGOkC6gBVeSzX9OLnps2Tg6gG265KXtPyw
         G58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411642; x=1694016442;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89Gy/A9o8dNKMD6Z4/baVc08wKQIS7a0WLppWENLhEk=;
        b=GphSDO42WNekVOK6NxNPgU7bEqsqhllP4vaUYTNKu37QzuM4DOECt6wcC9k99bFZ9U
         iCW/jpoRbBoEza0oExJb/yfi5+2QpKswGWvsZZNPl6k2n1OmFgprMzDvWKuxAyag92Uy
         Xc5r1oW7TKlowSNPBEtGSvv2a4zJQY4+QnOcWfwHsiFX7n1Rma1ZirTQR/pgHyYkYzzB
         WLqp+L2eA2EbEnpooRtXVOMQzIMAzxSTjOyyFkTYlGaZfyDwgoDeSr1cKXE0JKtcqIRt
         jFpynA7vaEUs/m/uHQfA8MbsfpS8PQGmPWPsHThrn1g5Mw04MJ2kuM3QF1SkFZJTfYVF
         ljfw==
X-Gm-Message-State: AOJu0YwSn2QT0Nwz+idn3KlQuchIRm0W8+mhF6YMDv4pp9ExW9IW5jcL
        478dfvLrXXsldfgkH+I6fZMOO4u0niqfOjIMzCuW5dhF6vw=
X-Google-Smtp-Source: AGHT+IEPsK0bOkr5hBBcgriOz9iAmk41BbaldzYh6pQwQNT+CG1LmpafNH5Taq079wa7pEzd4un43iU+WTK0axZ27U8=
X-Received: by 2002:a19:5014:0:b0:4fd:faa5:64ed with SMTP id
 e20-20020a195014000000b004fdfaa564edmr1957926lfb.11.1693411642120; Wed, 30
 Aug 2023 09:07:22 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 30 Aug 2023 18:07:10 +0200
Message-ID: <CAP8UFD3SxGw+B3U8YpsJokVTn-u4HzzJMFK=C+EVWD-iBZaGvg@mail.gmail.com>
Subject: Draft of Git Rev News edition 102
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
        nick <nick@nicholasjohnson.ch>, Jason Pyeron <jpyeron@pdinc.us>,
        "Theodore Ts'o" <tytso@mit.edu>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-102.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/656

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on
Friday September 1st.

Thanks,
Christian.
