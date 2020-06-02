Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD7C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EE02074B
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdhyL+zK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgFBTBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBTBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:01:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A2C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:01:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so2002405pjd.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZcXjlSGnV0NomNbfNp+DzypJsOnfPyiMLL8+tcqqWz0=;
        b=NdhyL+zKdR6jvKymoK3M9+EwcEDUOWzxBM6QJsZBMlTAUdfYH3WVLfByeLgRLHhHzI
         sSm3fWnPqhAuvHWEww5H50b7ijwCEji/88XlnlVrOkleTAade1fPGnglwh4YMixBBhWO
         bdzQgqUUDSREBom3iEE/RjKXpQQR5NmhUVrpkKzI1rTTsodlTOpHH0dQ4FxOFp88uw9H
         DuHNBGirSAeJv9EqxlfjszT9zGZCnoGQ9D/uILUgTA3d4/kPC6Fq7t1Su7ME5br5Ny+f
         1mTu2MdrGUMCASdUYzqP9cerviA4Rd5Ms3SLBY+6j8PlxtPuH6/Y5O/69H5Tu7fPpfMs
         QqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZcXjlSGnV0NomNbfNp+DzypJsOnfPyiMLL8+tcqqWz0=;
        b=rDtBydctpu+K2qACRU2mP+OHbdYlYMuY5yi9c8axltYjgfhlo5n+NfIhEO45HswM/d
         xvK7krWhFRxCLPqxjy2s9B9YDthM/x81PpTP9kavgCjiGzT/I0Wq/efPRutXIfTJsybH
         nmhkZmBHahBLjObrRR4gV17KJN3otg721ZsRwZlkHRy3u/SPJe3WCizLB+i1b6zrhzVX
         PavV+pRpysaE8Omqj3p2mHk32NLhYEbjFgOhuvk9IvKWPzYBFuRin4/bXIsACayAm4Km
         WbBTM9R30PorwyeAV2tx0mxXOKV2pSMGIjkQyW6yuhsd10nocjHKH2j/5RG78i9nz/48
         8loQ==
X-Gm-Message-State: AOAM533+9ucHSeRhjTISiZraCP6KfZy4ilEMN9rJV9yfNXg/N+ATL9fb
        vTBsrtJAOCehInCUkKWLJJE=
X-Google-Smtp-Source: ABdhPJzGuGnrnqTn8aPABPk+/KFfJf+qDMNfDv43a04PfBUzXnCM1dQIMn1qkt7kq8trgllzoCpvRQ==
X-Received: by 2002:a17:90a:8d16:: with SMTP id c22mr633986pjo.16.1591124511896;
        Tue, 02 Jun 2020 12:01:51 -0700 (PDT)
Received: from [192.168.208.37] ([49.206.125.136])
        by smtp.gmail.com with ESMTPSA id n19sm2925952pfu.194.2020.06.02.12.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:01:51 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        gitster@pobox.com, liu.denton@gmail.com, sunshine@sunshineco.com
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com>
Message-ID: <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
Date:   Wed, 3 Jun 2020 00:31:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602163523.7131-1-shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02-06-2020 22:05, Shourya Shukla wrote:
> Convert submodule subcommand 'set-branch' to a builtin and call it via
> 'git-submodule.sh'.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Denton Liu <liu.denton@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Here is the v5 of the subcommand. Thank you Danh for the feedback! I
> apologise for not replying on time. I have taken into account Danh's
> suggestions on the `quiet` option as well as done the fixup Dscho
> suggested (fixed by Junio here:
> https://github.com/gitster/git/commit/77ba62f66ff8e3de54d81c240542edb42a2711c7)
> 
>   builtin/submodule--helper.c | 44 +++++++++++++++++++++++++++++++++++++
>   git-submodule.sh            | 32 +++------------------------
>   2 files changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f50745a03f..a974e17571 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2284,6 +2284,49 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
>   	return 0;
>   }
>   
> +static int module_set_branch(int argc, const char **argv, const char *prefix)
> +{
> +	int opt_default = 0, ret;
> +	const char *opt_branch = NULL;
> +	const char *path;
> +	char *config_name;
> +
> +	/*
> +	 * We accept the `quiet` option for uniformity across subcommands,
> +	 * though there is nothing to make less verbose in this subcommand.
> +	 */
> +	struct option options[] = {
> +		OPT_NOOP_NOARG('q', "quiet"),
> +		OPT_BOOL('d', "default", &opt_default,
> +			N_("set the default tracking branch to master")),
> +		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
> +			N_("set the default tracking branch")),
> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
> +		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
> +		NULL
> +	};

I'm having second thoughts about my suggestion[1] to include
the short option for '--quiet' in the usage. This is the only
usage in submodule--helper that mentions that '-q' is a short
hand for '--quiet'. That seems inconsistent. I see two ways but
I'm not sure which one of these would be better:

A. Dropping the mention of '-q' in this usage thus making it consistent
    with the other usages printed by submodule--helper.

B. Fixing other usages of submodule--helper to mention that '-q' is
    shorthand for quiet. This has the benefit of properly advertising
    the shorthand.

C. Just ignore this?

I also noticed one other thing. A quote from
Documentation/CodingGuidelines regarding the usage for reference:

>  Optional parts are enclosed in square brackets:
>    [<extra>]
>    (Zero or one <extra>.)
> 
>    --exec-path[=<path>]
>    (Option with an optional argument.  Note that the "=" is inside the
>    brackets.)
> 
>    [<patch>...]
>    (Zero or more of <patch>.  Note that the dots are inside, not
>    outside the brackets.)
> 
>  Multiple alternatives are indicated with vertical bars:
>    [-q | --quiet]
>    [--utf8 | --no-utf8]
> 
>  Parentheses are used for grouping:
>    [(<rev> | <range>)...]
>    (Any number of either <rev> or <range>.  Parens are needed to make
>    it clear that "..." pertains to both <rev> and <range>.)
> 
>    [(-p <parent>)...]
>    (Any number of option -p, each with one <parent> argument.)
> 
>    git remote set-head <name> (-a | -d | <branch>)
>    (One and only one of "-a", "-d" or "<branch>" _must_ (no square
>    brackets) be provided.)

So, according to this, I think the usage should be ...

     git submodule--helper set-branch [-q | --quiet] [-d | --default] <path>

... and ...

     git submodule--helper set-branch [-q|--quiet] [-b | 
--branch]<branch> <path>

... respectively.

> +		NULL
> +	};

---
Footnotes:

[1]: 
https://github.com/periperidip/git/commit/9a8918bf0688c583740b3dddafdba82f47972442#r39606384

-- 
Sivaraam
