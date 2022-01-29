Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD4C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiA2SPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiA2SPW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:15:22 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B51FC061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:15:22 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c10so28114336ybb.2
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u2+BLP+XdQZ+CGQaRiKtfH6AdmcgeuT4A1h1wpWS1Qo=;
        b=df5FOG/Twv0M5A4z/oGbqi342Q2PF8ESKcOIkIOHvu0Cuu4GLDKBJpw1a3IcOtjTE9
         BakR618CoXCaVRxU9zOFfpRHGNM/rLZc82bRIMLoBRw1+5ggRR2ayTRu2DYHeNsFzvaW
         LZxKQPHP/m+L362YTMqdXZdeAHdPgdFriq360ZtdUMk/t9Tiz7YnKO5HpZeGxEy5u66V
         50gj35nSn2LLdxi41ZSsUCcJkZdK1iXuPY9Pd/5Pge5Zg6GmnAd+jtCSP4owj85HqeMn
         bb0NfgB/bKJ0mm22yPD0c4hjiTv9+HFawczjTI91Iq9/Zkq8UahajKTb2EWt36W/UXN2
         oUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u2+BLP+XdQZ+CGQaRiKtfH6AdmcgeuT4A1h1wpWS1Qo=;
        b=VfKCLtrDPaDzdrcKJPoRmTC4JaEdmCTu7Jq9pZPjDrBUdDQRpP8ok+H9hTveDuYjCC
         OetnlDxsHvvoSVWSRn9g+HiKrr0dMfsXuhzleFIyfOGhpHNpAXFWp4xxbI5GSTFNH68V
         U4vEpKotk6w8B+quKPjMHIhzGiCSTiS7OhE3YVUr3FEGs7exfRy3i82QpBwwzAkb/QWW
         0fzNR0tXOC/iXPIsLT38FjB27YQ+8VtXRLRY8uYI9FKUMoI1WWib7ArX5nQNZUOtkL8r
         /oad50BQklJvWBb+21c8z/MleOFLiiJh+1G3uPahVGHFQPJ5Sy2qVeiOfsATIq41SJMy
         3c0Q==
X-Gm-Message-State: AOAM533t2NOsiRZRONU+JzyLmGlIJNaqPKHC5KowXQgeDPGl/BfHzKTR
        3LTcfoZaEKtjmczObOxPB8TKNKeuvjEAM8nFlffut36STQs=
X-Google-Smtp-Source: ABdhPJyWsmheH//Pkwc/4W6RQae3bY3mN2UA3iKVQaPedAfveLNd1j8wIdfpAEbEuVIe/oKlOhq3R9k8e006SdmRsu4=
X-Received: by 2002:a25:6ed4:: with SMTP id j203mr21994012ybc.415.1643480120874;
 Sat, 29 Jan 2022 10:15:20 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 29 Jan 2022 19:15:09 +0100
Message-ID: <CAP8UFD2ykVTjJ-WOTq8RVvnnRBztrTeKexkrqjseYPuShWWE6Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 83
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Sean Allred <allred.sean@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-83.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/534

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Monday
January 31st in the evening.

Thanks,
Christian.
