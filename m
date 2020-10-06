Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C4FC41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C8E20789
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgJFS1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:27:08 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:28015 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgJFS1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 14:27:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4C5Qt271jHz5tl9;
        Tue,  6 Oct 2020 20:27:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6D125212C;
        Tue,  6 Oct 2020 20:27:06 +0200 (CEST)
Subject: Re: [PATCH] Improve diff pattern for PHP files
To:     Javier Spagnoletti via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Javier Spagnoletti <phansys@gmail.com>
References: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d262c797-29eb-1e08-8de0-6a2dd2a5d47f@kdbg.org>
Date:   Tue, 6 Oct 2020 20:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please choose a commit summary line of the form "area: summary", for
example:

   userdiff: PHP: catch "abstract" and "final" functions

Am 06.10.20 um 12:37 schrieb Javier Spagnoletti via GitGitGadget:
> From: Javier Spagnoletti <phansys@gmail.com>
> 
> Improve the output diff readability for php files by taking into account some missing function modifiers.

"Improve" is a noise word and need not be mentioned; a non-improvement
would not be accepted. Also, wrap long lines to at most 72 characters.
Perhaps:

   PHP permits functions to be defined like

       public final function foo() { }
       protected abstract function bar() { }

   but our hunk header pattern does not recognize these decorations.
   Add "final" and "abstract" to the list of function modifiers.

I am not a PHP expert, so I cannot tell whether what I have written
above makes sense.

> 
> Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
> ---
>     Improve diff pattern for PHP files
>     
>     Improve the output diff readability for php files by taking into account
>     some missing function modifiers.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-864%2Fphansys%2Fuserdiff_php-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-864/phansys/userdiff_php-v1
> Pull-Request: https://github.com/git/git/pull/864
> 
>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index 1df884ef0b..a99d84a7e3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -143,7 +143,7 @@ PATTERNS("perl",
>  	 "|=~|!~"
>  	 "|<<|<>|<=>|>>"),
>  PATTERNS("php",
> -	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
> +	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
>  	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"

It would be great if you could add test cases to t/4018/ that
demonstrate how these new keywords are handled.

-- Hannes
