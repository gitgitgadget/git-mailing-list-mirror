Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D66BC43217
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 14:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiKCO30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiKCO3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 10:29:10 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42969E7E
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 07:29:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id o13so1120314ilc.7
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CcnhIcidfjfwitD25omO5xoM2NjXFCORYjeL9vm7JdQ=;
        b=pBR2x0rTZ/UWCd+O8ejqpbcTQXE2bk4wj3Uu7m5duZ4uWRy+EPaoAgG1wXZdafutZo
         QbcQCR25w6OmiWtA2iT3AdVOVRT3DbvhvJytWHRSKKj9O4eLi9Py10SVAEdy/AoQp9LW
         YmEAwPLV15oh1cymVW7xsVZK8AsuzfIcVUlWjjA2trdtt3HsLMNkxn4GkQdDCmaZrq81
         uUjU0661TOWujP4CVL58OiO2sRcTXcbVQiEOvVebN5XA70G6P3U5p2R9Vq6mn2LNgbfC
         VQN5aeYd2Q1SL3OjwAQElh6VeeP3Mq6wJFg9wCXcbjnDfieEZVtAs0KwXb5873UAQckZ
         hiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcnhIcidfjfwitD25omO5xoM2NjXFCORYjeL9vm7JdQ=;
        b=3q6qE9Il9U5QzgxhG8UBYzob9rnpb+lmDsdqH6dxJm3AoR0TPZ7EZhco7zm49K4mHJ
         r3p15dYMPwU+4lqDaevZU0DKB84CTNkvmO3csbUxnw3tL8Ifm48tVbnWGeZ8y6RTTPSX
         pG1Ry1lI11Tv/1hxoH3Rh1PmTxJ8+aIqWt16NWrZ2Eg2mhW/h02oGMKTTVkGm0aC1RJa
         t3dIAh32plqx6XA9fLw3BvcJESrqsL9lqCU9BrQfysfGk5Oj9PuVlC4VHO+Ubp0n6H2H
         wS7Cg7DZC/JlkOf+OW0nA/pLiYaPMK2XX6DUMotLr1aohxWpo3QBV4V+IY5tNtwEBOMs
         M19Q==
X-Gm-Message-State: ACrzQf3h9acaynNb+M97D/9/RMGvehhXZgMgTUcVUtV2gxYpXLmzAQ+B
        YlRzzwPWQmK/jj4rftzvVME0q57JWH+ZSvV4mTA=
X-Google-Smtp-Source: AMsMyM6Wf/tBUrPZ1/uz4l1qYdYpfABkt+KvkpBxRrzOVosUv49MHYnu0T5KfvILXv4YfwjL667bwwZUdbGhSX9SvLc=
X-Received: by 2002:a92:d685:0:b0:2ff:9abf:de49 with SMTP id
 p5-20020a92d685000000b002ff9abfde49mr9619444iln.42.1667485747507; Thu, 03 Nov
 2022 07:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com> <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
 <Y2MEXyhh2cJ14ba9@nand.local>
In-Reply-To: <Y2MEXyhh2cJ14ba9@nand.local>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 3 Nov 2022 09:28:56 -0500
Message-ID: <CANaDLWK6-KkfKP0mipuWccfQFacDWsLHFNjS7ogL_xWvvmrCfQ@mail.gmail.com>
Subject: Re: [PATCH v2] status: long status advice adapted to recent capabilities
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> looking up an unknown configuration variable with 'man
> git-config' is easy enough.

I'm not strongly opinionated, but I believe the initial idea behind
redirecting them to the doc was because Git now comes with more
configuration abilities to improve performance of git status, that may
be more or less relevant depending on use cases, so there
isn't really a single git-config key for them to look up any more. Their
ideal solution could be core.untrackedCache=true, core.fsmonitor=true,
advice.statusUoption=false, status.showUntrackedFiles=false, or even
some combinations of those can be relevant.

From there, the goal I believe we were going for with this new doc
section is to let users know what configs exist for their git status
slowness pains and why, so they can then go look those configs up for
more details, which I agree would indeed be easy from there.

Again, I'm not strongly opinionated, and I hope I accurately represented
the inital thinking on this idea.

One slightly stronger opinion I have, is that if the advice message
was just

> It took %.2f seconds to enumerate untracked files.

and nothing else, I can definitely see a strong UX downside of not
giving a hint of next steps for users. Basically, "you have a problem,
and we're not helping you resolve it". Were you thinking more of
something like this?

> It took %.2f seconds to enumerate untracked files.
> Please look up the core.untrackedCache, core.fsmonitor
> advice.statusUoption, and status.showUntrackedFiles configs
> for potential solutions.

I'd say that's probably somewhat cryptic and a bit verbose (which is
what we were trying to avoid by telling them to go see the doc), but
we wouldn't be leaving the user stranded, so I can see how that would
work out ok.

I'm very interested in what you think.

Thanks,
