Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D563020954
	for <e@80x24.org>; Fri,  1 Dec 2017 19:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdLATuJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 14:50:09 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37578 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdLATuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 14:50:08 -0500
Received: by mail-qt0-f172.google.com with SMTP id d15so14450563qte.4
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 11:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lCcVaIbjh44IGGvaHpu32QJkL32YHdz7SO0PPlcl4qU=;
        b=k+CuXFsc87EnwEbZ4WQagvKoVH4WBCzqMGu1Q/yeYbHLIzjhZA3AqsQdogrg0SyedG
         g6qPxl3K62D4AGdudZsbrcNa67BupvWUEc05od+HtuPdth0NaQ5MjBmj9FPrmaKj0VwU
         dcJPKD9kC1PNyfIqYtQGrpdC0X1fGPt+B8eBaprBAXHIUwDs6E7Wvyz42Xz1wIEjjjj9
         azkGZYkJ2LZhJucv3ahMmvMAqkSgCwP+ExhcQj5f3j/ly0SA5qdLx27OfWqr7m0uETxJ
         BTrYSuHddX4JqJ2rNy2XLQcGDhKBGR+GtL04U+yhm7gubdLS4UlXuYJSapgZoD3JB0Ma
         MwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lCcVaIbjh44IGGvaHpu32QJkL32YHdz7SO0PPlcl4qU=;
        b=AcWtJe36fjW5BoMz22S25Jv51Fp21OHf5oJwlqy3ciUQi/8ACGwYR1w54+B5ehooeN
         eULc1lITdzA13gIvY95KVovbgeYHR4Ye86kN8g8/Va8Y7YU41gtyWt1eD0CMxgT0HDoR
         a2II4axvdUrhMGsYyGAzrLeI1Qi7dCdy/B/g0IMieFxD3VD+HaWXPc9F7CKcJNYg3HwK
         wODYnxc3/RDnS0R8kXGCYbb8CuqgFIph4LgExXwZjyevRT7Gwjl7WQp4PKJyoX/Q4PVM
         3aPYZvaVhdPQDpykO+0blgeTD65r+NNX8MoJOqk6Cs/bliBt+WtJZ8pHfrczlN0QPLWA
         08Ag==
X-Gm-Message-State: AKGB3mIiEI4UTqHRec+fjhJRdo0ypuSzCLCMXExcg5/5EXv7UmrA9I59
        3BhwUtG1nzHb2npbv42fB24=
X-Google-Smtp-Source: AGs4zMYLlBhX6V9lmtSmWghI4KXeZzXB/+BNyq49yfe9VZf3ZBI5B5DDLrlpWULossj9gcrrtXa8pA==
X-Received: by 10.237.59.247 with SMTP id s52mr9736767qte.139.1512157807361;
        Fri, 01 Dec 2017 11:50:07 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:1::7cc])
        by smtp.gmail.com with ESMTPSA id o26sm5414937qto.16.2017.12.01.11.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2017 11:50:06 -0800 (PST)
Subject: Re: [PATCH] sha1_file: use strbuf_add() instead of strbuf_addf()
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
References: <20171201174956.143245-1-dstolee@microsoft.com>
 <20171201182238.GA27688@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <54da89a5-bf20-cb20-9884-6285033f0d95@gmail.com>
Date:   Fri, 1 Dec 2017 14:50:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171201182238.GA27688@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2017 1:22 PM, Jeff King wrote:
> On Fri, Dec 01, 2017 at 12:49:56PM -0500, Derrick Stolee wrote:
[snip]
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 8ae6cb6285..2160323c4a 100644
> This overall looks good, but I noticed one bug and a few cosmetic
> improvements.

Thanks for finding quality improvements to this patch. I'll let it sit 
over the weekend for more feedback before sending a v2.

>
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1914,17 +1914,18 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
>>   	}
>>   
>>   	oid.hash[0] = subdir_nr;
>> +	strbuf_add(path, "/", 1);
> Maybe:
>
>    strbuf_addch(path, '/');
>
> would be a bit more readable (it's also a tiny bit faster, but this
> isn't part of the tight loop).
>
>> +	baselen = path->len;
> We set this here so that the '/' is included as part of the base. Makes
> sense, but can we now drop the earlier setting of baselen before the
> opendir() call?

Yeah, probably. I had briefly considered just adding the '/' before the 
first assignment of "baselen", but didn't want to change the error 
output. I also don't know if there are side effects for other platforms 
by calling opendir() with a '/'-terminated path.

>>   	while ((de = readdir(dir))) {
>>   		if (is_dot_or_dotdot(de->d_name))
>>   			continue;
>>   
>> -		strbuf_setlen(path, baselen);
>> -		strbuf_addf(path, "/%s", de->d_name);
>> -
>>   		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
>>   		    !hex_to_bytes(oid.hash + 1, de->d_name,
>>   				  GIT_SHA1_RAWSZ - 1)) {
>> +			strbuf_setlen(path, baselen);
>> +			strbuf_add(path, de->d_name, GIT_SHA1_HEXSZ - 2);
> Moving this code into the conditional makes sense here, since that's
> where we know the actual size. But what about the case when we _don't_
> hit this conditional. We still do:
>
>    if (cruft_cb)
>          cruft_cb(path->buf);
>
> which is now broken (it will just get the directory name without the
> entry appended).

Good catch! A big reason to pull it inside and use strbuf_add over 
strbuf_addstr is to avoid a duplicate strlen() calculation. However, I 
can store the length before the conditional.

> I think the optimized versions probably needs to be something more like:
>
>    while (de = readdir(...)) {
>        strbuf_setlen(path, baselen);
>        if (size is HEXSZ - 2) {
>            strbuf_add(path, de->d_name, HEXSZ - 2);
> 	  obj_cb(path->buf);
>        } else if (cruft_cb) {
>            strbuf_addstr(path, de->d_name);
> 	  cruft_cb(path->buf);
>        }
>    }

Small change by storing the length in advance of the conditional:

while (de = readdir(...)) {
     int namelen = strlen(de->d_name);
     strbuf_setlen(path, baselen);
     strbuf_add(path, de->d_name, namelen);

     if (namelen == HEXSZ - 2)
         obj_cb(path->buf)
     else
         cruft_cb(path->buf);
}

> Two other thoughts:
>
>    - from past discussions, I suspect most of your performance
>      improvement actually comes from avoiding addf(), and the difference
>      between addstr() and add() may be negligible here. It might be worth
>      timing strbuf_addstr(). If that's similarly fast, that means we
>      could keep the logic out of the conditional entirely.

addstr() duplicates the strlen(), which isn't much but we might as well 
save cycles where we can if it isn't too hard.

>    - there's an extra micro-optimization there, which is that if there's
>      no obj_cb, we have no need to assemble the full path at all. I doubt
>      it makes much of a difference, as most callers would pass an object
>      callback (I'd be surprised if we even have one that doesn't).

After doing a few 'git grep' commands, I found several that include a 
NULL cruft_cb but none that have a NULL obj_cb.

Thanks,
-Stolee
