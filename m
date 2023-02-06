Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBB4C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 15:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBFP2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBFP2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 10:28:00 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B635250
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 07:27:59 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m12so13167987qth.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEA4Q+P2iSRgROlVZN64zSdKm8K82U/EmBgu7A4EmdU=;
        b=Y1lVwU2xGO3MCJXITR/6GTdTpvpz3J+o0wtmj5xr5ktrTpkkSqZzhfDdP4BeiGoGmh
         oXElz2BXt16Musn8dXMeBwCF9ZyUDCGdfdIALBYrm9/VhNcceNqYerP9u4WpTxUKgzNf
         wYHDYTYVJheIJra0DBVbvMnO+6fqE4mwp5v/9w38M4plYNW8ast8juVEfNsHg/Hkr1CI
         S5sGjRmPnT0j+M0mdLJadR2vytQ+9VowpgnBQ1XE9VjejQwvb8tDijtTbnu00A8Og8rm
         9UfvJUrxM/Stcio98fdqP+QK6MW7SYiGlJOeFaUmT3d6ftsgS2OuxDq3j3Z4SWw+8bqO
         h5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEA4Q+P2iSRgROlVZN64zSdKm8K82U/EmBgu7A4EmdU=;
        b=InUIezOHXcQ2LA9vzGqbK9u2HBXioCygAvVWkRdBVZodxZsc61Go2hPSDyi7GrK/sK
         YGumaFVudEINy7LbgW3CQuGRD6Ij2osr4T1X7FLPMyDgxAKo1Lom4Gq2HgfXMCnSZAB3
         j+7GmdyEgEm0vGGpw64RC8xTxAcihjeJK3l2/GpnIbeFq5G7fI5zZ19IWEGfmK4k5Nh7
         o9H5tB8rg9F1NuTqKod07Gk+xAggdFMUgXcC17kFkHCH3Cb4nJfZNHOOGeS5DLPCj4ZZ
         UdDTxeMvqFesD7/U/B1mwghMX9RdjW3awK1/FQyXbyof9QMw3X4s7TMF5Lk/yWWsGFzb
         hZ4g==
X-Gm-Message-State: AO0yUKWiOZGyqzVQ90fCI6zQmjj4bTFt9z1mBvzz+pbkR7lhh62MpXps
        SlVSohde9wBhxMbwZNYX1VwT
X-Google-Smtp-Source: AK7set+Eih19vqreMU0AP6Y2NpFxEYadsiMPtsoCAMfa3ujt5Hf7p6luiUjjUVz9m0Gu1TUBKHeGlQ==
X-Received: by 2002:ac8:5987:0:b0:3b6:9418:ad6f with SMTP id e7-20020ac85987000000b003b69418ad6fmr22156078qte.67.1675697278885;
        Mon, 06 Feb 2023 07:27:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e86a:4a12:4f24:ca25? ([2600:1700:e72:80a0:e86a:4a12:4f24:ca25])
        by smtp.gmail.com with ESMTPSA id o6-20020ac85546000000b003b2ea9b76d0sm7378731qtr.34.2023.02.06.07.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 07:27:58 -0800 (PST)
Message-ID: <b1a3e684-26f9-0053-9446-751d73e83961@github.com>
Date:   Mon, 6 Feb 2023 10:27:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/5/2023 4:12 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Feb 04 2023, René Scharfe wrote:
> 
>> Use size_t to store the original length of the strbuf tree_len, as
>> that's the correct type.
>>
>> Don't double the allocated size of the strbuf when adding a subdirectory
>> name.  Only extend it to fit that name and a slash.
>>
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>> ---
>>  cache-tree.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/cache-tree.c b/cache-tree.c
>> index 9af457f47c..35f7617164 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -760,7 +760,7 @@ static void prime_cache_tree_rec(struct repository *r,
>>  	struct tree_desc desc;
>>  	struct name_entry entry;
>>  	int cnt;
>> -	int base_path_len = tree_path->len;
>> +	size_t base_path_len = tree_path->len;
>>
>>  	oidcpy(&it->oid, &tree->object.oid);
>>
>> @@ -785,7 +785,7 @@ static void prime_cache_tree_rec(struct repository *r,
>>  			 */
>>  			if (r->index->sparse_index) {
>>  				strbuf_setlen(tree_path, base_path_len);
>> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
>> +				strbuf_grow(tree_path, entry.pathlen + 1);
>>  				strbuf_add(tree_path, entry.path, entry.pathlen);
>>  				strbuf_addch(tree_path, '/');
>>  			}
> 
> The size_t conversion is trivially correct.

I agree, and thanks for finding and fixing this issue.

Upon reading strbuf_grow(), I would expect it to work the same
as ALLOC_GROW(), but its documentation clearly states a very
different result.

> One wonders if (even for this index-related code) we really need such
> careful management of growth, and could instead do with:
> 
> 	strbuf_setlen(tree_path, base_path_len);
> 	strbuf_add(tree_path, entry.path, entry.pathlen);
> 	strbuf_addch(tree_path, '/');

This would be my preferred way to go here.

> Or even just:
> 
> 	strbuf_addf(tree_path, "%*.s/", (int)entry.pathlen, entry.path);

Please do not add "addf" functions that can be run in tight loops.
It's faster to do strbuf_add() followed by strbuf_addch().

Thanks,
-Stolee
