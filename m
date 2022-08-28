Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC13EECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 06:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiH1Gn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiH1Gn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 02:43:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ABE52810
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 23:43:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso11722235pjh.5
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=CWt9ABQRnrbBx5HybpPeKLJc9VGaqRtVO+5RRmXuIV8=;
        b=I4XYCMAC0AZk/eSNatdPVI4GNzJxFvgp1p2rwNm+hMcAHUvdyofOr8EybVBSF1uCfv
         +Fp6LKgsnXhT+UNMS6QrBk+/z70eTrtpiOqboBmW1YQ6n1ozH1hALCo0n5VUQzbAelKr
         HKtjevOHlNazoQDTTwc8KpNuQwmKTo8IiX4NBR7p3T9dmiQu8P1RcvC75IBQlAr8q6vi
         6V5KFOZygeH20EFFOaDQIGdVOJS2EORCu5kzmkvUEHY2jCDflZhaPiqSbjnVbNwZJzLT
         dBG8LDvqTf0zgjBHDyscZs0TAvDaXHm0S2PLzOsVIbRZKk/Lj9EG2xm5oYcwXD3g9Qjl
         eIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=CWt9ABQRnrbBx5HybpPeKLJc9VGaqRtVO+5RRmXuIV8=;
        b=EY7b3qNzIVTgle0ENi2JdM7oeZdM6NGjYQXVTo3hFM9DLPaBf/Wh/s+fd88rW0HjAw
         7GAonuZcLHyE/FIkBbUa4mJxmto+yoq+WTwVJmxjVQjnmYpeSYHecgYVvvgROL/jSo5c
         pGWx8VEX4khU9vlJAxLcbk82E9AC4xIdx36GEs+T7MqhzW3V6tIif8BsuQZbE5/i3ayG
         BkX3PQPDr1cu9CedRFpuxDljWfseoXZ7aUn7hzDVbbd6edSgLDK/W8qnAAUaSfZF76Jf
         WExRsO5XaPyCn2v0v5YDwSAYPYFfWe0YiPwcXrMfDqGhVvjbha67hbOLdtT4/ouYUBwU
         3l4A==
X-Gm-Message-State: ACgBeo1sN9ELmQASGZko+ymAckZEJZj0cjbp53znCn6DR77PgNGxXh7M
        w8Wy1ed09Gh/m/uW1Yev43I=
X-Google-Smtp-Source: AA6agR4NroXYaPH7lW40fbmySk9OBnYQYRKaZwaonQLUvIDIQi0WXT0Jh3yM2a1nIO7Z0ugqKY6igQ==
X-Received: by 2002:a17:90b:1803:b0:1fb:45e2:5d85 with SMTP id lw3-20020a17090b180300b001fb45e25d85mr12680845pjb.163.1661669034822;
        Sat, 27 Aug 2022 23:43:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090a68ca00b001fd803f057bsm2378971pjj.33.2022.08.27.23.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:43:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 04/16] bisect--helper: simplify exit code computation
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <9ab30552c6ae6a5d0a85d7a7bbdd10af4a4cf7ec.1661604264.git.gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 23:43:53 -0700
Message-ID: <xmqqpmgkvpee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We _already_ have a function to determine whether a given `enum
> bisect_error` value is non-zero but still _actually_ indicates success.
>
> Let's use it instead of duplicating the logic.

Yeah, looking very good.


>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index aa94c25ec73..2f9c7f54f3f 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1380,12 +1380,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  	}
>  	free_terms(&terms);
>  
> -	/*
> -	 * Handle early success
> -	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
> -	 */
> -	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
> -		res = BISECT_OK;
> -
> -	return -res;
> +	return is_bisect_success(res) ? 0 : -res;
>  }
