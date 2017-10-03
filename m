Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243EB20365
	for <e@80x24.org>; Tue,  3 Oct 2017 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdJCJKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 05:10:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:58790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751194AbdJCJKw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 05:10:52 -0400
Received: (qmail 15779 invoked by uid 109); 3 Oct 2017 09:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:10:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6033 invoked by uid 111); 3 Oct 2017 09:10:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 05:10:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 05:10:50 -0400
Date:   Tue, 3 Oct 2017 05:10:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
 <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
 <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
 <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
 <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
 <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
 <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 05:56:53PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Note that I'm arguing that it's a foot-gun even without scripts in the
> > picture at all. Forget about plumbing versus porcelain. If you set
> > color.ui to "always", you're going to get unexpected and confusing
> > results from time to time.
> 
> Really? 
> 
> I would think you would consistently get ANSI colored output in any
> medium, even in files that you would later "cat" or "less -R" to
> view.  Is that unexpected?  Those who set "always" (I am not among
> them, of course) would expect that, I would think.

Those cases might be expected. But color when piping to grep or sed are
not. I guess you can lump those under "well, they should be using
plumbing, of course" but I don't think that's very realistic. People do
ad-hoc pipes in their shells all the time (well, I assume so; I
certainly do).

I don't argue that people don't have a need to write colors to a
non-terminal. Certainly they do. I argue that setting it in your on-disk
config is likely to have it trigger at other times when it's unexpected
and inconvenient.

I dunno. Maybe I am wrong, because certainly I never set it. We've had
two reports on the list since v2.14.2. The motivation for the first was
"I have no idea why I set that, and I'll switch to auto". This is the
second.

-Peff
