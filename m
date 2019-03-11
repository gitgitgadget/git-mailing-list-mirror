Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E9A20248
	for <e@80x24.org>; Mon, 11 Mar 2019 02:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCKC7y (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 22:59:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726871AbfCKC7y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 22:59:54 -0400
Received: (qmail 18694 invoked by uid 109); 11 Mar 2019 02:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 02:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19534 invoked by uid 111); 11 Mar 2019 03:00:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 10 Mar 2019 23:00:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2019 22:59:52 -0400
Date:   Sun, 10 Mar 2019 22:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] fix spurious space after linkgit, now in *.html
Message-ID: <20190311025952.GA6425@sigill.intra.peff.net>
References: <xmqqmumc3g1h.fsf@gitster-ct.c.googlers.com>
 <cover.1552230490.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552230490.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 04:14:22PM +0100, Martin Ågren wrote:

> [1] I could have sworn I checked the html docs and saw that they didn't
> have this extra space. Looking at git-scm.com again reveals that it's
> not there. Huh. Seems like the site's html-rendering doesn't go through our
> Makefile at all and handles "linkgit:" on its own:
> https://github.com/git/git-scm.com/blob/master/script/doc_importer

Correct. It significantly predates any support for asciidoctor in our
Makefile, and needs to do some custom ruby-level tweaking (though
possibly that could be cleaned up these days).

The doc_importer script you found, though, is not part of that process.
I _think_ it's just leftover cruft. The actual import and conversion
happens as part of the rake task in:

  https://github.com/git/git-scm.com/blob/master/lib/tasks/index.rake

(Not that any of this matters for your series; just sprinkling some fun
facts into the conversation).

-Peff
