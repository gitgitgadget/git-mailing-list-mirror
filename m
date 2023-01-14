Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F9C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjANO5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjANO5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 09:57:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55FE83D3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 06:57:40 -0800 (PST)
Received: (qmail 29689 invoked by uid 109); 14 Jan 2023 14:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jan 2023 14:57:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10457 invoked by uid 111); 14 Jan 2023 14:57:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jan 2023 09:57:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Jan 2023 09:57:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8LC44cxKt0wfB7q@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 09:47:38AM -0500, Jeff King wrote:

> As Ramsay suggested, we could probably use CURL_DISABLE_DEPRECATION to
> limit this just to the problematic case. An even more focused option is
> to use curl's helper here:
> 
> diff --git a/http.c b/http.c
> index 17d954dd95..21891493d9 100644
> --- a/http.c
> +++ b/http.c
> @@ -1,3 +1,4 @@
> +#define CURL_DISABLE_TYPECHECK 1

Oops, this line snuck in from my testing. See my other message for why
it's relevant. ;)

-Peff
