Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C451DC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F2206A5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="jjGFEEMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLKV6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:58:31 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLKV6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 16:58:31 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 47Y9mP2P4nz9sR7; Thu, 12 Dec 2019 08:58:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1576101509; bh=mxn/lJ3nBiYLb8NOKdyDEp3ff5jsqp0pQAK1BWL0C/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjGFEEMFjCLau/sq2pueS987gxua+e3t7RlFZlTWZSfXvAd47adWsDzk7YnVCWDyt
         yS/S2vCb6Ugx6S801WpNGRcP4zpN7b29z7f2/GUSEDuH2iNpNl23fupvIlt9Oy3MOS
         XgitT1ScJoCY3KFId/XpmB9dnjyuSIJcNixdyywDKRI1VHYfhpmAF7gbcwyF/ra+12
         lL5aPppO22cTMF4mf7lCxKs8awA+iKpwZSxKDPpJ0eLSpv+yxzrm9BhUkVzVSKyGl2
         DQTakKJHH4m00dp1jFObnFITetFdY1ndQ5/BzgvYyhxcvX7L7Ut95DDXcBRcBsxFvv
         CKKiR964MyIbw==
Date:   Thu, 12 Dec 2019 08:58:26 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] gitk: use --pretty=reference for copysummary
Message-ID: <20191211215826.GA31614@blackberry>
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 01:39:50PM -0800, Denton Liu wrote:
> In an earlier commit[1], git learned the 'reference' pretty format.
> Update copysummary to use this pretty format instead of manually
> reimplementing it as a format string.
> 
> With this change, we lose the double-quotes surrounding the commit
> subject but it seems the consensus is that the unquoted form is used
> more often anyway[2] so this change should be acceptable.
> 
> Since gitk and git are usually packaged and distributed together, their
> versions should be in sync so we should not have to worry a newer gitk
> running on top of an older version of git that doesn't support the
> 'reference' pretty format.

In fact my policy is not to do this (introduce a change to gitk that
means it requires the very latest git).  I would want the code either
to test the git version (which the code already does in other places)
or handle failure gracefully and fall back to the old command.

Paul.
