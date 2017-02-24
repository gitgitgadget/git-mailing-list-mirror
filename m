Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DE82022D
	for <e@80x24.org>; Fri, 24 Feb 2017 01:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbdBXBZi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 20:25:38 -0500
Received: from avasout01.plus.net ([84.93.230.227]:59711 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdBXBZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 20:25:37 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id oRRa1u00322aPyA01RRbQz; Fri, 24 Feb 2017 01:25:35 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=IItyMknG c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=H3Jr-aWNjtW9oiqvgoEA:9 a=QEXdDO2ut3YA:10
 a=nJcEw6yWrPvoIXZ49MH8:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 15/15] builtin/checkout: add --recurse-submodules switch
To:     Stefan Beller <sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
 <20170223225735.10994-16-sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <db5cfde2-a769-d786-8846-a5a526194b69@ramsayjones.plus.com>
Date:   Fri, 24 Feb 2017 01:25:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170223225735.10994-16-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/02/17 22:57, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-checkout.txt |  7 +++++++
>  builtin/checkout.c             | 28 ++++++++++++++++++++++++++++
>  t/lib-submodule-update.sh      | 33 ++++++++++++++++++++++++---------
>  t/t2013-checkout-submodule.sh  |  5 +++++
>  4 files changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 8e2c0662dd..d6399c0af8 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -256,6 +256,13 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>  	out anyway. In other words, the ref can be held by more than one
>  	worktree.
>  
> +--[no-]recurse-submodules::
> +	Using --recurse-submodules will update the content of all initialized
> +	submodules according to the commit recorded in the superproject. If
> +	local modifications in a submodule would be overwritten the checkout
> +	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
> +	is used, the work trees of submodules will not be updated.
> +
>  <branch>::
>  	Branch to checkout; if it refers to a branch (i.e., a name that,
>  	when prepended with "refs/heads/", is a valid ref), then that
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f174f50303..207ce09771 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -21,12 +21,31 @@
>  #include "submodule-config.h"
>  #include "submodule.h"
>  
> +static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +
>  static const char * const checkout_usage[] = {
>  	N_("git checkout [<options>] <branch>"),
>  	N_("git checkout [<options>] [<branch>] -- <file>..."),
>  	NULL,
>  };
>  
> +int option_parse_recurse_submodules(const struct option *opt,
> +				    const char *arg, int unset)

Again, this function should be marked static.

[I also noted _two_ other local functions with the same name
in builtin/fetch.c and builtin/push.c]

ATB,
Ramsay Jones


