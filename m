Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3F01F462
	for <e@80x24.org>; Mon, 20 May 2019 19:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfETT0H (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 15:26:07 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:57547 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfETT0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 15:26:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 4578573l1gz5tlJ;
        Mon, 20 May 2019 21:26:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 24A8320E7;
        Mon, 20 May 2019 21:26:02 +0200 (CEST)
Subject: Re: [PATCH v5] userdiff: add Octave
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, avarab@gmail.com, philipoakley@iee.org,
        gitster@pobox.com
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190518034623.87702-1-liboxuan@connect.hku.hk>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3b7a22e8-0310-3738-0476-b6d73f187331@kdbg.org>
Date:   Mon, 20 May 2019 21:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518034623.87702-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.05.19 um 05:46 schrieb Boxuan Li:
> Octave pattern is almost the same as matlab, except
> that '%%%' and '##' can also be used to begin code sections,
> in addition to '%%' that is understood by both. Octave
> pattern is merged into Matlab pattern. Test cases for
> the hunk header patterns of matlab and octave under
> t/t4018 are added.

Thank you! This patch looks good. With or without the grammar and style
fixes below:

Acked-by: Johannes Sixt <j6t@kdbg.org>

Junio will very likely appreciate if you resend with these fixes applied.

> 
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> v1: use matlab pattern for octave
> v2: add a new octave pattern
> v3: fix indentation problem of v2
> v4: improve doc and commit message
> v5: merge octave pattern into matlab and add test cases
> ---

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4fb20cd0e9..e657a6b7b7 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -819,7 +819,7 @@ patterns are available:
>  
>  - `java` suitable for source code in the Java language.
>  
> -- `matlab` suitable for source code in the MATLAB language.
> +- `matlab` suitable for source code in the MATLAB and Octave language.

s/language/languages/

>  
>  - `objc` suitable for source code in the Objective-C language.
>  

> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..bcae006abe 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -58,7 +58,10 @@ PATTERNS("java",
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>  PATTERNS("matlab",
> -	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
> +	 /* Octave pattern is mostly the same as matlab, except that '%%%' and
> +	  * '##' can also be used to begin code sections, in addition to '%%'
> +	  * that is understood by both. */

	/*
	 * We write multi-line
	 * comments like this.
	 */

> +	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
>  PATTERNS("objc",
>  	 /* Negate C statements that can look like functions */
> 

-- Hannes
