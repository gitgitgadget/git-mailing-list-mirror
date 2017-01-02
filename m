Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246BB1FCA5
	for <e@80x24.org>; Mon,  2 Jan 2017 04:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbdABETv (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 23:19:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:33932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932389AbdABETu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 23:19:50 -0500
Received: (qmail 7816 invoked by uid 109); 2 Jan 2017 04:19:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 04:19:50 +0000
Received: (qmail 11688 invoked by uid 111); 2 Jan 2017 04:20:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Jan 2017 23:20:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jan 2017 23:19:47 -0500
Date:   Sun, 1 Jan 2017 23:19:47 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git mailing list <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
Message-ID: <20170102041947.5jzx6og5fcpv7oso@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
 <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
 <994A5650F89F4B0080530BF7FD1879FD@PhilipOakley>
 <CA+P7+xqxSpV4yOjE+Lv0kw19Kq6UAbcN_-7O3U_EeBoT7AOtfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqxSpV4yOjE+Lv0kw19Kq6UAbcN_-7O3U_EeBoT7AOtfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 01, 2017 at 12:36:11PM -0800, Jacob Keller wrote:

> But how likely is it to end up with differing binaries running on the
> exact same repository concurrently? Basically, I am trying to see
> whether or not we could accidentally end up causing problems by trying
> to race with other git processes that haven't yet been made safe
> against race? Is the worst case only that some git operation would
> fail and you would have to retry?

Yes, I think that is the worst case.

A more likely scenario might be something like a server accepting pushes
or other ref updates from both JGit and regular git (or maybe libgit2
and regular git).

IMHO it's not really worth worrying about too much. Certain esoteric
setups might have a slightly higher chance of a pretty obscure race
condition happening on a very busy repository. I hate to say "eh, ship
it, we'll see if anybody complains". But I'd be surprised to get a
single report about this.

-Peff
