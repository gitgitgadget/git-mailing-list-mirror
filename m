Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCEC20248
	for <e@80x24.org>; Tue, 19 Mar 2019 03:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCSDUz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 23:20:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:55964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726817AbfCSDUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 23:20:55 -0400
Received: (qmail 29101 invoked by uid 109); 19 Mar 2019 03:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 03:14:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26160 invoked by uid 111); 19 Mar 2019 03:14:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 23:14:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 23:14:12 -0400
Date:   Mon, 18 Mar 2019 23:14:12 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] doc-diff: support diffing from/to AsciiDoc(tor)
Message-ID: <20190319031412.GC6173@sigill.intra.peff.net>
References: <cover.1552838239.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552838239.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 07:35:59PM +0100, Martin Ågren wrote:

> I've taught `doc-diff` a few new knobs to support usage like
> 
>   $ ./doc-diff --from-asciidoc --to-asciidoctor HEAD HEAD
> 
> and I don't think I've messed it up too badly in the process. I'm open
> to the idea that this might not be interesting to a whole lot of people.
> But I have made some progress on fixing up Asciidoctor *and* AsciiDoc
> issues using this, and once the output of the above command is empty --
> which might not be too far off -- it could be interesting to try and
> keep it that way using a bit of automation around these switches.

Very nice. All the patches look good to me.

The "from" and "to" variants of the options are a little awkward; these
are really properties of the actual endpoints. It would be nice if we
had some fixed syntax that defined the whole state, like:

  ./doc-diff asciidoc:HEAD asciidoctor:HEAD^

or something. But I think as you introduce new options (like the
header/footer cutting) that syntax would get pretty unwieldy. So
probably the separate options is the best way forward.

> While using/testing these patches, I've made some progress on the
> rendering of the headers and footers in Asciidoctor [1], so the
> `--cut-header-footer` switch that I'm adding in the final patch might
> hopefully not be necessary for too long. But we'd still need a
> `--cut-footer` switch -- at least I would, on my system [2]. If this
> series is considered generally sane, I'd be happy to rework the final
> patch to `--cut-header` if that's preferred.

I think what's here is fine for now. This is our own internal script, so
if options become useless later on, we can always cull them.

> [2] After [1], the date in the footer is still formatted differently
>     here. It might be a locale thing, and I tend to shy away from even
>     trying to understand those. :-/

Yeah, mine too.

-Peff
