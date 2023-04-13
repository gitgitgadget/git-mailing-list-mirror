Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B0C77B6F
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDMVzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMVzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 17:55:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D35BA2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:55:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q2so21353289pll.7
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681422900; x=1684014900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tMdJJZj/Ltm+gNMIYCDRBaSzim/rsyEFKb0DC4JBJc=;
        b=bOzYRB+rrwYoW5/sTCvxzXeJ2fX4HrrGGarmRhOzLcnZdi/qVWOY9zr77J15VSpJOd
         MQxXjmQHHUmA6KdsldrtJdISj05WAOSpvqjmcWD7PJh+wTsX5JISykN+z2A3f2hUkFVD
         wZUptqrbTblJFIixF1Gt43zA9sQZdFtb74V5wNIiamnVIGo2AUqDyHQeRqtxI6AANfbN
         /s0ZzaRsWlrseag/kzYhvwavTxqSOyNtfhJcDo394MD/psurjAmfZQHEpWy6DnjoZlE5
         x5XMbkDSvVtyOdfXHPjUH2zmF8Q07yOZUaEu1lSb+fRcpKSD9d7Iq6SUMr7P6NpmqNhJ
         qTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681422900; x=1684014900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tMdJJZj/Ltm+gNMIYCDRBaSzim/rsyEFKb0DC4JBJc=;
        b=MnI3lMa79GzHUIO278YDNLtVaLTgSPxC7iZvjLqGlsCyKDECYFEvOfCE5bnD3SXOvQ
         PPGd8L2eetGAdLx0O22OdNLMKAbD0yz0UA/YLU82VyPLtQ9vISkjnYqF5KIS3Dm0DNhw
         PyhO/WzCwfc+ZxYMCTlOQPL8Aob/uSmu6YxCRE6Sm8tshdDmp8Jee+VMXkBizJV6FsTK
         Qud6K5M4hNgDl76HcGBFpdVsE1BGWc7eO4DqRwZCWq0iMR16Ljnrdj1vk97y31thAQ1W
         /PhLbPpXQz7FVoe8DoqtdrfU03fVMcBSh2t/tB2e5j2i/4Vh7OQTIBwUiRqC9+/4Li/m
         ViyA==
X-Gm-Message-State: AAQBX9eveixMy5TjJrTxxYId3JgotDLnIcimvJMug9vdJWUec4Rj8Wbn
        l+GA4dQMTo92mN5jRQ8BRdUc
X-Google-Smtp-Source: AKy350ZdoTbdzao+JtR4A87AJsaOaaMPwYgKHELH8Onp5cKP8gqbkSWnJE0X2qyc743XNgICQ1u2nQ==
X-Received: by 2002:a17:903:41d1:b0:1a6:6b5d:8381 with SMTP id u17-20020a17090341d100b001a66b5d8381mr412198ple.21.1681422899754;
        Thu, 13 Apr 2023 14:54:59 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id oa4-20020a17090b1bc400b002469a865810sm3659307pjb.28.2023.04.13.14.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 14:54:59 -0700 (PDT)
Message-ID: <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
Date:   Thu, 13 Apr 2023 14:54:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 2/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-3-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230322161820.3609-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index dc991f753b..db90592090 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -27,6 +27,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  		usage(diff_files_usage);
>  
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
> +
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	rev.abbrev = 0;
>  
> @@ -80,6 +84,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  		result = -1;
>  		goto cleanup;
>  	}
> +
> +	if (pathspec_needs_expanded_index(the_repository->index, &rev.diffopt.pathspec))
> +		ensure_full_index(the_repository->index);

After reviewing the 'diff-index' integration [1], I'm wondering whether we
actually need pathspec expansion at all in this case. 'diff-files' compares
the working tree and the index, and will output a difference if the file on
disk differs from the index. But, if a file is SKIP_WORKTREE'd, that diff
will (I think?) always be empty. So, why would we need to expand a sparse
directory to match a pathspec to its contents if we *know* that the diff
will be empty?

[1] https://lore.kernel.org/git/20230408112342.404318-1-nanth.raghul@gmail.com/

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index d23041e27a..152f3f752e 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1401,6 +1401,30 @@ ensure_not_expanded () {
>  	test_region ! index ensure_full_index trace2.txt
>  }
>  
> +ensure_expanded () {
> +	rm -f trace2.txt &&
> +	if test -z "$WITHOUT_UNTRACKED_TXT"
> +	then
> +		echo >>sparse-index/untracked.txt
> +	fi &&
> +
> +	if test "$1" = "!"
> +	then
> +		shift &&
> +		test_must_fail env \
> +			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> +			git -C sparse-index "$@" \
> +			>sparse-index-out \
> +			2>sparse-index-error || return 1
> +	else
> +		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> +			git -C sparse-index "$@" \
> +			>sparse-index-out \
> +			2>sparse-index-error || return 1
> +	fi &&
> +	test_region index ensure_full_index trace2.txt
> +}

This implementation duplicates a lot of the code from 'ensure_not_expanded'.
Can 'ensure_expanded' and 'ensure_not_expanded' be refactored to call a
common helper function (which contains the common code) instead?

> +
>  test_expect_success 'sparse-index is not expanded' '
>  	init_repos &&
>  
> @@ -2101,4 +2125,32 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
>  	test_all_match git diff-files "folder*/a" 
>  '
>  
> +test_expect_success 'diff-files pathspec expands index when necessary' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +	
> +	# pathspec that should expand index
> +	ensure_expanded diff-files "*/a" &&
> +	ensure_expanded diff-files "**a" 

Similar to the comments in my 'diff-index' review [2]:

- The '**' in the pathspec doesn't do anything special unless using an
  explicit ':(glob)' pathspec. To make it clear that you're not trying to
  use a glob pathspec, you can use '*a' instead.
- Why are these pathspecs in quotes, but those in 'sparse index is not
  expanded: diff-files' are?

[2] https://lore.kernel.org/git/62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com/

> +'
> +
> +test_expect_success 'sparse index is not expanded: diff-files' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	ensure_not_expanded diff-files &&
> +	ensure_not_expanded diff-files deep/a &&
> +	ensure_not_expanded diff-files deep/*
> +'
> +
>  test_done

