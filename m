Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B1C201A0
	for <e@80x24.org>; Thu, 11 May 2017 23:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbdEKXnD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 19:43:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:49993 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932267AbdEKXnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 19:43:02 -0400
Received: (qmail 29073 invoked by uid 109); 11 May 2017 23:43:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 23:43:02 +0000
Received: (qmail 19993 invoked by uid 111); 11 May 2017 23:43:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 19:43:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 19:43:00 -0400
Date:   Thu, 11 May 2017 19:43:00 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible bug in includeIf / conditional includes on non git
 initialised directories
Message-ID: <20170511234259.gnbr6aiu26oqysxo@sigill.intra.peff.net>
References: <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
 <5735fdc6-85de-491c-481d-9d0c18912ee6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5735fdc6-85de-491c-481d-9d0c18912ee6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:31:14PM +0200, Sebastian Schuberth wrote:

> On 2017-05-11 20:53, Raphael Stolt wrote:
> 
> > I might have stumbled this time over a real bug in includeIf / conditional includes or maybe it's just as intended.
> > 1) Given I have a correct configured includeIf and I’m issuing `git config --show-origin --get user.email` against an directory which hasn’t been `git init`ed I get the user.email configured globally.
> 
> I don't think that's a bug surprise: The condition in the conditional
> include is "gitdir:". Before running "git init", it simply *is* no
> gitdir.

Yeah, I think all is working as intended. A "cwd:" conditional seems
like it would be useful, but I think it would have a lot of corner
cases. It may change over the course of a program, and you have
weirdness with things like "git --git-dir=/some/other/path", where your
cwd and the git repository you're looking at are totally unrelated.

-Peff
