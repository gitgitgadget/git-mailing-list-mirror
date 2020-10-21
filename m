Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E2EC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09880221FC
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqirJkRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441551AbgJUNZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405683AbgJUNZa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:25:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332FC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:25:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so3010144wru.12
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Vqj3Q575IJt4JhJhctogfnkXljLKLK214hCyNLPDDY=;
        b=sqirJkRVezotf3DvW+gmvMotvAXZE7WoqfMkND2ODgqVwnKpxok0/1DyErvXO9fZY1
         C3o3tqazvzaFEBEXm3CFBVeJsIoUknTn+sinr1gygR+B6gP9Kv+qEde8Hmmtd/qkRpLK
         wNA09q9jCRXEQ0G8axE+LD0NkFQEkke5QFYb6Q+CRZ5DJ0X/yI+nLlYZ3E+davh2aSaS
         zCl3S08Lz0K7h2F07xotSVTvNgd3R1fYvxL6GSTykOE43mNLOW7wxUFk+4M086VMWmZK
         sui0jGVJI06DPsgjBjcNFL1H/NdSOb7kwxCxBvi26eeBf+sMwNuquumPHOSnkYBOtdsD
         VWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Vqj3Q575IJt4JhJhctogfnkXljLKLK214hCyNLPDDY=;
        b=V5IQx5rMTledaxYcbht/pLFAQux9fRe/cZiDUguW/J0RJ/0DJ0BTWMfbHoJ2psBx9M
         ARckzK+2D84PKrAQ9YFr9zYg5L14ACvJ0JTEZDJdjgaogoNhXhmSuFOq0TWgfAr64PtV
         q1CgoTeVDCHmm02cz2/7YhGNU9Cz1A84B0jRI4QNdxoHKdXuSSFWLCSxEPQozNqAx1Y+
         dRyPZO+xcpp6mFOiRkUGfZmi+IlhZ5OMQgtCbHmTfRso7T3EI/LuRXvmpfVT4wsyZ7Rd
         CX0FGRgSPNCnmUJx0nx2OzEKpJyiLWWdxljhtq24Ierwwk+7/fWm93h4crseS8q/oMIm
         UMoQ==
X-Gm-Message-State: AOAM530Q2Oyh3nxUrU0klYi8Z2wW6eIpOShFBOSmXVkNK3Ib2CuItd+z
        1jyA05bXn1cmrGUrj8DSdvNeeqTjDWk=
X-Google-Smtp-Source: ABdhPJylXEUAEJ3Q7LGceuXcBgG/bi3J8pmEgDyWodVqBzwwZF3eRXBweRl8/J9mw3Kqi2A0tkx9cg==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr4820778wrs.412.1603286727964;
        Wed, 21 Oct 2020 06:25:27 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id u195sm3681331wmu.18.2020.10.21.06.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 06:25:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test
 script
To:     Joey S <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fc5fecec-1a77-871d-d1f9-dad1bae8920c@gmail.com>
Date:   Wed, 21 Oct 2020 14:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joey

On 20/10/2020 20:53, Joey S wrote:
> Modernize the test by replacing `test -e` instances with
> `test_path_is_file` helper functions, and `! test -e` with
> `test_path_is_missing`, for better readability and diagnostic messages.

This is a good summary of the changes and importantly explains why we're 
making the changes

> Signed-off-by: Joey Salazar <jgsal@protonmail.com>

The patch looks fine to me now

Thanks

Phillip

> ---
>   t/t7006-pager.sh | 84 ++++++++++++++++++++++++------------------------
>   1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 00e09a375c..fdb450e446 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -19,7 +19,7 @@ test_expect_success 'setup' '
>   test_expect_success TTY 'some commands use a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git log &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_failure TTY 'pager runs from subdir' '
> @@ -65,49 +65,49 @@ test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
>   test_expect_success TTY 'some commands do not use a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git rev-list HEAD &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success 'no pager when stdout is a pipe' '
>   	rm -f paginated.out &&
>   	git log | cat &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success 'no pager when stdout is a regular file' '
>   	rm -f paginated.out &&
>   	git log >file &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git --paginate rev-list uses a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git --paginate rev-list HEAD &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success 'no pager even with --paginate when stdout is a pipe' '
>   	rm -f file paginated.out &&
>   	git --paginate log | cat &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'no pager with --no-pager' '
>   	rm -f paginated.out &&
>   	test_terminal git --no-pager log &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'configuration can disable pager' '
>   	rm -f paginated.out &&
>   	test_unconfig pager.grep &&
>   	test_terminal git grep initial &&
> -	test -e paginated.out &&
> +	test_path_is_file paginated.out &&
> 
>   	rm -f paginated.out &&
>   	test_config pager.grep false &&
>   	test_terminal git grep initial &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'configuration can enable pager (from subdir)' '
> @@ -122,107 +122,107 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
>   		test_terminal git bundle unbundle ../test.bundle
>   	) &&
>   	{
> -		test -e paginated.out ||
> -		test -e subdir/paginated.out
> +		test_path_is_file paginated.out ||
> +		test_path_is_file subdir/paginated.out
>   	}
>   '
> 
>   test_expect_success TTY 'git tag -l defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git tag -l &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -l respects pager.tag' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false tag -l &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -l respects --no-pager' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag --no-pager tag -l &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag with no args defaults to paging' '
>   	# no args implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git tag &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag with no args respects pager.tag' '
>   	# no args implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false tag &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag --contains defaults to paging' '
>   	# --contains implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git tag --contains &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag --contains respects pager.tag' '
>   	# --contains implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false tag --contains &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -a defaults to not paging' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git tag -am message newtag &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -a ignores pager.tag' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag tag -am message newtag &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -a respects --paginate' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git --paginate tag -am message newtag &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag -c alias.t=tag t -am message newtag &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false -c alias.t=tag t -l &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git branch defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git branch &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git branch respects pager.branch' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.branch=false branch &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git branch respects --no-pager' '
>   	rm -f paginated.out &&
>   	test_terminal git --no-pager branch &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git branch --edit-description ignores pager.branch' '
> @@ -232,8 +232,8 @@ test_expect_success TTY 'git branch --edit-description ignores pager.branch' '
>   		touch editor.used
>   	EOF
>   	EDITOR=./editor test_terminal git -c pager.branch branch --edit-description &&
> -	! test -e paginated.out &&
> -	test -e editor.used
> +	test_path_is_missing paginated.out &&
> +	test_path_is_file editor.used
>   '
> 
>   test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
> @@ -242,13 +242,13 @@ test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
>   	test_when_finished "git branch -D other" &&
>   	test_terminal git -c pager.branch branch --set-upstream-to=other &&
>   	test_when_finished "git branch --unset-upstream" &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git config ignores pager.config when setting' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.config config foo.bar bar &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git config --edit ignores pager.config' '
> @@ -257,33 +257,33 @@ test_expect_success TTY 'git config --edit ignores pager.config' '
>   		touch editor.used
>   	EOF
>   	EDITOR=./editor test_terminal git -c pager.config config --edit &&
> -	! test -e paginated.out &&
> -	test -e editor.used
> +	test_path_is_missing paginated.out &&
> +	test_path_is_file editor.used
>   '
> 
>   test_expect_success TTY 'git config --get ignores pager.config' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.config config --get foo.bar &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git config --get-urlmatch defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git -c http."https://foo.com/".bar=foo \
>   			  config --get-urlmatch http https://foo.com &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git config --get-all respects pager.config' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.config=false config --get-all foo.bar &&
> -	! test -e paginated.out
> +	test_path_is_missing paginated.out
>   '
> 
>   test_expect_success TTY 'git config --list defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git config --list &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
> 
> @@ -392,7 +392,7 @@ test_default_pager() {
>   			export PATH &&
>   			$full_command
>   		) &&
> -		test -e default_pager_used
> +		test_path_is_file default_pager_used
>   	"
>   }
> 
> @@ -406,7 +406,7 @@ test_PAGER_overrides() {
>   		PAGER='wc >PAGER_used' &&
>   		export PAGER &&
>   		$full_command &&
> -		test -e PAGER_used
> +		test_path_is_file PAGER_used
>   	"
>   }
> 
> @@ -432,7 +432,7 @@ test_core_pager() {
>   		export PAGER &&
>   		test_config core.pager 'wc >core.pager_used' &&
>   		$full_command &&
> -		${if_local_config}test -e core.pager_used
> +		${if_local_config}test_path_is_file core.pager_used
>   	"
>   }
> 
> @@ -464,7 +464,7 @@ test_pager_subdir_helper() {
>   			cd sub &&
>   			$full_command
>   		) &&
> -		${if_local_config}test -e core.pager_used
> +		${if_local_config}test_path_is_file core.pager_used
>   	"
>   }
> 
> @@ -477,7 +477,7 @@ test_GIT_PAGER_overrides() {
>   		GIT_PAGER='wc >GIT_PAGER_used' &&
>   		export GIT_PAGER &&
>   		$full_command &&
> -		test -e GIT_PAGER_used
> +		test_path_is_file GIT_PAGER_used
>   	"
>   }
> 
> @@ -489,7 +489,7 @@ test_doesnt_paginate() {
>   		GIT_PAGER='wc >GIT_PAGER_used' &&
>   		export GIT_PAGER &&
>   		$full_command &&
> -		! test -e GIT_PAGER_used
> +		test_path_is_missing GIT_PAGER_used
>   	"
>   }
> 
> --
> 2.29.0.rc2
> 
