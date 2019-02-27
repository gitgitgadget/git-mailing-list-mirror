Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BAA120248
	for <e@80x24.org>; Wed, 27 Feb 2019 16:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfB0Qk7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 11:40:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:60044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726389AbfB0Qk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 11:40:58 -0500
Received: (qmail 6379 invoked by uid 109); 27 Feb 2019 16:40:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 16:40:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7236 invoked by uid 111); 27 Feb 2019 16:41:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 11:41:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 11:40:56 -0500
Date:   Wed, 27 Feb 2019 11:40:56 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
Message-ID: <20190227164056.GA2062@sigill.intra.peff.net>
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
 <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
 <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 08:02:35AM -0800, Elijah Newren wrote:

> > > I have found what I suspect to be a bug, or at least not desirable
> > > behavior in my case. In one branch, I have moved all files in a
> > > directory to another directory. The first directory is now empty
> > > in this branch (I haven't tested whether this is significant).
> >
> > I suspect that because you've moved all the files git thinks the
> > directory has been renamed and that's why it moves a/file2 when fix is
> > cherry-picked in the example below. I've cc'd Elijah as he knows more
> > about how the directory rename detection works.
> 
> Yes, Phillip is correct.  If the branch you were
> merging/cherry-picking still had any files at all in the original
> directory, then no directory rename would be detected.  You can read
> up more details about how it works at
> https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/technical/directory-rename-detection.txt

Is there a way to disable it (either by config, or for a single run)? I
know there's merge.renames, but it's plausible somebody might want
file-level renames but not directory-level ones.

-Peff
