Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8231F42D
	for <e@80x24.org>; Wed, 25 Apr 2018 09:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeDYJVj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:21:39 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:44968 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeDYJVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:21:36 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id BGcHf8epr4ZqzBGcIfo6NB; Wed, 25 Apr 2018 10:21:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524648094;
        bh=WqxVzU5O7Vm5kMiUXNsn66SZsYEuXkh/6/kbLoPV2Jg=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=FY6Wk3XYJjjXIXoYN8UnJ6iTKDvznX3bDJjoYcj3cFmMI9IwrnKQogj+lO8m2oirK
         ON66KNN0WiGrXhx8QYszEHBL1M+nYF/ez3TspoVmy/iXz6aZFF2mESQZIGAu0w8Cd3
         /NqKr17np80cA/2HW8stDIlRc8n6HYiCh4oYWPIs=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=A9qS8gIqAAAA:8
 a=5Ai05V15-9nS2OxGVcAA:9 a=QEXdDO2ut3YA:10 a=H28RkzuXznr5akrmL4QT:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
To:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <36d622ac-f07d-7fd9-65dd-94f88b0e2f56@talktalk.net>
Date:   Wed, 25 Apr 2018 10:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAzICDjU525AsDrz3GkdCDgVEp0DEGuvvUbMbNAlD1uCy+4Ya3WjTFJOHl868/d/odGNb11067s5wSE3LvhoTgNAIT3aBjlU0eXD4SFTEqFIf8cdc6v/
 rIK0PULMiSKCXHXWzXHJ1dfD4OSgRbB6ccQ+yRSs3pQF0NhOQQn36MsTZ8Swklq3t2TE0/4IztK51IhMwKzPEtKYY2AXBdxhA3g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/18 17:59, Johannes Sixt wrote:
> 
> In modern setups, less, the pager, uses alternate screen to show
> the content. When it is closed, it switches back to the original
> screen, and all content is gone.

Are you setting LESS explicitly in the environment?

 From the git config man page:
When the LESS environment variable is unset, Git sets it to FRX (if LESS 
environment variable is set, Git does not change it at all).

 From the less man page the X option:
Disables  sending the termcap initialization and deinitialization 
strings to the terminal.  This is sometimes desirable if the 
deinitialization string does something unnecessary, like clearing the 
screen.

So with the default setup the output should remain on the screen.

Best Wishes

Phillip


> It is not uncommon to request that the output remains visible in
> the terminal. For this, the option --no-pager can be used. But
> it is a bit cumbersome to type, even when command completion is
> available. Provide a short option, -N, to make the option easier
> accessible.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>   Documentation/git.txt | 3 ++-
>   git.c                 | 4 ++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 4767860e72..17b50b0dc6 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>   [verse]
>   'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
>       [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
> -    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
> +    [-p|--paginate|-N|--no-pager] [--no-replace-objects] [--bare]
>       [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
>       [--super-prefix=<path>]
>       <command> [<args>]
> @@ -103,6 +103,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>   	configuration options (see the "Configuration Mechanism" section
>   	below).
>   
> +-N::
>   --no-pager::
>   	Do not pipe Git output into a pager.
>   
> diff --git a/git.c b/git.c
> index ceaa58ef40..9e2d78f442 100644
> --- a/git.c
> +++ b/git.c
> @@ -7,7 +7,7 @@
>   const char git_usage_string[] =
>   	N_("git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
>   	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
> -	   "           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
> +	   "           [-p | --paginate | -N | --no-pager] [--no-replace-objects] [--bare]\n"
>   	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
>   	   "           <command> [<args>]");
>   
> @@ -81,7 +81,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   			exit(0);
>   		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
>   			use_pager = 1;
> -		} else if (!strcmp(cmd, "--no-pager")) {
> +		} else if (!strcmp(cmd, "-N") || !strcmp(cmd, "--no-pager")) {
>   			use_pager = 0;
>   			if (envchanged)
>   				*envchanged = 1;
> 

