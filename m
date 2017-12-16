Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930EB1F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbdLPJsq (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:48:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:41312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750907AbdLPJsn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:48:43 -0500
Received: (qmail 24024 invoked by uid 109); 16 Dec 2017 09:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 16 Dec 2017 09:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14922 invoked by uid 111); 16 Dec 2017 09:49:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 16 Dec 2017 04:49:07 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Dec 2017 04:48:41 -0500
Date:   Sat, 16 Dec 2017 04:48:41 -0500
From:   Jeff King <peff@peff.net>
To:     Asfand Qazi <ayqazi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Trying to use insteadOf trick to use different SSH keys for
 separate github accounts - not working
Message-ID: <20171216094840.GA32706@sigill.intra.peff.net>
References: <CAFTSPUV1E+jCMHzx+rq9Y1agthxcYrzDVY-rThTNCG7BfnPeTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFTSPUV1E+jCMHzx+rq9Y1agthxcYrzDVY-rThTNCG7BfnPeTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 16, 2017 at 07:50:02AM +0000, Asfand Qazi wrote:

> I found out about the 'insteadOf' setting, and thought it would work.
> So I added this to my global git config:
> 
> [url "git@github.com:MyCompany/"]
> insteadOf = git@work.github.com:MyCompany/
> 
> and left the SSH hostname setting where it was. Then I tried doing:
> 
> git clone git:github.com/MyCompany/la-repo.git
> 
> But it won't work. With GIT_TRACE=2, I get:

If I'm reading it right, you have the config backwards. You want to
convert git@github.com from Go's invocation of Git into your special
"work" alias. So:

  [url "git@work.github.com:MyCompany/"]
  insteadOf = "git@github.com:MyCompany/"

-Peff
