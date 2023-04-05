Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7DC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjDERyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjDERxx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:53:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49CE769F
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:53:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y2so24206936pfw.9
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680717202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zred3OEI3NGNsBD3AqiE0ZpMiTUQToK3otBRQRP/Yzo=;
        b=TC8r6c8fTcmtc5CjQxEnSndZLhg1MnYOli0MYgGfgYmniV6DnwW9zQ7DiUVZs0E88K
         P/q1+AdV/KA/QtY4SZHIQn/Wa6UxNnJ4K9VkBBXzTM7WgfZ1S/+JDN7XnZ+c6yWs6a5O
         f+haL7dmX3Xl65likCnGm71nk1Yg8PCCvtnDgdBJB0Vzqq1Z/AFyLYmulzOoQuluvHdN
         t3GOWlOo7fHn+y+vqUGeD5kJgksrO1mM+IxvQl1mdVer4eLfXqB6tZV91hf+oVcK8CZH
         6I72LYB9PCFdeiJXTAVv+jAFUOwO1yAmfTHFFuJqrLQomj9naMefyDQpM0DGvoH7IFcJ
         7beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zred3OEI3NGNsBD3AqiE0ZpMiTUQToK3otBRQRP/Yzo=;
        b=zyU4+AvaUc2o8XOEyPcPFiDs29iUYh0OvvX8Z+oFGoCStlilbOs9hLcw+vde+Yd+Eb
         Cy/aVqGEiM6V/ooi2Cx8xATpy69vbl3xcdAXtj06088G2F+SCBe1k9oJIKn3W8oLnhRm
         pLlaFyjQm59CnogA2fQwkQLlmcqswxGOFuuZsybRYnAUsBkaO0kM9HxQ9kK7IvNBu5Zi
         2rQK+IX3j+xVlb1UrAeDLuWYXBkLJ4ohDgE/C5BZqLTFDNEwcoxulE9aC8+aRtPQz7Md
         hMrKXKsScQ+7EnDFqxXE0Ogscr0utN/ydmgTOzk8HWnZPMw8Z98HyPUeQJoKoPvnOKY1
         GgUw==
X-Gm-Message-State: AAQBX9c1A2yf08Wv52mSnU0jNJG+cxu01AznevuqsvYnvMrbSHfoQqlb
        YP7zSiVyUGFRkrp3ig4AiIjIdJaABzb5iaQvrA==
X-Google-Smtp-Source: AKy350ZkGKxSGVBvVB4usbq99GYQUoj0nusmQg0aVoSQg+aFPwIlmlGIpnPWs/N2o2xNb2UXI27FLw==
X-Received: by 2002:aa7:8f29:0:b0:627:e49a:8714 with SMTP id y9-20020aa78f29000000b00627e49a8714mr6717807pfr.9.1680717202402;
        Wed, 05 Apr 2023 10:53:22 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7909a000000b005e5861932c9sm10883984pfa.129.2023.04.05.10.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:53:22 -0700 (PDT)
Message-ID: <91d3fd23-8120-db65-481a-e9f56017bb04@github.com>
Date:   Wed, 5 Apr 2023 10:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [GSOC][PATCH v1] diff-index: enable diff-index
Content-Language: en-US
To:     Raghul Nanth A <nanth.raghul@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20230403190538.361840-1-nanth.raghul@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230403190538.361840-1-nanth.raghul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A wrote:
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a..9e74cb22b9 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git diff-index HEAD
> +test_perf_on_all git diff-index HEAD~1

What is the benefit of testing 'diff-index' with 'HEAD' *and* 'HEAD~1'? I
wouldn't expect internal behavior in the command to change based on the
revision, so the performance should be nearly identical. I'd much rather see
'diff-index --cached' and/or other options & pathspecs exercised.

>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..13801f327d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1996,6 +1996,24 @@ test_expect_success 'sparse index is not expanded: rm' '
>  	ensure_not_expanded rm -r deep
>  '
>  
> +test_expect_success 'sparse index is not expanded: diff-index' '
> +	init_repos &&
> +
> +	echo "new" >>sparse-index/g &&
> +	git -C sparse-index add g &&
> +	git -C sparse-index commit -m "dummy" &&
> +	ensure_not_expanded diff-index HEAD~1

As with the other tests, please exercise different options and pathspecs
with 'diff-index' to improve coverage.

> +'
> +
> +test_expect_success 'match all: diff-index' '
> +	init_repos &&
> +
> +	test_all_match git diff-index HEAD &&
> +	run_on_all rm g &&
> +	test_all_match git diff-index HEAD &&
> +	test_all_match git diff-index HEAD --cached
> +'

In addition to the '--cached' option, please test different pathspecs
(especially different wildcard variations; see the 'git grep' [1] and 'git
diff-files' [2] integrations for examples you could build off of).

Seeing that 'diff-files' needed 'pathspec_needs_expanded_index', it's
possible that this command needs similar treatment. I'm curious as to
whether 'diff' needs it as well - the tests in 't1092' don't cover 'diff'
with pathspecs, so it might be behaving incorrectly. If that's the case, it
would be nice to see pathspecs handled all in one place
('run_diff_index()'?), if possible.

[1] https://lore.kernel.org/git/20220923041842.27817-1-shaoxuan.yuan02@gmail.com/
[2] https://lore.kernel.org/git/20230322161820.3609-1-cheskaqiqi@gmail.com/

> +
>  test_expect_success 'grep with and --cached' '
>  	init_repos &&
>  

