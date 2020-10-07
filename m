Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE1CC41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCF52087D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgJGQvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:51:07 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:41254 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgJGQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 12:51:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4C60hn5FVkz5tl9;
        Wed,  7 Oct 2020 18:51:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D4918212C;
        Wed,  7 Oct 2020 18:51:04 +0200 (CEST)
Subject: Re: [PATCH] userdiff: expand detected chunk headers for css
To:     Sohom Datta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sohom Datta <sohom.datta@learner.manipal.edu>
References: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <98994014-c049-f13f-bf5c-20ca9059707d@kdbg.org>
Date:   Wed, 7 Oct 2020 18:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.20 um 11:25 schrieb Sohom Datta via GitGitGadget:
> From: Sohom <sohom.datta@learner.manipal.edu>
> 
> Added support for classes, ids, :root selectors

s/Added/Add/ since we prefer this sentence in imperative mood.

> as well as @-based statements (ex: @page, @media
> and @keyframes ).
> 
> Also added tests for the same.

Ditto, or just drop this sentence.

> 
> Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
> ---
>     userdiff: Expand detected chunk headers for css
>     
>     Currently, the regex used for the CSS builtin diff driver in git is only
>     able to show chunk headers for lines that start with a number, a letter
>     or an underscore.
>     
>     However, the regex fails to detect classes (starts with a .), ids
>     (starts with a #), :root and attribute-value based selectors (for
>     example [class*="col-"]), as well as @based block-level statements like 
>     @page,@keyframes and @media since all of them, start with a special
>     character.

This text would have made a very good introductory part of the commit
message, but since it is after the three-dash separator, it is ignored.

The patch text looks good.

>     
>     I've modified the chunk header CSS regex so that it is able to detect
>     the statements above and add them to the chunk header.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-866%2Fsohomdatta1%2Fcss-userdiff-fix-test-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-866/sohomdatta1/css-userdiff-fix-test-v1
> Pull-Request: https://github.com/git/git/pull/866
> 
>  t/t4018/css-attribute-value-selector |  4 ++++
>  t/t4018/css-block-level-@-statements | 10 ++++++++++
>  t/t4018/css-class-selector           |  4 ++++
>  t/t4018/css-id-selector              |  4 ++++
>  t/t4018/css-root-selector            |  4 ++++
>  userdiff.c                           |  2 +-
>  6 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/css-attribute-value-selector
>  create mode 100644 t/t4018/css-block-level-@-statements
>  create mode 100644 t/t4018/css-class-selector
>  create mode 100644 t/t4018/css-id-selector
>  create mode 100644 t/t4018/css-root-selector
> 
> diff --git a/t/t4018/css-attribute-value-selector b/t/t4018/css-attribute-value-selector
> new file mode 100644
> index 0000000000..918256b20c
> --- /dev/null
> +++ b/t/t4018/css-attribute-value-selector
> @@ -0,0 +1,4 @@
> +[class*="RIGHT"] {
> +    background : #000;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/t/t4018/css-block-level-@-statements b/t/t4018/css-block-level-@-statements
> new file mode 100644
> index 0000000000..d6755f2f3d
> --- /dev/null
> +++ b/t/t4018/css-block-level-@-statements
> @@ -0,0 +1,10 @@
> +@keyframes RIGHT {
> +    from {
> +        background : #000;
> +        border : 10px ChangeMe #C6C6C6;
> +    }
> +    to {
> +        background : #fff;
> +        border : 10px solid #C6C6C6;
> +    }
> +}
> diff --git a/t/t4018/css-class-selector b/t/t4018/css-class-selector
> new file mode 100644
> index 0000000000..f790a0062f
> --- /dev/null
> +++ b/t/t4018/css-class-selector
> @@ -0,0 +1,4 @@
> +.RIGHT {
> +    background : #000;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/t/t4018/css-id-selector b/t/t4018/css-id-selector
> new file mode 100644
> index 0000000000..17c5111052
> --- /dev/null
> +++ b/t/t4018/css-id-selector
> @@ -0,0 +1,4 @@
> +#RIGHT {
> +    background : #000;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/t/t4018/css-root-selector b/t/t4018/css-root-selector
> new file mode 100644
> index 0000000000..22b958e369
> --- /dev/null
> +++ b/t/t4018/css-root-selector
> @@ -0,0 +1,4 @@
> +:RIGHT {
> +    background : #000;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..49c9771891 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -200,7 +200,7 @@ PATTERNS("csharp",
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
>  IPATTERN("css",
>  	 "![:;][[:space:]]*$\n"
> -	 "^[_a-z0-9].*$",
> +	 "^(([_a-z0-9]|[:[@.#][_a-z0-9]).*)$",
>  	 /* -- */
>  	 /*
>  	  * This regex comes from W3C CSS specs. Should theoretically also
> 
> base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
> 

