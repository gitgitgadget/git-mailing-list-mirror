Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02D4C6FD1E
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCHQU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 11:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjCHQUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 11:20:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282FB53C4
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 08:20:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r18so15948360wrx.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292421;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdtW2st/RDPJ9LOMjURsfwdjYze3nKYJWhtf365zjBQ=;
        b=dWl34FfMfBLj90YYGp1BTXSFBHksOWiTN7EG7a712DWPhx02BTUK23+0wfvaUf/QnG
         lf1ZjYYcpnQMcTW0Wql3FYrUeojQOCmdimqP014Dd+LZuVYxQYZvC41LmfDqtfVcqgf9
         76cVZCZjC+Y01dqA2HZ0Mx9ixW38jCqwo8kHWMOKQDIthJmNjyZl/L1hsRLZX3crs8qT
         tCq49RVpt794/8jP3t1KJS4QWxDlJ1UMN/+GPS50RQQiqyrW0UAmqy6dYAkItPPYkuZy
         ju9gRKCkZB2NRjcD/2nXFLZVna+BcHZHjInf1YfeBUataIngCgvwcZqVXOxyA0ZSMiW4
         uV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292421;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdtW2st/RDPJ9LOMjURsfwdjYze3nKYJWhtf365zjBQ=;
        b=U4pj5HeTvce74hYB+pz5bH6WK/ULcrAkoiWKk636RDGQcrevHm7efjj3vW47IbqkuR
         YQ7OxdLPPPxwczai9rxPInvQXKMPsVmTtPinLyfcCqfW+w3ZqSR8wPzh8XL66zbW5iYr
         bZ1tVvTBlQS9Gd7h2Zu3PpM4f3rnqcFyc2lOmpSCkS85P03+T8jFuRsHWWvlOnZsK45h
         1ATKMpC8nfkABh1tb5hPiEM1JbAXqliMrLbhuWKB4cBpcA/izV2XNA3VPHP0ZCmN7g1/
         YJlSKFp41kmlJwU8cea1Mx3evLwTx/ioTfMf+rG4ZuwsH4hKmruiHOb3JELYkDLnOjEC
         Y2Hg==
X-Gm-Message-State: AO0yUKXdjACjN8xEZH6ZoeQQcneGA3qulb1DPC1kekBUfmAvrUw78VX1
        ylt2W0JSUXq/WGpaxf3q8x8=
X-Google-Smtp-Source: AK7set+FRUWS0AciP0NSTwB5ae+QIT5OFzV8urDzIdD/PiYxygkf3+OURlOTiRMgSnBaienC7RiM8Q==
X-Received: by 2002:a5d:50c7:0:b0:2cb:29eb:a35e with SMTP id f7-20020a5d50c7000000b002cb29eba35emr16490265wrt.11.1678292421332;
        Wed, 08 Mar 2023 08:20:21 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id m14-20020adffe4e000000b002c54c8e70b1sm15830856wrs.9.2023.03.08.08.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 08:20:20 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d1fcbbe5-52ce-54d0-bad6-97997a2a72c3@dunelm.org.uk>
Date:   Wed, 8 Mar 2023 16:20:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer.c: fix overflow & segfault in
 parse_strategy_opts()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <patch-1.1-f6a06e25cf3-20230307T182039Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-f6a06e25cf3-20230307T182039Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 07/03/2023 18:21, Ævar Arnfjörð Bjarmason wrote:
> The split_cmdline() function introduced in [1] returns an "int". If
> it's negative it signifies an error. The option parsing in [2] didn't
> account for this, and assigned the value directly to the "size_t
> xopts_nr". We'd then attempt to loop over all of these elements, and
> access uninitialized memory.
> 
> There's a few things that use this for option parsing, but one way to
> trigger it is with a bad value to "-X <strategy-option>", e.g:
> 
> 	git rebase -X"bad argument\""

As Junio said that's nasty, thanks for catching it. I think what Junio 
has queued in seen is fine. The root cause of the issue is that we don't 
quote the --strategy-option arguments properly. I've got some cleanups 
based on top of this at 
https://github.com/phillipwood/git/commits/sequencer-merge-strategy-options 
to address that. I'll submit them once I've cleaned them up.

Best Wishes

Phillip

> In another context this might be a security issue, but in this case
> someone who's already able to inject arguments directly to our
> commands would be past other defenses, making this potential
> escalation a moot point.
> 
> As the example above & test case shows the error reporting leaves
> something to be desired. The function will loop over the
> whitespace-split values, but when it encounters an error we'll only
> report the first element, which is OK, not the second "argument\""
> whose quote is unbalanced.
> 
> This is an inherent limitation of the current API, and the issue
> affects other API users. Let's not attempt to fix that now. If and
> when that happens these tests will need to be adjusted to assert the
> new output.
> 
> 1. 2b11e3170e9 (If you have a config containing something like this:,
>     2006-06-05)
> 2. ca6c6b45dd9 (sequencer (rebase -i): respect strategy/strategy_opts
>     settings, 2017-01-02)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> CI & branch for this at
> https://github.com/avar/git/tree/avar/sequencer-xopts-nr-overflow
> 
> Not a new issue, but I figured with other discussions in this area
> kicking this out the door sooner than later was better.
> 
>   sequencer.c                    |  9 +++++++--
>   t/t3436-rebase-more-options.sh | 18 ++++++++++++++++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 3e4a1972897..79c615193b6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2876,13 +2876,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>   void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
>   {
>   	int i;
> +	int count;
>   	char *strategy_opts_string = raw_opts;
>   
>   	if (*strategy_opts_string == ' ')
>   		strategy_opts_string++;
>   
> -	opts->xopts_nr = split_cmdline(strategy_opts_string,
> -				       (const char ***)&opts->xopts);
> +	count = split_cmdline(strategy_opts_string,
> +			      (const char ***)&opts->xopts);
> +	if (count < 0)
> +		die(_("could not split '%s': '%s'"), strategy_opts_string,
> +			    split_cmdline_strerror(count));
> +	opts->xopts_nr = count;
>   	for (i = 0; i < opts->xopts_nr; i++) {
>   		const char *arg = opts->xopts[i];
>   
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 94671d3c465..195ace34559 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -40,6 +40,24 @@ test_expect_success 'setup' '
>   	EOF
>   '
>   
> +test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
> +	cat >expect <<-\EOF &&
> +	fatal: could not split '\''--bad'\'': '\''unclosed quote'\''
> +	EOF
> +	test_expect_code 128 git rebase -X"bad argument\"" side main >out 2>actual &&
> +	test_must_be_empty out &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
> +	cat >expect <<-\EOF &&
> +	fatal: could not split '\''--bad'\'': '\''cmdline ends with \'\''
> +	EOF
> +	test_expect_code 128 git rebase -X"bad escape \\" side main >out 2>actual &&
> +	test_must_be_empty out &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success '--ignore-whitespace works with apply backend' '
>   	test_must_fail git rebase --apply main side &&
>   	git rebase --abort &&
