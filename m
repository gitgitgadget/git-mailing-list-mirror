Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C072082F
	for <e@80x24.org>; Sun, 16 Jul 2017 04:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdGPEE6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 00:04:58 -0400
Received: from mout.web.de ([212.227.15.4]:51599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdGPEEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 00:04:41 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZlNu-1dDHUS3Y3a-00LU3L; Sun, 16
 Jul 2017 06:04:18 +0200
Subject: Re: [PATCH 3/2] apply: use COPY_ARRAY and MOVE_ARRAY in
 update_image()
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
 <2b2c8a6b-b493-84b1-1e47-5ea4585610da@web.de>
 <636e2b70-2687-a925-e52d-32aa966ae9a9@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cfc122ac-bd43-99f4-395d-2607fc34370c@web.de>
Date:   Sun, 16 Jul 2017 06:04:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <636e2b70-2687-a925-e52d-32aa966ae9a9@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:EN+KVfmLPJ39uB/aa0R0KsMrVzptBqsobCjAIJ53fR+6rHmQC4t
 HHFGM/oUwMMGlQ7bM5uwRqdJO1cGBVWLR7y5KEAy8SxP7Evhdlntr1aVUcGUE5kvPX4ALJu
 ZF4S6WsjF2BKYmI4axFEx2JRC9FMIeV32wYZPxdKlz0Z9oU83F7RIZVs7+uW+jsHe73d0+s
 OH36ldWyNhSoD+LVB1POw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3jjoTsLr3Mc=:U3Br704dTQ2l5ez5gmUhkb
 V/V06L4baVAObvRdiTP1V0NO/suFBxXnkFX+8vyOELGCD110jOAYri+4Ch8lkqkwe5n/8gWmi
 zs91bEs8TbVtEVJReRLbvS4wh/1GU3PosRMAIAeioFwStwQjrukREpbIonwvQ6YG3Pn+YDYa3
 /3Byqb0433sB8Tf5wAnDCKJ9SQKrFAbbvhNW8lAe4fYLhkPHbiHTVZsBb73JigS2gHpMLc9xu
 2QJh11HVsmj0rZYp2ttpXkMx+lRyYxJnieKMPfGGeg2AAGcO7Oy+KI7o9OM9ueJ9OWexj/a2P
 dHmfspIt79FutlFirs7mbAsu7nKi2xPeaXTZwo1hUEw7E9XLth4pADlrFpM/Tm0avM+L29WhH
 ZvzWoAXzHkMg9RHQ6Q8Jv/6DGtX3xqRgjuD+mgMY6ui5/vHBOZ3F7FeCUCiMIYCqY0yD5Ncxx
 cmVB7X4gQoX4IaP9oGYHTyZeJamMQ0iGWip8P98Zh9fUgts9wdhnmMO4kdbLNLNvCg1S+2Z8d
 WB4t1JMIqkGdshHsA6F+cy4SHNDbosG6rYajlCuGUPafM/RPhLMoR0zYMtXmI8CLfICRAKNQB
 s9qsn6FO1hBsFx//RymZu+kSQf6vw7OklWJWjXeGBr4nY/9zKjdIMHEHo3mKbyJnr1Onzt3Ll
 ECazepPQ0sj27KF86WNuP3n5/vhGd+z+6rXVW3pUBPgLOsZJhY9Wy1llg8f0XMpMWHFEuKoL9
 td3EnxoqI/w+pKZJqKeXLZk0vUfm7oIERuqpH1ZdMMuQJqnzFmxykS8qYsAcXgCKYSaKAeekV
 7EhMbzn2eZpeGYOJkQWFDC56cRs89rZ0XKk5H/MGHHEJ/RZxJs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 02:31 schrieb Ramsay Jones:
> 
> 
> On 15/07/17 21:20, René Scharfe wrote:
>> Simplify the code by using the helper macros COPY_ARRAY and MOVE_ARRAY,
>> which also makes them more robust in the case we copy or move no lines,
>> as they allow using NULL points in that case, while memcpy(3) and
>> memmove(3) don't.
>>
>> Found with Clang's UBSan.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> I don't know why the rules in contrib/coccinelle/array.cocci didn't
>> match. :-?
>>
>>   apply.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/apply.c b/apply.c
>> index f2d599141d..40707ca50c 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -2809,13 +2809,10 @@ static void update_image(struct apply_state *state,
>>   		img->line_allocated = img->line;
>>   	}
>>   	if (preimage_limit != postimage->nr)
>> -		memmove(img->line + applied_pos + postimage->nr,
>> -			img->line + applied_pos + preimage_limit,
>> -			(img->nr - (applied_pos + preimage_limit)) *
>> -			sizeof(*img->line));
>> -	memcpy(img->line + applied_pos,
>> -	       postimage->line,
>> -	       postimage->nr * sizeof(*img->line));
>> +		MOVE_ARRAY(img->line + applied_pos + postimage->nr,
>> +			   img->line + applied_pos + preimage_limit,
>> +			   img->nr - (applied_pos + preimage_limit));
>> +	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);
> 
> My patch looks like:
> 
> -       memcpy(img->line + applied_pos,
> -              postimage->line,
> -              postimage->nr * sizeof(*img->line));
> +       if (postimage->line && postimage->nr)
> +               memcpy(img->line + applied_pos,
> +                      postimage->line,
> +                      postimage->nr * sizeof(*img->line));
> 
> ... which I think I prefer (slightly).

Can postimage->line be NULL when postimage->nr is bigger than 0?  What
would that mean?  The only ways to arrive at that point that I an come
up with are bugs (we accidentally set ->line to NULL, or we forgot to
clean ->line).  We'd better notice them early by getting a nice
shrieking segfault.  Adding an assert would work as well.

René
