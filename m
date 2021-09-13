Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984DC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD5F60555
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbhIMTWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:22:49 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28502 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241829AbhIMTWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:22:47 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mPrWD-0009ye-79; Mon, 13 Sep 2021 20:21:29 +0100
Subject: Re: [PATCH v2 3/5] help tests: add test for --config output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
 <patch-v2-3.5-258282095de-20210910T112545Z-avarab@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <d167b927-d7b8-dfe6-d012-37919d14128b@iee.email>
Date:   Mon, 13 Sep 2021 20:21:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-3.5-258282095de-20210910T112545Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2021 12:28, Ævar Arnfjörð Bjarmason wrote:
> Add a missing test for checking what the --config output added in
> ac68a93fd2 (help: add --config to list all available config,

This ref should be 3ac68a93fd2
Probable hand editing mistake - it's Ok in 4/5

> 2018-05-26) looks like. We should not be emitting anything except
> config variables and the brief usage information at the end here.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t0012-help.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index c3aa016fd30..595bf81f133 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -77,6 +77,19 @@ test_expect_success 'git help -g' '
>  	test_i18ngrep "^   tutorial   " help.output
>  '
>  
> +test_expect_success 'git help -c' '
> +	git help -c >help.output &&
> +	cat >expect <<-\EOF &&
> +
> +	'"'"'git help config'"'"' for more information
> +	EOF
> +	grep -v -E \
> +		-e "^[^.]+\.[^.]+$" \
> +		-e "^[^.]+\.[^.]+\.[^.]+$" \
> +		help.output >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'generate builtin list' '
>  	git --list-cmds=builtins >builtins
>  '

