Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626AD1F576
	for <e@80x24.org>; Thu,  8 Feb 2018 08:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBHIuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 03:50:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:44792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751738AbeBHIuS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 03:50:18 -0500
Received: (qmail 2117 invoked by uid 109); 8 Feb 2018 08:50:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 08:50:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6694 invoked by uid 111); 8 Feb 2018 08:51:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 03:51:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 03:50:16 -0500
Date:   Thu, 8 Feb 2018 03:50:16 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        Jason Racey <jason@eluvio.com>, git <git@vger.kernel.org>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: "git branch" issue in 2.16.1
Message-ID: <20180208085015.GA24571@sigill.intra.peff.net>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
 <20180206195754.GE1427@zaya.teonanacatl.net>
 <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
 <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
 <20180207200859.GA9141@sigill.intra.peff.net>
 <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 11:20:08PM +0100, Lars Schneider wrote:

> >  1. You have $LESS in your environment (without "F") on one platform
> >     but not the other.
> 
> I think that's it. On my system LESS is defined to "-R".
> 
> This opens the pager:
> 
> 	$ echo "TEST" | less
> 
> This does not open the pager:
> 
> 	$ echo "TEST" | less -FRX
> 
> That means "F" works on macOS but Git doesn't set it because LESS is
> already in my environment.
> 
> Question is, why is LESS set that way on my system? I can't find
> it in .bashrc .bash_profile .zshrc and friends.

There's also /etc/bash.bashrc, /etc/profile, etc. I don't know what's
normal in the mac world. You can try running:

  bash -ix 2>&1 </dev/null | grep LESS

to see what your startup code is doing. I don't know of a good way to
correlate that with the source files, though. Or even to ask bash which
startup files it's looking in.

-Peff
