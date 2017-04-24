Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12159207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 12:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169811AbdDXM3R (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 08:29:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:39018 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1169797AbdDXM3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 08:29:16 -0400
Received: (qmail 27959 invoked by uid 109); 24 Apr 2017 12:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 12:29:13 +0000
Received: (qmail 6122 invoked by uid 111); 24 Apr 2017 12:29:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 08:29:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 08:29:11 -0400
Date:   Mon, 24 Apr 2017 08:29:11 -0400
From:   Jeff King <peff@peff.net>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, martin.von.zweigbergk@gmail.com
Subject: Re: [PATCH] rebase -i: add config to abbreviate command name
Message-ID: <20170424122911.5mvftamplokwctbr@sigill.intra.peff.net>
References: <20170424032347.10878-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170424032347.10878-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 11:23:47PM -0400, Liam Beguin wrote:

> Add the 'rebase.abbrevCmd' boolean config option to allow
> the user to abbreviate the default command name while editing
> the 'git-rebase-todo' file.

Just reading this, I was confused about what the patch actually did.
Reading the code, I figured it out, but perhaps an example would make
sense. Like:

  This means that we will print:

    p 1234abcd subject line

  in the todo file rather than:

    pick 1234abcd subject line

And then of course that left me wondering why somebody would want to do
that. I understand wanting to _type_ the abbreviated version, but surely
it's not too much work to read the full word?

Then I saw:

> ---
> Notes:
> 
>  *  This allows the lines to remain aligned when using single
>     letter commands.

That makes some sense. it should probably be part of the commit message,
so that future readers of "git log" understand why the change was made.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5155..59b64832aeb4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2614,6 +2614,9 @@ rebase.instructionFormat::
>  	the instruction list during an interactive rebase.  The format will automatically
>  	have the long commit hash prepended to the format.
>  
> +rebase.abbrevCmd::
> +	If set to true, abbreviate command name in interactive mode.

Similar to the commit message, this might need to go into more detail.
It was not immediately obvious to me that "command name" means the
command-names in the instruction list.

-Peff
