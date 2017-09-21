Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEA720A29
	for <e@80x24.org>; Thu, 21 Sep 2017 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbdIUQYS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:24:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:46108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751531AbdIUQYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:24:17 -0400
Received: (qmail 352 invoked by uid 109); 21 Sep 2017 16:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 16:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23711 invoked by uid 111); 21 Sep 2017 16:24:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 12:24:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 12:24:15 -0400
Date:   Thu, 21 Sep 2017 12:24:15 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Document the string_list structure
Message-ID: <20170921162414.h3lapq6ahdbamlu6@sigill.intra.peff.net>
References: <20170921124338.26626-1-hanwen@google.com>
 <20170921124338.26626-3-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921124338.26626-3-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 02:43:38PM +0200, Han-Wen Nienhuys wrote:

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  string-list.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/string-list.h b/string-list.h
> index 29bfb7ae4..08b534166 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -8,6 +8,12 @@ struct string_list_item {
>  
>  typedef int (*compare_strings_fn)(const char *, const char *);
>  
> +/* A resizable array of strings. The strings are owned if
> + * 'strdup_strings' is set. It can be used as a sorted array, and a
> + * custom comparison may be given in 'cmp'. The field 'items[i].util'
> + * may be used to implement an array of pairs. In that case, the
> + * caller is responsible for managing memory pointed to by 'util'.
> + */
>  struct string_list {
>  	struct string_list_item *items;
>  	unsigned int nr, alloc;

There's a considerable amount of documentation for string-list in
Documentation/technical/api-string-list.txt.

Perhaps we should look at migrating it into string-list.h, where it's
more likely to be found (and kept up to date). We did something similar
for strbuf.h a while back, and I think the result is much better. See
the commits in:

  git log bdfdaa4978^..d468fa2721

for an example.

-Peff
