Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009FC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF6261399
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 10:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbhDEKVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 06:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhDEKVd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 06:21:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC7C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 03:21:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p4so1752530edr.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X7zvMayn3aoLIgGh9aDyW8Cr7EN6ovt0NM0w7foEDvY=;
        b=YD0icIZHkF7hpGEYRsXQKdFOeQYQi94WCbzzlOOyPpYavE4F29uXTyxvGSFY07CF1X
         cZYohuATU99Epe8KN7yRaEtnfrRXmCngXZOg7NuuTWGVAmS67weegBc9K6iEJEYLqTOL
         L5PDnlONRy3ZjGdxisrgzLTWGDbG2e7+dGcKWEEcO930Iq11j/kHBSQiOAb7LwoxMmh4
         uMcDvO97cTV6kpo6lMeBWjmyMAIKYauWra9JJWsdQfEDPAmJsT4ChvyeuL9zMGpRDA9X
         g0OjxHjnCDw8t5ZLsL7H+sKIGekTejpYu1YG4MeQr+LI4CLvryd1yFqDJXJqWhUvdhkb
         ahZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7zvMayn3aoLIgGh9aDyW8Cr7EN6ovt0NM0w7foEDvY=;
        b=mbniMC+Zov3gxZUdUh/IL8OlAe3s0FQsWhIo6OCLfx/AH0NjKsn6TjjXaJl5+GJPHu
         QiM5j0d8TGkVBCoHpdLokiRa/L/JxheX8usgPb9aRb8t6wEB1Uezt1QWhenToCp3Ul7m
         CPWWtbYsrfKvyqr46DJdA/wXs9KlImk9R+PyGnv+Qy4oaJLPHxLDnU8ReKk1HfgNZGb8
         +jYSKDChma0PYOA/WyMK/oYDnT2VUxMIn1DxxcpnRVtNcA8ymzc8g7DLsB7nr6DLeh3U
         hl5sdKJNnJrYRpZ4yotlXN1oW8xqkHczr3dfLblcouGnb78Ov20Ay8uR0ZhgYtKPIPqe
         GGXw==
X-Gm-Message-State: AOAM533D6h4iPIbw8sT4HD0ld090S+gWZoeG4pxtvNDEWt1F+JPUgKg+
        WsBVxphpZ2E0uIeIrxO5tBz2JLIqnEg=
X-Google-Smtp-Source: ABdhPJw6w/yn1aEN0Q0m9QVVeGtmum6WSZxN1UCJbBKjBvS7YyKtjOgIwvdwZxRrPY/o1YyHL1lLew==
X-Received: by 2002:a50:f113:: with SMTP id w19mr29952904edl.226.1617618086170;
        Mon, 05 Apr 2021 03:21:26 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id m29sm4512622ejl.61.2021.04.05.03.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 03:21:25 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 1/1] userdiff: add support for scheme
To:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <20210403131612.97194-1-raykar.ath@gmail.com>
 <20210403131612.97194-2-raykar.ath@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4a9bdf0c-dc0f-a0fa-5c13-2b4732d21ca8@gmail.com>
Date:   Mon, 5 Apr 2021 11:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210403131612.97194-2-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva
On 03/04/2021 14:16, Atharva Raykar wrote:
> Add a diff driver for Scheme-like languages which recognizes top level
> and local `define` forms, whether it is a function definition, binding,
> syntax definition or a user-defined `define-xyzzy` form.
> 
> Also supports R6RS `library` forms, `module` forms along with class and
> struct declarations used in Racket (PLT Scheme).
> 
> Alternate "def" syntax such as those in Gerbil Scheme are also
> supported, like defstruct, defsyntax and so on.
> 
> The rationale for picking `define` forms for the hunk headers is because
> it is usually the only significant form for defining the structure of
> the program, and it is a common pattern for schemers to have local
> function definitions to hide their visibility, so it is not only the top
> level `define`'s that are of interest. Schemers also extend the language
> with macros to provide their own define forms (for example, something
> like a `define-test-suite`) which is also captured in the hunk header.
> 
> Since it is common practice to extend syntax with variants of a form
> like `module+`, `class*` etc, those have been supported as well.
> 
> The word regex is a best-effort attempt to conform to R6RS[1] valid
> identifiers, symbols and numbers.
> 
> [1] http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-7.html#node_chap_4
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>[...]
> diff --git a/userdiff.c b/userdiff.c
> index 3f81a2261c..ac1999bbc5 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -191,6 +191,10 @@ PATTERNS("rust",
>   	 "[a-zA-Z_][a-zA-Z0-9_]*"
>   	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>   	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
> +PATTERNS("scheme",
> +	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
> +	 /* All words should be delimited by spaces or parentheses */
> +	 "([^][)(}{[ \t])+"),

I think it would be nice to match single '(' and '[' to highlight when 
they have been added or deleted - I find this useful when I get a syntax 
error. Also it would be nice to handle r7rs identifiers like | this is a 
symbol |. Maybe something like
"(\\|([^\\\\|]*(\\\\|)*)*\\||[^][}{)( \t]|[][(){}])"

Best Wishes

Phillip

>   PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>   	 "[={}\"]|[^={}\" \t]+"),
>   PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> 

