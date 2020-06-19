Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB9AC433E4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CA0206C3
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390535AbgFSTtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:49:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37810 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390456AbgFSTtC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:49:02 -0400
Received: (qmail 5905 invoked by uid 109); 19 Jun 2020 19:49:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 19:49:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18561 invoked by uid 111); 19 Jun 2020 19:49:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 15:49:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 15:49:01 -0400
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 2/3] strbuf.c: remove unreferenced strbuf_write_fd
 method.
Message-ID: <20200619194901.GB722967@coredump.intra.peff.net>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
 <20200619150445.4380-3-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619150445.4380-3-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 11:04:44AM -0400, randall.s.becker@rogers.com wrote:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> strbuf_write_fd was only used in bugreport.c. Since that file now uses
> write_in_full, this method is no longer needed.

Just because there are no callers _now_ does not necessarily mean that
it's a good idea to get rid of a function. I think the real argument is
that we don't expect new ones, because it's a badly designed function
(for the reasons in our earlier discussion). Maybe worth summarizing
here.

-Peff
