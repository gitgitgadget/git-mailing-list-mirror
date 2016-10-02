Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2258D1F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 12:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbcJBMNQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 08:13:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:51027 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750833AbcJBMNP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 08:13:15 -0400
Received: (qmail 21294 invoked by uid 109); 2 Oct 2016 12:13:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 12:13:14 +0000
Received: (qmail 22620 invoked by uid 111); 2 Oct 2016 12:13:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 08:13:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Oct 2016 08:13:12 -0400
Date:   Sun, 2 Oct 2016 08:13:12 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] tmp-objdir: mark some file local symbols static
Message-ID: <20161002121311.4febd7jtc4yv5fev@sigill.intra.peff.net>
References: <f5560f8b-75be-faa0-ce1c-5e2716ee82a5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5560f8b-75be-faa0-ce1c-5e2716ee82a5@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 02, 2016 at 12:07:27AM +0100, Ramsay Jones wrote:

> If you need to re-roll your 'jk/quarantine-received-objects' branch,
> could you please squash this into the relevant patches.

Oops, thanks. Don't know how I missed both of these.

> [I also note that tmp_objdir_destroy(), declared to be part of the
> public interface, is not currently called from outside tmp_objdir.c.
> Despite being unlikely, it is at least plausible that this function
> may be useful in future. ;-) ]

Yeah, builtin/receive-pack is happy to just rely on process death to
destroy it, but I think it's good to keep open an option for somebody to
do:

  if (error) {
	tmp_objdir_destroy(t);
	return -1;
  }

or similar.

-Peff
