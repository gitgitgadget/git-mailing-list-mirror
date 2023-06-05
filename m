Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB5DC77B73
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjFETcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjFETct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 15:32:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BB100
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 12:32:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so1907897b3a.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685993568; x=1688585568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=but4oCeKL7WXIqVAEaY0FsvjF3sFbywqZCKMYiVlDus=;
        b=DdrbCquG3itzvt9To4+lK6p8i2ouNUjcTF+58KoS7kdFIzKv7/k1ubg/Xy6O3EVw1H
         ZxKmObCgZAsXL1OlUxQg5yjurJUlr4ahTLEmovkuSxrYd00EqsikzpoLSCs76Hqkh18g
         YAgGeq2TQGVqc0S5ixObzVyxFq7kyy9XigoUlpQf8hTSANd8mDy5otILDz1pHqKKRlrO
         cc+G7uCGtdaLfA5lu7YmkdKDZbtzWnnLsrVq0T1no3LmtMO8x8xOuEehRZCwBjMoMXkV
         ZzUXTyHqmmoVVG3L8lasimGdWxXnMZIHArKO/BOpsEXLLIOvtqPzWGdGTYvCWggdSgD2
         X44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993568; x=1688585568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=but4oCeKL7WXIqVAEaY0FsvjF3sFbywqZCKMYiVlDus=;
        b=h3/xbX8MI5pVeXGgsd8k4dPWCBhd1aLdWxoNlrF3C8iy5UFRbfwh9V+fMOAbiAvAUr
         q5muJzbWtEESq0icc9zroncgKgazLvuJscpMCmlyi+UtQEFuIi5136xu9JQFZ3IfNblz
         ZnaOsnRtL5+9qZtahUu67oQaGfOvIM87AAvMZqOdd+OO5Kt+5lk4aKu2yvD+5XwiGM7l
         nCF6diM6NWB8rERjvOr1TWUHYxtCzJFmLZBTqRA5M8OeTE9XtPsVwI71Ymf2EqRR5Lqb
         ilZFDgeSTrwavVVBvTTKgur3NMRHb9wR6J/0nc1u//9nQ7yL6/fNhD4IdqqoJMr18VzD
         Xgqg==
X-Gm-Message-State: AC+VfDxyPUyBGXC50NcQ4ZJVUUrFigoz7JIQJJ/JAWL/ICFvgBqVh0dF
        6a2j3pwcuS3xji/I3giT84d7JJgPCJp4lIsuQA==
X-Google-Smtp-Source: ACHHUZ6HOx1LZrmNtc2KYvUANYuAO/brNwiJMRX1wDXvVFLgj30k+mVKStO5ZdJurR9mZHaWZK0kDQ==
X-Received: by 2002:a17:902:7247:b0:1a6:45e5:a26a with SMTP id c7-20020a170902724700b001a645e5a26amr4833478pll.27.1685993567826;
        Mon, 05 Jun 2023 12:32:47 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902900400b001aaef9d0102sm6932748plp.197.2023.06.05.12.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:32:47 -0700 (PDT)
Message-ID: <f8094f2d-fbf7-3379-a630-781eb09cce64@github.com>
Date:   Mon, 5 Jun 2023 12:32:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] repository: create read_replace_refs setting
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
 <4c7dbeb8c6dd6ab4c1903196967d5e0906a293c2.1685716158.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <4c7dbeb8c6dd6ab4c1903196967d5e0906a293c2.1685716158.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> diff --git a/repository.h b/repository.h
> index c42f7ab6bdc..5315e0852e3 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -39,6 +39,15 @@ struct repo_settings {
>  	int pack_read_reverse_index;
>  	int pack_use_bitmap_boundary_traversal;
>  
> +	/*
> +	 * Has this repository have core.useReplaceRefs=true (on by

s/Has/Does(?)

It's not a huge deal, but if you were planning to re-roll anyway due to [1],
this should be easy enough to include.

[1] https://lore.kernel.org/git/a1967c58-48c5-6ae0-f60a-2d8c107f8f66@web.de/

> +	 * default)? This provides a repository-scoped version of this
> +	 * config, though it could be disabled process-wide via some Git
> +	 * builtins or the --no-replace-objects option. See
> +	 * replace_refs_enabled() for more details.
> +	 */
> +	int read_replace_refs;
> +
>  	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
>  
>  	int index_version;
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 8143817b19e..d37c83b4640 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -594,4 +594,44 @@ test_expect_success 'grep partially-cloned submodule' '
>  	)
>  '
>  
> +test_expect_success 'check scope of core.useReplaceRefs' '
> +	git init base &&
> +	git init base/sub &&
> +
> +	echo A >base/a &&
> +	echo B >base/b &&
> +	echo C >base/sub/c &&
> +	echo D >base/sub/d &&
> +
> +	git -C base/sub add c d &&
> +	git -C base/sub commit -m "Add files" &&
> +
> +	git -C base submodule add ./sub &&
> +	git -C base add a b sub &&
> +	git -C base commit -m "Add files and submodule" &&
> +
> +	A=$(git -C base rev-parse HEAD:a) &&
> +	B=$(git -C base rev-parse HEAD:b) &&
> +	C=$(git -C base/sub rev-parse HEAD:c) &&
> +	D=$(git -C base/sub rev-parse HEAD:d) &&
> +
> +	git -C base replace $A $B &&
> +	git -C base/sub replace $C $D &&
> +
> +	test_must_fail git -C base grep --cached --recurse-submodules A &&
> +	test_must_fail git -C base grep --cached --recurse-submodules C &&

First, we verify that replace refs are enabled on both the superproject and
submodule by default (if they are, 'a' has been replaced with 'b' and 'c'
has been replaced with 'd')...

> +
> +	git -C base config core.useReplaceRefs false &&
> +	git -C base grep --recurse-submodules A &&
> +	test_must_fail git -C base grep --cached --recurse-submodules C &&

...then, if replace refs are disabled in the superproject (but not the
submodule), 'b' no longer replaces 'a' but 'd' still replaces 'c'...

> +
> +	git -C base/sub config core.useReplaceRefs false &&
> +	git -C base grep --cached --recurse-submodules A &&
> +	git -C base grep --cached --recurse-submodules C &&

...but once replace refs are disabled in the submodule, 'd' no longer
replaces 'c', and 'b' still doesn't replace 'a'...

> +
> +	git -C base config --unset core.useReplaceRefs &&
> +	test_must_fail git -C base grep --cached --recurse-submodules A &&
> +	git -C base grep --cached --recurse-submodules C

...and, finally, if we restore the default state in the superproject
(replace refs enabled) but not the submodule, 'b' once again replaces 'a',
but 'd' still doesn't replace 'c'.

Thanks for adding this test! It clearly and thoroughly exercises the updated
config behavior.

> +'
> +
>  test_done

