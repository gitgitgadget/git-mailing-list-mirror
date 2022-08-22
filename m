Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39903C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 17:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiHVRDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiHVRDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 13:03:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B539205
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:03:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id p5so7036768qvz.6
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OmblUDyxltFiDY94RhTJr5oFxjMeu4LCyi6B0TgGRmU=;
        b=W+JcJNb5F9hXu7yFrCP6DKM3RKaL4JSz5xoABU4cQLPfQGHHpjBfyVJAYD8TNWiKLC
         2PhfyIeX2wt0vL6i83rqR4Go1L3nBxcNFyDsK3ZVAgo1Wq+H6C6zraSLmnzEvgZgGkxV
         TS34yE5QnCoEdSDlQJHTDA34xBB9mKVkoEaQqwTVyrkX+a1HCAIptnb/mJO/GmAbbHg1
         WdcIa21ZgOCxlFzwozmYEt0BXflHXSLggpQbkFfyqUZgDLA9vDfqWOMJSdFQxSpYXOfQ
         O9Aq17RaYHt4vgM95xV6LlHtBItAxvQl72HBZri7AVLN400mSg363mFRLHVoyd8lK/yY
         8vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OmblUDyxltFiDY94RhTJr5oFxjMeu4LCyi6B0TgGRmU=;
        b=qbqPrJy+mcV8UU378hL3BpEwJ+XNieOc/KsGeWnAg97rY5fB1GxKS6L38ydGL1L8Wp
         k7fw7JoWvWg9AhZaxo9bjTk6XRjR/mNwKG9IKGF/ayR6OUq8gJs+8RXYqnQRmR5AWjaA
         lAk1wwkvtIpbNq+Q+fp8ZcUtX9X+SkSbjHhV8PNiFkEnm4tQ1Rx7SDll9kKH9ch/Unww
         xdQrla7E0v933RG/80GdFkDMLAerkrvdCxYcHvWpcCDUhpy38gTr+UYSTwREuRx2X/p4
         wmW10BOlQVlvUDFpl15Fo+WfaxB+NM0otpB/eMm5mzFbC668fzh4hnnnIjuzZlU51ro0
         uVLw==
X-Gm-Message-State: ACgBeo3gFaDWRdJW5iQKM3X3HnAKlS8IZYMZNc43KzmzcjXBag6YNWqu
        m8cTqttUSAQ3OPl+PxOLXpIy
X-Google-Smtp-Source: AA6agR7Ts3bq1/J6pXilLKZ5kGRJYSp38X1RF3I6H+8lyvFFN12Vm9TgivdCP01Q7k+yMFJq/bPYgQ==
X-Received: by 2002:a05:6214:1d21:b0:496:a0d8:ec20 with SMTP id f1-20020a0562141d2100b00496a0d8ec20mr16624165qvd.84.1661187793261;
        Mon, 22 Aug 2022 10:03:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5550:8912:9500:397a? ([2600:1700:e72:80a0:5550:8912:9500:397a])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a410500b006b640efe6dasm11871834qko.132.2022.08.22.10.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:03:12 -0700 (PDT)
Message-ID: <3cecd058-aec2-d5f9-ef79-58cc10ce14fb@github.com>
Date:   Mon, 22 Aug 2022 13:03:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 6/6] midx.c: include preferred pack correctly with
 existing MIDX
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
References: <cover.1660944574.git.me@ttaylorr.com>
 <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 5:30 PM, Taylor Blau wrote:

> Resolve this by adding all objects from the preferred pack separately
> when it appears in the existing MIDX (if one was present). This will
> duplicate objects from that pack that *did* appear in the MIDX, but this
> is fine, since get_sorted_entries() already handles duplicates. (A
> future optimization in this area could avoid adding copies of objects
> that we know already existing in the MIDX.)

...

> This resolves the bug described in the first patch of this series.

Thinking ahead to when this is a commit, perhaps this could instead
refer to the 'preferred pack change with existing MIDX bitmap' test
case?

> @@ -610,10 +609,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
>  		nth_midxed_pack_midx_entry(m,
>  					   &fanout->entries[fanout->nr],
>  					   cur_object);
> -		if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
> -			fanout->entries[fanout->nr].preferred = 1;
> -		else
> -			fanout->entries[fanout->nr].preferred = 0;
> +		fanout->entries[fanout->nr].preferred = 0;
>  		fanout->nr++;

Here, we have lost the ability to set the 'preferred' bit from the
previous MIDX. Good.

> @@ -694,6 +689,11 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>  						    preferred, cur_fanout);
>  		}
>  
> +		if (-1 < preferred_pack && preferred_pack < start_pack)
> +			midx_fanout_add_pack_fanout(&fanout, info,
> +						    preferred_pack, 1,
> +						    cur_fanout);
> +

And here, when there is a preferred pack _in the previous MIDX_,
we add its objects a second time, but now with the preferred bit
on. If the preferred pack is _not_ in the previous MIDX, then the
'preferred_pack < start_pack' condition will fail and the bits
would have been set within the for loop.

> @@ -346,7 +346,7 @@ test_expect_success 'preferred pack change with existing MIDX bitmap' '
>  		test_path_is_file $midx &&
>  		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
>  
> -		test_must_fail git clone --no-local . clone2
> +		git clone --no-local . clone2

I mentioned in patch 1 that this test could use some comments about
what is unexpected and what _is_ expected. I think this comment needs
an update in this patch:

	# Generate a new MIDX which changes the preferred pack to a pack
	# contained in the existing MIDX, such that not all objects from
	# p2 that appear in the MIDX had their copy selected from p2.

Thanks,
-Stolee
