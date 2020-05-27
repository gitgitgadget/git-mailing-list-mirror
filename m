Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E212CC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DFB2073B
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgE0Hee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 03:34:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:57142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgE0Hed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 03:34:33 -0400
Received: (qmail 20486 invoked by uid 109); 27 May 2020 07:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 07:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1613 invoked by uid 111); 27 May 2020 07:34:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 03:34:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 03:34:32 -0400
From:   Jeff King <peff@peff.net>
To:     Erik Janssen <eaw.janssen@chello.nl>
Cc:     git@vger.kernel.org
Subject: Re: [Feature request] Add -u option to git rm to delete untracked
 files
Message-ID: <20200527073432.GD4006199@coredump.intra.peff.net>
References: <1098602171.79502.1590528083387@mail.ziggo.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1098602171.79502.1590528083387@mail.ziggo.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 11:21:23PM +0200, Erik Janssen wrote:

> Would it be feasible to add a -u option to git rm to specify that I
> also want a file deleted if it is not tracked by git?

It might be a little tricky, as I suspect the code is starting from the
set of tracked files, and then applying the arguments of pathspecs (but
I didn't look too carefully, so I might be wrong).

The "git clean" command is made for this (and starts by iterating over
the filesystem), and does exactly what you want. But I guess you are
hoping for a state where you can just run "git rm" without having to
think about whether the file is tracked or not.

-Peff
