Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DCC5518A
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CCB2077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVTrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:47:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:36382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725779AbgDVTre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:47:34 -0400
Received: (qmail 10189 invoked by uid 109); 22 Apr 2020 19:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 19:47:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1325 invoked by uid 111); 22 Apr 2020 19:58:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 15:58:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 15:47:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "fetch: default to protocol version 2"
Message-ID: <20200422194733.GA561178@coredump.intra.peff.net>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
 <20200422155047.GB91734@google.com>
 <20200422194047.GD558336@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422194047.GD558336@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 03:40:47PM -0400, Jeff King wrote:

> > By the way, I'd recommend the immediate workaround of
> > 
> > 	git fetch --negotiation-tip=refs/remotes/xo/* xo
> > 
> > instead.  But that's a separate subject.
> 
> It seems like if we are fetching with refspec X/*:Y/* that we should
> perhaps automatically select our local Y/* negotiation tips.

Actually, I guess that option is not "please prioritize these tips", but
rather "use only these tips". So using it can sometimes hurt.

> That said, neither it (nor the manual version above) would help the case
> I've been testing with. It's a first fetch from "xo", which can reuse
> history we already have from other remotes.
> 
> I agree it's a good workaround for folks doing their daily fetches,
> though.

I did confirm that re-running my test with --negotiation-tip=master (to
point to Linus's tree, avoiding the clogging of "next" commits) results
in the usual good pack in a reasonable time.

-Peff
