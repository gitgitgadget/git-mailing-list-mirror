Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FEAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5658661994
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhI3Sgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbhI3Sgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 14:36:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A041CC06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 11:35:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207-20020a2503d8000000b005b6fc088578so4580847ybd.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rjINrGoO7qDbUje9iXOtpXLTVlxaQ7KDeCa1pjx64wg=;
        b=Tmkf92R3vQQ2uEYsdoqd+RhYIE3Vu5K1nBoDqYt3pyHJHBRHcGXl3P3z044TvcCvv7
         Egft1e9TX9ZAveAPMdROgm1u1YSwqFj1K1Oz4U6cmv+Pt2GLBL7Yli9c1MnBlI9mZ75O
         547At0Zvey0wkPEtZngt/xHmrOtJCDxLHzmtGxzdlutpls19CTfjYS/aEfboP19tsAg/
         r6Oi0mgJpiQAbXGusBhT59qdd6ouLp6x7IfxXx7HZ3zCWf3AOUoph8Wl83HrU7P5QZ88
         1+yz1x1Zn/33IRTKI7X+h9cxpdyaFx9lxjiywyC97j/3zyZXOxvSbEZ67AXV0zTaE6mt
         ZVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rjINrGoO7qDbUje9iXOtpXLTVlxaQ7KDeCa1pjx64wg=;
        b=GTeijzrge+8g6TBxbfahW6L9ymBkrWNj3s+zD5yUzAKa9mJgIw6wueSh4D+uCfxckZ
         TmrIlcra+gC66Es5d0UuvaJcAf1dE6HevJJakOgqNRnlB57ZJ0FCHbehmgd0BMEuiuTG
         bcHBD+WHzuHPch99R3uqtg/HlUuNdnGGQqAkb+y/pCkdZu8Sc3+Vs13otXfud3eRMPOC
         YGcliNxlDW4OwrKKsi/pw34ak1OpkA9L2IYKI+PdVYb5K8+rCCsP/A4jhvzmvxyh6R7A
         bAIQz2l5dLk4M77ZzbOfhmDu5jQ53f/w5KcLA3J4yP3et/PYGrS7nBdGAgn5+KP5Ld2h
         btfg==
X-Gm-Message-State: AOAM532R4i6g62yBzFOxHQcjn1E2wKiAi8WUBj1rjZDiirVizWxLL0MV
        fWOazTjY7EIddGI/P9PmNH/86mCWdMmpIA==
X-Google-Smtp-Source: ABdhPJzt56Ued1hHKWeqo1r1uEEsgwFi3nYTtJRaHUgfm6xdzFwMrVxvBd05yPOxy+sZBk1dhqsuRWhVWyswBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:1486:: with SMTP id
 128mr823647ybu.301.1633026902898; Thu, 30 Sep 2021 11:35:02 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:35:01 -0700
In-Reply-To: <kl6lmtnu7xle.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lk0ix9aju.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-2-chooglen@google.com> <e1447d0e-091d-c659-b702-c5b33fffdb59@sunshineco.com>
 <kl6lmtnu7xle.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> Because I took the time to scan backward through this test script, I 
>> understand that `core.commitGraph` is already `true` by the time this 
>> test is reached, thus the new test title is accurate (for now). However, 
>> it would be a bit easier to reason about this and make it more robust by 
>> having the test itself guarantee that it is set to `true` by invoking 
>> `git config core.commitGraph true`.

>> test_config() unsets the config variable when the test completes, so I'm 
>> wondering if its use is in fact desirable here. I ask because, from a 
>> quick scan through the file, it appears that many tests in this script 
>> assume that `core.commitGraph` is `true`, so it's not clear that 
>> unsetting it at the end of this test is a good idea in general.
>
> This is a good point. I made the original change in response to Taylor's
> comment, but I think we both didn't consider that this script assumes
> `core.commitGraph` is `true`. The rest of the tests pass, but only
> because the default value is true and I'd rather not have tests rely on
> a happy accident.

I said I would incorporate these suggestions, but I didn't propose what
changes I would actually make.

Given that each test depends on a global config value in the setup
phase, it might be simplest to read if we try to avoid anything that
touches that value. The easiest way to achieve this is to use git -c
core.commitGraph {true,false} for the {true,false} cases. Since there is
no -c equivalent for the unset case, I'll continue to use
test_unconfig() + test_when_finished() to temporarily unset the value.
