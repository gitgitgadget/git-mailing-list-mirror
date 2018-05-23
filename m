Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FD41F51C
	for <e@80x24.org>; Wed, 23 May 2018 06:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbeEWGQz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 02:16:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:49962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753872AbeEWGQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 02:16:54 -0400
Received: (qmail 19526 invoked by uid 109); 23 May 2018 06:16:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 May 2018 06:16:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12653 invoked by uid 111); 23 May 2018 06:17:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 May 2018 02:17:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 May 2018 02:16:52 -0400
Date:   Wed, 23 May 2018 02:16:52 -0400
From:   Jeff King <peff@peff.net>
To:     Chris <jesdisciple@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git push => git: 'credential-winstore' is not a git command.
Message-ID: <20180523061652.GA13157@sigill.intra.peff.net>
References: <CAN_7rfcZHkbfaVO5A989Dza-zu7eRSPTKag9pcyB4v9=HWbKKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN_7rfcZHkbfaVO5A989Dza-zu7eRSPTKag9pcyB4v9=HWbKKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 10:17:54AM -0500, Chris wrote:

> git config --global --unset credential.helper
> 
> 
> This did help me, because previously Git was trying to authenticate me
> with the Microsoft account I use to log into my Windows, which is
> unrelated to the account I need to use to push code. And it removed
> one of the two "git: 'credential-winstore' is not a git command."
> messages I was receiving.
> 
> But I still get one of them, so I tried reinstalling Git for Windows
> with the credential helper disabled, but that didn't help. Then I ran
> this command:
> 
> git config -e
> 
> 
> And couldn't find any mention of [credential].

That command will only edit the local repository's config file. You may
have other config for your user (--global) or for the machine
(--system).

Try:

  git config --show-origin --get-regexp credential.*

to see any related config you have, and which file it comes from (you
can also just do "--show-origin --list" to see all of the config).

> What can I do to get rid of this annoying message (and, for all I
> know, potential symptom of a larger problem)?

I don't know enough about Git for Windows packaging to know whether
you're supposed to have the winstore credential helper installed. So it
could be a symptom of some kind of installation problem. But in general,
a missing credential helper isn't a big deal (it just means that Git
can't ask it for a credential and will end up prompting you or using a
different helper).

-Peff
