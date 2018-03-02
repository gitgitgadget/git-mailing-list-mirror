Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA4F1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946259AbeCBR44 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:56:56 -0500
Received: from avasout04.plus.net ([212.159.14.19]:55486 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424114AbeCBR4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:56:55 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id rovNe28IITRZxrovOeKkBj; Fri, 02 Mar 2018 17:56:54 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=R6ot5+ZX c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ybZZDoGAAAAA:8 a=obx3VohaOq_7eDfPUfMA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] ref-filter: mark a file-local symbol as static
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <1d28d866-535c-6d37-4cb9-5decedab3acb@ramsayjones.plus.com>
 <20180302035904.GA238112@aiede.svl.corp.google.com>
 <733494ed-56b1-9072-3c9d-cedc35acd215@ramsayjones.plus.com>
 <xmqqinaecs3q.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <07197560-a6b6-91a0-3750-b17ed7dc5f69@ramsayjones.plus.com>
Date:   Fri, 2 Mar 2018 17:56:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqinaecs3q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB/r3Ryymav5Vd9XY69Ax3r7z2EyYZiQVwrdNW/xbqRQ2yVl3F++Ju1arfrca3XzAS2L6MeTMaePw+Aa5/qYVPUU0uKRTGIg/PxYWe8zW+vqwZ77ipA6
 c203bPK2yE68YRiaLvzDcvjKgbaNNZb6/kI2jg8NhMMhuqHUruwS06MIOr9Yevvp/q0TzWPKldlosw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/03/18 17:19, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Junio, do you want me to re-roll, or would you mind tweaking the
>> commit message while queueing?
> 
> Perfect timing ;-)  I was about to get to these two patches.  Here
> is what is queued.

Thanks!

ATB,
Ramsay Jones

> commit 2d7cb07e3718d0af6547e2abb35f9cff9b10c1f5
> Author: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Date:   Fri Mar 2 02:54:02 2018 +0000
> 
>     ref-filter: mark a file-local symbol as static
>     
>     Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
>     <id> is invalid', 2018-02-23) added the add_str_to_commit_list()
>     function, which causes sparse to issue a "... not declared. Should it
>     be static?" warning for that symbol.
>     
>     Indeed, the function is only used in this one compilation unit. Mark
>     it static.
>     
>     Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index aa282a27f4..ed993d32d8 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2000,7 +2000,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>  	free(to_clear);
>  }
>  
> -int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
> +static int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
>  {
>  	struct object_id oid;
>  	struct commit *commit;
> 
> 
