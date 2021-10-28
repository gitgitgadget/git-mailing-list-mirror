Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E507C433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829CB60F38
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJ1TEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhJ1TEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:04:53 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0337C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 12:02:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t127so17720197ybf.13
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T10vAxdkhDgQ2L7GbruZdy1m9RYjATtcBZrJqCHQxUg=;
        b=Ob4vsf37Ut7J0mGu5o8SMBZSp8fkRViJxEwU/1kH9mXbsLLoE+tVb3WVxXI24S1OWc
         DFqrlhXn3ofzIhFbmzQI0CYH5nQ+tLhgMQCUnZwhnAu2/51RhqRbgDrCivUspkRs5dDo
         QlaHRTcE6LlMz0exJaXzyL0ulugsO1Cy7t3BCTH09dlaXeLNbcXTy9Q/+Geg64Mhopmv
         EAtSciAt/kN5QBoqUiscCtqjkaM+/pRsSDVCTfkEke5KA/9itQARoNDAf4B2cVKohr5B
         LkCngXmaC0ngzDepQEl1y/uaY5aA1IzfXpJCW8w8aZDbuaz4Hfg3GiPxTfm/3MV9d3aE
         ytBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T10vAxdkhDgQ2L7GbruZdy1m9RYjATtcBZrJqCHQxUg=;
        b=RGxRJSDJmm6G3/ix40xJ/3uYMWTNSaywm6zE5Oiinubz1F8XrCd2QPGldqAdOT9hOk
         zqugQnYx/flRR99Kw0hHbDjcUglm8WOPO+4IykPbqEwXA1vgn11nD9HJeTj/AZe+X7qt
         a8eXxyulc/977ahxeHVv5/DkGxTWqIrwVasmesS0K8jfcIXaRKgenUCYeUHXanmKCr1g
         GCh93qfJoNBr19H/rJqftYB+W9t8U03bE0mGUWqsPY8quF6p5XWdZnOxcjDXWARjrXNF
         Yq2x2P8JksnQ7Pspxchhk7tlCeGeatPN6KuNH//cqQUL8oOFNIddFnHZwbtaM5ugszVa
         PZEw==
X-Gm-Message-State: AOAM531Ah4ig+94p/f5BssknRRVgYI4NjNG8uNpd8w5+nry9LnmMOphu
        YB5KDyiMx1qKDay3a2wJOV4OYVmR4sBA97jIL7AR0bMwK6Y=
X-Google-Smtp-Source: ABdhPJzPz+4Xg8azProVtPry62rbvtVnEuoUekrhT5L+0yOkbvZJD0niDKznQacb3JUSbpD9s0KGFt9ckQX84juE7KU=
X-Received: by 2002:a25:d4d0:: with SMTP id m199mr6121640ybf.249.1635447744959;
 Thu, 28 Oct 2021 12:02:24 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Oct 2021 21:02:14 +0200
Message-ID: <CAP8UFD3DU9WLWydMRsSGL5Yi6Fv=dd37vJ9uikDEYwpzQ-H8Sg@mail.gmail.com>
Subject: Draft of Git Rev News edition 80
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        David Aguilar <davvid@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-80.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/524

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
October 30th in the evening or night.

Thanks,
Christian.
