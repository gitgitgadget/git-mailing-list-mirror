Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702CC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EDD20836
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgBRFal (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:30:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:46534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725878AbgBRFal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 00:30:41 -0500
Received: (qmail 14456 invoked by uid 109); 18 Feb 2020 05:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 05:30:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14598 invoked by uid 111); 18 Feb 2020 05:39:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 00:39:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 00:30:40 -0500
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-receive-pack: document push options
Message-ID: <20200218053040.GC1641086@coredump.intra.peff.net>
References: <20200217144432.43920-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217144432.43920-1-sir@cmpwn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 09:44:31AM -0500, Drew DeVault wrote:

>  Documentation/git-receive-pack.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index 25702ed730..69b3e77776 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -109,6 +109,12 @@ the following environment variables:
>  This hook is called before any refname is updated and before any
>  fast-forward checks are performed.
>  
> +If the user has specified any push options (see linkgit:git-push[1]),
> +`GIT_PUSH_OPTION_COUNT` is set to the number of options, and
> +`GIT_PUSH_OPTION_N` is set where N is an integer from 0 thru
> +`GIT_PUSH_OPTION_COUNT` - 1. In order for to receive push options,
> +`receive.advertisePushOptions` must be enabled on the server.

Hmm. This is covered already in the pre-receive sections of githooks(7).
I wonder if it would be worth consolidating those and having one refer
to the other.

I'd be OK just duplicating the content in the meantime, but note that
the githooks version covers some more subtleties (like setting the count
to 0 when push options are negotiated but none are sent).

If we do go with the text above, there's a typo: s/for to/to/.

-Peff
