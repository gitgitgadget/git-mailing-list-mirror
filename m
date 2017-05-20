Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576AB201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755096AbdETVQP (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:16:15 -0400
Received: from avasout07.plus.net ([84.93.230.235]:36762 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753856AbdETVQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:16:14 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id NlGA1v0071keHif01lGBbf; Sat, 20 May 2017 22:16:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=gdoHADL5AAAA:8 a=5D-dG0KQFcBTO_saTsQA:9 a=QEXdDO2ut3YA:10
 a=DclRd9yUzMzvIfv12z_R:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] name-rev: use larger timestamp for is_better_name
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
References: <20170520203649.GA13079@untitled>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fe9ca677-1f38-4b61-a610-9f8ab014daff@ramsayjones.plus.com>
Date:   Sat, 20 May 2017 22:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170520203649.GA13079@untitled>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/05/17 21:36, Eric Wong wrote:
> This fixes t4202 for me at "44 - log --graph with full output"
> on 32-bit x86.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  This is for pu, I'm still using the machine I used git with in 2005 :)
> 
>  builtin/name-rev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index f06498524..35409c03b 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -27,7 +27,7 @@ static const char *prio_names[] = {
>  
>  static int is_better_name(struct rev_name *name,
>  			  const char *tip_name,
> -			  unsigned long taggerdate,
> +			  timestamp_t taggerdate,
>  			  int generation,
>  			  int distance,
>  			  int from_tag)
> 

Heh, you seem to be a little ahead of me. :-D

I test on 32-bit Linux from time to time, and tonight's 'pu'
branch fails t4202.44, t6007.2,5-6,12-13,16, t6012.2-11,
t6111.2-65. I bisected the t4202 failure to a merge commit
(99d31e1378, merge branch 'jc/name-rev-lw-tag') and I spotted
the 'unsigned long' taggerdate parameter to the is_better_name()
function.

I was just about to try the patch above and retest, when I saw
your email! (so I can leave that for tonight).

Thanks!

ATB,
Ramsay Jones

