Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC172098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945496AbcJSPqg (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:46:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:59464 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942863AbcJSPqe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:46:34 -0400
Received: (qmail 5452 invoked by uid 109); 19 Oct 2016 08:55:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 08:55:44 +0000
Received: (qmail 11184 invoked by uid 111); 19 Oct 2016 08:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 04:56:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 04:55:43 -0400
Date:   Wed, 19 Oct 2016 04:55:43 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v4 2/7] ref-filter: add function to print single
 ref_array_item
Message-ID: <20161019085543.om7v7eowfaushags@sigill.intra.peff.net>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-3-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161007210721.20437-3-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 05:07:16PM -0400, santiago@nyu.edu wrote:

> From: Lukas Puehringer <luk.puehringer@gmail.com>
> 
> ref-filter functions are useful for printing git object information
> using a format specifier. However, some other modules may not want to use
> this functionality on a ref-array but only print a single item.
> 
> Expose a pretty_print_ref function to create, pretty print and free
> individual ref-items.

Makes sense.

> diff --git a/ref-filter.h b/ref-filter.h
> index 14d435e..3d23090 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -107,4 +107,7 @@ struct ref_sorting *ref_default_sorting(void);
>  /*  Function to parse --merged and --no-merged options */
>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
>  
> +void pretty_print_ref(const char *name, const unsigned char *sha1,
> +		const char *format, unsigned kind);
> +

What are the possible values for "kind"? I guess these should come from
FILTER_REFS_TAGS, BRANCHES, etc. It's probably worth documenting that.
Alternatively, is it possible to just determine this from the name? It
looks like filter_ref_kind() is how it happens for a normal ref-filter.

-Peff
