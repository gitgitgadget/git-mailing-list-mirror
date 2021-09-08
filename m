Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A747C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C64661153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhIHFOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHFOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:14:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 22:13:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so1306802pgr.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 22:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M4Sjpf/K660S5b2m4sgSWiuGviMmmNZec2KKsG+/1dA=;
        b=kfZ+8Md7ZX59tIkw9ctjQEid2bpsd8/rw0bKmXUIhne504aPh9XY3GV0Dff5a8IbkM
         CIgA5RL8qoBaCM+huRmy0YGtw056q9hDIy/tjq9naHLxC6jS/OJCuVWVd1Lt67cpjqfZ
         w8WxwIe+JDs4MB1Yted/XrEAoKN5K+ZzyzIwGVGru0BgoiKbgWViMUBuzg47yYInLgX5
         y8GSxIRLZ0lAE4NofUlPRLEaR1RxSq+3m3kF0+dAJRfibxll1VqJQB5XqC77yvsIf5LW
         2RsoGq40QHgCH7QGvGbBNn85Ps5dPdB/KSa1E01j40bNog2sDDRzRUvqPbez36VtsYEF
         Myag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M4Sjpf/K660S5b2m4sgSWiuGviMmmNZec2KKsG+/1dA=;
        b=rpg2+6qk+uMxmklIiBkdRJhzWIAD/wr15BJngeStvhNm5XH7ywBfYr1GUz40A6az7o
         mY4eCxuqHHKNw8HvVOqaRhm26XA0YsgRKwvL7jVwVxwYErXqt47skLlsGxpu1KOHbwvz
         F480/3UcKe1Cj9FO+KM4m7dEK36o8t4TAL2Eer0H1Xsm72D3xOeCtaPMUSrpADjjLFYN
         qWQAlB+uVUUKdzWOI0ZSGkZl745FRKzPkx53fgTgolom9MwITQRXAuPjfhueG/XGITyN
         U+Eio1QrCP1r39B4DNFqoaQzXfDfH8B1XZ0myR0O/lzXN5HPX4sqHeGmLcIeY1Bvpj32
         59SA==
X-Gm-Message-State: AOAM5302fCiISYnbQhSsBJqhMarOYhK8sFL5Jq18DOGNTJW0QGPUY8mw
        R/e97TgdYYYk7T2Q8IcZ87T9+uDLQm8DvuX8
X-Google-Smtp-Source: ABdhPJx/hwsVfYiI9XlHtA6uEhhh3pbmy7jG5GrXWJLPMN74lq0XzTaZciDQDoql5WWlLCbHWLrBaw==
X-Received: by 2002:a05:6a00:c8a:b0:3fb:dbcc:e1d7 with SMTP id a10-20020a056a000c8a00b003fbdbcce1d7mr1844451pfv.51.1631077995022;
        Tue, 07 Sep 2021 22:13:15 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id i1sm721122pjs.31.2021.09.07.22.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:13:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] t4151: document a pair of am --abort bugs
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
 <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <96e001e5-56d7-7806-19ad-ac41f833b0a7@gmail.com>
Date:   Wed, 8 Sep 2021 12:13:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/21 09.17, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   t/t4151-am-abort.sh | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 9d8d3c72e7e..501a7a9d211 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -23,7 +23,11 @@ test_expect_success setup '
>   		test_tick &&
>   		git commit -a -m $i || return 1
>   	done &&
> +	git branch changes &&
>   	git format-patch --no-numbered initial &&
> +	git checkout -b conflicting initial &&
> +	echo different >>file-1 &&
> +	git commit -a -m different &&
>   	git checkout -b side initial &&
>   	echo local change >file-2-expect
>   '
> @@ -191,4 +195,31 @@ test_expect_success 'am --abort leaves index stat info alone' '
>   	git diff-files --exit-code --quiet
>   '
>   
> +test_expect_failure 'git am --abort return failed exit status when it fails' '
> +	test_when_finished "rm -rf file-2/ && git reset --hard" &&
> +	git checkout changes &&
> +	git format-patch -1 --stdout conflicting >changes.mbox &&
> +	test_must_fail git am --3way changes.mbox &&
> +
> +	git rm file-2 &&
> +	mkdir file-2 &&
> +	echo precious >file-2/somefile &&
> +	test_must_fail git am --abort &&
> +	test_path_is_dir file-2/
> +'
> +
> +test_expect_failure 'git am --abort returns us to a clean state' '
> +	git checkout changes &&
> +	git format-patch -1 --stdout conflicting >changes.mbox &&
> +	test_must_fail git am --3way changes.mbox &&
> +
> +	# Make a change related to the rest of the am work
> +	echo related change >>file-2 &&
> +
> +	# Abort, and expect the related change to go away too
> +	git am --abort &&
> +	git status --porcelain -uno >actual &&
> +	test_must_be_empty actual
> +'
> +
>   test_done
> 

I expect BUGS section in git-am(1) to be added to describe known bugs 
you demonstrated above, judging from the patch subject.

-- 
An old man doll... just what I always wanted! - Clara
