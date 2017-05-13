Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09E5201A4
	for <e@80x24.org>; Sat, 13 May 2017 06:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdEMGnw (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 02:43:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:50693 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdEMGnv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 02:43:51 -0400
Received: (qmail 18770 invoked by uid 109); 13 May 2017 06:43:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 06:43:49 +0000
Received: (qmail 30109 invoked by uid 111); 13 May 2017 06:44:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 02:44:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 02:43:48 -0400
Date:   Sat, 13 May 2017 02:43:48 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Best "triangle" workflow setup?
Message-ID: <20170513064348.wwnkle4bkhih2clx@sigill.intra.peff.net>
References: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
 <20170511201707.aobrdiompzg6wu5k@sigill.intra.peff.net>
 <CAHd499AvDRH-KZ7piOE=QsVXSpMt0u5jVXUC=7UPnRVLYo-U5Q@mail.gmail.com>
 <20170511233640.ylf4to3hotngh6xe@sigill.intra.peff.net>
 <CAHd499A=wwxFxZ2mq=PZcOBNRSiK1Xm_sE79AypBXQaYU_UcJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499A=wwxFxZ2mq=PZcOBNRSiK1Xm_sE79AypBXQaYU_UcJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 09:53:23AM -0500, Robert Dailey wrote:

> Thanks, just curious, where in the git documentation is the "origin"
> to "origin/HEAD" resolution documented? I checked the git-revisions
> page but it doesn't seem to mention it there. Thanks for explaining
> though.

In gitrevisions(7), the <refname> section, rule 6:

  otherwise, refs/remotes/<refname>/HEAD if it exists.

And then the contents of origin/HEAD are discussed a bit in
git-remote(1), under set-head.

> Also is there a similar mechanism for "track same-named branch on
> specified remote"? Something like "origin/."? I follow git-flow
> development process, so topic branches on hotfix or release branches
> will track origin/master (since origin/HEAD still points to master or
> develop). But I want to track "origin/release/1.2.3" without typing
> the full thing. Basically would be nice if there was a lazy shorthand
> for it similar to the "origin/HEAD" example you gave.

No, I don't think there's a shorthand for "the same-named branch". But
there are two things that might help:

  1. If you're always branching from release/1.2.3 instead of "master",
     you can use "git remote set-head" to change it.

  2. If you want a local branch "foo" to track refs/remotes/origin/foo
     (which already exists) then the checkout-dwim should work for you:

        $ git checkout foo
	Branch foo set up to track remote branch foo from origin.
	Switched to a new branch 'foo'

-Peff
