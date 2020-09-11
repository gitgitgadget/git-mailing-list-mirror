Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58436C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136EE221ED
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIKQr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:47:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:54572 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgIKQq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 12:46:59 -0400
Received: (qmail 2135 invoked by uid 109); 11 Sep 2020 16:46:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 16:46:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4570 invoked by uid 111); 11 Sep 2020 16:46:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 12:46:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 12:46:56 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
Subject: Re: Git doesn't honor NO_PROXY environment variable while cloning
Message-ID: <20200911164656.GA2641000@coredump.intra.peff.net>
References: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com>
 <20200911135928.GA1986935@coredump.intra.peff.net>
 <alpine.DEB.2.20.2009111729530.6227@tvnag.unkk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2009111729530.6227@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 05:31:16PM +0200, Daniel Stenberg wrote:

> On Fri, 11 Sep 2020, Jeff King wrote:
> 
> > So I dunno. This seems like a libcurl bug, but it's possible we're
> > feeding it data wrong somehow.
> 
> I didn't check very closely, but it certainly sounds like this one:
> 
>   https://github.com/curl/curl/pull/5902

You know, I almost cc'd you, but I didn't want to bug you until I was
more sure it was a curl issue. But here you are anyway. :)

That indeed looks a lot like the same issue. And building the tip of
libcurl's master and linking git against it makes the problem go away.
So that is almost certainly it.

Thanks for the quick response!

-Peff
