Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B8D1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcHOM2Y (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:28:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:55359 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752768AbcHOM2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:28:23 -0400
Received: (qmail 13826 invoked by uid 109); 15 Aug 2016 12:28:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:28:23 +0000
Received: (qmail 13977 invoked by uid 111); 15 Aug 2016 12:28:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:28:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:28:20 -0400
Date:	Mon, 15 Aug 2016 08:28:20 -0400
From:	Jeff King <peff@peff.net>
To:	norm@dad.org
Cc:	git@vger.kernel.org
Subject: Re: Getting the "message" given a branch designation and conversely
Message-ID: <20160815122820.msajaamgmlexe2jd@sigill.intra.peff.net>
References: <201608141458.u7EEwF8P099500@shell1.rawbw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201608141458.u7EEwF8P099500@shell1.rawbw.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 07:58:14AM -0700, norm@dad.org wrote:

> I am learning how to use git. I would like to know how:
> 
> Given a branch's designation, such as "master~4", how can I see the message I
> furnished when I created the branch using "git commit"?

Somebody already pointed you at "git log", which is the right tool for
looking at commit messages (or perhaps "git show" if you only want to
see a single entry).

> Conversely, given the message I furnished to "git commit", when I created a
> branch, how can I see the branch's designation?

Try "git log --grep=some.regex" to find a particular commit. Usually we
refer to commits by their sha1 id, which will be shown by git-log.
However, you can use git-describe to generate a name for any commit that
is based on traversing from a tag. Try:

  git describe --contains --all <sha1>

for example. Using "--all" tells git to consider names based on branches
as well as tags. Using "--contains" will generate a name based on
traversing backwards from the tags and branches (like "master~4") rather
than basing the name on a tag that you build off of.

-Peff
