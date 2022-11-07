Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80391C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiKGTxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKGTxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:53:33 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545520BEC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:53:33 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id l6so6421047ilq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vy2LLrg2ClMwTkiP1hdIg4EonULFvmlfbhLfs7qs+Yo=;
        b=0jj59rDR/g9AACfZrsVitXVx0V0CJ2jPEC2t/fn+kXhz9XHzCmFx365YClV5VHuE6t
         nfqOGBzS202rXLcRV0+BQXpqYVVTmTSDrlJkAfXW73lYxa+fUG5jA7TOAOPo4AWakoDz
         QPIIs+H0/bfuTemsWxXaXuvLh2aa15vyDbz00IjKHleHHXeMdLiFsjA9nAg3AchO8LMz
         fqr1Eft/srnXjhFH1r5UORuTK7O7WpAj/AdWaI8P7Qj7/nEhiO+7Be0nFaIujTZo030a
         J8elBmzH7XkHDZQsQNBwKdnb8CGaehOBUhpBYX7ypgi7OdmFGmWOJYtlltVBNHCeTnES
         muNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy2LLrg2ClMwTkiP1hdIg4EonULFvmlfbhLfs7qs+Yo=;
        b=oqSUI/OQbfNFMqZ1rH93ZKQrsf+XbJsMaSUFwtW4b/sfy6xCA7OqEYc7oSMfNGrYA2
         Tx5nyWjbze3ie7Y4WUO/y/gM92a/F5SK3bMFRAj2pwbXtHHUldB2CQ9qnQOROK7+HSHY
         0TgUrH2kTQscBZbSNlcgNXh9MMPHy2uosj3kpRC9C4SK4oixr88UvJnRXI3G18SqKyWQ
         gTrbTn3pkmc6E/o6v9b1WMEjv7r8V+TA2njNNNC11w8iM6FOvOEncTHAMBMfp3B+UbMZ
         hsJwgCirPYuq95Zztouy15pk7GmZEsVo4wvi2cUfq1F35AOO7D2GGtCcUi6XedRZKdxr
         Foiw==
X-Gm-Message-State: ACrzQf1cgLxaNRwxIJkMxExXH+uxnXNfn9218OKAXMZJXT/Sys/4QUIF
        wRw/966r5Ex7YS608K8HJidsZ3HlqsquEtBb
X-Google-Smtp-Source: AMsMyM5omazxuP5IfARP8+p2lYqhF2OuMjj+tGipYRuW1Jfh66tz94QnVI3drtx39Hg8QDfNGV57ZQ==
X-Received: by 2002:a92:2a03:0:b0:2fa:16e3:1833 with SMTP id r3-20020a922a03000000b002fa16e31833mr29960078ile.286.1667850812513;
        Mon, 07 Nov 2022 11:53:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a92d80b000000b002f139ba4135sm3045207ilm.86.2022.11.07.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:53:32 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:53:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2liOzOFLyz4uzd0@nand.local>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 02:45:24PM -0500, Derrick Stolee wrote:
> On 11/3/22 9:34 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Whenever a branch is pushed to a repository which has GitHub Actions
> > enabled, a bunch of new workflow runs are started.
> >
> > We sometimes see contributors push multiple branch updates in rapid
> > succession, which in conjunction with the impressive time swallowed by
> > even just a single CI build frequently leads to many queued-up runs.
> >
> > This is particularly problematic in the case of Pull Requests where a
> > single contributor can easily (inadvertently) prevent timely builds for
> > other contributors.
>
> As someone who is both the cause and the victim of this, I
> thank you for finding a way to reduce wasted CPU time. This
> patch looks good to me, though I'll need to trust the docs
> and your testing to be sure it will work. We will definitely
> see it in place as it merges into 'next' and 'main'.

I wonder how we should treat Ævar's concerns in this thread. I suspect
that the vast majority of workflows wouldn't be affected, but I don't
want to completely break Ævar's workflow, either ;-).

Some kind of configuration mechanism like I proposed might be nice.
Thoughts?

Thanks,
Taylor
