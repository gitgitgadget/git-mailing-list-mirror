Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C9F1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 07:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeI2ONb (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:13:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:36130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727502AbeI2ONb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:13:31 -0400
Received: (qmail 9771 invoked by uid 109); 29 Sep 2018 07:46:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 07:46:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4524 invoked by uid 111); 29 Sep 2018 07:45:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 03:45:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 03:46:04 -0400
Date:   Sat, 29 Sep 2018 03:46:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
Message-ID: <20180929074603.GF2174@sigill.intra.peff.net>
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
 <20180927212727.128214-1-sbeller@google.com>
 <20180927232732.GA216193@aiede.svl.corp.google.com>
 <20180928011129.GD11281@sigill.intra.peff.net>
 <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 09:50:14AM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: CodingGuidelines: document the API in *.h files
> 
> It makes it harder to let the API description and the reality drift
> apart if the doc is kept close to the implementation or the header
> of the API.  We have been slowly migrating API docs out of the
> Documentation/technical/api-* to *.h files, and the development
> community generally considers that how inline docs in strbuf.h is
> done the best current practice.
> 
> We recommend documenting in the header over documenting near the
> implementation to encourage people to write the docs that are
> readable without peeking at the implemention.

Yeah, I agree with all of that rationale.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 6d265327c9..e87090c849 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -385,7 +385,11 @@ For C programs:
>     string_list for sorted string lists, a hash map (mapping struct
>     objects) named "struct decorate", amongst other things.
>  
> - - When you come up with an API, document it.
> + - When you come up with an API, document it the functions and the
> +   structures in the header file that exposes the API to its callers.
> +   Use what is in "strbuf.h" as a model to decide the appropriate tone
> +   in which the description is given, and the level of details to put
> +   in the description.

I like the general idea here. I had trouble parsing the "in which the
description is given". Maybe just:

  When you come up with an API, document its functions and structures in
  the header file that exposes the API to its callers. Use what is in
  "strbuf.h" as a model for the appropriate tone and level of detail.

I like the idea you mentioned elsewhere of polishing up strbuf.h to
serve as the model (but I don't want to hold up this much simpler patch
if that seems likely to drag on).

Thanks for pushing this towards a concrete conclusion.

-Peff
