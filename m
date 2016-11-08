Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548E12022A
	for <e@80x24.org>; Tue,  8 Nov 2016 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbcKHV5N (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 16:57:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:40357 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbcKHV5M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 16:57:12 -0500
Received: (qmail 32149 invoked by uid 109); 8 Nov 2016 21:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 21:57:12 +0000
Received: (qmail 24574 invoked by uid 111); 8 Nov 2016 21:57:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 16:57:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 16:57:09 -0500
Date:   Tue, 8 Nov 2016 16:57:09 -0500
From:   Jeff King <peff@peff.net>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not
 to abbreviate
Message-ID: <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
 <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
 <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
 <22561.44597.59852.574831@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22561.44597.59852.574831@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 10:51:33AM +0000, Ian Jackson wrote:

> Yes, I agree that it does seem weird.  But the alternatives seem
> worse.  I think it's probably best if options like this (currently
> only honoured by out-of-core tools but of general usefulness) are
> collected together here.
> 
> There is a precedent: `git config gui.encoding' is, according to the
> documentation, honoured only by git-gui and gitk.

Yeah, I think git's config system was always designed to carry options
for porcelains outside of git-core itself. So your new option fits into
that.

I think the two things I found weird were:

  - it's in the "log" section, which makes me think it's an option for
    git-log. But it's not. I'm not sure what the _right_ section is, but
    hopefully it would make it clear that this is command-agnostic.

    Something like "gui.abbrevTags" might be OK (and as you note, has
    precedence). But of course it's possible that a command like "tig"
    could learn to support it.  I'm not sure if that counts as a GUI or
    not. :)

  - The description talks about tag abbreviation, but doesn't really
    define it. Not being a gitk user, it was hard for me to figure out
    whether this was even relevant. Does it mean turning
    "refs/tags/v1.0" into "1.0"? From the rest of the series, it sounds
    like no. That should be more clear from the documentation.

-Peff
