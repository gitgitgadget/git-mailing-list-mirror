Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7155FC678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 09:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCBJhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCBJhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 04:37:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F363B3D1
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 01:37:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so1825000wms.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 01:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677749828;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97y4Hl3v3VcYMtm+XFW1S3vugYLBECN1CRSzBG8ylR0=;
        b=Vd5zLxfix2Xbnp+GAypkEDr9Z7KPBzNRE1ESHxDm0VjQONd158TI2tESscm/pQzQz5
         Hd6hkAISbYPVTLiL7z+VOBSiDN6Ia8EATwgB+tT3kHEwW1hL5dLfmRN9j9+dhFx6TIlt
         c4al5up2e0Gy09dItE5t8LWPXFUbar7F6R+bfNuxbN9DyZe1GJIfHGQFkFl9VIooV0Er
         S0egWMUtj79v2tU4o6DDcbc1imUgpNkWPtQ6bc5UpW799TbVQamGOH88O4AnEWf5VQ2Q
         iQhklFgFF/qQN4gDCFFHiwwQeERqqQrwT1EpP6FM/aqFuJZ6us4Rf7919Vc9T2VGqvlE
         qhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677749828;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97y4Hl3v3VcYMtm+XFW1S3vugYLBECN1CRSzBG8ylR0=;
        b=nSsKyO0bPHQzhKzGwPG/xB1RskhyLDhaTwBJKNunGnuU1NRRYiJ119SFX68XpHhB/w
         gV58cp0AlY+j1EgUlJ9oXGEjF+ctyLUeYhsYQBrPBJkUy17NbhOl4ZlKMSxE0+JWjgrL
         FnBf0sh7rP5F5aOcshGdOBBM/MmckoshYjNSICNZw6GCZ2LzMjHBn+K59q41D8mQx8zG
         6azyEee5eNVUvXVWr6SPTfkbRegseChvFT1NcV5cLJ09+bhj89WWN58gRG9verP9TiwN
         Vw2S4oSBAZdBiO6kZYxU97REXe1jPh6tak3V2ePzkg57xH+DHj+mA0a+1NiEp8zcUbl9
         CC7g==
X-Gm-Message-State: AO0yUKUGqUhWLyVEW2EMw1ENqNthcuTU90atLcyf3EnhqsM7zTFzxotR
        TRlNV+zTzpARUU6vw0PqIv8=
X-Google-Smtp-Source: AK7set8EAp2FE0oVTGSiaqHb11iE9WLzqaa/I5ol50eTrT56BzZV93KgffPqglR2N63iiPj0bLjO9w==
X-Received: by 2002:a05:600c:70a:b0:3eb:2b79:a40 with SMTP id i10-20020a05600c070a00b003eb2b790a40mr7373374wmn.20.1677749827661;
        Thu, 02 Mar 2023 01:37:07 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dd1bd0b915sm2594992wms.22.2023.03.02.01.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:37:07 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk>
Date:   Thu, 2 Mar 2023 09:37:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230225180325.796624-4-alexhenrie24@gmail.com>
In-Reply-To: <20230225180325.796624-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 25/02/2023 18:03, Alex Henrie wrote:
> The purpose of the new option is to accommodate users who would like
> --rebase-merges to be on by default and to facilitate possibly turning
> on --rebase-merges by default without configuration in a future version
> of Git.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/config/rebase.txt        | 10 ++++
>   Documentation/git-rebase.txt           |  3 +-
>   builtin/rebase.c                       | 79 ++++++++++++++++++--------
>   t/t3422-rebase-incompatible-options.sh | 12 ++++
>   t/t3430-rebase-merges.sh               | 63 ++++++++++++++++++++
>   5 files changed, 143 insertions(+), 24 deletions(-)
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

I'm still not clear why the commandline doesn't override the config in 
all cases as is our usual practice. After all if the user has set 
rebase.merges then they don't need to pass --rebase-merges unless they 
want to override the config.

 > [...]
> @@ -1513,13 +1539,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				break;
>   
>   		if (i >= 0 || options.type == REBASE_APPLY) {
> -			if (is_merge(&options))
> -				die(_("apply options and merge options "
> -					  "cannot be used together"));
> -			else if (options.autosquash == -1 && options.config_autosquash == 1)
> +			if (options.autosquash == -1 && options.config_autosquash == 1)
>   				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
> +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
> +				die(_("apply options are incompatible with rebase.merges.  Consider adding --no-rebase-merges"));

This is good, thanks for adding it

 > [...]
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f50fbf1390..a825a77fb4 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -283,6 +283,69 @@ test_expect_success '--rebase-merges="" is deprecated' '
>   	grep deprecated actual
>   '
>   
> +test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b config-rebase-cousins main &&
> +	git rebase HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
> +test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
> +	test_config rebase.merges no-rebase-cousins &&
> +	git checkout -b override-config-no-rebase-cousins E &&
> +	git rebase --no-rebase-merges C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b override-config-rebase-cousins main &&
> +	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	o | H
> +	|/
> +	o A
> +	EOF
> +'

I'm not sure this test adds much value, it is hard to see what kind of 
regression would allow the others to pass but not this one.

> +test_expect_success '--rebase-merges overrides rebase.merges=false' '
> +	test_config rebase.merges false &&
> +	git checkout -b override-config-merges-false E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&
> +	test_cmp_rev HEAD $before

This test passes if the rebase does nothing, maybe pass --force and 
check the graph?


Best Wishes

Phillip

> +'
> +
> +test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b no-override-config-rebase-cousins main &&
> +	git rebase --rebase-merges HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
>   test_expect_success 'refs/rewritten/* is worktree-local' '
>   	git worktree add wt &&
>   	cat >wt/script-from-scratch <<-\EOF &&
