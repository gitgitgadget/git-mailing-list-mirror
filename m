Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19FD1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbcFQXko (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:40:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:56505 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751103AbcFQXko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:40:44 -0400
Received: (qmail 8374 invoked by uid 102); 17 Jun 2016 23:40:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:40:44 -0400
Received: (qmail 30407 invoked by uid 107); 17 Jun 2016 23:40:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:40:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:40:41 -0400
Date:	Fri, 17 Jun 2016 19:40:41 -0400
From:	Jeff King <peff@peff.net>
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] archive-tar: add UL type suffix to unsigned long constant
Message-ID: <20160617234041.GC26564@sigill.intra.peff.net>
References: <57646646.9060407@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57646646.9060407@ramsayjones.plus.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 10:06:14PM +0100, Ramsay Jones wrote:

> If you need to re-roll your 'jk/big-and-old-archive-tar' branch, could
> you please squash this into the relevant patch (commit 8035a1e3,
> "archive-tar: write extended headers for far-future mtime", 16-06-2016).
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  archive-tar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/archive-tar.c b/archive-tar.c
> index 749722f..c7b85fd 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -187,7 +187,7 @@ static inline unsigned long ustar_size(uintmax_t size)
>  
>  static inline unsigned long ustar_mtime(time_t mtime)
>  {
> -	if (mtime < 077777777777)
> +	if (mtime < 077777777777UL)

Whoops. I even got it right in the similar line above. :-/

This did make me wonder how the whole thing fares on a system where
"unsigned long" is 32-bit (AIUI, Git for Windows is such a system).

The sizes passed around (here and all through git) are "unsigned long",
so I don't think we're making anything _worse_.

-Peff
