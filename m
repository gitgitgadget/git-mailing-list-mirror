Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB8C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbiEKVcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiEKVcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 17:32:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29EF6D85C
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:31:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e3so3429870ios.6
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u9c6pTAui/cClBzyV7odrPOIjo4A2547V1IpNmsXh34=;
        b=0VLPGDCPkgkk1xkl33ZR9KeqsN1dRXuTnq7UzLTDYRgi2gW6EhjILrUo0VlT9pijKq
         S9KoCWYcNEx6XSXCu/S8ZYRWLCRC6R5zHKuIYyVNZa1TrrHPT43/8snV+lDOrzTwoO25
         FMESf2ZKLYMqs/n/iT4XxRt88d9Xepm3HVVvd0lumtUDlqu3W/1XFCCWhUsazPMmc/rs
         Go1lMwStEntrZhWC0phJWQlNbQt4TXQ6t5O8FghZUbkT6ZJhF0aSXdWxYJYbnaNPsg0J
         qQQzfH678Ei+JbbBbJxF8ehE/o7Msm+GUSJ9rC2xoQY835bkeeqz1o2MCldGwO4MFHcR
         ZREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9c6pTAui/cClBzyV7odrPOIjo4A2547V1IpNmsXh34=;
        b=Xd5/P5tlrmwRfCUtj9SaCVk8e4JYpYY4pGHxHFW7B7NZQTk970RUH753wCniOW8PEm
         aa+y+VFR40HxJso2Nv4q4+r4xYj+kt1st9a0KALDragYNfKHE17CmWlOFaRwx6WmGND7
         vPIBPAWfQ0Sk3T5xWbgJvzAOGXS5guOr1Z7+NlnvEwrqX1E8E/RqFgqIxvh75aZIfxwd
         OgQdGR/nk+mW0lF92wtTAc661Cmu0ZT14BsqC/Xq5by74YdZQhnSCfMJu3h8mi4E4Jwz
         oTofacPQ3YsJ8F/VXh2A7zEHlZj+ZLrrCq9UbUVxKQgxFw3LVq07yelDAklKCOmStmAJ
         VufQ==
X-Gm-Message-State: AOAM5322M/laYiewn/StMdJqh5GenFVvyfmovtt2jY4SAuZXLIpV8p//
        Dq1f0ZEr13Li9kSaq+qKaT19CA==
X-Google-Smtp-Source: ABdhPJw1mstFZ/nTTN2Hja6wpCsAgetPbonE+8+Dl3YyDWOi0i8L+3YgEO9kYPt9mM/gn+DsnW5IJA==
X-Received: by 2002:a02:c6af:0:b0:32a:f5f6:34bc with SMTP id o15-20020a02c6af000000b0032af5f634bcmr13864689jan.186.1652304719107;
        Wed, 11 May 2022 14:31:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l45-20020a026a2d000000b0032b3a78177fsm877392jac.67.2022.05.11.14.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:31:58 -0700 (PDT)
Date:   Wed, 11 May 2022 17:31:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/5] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Message-ID: <YnwrThYqiHYbyZgM@nand.local>
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <1fff3b3ca76d0b5e026270fdf746c55b582405d5.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fff3b3ca76d0b5e026270fdf746c55b582405d5.1650547400.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 09:26:37PM +0800, Teng Long wrote:
> although bitmap is essentially can be understood as a kind of index
> , let's define this name a little more accurate here.

The placement of this comma is a little odd, but otherwise the patch
looks good to me.

Thanks,
Taylor
