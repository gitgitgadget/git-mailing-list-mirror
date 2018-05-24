Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A57E1F42D
	for <e@80x24.org>; Thu, 24 May 2018 02:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935333AbeEXCmX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 22:42:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35618 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935126AbeEXCmV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 22:42:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id i14-v6so190370wre.2
        for <git@vger.kernel.org>; Wed, 23 May 2018 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fB5Sk3iv35NMebNAxuoZY/+8pxLbxoprv7oaD5iBU1Y=;
        b=fYLVVmxuViXq7XJQZzjOjcrfY2Ai+Vlkwd/0ljWbaJyaXQIM3u/rHNIsPbzc7VNBEL
         gkW2knYmSmIifg58/QgRzv+Li+7nU7AvCR6UKHpHOpTWSZLJUFRiWZ42qLnPJCKG9biF
         ltiTQz11+Dptm8w9lDp8IGE4rEVyHhFMyLsuY7ZFtLobWknXONMVGjTCqE/xP/nAbokn
         C17JtOKVpsJGLQaFsDtttF4MN5ReZ6mBCzkSp6V0wA40AGYSy8/+AvyRprEz3lJ/H5Zl
         wDJdNc85LlOV6bWA99NqyIZmk27DPV48GHHHa1nGwAuaYwv+59qMSxPOZAYvuZxsOwqj
         ZNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fB5Sk3iv35NMebNAxuoZY/+8pxLbxoprv7oaD5iBU1Y=;
        b=QmBYXVUuzqThXAiWTgFtJgVfkCVH6g6QLzq5vBTBHmsCF6z8sSM8fAwMmu3M5rXZgX
         9o0byiBYmpS3qVwSlVtJA+albhyLKTgvHEDZnInr4BpHGctchcvMsltUinfDpIf69gST
         iGup+B/hD+x9mKjZXbgHjFURapZB0pnSyrKe8CuA3dQiX9W+Cmyj0hCnyOO6vbHwTYdA
         zE388aTkHLn3UmDWE0dTZaqiloJe95yBN1bVLeHgCGXukVvjyo51XeGDLIGXbqws0v7F
         8XNQ0S5aYeCfqewNruXO/KKDy//37ShVf7gKZehCAYJAY3puKapd0BzhmyypeubXGAlV
         cNcw==
X-Gm-Message-State: ALKqPweIC0zXeqDY46mP6TDPDGIV0aq2mBrdwY+5Nrq20WtvcYisvpwS
        IhnB3HzU9+msq2NMX9/MjxM=
X-Google-Smtp-Source: AB8JxZrCaMdIiw057noYKBpq9IjLx1La578VZqfEX1CPi2ZdZcxKHWJuI629kw6xZiMwq/v3M+W99w==
X-Received: by 2002:adf:e4c6:: with SMTP id v6-v6mr4318553wrm.238.1527129740392;
        Wed, 23 May 2018 19:42:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u35-v6sm29378566wrc.29.2018.05.23.19.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 19:42:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v3 2/2] Add tests for rev-list --bisect* --first-parent
References: <20180523120110.36532-1-tiagonbotelho@hotmail.com>
Date:   Thu, 24 May 2018 11:42:17 +0900
In-Reply-To: <20180523120110.36532-1-tiagonbotelho@hotmail.com> (Tiago
        Botelho's message of "Wed, 23 May 2018 13:01:10 +0100")
Message-ID: <xmqq7entu646.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> Subject: [RFC PATCH v3 1/2] Implement --first-parent for git rev-list --bisect
> Subject: [RFC PATCH v3 2/2] Add tests for rev-list --bisect* --first-parent

perhaps

	bisect: teach "git rev-list --bisect" to work with "--first-parent"
	bisect: test "git rev-list --first-parent --bisect"

or soemthing?  I _think_ it is probably preferrable to have the test
in the primary patch, making these two patches into one.

> ---
>  t/t6002-rev-list-bisect.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index a66140803..977c82157 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -263,4 +263,43 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
>  	test_cmp expect.sorted actual.sorted
>  '
>  
> +# We generate the following commit graph:
> +#
> +#     A
> +#    / \
> +#   D   B
> +#   |   |
> +#   EX  C
> +#    \  /
> +#     FX

Existing ascii art in the same script seems to draw the history
growing from bottom to top, the other way around.  Please be
consistent.  I think that we tend to draw simple histories growing
from left to right, and a more complex ones from bottom to top.

> +test_expect_success 'setup' '
> +  test_commit A &&
> +  test_commit B &&
> +  test_commit C &&
> +  git reset --hard A &&
> +  test_commit D &&
> +  test_commit EX &&
> +  test_merge FX C
> +'
> +
> +test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent FX ^A' <<EOF
> +$(git rev-parse EX)
> +EOF

OK, because our range has odd number of commits on the first-parent
chain, the middle one is unambiguously the one to pick.

> +test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent FX ^A' <<EOF
> +bisect_rev='$(git rev-parse EX)'
> +bisect_nr=1
> +bisect_good=0
> +bisect_bad=1
> +bisect_all=3
> +bisect_steps=1
> +EOF
> +
> +test_output_expect_success "--bisect-all --first-parent" 'git rev-list --bisect-all --first-parent FX ^A' <<EOF
> +$(git rev-parse D) (dist=1)
> +$(git rev-parse EX) (dist=1)
> +$(git rev-parse FX) (dist=0)
> +EOF
> +
>  test_done
