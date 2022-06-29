Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59342C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 06:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiF2GlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiF2GlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 02:41:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD75275E8
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 23:41:04 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p7so24792683ybm.7
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JlwebwwLwnneNpxBfbd7N68XHmgzat6ggowqI23yBqo=;
        b=gotF0VpddB8iUoKS0IGNwzhTwB2fzm5Wfxo4en1RYITLzHnZMp+z9pI0OEZBkXL9NM
         kkgUu/Sw4eCaJTMrgB9NAA7FRcmUXTfKlSEOIFYN8cpyfeDjVWAiBJEmxoyrhx8GH7F8
         ZwHG415YqZnAvzs02GwuIZjGrytiZEFqR8MVYJ4jYikxYvPUWkdoyoP8MFm59w//kX5l
         WhWMDDEsJGJYtgXIe1hqyBMiwQcUCOQNHcCRK7pUYnVdrE1tXfUYPRr8bTdGbF/zNiRq
         mSw0OCGabVPI4BU//eBTRwHWmY5dcr2bUqT6NCYaUzZFuGAvdqiAPnmqovuyh0HdgPHK
         /LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JlwebwwLwnneNpxBfbd7N68XHmgzat6ggowqI23yBqo=;
        b=i5k+A00Mv70BFLqiz++SfYiLrFsexLUAijdoqNNJsC/kxKW9OVPSWiA92SAjvePIXw
         x2Ku4Jpi51fSzHCXlwT0XN+bbWHoH5ohASWe8DA1D8rI0tCM4tyYe7RN5EKVX0INlRLx
         4bwjtg23MwHoGr2L+oHzSfWlMUu/M1hbom9+NlMmGIJ7zWowM5zHJWt+fOPIZyrgAeuX
         KkgNkT78615IlOg6SlJpIRNMOGD16O/HoG9dfMaBwU834IrSjanVTEJ2j8PXAwaXiMrh
         FnOg6bhC6uIxDNmMzZ1ua68sDpoPLGP0Bj/AuyhBVSZseYqCpzWzexsZeYil3BWkyS9D
         qp+A==
X-Gm-Message-State: AJIora+YdaKmVPQ5/SlMdbDLsx/wbxSDqNctcrm/cS4Zfac6PiKcMcQ3
        0BEsPvDffeyO0Tl8w6lwGkcCKbSlG+r6KsRk0BYr7Uo1X3E=
X-Google-Smtp-Source: AGRyM1tuWqZTaWOGTbhRu+5wCzZA5kT3VJj0Iq+4+F8538VCT58n1kgkHyh6MP3Dl4R1qltUnN6lTtkSUBgmcBb46pU=
X-Received: by 2002:a25:b9c7:0:b0:66c:e02d:9749 with SMTP id
 y7-20020a25b9c7000000b0066ce02d9749mr1797881ybj.494.1656484863156; Tue, 28
 Jun 2022 23:41:03 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Jun 2022 08:40:52 +0200
Message-ID: <CAP8UFD3N0rs+ba-gV6BNAebKbCMEYXhfcJy65vZSqv0=wJW+Ow@mail.gmail.com>
Subject: Draft of Git Rev News edition 88
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-88.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/582

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition very late on Thursday
June 30th.

Thanks,
Christian.
