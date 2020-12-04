Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BFCC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8C622CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgLDVMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:12:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:52352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgLDVMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:12:19 -0500
Received: (qmail 1011 invoked by uid 109); 4 Dec 2020 21:11:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 21:11:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16871 invoked by uid 111); 4 Dec 2020 21:11:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 16:11:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 16:11:38 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: determine list of extra built-ins dynamically
Message-ID: <X8qmClPjwYWIoExP@coredump.intra.peff.net>
References: <pull.807.git.1607110436367.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.807.git.1607110436367.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 07:33:56PM +0000, Johannes Schindelin via GitGitGadget wrote:

> In 0a21d0e08902 (Makefile: mark git-maintenance as a builtin,
> 2020-12-01), we marked git-maintenance as a builtin in the Makefile, but
> forgot to do the same in `CMakeLists.txt`.

Oof, right.

> Rather than always play catch-up and adjust `git_builtin_extra`
> manually, use the `BUILT_INS` definitions in the Makefile as
> authoritative source and generate `git_builtin_extra` dynamically.

Yay. This is exactly how I'd hoped things would work or the cmake file
in general. I don't mind following micro-formats within our Makefile to
keep things easier for the cmake parsing side.

>  contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

The implementation looks plausibly correct to me (bearing in mind that
I've never written cmake).

-Peff
