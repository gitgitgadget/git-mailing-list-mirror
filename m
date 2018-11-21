Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF42E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeKVAdy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:33:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:47336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729157AbeKVAdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:33:54 -0500
Received: (qmail 20287 invoked by uid 109); 21 Nov 2018 13:59:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Nov 2018 13:59:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9401 invoked by uid 111); 21 Nov 2018 13:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Nov 2018 08:58:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2018 08:59:21 -0500
Date:   Wed, 21 Nov 2018 08:59:21 -0500
From:   Jeff King <peff@peff.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep prints colon instead of slash
Message-ID: <20181121135921.GA9586@sigill.intra.peff.net>
References: <5d3618d4-8a5a-b4dc-3cc9-4134cd73675a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d3618d4-8a5a-b4dc-3cc9-4134cd73675a@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 02:54:34PM +0100, Marc Gonzalez wrote:

> If I specify the branch to explore, git grep prints a colon instead of
> a slash in the path:
> 
> $ git grep arm,coresight-tmc master:Documentation/devicetree
> master:Documentation/devicetree:bindings/arm/coresight.txt:                     "arm,coresight-tmc", "arm,primecell";
> master:Documentation/devicetree:bindings/arm/coresight.txt:             compatible = "arm,coresight-tmc", "arm,primecell";
>                                ^
>                               HERE
> 
> There is no such issue when the branch is not specified:
> 
> $ git grep arm,coresight-tmc Documentation/devicetree
> Documentation/devicetree/bindings/arm/coresight.txt:                    "arm,coresight-tmc", "arm,primecell";
> Documentation/devicetree/bindings/arm/coresight.txt:            compatible = "arm,coresight-tmc", "arm,primecell";
>                         ^
>                     NO ISSUE
> 
> 
> Is this expected behavior?
> The spurious colon prevents one from simply copy/pasting the output.

There's lots of discussion in this thread from last year:

  https://public-inbox.org/git/20170119150347.3484-1-stefanha@redhat.com/

Notably:

  git grep arm,coresight-tmc master -- Documentation/devicetree

will do what you want.

-Peff
