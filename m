Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702612027C
	for <e@80x24.org>; Mon, 29 May 2017 06:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbdE2Glu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 02:41:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36619 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdE2Glt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 02:41:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so5515585pge.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PDymxgua6z3TdLViH+wbYT7OWgwLmYtgua31PnzblMI=;
        b=bNoqFC2ultMNas6RGgvtI0iAiRBVxwmByOtE3R+HyNOSMfd6nDgu67Tevv5dyTuGWc
         pMI6YZAP5l4P0L6qo/po3ocRVi3s+w3AbVnwBkj5WXjR3q0sp6ztTjwR9V2Q4M4k5Pa5
         5iRjcnhNMmuV/Lojq7iolkLU6d6nQYcHqDEXGbSaenER95kZTiS4HUMGhnHKxz61ZVQK
         /EkeCwOTNeGJ7DLsVJBZ4yjCbu+AWHP+BsKFsRxLJfOqjZZprb8A3peIuE0R/32xfpJU
         dH+CePE/lm4lc3MJMjOX34qGcuTWc+97i5832axQjOaemFACMRALnRcx9atk2tLaN2Ia
         fESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PDymxgua6z3TdLViH+wbYT7OWgwLmYtgua31PnzblMI=;
        b=GCk3xMXpcThl+/WerFFlRyuRhQh3Aya/ZxklllK+8T3L8VlG+cPi0Qf8jAPSIBslHZ
         yQXJS5J08AuZjH9qTbo781tJ/5Rab9vMDO5pR1JpmVKU1posKfSySL8CVH1WC2e4h9cK
         w1j5Rr/fbj3AqgYpcjQnZi7be06E4t5oyMlWy7RhtK0uvU6cIiQhISWCTYRTJJkS1sS9
         uC3sdXMoxw1kheCEzQ7NnYTI8sDB36s40Oycr1z5yt1SfCtQboV7E25zLJc6CTsglMQp
         Pc9CATjcpkJgy6nXQmA9khb60TWK7H0KEhyzENUjoh1Nj+nvNpu6lB34VK3130/iWwqC
         deNg==
X-Gm-Message-State: AODbwcCOx3bmPvzVclzyWLWAXo2GYpNQjLESDxMRhxTmukqv9Os4Zg64
        0QND8OUPb1z7HQ==
X-Received: by 10.99.112.86 with SMTP id a22mr17075669pgn.52.1496040109066;
        Sun, 28 May 2017 23:41:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id q25sm14289436pgn.9.2017.05.28.23.41.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 23:41:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 2/4] stash: add test for stashing in a detached state
References: <20170528165642.14699-1-joel@teichroeb.net>
        <20170528165642.14699-3-joel@teichroeb.net>
Date:   Mon, 29 May 2017 15:41:47 +0900
In-Reply-To: <20170528165642.14699-3-joel@teichroeb.net> (Joel Teichroeb's
        message of "Sun, 28 May 2017 09:56:40 -0700")
Message-ID: <xmqqshjo6u6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index aaae221304..b86851ef46 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -808,6 +808,17 @@ test_expect_success 'create with multiple arguments for the message' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'create in a detached state' '
> +	test_when_finished "git checkout master" &&
> +	git checkout HEAD~1 &&
> +	>foo &&
> +	git add foo &&
> +	STASH_ID=$(git stash create) &&
> +	echo "WIP on (no branch): 47d5e0e initial" >expect &&

Is it easy to generate this (especially 47d5e0e) at runtime?  I know
that earlier tests in this script are brittle and will break when
object names change by using test vectors that hardcode object names
a bit too much, but if we can avoid making it worse, let's try to do
so for future developers who will have to do the work of adjusting
the tests for possible changes to the object name hashing algorithm.

> +	git show --pretty=%s -s ${STASH_ID} >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'stash -- <pathspec> stashes and restores the file' '
>  	>foo &&
>  	>bar &&
