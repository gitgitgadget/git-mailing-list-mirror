Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4FB720958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbdCTSm5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:42:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47937 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932523AbdCTSm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:42:56 -0400
Received: (qmail 15812 invoked by uid 109); 20 Mar 2017 18:42:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:42:55 +0000
Received: (qmail 4651 invoked by uid 111); 20 Mar 2017 18:43:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:43:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:42:51 -0400
Date:   Mon, 20 Mar 2017 14:42:51 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 1/3] stash: show less information for stash push --
 <pathspec>
Message-ID: <20170320184250.rkpgx4sl6zzqzelw@sigill.intra.peff.net>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170319202351.8825-2-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 08:23:49PM +0000, Thomas Gummerer wrote:

> When using git stash push -- <pathspec> in the following sequence:
> 
>        git init -q repo
>        cd repo
> 
>        for i in one two; do
>                echo content >$i
>                git add $i
>        done
>        git commit -qm base
> 
>        for i in one two; do
>                echo change >$i
>        done
>        git stash -- one
> 
> it shows:
> 
>    Saved working directory and index state WIP on master: 20cfadf base
>    Unstaged changes after reset:
>     M   one
>     M   two
> 
> Even though "one" no longer has unstaged changes.
> 
> It really is enough for the user to know that the stash is created,
> without bothering them with the internal details of what's happening.
> Always pass the -q flag to git clean and git reset in the pathspec case,
> to avoid unnecessary and potentially confusing output.

Yeah, on further reflection, this is definitely the right thing to do.

-Peff
