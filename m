Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF84C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 04:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC6A61942
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 04:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZEXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 00:23:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:49470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCZEWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 00:22:42 -0400
Received: (qmail 28493 invoked by uid 109); 26 Mar 2021 04:22:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 04:22:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7444 invoked by uid 111); 26 Mar 2021 04:22:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 00:22:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 00:22:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] daemon: sanitize all directory separators
Message-ID: <YF1hkaoFU4CV9zna@coredump.intra.peff.net>
References: <314451a4-ee8f-fb68-016f-66a4f3bea409@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314451a4-ee8f-fb68-016f-66a4f3bea409@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 05:21:24PM +0100, René Scharfe. wrote:

> When sanitizing client-supplied strings on Windows, also strip off
> backslashes, not just slashes.
> [...]
>  static void sanitize_client(struct strbuf *out, const char *in)
>  {
>  	for (; *in; in++) {
> -		if (*in == '/')
> +		if (is_dir_sep(*in))

Yeah, this seems like the obviously correct thing to be doing.

-Peff
