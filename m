Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2D4C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 03:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjDFD5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 23:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjDFD5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 23:57:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F34203
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 20:57:31 -0700 (PDT)
Received: (qmail 12084 invoked by uid 109); 6 Apr 2023 03:57:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 03:57:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22004 invoked by uid 111); 6 Apr 2023 03:57:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 23:57:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 23:57:29 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
Message-ID: <20230406035729.GA2092667@coredump.intra.peff.net>
References: <20230323221523.52472-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323221523.52472-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 04:15:23PM -0600, Felipe Contreras wrote:

> In 2007 we added a custom header macro to provide version information
> 7ef195ba3e (Documentation: Add version information to man pages,
> 2007-03-25),
> 
> However, in 2008 asciidoc added the attributes to do this properly [1].
> 
> This was not implemented in Git until 2019: 226daba280 (Doc/Makefile:
> give mansource/-version/-manual attributes, 2019-09-16).
> 
> But in 2023 we are doing it properly, so there's no need for the custom
> macro.
> 
> [1] https://github.com/asciidoc-py/asciidoc-py/commit/ad78a3c

This should be OK to do, as it is just touching the python asciidoc
side. When we discussed those attributes in 2019:

  https://lore.kernel.org/git/20190320183229.GK31362@pobox.com/

asciidoctor support was new and incomplete. It needed v1.5.7 (from
2018), and even today still does not seem to handle manversion. But
since this patch leaves in place the equivalent hack in
asciidoctor-extensions.rb, it will continue working.

  Aside: If we think asciidoctor 1.5.7 is recent enough to rely on, then
  we might want to simplify our hack to just output manversion. Right
  now we generate duplicate "source" and "manual" lines, though docbook
  seems to do OK with it.

-Peff
