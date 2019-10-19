Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F251F1F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 11:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfJSL63 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 07:58:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:40579 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfJSL63 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 07:58:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46wLyV2wQlz5tl9;
        Sat, 19 Oct 2019 13:58:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6D0E71CFC;
        Sat, 19 Oct 2019 13:58:25 +0200 (CEST)
Subject: Re: [PATCH v2 01/15] t7408: replace `test_must_fail
 test_path_is_file`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
 <987fee4652ae1bd8d3eb50ed51f7c9694d567dfc.1571435195.git.liu.denton@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <769fabd5-9159-61c8-db88-52a4d261f88a@kdbg.org>
Date:   Sat, 19 Oct 2019 13:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <987fee4652ae1bd8d3eb50ed51f7c9694d567dfc.1571435195.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.10.19 um 00:04 schrieb Denton Liu:
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index 34ac28c056..9e62d43cac 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -123,7 +123,7 @@ test_expect_success 'missing submodule alternate fails clone and submodule updat
>  		test_must_fail git submodule update --init &&
>  		# and we have no alternates:
>  		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&

Here's another incorrect use of test_must_fail (not the only instance in
this file). Looks like we would need a "test_alternate_is_not_used" helper.

> -		test_must_fail test_path_is_file sub/file1
> +		test_path_is_missing sub/file1
>  	)
>  '

I suggest to drop this patch; it doesn't fit the theme of this series,
and if you attempt to do it right, you'll quickly find a deep rabbit hole.

-- Hannes
