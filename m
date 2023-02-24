Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06147C61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 14:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBXOzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBXOzi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 09:55:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D5168B3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 06:55:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c12so14196913wrw.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Cl6z1obw0GByS8zgWKeN3aXbyUHWsD/UM4x/PBe6pI=;
        b=WV8Xswi8lOiZKVOXJQuW4jlTZgnLHGNPYgi+nxvSl59dvoupBbnfo5qTILRO62aPZD
         IxsgMerTojhE7EtNUlndSFHCQY3SbIyGK9FoV6GbaHCoPONH9nOEZw3/ipsaZzX6xhgZ
         V+djhU0zaPW5v+NXo/bdyK2Hph6Gb43821d/pbyFzgwIKVggPaZPF4TxTwSKBsTadxgo
         QvDQyZLa2z7eO6+tk2QLUbBTQhFkb29aw2jyCIdckBfRhQVKs4ZjbZ3OQSayY7e9jyY0
         2fVOT8iaN1ki7Hzt4xwMextOAAAYqYP+ev5iNxPJzix8FejyxtqPaQ1I3MhKarX32/19
         woXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Cl6z1obw0GByS8zgWKeN3aXbyUHWsD/UM4x/PBe6pI=;
        b=f3FFMO2UnU7XCm+NQy2M+NH4lKaeUD/Q/cZvNfJeDCIrfWg1Ly2oiyWnyCKtZ35orq
         /OIXCP+J1QYUFJ9+YOkj2Tqsijtz9+LnHUCce97EpH8lLFMGbPVp8jxWT8UuzExqIohU
         7PqfaKPCPpvt9av748ak4Hm1B0nBp3H5RMa1rqY3/obQo0lWcOefIyHft9FdnQxSpJMj
         notO7V9gxjjMLV5MrrHkcJJIGzXdgS8OlTpCTD01GUz8Lk/4cz2VTil8eAvT9XrGd67Z
         WYKzXADh4vmbzyZiBYiNUn2yjO++JP4ADkaxY3sVHLyRGeoRKqrVq2LydId7IkdlWvA3
         bcpA==
X-Gm-Message-State: AO0yUKXXablLj+hwTXMm8PcpDRSkXpR/cEufvTsZk5LEvMlj/xq2rW86
        XDrW54eRCiaavB5Bqwzt5vM=
X-Google-Smtp-Source: AK7set99OSFDrMmqPdvbySoscoKFTQKFey/HZOWKjM14XWFAvGSci5IAaVnnvamInZEcV0pJJELRcg==
X-Received: by 2002:a5d:64ac:0:b0:2c5:4c9f:cf3b with SMTP id m12-20020a5d64ac000000b002c54c9fcf3bmr16549052wrp.7.1677250535972;
        Fri, 24 Feb 2023 06:55:35 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b002c54c92e125sm12188207wrr.46.2023.02.24.06.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 06:55:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7ba8a92d-8c94-5226-5416-6ed3a8e2e389@dunelm.org.uk>
Date:   Fri, 24 Feb 2023 14:55:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/3] rebase: add a config option for --rebase-merges
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-3-alexhenrie24@gmail.com>
Content-Language: en-US
In-Reply-To: <20230223053410.644503-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 23/02/2023 05:34, Alex Henrie wrote:
> The purpose of the new option is to accommodate users who would like
> --rebase-merges to be on by default and to facilitate possibly turning
> on --rebase-merges by default without configuration in a future version
> of Git.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/config/rebase.txt | 10 ++++
>   Documentation/git-rebase.txt    |  3 +-
>   builtin/rebase.c                | 47 ++++++++++++----
>   t/t3430-rebase-merges.sh        | 96 +++++++++++++++++++++++++++++++++
>   4 files changed, 144 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index f19bd0e040..308baa9dbb 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -67,3 +67,13 @@ rebase.rescheduleFailedExec::
>   
>   rebase.forkPoint::
>   	If set to false set `--no-fork-point` option by default.
> +
> +rebase.merges::
> +	Whether and how to set the `--rebase-merges` option by default. Can
> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
> +	true is equivalent to `--rebase-merges` without an argument, setting to
> +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
> +	`--rebase-merges` with that value as its argument, and setting to false
> +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
> +	command line without an argument overrides a `rebase.merges=false`
> +	configuration but does not override other values of `rebase.merge`.

Thanks for updating this, it is much clearer what the different settings 
mean now. I not sure if having the config setting override the default 
when the user passes --rebase-merges without an argument is a good idea.

> [...]   
> +static void parse_merges_value(struct rebase_options *options, const char *value)
> +{
> +	if (value) {
> +		if (!strcmp("no-rebase-cousins", value))
> +			options->rebase_cousins = 0;
> +		else if (!strcmp("rebase-cousins", value))
> +			options->rebase_cousins = 1;
> +		else
> +			die(_("Unknown mode: %s"), value);
> +	}
> +
> +	options->rebase_merges = 1;
> +}

It's a shame we seem to have grown yet another callback since v2, I'm 
not sure we should need to add quite so much code just to support a new 
config option

 > [...]
> @@ -1436,14 +1467,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.exec.nr)
>   		imply_merge(&options, "--exec");
>   
> -	if (rebase_merges) {
> -		if (!strcmp("rebase-cousins", rebase_merges))
> -			options.rebase_cousins = 1;
> -		else if (strcmp("no-rebase-cousins", rebase_merges))
> -			die(_("Unknown mode: %s"), rebase_merges);
> -		options.rebase_merges = 1;
> +	if (options.rebase_merges)
>   		imply_merge(&options, "--rebase-merges");
> -	}

As I have said before I really think this patch needs to follow the lead 
of eddfcd8ece (rebase: provide better error message for apply options 
vs. merge config, 2023-01-25) and provide an error message if 
--rebase-merges is enabled by rebase.merges and the user provides a 
command line option that requires the apply backend. So

	git -c rebase.merges=true rebase --whitespace=fix

would result in

	error: apply options are incompatible with rebase.merges.
	Consider adding --no-rebase-merges

> [...]
> +test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b no-override-config-rebase-cousins main &&
> +	git rebase --rebase-merges HEAD^ &&

I think this behavior is confusing for users and will break scripts that 
quite reasonably assume --rebase-merges is equivalent to 
--rebase-merges=no-rebase-cousins

> [...]
> +test_expect_success 'local rebase.merges=false overrides global rebase.merges=true' '
> +	test_config_global rebase.merges true &&
> +	test_config rebase.merges false &&
> +	git checkout -b override-global-config E &&
> +	git rebase C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success 'local rebase.merges="" does not override global rebase.merges=true' '
> +	test_config_global rebase.merges no-rebase-cousins &&
> +	test_config rebase.merges "" &&
> +	git checkout -b no-override-global-config E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase C &&
> +	test_cmp_rev HEAD $before
> +'

These two tests seem to be testing the config subsystem rather than this 
patch. As Dscho has pointed out it is important to get a balance between 
test coverage and test run time. I think these two tests can definitely 
be dropped.

Best Wishes

Phillip
