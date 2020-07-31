Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D110C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0022C2083B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgGaRlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:41:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43852 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733153AbgGaRlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:41:51 -0400
Received: (qmail 23276 invoked by uid 109); 31 Jul 2020 17:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 17:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28535 invoked by uid 111); 31 Jul 2020 17:41:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 13:41:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 13:41:49 -0400
From:   Jeff King <peff@peff.net>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Diff --stat for files that differ only in whitespace
Message-ID: <20200731174149.GB843002@coredump.intra.peff.net>
References: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 09:10:44AM -0400, Matt Rogers wrote:

> When using a repository with "core.autocrlf=false" I'm trying to run a diff
> between two commits that have many files (~1000) changed that differ mostly
> in line endings or other whitespace.  When I run
> `git diff --stat --ignore-all-space <commit-1> <commit-2>` I'm getting an output
> that has many files listed like:
> 
> some-file.txt | 0

This seemed familiar, so I dug up some prior discussion here:

  https://lore.kernel.org/git/1484704915.2096.16.camel@mattmccutchen.net/

We didn't come to a resolution there, but there is a patch to play with,
and I think nobody was opposed to the notion that with the right
code change we could be suppressing these whitespace-only stat lines

-Peff
