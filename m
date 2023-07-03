Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE6C001B0
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGCSVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjGCSVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:21:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A553EE67
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:21:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53482b44007so2349465a12.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1688408478; x=1691000478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvTN58wLh42T+V6pb5oZXQP6JtrFi0ro7wrhU/Fh/+M=;
        b=N7pOgzPBim2JG1pVwwNz82Jqh3s+hZkCUtJgumPdjMUZQcvK/rZjvzCIs2fXTIKdwo
         tr3qrAqntW26+lGVxUAgScqG+IzpNVN33SM7eW2LhebobG0Sye5ExOBTesTnmg0ju+I1
         wumDvGlDfMsrC99Cesd73ETqK4CDZCCie32csKFHQDx1hN5UGSbIXGaE/D4TciLc6l6J
         lylmeZe2BvpBgh5CSZI+ZY8bAxJspoEMUsLYCqzbYrWnH14o1RlkLMTmt2ypwNY53EQJ
         6wuh7rKGKRevml+5g8hTFl1zLzMxxv+RbBaTVyGmMXOwa97gOnNx4Pzmc9wLrkPstr9O
         d0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408478; x=1691000478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvTN58wLh42T+V6pb5oZXQP6JtrFi0ro7wrhU/Fh/+M=;
        b=J7fsaQrNgF1vX2HD0MAn9IqpPKAX1F9acgJvRqic8gRKH8imzrq76lnpcqj+2FtPay
         X11he9s3ciScchpsSwiNuTgki7Wcdy0OEJ4hBKxShOISadX2RX9WASZsxbXxwJOvIvJ6
         SyOWQTlK7grlER14XWeS67Ve7jHCpB8SidbQ4VLg8DpF1XkyQFl8FyurHVVoPIvCjPbs
         wP4XA2PQDNlR2WMVQsg1reMkUA1zR8nxQpbv4sq1tdVo+tsHNMr7sWuG5PKqFUOBQC9S
         /z+6JgSQbsY6UjG3K0LBjh8Q6alp3kH1t2bhqjRa5RfRRC3kExx5+EgCB5rPEiKL5x8z
         mJZA==
X-Gm-Message-State: ABy/qLZQa+ZciDMVLTfO8ZSDuLFqvr7DjEKDeW7H0Y/gqWLTNYQ9eVz0
        OFDkJhQAWiixhbYvq7v1tNVnRHP6QpN3G4VkJA==
X-Google-Smtp-Source: APBJJlH3rqvhwJ2x9RJZdj+xW25Cqb1JzGzEEwLBOg06cE4/HIhpOmQf2J049X08B0nCp4fdYNuyzw==
X-Received: by 2002:a17:90a:558f:b0:263:129e:80ac with SMTP id c15-20020a17090a558f00b00263129e80acmr9204258pji.38.1688408478597;
        Mon, 03 Jul 2023 11:21:18 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id q68-20020a17090a1b4a00b002635341a7e8sm8940674pjq.3.2023.07.03.11.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 11:21:18 -0700 (PDT)
Message-ID: <fb4bad5b-6e49-dbad-d9ae-94ec7db9f93c@github.com>
Date:   Mon, 3 Jul 2023 11:21:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/3] check-attr: integrate with sparse-index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
 <20230701064843.147496-4-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230701064843.147496-4-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Set the requires-full-index to false for "diff-tree".
> 
> Add test to ensure the index is not expanded when the
> sparse index is enabled.
> 
> The `p2000` tests demonstrate a ~63% execution time reduction for
> 'git check-attr' using a sparse index.
> 
> Test                                            before  after
> -----------------------------------------------------------------------
> 2000.106: git check-attr -a f2/f4/a (full-v3)    0.05   0.05 +0.0%
> 2000.107: git check-attr -a f2/f4/a (full-v4)    0.05   0.05 +0.0%
> 2000.108: git check-attr -a f2/f4/a (sparse-v3)  0.04   0.02 -50.0%
> 2000.109: git check-attr -a f2/f4/a (sparse-v4)  0.04   0.01 -75.0%

Great results as usual!

> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  builtin/check-attr.c                     |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++

Did you forget to add the perf test to this patch? 

>  2 files changed, 14 insertions(+)
> 
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index b22ff748c3..02267f9bc1 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -122,6 +122,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, check_attr_options,
>  			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;

Given that you updated 'read_attr_from_index()' to handle sparse directories
in [1], it makes sense that disabling 'command_requires_full_index' is all
that's needed to enable the sparse index here.

[1] https://lore.kernel.org/git/20230701064843.147496-2-cheskaqiqi@gmail.com/

> +	
>  	if (repo_read_index(the_repository) < 0) {
>  		die("invalid cache");
>  	}
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4edfa3c168..317ccc8ec5 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2288,4 +2288,15 @@ test_expect_success 'check-attr with pathspec outside sparse definition' '
>  	test_all_match git check-attr  -a --cached -- folder1/a
>  '
>  
> +test_expect_success 'sparse-index is not expanded: check-attr' '
> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_all cp ../.gitattributes ./deep &&

nit: we're only verifying behavior in 'sparse-index', so this should
probably be

	cp .gitattributes ./sparse-index/deep &&

> +
> +	ensure_not_expanded check-attr -a -- deep/a &&
> +	run_on_all git add deep/.gitattributes &&

Similar to above, this should probably be:

	git -C sparse-index add deep/.gitattributes &&

> +	ensure_not_expanded check-attr -a --cached -- deep/a
It'd be nice to show that the index is also not expanded files outside of
the sparse-checkout cone, e.g. 'folder1/.gitattributes' or
'folder1/0/.gitattributes' (similar to what you did for the correctness
tests in [2]).

[2] https://lore.kernel.org/git/20230701064843.147496-3-cheskaqiqi@gmail.com/

> +'
> +
>  test_done

