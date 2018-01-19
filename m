Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F6A1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeASVxs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:53:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:50162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932584AbeASVxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:53:46 -0500
Received: (qmail 26005 invoked by uid 109); 19 Jan 2018 21:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 21:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25008 invoked by uid 111); 19 Jan 2018 21:54:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 16:54:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 16:53:44 -0500
Date:   Fri, 19 Jan 2018 16:53:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement
 --stat
Message-ID: <20180119215344.GD12074@sigill.intra.peff.net>
References: <20180113132211.13350-1-pclouds@gmail.com>
 <20180118100546.32251-1-pclouds@gmail.com>
 <xmqq607xpmty.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq607xpmty.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 01:20:41PM -0800, Junio C Hamano wrote:

> >      Documentation/merge-config.txt     |  4 ++
> >      builtin/merge.c                    |  2 +
> >  A+x t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++
> >      t/t7612-merge-verify-signatures.sh | 45 +++++++++++++
> >  4 files changed, 132 insertions(+)
> 
> I like the concept but given that additions and mode changes are
> rare events, I am not so sure if it is worth always wasting three
> columns like the above.  Assuming that this is solely meant for
> human consumption and machine parsability is of no concern, I
> actually prefer the output format you said you've been using your
> personal fork, e.g.
> 
>  Documentation/merge-config.txt              |  4 ++
>  builtin/merge.c                             |  2 +
>  t/t5573-pull-verify-signatures.sh (new, +x) | 81 ++++++++++++++++++++++++
>  t/t7612-merge-verify-signatures.sh          | 45 +++++++++++++
> 
> That is
> 
>  (1) do not change the starting column at the leftmost end, and
>  (2) do not permanently allocate the columns for "compact" summary.

I think the patch already does (2). In fact, it computes the max
compact-status size (so if you only have "A" and not "A+x", it wastes
only the one column).

I agree that (1) would save space in some cases, though IMHO it's a
little hard to notice.

-Peff
