Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BD11F404
	for <e@80x24.org>; Tue, 14 Aug 2018 15:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbeHNR4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:56:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41945 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbeHNR4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:56:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so17503852wrr.8
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IgqqyxQtRrr2Bz/cDtZHvsNh4LC5GKctpM8KOwtapeU=;
        b=cz67SkvsJVkndOEMN6abWu/m2l0fiuKD76W7q5YQ1k4saCni9AlXRHu7KD8llaf9/C
         tSewKpZswfDwJMaR67bTmWMAWQTFn3CMjI6IvUCP3HX8j+p264euOdwiL7ZNwswtvAkA
         FLg0iiFrF5Zl19xy4l1xvO2nvnB+mx+mf+ssZNcN8ZT/sUrfmYowEk06RCtnaiA/0fpN
         bG3MCxqK7cWZA3HW6JV2uj0auwhoKKMVX/i17LqjTf+XSsIQvIG899+gg7W0/yGZchwm
         o6/BUpNuAGX3RkchMLftFDHAJQF/hcTItwvLMeQIvSgoOmoAsRHMtOKsyyjKsSQ44xVR
         t8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IgqqyxQtRrr2Bz/cDtZHvsNh4LC5GKctpM8KOwtapeU=;
        b=Yt2I7THoaK+gWGA4lmk5nRBiIZHCyOn/wfZuN3xLwG0y/fHPRlBfRnNph3j9WAWReP
         xmda01TdAa8lDAgOyGZCHH2dg36rsUg02tuypWQh2s1nZaPtVDNTJARPA9FMMicU3rOg
         R5fTVVypd+qlLZJHvLd1g3R5JzUAP7oGa0tuq/F+W7wZxO+TffEi/qB99pm7E7CN2ecq
         rh3x3litn5zFA9u5biD6+JeFAAsDMHHU7ghCcZcLTfKBQ92C+9eIJBG4KFFrL4YQbLlQ
         szBVbhCQ5hl7DZAwk/s7Q+28qgEVNbgksjd7QUbn1hz6Nm2H30bKws1LTjttznbBRSGx
         U8NQ==
X-Gm-Message-State: AOUpUlF0yzTUu02Uh7fxHN/HoHJ6tKdT6FgTlA2DS1yuHVjnIODuPeme
        9QbSiaPCILRbBcEJOxwmyG0=
X-Google-Smtp-Source: AA+uWPzJhQ2Yh41IY+Pvhm8WE1RCHo5uhjmmYvbNEQR1BhGTowaa5YZAuzZN6fDu0aSfudcNwfSYcw==
X-Received: by 2002:adf:9203:: with SMTP id 3-v6mr13744017wrj.275.1534259320604;
        Tue, 14 Aug 2018 08:08:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w204-v6sm18079525wmw.5.2018.08.14.08.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 08:08:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mark_colliding_entries(): fix incorrect #if...#endif guard
References: <pull.18.git.gitgitgadget@gmail.com>
        <becaf4374a1f8e56a4a26203d74ba64560a465da.1534244538.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Aug 2018 08:08:38 -0700
In-Reply-To: <becaf4374a1f8e56a4a26203d74ba64560a465da.1534244538.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 14 Aug 2018
        04:02:21 -0700 (PDT)")
Message-ID: <xmqqva8d0yvd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The way the guard was put, the code was declaring an unused variable on
> Windows. No need to do that, so let's fix it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  entry.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index c70340df8..2bce13352 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -402,11 +402,9 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>  static void mark_colliding_entries(const struct checkout *state,
>  				   struct cache_entry *ce, struct stat *st)
>  {
> +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
>  	int i;
>  
> -	ce->ce_flags |= CE_MATCHED;
> -
> -#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
>  	for (i = 0; i < state->istate->cache_nr; i++) {
>  		struct cache_entry *dup = state->istate->cache[i];
>  
> @@ -422,6 +420,8 @@ static void mark_colliding_entries(const struct checkout *state,
>  		}
>  	}
>  #endif
> +
> +	ce->ce_flags |= CE_MATCHED;
>  }

Even though it looks a bit odd to smudge 'ce' itself after the loop,
I think this would not break anything, simply because the loop does
treat the 'ce' as special and stops the iteration once it sees it,
even before its MATCHED bit is set.

Duy, if you are going to send a new version updated for other
reasons, please squash this in.  In the meantime, I'll queue it on
top of what we have right now.

Thanks, both.

