Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB8C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 21:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiITV7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiITV7D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 17:59:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C80A6B675
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:59:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y2so2736534qkl.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=IsiFaxX6q/Z1uEPmtqVyLEwZi23dewBjgyJ1ovOEWcY=;
        b=sd0IdYcW/KB7DJLPh2FChitXey67fjSAIOG1c33S64j1DPj6dqW67utVTzo0Xck1kC
         lO+mh2Pi3HgBquk6dYEs66bIT5DEzcwAdbsBnVBpK6ymdRu8oSQtda+xquWqqRGvB8TF
         35z85O89mkd8+gOTGP6WPnpNgv7b59twkwX/B9iNav+mBvT6sWMPzm674hXjfNUB4uSo
         BghhaOCUHI0b0INss1m1jr4FYy77YLLJQZVLg6Z9fTdB0vKz6tApq2CxTzLg78kM5/3w
         WB4yTflzV/vO+LJJiKxJeWucLHyogR8m7/k0UyGei1FiudR/pCCkCtUaN40ZKq8WjpnC
         MfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IsiFaxX6q/Z1uEPmtqVyLEwZi23dewBjgyJ1ovOEWcY=;
        b=ZmuS4Qyj7amWvIBmAcZnwGltVQRmbG6MuaDR3jD83aCCdt6Y0jHUROsZoG/TEPWzOj
         q5XYjlic5YrgCapfPaqoLtlUN2yylmCcAL18HBN/Io2UMJVefz0fXpQj3x6SB4T99ep8
         nHXhrzvq+PIlvA+9n46ITnm/dyzLnH/qKY0PDesfjQgUEu4eWaeh+Z2sAn1bh7fw46LX
         SWfCTE/L00mpBX5/8IpXP0+Rw4x7WWaYy8Bd2wVoQdTGE4nHc//Sr3rYTDRU158O5UT7
         low1y72GCv/p5PhwqSld0cG0JUlMVgzi7X+leNJu8eU9mQOdLv0d4nci0GHvI6GPEtlc
         g7zA==
X-Gm-Message-State: ACrzQf04/JCPgYi/hPK+B+11dOX4kv9zqWkSj1maJb9H+cm5xSYwrhrI
        7LiW1jLTREgh/fAFRtQe7giVrw==
X-Google-Smtp-Source: AMsMyM76tHkf0C1MZEI38NJfo+FakCZ9lPx3DK5bZF5qFt8UU5DKN48agfgsudQYQ5supBJFp/vL1g==
X-Received: by 2002:a05:620a:240d:b0:6ce:7f55:1191 with SMTP id d13-20020a05620a240d00b006ce7f551191mr17653553qkn.644.1663711142240;
        Tue, 20 Sep 2022 14:59:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t15-20020a37aa0f000000b006cbc6e1478csm577419qke.57.2022.09.20.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 14:59:01 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:59:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 0/5] [RFC] introduce Roaring bitmaps to Git
Message-ID: <Yyo3pMlGkw1TWLDQ@nand.local>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 05:47:34PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> This patch series is currently in RFC state and it aims to let Git use
> roaring bitmaps. As this is an RFC patch series (for now), the code are not
> fully accurate (i.e. some tests are failing). But it is backward-compatible
> (tests related to ewah bitmaps are passing). Some commit messages might need
> more explanation and some commits may need a split (specially the one that
> implement writing roaring bitmaps). Overall, the structure and code are near
> to ready to make the series a formal patch series.

Extremely exciting. Congratulations on all of your work so far. I'm
hopeful that you'll continue working on this after GSoC is over (for
those playing along at home, Abhradeep's coding period was extended by a
couple of weeks).

But even if you don't, this is a great artifact to leave around on the
list for somebody else who is interested in this area to pick up in the
future, and benefit from all of the work that you've done so far.

I am still working through my post-Git Merge backlog, but I'm looking
forward to reading these patches soon. I'm glad that other reviewers
have already started to dive in :-).

Well done!


Thanks,
Taylor
