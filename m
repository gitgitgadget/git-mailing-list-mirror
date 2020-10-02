Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAABC4727D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 12:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE949206A2
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 12:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgJBMB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:01:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:47692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBMB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 08:01:27 -0400
Received: (qmail 7052 invoked by uid 109); 2 Oct 2020 12:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2020 12:01:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22100 invoked by uid 111); 2 Oct 2020 12:01:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2020 08:01:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Oct 2020 08:01:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 1/3] credential.c: fix credential reading with regards
 to CR/LF
Message-ID: <20201002120126.GA2255314@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
 <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com>
 <20200929004220.GC898702@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010021011540.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 02, 2020 at 01:37:23PM +0200, Johannes Schindelin wrote:

> But I would highly doubt that the empty lines were the biggest problem:
> Sure, we would fail to recognize an empty line with CR/LF line endings
> when reading with `strbuf_getline_lf()`, but we would totally
> misunderstand the entire rest of the lines, too. For example, we would
> mistake `quit\r` for an unknown command, and hence simply ignore it.
> 
> I do agree, however, that your confusion validly points out a flaw in the
> commit message: the "empty line" comment is a red herring.
> 
> Therefore, I spent some time pouring over the commit message. This is my
> current version:
> [...]
> What do you think?

I think we are on the same page, and this revision does a good job of
fixing my complaint about the commit message. Thanks. One minor typo:

>     While we do this for the credential helper protocol, we do _not_ do
>     adjust `git credential-cache--daemon` (which won't work on Windows,

s/do$//

-Peff
