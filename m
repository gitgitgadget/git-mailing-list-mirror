Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9A91F453
	for <e@80x24.org>; Mon,  1 Oct 2018 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeJBCvc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:51:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:37722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725936AbeJBCvc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:51:32 -0400
Received: (qmail 21296 invoked by uid 109); 1 Oct 2018 20:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Oct 2018 20:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21579 invoked by uid 111); 1 Oct 2018 20:11:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Oct 2018 16:11:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2018 16:12:02 -0400
Date:   Mon, 1 Oct 2018 16:12:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #04; Thu, 20)
Message-ID: <20181001201202.GA10234@sigill.intra.peff.net>
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
 <c5f7009b-53b5-26b9-8a01-b8648ee33a15@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5f7009b-53b5-26b9-8a01-b8648ee33a15@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 09:16:07PM +0200, René Scharfe wrote:

> Am 21.09.2018 um 07:22 schrieb Junio C Hamano:
> > * cc/delta-islands (2018-08-16) 7 commits
> [...]
> > * jk/pack-delta-reuse-with-bitmap (2018-08-21) 6 commits
>
> Not sure if it's the interaction of the two topics or if only one of
> them is to blame, but the result of the merge can dereference a NULL
> pointer.  Found using Clang's UBSan and t5310.
> 
> Here's a patch that avoids the issue, but I don't know if it's the
> right thing to do -- should we rather treat a non-existing base as
> "not from the same island" instead?
> 
> And it's certainly ugly -- that condition is complicated enough
> already.  Splitting it up in a nice way would probably help, but how?

Perhaps like in 2fa233a554 (pack-objects: handle island check for
"external" delta base, 2018-09-18)?

-Peff
