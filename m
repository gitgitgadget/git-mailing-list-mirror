Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D098A20756
	for <e@80x24.org>; Fri, 20 Jan 2017 20:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbdATUAo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 15:00:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:42285 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753079AbdATUAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 15:00:44 -0500
Received: (qmail 14728 invoked by uid 109); 20 Jan 2017 20:00:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 20:00:43 +0000
Received: (qmail 2399 invoked by uid 111); 20 Jan 2017 20:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 15:01:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 15:00:41 -0500
Date:   Fri, 20 Jan 2017 15:00:41 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
Message-ID: <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com>
 <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
 <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
 <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 11:53:01AM -0800, Stefan Beller wrote:

> > One alternative would be to make the check cheaper. Could we reliably
> > tell from the submodule.foo.* block in the config that path "foo" is a
> > submodule? I think that would work after "submodule init" but not right
> > after "git clone". So the index really is the source of truth there.
> 
> Well we can check if there is a .gitmodules file that has a
> submodule.*.path equal to the last part of $CWD, no need to look
> at the git config.
> 
> And that would also work right after git clone (in an
> unpopulated/uninitialized submodule as I call it).
> 
> And in my current understanding of submodules the check in
> .gitmodules ought to be enough, too.

Yeah, that probably makes sense. You can have a gitlink without a
.gitmodules file, but I don't quite know what that would mean in terms
of submodules (I guess it's not a submodule but "something else").

-Peff
