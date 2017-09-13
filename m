Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3462E20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdIMVRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:17:46 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:46504 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdIMVRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:17:45 -0400
Received: by mail-pg0-f48.google.com with SMTP id i130so2665723pgc.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i9TV4MOP2JzobYNIEHm1QS07Q+7Gt8ZeLZjR1tbEAhA=;
        b=VsHqtu3CE2NriKf1RSzLnAdAnHNIawq/gwL8CNNCDMzwRr60YBBf37Tc6BxNtZFzdg
         RvHsqOIWVrUUJQuVS63AjZKlRxk1AbYlviUD86srHjorSh3GDED+4PXBZbLnOlFYjacx
         s/IORLWVlHqibYvLyLgHzPsovuDttTQxD1eqGrmwwPmDEAo/7z9Vc1GQxCGISfo50Q98
         JQiK8kRxj1hzw2WIv1r64vwZXDdFovc+E5APt9CG+nw3KQgwdh7ZGMzlM+mQA5N1Y23u
         23JIrbSVGo49OloVBh3K4rWRUzJowvdiBkBCRvrTtPq1SD/Po3x9uwIzWhYWwwZwkVbe
         a58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9TV4MOP2JzobYNIEHm1QS07Q+7Gt8ZeLZjR1tbEAhA=;
        b=N5BibXpZCrJEMRnTN5Izp/+IGqujIMtAkcjrnM9WdRvmB3FJ+2FDUIAb/DW0St92eR
         /JPs8g2mxGHtHKNyWui/QLgojCTsoWWe1x3t5u2NEbbcQujh8s2kAC2i0NeGEx3O6SXW
         lOh4NJA4oJOzD53X6AQ9PFrvrTrp6MdBdZIA5V2iYmzEBZVsE0YCEVSWdhRu5M19YI0m
         kAteT9w/oa2337DeI3LrH2mm8OD1KOa2pIZhpCWkb4gH16/Bc/U1YrW8sy2LOv98e0aB
         kaSFv2kNu+6qX8GRoYNKIDNvqgnQex6umfa11dT/ihaDuTj9AMHKP4rRKWjaeZd7Wgg1
         JA/A==
X-Gm-Message-State: AHPjjUiJKskjrZeSYKByiZW7Jnxe6xR0ZOiOWVSe6aQIlDvv2OPNoXkf
        JbnPxFWVZmXjxA==
X-Google-Smtp-Source: ADKCNb7Uk+93ZDCMyHliM3kxP17W9K5JLGnaeBsqgPQ3vtOsfl/Itwfw6eILRJhwNCS+Dk3ajaRrQA==
X-Received: by 10.101.82.8 with SMTP id o8mr18875605pgp.261.1505337464840;
        Wed, 13 Sep 2017 14:17:44 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id v2sm22235646pgo.38.2017.09.13.14.17.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:17:44 -0700 (PDT)
Date:   Wed, 13 Sep 2017 14:17:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/7] pkt-line: check write_in_full() errors against "< 0"
Message-ID: <20170913211742.GM27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171730.ckcebchjhhvtwcsj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171730.ckcebchjhhvtwcsj@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> As with the previous two commits, we prefer to check
> write_in_full()'s return value to see if it is negative,
> rather than comparing it to the input length.
>
> These cases actually flip the logic to check for success,
> making conversion a little different than in other cases. We
> could of course write:
>
>   if (write_in_full(...) >= 0)
>           return 0;
>  return error(...);
>
> But our usual method of spelling write() error checks is
> just "< 0". So let's flip the logic for each of these
> conditionals to our usual style.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pkt-line.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
