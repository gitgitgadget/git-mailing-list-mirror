Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9691F790
	for <e@80x24.org>; Wed,  3 May 2017 01:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdECBtn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 21:49:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:44285 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbdECBtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 21:49:42 -0400
Received: (qmail 2196 invoked by uid 109); 3 May 2017 01:49:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 01:49:39 +0000
Received: (qmail 19296 invoked by uid 111); 3 May 2017 01:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 21:50:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 May 2017 21:49:36 -0400
Date:   Tue, 2 May 2017 21:49:36 -0400
From:   Jeff King <peff@peff.net>
To:     Paul van Wichen <paul.vanwichen@cloudcheckr.com>
Cc:     git@vger.kernel.org
Subject: Re: Git checkout issue - deleting file without apparent reason
Message-ID: <20170503014936.emvtrb4edbvauzqc@sigill.intra.peff.net>
References: <CAK6FQHcHxwCgzGFCnV_3wvX-sVvL8cHpZH11x6ffbzxUJTTGCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK6FQHcHxwCgzGFCnV_3wvX-sVvL8cHpZH11x6ffbzxUJTTGCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2017 at 09:33:02PM -0400, Paul van Wichen wrote:

> We are having a strange issue that we haven't been able to pin down.
> Scenario: master branch and feature branch both have a specific file.
> 1. Master checked out.
> 2. git status show no changes / clean staging area.
> 3. Checkout feature branch .
> 4. git status show no changes / clean staging area.
> 5. Checkout master again.
> 6. git status shows that a file has been deleted (i.e. the file was
> removed from the file system and the staging area shows it as
> deleted).
> 
> The file exists in both the feature branch and the master branch. As
> best as we can tell, the file is identical on both commits.
> The issue occurs on multiple platforms - tested on Windows and OS X.
> It only occurs for 1 specific file.

Just a guess, but might there be another file in the repository whose
name differs only in case? On a case-insensitive filesystem that can
cause gremlins like this, because the filesystem cannot represent all of
the states in the git tree.

-Peff
