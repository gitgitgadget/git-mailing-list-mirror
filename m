Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE2820966
	for <e@80x24.org>; Thu, 30 Mar 2017 23:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934059AbdC3XdV (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 19:33:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:54500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdC3Xce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 19:32:34 -0400
Received: (qmail 6229 invoked by uid 109); 30 Mar 2017 23:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 23:32:30 +0000
Received: (qmail 4490 invoked by uid 111); 30 Mar 2017 23:32:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 19:32:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 19:32:28 -0400
Date:   Thu, 30 Mar 2017 19:32:28 -0400
From:   Jeff King <peff@peff.net>
To:     Nate Mueller <nate@retailnext.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Issue with 2.11.0 and GIT_EXEC_PATH with multiple entries
Message-ID: <20170330233228.dfv5mxnwlppghmua@sigill.intra.peff.net>
References: <CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com>
 <xmqqo9wi1ifw.fsf@gitster.mtv.corp.google.com>
 <CAJF7t-cAtR9yp2184pUsw+w3mf-SSMW4FUY27N8+f=6u7qjx3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF7t-cAtR9yp2184pUsw+w3mf-SSMW4FUY27N8+f=6u7qjx3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 04:00:41PM -0700, Nate Mueller wrote:

> Really?  My config has been set this way for years and it's never
> caused problems before.  I have subcommands in both of those
> directories and all work.

Really. It did happen to work most of the time before (because most uses
involved just appending it to $PATH). But it was never intended to work
with multiple paths. The:

  . "$(git --exec-path)/git-sh-whatever"

advice has been advertised in the documentation for years. E.g., see
bd870878f (Documentation: don't assume git-sh-setup and git-parse-remote
are in PATH, 2008-06-29). So even if we wanted to relax the rules in our
scripts, it seems like a potential hazard for 3rd party scripts.

The recommended way is to just put your ~/.git-exec into your $PATH.

-Peff
