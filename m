Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71041F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 11:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeKOVNv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 16:13:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:40382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729010AbeKOVNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 16:13:50 -0500
Received: (qmail 17077 invoked by uid 109); 15 Nov 2018 11:06:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 11:06:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14250 invoked by uid 111); 15 Nov 2018 11:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 06:05:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 06:06:26 -0500
Date:   Thu, 15 Nov 2018 06:06:26 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation/clone: document ignored configuration
 variables
Message-ID: <20181115110626.GC19032@sigill.intra.peff.net>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
 <20181114104620.32478-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114104620.32478-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:46:20AM +0100, SZEDER Gábor wrote:

> Due to limitations in the current implementation, some configuration
> variables specified via 'git clone -c var=val' (or 'git -c var=val
> clone') are ignored during the initial fetch and checkout.
> 
> Let the users know which configuration variables are known to be
> ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
> documentation of 'git clone -c', along with hints to use the options
> '--mirror' and '--no-tags' instead.

Good idea.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index a55536f0bf..2fd12524f9 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -189,6 +189,12 @@ objects from the source repository into a pack in the cloned repository.
>  	values are given for the same key, each value will be written to
>  	the config file. This makes it safe, for example, to add
>  	additional fetch refspecs to the origin remote.
> ++
> +Due to limitations of the current implementation, some configuration
> +variables do not take effect until after the initial fetch and checkout.
> +Configuration variables known to not take effect are:
> +`remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
> +corresponding `--mirror` and `--no-tags` options instead.

This looks good. I considered at first that this might want to go in a
BUGS section of the manpage, but it makes the most sense being right
next to the definition of "-c".

-Peff
