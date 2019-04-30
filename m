Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F63C1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 17:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3RlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 13:41:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:44782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725942AbfD3RlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 13:41:13 -0400
Received: (qmail 25328 invoked by uid 109); 30 Apr 2019 17:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 17:41:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10869 invoked by uid 111); 30 Apr 2019 17:41:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 13:41:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 13:41:10 -0400
Date:   Tue, 30 Apr 2019 13:41:10 -0400
From:   Jeff King <peff@peff.net>
To:     Aleksey Midenkov <midenok@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
Message-ID: <20190430174110.GA16729@sigill.intra.peff.net>
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 02:19:11PM +0300, Aleksey Midenkov wrote:

> > I gave it about 2000 commits (from v2.20.1 to master on git.git) to
> > rebase. No luck.
> 
> Please, try on this repo: git@github.com:tempesta-tech/mariadb
> 
> ```
> git checkout 62a082f573
> git rebase -p -x /tmp/check.sh ca7fbcea6c4
> ```

It doesn't reproduce for me.

Usually when we see racy contention on index.lock, the culprit turns out
to be another unrelated git process refreshing the index. Do you have
anything else running which might be using "git status" (e.g., magit in
emacs, vim git integration, etc)?

-Peff
