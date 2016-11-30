Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DA11FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757428AbcK3XSw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:18:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:49330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757387AbcK3XSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:18:51 -0500
Received: (qmail 23837 invoked by uid 109); 30 Nov 2016 23:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:18:50 +0000
Received: (qmail 26665 invoked by uid 111); 30 Nov 2016 23:19:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 18:19:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 18:18:48 -0500
Date:   Wed, 30 Nov 2016 18:18:48 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
 <alpine.DEB.2.20.1611301204020.117539@virtualbox>
 <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
 <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
 <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 10:37:40PM +0000, Ramsay Jones wrote:

> > Anyway. Those are all options, but I don't think there is any problem
> > with sticking with warning("") for now. It is not the first part of the
> > code that tickles the format-zero-length warning.
> 
> Hmm, well I have been building git for some time with the warning
> enabled without problem.
> 
> [I can see a few examples of 'status_printf_ln(s, c, "%s", "");' in
> git-grep output, so ...]
> 
> I am not suggesting any change here, and was just curious why it
> seemed to be unnecessary now (I knew it was necessary at one time).

I forgot, we ended up reversing course later and silencing them:

  http://public-inbox.org/git/20140505052117.GC6569@sigill.intra.peff.net/

By the rationale of that conversation, we should be doing:

  warning("%s", "");

here.

-Peff
