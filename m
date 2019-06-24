Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555591F4B6
	for <e@80x24.org>; Mon, 24 Jun 2019 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfFXTDw (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 15:03:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48536 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFXTDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 15:03:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E208E1F461;
        Mon, 24 Jun 2019 19:03:51 +0000 (UTC)
Date:   Mon, 24 Jun 2019 19:03:51 +0000
From:   Eric Wong <e@80x24.org>
To:     meta@public-inbox.org, git@vger.kernel.org
Subject: TLS on news.public-inbox.org [was: may be unstable]
Message-ID: <20190624190351.GA12888@dcvr>
References: <20190621172120.kt2txjqbvsvdxidx@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621172120.kt2txjqbvsvdxidx@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Hopefully I didn't break anything, stress testing some stuff
> and my own Internet connection is intermittent :<

STARTTLS is now available on port 119, and NNTPS on 563.
I think it works... :x

No idea if it's actually secure or not; but it might help
get around firewalls or traffic filtering.

I'm using Let's Encrypt and IO::Socket::SSL defaults for
SSL_server=1.  This is with the libiosocket-ssl-ssl-perl 2.044-1
package in Debian stable (9.x),

Anyways there's a boatload of changes and size reductions aimed
at C10K+ parallelism starting at:
https://public-inbox.org/meta/20190624025258.25592-1-e@80x24.org/
But OpenSSL/IO::Socket::SSL overhead remains disappointing,
even with SSL_MODE_RELEASE_BUFFERS :<

HTTPS work hasn't started, yet (but I figure most folks are
using nginx + varnish); and there's other bugs and stuff
I'd need to look at...
