Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D37C55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 03:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ED1206CD
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 03:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDXD4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:56:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:38304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725982AbgDXD43 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 23:56:29 -0400
Received: (qmail 19507 invoked by uid 109); 24 Apr 2020 03:56:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 03:56:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16400 invoked by uid 111); 24 Apr 2020 04:07:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 00:07:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Apr 2020 23:56:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        szeder.dev@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 4/4] commit-graph: close descriptors after mmap
Message-ID: <20200424035628.GA1648190@coredump.intra.peff.net>
References: <cover.1587677671.git.me@ttaylorr.com>
 <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
 <xmqq368tg8po.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq368tg8po.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 03:04:19PM -0700, Junio C Hamano wrote:

> With this fix, with or without the other topics still in flight, I
> do not think no code touches graph_fd.  Should we remove the
> graph_fd field from the structure as well?

Oops, I thought I did.

> diff --git a/commit-graph.h b/commit-graph.h
> index a0a2c4a1e5..1254eae948 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -40,8 +40,6 @@ struct tree *get_commit_tree_in_graph(struct repository *r,
>  				      const struct commit *c);
>  
>  struct commit_graph {
> -	int graph_fd;
> -

Yes, this should definitely be squashed in.

-Peff
