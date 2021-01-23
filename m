Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC537C433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6C3233FA
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbhAWPjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAWPjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:39:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F3C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:38:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id dj23so10000550edb.13
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Rs14XBuu/O0Uu50MYM+c1UOBTyv67TCtfMVcWRB8Tjw=;
        b=kJSa16IP9GFqHz4KHoaH+Jnxo1pOePzqIpWeudOv6fbJnldKXmfYnHkjBb/tj7L5ri
         +sjtDy2yiho/F3YB+l4RVN0TYndFsC1Ehtj0YdpxkTLEZYkK5xFImcPouhbtxj6xb4d5
         VRgU88014dg4ab5O+MOol6SBl3u0fb+jfElF6MedcIc4WvwyY/jryXRVbDTJVHN1DdoW
         +IWHDJ6+SPQi1og/k1spMpOcPW8qb42JtDOReOd7F6oKxLHDNaA8Y3OcrJtUzxIPW96s
         lICUvpcsL1V3yHHBHh1mf9/u4VozarcJT95tmtikS2bxSdhTZHGrqYBkJXq1MEyDF14/
         RcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Rs14XBuu/O0Uu50MYM+c1UOBTyv67TCtfMVcWRB8Tjw=;
        b=A/SWS3t0PGzYZoYekYStzRz4NLztTJZEJExO4bQPU6RV4T7oozNH82R6+wr3VOVvew
         4cXfEy0Sc3pCQ0vIZSVKO8+sYVmMagvewTdJTp55wEubf3iD9r/ltKwkjS272pnYAt0i
         KFO/wr1sNfQ3/1377DvljVTful4vV9+WVa+RnTj0Fkul5X3LZuKkiW/Lcci5K77rUEMO
         JJ2dloU3HAKZh+zrE87f5DKg6DkCOg7NwMKiWROtEjvcfhEk8GI7jzH74K9xILYIsPNg
         IfYLMAomE8q5ySD7rmSyWqPtMIAjWCTjh72NT1ljX2JZJvRoA2li1g584nEKIF/nMxyk
         HxUQ==
X-Gm-Message-State: AOAM531RCKY/n9JGMMe4xyiglJV0rx6Xhlthb9TXkFFmyjdrNBTck/A1
        e4sXcGK4GO0Y/KbqrlsUB3E=
X-Google-Smtp-Source: ABdhPJwQZGuA420YC/gqPZBHYSL7ee2HJKYw3lhH0L5VMy/4XiuzDDRgOXxkB8K35bNJeIcQc+SuqA==
X-Received: by 2002:aa7:d304:: with SMTP id p4mr192579edq.144.1611416312451;
        Sat, 23 Jan 2021 07:38:32 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id da26sm7350023edb.36.2021.01.23.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:38:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 01/17] doc: propose hooks managed by the config
References: <20201222000220.1491091-1-emilyshaffer@google.com>
 <20201222000220.1491091-2-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20201222000220.1491091-2-emilyshaffer@google.com>
Date:   Sat, 23 Jan 2021 16:38:31 +0100
Message-ID: <87mtwz7jew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 22 2020, Emily Shaffer wrote:

>     Since v4, addressed comments from Jonathan Tan about wording. However, I have
>     not addressed AEvar's comments or done a full re-review of this document.
>     I wanted to get the rest of the series out for initial review first.

As you note here and in a couple of other patch notes a lot of the
current state was based on my v4 commentary. I see we have parallel hook
execution by default now, woohoo!

I've been keeping an eye on this series, but have been kicking the can
down the road on reviewing it.

Skimming it now I think the state of it looks mostly good now when
viewing the end result, I think it's mainly got one big problem, but the
good news is that it's relatively easy to solve :)

Which is that I think it's really hard to follow along with it because
01/17 starts with a big design doc that's partially outdated, and
partially saying things that aren't in or should be in either a
user-facing doc or commit message.

And then individual patches (e.g. 12/17) either don't have tests
associated with them to test the feature they add, don't update/add
docs, or the docs are at the very beginning.

I think we should aim to mostly or entirely get rid of
Documentation/technical/config-based-hooks.txt, it was more of a "what
about this design?" document in the beginning.

In a series we'd apply most or all of it should really be in end-user
doc (and stuff like "Future work" can just be noted in commit messages
as we go along).

So long story short, I started trying to review this, but found myself
trying to reply to one patch and then grabbing docs from 01/17, or
(e.g. for the parallel stuff) not having tests and starting to come up
with them myself.

So I thought I'd send this E-Mail instead as prodding to maybe convince
you to re-roll it again to make it easier to follow along in a piecemeal
fashion.

As noted before I'm happy to help with this series if needed. I just
thought I'd send this first given that it's been a month since the last
submission, perhaps you've got some more local WIP changes by now...
