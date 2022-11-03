Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AACC43219
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 01:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKCBVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 21:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiKCBVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 21:21:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938812745
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 18:21:10 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r81so252856iod.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asJZE4JiM4/qJBilF/C+wQOtAPJ+8yqVyimtht+Pjdw=;
        b=UTzNvFKKhqed94NQBRs5zA2w8uqdcmCGeIuXKbblNa543rzOC4yjct8rDI0FKEb0bN
         Jvnm2YbdN5zeKMpQ0SOGuoH35KT6LbuUpDmHIN/7l8S3/+XrcLsc/SvUfp1W0oFArF/R
         JtzShiZib38UWUhsteY8CPKTWBVvO2UHJ+a13Sw74DGIgMNgURnGY3StgzCwqjeM2CR6
         yDRuk5kk9GJ4ADGgFmaQ/2nLl0jru4BIS4kNaURWqBMhoYoqoiARuXebpz8yAyIltNCl
         1DtT0XlNsdIKxFYEKFdmBSUkPS00oxrPnkefkB0qGvKCEB4adwhO/hFu9wt+NtPXrvRL
         ds3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asJZE4JiM4/qJBilF/C+wQOtAPJ+8yqVyimtht+Pjdw=;
        b=K9nyY4CHc8YmVjhN9AkYCLVApoqLIuQSLLp63DLQdzvFkrIrs/Bm7HRWCNRPXY9ujR
         RYY7HZwiW4nrA00/8KS6eXrN3eO6nv3oTadi9V4hqk2D3a4kLe7ndPe0jCnpcj/BDUrE
         POIVHEbPjT960zW+w6CZxGqBvgz3WoodVT56STja2DEbSCeS9Qt//0i6+O8wNJ4zT23/
         UDexgdNvUW0W6w1lV8mLUXVWoar4S7Xd3La6Rr1vysgYv926UmzDYjmOjFHmQLtSPDz7
         xIQHi50xzoghUwhFLtUvCpt0+XExlfjYNsXSk7IoIh7fJRPp7F6NjYt1Sdk0SAWvcAgu
         AJ1A==
X-Gm-Message-State: ACrzQf1Hrvdlxb+OYPmkjuYLNLY3uWAuZ4Y3bKBsG19LDNvJUACKUZmP
        Oh2e7l1A6JF7KHOmkb8ztJD7OA==
X-Google-Smtp-Source: AMsMyM6h2Ry1P2N0oClWO7wUZvA24f1oGPpmRRDo8vtNYrhauCB8SqPRW2yq0jHh07Yff/oh7mHuiw==
X-Received: by 2002:a05:6638:19c6:b0:375:4b2f:4ea4 with SMTP id bi6-20020a05663819c600b003754b2f4ea4mr15787852jab.175.1667438466958;
        Wed, 02 Nov 2022 18:21:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m22-20020a026a56000000b003627dc2a94esm5304644jaf.96.2022.11.02.18.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:21:06 -0700 (PDT)
Date:   Wed, 2 Nov 2022 21:21:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net
Subject: Re: [PATCH v2 0/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2MXgVZx6rqGkMzM@nand.local>
References: <20220826070912.70274-1-dyroneteng@gmail.com>
 <cover.1667393419.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667393419.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 08:56:04PM +0800, Teng Long wrote:
>  pack-bitmap.c           | 12 ++++++++----
>  t/t5310-pack-bitmaps.sh | 11 ++++++++---
>  2 files changed, 16 insertions(+), 7 deletions(-)

This is based on a somewhat out-of-date version of the pack-bitmap.c
code which has changed quite a bit since Abhradeep Chakraborty worked on
it over the summer.

Resolving the merge conflicts during am wasn't too hard, and my rerere
cache should save me from having to do it again. But if you don't mind
rebasing on the tip of 'master' before sending the next round, that
would be appreciated.

Thanks.

Taylor
