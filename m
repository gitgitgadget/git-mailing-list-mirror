Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C646C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCJSYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCJSYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 13:24:14 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD412CC2
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:23:59 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x11so6509768pln.12
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678472639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qF50Ep0WI3Hznk//jyLb8iF8DBa+i/HiPeLzMXymHSU=;
        b=YTVqCIUSMPja5PxUw9Vo/Ged9LrDbw4hUYh/hLHtN1AVYPbYAKi7zsu3zwZAuCr1aM
         6n1ECmT/PAMUPMgksd6Akq9rAlhoTbZCxruZGC0zfscSLsmIF1I1YuodgzliwvlGYYuj
         VXRsehtoZwL+CWLDQeQUKuqdsWgPAgfnqqvg5GD7xF+SvSzyO9zYZttYdZDD1AB3buk2
         BIro0Qq9+LUTIduH4gdRKKCrEFM9nLoWdgewRNMiSe9Sf+Tq7S4+euVc17bSyomNa0fx
         XF7fbfW7FjdX9fppxxrLNmzc82KcATQ5ewba+kafbt8UhlwM4erv9pXpFPAvOBNtPAWM
         64vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678472639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF50Ep0WI3Hznk//jyLb8iF8DBa+i/HiPeLzMXymHSU=;
        b=UpyHv2MVOqKEUz5lqWhTvAwhyhAvFD4B3mii4+rEkYn1k7L7u/Q8al6lzlYrJHghDB
         ixMboRKjIqsfX6QdrLTa2f8svH7GMBtmZtopnr3ZdhO5xE3mm15K5sRTLDm4kzJTyg0c
         spps7ku6irV2u3qz/ro2yuICQE5wR+BMiI2h/wuVbBrPPZ4iK0LKjSijE4RVc/6+TSf6
         lNgUiItn5jcBQIy1dNQ3QFAhXjKP2RUNWJ2mHfd0OXUPTyltPA+R2rJpEiJdl7QkpraV
         gmWCCbOlhA1r6vqI0sjsBby2hJ+MkAibckY2xkSI992vyDe3S0sjcPXWJ5QFIYBsnNTq
         W7aQ==
X-Gm-Message-State: AO0yUKUlERn3wLKx3PFAVT6dU4t7eOaIjjkHFRltjKcLJFETWl6Q/a+V
        Wk5qSB9VdDKL5SrRzKosHQhO
X-Google-Smtp-Source: AK7set8Qa0PfBJCr3WTIlZGV7v2KgjYOvTKj7GkwdEsRQjcbV7S5ollagyHvPBRg0LE7aoi1ZDnyrw==
X-Received: by 2002:a05:6a20:9147:b0:cc:da74:9c5e with SMTP id x7-20020a056a20914700b000ccda749c5emr30444813pzc.35.1678472638832;
        Fri, 10 Mar 2023 10:23:58 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a25-20020a62e219000000b0058d91fb2239sm132167pfi.63.2023.03.10.10.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 10:23:58 -0800 (PST)
Message-ID: <c5a32703-29a7-4e9f-f669-6a017ffdce60@github.com>
Date:   Fri, 10 Mar 2023 10:23:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 2/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230309063952.42362-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-3-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230310050021.123769-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Remove full index requirement for `git diff-files`
> and test to ensure the index is not expanded in `git diff-files`.
> 
> The `p2000` tests demonstrate a ~96% execution time reduction for 'git
> diff-files' and a ~97% execution time reduction for 'git diff-files'
> for a file using a sparse index:
> 
> Test                                           before  after
> -----------------------------------------------------------------
> 2000.78: git diff-files (full-v3)              0.09    0.08 -11.1%
> 2000.79: git diff-files (full-v4)              0.09    0.09 +0.0%
> 2000.80: git diff-files (sparse-v3)            0.52    0.02 -96.2%
> 2000.81: git diff-files (sparse-v4)            0.51    0.02 -96.1%
> 2000.82: git diff-files f2/f4/a (full-v3)      0.06    0.07 +16.7%
> 2000.83: git diff-files f2/f4/a (full-v4)      0.08    0.08 +0.0%
> 2000.84: git diff-files f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
> 2000.85: git diff-files f2/f4/a (sparse-v4)    0.51    0.02 -96.1%

These are great performance results!

> 
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  builtin/diff-files.c                     |  4 ++++
>  t/perf/p2000-sparse-operations.sh        |  2 ++
>  t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index dc991f753b..360464e6ef 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -27,6 +27,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  		usage(diff_files_usage);
>  
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
> +
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;

Looks good.

> +
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	rev.abbrev = 0;
>  
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a..82751f2ca3 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git diff-files
> +test_perf_on_all git diff-files $SPARSE_CONE/a
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 9b71d7f5f9..4f582164a3 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2103,4 +2103,17 @@ test_expect_success 'diff-files with pathspec outside sparse definition' '
>  	test_cmp expect sparse-checkout-out
>  '
>  
> +test_expect_success 'sparse index is not expanded: diff-files' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	ensure_not_expanded diff-files  &&
> +	ensure_not_expanded diff-files deep/a 

IIRC, in many cases, the internal diff machinery won't expand a sparse index
even if the pathspec matches files outside the sparse-checkout definition.
Does 'ensure_not_expanded diff-files folder1/a' work? What about
'ensure_not_expanded diff-files "*a"'?

> +'
> +
>  test_done

