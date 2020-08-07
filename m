Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42029C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A95221E4
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHGDJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:09:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGDJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 23:09:27 -0400
Received: (qmail 27982 invoked by uid 109); 7 Aug 2020 03:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 03:09:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6108 invoked by uid 111); 7 Aug 2020 00:02:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Aug 2020 20:02:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Aug 2020 20:02:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     PANEL Christian <ch.panel@free.fr>, git@vger.kernel.org
Subject: Re: git bug
Message-ID: <20200807000226.GA12088@coredump.intra.peff.net>
References: <1596725319.6764.7.camel@free.fr>
 <5387a5b7-4551-53a0-abdb-e26cc2702536@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5387a5b7-4551-53a0-abdb-e26cc2702536@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 10:23:54PM +0200, René Scharfe wrote:

> So "file" is no longer ignored.  Committing the .gitignore change
> doesn't change that:
> 
>   $ git add .gitignore
>   $ git commit -m 2nd
>   [master d4c95a1] 2nd
>    1 file changed, 1 deletion(-)
>   $ git status
>   On branch master
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>   	file
> 
>   nothing added to commit but untracked files present (use "git add" to track)
> 
> Which steps did you take to arrive at a different result?

Perhaps also:

  git check-ignore -v file

would be helpful for seeing why Git thinks it might be ignored (e.g.,
another wildcard rule that happens to match it).

-Peff
