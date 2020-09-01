Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0FC433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893C12071B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 07:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIAHi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:38:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:45976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 03:38:28 -0400
Received: (qmail 24564 invoked by uid 109); 1 Sep 2020 07:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2020 07:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24139 invoked by uid 111); 1 Sep 2020 07:38:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 03:38:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 03:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation
 database
Message-ID: <20200901073827.GA3967005@coredump.intra.peff.net>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
 <20200830221004.GB241078@camp.crustytoothpaste.net>
 <xmqqsgc3h28s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgc3h28s.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 30, 2020 at 09:24:03PM -0700, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2020-08-30 at 19:28:27, Philippe Blain via GitGitGadget wrote:
> >> From: Philippe Blain <levraiphilippeblain@gmail.com>
> >> 
> >> Tools based on LibClang [1] can make use of a 'JSON Compilation
> >> Database' [2] that keeps track of the exact options used to compile a set
> >> of source files.
> >
> > For additional context why this is valuable, clangd, which is a C
> > language server protocol implementation, can use these files to
> > determine the flags needed to compile a file so it can provide proper
> > editor integration.  As a result, editors supporting the language server
> > protocol (such as VS Code, or Vim with a suitable plugin) can provide
> > better searching, integration, and refactoring tools.
> 
> I found that the proposed commit log was very weak to sell the
> change; some of what you gave above should definitely help strenthen
> it.

Likewise. Looking at the output, I'm confused how it would help with
things like searching and refactoring. It might be nice to spell it out
for those of us exposed to it for the first time (I tried following the
links but remained unenlightened).

I'd also be curious to hear what advantages it gives to add a new
Makefile knob rather than just letting interested parties add -MJ to
their CFLAGS. Is it just a convenience to create the concatenated form?
It seems weird that projects would need to do so themselves with sed
hackery (i.e., I'd expect whatever consumes this json to be able to
handle multiple files).

-Peff
