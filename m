Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421831F404
	for <e@80x24.org>; Tue, 28 Aug 2018 00:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbeH1ErQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 00:47:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725198AbeH1ErQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 00:47:16 -0400
Received: (qmail 15201 invoked by uid 109); 28 Aug 2018 00:58:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 00:58:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27557 invoked by uid 111); 28 Aug 2018 00:58:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 20:58:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 20:58:10 -0400
Date:   Mon, 27 Aug 2018 20:58:10 -0400
From:   Jeff King <peff@peff.net>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: GIT_TRACE doesn't show content filter files it's operating on
Message-ID: <20180828005810.GA18659@sigill.intra.peff.net>
References: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
 <20180827235321.GB11663@sigill.intra.peff.net>
 <28045b26-4822-b00c-30f3-1076d2e49d1f@stason.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28045b26-4822-b00c-30f3-1076d2e49d1f@stason.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 05:22:13PM -0700, Stas Bekman wrote:

> Your suggestions do the trick, Jeff. Thank you.
> 
> 1. To benefit others who might be looking for something similar may I
> post your suggestions as an answer to:
> <https://stackoverflow.com/questions/51995773/getting-git-to-show-specific-filenames-it-is-running-content-filters-on>?

Great, thanks.

> 2. Is there no way to get git to do the filename reporting as a normal
> GIT_TRACE behavior? I don't know anything about its internal workings,
> but it surely must knows which file it operates on when it opens it and
> sends its data as stdin to the content filter. It makes the debugging so
> much easier when one can see what files are being worked on. So perhaps
> this utility can be made available to all not just as a hack/workaround.

No, because GIT_TRACE itself only reports on the execution of commands
and sub-processes. There are other GIT_TRACE_* variables for various
subsystems, but AFAIK nobody has instrumented the smudge/clean filter
code. IMHO it would be reasonable to have a GIT_TRACE_CONVERT
that covered convert.c (so these filters, but also newline conversion,
etc).

-Peff
