Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAC41F404
	for <e@80x24.org>; Tue, 11 Sep 2018 01:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeIKGyy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 02:54:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726194AbeIKGyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 02:54:53 -0400
Received: (qmail 3553 invoked by uid 109); 11 Sep 2018 01:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Sep 2018 01:58:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14083 invoked by uid 111); 11 Sep 2018 01:58:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 21:58:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 21:58:00 -0400
Date:   Mon, 10 Sep 2018 21:58:00 -0400
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
Message-ID: <20180911015800.GB5838@sigill.intra.peff.net>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180910205359.32332-1-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 11:53:59PM +0300, Max Kirillov wrote:

> From: Jeff King <peff@peff.net>
> Subject: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
> 
> There is no known case where empty body it used by a server as
> instruction to read until EOF, so there is no need to violate the RFC.
> Make get_content_length() return 0 in this case.
> 
> Currently there is no practical difference, as the GET request
> where it can be empty is handled without actual reading the body
> (in get_info_refs() function), but it is better to stick to the correct
> behavior.

There could be a difference if there is a server which actually sets
CONTENT_LENGTH to the empty string for a chunked body. But we don't know
of any such server at this point.

> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> The incremental. Hopefully I described the reason right. Needs "signed-off-by"

Certainly this is:

  Signed-off-by: Jeff King <peff@peff.net>

-Peff
