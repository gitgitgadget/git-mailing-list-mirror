Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CFEECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 15:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiHaPcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiHaPcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 11:32:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC2C32CD
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 08:32:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-340f82c77baso195218027b3.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=rNG0YqdvxXCcGzjzo3LKuhX+iQN5YJAog+DecdtJQUY=;
        b=LR+bWUCrjjol0aoBfOrCd1cQNp346GHlZph8ofIiiO2x/40MFmzCTq6g3wK0pdAwiH
         viFz7aSHtfYi2mqIdhQ4yFO/j3BbUT8noQM41k1QHnfUZicgqZnLjE/O/QlKjXLHhIb5
         0KqdJ5sVwh0IlGc6BUWvwFwS5rqFkDX1275dvuSKseoBLZqQD9+NKsVVm699KLEICxLk
         u3NaxWaFYhj6XsuV6GAnn6/j26NTQ0FumlZ6x0vho8/Ttl5rezBR8Sg5NHNKkFuVefYV
         PSqxBC+RLsniCtsyIfpiNWbxt+X+zZ/20SZBLxH8zsvSZW+razKr26kcN8daZLACeGYX
         InaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=rNG0YqdvxXCcGzjzo3LKuhX+iQN5YJAog+DecdtJQUY=;
        b=PqoL8GmAXr7qBANVQeWdCANmBFoQ3GoryStuhG+MzyOETCtSxKU8pp6/Wss6bYZROO
         LvZQXkWOuHWA3FYA/+5Pc4TpyuIY4OLgYgOL/KOSLB+KrSu97KXVcfZjwN9uFtuQMcMo
         +495nrs4YNKjPsSPeEzJzuhgl+iWjOnNUP61kIFjDmCJTzd5gJjtTXUvkLn48wdY+3/w
         iRxmAv9eSEZIMErdmuG1X+OuLgebHSKhjD8xHoCo6eLRrnXdMHZH30AQHR/C3kwCVTSl
         hko/sIsOGeiTXCR5SVnB0UUZbBjj8PZFNgCUsNbzCxIjUyEG7UvcK5DX8HJIbQI7WEfV
         ccJw==
X-Gm-Message-State: ACgBeo3qqpBHIKvqzV9r88vNb0Gm2yLwkNY8jNCi5u8tE+zIi8lXiU+k
        PJK2470wzZzkUWg2qofip4IBVsI4G6TEyvAAYto9WBbxuBJAOg==
X-Google-Smtp-Source: AA6agR5m1ZAGDsbrBs4yYt9k+GKHslSnqmzhCxs/GJunuVdNMUlxJ3NP/BS6Zug6xKSqjUAo7RFlRpzPlvhUS6XUITs=
X-Received: by 2002:a0d:cc4f:0:b0:337:ef0:ad2b with SMTP id
 o76-20020a0dcc4f000000b003370ef0ad2bmr18759081ywd.365.1661959959203; Wed, 31
 Aug 2022 08:32:39 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Aug 2022 17:32:28 +0200
Message-ID: <CAP8UFD3CBrz4JzMqUO-56ucRTkonPh+TkJQhfxTaSbhi8EmFjw@mail.gmail.com>
Subject: Draft of Git Rev News edition 90
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-90.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/596

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on Friday
September 2nd. (Yeah this is very late, sorry.)

Thanks,
Christian.
