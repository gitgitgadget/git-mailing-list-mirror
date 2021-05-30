Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DAAC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19C860E0C
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhE3VtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:49:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:41546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhE3VtG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:49:06 -0400
Received: (qmail 18973 invoked by uid 109); 30 May 2021 21:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 May 2021 21:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22190 invoked by uid 111); 30 May 2021 21:47:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 May 2021 17:47:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 30 May 2021 17:47:26 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, dyroneteng@gmail.com,
        levraiphilippeblain@gmail.com, stolee@gmail.com
Subject: Re: [PATCH] clone: caveat note on converting partial clone
Message-ID: <YLQH7i5IPSdBnDko@coredump.intra.peff.net>
References: <20210529120730.38472-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210529120730.38472-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 29, 2021 at 07:07:31PM +0700, Bagas Sanjaya wrote:

> Currently partial clones can't be converted into full clones, because
> there is an issue where the remote can't send all missing objects
> required.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  This patch is based on "clone: document partial clone section" by Teng
>  Long [1].
> 
>  [1]:
> https://lore.kernel.org/git/pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com/

Wouldn't:

  git -c fetch.negotiationAlgorithm=noop fetch ...

work?

IMHO that is not ideal, and I would like to see it work even when we
provide "have" lines to the server. But if we are going to tell users
something in the documentation, pointing them to this technique is
probably much more helpful than saying "it can't be done".

-Peff
