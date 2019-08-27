Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A390A1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 01:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfH0BXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 21:23:14 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46126 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfH0BXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 21:23:13 -0400
Received: by mail-yb1-f193.google.com with SMTP id y194so4306952ybe.13
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 18:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r8Tt4ggUCHidd8TRkyZLxzpUkFLrENUXTmYGjTqojkU=;
        b=PBpQQ8RVqEDzfSQzYtaVqlJHW/zNzU8aFhn4EqYZFeOBGUT2VVGQnvT+7bBZqV/Ih+
         rMTlYv13qOJs8x4n3rLphXx9zhwWvGiBhd1NerN81yyTKOBrKKmYXOxtIQwWEmwij55X
         kfWfmlcl4C3LNlEk4d/PF17bqW5TrvqO6ZBSxVyJbLXoqLMBvAHct+xjLC6w9N7aRI22
         IrQFTYewQ7iJf4thNdC0VEYUUTFcaCcfSMDUgpPC03kcZKlNY4RPljP8We3COr7QtqQX
         NveajLuS+FJfjeG8QVo0kWzQfATcqXw6+klUoO1QZ+uU2/dedFa1mKYWyJwF1Fqa0jS2
         L/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8Tt4ggUCHidd8TRkyZLxzpUkFLrENUXTmYGjTqojkU=;
        b=BOVVb+N0us2ucXoxGFzcRTDe4TliM9pr1p0UnlP1bnF8thbgy+jjnD6ABATzj2c2sK
         L/YLgab40u3HlGXdGZDVrHdoPstYGY54375AUVSye0mQfE6aVRbAnZKGDpldIQuMEzX+
         faKG3tDKr2RCqMYj6FQtMzf8sYosVBcoqnHsGJF107xLwDTg0WumAf8TrqGPw5ZwjbMu
         CgecrUs5vZgD7pDjHoO0HUJZnecyI63vTdUDNBDEEVwtLkKqDXJg6/I+E85Lb/Qgcxmc
         PDMjK/tkUEBabDOMdb1HerCYjDocZw/Vr6z8ZCb088FtSZAKwrRj2FIRLyNNTBuvCtX3
         nogQ==
X-Gm-Message-State: APjAAAW17j1X6nu2Yq1+NIOjtoHL1QBR6/oMdBEE0hpCnABlB3QjMAPu
        vP4Ht27Y+YInIj+e5YTycQY=
X-Google-Smtp-Source: APXvYqwPjRJA0Cufsg7vLHdcJPpMY8ibsDNJPNY9NYJiLdcG0QoRhFuYPBNkzkxxStrKhKRNrLts/g==
X-Received: by 2002:a25:d711:: with SMTP id o17mr15546227ybg.466.1566868992797;
        Mon, 26 Aug 2019 18:23:12 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e3sm2753784ywc.91.2019.08.26.18.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 18:23:12 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] t6006: simplify and optimize empty message test
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
 <20190826235226.15386-2-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39b07712-f6f0-44bd-c434-a871db4a4899@gmail.com>
Date:   Mon, 26 Aug 2019 21:23:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826235226.15386-2-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2019 7:52 PM, Elijah Newren wrote:
> Test t6006.71 ("oneline with empty message") was creating two commits
> with simple commit messages, and then running filter-branch to rewrite
> the commit messages to be empty.  This test was written this way because
> the --allow-empty-message option to git commit did not exist at the
> time.  Simplify this test and avoid the need to invoke filter-branch by
> just using --allow-empty-message when creating the commit.
> 
> Despite only being one piece of the 71st test and there being 73 tests
> overall, this small change to just this one test speeds up the overall
> execution time of t6006 (as measured by the best of 3 runs of `time
> ./t6006-rev-list-format.sh`) by about 11% on Linux and by 13% on
> Mac.

Wow! A good cleanup to include, regardless of other concerns.

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6006-rev-list-format.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index da113d975b..d30e41c9f7 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
>  '
>  
>  test_expect_success 'oneline with empty message' '
> -	git commit -m "dummy" --allow-empty &&
> -	git commit -m "dummy" --allow-empty &&
> -	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
> +	git commit --allow-empty --allow-empty-message &&
> +	git commit --allow-empty --allow-empty-message &&
>  	git rev-list --oneline HEAD >test.txt &&
>  	test_line_count = 5 test.txt &&
>  	git rev-list --oneline --graph HEAD >testg.txt &&

LGTM.

-Stolee
