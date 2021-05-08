Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9EC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 03:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6627261288
	for <git@archiver.kernel.org>; Sat,  8 May 2021 03:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhEHDLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 23:11:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:47942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhEHDLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 23:11:53 -0400
Received: (qmail 5308 invoked by uid 109); 8 May 2021 03:10:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 May 2021 03:10:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7941 invoked by uid 111); 8 May 2021 03:10:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 23:10:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 23:10:50 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJYBOrm2cQkkVteb@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <6095ceb984401_cfc7208b9@natae.notmuch>
 <YJXT7AaqCeCV4WcZ@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJXT7AaqCeCV4WcZ@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 11:57:32PM +0000, brian m. carlson wrote:

> It's not quite that simple.  It requires changes to
> asciidoctor-extensions.rb and we also need to consider
> NO_MAN_BOLD_LITERAL and GNU_ROFF.  The latter especially is likely to be
> inconvenient, since according to the Makefile, it's impossible to write
> man output that works across troff versions.
> 
> We will also want to preserve the ability to use xmlto because we
> currently have doc-diff which helps us find divergences in the behavior
> of AsciiDoc and Asciidoctor, many of which affect all formats, and that
> will be completely useless if we use two different rendering toolchains.

Speaking of doc-diff: with that patch applied, try "./doc-diff
--asciidoctor HEAD^ HEAD", which shows quite a few of the complications
(another one seems to be that all of the linkgit macros are broken).

-Peff
