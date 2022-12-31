Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB05C3DA7D
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 14:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLaO7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 09:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLaO7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 09:59:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6467C6142
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:59:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso17360817wmp.3
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDEmVi1uyW//N+74yPQO2BGKc4+ZuWRWvZR+CnydzDw=;
        b=a2jUk69SBTShNzeIgNV38ii74QSlovFwpqLVDiFQhOmuvIbvhpOhU4uoOEVnR67f0d
         7Vwx14xxajQ5ltgr+U0BaStjmpbX285cd9yfjYpjRE4jkZUsTeah9DA+FQkQcB9Qae3T
         vEbxGjbx/WVhz36ioQbhIqksP1iBdfKz1rIvqJ7GXZlOxtKyLtynRTa7b4SryV4rSh8d
         qntI6Wd+ZmPPZwEOggrQnmAvj8zDxCnoVgID59pwImfiHhp0jk6LWUzzDuKwiMPk6Ayo
         3EpnHFx7pnSbpOCsMTs2gIr4tCNP8FPCyZdiAWEmUjjYK7Z/Nr5NQ2MobVq53siAtezq
         OH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDEmVi1uyW//N+74yPQO2BGKc4+ZuWRWvZR+CnydzDw=;
        b=ES0N+WN6KNpEVrSiTFKZ9XIu4XCQdn9WGIyDWoB8DCzCOg4rcT6w/qPzWXwCsEYUGk
         9iNR2AivC3unJTuVrG3Zsrimi15AJYxSXNp4kEe7dVV7ypTsNsbdA54InF+ax48MTYCA
         ncWnLpAEoDYqG/1pc3gNFiJDyCzUtUeBAEEsvke6nt9os/+9A7DrQtsd6QrSld10FJVW
         OhDNKKzEr2rsexVK0U4Qrgt32L6eZLMD48JwyxzHQ3Njzrs/IvI+FeGBEJoa4DdKPk7R
         w4Wf93RJ0t+5UM67grIlv4DFWLZRP6t5FpWXBrQUv/tBh12dnt80oDZXxiPL3poOqnpk
         wpdA==
X-Gm-Message-State: AFqh2kowmXkWAWV3SdLwfWHy7XBh4kFgkcHcYVNjZUxtp6+xoeH1+Q3C
        M7FE61LNCyXrWE5CVddFWN7PSMMfxjA=
X-Google-Smtp-Source: AMrXdXtoR6vt7jK7GQm7m4M/hnZbnsOrkxv0jfBQGvvPxRcvNNj5Ss+HEU8fO8j29LecPqIPeAbh7Q==
X-Received: by 2002:a05:600c:4da0:b0:3d3:5027:4cce with SMTP id v32-20020a05600c4da000b003d350274ccemr26379159wmp.10.1672498784813;
        Sat, 31 Dec 2022 06:59:44 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id n64-20020a1ca443000000b003d21759db42sm36702369wme.5.2022.12.31.06.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 06:59:44 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <33fc8bda-eedc-d1bf-7192-1cf1df5f6b3d@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 14:59:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/10] builtin/rebase.c: fix "options.onto_name" leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-07.10-484ebbfd6d1-20221230T071741Z-avarab@gmail.com>
In-Reply-To: <patch-07.10-484ebbfd6d1-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/12/2022 07:28, Ævar Arnfjörð Bjarmason wrote:
> In [1] we started saving away the earlier xstrdup()'d
> "options.onto_name" assignment to free() it, but when [2] added this
> "keep_base" branch it didn't free() the already assigned
> "squash_onto_name" before re-assigning to "options.onto_name". Let's
> do that, and fix the memory leak.

I'm afraid I don't really follow the reasoning here. "squash_onto_name" 
is only used if --root is given and that option is incompatible with 
--keep-base so the --keep-base branch has no business touching it. 
Having said that I think you've stumbled upon a viable solution if you 
drop the unneeded free() added below and rename "squash_onto_name" to 
something like "onto_name_to_free".

Best Wishes

Phillip


> 1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
> 2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/rebase.c                 | 3 ++-
>   t/t3416-rebase-onto-threedots.sh | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 91bf55be6e6..f7fd20d71c0 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1658,7 +1658,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		strbuf_addstr(&buf, options.upstream_name);
>   		strbuf_addstr(&buf, "...");
>   		strbuf_addstr(&buf, branch_name);
> -		options.onto_name = xstrdup(buf.buf);
> +		free(squash_onto_name);
> +		options.onto_name = squash_onto_name = xstrdup(buf.buf);
>   	} else if (!options.onto_name)
>   		options.onto_name = options.upstream_name;
>   	if (strstr(options.onto_name, "...")) {
> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
> index ea501f2b42b..f8c4ed78c9e 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -5,6 +5,7 @@ test_description='git rebase --onto A...B'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY/lib-rebase.sh"
>   
