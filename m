Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD668202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 18:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbdIUSZy (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 14:25:54 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:54875 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbdIUSZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 14:25:53 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3xylRM54Kzz5tlG;
        Thu, 21 Sep 2017 20:25:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EE5972090;
        Thu, 21 Sep 2017 20:25:50 +0200 (CEST)
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
Date:   Thu, 21 Sep 2017 20:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.2017 um 06:32 schrieb Jeff King:
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6e3a6767e5..8dd3ae05ae 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -159,6 +159,10 @@ foo.bar= ...`) sets `foo.bar` to the empty string which ` git config
>   	Add "icase" magic to all pathspec. This is equivalent to setting
>   	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
>   
> +--no-optional-locks::
> +	Do not perform optional operations that require locks. This is
> +	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
> +
>   GIT COMMANDS
>   ------------
>   
> @@ -697,6 +701,15 @@ of clones and fetches.
>   	which feed potentially-untrusted URLS to git commands.  See
>   	linkgit:git-config[1] for more details.
>   
> +`GIT_OPTIONAL_LOCKS`::
> +	If set to `0`, Git will avoid performing any operations which
> +	require taking a lock and which are not required to complete the
> +	requested operation. For example, this will prevent `git status`
> +	from refreshing the index as a side effect. This is useful for
> +	processes running in the background which do not want to cause
> +	lock contention with other operations on the repository.
> +	Defaults to `1`.

I don't think we should pass this environment variable to remote 
repositories. It should be listed in local_repo_env[] in environment.c.

-- Hannes
