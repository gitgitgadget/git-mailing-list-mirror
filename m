Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE38C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjCXSIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjCXSHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:07:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F38C1CF4D
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:06:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id n125so3247013ybg.7
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679681204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJuApYJlGlrugGebotFvm0lEsWFco9+jVH/5FPaQROc=;
        b=TaeK+y6RDeAB0efBQvCuXLuv037PhUFIHCL14PlLp7/dbmfG490PBmCgKz1ruRp40c
         mv6WDM4cZnlZoiW4ZV5B/t2o7R09XrKMA2XgI4g7IsnwgmLuNetGW7Bc6G6rpzCBGKyu
         YaOiLY4iwRTnxgE5q9VSROyzb+1DC942zE8ZJcaFYv7ETfA1XvG8/adDGWUblxlx4SQP
         G3/Hy3vPLdZepsBq4Yw5Oss2vd3ym4epVpC/BCwr7pqQFdYVg5yImX+a0xDhNEpNLp9T
         zufJ6rL5G3qQTi3thpTkgFIEaT1fAEsy40sedLd/9FihEK3pd+0Yq6JycQ33WGHQ9ZYK
         mVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679681204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJuApYJlGlrugGebotFvm0lEsWFco9+jVH/5FPaQROc=;
        b=sbJ4mysypP8OkHqDWv6cHzEjYVpictwqQ1FdGGsatHhiotOr35xVMC1WpoTxHXEteq
         BJnLEfK4EU32bt83M2n23d9I4GL8JroxS7G95SPjw2szdJKZwVYnpumW3WM3zQ0PRxxS
         1plOpc7sZBcUht+H7b++ITebrDA8oyCTPzYDw1ad6Bq9EaR2dXwhZ7/CIxWg/8zcDYoG
         OHK0Rg4YSbg2ld8PQzWDX2FpOcvYi4kfWWSzI4wosm+IQUL4+zVJUaQThHZfS5Y8HN4K
         2d2A5dvQi+GGWHMUXS2i6nkLBHHfrZPMVJc8BCrFaPh/VuTZpT4fx6WWCgSPqnEhasHf
         SoFA==
X-Gm-Message-State: AAQBX9ebg+EB9ylnIopSldKViVOFdaBePY/7/Y20a4jSXVtTIJxOq7Ah
        mqF62ajSG0mz4eIHkZsbNd9f
X-Google-Smtp-Source: AKy350b9e8XXiyYuH0sVzBdXRDd/E6JBAimW+m1vGljwWAwFLQ2E7D+oucx9t3upyKP1iRLPAeQpcg==
X-Received: by 2002:a25:144:0:b0:a2d:a981:6f50 with SMTP id 65-20020a250144000000b00a2da9816f50mr3260837ybb.27.1679681204356;
        Fri, 24 Mar 2023 11:06:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id d8-20020a818d08000000b00545a0818501sm525733ywg.145.2023.03.24.11.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:06:44 -0700 (PDT)
Message-ID: <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
Date:   Fri, 24 Mar 2023 14:06:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover.1679342296.git.me@ttaylorr.com>
 <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
 <20230321180525.GG3119834@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230321180525.GG3119834@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2023 2:05 PM, Jeff King wrote:
> On Mon, Mar 20, 2023 at 04:02:52PM -0400, Taylor Blau wrote:
> 
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -174,7 +174,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
>>  		return NULL;
>>  	}
>>  
>> -	index->map_pos += bitmap_size;
>> +	bitmap_index_seek(index, bitmap_size, SEEK_CUR);
>>  	return b;
> 
> As an aside, I notice none of the callers here or in the next patch
> check the return value of bitmap_index_seek(). I guess you included it
> to match the return value of lseek(), but maybe it is better to return
> void if nobody is looking at it.
> 
> But getting back to the bounds-checking: I think we are already
> correctly bounds-checked here, because ewah_read_mmap() will make sure
> that it doesn't read too far (and will return an error if there's
> truncation). And if it didn't, this check-on-seek doesn't help us,
> because we'll already have done out-of-bounds reads.

>> +	bitmap_index_seek(index, header_size, SEEK_CUR);
>>  	return 0;
>>  }
> 
> Likewise this function already has bounds checks at the top:
> 
> 	if (index->map_size < header_size + the_hash_algo->rawsz)
> 		return error(_("corrupted bitmap index (too small)"));
> 
> I'd be perfectly happy if we swapped that our for checking the bounds on
> individual reads, but the extra checking in the seek step here just
> seems redundant (and again, too late).

I think it would be nice to replace all of these custom bounds
checks with a check within bitmap_index_seek() and error conditions
done in response to an error code returned by that method. It keeps
the code more consistent in the potential future of changing the
amount to move the map_pos and the amount checked in these conditions.

Thanks,
-Stolee
