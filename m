Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC161F405
	for <e@80x24.org>; Sun, 16 Dec 2018 10:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbeLPKv0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:51:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:43250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729811AbeLPKv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:51:26 -0500
Received: (qmail 24413 invoked by uid 109); 16 Dec 2018 10:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22381 invoked by uid 111); 16 Dec 2018 10:50:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:50:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:51:24 -0500
Date:   Sun, 16 Dec 2018 05:51:24 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] git-column.txt: fix section header
Message-ID: <20181216105123.GD13704@sigill.intra.peff.net>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
 <20181215112742.1475882-2-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215112742.1475882-2-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 12:27:39PM +0100, Martin Ågren wrote:

> We have too few dashes under "Examples", which causes Asciidoctor to not
> pick it up as a section header, but to instead just render the dashes
> literally. This also seems to confuse Asciidoctor about dashes in
> general around here. It misinterprets the listing blocks in this
> section, again rendering the dashes literally.
> 
> Make sure we have as many dashes as we have characters in "Examples".
> This fixes the section-issue and, somehow, makes the listing blocks
> render correctly.

Yeah, the mis-matched title-and-dashes thing has bitten us several
times. I think this one just post-dates the last round of fixing.

The "somehow" here is that the mismatched dashes appear to be the start
of a code listing block, making the whole example section into one big
listing (which isn't properly closed, generating a warning).

And that's why in the context:

>  EXAMPLES
> -------
> +--------
>  
>  Format data by columns:
>  ------------

We _don't_ need to match up the dashes for "Format data...". That is
meant to be a listing block (and arguably should use a shorter string of
dashes to make that intent more obvious).

-Peff
