Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C773B1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcG2QXI (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:23:08 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:17144 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbcG2QXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:23:07 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s1DY46bV3z5tlG;
	Fri, 29 Jul 2016 18:23:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id F34A9528F;
	Fri, 29 Jul 2016 18:23:03 +0200 (CEST)
Subject: Re: [PATCH] Fix failing test t3700-add.sh
To:	=?UTF-8?Q?Ingo_Br=c3=bcckl?= <ib@wupperonline.de>
References: <579b4ca1.18da2703.bm000@wupperonline.de>
Cc:	git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <6708d224-9a44-1446-8543-7c3c6403e506@kdbg.org>
Date:	Fri, 29 Jul 2016 18:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <579b4ca1.18da2703.bm000@wupperonline.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 29.07.2016 um 14:31 schrieb Ingo Brückl:
> At the time of the test xfoo1 already exists and is a link.
> As a result, the check for file mode 100644 fails.
>
> Create not yet existing file xfoo instead.
>
> Signed-off-by: Ingo Brückl <ib@wupperonline.de>
> ---
>  t/t3700-add.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 4865304..aee61b9 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -342,12 +342,12 @@ test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
>  '
>
>  test_expect_success 'git add --chmod=-x stages an executable file with -x' '
> -	echo foo >xfoo1 &&
> -	chmod 755 xfoo1 &&
> -	git add --chmod=-x xfoo1 &&
> -	case "$(git ls-files --stage xfoo1)" in
> -	100644" "*xfoo1) echo pass;;
> -	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
> +	echo foo >xfoo &&
> +	chmod 755 xfoo &&
> +	git add --chmod=-x xfoo &&
> +	case "$(git ls-files --stage xfoo)" in
> +	100644" "*xfoo) echo pass;;
> +	*) echo fail; git ls-files --stage xfoo; (exit 1);;
>  	esac
>  '

The commit that added this test is already 2 months old. How could that 
have been missed?

In fact, I cannot verify that there is xfoo1 in the directory or in the 
index before this test case runs. The general statement that the commit 
message makes is clearly not correct. What am I missing?

-- Hannes

