Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878D22021E
	for <e@80x24.org>; Fri,  4 Nov 2016 00:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758893AbcKDADy (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 20:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbcKDADx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 20:03:53 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19DA731B327;
        Fri,  4 Nov 2016 00:03:53 +0000 (UTC)
Received: from mail.random (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA403pI2032495
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2016 20:03:52 -0400
Date:   Fri, 4 Nov 2016 01:03:51 +0100
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161104000351.GP4611@redhat.com>
References: <20161102202709.GI4611@redhat.com>
 <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
 <20161102213805.GJ4611@redhat.com>
 <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
 <20161102222901.GK4611@redhat.com>
 <20161103141848.42pg6iow24prign5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103141848.42pg6iow24prign5@sigill.intra.peff.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 04 Nov 2016 00:03:53 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 10:18:48AM -0400, Jeff King wrote:
> bogus header. The munging that postfix does makes things worse, but I

I agree it makes things worse.

> can see why it is confused and does what it does (the whole email is
> inside a double-quoted portion that is never closed, so it probably
> thinks there is no hostname portion at all).

I would see it too, if it actually sent the email to the garbled email
address it generated, but it actually got the right email address
(because it sent the email to the right address), but it decided to
show a different email address in the mail header than the one it sent
the email to. But I figure this is the wrong list for such questions :).

> I think if any change were to be made, it would be to recognize this
> bogosity and either clean it up or abort. That ideally would happen via

If postfix continues to do what it does, a strict checking would be my
preference of course, assuming it won't break anything that currently
works...

If not it's fine too, as nothing particularly "unexpected" happened in
git.

At this point double checking that what postfix does is legit is
perhaps more worthwhile than adding strictness to git.

Thanks,
Andrea
