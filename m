Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4971E1F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 08:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeCWI4k (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 04:56:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:39748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751675AbeCWI4j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 04:56:39 -0400
Received: (qmail 4370 invoked by uid 109); 23 Mar 2018 08:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Mar 2018 08:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26271 invoked by uid 111); 23 Mar 2018 08:57:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Mar 2018 04:57:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2018 04:56:37 -0400
Date:   Fri, 23 Mar 2018 04:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Greenberg <p@aaronjgreenberg.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
Subject: Re: [PATCH] branch: implement shortcut to delete last branch
Message-ID: <20180323085636.GA24416@sigill.intra.peff.net>
References: <1521770966-18383-1-git-send-email-p@aaronjgreenberg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521770966-18383-1-git-send-email-p@aaronjgreenberg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 02:09:25AM +0000, Aaron Greenberg wrote:

> This patch gives git-branch the ability to delete the previous
> checked-out branch using the "-" shortcut. This shortcut already exists
> for git-checkout, git-merge, and git-revert. One of my common workflows
> is to do some work on a local topic branch and push it to a remote,
> where it gets merged in to 'master'. Then, I switch back to my local
> master, fetch the remote master, and delete the previous topic branch.
> 
> $ git checkout -b topic-a
> $ # Do some work...
> $ git commit -am "Implement feature A"
> $ git push origin topic-a
> 
> # 'origin/topic-a' gets merged into 'origin/master'
> 
> $ git checkout master
> $ git branch -d topic-a
> $ # With this patch, a user could simply type
> $ git branch -d -
> 
> I think it's a useful shortcut for cleaning up a just-merged branch
> (or a just switched-from branch.)

I don't use "-" myself, but I can see how this would be useful. Do note
that in a discussion last year there was some hesitation about allowing
"-" for destructive commands:

  https://public-inbox.org/git/vpqh944eof7.fsf@anie.imag.fr/

I don't really have a strong opinion either way.

The details in this cover letter probably should go into the commit
message. The diff itself looks OK (the assumption of a 7-char
abbreviation in the test is a little gross, but I see you're just
following existing convention in the file).

-Peff
