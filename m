Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E421F404
	for <e@80x24.org>; Mon,  2 Apr 2018 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeDBMlD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 08:41:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751237AbeDBMlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 08:41:02 -0400
Received: (qmail 15246 invoked by uid 109); 2 Apr 2018 12:41:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Apr 2018 12:41:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16177 invoked by uid 111); 2 Apr 2018 12:42:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Apr 2018 08:42:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2018 08:40:59 -0400
Date:   Mon, 2 Apr 2018 08:40:59 -0400
From:   Jeff King <peff@peff.net>
To:     David Hoyle <davidghoyle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git log --oneline cannot display dates
Message-ID: <20180402124059.GA396@sigill.intra.peff.net>
References: <CAFGVh0zWuqa5HswE7JAx3-bOSGGaRAgLa6ULy--+yn_iD5eJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFGVh0zWuqa5HswE7JAx3-bOSGGaRAgLa6ULy--+yn_iD5eJRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 02, 2018 at 01:05:01PM +0100, David Hoyle wrote:

> When using the git log command with the --oneline switch, you cannot
> add the --date=<date> switch to see the dates.

Right. --date is just about selecting which date format to show, not
whether to show one. The decision of what to show is up to the format,
and --oneline does not include a date.

> The only workaround is
> to create an alias and use the --pretty-format which doesn't provide
> the ability to colour the branch and tag information (as far as i can
> tell).

You can use "%C(auto)" to turn on auto-coloring for various components:

  git log --format='%C(auto)%h%d %s'

which reproduces the usual coloring and format of --oneline. Then you
should be able to add in your own date, colored as you wish. E.g.:

  git log --format='%C(auto)%h%d %C(blue)%ad%C(reset) %s'

If you want to use this a lot, you may want to look into the "pretty.*"
config so you can trigger it with a short name.

-Peff
