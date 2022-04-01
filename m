Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC1BC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiDAQln (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346190AbiDAQl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:41:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3323D674D2
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 09:22:18 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 9so3772603iou.5
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:subject:message-id:mime-version:content-disposition;
        bh=9RHhV7zIKbV3lCqWcAa3/vMZpCcfS5KGQD8ZCGdR9mE=;
        b=Z/9FxPa+B1X+JfjxknrDJMofgr0HSgd0YF2uyu2HvnmBeBtt6mYQxkUhvMPI5eJllK
         hpD4ew3eBKq3CQ9papj0BpKiKMCnoj0y+aPb5WX8fytHcy7sSiRDGoZW7EGek1aC59Zb
         k6p7qzXqHrTeM8lO5nCai3Gt3WuGCuqE+njSwGiJOW3cAL62ed/j9b4WfsmGWg3YKIxO
         ALGKX+ZjbzcAXRR8hZ0aSmUkLuY48uozggqikWpJSNLey1oInJUupI/7lqBM1EOoTxA/
         MUml2xhVlnaXmGgwoAziEO+HQ3PZoGpdoE7Zj0F4iRiCDjA/n+K1voji9/IA+eFqsEik
         T0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=9RHhV7zIKbV3lCqWcAa3/vMZpCcfS5KGQD8ZCGdR9mE=;
        b=NqhxaMJvKt+jRd6ZPMjg9QTyl3p4vpHTUNWcyD/sdN/mg39RRVjqIVbJqTrwWaiCU/
         NSwWMmDuPky2ssprAurdAFkLGXM9t87qLYsbrnmew6rxqs63VnW/yxu8ofPCg8oeqlj8
         Y3mUsaiTQe67pxbGj6CQnk0BLQ8Km0XRtfekulng4GELzxmVfjBdHtfjGgyKAze2LCAI
         oLXHAzOvKS49GMOz0Bbggs+lNWb7p+HHqI2d/1erfw27vdwxeWGydKxM8SNMFzzYx0cY
         0DubAC3L6Ubw6u16suSvNeYxIFAhwipRTIn3P0ux5v5WJgCLN2jLTOjTT9d0kHHYwoUO
         rfvw==
X-Gm-Message-State: AOAM532wuZ8Lgo5zOSxDShJmUFTn28e2gv9IcofZwQ/yuTPSOdUKdLqI
        ripem5Dj9I21e9Qoa71yWEihejza6VEdXGQXs+7ILq9ihr1XlmGxiMHNR/afqvzD9QgVwwJdK+I
        buQxxm8xRjQjycpjuC5eLBwUo0KTzex29A6YdiAJawlE981aBKOHnmrCjxjUQsRCt
X-Google-Smtp-Source: ABdhPJw8Qlf8D8qtoedY5zpMU5DQ/zKjB1/Luh89t9XNVZrWV3Tqa8vv0eAdz4MfFgswES35qgAlvg==
X-Received: by 2002:a02:93ca:0:b0:319:fca7:7364 with SMTP id z68-20020a0293ca000000b00319fca77364mr5869690jah.182.1648830137045;
        Fri, 01 Apr 2022 09:22:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f8-20020a056e02168800b002c654e0f592sm1600662ila.58.2022.04.01.09.22.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:22:16 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Fri, 1 Apr 2022 12:22:14 -0400
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-scm.com Heroku credits update
Message-ID: <YkcmtqcFaO7v1jW5@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As some of you know, we have a website at https://git-scm.com, which has
served as the Git project's de-facto homepage.

That site is hosted on Heroku, which has graciously provided the Git
project with hosting credits for many years. That, combined with support
from Cloudflare has meant that the maintenance cost for the site is
effectively $0.

Unfortunately, Heroku no longer provides free hosting credits to
organizations and open-source projects. I have been in an ongoing
support thread with them, and their stance is pretty clear.

To that end, we have a few options about what to do with the website in
the future:

  - Convert the Rails application into a static site that could be
    hosted elsewhere for free. The non-static portions of the site would
    have to become static in one way or another, and we'd have to come
    up with an alternative search mechanism to replace the existing one.

  - Explore ways to cheapen our Heroku bill (more on this later). Our
    footprint at Heroku currently is a dyno for the Rails site itself,
    along with a separate database (Postgres) and cache (Redis). We
    could explore eliminating the Rails-layer cache, and tune our
    Cloudflare settings to more aggressively cache parts of the website.

  - Pay Heroku using the Git project's funds held at Conservancy.

  - Find a cheaper Rails host.

Our Heroku bill varies slightly based on usage, but here's last month's
bill, which is more or less representative:

              | Usage (months)       | Cost $/mo |  Total
    ----------+----------------------+-----------+---------
    scheduler | 0.004941199999999998 | $25.00/mo |   $0.12
    web       | 1                    | $50.00/mo |  $50.00
    redis     | 1                    | $30.00/mo |  $30.00
    postgres  | 1                    | $50.00/mo |  $50.00
    ----------+----------------------+-----------+---------
                                                   $131.58

(I'm omitting about $1.46 of charges that come from spinning up dynos to
power "PR previews" when somebody makes a pull request to the
git/git-scm.com repository on GitHub).

I think we could reasonably get rid of the Rails-layer caching using
Redis and save some money there, but it may not be possible depending on
how much content Cloudflare is willing to keep warm in its cache.

In the meantime, Heroku is billing Git's account at Conservancy [1] in
order to keep the site running while we all figure out what to do next.
I have some opinions about what a sustainable solution looks like, but
I'll avoid sharing them just yet in order to avoid tainting the
discussion.

Thanks,
Taylor

[1]: I promised[2] an update on our financials, and am still working on
it. The Git project currently has about ~$70k USD in its account.
[2]: https://lore.kernel.org/git/Yg%2FsO63nhhtAXWvn@nand.local/
