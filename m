Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14269C2D0C0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 00:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149020643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 00:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEnuVo0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLXAXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:23:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41375 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 19:23:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so16694433eds.8
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SOyoNSP3b8AedsTr0MbRGZIDeUGgMsLOE4tZinWSYM4=;
        b=rEnuVo0VUOqwIJY+ejPEqJxEVxGhNyH6fKTZM8TG+7I/YtbZUogQuaEoDyrVFDw9i+
         vDGI05+B8aGNqeMJMhk/bGI1nXMHumyK+wF1GBdXc31E+Iokqf3lObRCW+27Vbta1y45
         rV+QcPWEjyARvaDdTrZI1IOw5NPSnYcXRorWi7YbId9Ue0yHLvizLoKQMh9SZ2GSBG2G
         sA1XD/7E+QhSW/1rW2MMqrBL/gU6WmBEvZFgRsTYvC1wYzfWoKMQhWQmxMm1S46Ia/uR
         xunq0b3L1yxpt4ah2k93wVhLU/MpXsC3KWTARPVekExboQnNNAuBP498rLYsv9XexuuU
         54TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SOyoNSP3b8AedsTr0MbRGZIDeUGgMsLOE4tZinWSYM4=;
        b=NMiMg3rv2z4Uwb/gT6EV8vBJbWhpH8wIMZzUUjVU9vQJXwp3FYCUv4+mt6ybmlymsb
         cpNqgkFZrCdJIQJVq784j4+E3BMcPWfZnaX588zWdk0tYKaYdxNalWOxFw9K3YCcRiNS
         oiFo4I6VRbLSOCZGST2UrI7U7+IKbv5pmNSyf+7lq+x4MOShEc3gKIP4spTztQpl9yzT
         BJmeMdmxnXelf6SrmfX9rIk+KqsRiDnepE6aHkofbtbMcJuxF6z/pqtzvxutVZ0GUegs
         4LS1M9LDhV5vZG2/KfgjuQ+uwLebcpotJc8lxCX1dnmUOc8qs0fS+MUJzuD4o4oNKPaC
         SJ0g==
X-Gm-Message-State: APjAAAVCJQJCb9z9n4/fIojB75BeqGIZAAnHN5A+cprNbm11gsJLnkMB
        Rfl4RCd6FKPoYjUq+4Wvpnmm2YzjbwHP/b7+UctfZovtdSc=
X-Google-Smtp-Source: APXvYqwFMlsPdWTVGXB/TChs6xxVOq5C7QxRgh1qDQVBU0JhUDOxAOj8zYkIl9BUBA7hPlo4eqS40gHj8JUpwff/6Xk=
X-Received: by 2002:a17:906:7c47:: with SMTP id g7mr35233341ejp.281.1577146993911;
 Mon, 23 Dec 2019 16:23:13 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Dec 2019 01:23:02 +0100
Message-ID: <CAP8UFD0rQOa=iOA_4NwQDc33c6MMXvjh+bk8XQmgsWqWQ-xAbA@mail.gmail.com>
Subject: Draft of Git Rev News edition 58
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "Miriam R." <mirucam@gmail.com>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-58.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/408

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
December 25th in the evening.

Thanks,
Christian.
