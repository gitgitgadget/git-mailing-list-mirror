Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E621A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeHMOFM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:05:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33711 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeHMOFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:05:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so16938704qtp.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tQCnlQvG9QVk2B6lbFBEba6YhVCFx8mm9gEreOmk6ZA=;
        b=XUKjpRqQjFTixCQItEBviksfbVAXCdmqJOqU1lSuSYOpZnopBdFid04QHhSaqNSrpY
         CiCndEH30mK11YdyDAzeNFfCpgNXosnTmsCKPKzHHtvSl5ZDu9wgyjRT+5TFwJA9j/MT
         Ro26+0joBI/XFZXTJ3LuBLW16Bctc/gDmSX9jHlgt6DtRLivTddvbuKlkEg5KyJR/RI0
         z/gR6AZDZEj9X1AG7LX7Xc/Jzd0GBwsz3dVNXqSHsMPkEd4JYJNXbTKs0alv5AvInYO4
         YL67pgFpKRrezhXuCxhYU8SUxg/UvaIljcMlpcP94tHBu6gm8AE7ULs93s46Wkeg9x7i
         6m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tQCnlQvG9QVk2B6lbFBEba6YhVCFx8mm9gEreOmk6ZA=;
        b=OV311kNAPqzQIEV1Aa1kV1InFtIB5Yore4FoeujYwRFOxfXct6Y2GWhHxqzgqMcowG
         Rbh6GeiDhK9Pe//DiPs//ZjThEK2bccoh3n5BC0Ep4qd5zV6WNpvDjyNsYBkzg+df+Xn
         wseRtqATU8BtnoCX0vMdF66/pZHibT8sHWEMs5kBHh2DxsP6W++hFBlhzWA7Q27yq1Fc
         XhnFjleQgK2IEM709sWMGntq4wGO3RddKmcKUiMgss0WicFpocE5skhdSLElQgvJqdW6
         fpYXxa0MT2aaR7Nx0uEc5tjzNiPCB0Mq3IBIAcu4e01u2Pg4br0a2ooJSe/smNra6CYN
         pJGQ==
X-Gm-Message-State: AOUpUlFxYOX8WxEMmH6BOKUvxJn/KpqUz8KQHXZePXXu01WQXCHcCECw
        KwraMR6do9D6x/Xs5KlJ0XOT8SXR
X-Google-Smtp-Source: AA+uWPywacDDZAXrMMH5GT3nIlT+wIzbOLG9oM1oOogTYTr8MVumpSktqy7XeR2Q8vWE/8jOUguwkA==
X-Received: by 2002:ac8:306b:: with SMTP id g40-v6mr16185631qte.136.1534159401547;
        Mon, 13 Aug 2018 04:23:21 -0700 (PDT)
Received: from [172.16.101.16] ([216.253.28.6])
        by smtp.gmail.com with ESMTPSA id p21-v6sm11500548qtb.32.2018.08.13.04.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:23:20 -0700 (PDT)
Subject: Re: [PATCH] t5318: avoid unnecessary command substitutions
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <b2f5b69806c4c4a4009267701245aee4cabd2cf1.1531348540.git.jonathantanmy@google.com>
 <20180813003010.17610-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9e934039-6b97-28bd-b5c9-34ac5f6754bb@gmail.com>
Date:   Mon, 13 Aug 2018 07:23:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180813003010.17610-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2018 8:30 PM, SZEDER Gábor wrote:
> Two tests added in dade47c06c (commit-graph: add repo arg to graph
> readers, 2018-07-11) prepare the contents of 'expect' files by
> 'echo'ing the results of command substitutions.  That's unncessary,
> avoid them by directly saving the output of the commands executed in
> those command substitutions.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>   t/t5318-commit-graph.sh | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 1c148ebf21..3c1ffad491 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -444,25 +444,27 @@ test_expect_success 'setup non-the_repository tests' '
>   test_expect_success 'parse_commit_in_graph works for non-the_repository' '
>   	test-tool repository parse_commit_in_graph \
>   		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
> -	echo $(git -C repo log --pretty="%ct" -1) \
> -		$(git -C repo rev-parse one) >expect &&
> +	{
> +		git -C repo log --pretty=format:"%ct " -1 &&
> +		git -C repo rev-parse one
> +	} >expect &&
>   	test_cmp expect actual &&
>   
>   	test-tool repository parse_commit_in_graph \
>   		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
> -	echo $(git -C repo log --pretty="%ct" -1 one) >expect &&
> +	git -C repo log --pretty="%ct" -1 one >expect &&
>   	test_cmp expect actual
>   '
>   
>   test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
>   	test-tool repository get_commit_tree_in_graph \
>   		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
> -	echo $(git -C repo rev-parse two^{tree}) >expect &&
> +	git -C repo rev-parse two^{tree} >expect &&
>   	test_cmp expect actual &&
>   
>   	test-tool repository get_commit_tree_in_graph \
>   		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
> -	echo $(git -C repo rev-parse one^{tree}) >expect &&
> +	git -C repo rev-parse one^{tree} >expect &&
>   	test_cmp expect actual
>   '
>   
These make sense and are good examples for future test patterns. Thanks, 
Szeder.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
