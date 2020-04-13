Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F14EC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAAA2072D
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgDMRU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:20:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:52308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732579AbgDMRUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 13:20:54 -0400
Received: (qmail 31801 invoked by uid 109); 13 Apr 2020 17:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Apr 2020 17:20:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19784 invoked by uid 111); 13 Apr 2020 17:31:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Apr 2020 13:31:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Apr 2020 13:20:52 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] better handling of gigantic config files
Message-ID: <20200413172052.GB8183@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
 <20200413004927.GC55122@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413004927.GC55122@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 12, 2020 at 06:49:27PM -0600, Taylor Blau wrote:

> Thanks for doing this. I knew that it rang a bell for some reason, but
> it was because of the upload-pack changes to limit the set of allowed
> object filter choices that I'd sent as an RFC somewhere.
> 
> I was using 'parse_config_key()', and I think that you noted somewhere
> that it was odd that it filled an int and not a size_t. So, thanks very
> much for fixing that case.

Yes, your patch was part of why it was on my mind, though really all of
this is the culmination of many years of annoyance. :)

You'll have to update your code to use size_t when the two are merged
together. I don't think there's anything else in flight that needs
similar treatment, though.

-Peff
