Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B4C1F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 14:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeGEOVN (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 10:21:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:49552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753418AbeGEOVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 10:21:13 -0400
Received: (qmail 29941 invoked by uid 109); 5 Jul 2018 14:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Jul 2018 14:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15537 invoked by uid 111); 5 Jul 2018 14:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Jul 2018 10:21:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jul 2018 10:21:11 -0400
Date:   Thu, 5 Jul 2018 10:21:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
Message-ID: <20180705142110.GA10192@sigill.intra.peff.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530654455.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1530654455.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 04:51:52PM -0500, Taylor Blau wrote:

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 0de3493b80..be13fc3253 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>  	   [-l | --files-with-matches] [-L | --files-without-match]
>  	   [(-O | --open-files-in-pager) [<pager>]]
>  	   [-z | --null]
> -	   [-c | --count] [--all-match] [-q | --quiet]
> +	   [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
>  	   [--max-depth <depth>]
>  	   [--color[=<when>] | --no-color]
>  	   [--break] [--heading] [-p | --show-function]
> @@ -201,6 +201,10 @@ providing this option will cause it to die.
>  	Output \0 instead of the character that normally follows a
>  	file name.
> 
> +-o::
> +--only-matching::
> +  Output only the matching part of the lines.
> +

Putting myself into the shoes of a naive reader, I have to wonder what
happens when there are multiple matching parts on the same line. I know
the answer from your commit message, but maybe that should be covered
here? Maybe:

  Output only the matching part of the lines. If there are multiple
  matching parts, each is output on a separate line.

-Peff
