Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7205420357
	for <e@80x24.org>; Fri, 14 Jul 2017 13:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754197AbdGNN2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 09:28:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753968AbdGNN2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 09:28:49 -0400
Received: (qmail 19425 invoked by uid 109); 14 Jul 2017 13:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 13:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10742 invoked by uid 111); 14 Jul 2017 13:29:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 09:29:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 09:28:47 -0400
Date:   Fri, 14 Jul 2017 09:28:47 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Elliot Chandler <worldpeacehaven@gmail.com>,
        Lutz Roeder <lutz.noreply@gmail.com>, git@vger.kernel.org
Subject: Re: Git on macOS shows committed files as untracked
Message-ID: <20170714132846.dww7y5ae4fexejnc@sigill.intra.peff.net>
References: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
 <914898a3-24da-403a-8e1c-e90b53df46a9@web.de>
 <CAHVrscDg8bc-CYm6dSJFgdPSv1vJ0=AC0s3y26CHctKkYAvJyA@mail.gmail.com>
 <8b5fc22c-4d65-d34a-a84c-c913f454c771@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b5fc22c-4d65-d34a-a84c-c913f454c771@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 02:35:52PM +0200, Torsten Bögershausen wrote:

> (Please no top-posting)
> On 14/07/17 11:45, Elliot Chandler wrote:
> > For what it's worth, the file looks normal in Gentoo GNU/Linux (name
> > appears "ḋἲ╓εﮯ𒑏○╓Ӳ" and it seems to work like any other directory).
> > 
> Thanks for testing -
> Normal and Normal ;-)
> For me the 6th code point does look strange
> The "box" with 04142F:
> Code point 4142F is unassigned and is outside any currently defined block range.

Are you sure? I get u+1244f. I don't have a glyph for it in my font, but
at least it's a real unicode codepoint (cuneiform 1).

> So this is not valid Unicode, so we have a problem here under MacOS -
> not much Git can do about it.

I do still suspect this is the root of the problem. There's something
about the string that HFS+ doesn't want to store, and there's nothing we
can do to fix that.

-Peff
