Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4111F463
	for <e@80x24.org>; Wed, 18 Sep 2019 06:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfIRG2Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 02:28:16 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30932 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfIRG2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 02:28:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46Y95m41RNz5tlL;
        Wed, 18 Sep 2019 08:28:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 86ACF10A;
        Wed, 18 Sep 2019 08:28:11 +0200 (CEST)
Subject: Re: [PATCH] ls-remote: create '--count' option
To:     =?UTF-8?Q?Kamil_Doma=c5=84ski?= <kamil@domanski.co>
References: <20190918001134.20776-1-kamil@domanski.co>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <f643547f-54e0-fe4f-d8e5-95445431faf3@kdbg.org>
Date:   Wed, 18 Sep 2019 08:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918001134.20776-1-kamil@domanski.co>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.09.19 um 02:11 schrieb Kamil Domański:
> Create a '--count' option for ls-remote, based on the one from
> for-each-ref. This allows e.g. to return only the first result
> from a sorted list of refs.
> 
> Signed-off-by: Kamil Domański <kamil@domanski.co>
> ---
>  Documentation/git-ls-remote.txt | 11 ++++++++---
>  builtin/ls-remote.c             | 16 ++++++++++++----
>  t/t5512-ls-remote.sh            |  9 +++++++++
>  3 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 0b057cbb10..5adc1d676e 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -9,9 +9,9 @@ git-ls-remote - List references in a remote repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
> -	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
> -	      [--symref] [<repository> [<refs>...]]
> +'git ls-remote' [--count=<count>] [--heads] [--tags] [--refs]
> +	      [--upload-pack=<exec>] [-q | --quiet] [--exit-code] [--get-url]
> +	      [--sort=<key>] [--symref] [<repository> [<refs>...]]

It is understandable that the new option is important to _you_, but it
does not seem important enough that it must be the first in the list.
Please add it between --symref and <repository>

>  
>  DESCRIPTION
>  -----------
> @@ -21,6 +21,11 @@ commit IDs.
>  
>  OPTIONS
>  -------
> +--count=<count>::
> +	By default the command shows all refs that match
> +	`<pattern>`.  This option makes it stop after showing
> +	that many refs.

Is the meaning of this option perhaps:

    Stops after the specified count of refs have been listed.
    If `--sort=<key>` is specified as well, refs are counted
    after sorting; otherwise, it is unspecified which subset
    of is listed.

I do not know whether the "otherwise" part would be true (check it!),
but I am pretty certain that the "If" part must be true, otherwise the
option would be pointless.

The comment about the ordering of this paragraph at the very beginning
of the option list applies here, too, because the list is not sorted
alphabetically.

-- Hannes
