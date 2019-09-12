Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E251F463
	for <e@80x24.org>; Thu, 12 Sep 2019 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfILREp (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 13:04:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38722 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfILREp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 13:04:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so3610402qta.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IImPGdee2SEiZKnc7PmSIzRxZp4A8FWAWiD6V7Uhzec=;
        b=CHfBIoiRl3SqsvVEKCqTlS5JBCXe7lICWgG3zI/+HgRGpuGvFAa3FWAYc3t2Y3ljbn
         VGjTeVBCgWdrHuR3pvyNBq0jfExJqV4vjEZeQ8ukIoNweCJsP1NxtReeGtS8Kx2AwoFu
         tokG8FwupzX2d7Ae4D++SmCbPAuSgkagZQ1JT+r7y1HvQa9UxOQpGmf6je26vcmGvKSI
         4GbXFwdWbh56OYpze939L4Qm62EpMkMi5m7Ch4AlKkccppXYdfWT+UpOoeHQejZ/dzES
         zpWhnUcwrk+mwGKI5c5VDofHphuBMerJPtGsQxXwLGvg78xyZcO58/z5KtV0thsXCBYf
         NOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IImPGdee2SEiZKnc7PmSIzRxZp4A8FWAWiD6V7Uhzec=;
        b=jLBp9yDvmQT0iDRaObqkbvP/RdSzm14WJKpIq4kCrxPrjldfCSCy8rfPmuf5kFRqba
         ehlCQy6EJgmfhuxIq3l1MYvvxSVBGlKfUgT9v9v6dpRkzth5TYkg5iFdKkXkXmbc5G2M
         X+s63fq12NXn+NiAg2t3TSOjEtnF9G0scM6wkx+G8aF1y84HCj2VL8mw1K4dHlOYeFlc
         8ZplUktxN527pJn0rreR2RRts2o/yYkApyA1jqFHkJ8qMnDh2pqibquPcY2uBSG9q2ks
         KBivtRCJwtnbmJUwAJvzrdhkrdgz/MmvgLHi+DDRfkClbN5g78wqNzqV2ngnGaeXD6QA
         7w4A==
X-Gm-Message-State: APjAAAXdqdz3CShhJiaKwVpWaiV8BcDjZJtRFiPmYjUqPt0tEyTax40N
        US0lYPolNlDFgg94e8yn+3bktA==
X-Google-Smtp-Source: APXvYqyaM4uSs3rgdzS0x2MZDaBVma5BGaXKaq8vetLHrcOUgeyK370nzu4nJ/99PAfTz0UpO+pp9Q==
X-Received: by 2002:aed:27c1:: with SMTP id m1mr42598887qtg.197.1568307418328;
        Thu, 12 Sep 2019 09:56:58 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:789e:7c92:c1c1:6938])
        by smtp.gmail.com with ESMTPSA id w126sm11321317qkd.68.2019.09.12.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 09:56:57 -0700 (PDT)
Date:   Thu, 12 Sep 2019 12:56:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] upload-pack commit graph segfault fix
Message-ID: <20190912165656.GA86882@syl.lan>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912144122.GA27815@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912144122.GA27815@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 10:41:22AM -0400, Jeff King wrote:
> Here's a re-roll of my "disable commit graph more gently" fix. Versus
> v1:

Thanks for sending a re-roll. I deployed this out to all of our servers
running git at GitHub, and it seems to be working fine.

For what it's worth, I don't have 'core.commitGraph' enabled on any of
those servers for now, but I'll turn it back on shortly.

>   - I've included a preparatory patch that speeds up
>     prepare_commit_graph(). It's not strictly related, but there's a
>     textual dependency. It could be easily spun off to its own series.
>
>   - a comment points out that the ordering of the "disable" check is
>     important
>
>   - disable_commit_graph() now works on a repository struct
>
>   - typo fixes in the test comments
>
>   [1/2]: commit-graph: bump DIE_ON_LOAD check to actual load-time
>   [2/2]: upload-pack: disable commit graph more gently for shallow traversal
>
>  commit-graph.c        | 18 +++++++++++++++---
>  commit-graph.h        |  6 ++++++
>  repository.h          |  3 +++
>  t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  upload-pack.c         |  2 +-
>  5 files changed, 63 insertions(+), 4 deletions(-)
>
> -Peff

Thanks,
Taylor
