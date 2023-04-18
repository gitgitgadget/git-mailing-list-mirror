Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C7C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjDROcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDROcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:32:16 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D49F
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:32:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n203so17495624ybg.6
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681828334; x=1684420334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgfbRS38TgiTelC0++i/E8We2Hs+Q4ZVYsKtamXu3Ns=;
        b=dr7bkI1D6nlB90w+ol8G+k/7avig/BtjxQmSS4nTeOcHeGOmnCfdA9prr9MfxFPaZr
         yWkXUiEHydjAFFuGeJN9zyMvMp9v42PNYiBebJBiO2n7Rqc50F0kLy8rMA9LNkN5bGme
         3/gSbsMd192SnSxl21wysIhWSPXTGwpvM6p7bZS9N34mX7Q6CFu8n+ZynZ/YR7KOsLjW
         yAbi6OMzh25WFmAiTNtEvY4JhM9FMItm62p84bOYPoc0uxAwDqayXJaGhz1RwVzBRpBk
         jzL130LY6kTv8sJFq7PgJ99l5dvQscTter8FlfteLVYRRnU9oEP2NVKrbjrHRLaHBFyn
         rbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681828334; x=1684420334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgfbRS38TgiTelC0++i/E8We2Hs+Q4ZVYsKtamXu3Ns=;
        b=A5mPjryNul4dsnU46s86OdvOeJutKRsdPiJ2P50K7l5tu+tNd2ba6+js7UqyjO5S5O
         +cSoDXz12g9lhMTYdzs76WAub1fZrFWkkEfW5Nho3knaDITT91cj9zvMMOMV191CqqVe
         kaCNp9OdeTpexLNzaRIEvgZnMn57twTCAWYckmQTlRi2LT9jJwkurg/Xe4j9nfQ21KGQ
         3FjKKls1tl6h6fPLIbUgf1ZzOJ5VDuKTTy+hsK39/a+d1sKuK/ONOAzWzWlhvG2OWCNz
         k2pYWpyT52aNIpxfXUgxs3O33Wbe61BpL6JSSoWh8TKyuYxGWLtnNKqUcI0TjIvLC4TJ
         C/gQ==
X-Gm-Message-State: AAQBX9cptRzcfs2/745t2K+1YCopACwzSuxe6WDbT/yJkdh1AasLw0z9
        DUm+hLXz822LNT5wHElD96GOJG9r098M51PY+A==
X-Google-Smtp-Source: AKy350a3VYddktuW7CsE51EjRZeTdAigH1TT5Ejc69BHAnf72WZ5NAhv27UstDcOMErSNOBB9b/8uA==
X-Received: by 2002:a25:5186:0:b0:b95:6cbb:dc5d with SMTP id f128-20020a255186000000b00b956cbbdc5dmr2188031ybb.17.1681828334314;
        Tue, 18 Apr 2023 07:32:14 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s1-20020a819b01000000b005461671a79csm3857063ywg.138.2023.04.18.07.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:32:14 -0700 (PDT)
Message-ID: <e29e6584-709f-d172-e73a-88a2027a9283@github.com>
Date:   Tue, 18 Apr 2023 10:32:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] fsck: check rev-index position values
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <adbe9c8ee90e087e864bd9e0c67338974b5dbc8d.1681748502.git.gitgitgadget@gmail.com>
 <xmqq1qkijhho.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq1qkijhho.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/2023 6:01 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  	if (!hashfile_checksum_valid((const unsigned char *)p->revindex_map, p->revindex_size)) {
>>  		error(_("invalid checksum"));
>> -		return -1;
>> +		res = -1;
>>  	}
>>  
>> -	return 0;
>> +	/* This may fail due to a broken .idx. */
>> +	if (create_pack_revindex_in_memory(p))
>> +		return res;
> 
> Here, if the revindex file itself is self consistent, res would
> still be 0, so we will end up silently returning.  Is the idea that
> while whatever causes in-memory revindex fail to be computed is a
> concern from the point of view of the repository's health, it would
> be caught elsewhere as a problem for the <pack,idx> pair we are
> seeing here?

This is something I noticed during a test suite run, where the .idx
was corrupt, so the .rev file could not be checked. In this situation,
we are not using the .rev file for anything since Git processes would
fail to lookup objects in the associated packfile.

In this case, we have no way to validate the rest of the .rev file's
contents, but at least we checked its header and checksum, which is
the best we can hope to do in this case.

Thanks,
-Stolee
