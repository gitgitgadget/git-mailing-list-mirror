Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F8C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1056220705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgAHJLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:11:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:60080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727112AbgAHJLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 04:11:20 -0500
Received: (qmail 20871 invoked by uid 109); 8 Jan 2020 09:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 09:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8235 invoked by uid 111); 8 Jan 2020 09:16:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 04:16:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 04:11:19 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten Krah <krah.tm@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
Message-ID: <20200108091119.GB87523@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
 <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
 <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 04:28:24PM +0100, Torsten Krah wrote:

> I can reproduce that (locally) at least:
> 
> What does *not* work for me:
> 
>    git clone XX main
>    cd main
>    git fetch XX && git checkout FETCH_HEAD
>    git checkout -b TEST
>    git reset --soft HEAD~1
>    git restore --staged $FILES
> 
> git status now lists $FILES as unstaged and they are not included in
> the staging area.
> 
>    git commit
> 
> -> now $FILES are included in the commit (I would expect them not to be
> included - right?) and git status does list those still in the working
> area.

That step seems wrong, and I can't reproduce it here. If "git status"
lists the files as unstaged, then "git commit" should not be committing
them. Can you show us a more complete example that we can run ourselves
(i.e., that does not rely on whatever is in "main", and what is in
$FILES)? Barring that, can you show us the output of the commands, as
well as "git show FETCH_HEAD FETCH_HEAD~1"?

-Peff
