Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D737C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CF32076A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414577AbgDOPLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:11:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:54536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1414570AbgDOPLb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:11:31 -0400
Received: (qmail 12481 invoked by uid 109); 15 Apr 2020 15:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 15:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4205 invoked by uid 111); 15 Apr 2020 15:22:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 11:22:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 11:11:28 -0400
From:   Jeff King <peff@peff.net>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Move some files, with all history, from one project into a new
 one
Message-ID: <20200415151128.GA2464307@coredump.intra.peff.net>
References: <AM0PR02MB3715F9566BD9FEFAF832F0749CDB0@AM0PR02MB3715.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR02MB3715F9566BD9FEFAF832F0749CDB0@AM0PR02MB3715.eurprd02.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 08:31:35AM +0000, Kerry, Richard wrote:

> I would like to move some files, from the project in which they have
> always resided into  a new project.  I would like to keep all their
> history.  I don't want to waste space by also moving the rest of the
> old project's history, or historical file contents.

Try git-filter-branch's --subdirectory repository, which is designed to
do exactly this.

Or the much newer (and faster) git-filter-repo:

  https://github.com/newren/git-filter-repo

> Do I create a new branch, then delete the rest of main-system leaving
> only what I want?  Surely if I do that then I would end up with all
> the main-system file data within the new repo, which would expand its
> size.  Is there a recommended way to extract certain files with their
> histories?

Correct; just deleting files and creating a new commit will still carry
them in the history. You have to rewrite the old commits.

-Peff
