Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CAF81F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBHSPF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:15:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:37798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727121AbfBHSPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:15:05 -0500
Received: (qmail 10353 invoked by uid 109); 8 Feb 2019 18:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 18:15:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26082 invoked by uid 111); 8 Feb 2019 18:15:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 13:15:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 13:15:03 -0500
Date:   Fri, 8 Feb 2019 13:15:03 -0500
From:   Jeff King <peff@peff.net>
To:     Douglas Godfrey <douglas.godfrey@whamtech.com>
Cc:     git@vger.kernel.org
Subject: Re: undefined symbols building GIT source from githu
Message-ID: <20190208181503.GC27673@sigill.intra.peff.net>
References: <1a9f02ca-3bc3-f00f-6923-1bbf050e84ca@whamtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a9f02ca-3bc3-f00f-6923-1bbf050e84ca@whamtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 01:13:04AM -0500, Douglas Godfrey wrote:

> make
> 
> ld: warning: in libgit.a, file was built for unsupported file format which is not the architecture being linked (x86_64)
> ld: warning: in xdiff/lib.a, file was built for unsupported file format which is not the architecture being linked (x86_64)
> Undefined symbols:
>   "_strbuf_addstr_urlencode", referenced from:
> [...]

It sounds like there is a mismatch between your compiler/linker and
"ar". I had a vague recollection of this coming up before, and turned
this up in the archive:

  https://public-inbox.org/git/CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com/

does setting AR/ARFLAGS as in that patch help (note that the original
complaint is that ARFLAGS is not respected, but that was since changed
in response to that thread).

-Peff
