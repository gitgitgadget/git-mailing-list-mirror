Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5BC1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 22:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503296AbfIWW1B (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 18:27:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2503270AbfIWW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 18:27:01 -0400
Received: (qmail 30912 invoked by uid 109); 23 Sep 2019 22:27:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 22:27:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4924 invoked by uid 111); 23 Sep 2019 22:29:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 18:29:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 18:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git: use COPY_ARRAY and MOVE_ARRAY in handle_alias()
Message-ID: <20190923222659.GA22645@sigill.intra.peff.net>
References: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 10:48:30PM +0200, René Scharfe wrote:

> Use the macro COPY_ARRAY to copy array elements and MOVE_ARRAY to do the
> same for moving them backwards in an array with potential overlap.  The
> result is shorter and safer, as it infers the element type automatically
> and does a (very) basic type compatibility check for its first two
> arguments.
> 
> These cases were missed by Coccinelle and contrib/coccinelle/array.cocci
> because the type of the elements is "const char *", not "char *", and
> the rules in the semantic patch cautiously insist on the sizeof operator
> being used on exactly the same type to avoid generating transformations
> that introduce subtle bugs into tricky code.

Another good reason to use "sizeof(var)" instead of sizeof(type)". :)

The patch looks good.

-Peff
