Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578A01F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbcG2S1t (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:27:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:51255 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753266AbcG2S1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:27:47 -0400
Received: (qmail 6729 invoked by uid 102); 29 Jul 2016 18:27:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:27:47 -0400
Received: (qmail 4270 invoked by uid 107); 29 Jul 2016 18:28:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:28:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:27:43 -0400
Date:	Fri, 29 Jul 2016 14:27:43 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, e@80x24.org,
	ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 0/5] Git filter protocol
Message-ID: <20160729182743.GA9877@sigill.intra.peff.net>
References: <20160727000605.49982-1-larsxschneider@gmail.com>
 <579906C5.1050809@gmail.com>
 <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
 <20160728132906.GA21311@sigill.intra.peff.net>
 <579B087F.7090108@gmail.com>
 <31219A33-CA8A-44D1-9DE0-6448AA1A7571@gmail.com>
 <20160729155740.GB29773@sigill.intra.peff.net>
 <FA73FFDF-51D1-49FD-A24E-72A2C033E2F3@gmail.com>
 <20160729165018.GA6553@sigill.intra.peff.net>
 <9C2A3438-84BA-49FE-87AA-1084995A1E89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9C2A3438-84BA-49FE-87AA-1084995A1E89@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 07:43:49PM +0200, Lars Schneider wrote:

> Here is the reject case (non-streaming):
> 
> git> smudge
> git> <filename>
> git> <size>
> git> ...pkt-lines...
> git> pktline-flush
> 
> git< 0
> git< reject
> 
> 
> Do you see a problem with this approach?

Only that it seemed a little weird to me to have to write a meaningless
"0" when "reject" covers the situation entirely. I don't think it's
wrong, though (and even in some ways right, because it decouples the
meaning of "reject" from the syntax of parsing, but I think it's OK for
the protocol parser to understand the difference between success and
failure codes).

-Peff
