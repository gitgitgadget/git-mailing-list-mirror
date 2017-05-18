Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B7F201CF
	for <e@80x24.org>; Thu, 18 May 2017 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755356AbdERQAB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 12:00:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:54263 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdERQAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 12:00:00 -0400
Received: (qmail 11685 invoked by uid 109); 18 May 2017 15:59:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 15:59:58 +0000
Received: (qmail 18247 invoked by uid 111); 18 May 2017 16:00:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 12:00:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 11:59:56 -0400
Date:   Thu, 18 May 2017 11:59:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?QW5kcsOp?= Werlang <beppe85@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: explain default option for rev-parse --short
Message-ID: <20170518155956.ecti4audvrqlj3pt@sigill.intra.peff.net>
References: <CAP96LmMtfO5DC6hGeqJdZvcqj+29H_7=8S+uua8YC7YwFRC9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP96LmMtfO5DC6hGeqJdZvcqj+29H_7=8S+uua8YC7YwFRC9Nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 11:03:00AM -0300, André Werlang wrote:

> Git 2.11 introduced a computation to guess the default length
> for commit short hashes. The documentation isn't updated.

Thanks for the patch. I think this is going in the right direction, but
I have a few minor comments.

> From 2b1c229153a89c7608e64b87d2f933704c18b7ae Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Andr=C3=A9=20Werlang?= <beppe85@gmail.com>
> Date: Thu, 18 May 2017 10:50:11 -0300
> Subject: [PATCH] doc: explain default option for rev-parse --short
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

These headers are redundant with what's in your email headers and can be
dropped.

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 7241e96..b49f053 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -139,8 +139,10 @@ can be used.
>  --short::
>  --short=number::
>   Instead of outputting the full SHA-1 values of object names try to
> - abbreviate them to a shorter unique name. When no length is specified
> - 7 is used. The minimum length is 4.
> + abbreviate them to a shorter unique name. When no length is specified,
> + it is guessed from the number of objects in the repository. In any case,
> + the actual length will be enough to identify the object unambiguously
> + in the current state of the repository. The minimum length is 4.

This is definitely an improvement, though I wonder if we should mention
that we default to core.abbrev (which in turn defaults to the "auto"
behavior).

It looks like there are a few other mentions of "7" with respect to
"--abbrev": git-branch.txt, git-describe.txt, git-blame.txt. Those
should probably get the same treatment.

There are a few other "--abbrev" options (e.g., ls-files and ls-tree)
that don't mention "7". But while we're fixing the others, it may be
worth giving them all consistent text.

-Peff
