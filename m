Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFAC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E4B207C3
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcYqj9Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgJMKCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgJMKCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 06:02:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEFBC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 03:02:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e17so23231796wru.12
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=13k6kyOjobyqp/1jhvLz31Bs66kYUVFAe7A7w7G1CqY=;
        b=fcYqj9OtMmesoGQ2I3eUEAFi0lW1OV6owMz/MQdQf6TbLEelOkeYvv2k6YJs07Tjxv
         1iMx8NP9XPxaaGC8KUlI9OuiWMAVn0vo2J/jihpLMwDLUi5zA2Z/iRLpdkE2vt7nUKiU
         p/PUESUri7vU+zS08Kxu+6eCFmTtQE7s4tnxrmyPat7M/gZKmEJdWm0XvQosvGYxbdvo
         aHIFmuyBJGGYSZbCVtgekECnWnNRAd1ZgauiM/Vpbv+GgJov5aN+w4K5t9iC7qa28PwO
         LMZerYbSjglmBNeNhVloh16Ljnu+JZ/zBu1whB+BQh/bFHmg3bDauYQtyICIciEZGpUf
         iPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13k6kyOjobyqp/1jhvLz31Bs66kYUVFAe7A7w7G1CqY=;
        b=pWa8khq2XrGGLJBG8pzGNZcvW/EfjZE5RyVw4Q6zttwpK70TEH9Twf3lANie5gUuxO
         Wv1g/o4mDkjoZkAcrnMFuGdJv0jXZFkjfpF9JuAFHXnBQgIPllkU1XJCos716y+RwR4u
         UU4O8S2sVfi/W2GEeKB5Cd+iY0A0CHQUx+XJkSaJZfLU59RMWyDsX7glyY7AZ81mlEYG
         0x5AHmMkmXPG3sgiF6FyRNAwIqNvo+bZIRTIDvTdkxF/1htyxjgWlcTC8o+LiYG554wC
         fdkVSbH057N1BLisLUXke5qv0IIDsVD+ilD4++GGAvn4UoMuSET43Q8CoMCnhUDdUY40
         h5qg==
X-Gm-Message-State: AOAM530mxX0z3bUZ4yizbBa1g9CCRXEm9vSWN7XB4Q9h468dY+flhD+t
        +WuIarxDLNC796IpM3+2v2aSzUR01PI=
X-Google-Smtp-Source: ABdhPJy6RB0oRAOZop6x3F7H34CBfmOCnWIlP8fzF03inT/VJIXuVuX3xnNeL9CKBZXmocZV0gW1fQ==
X-Received: by 2002:adf:deca:: with SMTP id i10mr30086564wrn.96.1602583360052;
        Tue, 13 Oct 2020 03:02:40 -0700 (PDT)
Received: from [192.168.1.201] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.googlemail.com with ESMTPSA id 1sm30357360wre.61.2020.10.13.03.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 03:02:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201012234901.1356948-1-samuel@cavoj.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
Date:   Tue, 13 Oct 2020 11:02:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012234901.1356948-1-samuel@cavoj.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel

On 13/10/2020 00:49, Samuel Čavoj wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> When performing a rebase with --rebase-merges using either a custom
> strategy specified with -s or an octopus merge, and at the same time
> having gpgsign enabled (either rebase -S or config commit.gpgsign), the
> operation would fail on making the merge commit. Instead of "-S%s" with
> the key id substituted, only the bare key id would get passed to the
> underlying merge command, which tried to interpret it as a ref.
> 
> Fix the issue and add a test case as suggested by Johannes Schindelin.
> 
> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> ---
> changed v1 -> v2:
>      added test case
> ---
>   sequencer.c                | 2 +-
>   t/t3435-rebase-gpg-sign.sh | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 00acb12496..88ccff4838 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>   		strvec_push(&cmd.args, "-F");
>   		strvec_push(&cmd.args, git_path_merge_msg(r));
>   		if (opts->gpg_sign)
> -			strvec_push(&cmd.args, opts->gpg_sign);
> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>   
>   		/* Add the tips to be merged */
>   		for (j = to_merge; j; j = j->next)
> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> index b47c59c190..f70b280f5c 100755
> --- a/t/t3435-rebase-gpg-sign.sh
> +++ b/t/t3435-rebase-gpg-sign.sh
> @@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
>   	test_must_fail git verify-commit HEAD
>   '
>   
> +test_expect_success 'rebase -r, GPG and merge strategies' '
> +	git reset --hard merged &&
> +	git rebase -fr --gpg-sign -s resolve --root &&
> +	git verify-commit HEAD
> +'

Unfortunately I've just noticed that the test above runs

	git config commit.gpgsign true

So this test would pass anyway if merge picks up that config setting. 
The previous test needs to be changed to

	test_config commit.gpgsign true

so that the config setting is cleared when that test finishes. That 
previous test would then be a good template for testing `rebase -r 
--no-gpg-sign` if you wanted to add a test for that to the next patch as 
Junio suggested.

Best Wishes

Phillip

>   test_done
> 

