Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5BF1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 18:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbcK2SiB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:38:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:48603 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932403AbcK2SiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:38:01 -0500
Received: (qmail 5318 invoked by uid 109); 29 Nov 2016 18:38:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 18:38:00 +0000
Received: (qmail 13405 invoked by uid 111); 29 Nov 2016 18:38:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 13:38:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 13:37:58 -0500
Date:   Tue, 29 Nov 2016 13:37:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161129183758.wicmteo5vdvygu2q@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129065912.xa7itc3os425mr3r@sigill.intra.peff.net>
 <xmqqfumagmso.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfumagmso.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 10:31:51AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm actually considering scrapping the approach you've queued above, and
> > just teaching verify_path() to reject any index entry starting with
> > ".git" that is a symlink.
> 
> Hmph, that's a thought.

I was resistant to it at first because we'll have to deal with all of
the headaches of matching case-folding, but if we just match ".git*" and
not ".gitmodules", ".gitattributes", etc, it actually gets easier. I
think we can basically build off of the existing is_hfs_dotgit() and
is_ntfs_dotgit() functions.

I haven't written the code yet, though, so there may be complications.

-Peff
