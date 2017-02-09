Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4FB1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 03:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdBIDrB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 22:47:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:52007 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdBIDrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 22:47:00 -0500
Received: (qmail 23862 invoked by uid 109); 9 Feb 2017 03:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 03:47:00 +0000
Received: (qmail 24635 invoked by uid 111); 9 Feb 2017 03:47:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 22:47:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 22:46:58 -0500
Date:   Wed, 8 Feb 2017 22:46:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
Message-ID: <20170209034657.qbkzbbzuvjpxl422@sigill.intra.peff.net>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 02:34:08PM -0800, Junio C Hamano wrote:

> * sk/parse-remote-cleanup (2017-02-06) 1 commit
>   (merged to 'next' on 2017-02-06 at 6ec89f72d5)
>  + parse-remote: remove reference to unused op_prep
> 
>  Code clean-up.
> 
>  Will merge to 'master'.

Hrm. Are the functions in git-parse-remote.sh part of the public API?
That is, do we expect third-party scripts to do:

  . "$(git rev-parse --exec)/git-parse-remote.sh
  error_on_missing_default_upstream "$a" "$b" "$c" "$d"

? If so, then they may be surprised by the change in function signature.

I generally think of git-sh-setup as the one that external scripts would
use. There _is_ a manpage for git-parse-remote, but it doesn't list any
functions. So maybe they're all fair game for changing?

I just didn't see any discussion of this in the original patch thread,
so I wanted to make sure we were making that decision consciously, and
not accidentally. :)

-Peff
