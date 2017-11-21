Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE392036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdKUVpy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:45:54 -0500
Received: from ikke.info ([178.21.113.177]:39222 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdKUVpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:45:53 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 548714400DB; Tue, 21 Nov 2017 22:45:52 +0100 (CET)
Date:   Tue, 21 Nov 2017 22:45:52 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171121214552.GB16418@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 04:27:59PM -0500, Robert P. J. Day wrote:
> No major changes, just some rewording and showing some variations of
> general Git commands.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 9f13266a6..d690d1ff0 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -13,7 +13,7 @@ gitcli
>  DESCRIPTION
>  -----------
> 
> -This manual describes the convention used throughout Git CLI.
> +This manual describes the conventions used throughout Git CLI.
> 
>  Many commands take revisions (most often "commits", but sometimes
>  "tree-ish", depending on the context and command) and paths as their
> @@ -32,32 +32,35 @@ arguments.  Here are the rules:
>     between the HEAD commit and the work tree as a whole".  You can say
>     `git diff HEAD --` to ask for the latter.
> 
> - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> + * Without a disambiguating `--`, Git makes a reasonable guess, but can
> +   error out, asking you to disambiguate when ambiguous.  E.g. if you have a

'Can' error out implies that it sometimes would not error out when there
is ambiguity. Are there situation where git does not error out in that
case?

>     file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
>     you have to say either `git diff HEAD --` or `git diff -- HEAD` to
>     disambiguate.
>  +
>  When writing a script that is expected to handle random user-input, it is
>  a good practice to make it explicit which arguments are which by placing
> -disambiguating `--` at appropriate places.
> +a disambiguating `--` at appropriate places.
> 
>   * Many commands allow wildcards in paths, but you need to protect
> -   them from getting globbed by the shell.  These two mean different
> -   things:
> +   them from getting globbed by the shell.  The following commands have
> +   two different meanings:
>  +
>  --------------------------------
>  $ git checkout -- *.c
> +
>  $ git checkout -- \*.c
> +$ git checkout -- "*.c"
> +$ git checkout -- '*.c'
>  --------------------------------
>  +
> -The former lets your shell expand the fileglob, and you are asking
> -the dot-C files in your working tree to be overwritten with the version
> -in the index.  The latter passes the `*.c` to Git, and you are asking
> -the paths in the index that match the pattern to be checked out to your
> -working tree.  After running `git add hello.c; rm hello.c`, you will _not_
> -see `hello.c` in your working tree with the former, but with the latter
> -you will.
> +The first command lets your shell expand the fileglob, and you are asking
> +the dot-C files in your working tree to be overwritten with the version in
> +the index.  The latter three variations pass the `*.c` to Git, and you are
> +asking the paths in the index that match the pattern to be checked out to
> +your working tree.  After running `git add hello.c; rm hello.c`, you will
> +_not_ see `hello.c` in your working tree with the first command, but with
> +the latter three variations, you will.
> 
>   * Just as the filesystem '.' (period) refers to the current directory,
>     using a '.' as a repository name in Git (a dot-repository) is a relative
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
