Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E37C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5761425
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhDWT5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWT5b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:57:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A66C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:56:54 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 8so17068188qkv.8
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4nLOSUv1OkJE/UFKukKJ2EJ9yeazl7JYgFtVz+x2t9E=;
        b=HcK8MjKDV6P+gpqaYC3IzpxGx0chpumw31s94gxFNM6XB4Yz+/hXHM/bAGlF/bgNHH
         pKG6zBM94EKCP2CBEjfLBJT27860Fgl0ugSQ/QW2QojfSZh1Z1hVHKbO1KwUoZh6lCkg
         6gwf0MTH/uxPPi+R7HjijrihuaiwVm0kszHrfQaGmS3DbcSRNc1q0VordQdGvlbcdI0F
         PyO2H2gvSZdT9tl8X6XvHYlNR+FSKy+QSmrSKBBFEgZoHeOWUJQ4/ZMyjr/hNLwcdaA9
         udVY8N339TkMG0QGcKEkG6BTCWxJHRw3GAGDW7+z/M4F0zu4DDc8764kPOd8OYcnuahi
         jUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4nLOSUv1OkJE/UFKukKJ2EJ9yeazl7JYgFtVz+x2t9E=;
        b=JCRr2QuFPEaTBpH2ulEGRu5CUe3dek2uSe/bXqjD9NMNLJnEY7Rn0dElXy3eDZYj0H
         TZpMPSSdNXs2cmP/syzspjBTN9cYVgaAQVaZtvJE4/LVBO5VFkPhgYMa0mZ8rnDVMVoW
         57yHfpyt0nK1fd2XQuuOHQBakxbLp/3auXiRAnsrKv6RtUvW0qXh6+AWFTyA6HkNKEsG
         R9dZeZjB+p3Rs8YRmn0ROZV6VevM0UnXX5E7vINf22Rfx4810DMasaOjCiNcnCv10Z0J
         nLP21r6OsCHt59SFePPByGCEuMkDkCMSuSFmVqarMPn/bHowo3s4ZubUWEeXkPsykBMd
         sU6A==
X-Gm-Message-State: AOAM533ekQD9wkUuCZWhH49+41s9CjO2cfxxWmLdvNGuRRd0K9hyh8/N
        /Rmex8CkP+tl62h3XxRfXl9sZQ6m7UtCXQ==
X-Google-Smtp-Source: ABdhPJzkhraEZeW1zueB+8TV2ZCv9XSk9rW2oeW2nibpdc3uIt1TgQQ85aM+GlyUVqjetEjEn7LGEw==
X-Received: by 2002:a37:9ec4:: with SMTP id h187mr5816351qke.249.1619207813817;
        Fri, 23 Apr 2021 12:56:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id f8sm4748807qkh.83.2021.04.23.12.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 12:56:53 -0700 (PDT)
Subject: Re: [PATCH 7/7] ci: run test round with parallel-checkout enabled
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <f7c20e0b5bd7857b2303aab762f24c503e50030d.1619104091.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56757f2b-f203-3014-dbad-e86c49d0d64b@gmail.com>
Date:   Fri, 23 Apr 2021 15:56:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f7c20e0b5bd7857b2303aab762f24c503e50030d.1619104091.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> We already have tests for the basic parallel-checkout operations. But
> this code can also run be executed by other commands, such as
> git-read-tree and git-sparse-checkout, which are currently not tested
> with multiple workers. To promote a wider test coverage without
> duplicating tests:
> 
> 1. Add the GIT_TEST_CHECKOUT_WORKERS environment variable, to optionally
>    force parallel-checkout execution during the whole test suite.
> 
> 2. Set this variable (with a value of 2) in the second test round of our
>    linux-gcc CI job. This round runs `make test` again with some
>    optional GIT_TEST_* variables enabled, so there is no additional
>    overhead in exercising the parallel-checkout code here.
> 
> Note that tests checking out less than two parallel-eligible entries
> will fall back to the sequential mode. Nevertheless, it's still a good
> exercise for the parallel-checkout framework as the fallback codepath
> also writes the queued entries using the parallel-checkout functions
> (only without spawning any worker).

I agree that this is helpful additional testing.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  ci/run-build-and-tests.sh  |  1 +
>  parallel-checkout.c        | 14 ++++++++++++++
>  t/README                   |  4 ++++
>  t/lib-parallel-checkout.sh |  3 +++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index a66b5e8c75..23b28e7391 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -25,6 +25,7 @@ linux-gcc)
>  	export GIT_TEST_ADD_I_USE_BUILTIN=1
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>  	export GIT_TEST_WRITE_REV_INDEX=1
> +	export GIT_TEST_CHECKOUT_WORKERS=2
>  	make test
>  	;;

(Making a note to audit the entries here, as I believe some
of these could be enabled by default or no longer do anything.)

>  void get_parallel_checkout_configs(int *num_workers, int *threshold)
>  {
> +	char *env_workers = getenv("GIT_TEST_CHECKOUT_WORKERS");
> +
> +	if (env_workers && *env_workers) {
> +		if (strtol_i(env_workers, 10, num_workers)) {

I had to look up how strtol_i() differs from strtol(). It seems
like we should use strtol_i() more often than we do.

> +			die("invalid value for GIT_TEST_CHECKOUT_WORKERS: '%s'",
> +			    env_workers);
> +		}
> +		if (*num_workers < 1)
> +			*num_workers = online_cpus();
> +
> +		*threshold = 0;
> +		return;
> +	}

LGTM.

Thanks,
-Stolee


