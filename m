Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF66D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbdASQml (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:42:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:41558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753606AbdASQmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:42:38 -0500
Received: (qmail 29553 invoked by uid 109); 19 Jan 2017 16:42:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:42:03 +0000
Received: (qmail 6514 invoked by uid 111); 19 Jan 2017 16:42:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 11:42:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 11:41:57 -0500
Date:   Thu, 19 Jan 2017 11:41:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] color.c: trim leading spaces in color_parse_mem()
Message-ID: <20170119164157.mvoadhxxwwynedoz@sigill.intra.peff.net>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
 <20170119114123.23784-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170119114123.23784-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 06:41:22PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Normally color_parse_mem() is called from config parser which trims the
> leading spaces already. The new caller in the next patch won't. Let's be
> tidy and trim leading spaces too (we already trim trailing spaces before
> comma).

What comma? I don't think that exists until the next patch. :)

I think just trimming from the front is OK, though, because
color_parse_mem() trims trailing whitespace after a word. So either you
have a word and we will trim after it, or you do not (in which case
this will trim everything and hit the !len case you added).

So maybe a better commit message is just:

  Normally color_parse_mem() is called from config parser which trims
  the leading spaces already. The new caller in the next patch won't.
  Let's be tidy and trim leading spaces too (we already trim trailing
  spaces after a word).

-Peff
