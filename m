Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbiBWRyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbiBWRyq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:54:46 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C0463A0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:54:18 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 195so15223950iou.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPsr3uFIk5yus+ZLCFdIhjFOvChqeUXqZyijjUznjfE=;
        b=ARDG0ZMdKr+sBY26KNd9w38tIxckGYYDL8OqR9i7vbGz4GuSqAeSJfXa4Srmn9katd
         g4pMnXGzEDRumzAiGe7ffw7BEZhfFsVrXK+17ONF6PfDVGO+BPBQQkbJZhTVylw5xk03
         NOO5QHxMXDAJbr/WVLWtY6wq33kYojdnbeUrI/iip9TPqXeQy5kUARtAqI7S0fTRkP2b
         gk4Q+lp0Tj4l4EiiPRnCNAmaRK2tn2HdFK4gnqXUZw9O0Ko9WldcOVyQFwGfa3kYUji4
         8+L1uAe8LvoQB86N/5JF7HeIeUbljMxYuPmXM4UZ+cEmW1UfZh4E/w4uQPZvye+PDz4+
         yvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPsr3uFIk5yus+ZLCFdIhjFOvChqeUXqZyijjUznjfE=;
        b=oFeSrkulCHbn9xB0aTeW7qcAO+3aqOMK/4y6heRFJJ4zPOZI5hYcPKBQnYUOOqy4GJ
         AoOsbOC1twnlnTE6hy2HdQyS+W3o9GC40DWVLRVh1LoAGKoTH37WJ4/TNoOWUna10KVX
         QuaFzTE2lux7KQbz41fKKWv071yjHCtqmPpbZJuzkfq/+jVQkqFu9HabHwybgIE5cS2j
         Y+3/eVQLqsvnTv/vyiL0r08qIdhppHkrqkRvr7zMo+ZzhXmzDjhFv10HOd1olv/YUxn1
         DZrJmv3nmIx5QgNRIn7ifZKHlOzaKZPwwOquUx+OxlNrCD2+vfoCv+mDaeHxUNL4vPva
         xL/g==
X-Gm-Message-State: AOAM533wBkv4a2RImvtZeHEkkfsApDr/fkJxSgihhE1T/ftGl6ZApVNC
        k2J1LDL4gyD4TOTsf41SjT0sZK288iY+nc6R
X-Google-Smtp-Source: ABdhPJyBUei7Agc8LFRofZ8PzbYqywl3/4hkLk2P2ciZpaqg0+Ow/teC0zyn+wCNva3JVTT83gFzNA==
X-Received: by 2002:a6b:ec15:0:b0:640:def4:c0bd with SMTP id c21-20020a6bec15000000b00640def4c0bdmr448688ioh.134.1645638857896;
        Wed, 23 Feb 2022 09:54:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11sm173067ilg.53.2022.02.23.09.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:54:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 12:54:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, avarab@gmail.com
Subject: Re: [PATCH v2 2/2] t0003: avoid pipes with Git on LHS
Message-ID: <YhZ0yXFIZNw/us6d@nand.local>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com>
 <20220223115347.3083-3-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220223115347.3083-3-shivam828787@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 05:23:47PM +0530, Shubham Mishra wrote:
>  t/t0003-attributes.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

This patch looks great to me, thanks!

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
