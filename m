Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D80C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiHJMrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJMrf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 08:47:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34FC760E1
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 05:47:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v23so484427qkv.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 05:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1imRXOnzn0nMictMncuXczTI9HzyhJbL4KAu5gnnGN8=;
        b=A1CJp2gy0mJAPyqduCRn6WrXPIT+gaj3rbuj8NzCFY/S6xwr1e3j/EDvkPbiXA6/T8
         hs1PpCL2sLBw46L00AZMpXDZicp9stGS7nFjaAH2SNVUkG+Wd73qa8Bzci2Q1M7gpcIS
         elc7D+kwtPm1tg9v+rI0Fh1/DyyHp2WditvkqtNrYwmTUORyYzTuINNFR4sfZpGdbjbm
         jm5XtsV9/MncoW6r3C4Y4TOQgb/ahdPzv6GTMqtGAXbhKoYw/Wu+iqZQbeKUW7zFgYIm
         9wKC/FC8olvhKRn1edNByq5DLNlhBjFqsaV7p/ONHrNfG5pmvNWTaLoy6WQfD4W4tRPk
         jMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1imRXOnzn0nMictMncuXczTI9HzyhJbL4KAu5gnnGN8=;
        b=ixaaFwLLNj9qgzt0lT/inr0qiS7OOwuKadfXeQMMIQ3ha9QtykHmEVSjv+/6YFR6Tp
         Wc9oQDNYYLuG4qRNaOoXOvZ6PbK7yvXS83tH+G7Bx5ydsHOtFcv39ZOk3l47A+Ey+39Z
         qhMaUSHv/FoR0uWmKi6WbMN1H0/+K3MF/1OJl0jpHFCJ6yv3MvICj/Dmti7V8GR/xWoB
         GCjzf+paFMZeUcg09RTfdoFOe0eW5pv311eYkx8HBC9m20/EpsLHK/An4Fzov01UGw6L
         ZavnnT8dlI2NXStu5YEt0N4Ij83WR4vkwhK7rZd2h7wYC0IW1PxgyX6oNglBuW8eZE7c
         uV8Q==
X-Gm-Message-State: ACgBeo124RWb6qiqcetU49B/wyoPvwv1aYrU5IZag7U3KGquK7VktuAA
        4aV+th5Xurhgb+ulDfLhgwwu
X-Google-Smtp-Source: AA6agR7zM+WWROIaglIz839h9eYJssvuq9KA1rUrFuihZEvYHi/UQWlbsTPw7a6e92BnQAkhfOrxAQ==
X-Received: by 2002:a05:620a:150d:b0:6b9:9104:2ec6 with SMTP id i13-20020a05620a150d00b006b991042ec6mr3992953qkk.452.1660135654047;
        Wed, 10 Aug 2022 05:47:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:91c5:d5d6:a070:72da? ([2600:1700:e72:80a0:91c5:d5d6:a070:72da])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a24d000b006b8cff25187sm14478487qkn.42.2022.08.10.05.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:47:33 -0700 (PDT)
Message-ID: <afc04510-3c68-0226-b366-f541ca933a14@github.com>
Date:   Wed, 10 Aug 2022 08:47:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] t1092: add tests for `git-rm`
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-2-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220807041335.1790658-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/22 12:13 AM, Shaoxuan Yuan wrote:

> +test_expect_failure 'rm pathspec outside sparse definition' '

My only concern with this version is a minor one, and I didn't
notice it until this version: this test_expect_failure.

test_expect_failure doesn't help too much except to say "something
fails in this test". It could be the very first command, or it
could be the last.

> +	init_repos &&
> +
> +	for file in folder1/a folder1/0/1
> +	do
> +		test_sparse_match test_must_fail git rm $file &&
> +		test_sparse_match test_must_fail git rm --cached $file &&
> +		test_sparse_match git rm --sparse $file &&
> +		test_sparse_match git status --porcelain=v2
> +	done &&
> +
> +	cat >folder1-full <<-EOF &&
> +	rm ${SQ}folder1/0/0/0${SQ}
> +	rm ${SQ}folder1/0/1${SQ}
> +	rm ${SQ}folder1/a${SQ}
> +	EOF
> +
> +	cat >folder1-sparse <<-EOF &&
> +	rm ${SQ}folder1/${SQ}
> +	EOF

The difference you are demonstrating is that this output is
different. I think that at the point of this patch, they are
the same. The goal of this patch is to establish a common
point of reference for the full index and sparse index cases.

If everything below was "test_sparse_match" in this patch,
then I believe the test would pass.

The behavior changes when we enable the sparse index in the
'rm' builtin. Demonstrating the changes to the test at that
time helps collect all of the different ways behavior changes
with a sparse index, making it really easy to audit what
exactly is different between the modes.

Another approach would be to integrate the sparse index with
the builtin early, but keep the ensure_full_index() calls in
certain places (so we still expand to a full index) and slowly
add modes that do not expand. This is even trickier to do than
to delay the test changes to the end.

That said, finding out how to organize these tests is very
difficult because there is a bit of a chicken-or-egg problem:
How can we test the custom integration logic without enabling
the sparse index across the entire builtin? How can we enable
the sparse index across the builtin without having all of the
integration logic implemented?

So please take my ramblings here as food for thought, but not
any need to make changes to this series. v2 looks good to me.

Thanks,
-Stolee
