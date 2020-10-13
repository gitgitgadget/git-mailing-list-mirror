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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08472C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EA62078A
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 09:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r13Jx8dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgJMJzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgJMJzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 05:55:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A50C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 02:55:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so22931719wrm.13
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YbrPI3gfqjh/CMKoMN575NX2DTerxwM/IrB8kqvGkdY=;
        b=r13Jx8dC/u3LKQKst61Svp7YWwBrjYaaTUHfJeqXO0XYmryptoZdcBS9Lm8BH/Nipf
         ulw0E3MYACnCrkPc3Qd3HtZEUZanzg16Ieq815t3Vixr6ARt87vMxvGBYikyh6xTziza
         J5G3Btl+f9ggT35r//I8mtExt78pMuv0FMRQcQSo3nr0nYiuWpMcfpsOHDm/75fy5vhh
         Q4ZznGzADK/F2W2nSSno8WaseGecmrsl8sYCWSqoeYQdTW9YQeAMJR6FMXiVDf3jHeVo
         eOWDKuJA9alEchyfnxihypq1bFAZ2qz9/rVU/xQUpwQMrm0/cc9zVxSRTLEtF4tdEPKK
         x7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YbrPI3gfqjh/CMKoMN575NX2DTerxwM/IrB8kqvGkdY=;
        b=THuA8oC2yx8q3+AYmSxFNsk2QV32AyswX4sM8rf18Y4yaUrda91lsfD0qRZz/JgAxt
         EHdE5q5Z4aQdkT3p/5yhlV0rNzqKEsQosvXPVvDMnFKLlofrTMqbHDC9CDm30t4UKgv8
         stfzt1te4YPkW6z1LbFR+Mq1mDQBYRJUVFJMizeXM2jjSor4v/pM86/1hHndFZlvFTlq
         tQzJBxayBmu63nshPq7UQmIVkc144rxRqYGjfl6JBydnLxC3Cwy/udmNsQTVSQ5JqInK
         T6F67bQaUN/YOzpMAVYrPkF6/tFX3bZIcyp5kx0KnfFh0upKMcYuQVuTBiHyG3M9NzXh
         myfQ==
X-Gm-Message-State: AOAM530osyHASxZW68VhFCP+R/cwllglVZq5ZaW2eFlYi510ztLziYRX
        2aSqtTqQXpyBEVZuMUwVTME=
X-Google-Smtp-Source: ABdhPJzV4ugzJV8F3iyY5orPulDAPx2n+Y08e0i0dol/FUf4RVoJ7JkThusowMmGJyPV7Se3xsuATg==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr34902323wrq.59.1602582938425;
        Tue, 13 Oct 2020 02:55:38 -0700 (PDT)
Received: from [192.168.1.201] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.googlemail.com with ESMTPSA id 1sm30334394wre.61.2020.10.13.02.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 02:55:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201012234901.1356948-1-samuel@cavoj.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <92b32c0a-68ef-f0f2-48d4-ddb3e1cc7245@gmail.com>
Date:   Tue, 13 Oct 2020 10:55:36 +0100
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

Thanks for re-rolling this

On 13/10/2020 00:49, Samuel Čavoj wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> When performing a rebase with --rebase-merges using either a custom
> strategy specified with -s or an octopus merge, and at the same time
> having gpgsign enabled (either rebase -S or config commit.gpgsign), the
> operation would fail on making the merge commit.

Small nit-pick: I think it worked fine with if commit.gpgsign was set 
and the user did not pass -S or --no-gpg-sign because merge would sign 
the commits as commit.gpgsign was set, it was only if the user passed a 
gpg signing option to rebase that we had problems. I'm not sure it's 
worth a re-roll just for that though

Best Wishes

Phillip

> Instead of "-S%s" with
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
> +
>   test_done
> 

