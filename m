Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0AEC433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiI2PwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiI2PwL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 11:52:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D513571A
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 08:52:10 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-333a4a5d495so18585887b3.10
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ym3sccCN+F6GlV4Qlu/7kqkXhp9ms5no9JN0TAxEr60=;
        b=NjlBeArhU2Y7EnOOQHRnn8ykQbhZ0K2+d108N54e+wAWHrxsObmx0jV0STAoSNO6SM
         ffx/whQpVZkmj27sZ6bW8HS1xozTlSkj7Wo5qgwwCi7lMmKVRoooJFQ+b7bIkVo0P5C+
         CCCpQ1W4HxUHpNcT+hM32RGuS1QH7hS6/vfZj7Ze8Wyi9QB01QF1agLrWuIsbXtd6u4L
         DSDbm7/sYMFfKpvwfVC87TH4+mjYYAOIScvbrbBmG8Ii0IMOSjM5KFQWKjsW6x7js/pC
         EorL7+u1Rf5CNWUFShCsYcwA2QESQplvxuhr5KYcHw1pk/7yEKwzB4pg5S+4Wjr4lIHF
         smag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ym3sccCN+F6GlV4Qlu/7kqkXhp9ms5no9JN0TAxEr60=;
        b=6/EUZ9fnEXtuSh5PpRlvSRXgPHKAjAkhFimW0jlGV16BJMVGaGczYWVdZ2PtRrC1FT
         NygryvVECizBcLzSye/p3hOJTl9D/XQ3vqMdB8Lt1DagfNTljZgkZfbq9MVzavSVyfX6
         /DBvTx45C1FSmqQgPJz7Ljr97tLTrLlMnno/aqnTel35rgOjUl6KmMOpVQo9Vc8Kvl1n
         VLO49nwhnDd/o0qO6bN2Eo2e3ez59wHOKt5l+mSQ2YJC6rrTQ3LadseDki3OSo1yjW4b
         nff2cUR3cxK9DfteHt65YO9eTq9s6I2MdTHh7t/PqK9d12xhWI9pZlW/7qU7ZybI84Zd
         MwIw==
X-Gm-Message-State: ACrzQf0Ty3S4sOE3coMREDFhRf0nDp5g1bM9XkKatnbmRfWw0hxLRjbO
        pLWvmWX+lfDxUCL2atTJTU2rjZqIAqVfjnugAeoEICYPPBeWVQ==
X-Google-Smtp-Source: AMsMyM6/pXAkpguZHTTbKCw1ee6NZjbftcBkAckcAOHp0ft7j+ueeLxlTdq04e+oHHiQ06uQymamMxIytj9LkoBFl/M=
X-Received: by 2002:a0d:f886:0:b0:34d:3ea:1adc with SMTP id
 i128-20020a0df886000000b0034d03ea1adcmr4144769ywf.130.1664466729662; Thu, 29
 Sep 2022 08:52:09 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Sep 2022 17:51:58 +0200
Message-ID: <CAP8UFD2pG7f5-9eywHE4ziz7OKLZ_A9AnNnQEQvdvOTYvsdP+A@mail.gmail.com>
Subject: Draft of Git Rev News edition 91
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-91.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/598

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday
October 1st.

Thanks,
Christian.
