Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBBC20248
	for <e@80x24.org>; Mon,  1 Apr 2019 13:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDANSe (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 09:18:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:42874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726473AbfDANSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 09:18:34 -0400
Received: (qmail 25084 invoked by uid 109); 1 Apr 2019 13:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Apr 2019 13:18:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13187 invoked by uid 111); 1 Apr 2019 13:18:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Apr 2019 09:18:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2019 09:18:32 -0400
Date:   Mon, 1 Apr 2019 09:18:32 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/2] Documentation/git-status: fix titles in porcelain
 v2 section
Message-ID: <20190401131831.GA12254@sigill.intra.peff.net>
References: <20190330183001.16624-1-tmz@pobox.com>
 <20190330183001.16624-3-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190330183001.16624-3-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 02:30:01PM -0400, Todd Zullinger wrote:

> Asciidoc uses either one-line or two-line syntax for document/section
> titles[1].  The two-line form is used in git-status.  Fix a few section
> titles in the porcelain v2 section which were inadvertently using
> markdown syntax.

Yep, makes sense. One observation:

> -### Branch Headers
> +Branch Headers
> +^^^^^^^^^^^^^^

The one-line equivalent in asciidoc would be something like:

  === Branch Headers

but that's actually a "level 2" header (because it counts from zero),
whereas "^" underlining is a "level 3" header. But I think "^" is right
here, because this is under level 2 "~" header.

> As an aside, while I was reading the Asciidoc/tor manuals, I notice the
> two-line title syntax was not mentioned in Asciidoctor.  That seems to
> be because Asciidoctor has suggested the two-line title format should be
> deprecated, as discussed at:
> 
>     https://github.com/asciidoctor/asciidoctor/issues/418
> 
> I'm not sure how likely that is to occur.  With the 2.0 release,
> asciidoctor plans to use semantic versioning, so I would not expect any
> deprecation to happen before at least 2.1.  It would only affect use
> without compat-mode.

I think it's probably fine to punt on this until we see some actual
movement upstream on the deprecation / removal.

One side note. The original asciidoc user guide says one-line headers
have equals on either side, like:

  === Branch Headers ===

but that one can omit the trailing delimiter. The asciidoctor reference
just suggests using the one-sided:

  === Branch Headers

So presumably if we do want to convert, we would just go with the
one-sided version.

-Peff
