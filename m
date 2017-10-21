Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D255202FC
	for <e@80x24.org>; Sat, 21 Oct 2017 06:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdJUG0U (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 02:26:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:59766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750961AbdJUG0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 02:26:19 -0400
Received: (qmail 10118 invoked by uid 109); 21 Oct 2017 06:26:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 06:26:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22683 invoked by uid 111); 21 Oct 2017 06:26:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 02:26:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2017 02:26:17 -0400
Date:   Sat, 21 Oct 2017 02:26:17 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v2 1/2] replace git stash save with git stash push in the
 documentation
Message-ID: <20171021062617.yajqusruqanjnicb@sigill.intra.peff.net>
References: <20171005200049.GF30301@hank>
 <20171019183304.26748-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019183304.26748-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 07:33:03PM +0100, Thomas Gummerer wrote:

> diff --git a/git-stash.sh b/git-stash.sh
> index 8b2ce9afda..16919277ba 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -267,11 +267,11 @@ push_stash () {
>  			# translation of "error: " takes in your language. E.g. in
>  			# English this is:
>  			#
> -			#    $ git stash save --blah-blah 2>&1 | head -n 2
> -			#    error: unknown option for 'stash save': --blah-blah
> -			#           To provide a message, use git stash save -- '--blah-blah'
> -			eval_gettextln "error: unknown option for 'stash save': \$option
> -       To provide a message, use git stash save -- '\$option'"
> +			#    $ git stash push --blah-blah 2>&1 | head -n 2
> +			#    error: unknown option for 'stash push': --blah-blah
> +			#           To provide a message, use git stash push -- '--blah-blah'
> +			eval_gettextln "error: unknown option for 'stash push': \$option
> +       To provide a message, use git stash push -m '\$option'"

The user message is fixed here, but doesn't the message for translators
need the same treatment?  I guess it's just talking about the spacing,
so it doesn't need to be completely accurate. But it probably makes
sense to update it at the same time.

As an aside, I do kind of wonder if the right advice for "push" is
different than for "save" here. I.e., should it say "to provide a
pathspec that starts with --, use push -- --blah-blah". I'm not sure it
matters that much. Second-guessing what a user meant seems likely to go
wrong (e.g., "--icnlude-untracked" would trigger this message, which is
just silly). But that's largely orthogonal to what you're doing here.

-Peff
