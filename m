Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A7C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiLSP0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLSP0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:26:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C925D6467
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:26:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so22395350ejc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iuPe8ge5Iy/g3iF2YU1nafyO8clOiphVKWzcSCQQ9qk=;
        b=Yc+g+65Xz+g4ehSTfYQf9R7xkYpMw8MjR3UR4ioOGBQjW4GXv/mjU+HhIJ5aR5pa4H
         vE4doY14KwDr5loa67MODOaSPTSW0uNVPbNBSSML/JaAUO1sg9tfkojCUr9mZOxcdUOY
         RCUN7CTobt34+ZwO2t+QdFvJhyBvSG9cuzbUUSIBEVYAcjq+KyvhwN/4lGuqoDde58u7
         BdFKDSyq6yYemgjdd8BR0bRFj8jTS2de/eg+kZSn7qOQgkBBOId0Yz33ctonHZNo73yN
         qIsEPW67EUUOEmJT3tSczy3EIs1CaTnGB1jVqRzPZRAzMEuAXSBh2GctTJOEBxA8gVxl
         rFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuPe8ge5Iy/g3iF2YU1nafyO8clOiphVKWzcSCQQ9qk=;
        b=E+DH/yEelAphKnSwDdoiGSU6uYIdsgQlQBqfUKxhofTpaYq4mZdDMqXxfORI4I7msu
         9QFgPR6+rJHlhIP7pPVL+eplCjGjo512yElGqVz4cujLDtpL7JgY5DGsQUDobPZRcnHG
         h+qC1ynXDTVC6RF2OfpoQ23oUoGp4JlF63ABWGcSrwgnJ+O9+tp5muit6ap0LG69BJSL
         w1v8xN6Q/cg4ITmySYAVoSGr/LL/dNXayYDSF/WGN7WcrmqTwRGXb9Nj0W9wbuqz3R+A
         Kzco/cWuCVatMXI039vZmKJtfiD+i2Gk5iT16xguLtJMNY1SsjWddQ6cyZVo9dd/JkGg
         3M5g==
X-Gm-Message-State: ANoB5pkbLDqJGlNj3M83LqB883QBsP7JI09+S+s0lmD1x8E20uFFT7KB
        8XDdRy0LODLV5wmppjhuoq11bA7+nUs+OA==
X-Google-Smtp-Source: AA0mqf4KJbfT9hrqecw6mQ674kfpAPly685L533Um5J+8JWvKyjUmVWp0B0L9DikYhZ+3L4JB9dpzw==
X-Received: by 2002:a17:906:b1c6:b0:78d:f455:b5d4 with SMTP id bv6-20020a170906b1c600b0078df455b5d4mr36441262ejb.20.1671463596652;
        Mon, 19 Dec 2022 07:26:36 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906311400b0073d81b0882asm4533150ejx.7.2022.12.19.07.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:26:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7I2F-006bZR-2u;
        Mon, 19 Dec 2022 16:26:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Remove redundant double exclamation points
Date:   Mon, 19 Dec 2022 16:19:23 +0100
References: <pull.1401.git.git.1671459163559.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1401.git.git.1671459163559.gitgitgadget@gmail.com>
Message-ID: <221219.868rj3za6s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
>
> S_ISDIR is a macro that involves a "==" comparison.

It does? The POSIX standard
(https://pubs.opengroup.org/onlinepubs/009604499/basedefs/sys/stat.h.html)
says:

	The following macros shall be provided to test whether a file is
	of the specified type. The value m supplied to the macros is the
	value of st_mode from a stat structure. The macro shall evaluate
	to a non-zero value if the test is true; 0 if the test is false.

The "non-zero" there seems to intentionally leave open that this may be
defined e.g. as via a "&" test, as opposed to "==" which according to
C99's 6.5.9.3 says:

	The == (equal to) and != (not equal to) operators are analogous
	to the relational operators except for their lower
	precedence.90) Each of the operators yields 1 if the specified
	relation is true and 0 if it is false. The result has type
	int. For any pair of operands, exactly one of the relations is
	true.

> This means the !! is redundant and not needed.

I think you're therefore introducing a bug here, this may work on your
platform, but we have no guarantee that it'll work elsewhere.

I thought that it probably wouldn't matter, as we'd treat the argument
as a boolean, but we don't. In within_depth() we proceed to use the
passed-in 3rd argument (depth) as a counter, so it really does matter if
it's 0, 1, or other non-zero.

>  tree-walk.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 74f4d710e8f..6b51d27ccb2 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -1040,9 +1040,9 @@ static enum interesting do_match(struct index_state *istate,
>  		    ps->max_depth == -1)
>  			return all_entries_interesting;
>  		return within_depth(base->buf + base_offset, baselen,
> -				    !!S_ISDIR(entry->mode),
> -				    ps->max_depth) ?
> -			entry_interesting : entry_not_interesting;
> +				    S_ISDIR(entry->mode), ps->max_depth) ?
> +			       entry_interesting :
> +			       entry_not_interesting;
>  	}
>  
>  	pathlen = tree_entry_len(entry);

Aside from whether or not this is a bug, could you please submit
proposed refactorings of the git project via coccinelle patches if
possible (as I suggested to you before).

I realize that it has a slight learning curve, but it makes writing &
maintaining these so much easier, and it'll fix (mis)uses going forward,
not just as a one-off.

So, as an example (and assuming this wasn't buggy), you'd do that in
this case as e.g. (untested, but you can see similar syntax in our
existing *.cocci files):
	
	@@
	@@
	- !!
	(
	S_ISDIR
	|
	S_ISFIFO
        // |
        // we'd continue to list the rest here...
	)
	  (...)
