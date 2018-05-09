Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162AA1F42D
	for <e@80x24.org>; Wed,  9 May 2018 06:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933768AbeEIGlf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 02:41:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:33054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933608AbeEIGle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 02:41:34 -0400
Received: (qmail 15016 invoked by uid 109); 9 May 2018 06:41:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 May 2018 06:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11688 invoked by uid 111); 9 May 2018 06:41:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 May 2018 02:41:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2018 02:41:32 -0400
Date:   Wed, 9 May 2018 02:41:32 -0400
From:   Jeff King <peff@peff.net>
To:     Leslie Wang <qiwa@pensando.io>
Cc:     git@vger.kernel.org
Subject: Re: regarding fix on "git clone $there $here"
Message-ID: <20180509064131.GA26636@sigill.intra.peff.net>
References: <2F384E33-2101-4D90-986B-FAE2FC2AD7C5@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2F384E33-2101-4D90-986B-FAE2FC2AD7C5@pensando.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 08, 2018 at 10:25:58PM -0700, Leslie Wang wrote:

> Recently we try to upgrade ubuntu from 17.10 to 18.04, then we found
> one inconsistent behavior on git clone.
> 
> At 2.14.1 or 2.15.1, if I run command like 
>  - mkdir /tmp/111
>  - git clone git@github.com:111/111 /tmp/111
> 
> because it will failure, then /tmp/111 will be removed automatically.
> 
> However, at latest 2.17.0 which is part of ubuntu 18.04, seems like
> git clone failure will not auto remove this folder. I notice 2.16.2
> and 2.17.0 release note includes this fix. So just wonder to know if
> prior behavior was think of bug, and this fix has change the behavior. 
> 
>  * "git clone $there $here" is allowed even when here directory exists
>    as long as it is an empty directory, but the command incorrectly
>    removed it upon a failure of the operation.

Right, the old behavior was considered a bug. Git didn't create the
directory, so when rolling back its changes on failure, it shouldn't
delete it either.

-Peff
