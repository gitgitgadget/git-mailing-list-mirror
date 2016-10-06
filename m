Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CD1207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbcJFTLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:11:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:53557 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbcJFTLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:11:35 -0400
Received: (qmail 30333 invoked by uid 109); 6 Oct 2016 19:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 19:11:29 +0000
Received: (qmail 30582 invoked by uid 111); 6 Oct 2016 19:11:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 15:11:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 15:11:27 -0400
Date:   Thu, 6 Oct 2016 15:11:27 -0400
From:   Jeff King <peff@peff.net>
To:     Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
Cc:     git@vger.kernel.org
Subject: Re: Systems with old regex system headers/libraries don't pick up
 git's compat/regex header file
Message-ID: <20161006191127.2vjtmxl7ygjeqcbk@sigill.intra.peff.net>
References: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 10:15:49AM +0100, Richard Lloyd wrote:

> Unfortunately, on systems with an older regex shipped as
> standard (e.g. HP-UX 11), the include path picks up
> /usr/include/regex.h first, which doesn't define REG_STARTEND
> and the git-compat-util.h check fails.
> 
> The fix I applied on HP-UX 11 was to add -Icompat/regex
> to the CFLAGS ahead of other -I directives. Another possible
> change needed might be to line 69 of compat/regex/regex.c:

Junio mentioned the NO_REGEX knob in the Makefile. If that works for
you, the next step is probably to add a line to the HP-UX section of
config.mak.uname, so that it just works out of the box.

-Peff
