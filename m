Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664EC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52F5206A4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbs14y0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRSbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRSbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:31:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39171C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:31:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so6567077wrs.5
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tNAbxKnfvkMlRi+CrpwOL+1lYv/I5HGRdumfUOicczE=;
        b=Tbs14y0meoeYzdLwfyFYVa87yBeJsfKlmeBBYvji0BHwUvQ+rdHbv4P3MZSODkwG4h
         z3cSK3I44irmyni0GSr80Xxb4gTgZg0rMVsXdUeOtdKHSQnGcapFwU2854kUoF7Sj2oe
         ecxUdVqUv1VfxFez1+PQkyW0kqZkt+2oDhdvt9pAinGumwu2OE7IdqjGs2HdXuTMJrat
         EZtHy2Up6sgEXUuFjdYFAJyaQmUpKoeeQY3Wvc79ouWXTZ0QXk+v7wAKrdHalh8eAxYP
         pR6JnIUXbN/IYGrN9OWcyt22EAHvxXmt0Xn+i4TXICyLZermm4bA3DpQGSFJeVpsjj5b
         xRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tNAbxKnfvkMlRi+CrpwOL+1lYv/I5HGRdumfUOicczE=;
        b=YNAJT39rGKSfjVn2Tj4x70OGAudqX1JYwra2i12BNT25lMCTyrn+bW5BmmBpHPAEw0
         ChYaBogDp3u+kH6TUKPifC8yQDkun7CmrcPmOMtq4GAV8f/BKGIFn/4na/7g3Y/Yp4ta
         6wgj46fp+6snfUIEIwEDy8on9BChcN2kZM4/TS69oV9UMMvzrZxqoNQWMdRJtHpEHyFP
         4UNhnpse8gYhql57M2LkpOeDabnwPz+3vs47pZL8el/kwWJmt0Jwjr/OzQ36lY/SEYl7
         HQ7STRnRunoIj3NKg9gC/8MRX4WjR28ZrwnZIJANbcwfswwHpWfwyRfMuMDmpNxHVRTa
         nuuw==
X-Gm-Message-State: AOAM530Ta6wm+E/6usXq1Fb0yJAnm7woYCiitwGYTFJGBzKbuKo4SD9r
        nRs0piDmN9emZTgXZN3ZGIE=
X-Google-Smtp-Source: ABdhPJy99+CKHjPYNhKNbX73vPudsg+y1Sqfgoy+A1rAGQIuSPHe+ngpTy8sSambbNDewyqVHnzSJw==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr39102806wrp.396.1600453860728;
        Fri, 18 Sep 2020 11:31:00 -0700 (PDT)
Received: from [192.168.1.201] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.googlemail.com with ESMTPSA id b187sm6328422wmb.8.2020.09.18.11.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 11:31:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] config: improve error message for boolean config
To:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrew Klotz <agc.klotz@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
 <689d84672422dd96d1eb89ea6137e79ce4030248.1600395427.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <15b794ad-6eae-6de1-3328-9b814e8e2605@gmail.com>
Date:   Fri, 18 Sep 2020 19:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <689d84672422dd96d1eb89ea6137e79ce4030248.1600395427.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew

On 18/09/2020 03:17, Andrew Klotz via GitGitGadget wrote:
> From: Andrew Klotz <agc.klotz@gmail.com>
> 
> Currently invalid boolean config values return messages about 'bad
> numeric', which is slightly misleading when the error was due to a
> boolean value. We can improve the developer experience by returning a
> boolean error message when we know the value is neither a bool text or
> int.

This patch improves things for boolean config keys  but 
git_config_bool_or_int() is used by status.submoduleSummary, merge.log 
and commit.verbose which can be either a number or a boolean (where a 
boolean generally means use a default number). It would be a more 
invasive change but I wonder if it would be better for git_config_bool() 
to have it's own error message rather sharing it with 
git_config_bool_or_int().

Best Wishes

Phillip

> `GIT_TEST_GETTEXT_POISON` is a boolean so we no longer fail on
> evaluating it as an int in `git_config_int`. Because of that we can
> move the special translation case into the boolean config check where
> we are now failing with an updated message
> 
> before with an invalid boolean value of `non-boolean`, its unclear what
> numeric is referring to:
> ```
> fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
> ```
> 
> now the error message mentions `non-boolean` is a bad boolean value:
> ```
> fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
> ```
> 
> Signed-off-by: Andrew Klotz <agc.klotz@gmail.com>
> ---
>   config.c                  | 22 ++++++++++++----------
>   t/t0205-gettext-poison.sh |  2 +-
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 2bdff4457b..198d0d3216 100644
> --- a/config.c
> +++ b/config.c
> @@ -996,15 +996,6 @@ static void die_bad_number(const char *name, const char *value)
>   	if (!value)
>   		value = "";
>   
> -	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> -		/*
> -		 * We explicitly *don't* use _() here since it would
> -		 * cause an infinite loop with _() needing to call
> -		 * use_gettext_poison(). This is why marked up
> -		 * translations with N_() above.
> -		 */
> -		die(bad_numeric, value, name, error_type);
> -
>   	if (!(cf && cf->name))
>   		die(_(bad_numeric), value, name, _(error_type));
>   
> @@ -1097,7 +1088,18 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>   		return v;
>   	}
>   	*is_bool = 0;
> -	return git_config_int(name, value);
> +	if (git_parse_int(value, &v))
> +		return v;
> +
> +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> +		/*
> +		 * We explicitly *don't* use _() here since it would
> +		 * cause an infinite loop with _() needing to call
> +		 * use_gettext_poison().
> +		 */
> +		die("bad boolean config value '%s' for '%s'", value, name);
> +	else
> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
>   }
>   
>   int git_config_bool(const char *name, const char *value)
> diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
> index f9fa16ad83..b66d34c6f2 100755
> --- a/t/t0205-gettext-poison.sh
> +++ b/t/t0205-gettext-poison.sh
> @@ -33,7 +33,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
>   
>   test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
>   	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
> -	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
> +	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
>   "
>   
>   test_done
> 

