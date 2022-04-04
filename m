Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F91BC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 07:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377668AbiDDHWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377649AbiDDHWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 03:22:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2E35ABB
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 00:20:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r10so4178283eda.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0N9NMlKfGxSz3vc+bEE+JRUmNL2Y67uGqSOdwtob3LI=;
        b=EvLAmjl6OqfArLpc7XKb/D0EFIHMbsILEaLi/XKzmCplsNH0yxLHommaJktzGiPVQa
         4MmUJLMiKhpbN9k4ZqDnpZgz0nJzZtwFeM4B/CK3zKzIxS4FTn0ncN2/vjI3ivRQ9kLs
         5QBJ+eEFiIpGb++cOw7+iqYEqEevFGLwHCDfJ7qq5i6jVO2lCtPCMjouO2HH4bO9xsZA
         v1Uts0+gqusoBR3PRYvQMkiDw3L0e93HD5QvUaYezO3U9AF0zVd+xPTqV1RRJ3IB6RRH
         wjZ8JXViI2PxqSjYWy1uWwb89+4Fq3h/OsRMjfXOSvIdG/roEBMwBTch/rsz3MtXOnDf
         yMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0N9NMlKfGxSz3vc+bEE+JRUmNL2Y67uGqSOdwtob3LI=;
        b=jbkPLSmoYRwUepCpPF0dimz6+1dD2eHDslbMN8nRPsFzClmzygpWEJ4XCyyHZse/Cr
         yzOoZYgXN7YwDIEb47pKcWzG5vBsuhfukqElsSBwCwmr5WylZENTBaQrb77vz/dytD7H
         /7KbzdtlHxlpVHG+8BY9npYsjInGzOajEuMVGJ8xZhRRYYT0yUbwNG87X8z2LMO+2nOd
         o+KDKm4njBOMF4oLMyQVIRfI9ArUvNBQO/iprZJUnwW9WEVfGNZQo6UIuQ1o8XjLMycs
         Ya1hIq23s30BVY8sliwSEVeu2Q/PtQXso4RrteL2OMMKPADC42upCGf6soz2hMjJ3dg+
         +E3Q==
X-Gm-Message-State: AOAM532bHfj+WgrUx3DQKmdb17OH8JLEuHPL4gRgFwLCLl1uL9JE7Jaw
        pvmGNvzxq5/y4AwJwFbya7WGUdlbkdg=
X-Google-Smtp-Source: ABdhPJwj2XkbTAkloj6xIqAc3YoqYXzIbwMh3gbGFiMX9NpvgsVsiHdZopM4/uMA1WKWAY2lO7sU8g==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr31554492ede.327.1649056849366;
        Mon, 04 Apr 2022 00:20:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id go40-20020a1709070da800b006dfc3945312sm3977282ejc.202.2022.04.04.00.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:20:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbH16-002M4E-BD;
        Mon, 04 Apr 2022 09:20:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     xing zhi jiang <a97410985new@gmail.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, chooglen@google.com
Subject: Re: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
Date:   Mon, 04 Apr 2022 09:12:41 +0200
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220403132508.28196-1-a97410985new@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220403132508.28196-1-a97410985new@gmail.com>
Message-ID: <220404.86lewljovj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, xing zhi jiang wrote:

Aside from what Johannes Sixt mentioned:

> +PATTERNS("javascript",
> +	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
> +	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
> +	 /* don't match statement */
> +	 "!;\n"
> +	 /* match normal function or named export for function in ECMA2015 */
> +	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
> +	 /* match JavaScript variable declaration with a lambda expression at top level */
> +	 "^((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
> +		"(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
> +	 /* match object's property assignment by anonymous function and CommonJS exports for named function */
> +	 "^((module\\.)?[$_[:alpha:]][$_[:alnum:]]*\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(async[\t ]+)?(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
> +	 /* match assign function to LHS with explicit function keyword */
> +	 "^(.*=[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
> +	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */
> +	 "^[\t ]*(QUnit.test\\(.*)\n"
> +	 /* don't match the function in class or in object literal, which has more than one ident level */
> +	 "!^(\t{2,}|[ ]{5,})\n"
> +	 /* match normal function in object literal */
> +	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function.*)\n"
> +	 /* don't match chained method call */
> +	 "!^[\t ]*[$_[:alpha:]][$_[:alnum:]][\t ]*\\(.*\\)\\.\n"
> +	 /* match function in class and ES5 method shorthand */
> +	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",
> +	 /* word regex */
> +	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and its big version */
> +	 "0[xXoObB][_0-9a-fA-F]+n?"
> +	 /* DecimalLiteral and its big version*/
> +	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
> +	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
> +	 /* punctuations */
> +	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
> +	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
> +	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
> +	 /* identifiers */
> +	 "|[$_[:alpha:]][$_[:alnum:]]*"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */<

While we don't use helper macros for these currently there's no reason
we can't, I thin the above might be more readable with e.g.:

	#define JS_AA "[$_[:alpha:]][$_[:alnum:]]"

Which would make this:
	
	+PATTERNS("javascript",
	+	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
	+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
	+	 /* don't match statement */
	+	 "!;\n"
	+	 /* match normal function or named export for function in ECMA2015 */
	+	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*" JS_AA "*[\t ]*\\(.*)\n"
	+	 /* match JavaScript variable declaration with a lambda expression at top level */
	+	 "^((const|let|var)[\t ]*" JS_AA "*[\t ]*=[\t ]*"
	+		"(\\(.*\\)|" JS_AA "*)[\t ]*=>[\t ]*\\{?)\n"
	+	 /* match object's property assignment by anonymous function and CommonJS exports for named function */
	+	 "^((module\\.)?" JS_AA "*\\." JS_AA "*[\t ]*=[\t ]*(async[\t ]+)?(\\(.*\\)|" JS_AA "*)[\t ]*=>.*)\n"
	+	 /* match assign function to LHS with explicit function keyword */
	+	 "^(.*=[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
	+	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */

Wry try to stick to wrapping at 80 characters, so some of these comments
should really be wrapped (see CodingGuidelines for the multi-line
comment style we use).

	+	 "^[\t ]*(QUnit.test\\(.*)\n"
	+	 /* don't match the function in class or in object literal, which has more than one ident level */
	+	 "!^(\t{2,}|[ ]{5,})\n"
	+	 /* match normal function in object literal */
	+	 "^[\t ]*(" JS_AA "*[\t ]*:[\t ]*function.*)\n"
	+	 /* don't match chained method call */
	+	 "!^[\t ]*" JS_AA "[\t ]*\\(.*\\)\\.\n"
	+	 /* match function in class and ES5 method shorthand */
	+	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?" JS_AA "*[\t ]*\\(.*)",
	+	 /* word regex */
	+	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and its big version */
	+	 "0[xXoObB][_0-9a-fA-F]+n?"
	+	 /* DecimalLiteral and its big version*/
	+	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
	+	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
	+	 /* punctuations */
	+	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
	+	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
	+	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
	+	 /* identifiers */
	+	 "|" JS_AA "*"),
	
Just a thought, I wonder how much line-noisy we could make this thing in
general if we defined some common patterns with such helpers.

Anyway, insted of :alnum:and :alpha: don't you really mean [a-zA-Z0-9]
and [a-zA-Z]. I.e. do you *really* want to have this different depending
on the user's locale?

I haven't tested, but see the LC_CTYPE in gettext.c, so I'm fairly sure
that'll happen...

