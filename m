Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C908C47254
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112182073B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgEDPBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:01:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:35810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728983AbgEDPBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:01:06 -0400
Received: (qmail 31166 invoked by uid 109); 4 May 2020 15:01:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 15:01:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17569 invoked by uid 111); 4 May 2020 15:01:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 11:01:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 11:01:05 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: respect the [skip ci] convention in our GitHub
 workflow "CI/PR"
Message-ID: <20200504150105.GB11373@coredump.intra.peff.net>
References: <pull.776.git.git.1588432087854.gitgitgadget@gmail.com>
 <20200503093646.GC170902@coredump.intra.peff.net>
 <20200503120546.GB28680@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200503120546.GB28680@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 07:05:46PM +0700, Danh Doan wrote:

> This is my proposal for it:
> [...]
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index fd4df939b5..303393ba73 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -1,6 +1,19 @@
>  name: CI/PR
>  
> -on: [push, pull_request]
> +on:
> +  pull_request:
> +    branches:
> +      - '*'
> +  push:
> +    branches:
> +      - maint
> +      - master
> +      - next
> +      - jch
> +      - pu
> +      - 'for-ci/**'
> +    tags:
> +      - '*'

Yeah, this seems quite reasonable to me. I'd just add a refspec to push
a duplicate of branches I'm interested in running CI on to for-ci.

-Peff
