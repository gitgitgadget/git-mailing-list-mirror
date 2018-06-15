Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2074F1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 15:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934609AbeFOPDQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 11:03:16 -0400
Received: from avasout07.plus.net ([84.93.230.235]:52193 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754429AbeFOPDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 11:03:16 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id TqFtfjqJyjlDzTqFvfEdMn; Fri, 15 Jun 2018 16:03:15 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=yMhMjlubAAAA:8 a=6EsMHRoz8zFA2R-kbwUA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/8] ewah/bitmap.c: delete unused 'bitmap_each_bit()'
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615143018.170686-3-dstolee@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <aa2e0c9e-752c-e8ec-ce1f-ccbc6af6ce27@ramsayjones.plus.com>
Date:   Fri, 15 Jun 2018 16:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615143018.170686-3-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGTSULUIErQ03HI/8syrUMggJg4nBdDE9magfbwMhF9b6VB3GLe2BfEwe7hhZfvPVpN9R4YPkc1Xx0PBjDKo5WNwOGVs+/PXjJXxf+rQDEACLdNEDR75
 7B6NHSiakYJbIgMvSb6dKVAL4S2LPx7DGqTktZxKJpW7f1c+FBbWWH0KmeabYBjZrmpzr+qowJpTig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/06/18 15:30, Derrick Stolee wrote:
> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ewah/bitmap.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index d61dc6114a..52f1178db4 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -129,30 +129,6 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
>  		self->words[i++] |= word;
>  }
>  
> -void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *data)
> -{
> -	size_t pos = 0, i;
> -
> -	for (i = 0; i < self->word_alloc; ++i) {
> -		eword_t word = self->words[i];
> -		uint32_t offset;
> -
> -		if (word == (eword_t)~0) {
> -			for (offset = 0; offset < BITS_IN_EWORD; ++offset)
> -				callback(pos++, data);
> -		} else {
> -			for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
> -				if ((word >> offset) == 0)
> -					break;
> -
> -				offset += ewah_bit_ctz64(word >> offset);
> -				callback(pos + offset, data);
> -			}
> -			pos += BITS_IN_EWORD;
> -		}
> -	}
> -}
> -
>  size_t bitmap_popcount(struct bitmap *self)
>  {
>  	size_t i, count = 0;
> 

Again, remove extern declaration from header file.

ATB,
Ramsay Jones


