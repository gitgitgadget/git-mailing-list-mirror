Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39EC51F405
	for <e@80x24.org>; Mon, 17 Dec 2018 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbeLQP7S (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 10:59:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:43892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732405AbeLQP7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 10:59:18 -0500
Received: (qmail 2590 invoked by uid 109); 17 Dec 2018 15:59:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 15:59:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3950 invoked by uid 111); 17 Dec 2018 15:58:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 10:58:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 10:59:15 -0500
Date:   Mon, 17 Dec 2018 10:59:15 -0500
From:   Jeff King <peff@peff.net>
To:     Issac Trotts <issac.trotts@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Noemi Mercado <noemi@sourcegraph.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
Message-ID: <20181217155915.GA914@sigill.intra.peff.net>
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 10:25:14PM -0800, Issac Trotts wrote:

> Make it possible to write for example
> 
>         git log --format="%H,%S"
> 
> where the %S at the end is a new placeholder that prints out the ref
> (tag/branch) for each commit.

Seems like a reasonable thing to want.

One curious thing about "--source" is that it requires cooperation from
the actual traversal. So if you did:

  git rev-list | git diff-tree --format="%H %S"

we don't have the %S information in the latter command. I think that's
probably acceptable as long as it does something sane when we don't have
that information (e.g., replace it with an empty string). It might also
be worth calling out in the documentation.

-Peff
