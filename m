Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEDC433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 11:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C55023102
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 11:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbhALLiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 06:38:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:53274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730185AbhALLiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 06:38:01 -0500
Received: (qmail 8994 invoked by uid 109); 12 Jan 2021 11:37:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 11:37:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12554 invoked by uid 111); 12 Jan 2021 11:37:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 06:37:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 06:37:20 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
Message-ID: <X/2J8KL/Jig/xttF@coredump.intra.peff.net>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
 <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 08:47:35AM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/sha1dc_git.c b/sha1dc_git.c
> index 5c300e812e0..fecf5da1483 100644
> --- a/sha1dc_git.c
> +++ b/sha1dc_git.c
> @@ -18,7 +18,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
>  {
>  	if (!SHA1DCFinal(hash, ctx))
>  		return;
> -	die("SHA-1 appears to be part of a collision attack: %s",
> +	die(_("SHA-1 appears to be part of a collision attack: %s"),
>  	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));

I didn't find any list discussion, but I think I may have actually left
this untranslated intentionally. Like a BUG(), we'd expect it to come up
basically never. And when it does, being able to search for the exact
wording online may be more important than providing a translated
version.

It probably doesn't matter that much either way, though.

-Peff
