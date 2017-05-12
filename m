Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBD4201A7
	for <e@80x24.org>; Fri, 12 May 2017 18:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756524AbdELSMi (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 14:12:38 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35899 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755818AbdELSMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 14:12:37 -0400
Received: by mail-ua0-f176.google.com with SMTP id j17so51216976uag.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QvFrTMQbTntY5uw+qCegCt8VTI67FLRbL+pNA1PXwnQ=;
        b=NnKZ5h1YqGyJxDzDsBZ76zB8Kuzc+e2NG6Ggeo2cu+MtLw+GeePU5g1AnC5LC/f8WP
         GoD+fUy97ueKQM9ZGMb01PLOq+bfhRPcnwY5GKw7OVkt2orpkyAE7QTgvjO7PxkKL3D0
         fZUyuw5KQxpRgbCpDBTI/SdSiunQ70dXlw2Sr4FZ0p4uYucpXW91ccfsNq9YoA53xuSx
         hnHCewXg/dCPwD85tDRHZZk1WIBg3pqH/H4Bxc/AXK4n9By42IgVN3IegR67LHifuww2
         0GPy468YOZQWqGKn60uFjgrqmqRjwVWjWT/JbTUtSXXqGp9ozPaQV4xK73Due49sC3YL
         M75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QvFrTMQbTntY5uw+qCegCt8VTI67FLRbL+pNA1PXwnQ=;
        b=BLk8AbiE9qqG3QspC3eLcCKJtW2QwCc9zO2j3ald4MlicjvPJ42njK120QaOBoCa5L
         AOeMds5MVH5VeXctIm2N+GWDgmvmTtFwtvUGCMp6p7ekBEKlxUVhjggHo2WGmDkrYO4s
         9fiGN+3FlZOPchqSGBsl9X81KhEr0CRqq8powMh+5kWJOCQkWwHp5+LDgGB62St+kVI/
         XWmhFK7GSdc2hHoKVg39x79geFqsuwNjhplGfClWUw3Toqzf2YO2IAX7z+7kVD6IaSSn
         6wOrXokO4TGPrA8+TiRJjWTxMOrv1GejvH/1SinCMFHzgUo3wl0Cpziavbus0onyXstT
         Ej5w==
X-Gm-Message-State: AODbwcBWRMprbnP/6OAo2wPY7CbnF0X5DDG+LFdEuwP4ervzTCAW5Qhj
        pXVH9uh6xrqVmoWP5Qajw8bQK0uiuhKC
X-Received: by 10.159.57.93 with SMTP id i29mr2838536uag.102.1494612756547;
 Fri, 12 May 2017 11:12:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.69.87 with HTTP; Fri, 12 May 2017 11:12:35 -0700 (PDT)
In-Reply-To: <20170512172657.GA98586@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com> <20170512162109.49752-1-paul@myitcv.io>
 <20170512172657.GA98586@google.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Fri, 12 May 2017 19:12:35 +0100
Message-ID: <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> How can I help diagnose what's going on here?

<snip>

> Welp that's a pretty terrible bug which stems from
> missing a check to see if a submodule is initialized, and not explicitly
> setting GIT_DIR=.git (theres cases where we don't want this but turns
> out we probably should do that here).  Let me know if this fixes the
> problem:

That's certainly fixed the fork explosion. Indeed seems to now work as
expected from my perspective...

And also answers the question that I was going to ask, namely whether
git ls-files --recurse-submodules should work on repos that do not contain
any submodules... to which I'd hoped the answer was "yes" (because as I
said it was a fatal error in v2.11.x, despite there being some output). The
behaviour I'm now seeing appears to affirm that, assuming it's as expected
from your perspective!

Thanks for the quick response.
