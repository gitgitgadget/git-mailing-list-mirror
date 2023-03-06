Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88DC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCFORJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCFOQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:16:46 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB59311F3
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:15:50 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g9so4971411qvt.8
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678112077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0Ii8+Hm4k/ZfEOk7LsCKzV7sCK+BCNEOdaijleAOo=;
        b=PQ38c3HBvDUKWmaghqVX4AoM1Ly06tN22bfOABjb4PucNVdM4UsNYkJjRChwxT+Roi
         g4XI8O6LfHeJ+BSZb84SCIIm8RKAFJ9fF01O7sH94FRJe6Ak/GbEmGBjGD3nv0dqFMhi
         1Wo9yqBjTAMcV7xYBK0Es/esUPYPBemdIyir3NGnh8B8cGD8AN+qaUuGIaf4p1FA1ykW
         AIrl/4kSEWRGmaJMAi/RrU1hQRIDf3XCpb6vxhOPWUaOoXmmBrF84oQGAs0BAy705Iwy
         rawmZaMWa47NBKoFjrjxWqOozTe5w4o45n/9Yzi1DBTd3OL71IsBNWgHxQgCoCOeH8gC
         Sz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0Ii8+Hm4k/ZfEOk7LsCKzV7sCK+BCNEOdaijleAOo=;
        b=lEGR+Uusumd5abz86V5qFB+ZxDVgmlW2HnhelN0kNgMd+9x2tA02odAzIjWq705KCh
         M5W2bR56TAy4hSO6rKYldmIhHi8Au34ULa/sHNCnd8nZzm6j/TZT1Ug78GqdoIxm41rO
         B++p01xKr6Y4IJprYn4pgLejJbGG+u9w/NQNrBea77C9bVX/TsUiP+f9zq2pvf00po58
         86JiN9rf2IcS2R8AC1cCEJO6WxY+Dh/qOqKh3v3MQFTqzVzns07t4oZhu8X4XVqjDAvG
         32FV5JKzAXwXNzxfcqNxs04xAeue8SjYSya2sSgmMRauYQs3Rg7pwXq7aB+Qn80g4ng5
         9TDQ==
X-Gm-Message-State: AO0yUKXMe874AW1ZdER0B5EUHtwsmspYwXjZwD/RLxDohJdzhUqptiz5
        NJdlYBYhi4cCFFKFeiIhR4jTS0TSDEbuoonXIA==
X-Google-Smtp-Source: AK7set85JK4bGLLxiWZYHtea1Jmieul1jp1Z7DChErlf4UbXH7TurbbvfU5IONQ0XWBHfmpc4/qRVg==
X-Received: by 2002:a05:6214:2627:b0:53a:151:b650 with SMTP id gv7-20020a056214262700b0053a0151b650mr18427446qvb.35.1678112076852;
        Mon, 06 Mar 2023 06:14:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:142d:d17c:5d14:a6e9? ([2600:1700:e72:80a0:142d:d17c:5d14:a6e9])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a211300b007423c122457sm7480882qkl.63.2023.03.06.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:14:36 -0800 (PST)
Message-ID: <99252618-28a9-6aa7-880a-f8ab0714bbb9@github.com>
Date:   Mon, 6 Mar 2023 09:14:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC][PATCH] t1092: add tests for `git diff-files`
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20230304025740.107830-1-cheskaqiqi@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230304025740.107830-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2023 9:57 PM, Shuqi Liang wrote:
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2054,5 +2054,37 @@ test_expect_success 'grep sparse directory within submodules' '
>  	git grep --cached --recurse-submodules a -- "*/folder1/*" >actual &&
>  	test_cmp actual expect
>  '
> +test_expect_success 'diff-files with pathspec inside sparse definition' '

nit: you need an empty line between the previous test's closing quote
and the start of your new test.

> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>$1
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	test_all_match git diff-files  &&
> +	test_all_match git diff-files deep/a &&
> +	test_all_match git diff-files --find-object=HEAD:a
> +'
> +
> +test_expect_success 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>$1
> +	EOF
> +
> +	run_on_sparse mkdir newdirectory &&
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git sparse-checkout set newdirectory &&
> +	test_sparse_match git add newdirectory/testfile &&
> +	run_on_sparse ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git sparse-checkout set &&

These uses of 'git sparse-checkout set' are probably not necessary
if you use "git add --sparse newdirectory/testfile". It does present
an interesting modification of your test case: what if the file
exists on-disk but outside of the sparse-checkout definition? What
happens in each case? What if the file is different from the staged
version?

> +
> +	test_sparse_match git diff-files &&
> +	test_sparse_match git diff-files newdirectory/testfile &&
> +	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile
> +'

These tests look like a good start here. I was first confused as
to why you were doing such steps to modify the sparse-checkout
definition, but I see it is critical that you have staged changes
outside of the sparse-checkout cone. These kinds of details, the
"why" you are doing subtle things, are great to add to the commit
message.

> To make sure git diff-files behaves as expected when
> inside or outside of sparse-checkout definition.
> 
> Add test for git diff-files:
> Path is within sparse-checkout cone
> Path is outside sparse-checkout cone

With that in mind, here is a way you could edit your commit
message to be more informative:

  Before integrating the 'git diff-files' builtin with the sparse
  index feature, add tests to t1092-sparse-checkout-compatibility.sh
  to ensure it currently works with sparse-checkout and will still
  work with sparse index after that integration.

  When adding tests against a sparse-checkout definition, we must
  test two modes: all changes are within the sparse-checkout cone
  and some changes are outside the sparse-checkout cone. In order to
  have staged changes outside of the sparse-checkout cone, create a
  'newdirectory/testfile' and add it to the index, while leaving it
  outside of the sparse-checkout definition.

(If you decide to add tests for the case of 'newdirectory/testfile'
being present on-disk with or without modifications, then you can
expand your commit message to include details about those tests,
too.)

Thanks,
-Stolee

