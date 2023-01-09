Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C9C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 14:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjAIO7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 09:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjAIO67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 09:58:59 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE5D1582C
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 06:58:58 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id m12so4299990qvt.9
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQAXzfew6rXhUZNY0DNAs4QspsanvViQnwfAtsQL9B8=;
        b=fdJK0j7rG2vJB8VjAa4uCNN07DesmXl0S3dn4aKDPFmjx70mYCSs67qMtemKpCX5Ta
         q7LuAeuRKYMfQQSYV/y+gcte/XGy+XhkSuUkq8rU1QzOmKJh8hSUsIehfa8QVW/sa0Qw
         SIobTbkPkOVko+mbPRjzU4hLBhSg69P6xj+fG5CKOSGiRDXYZRKHbM/eoHYQQglpGEe9
         mbQ8PxBlnH0ogO6ngoiYfxEudhrqCIAlKVAkOVHOgCY8WrnmTsk5jBuAFQTyRjjmE7mw
         b/s9Yi2zXX0Nx2pTNQFYMkyYm82lUF9pHPGdCNXgmIz27RgXWGvhKjL7R0CjlW2VLWmE
         mF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQAXzfew6rXhUZNY0DNAs4QspsanvViQnwfAtsQL9B8=;
        b=VrzUtJIxyobkAZidrbZLUAtfSk5uLCdmbkMQ3CUyLBnPVBVDSu9I9bvjoYST2rmg7K
         X9dut2KaUiWiw6x3WGi/hVemJ2m6QmpFrVQUBhd4GnA6+eoXU0LienArzB+yu6hmQMy3
         QZkT8S4cHER8dCBQwV1OT60Gx3znOEA30HXvLg9EwzMn9mDXprZBITmogqUc0hRJMUfS
         Lf1Ae4Gz/9u00eG1mBgBs5zdGM5cO3PDBIFQiDXfRqeVcnU+Kk20SKnkL4qlX35nWSXK
         i4dNVXsG5yKngKZCR8bxoAd61qvcfY2qPS+xWvZBV+041fbRBlNYY9hBAOembGD8UeN4
         B5NA==
X-Gm-Message-State: AFqh2kon3QX30paNE0O0vgx9+Lt02E9TvFbOHwgZU+fkMkdntYZqtQRK
        GMsFw0yxgTZsEr4z6B6fQIav
X-Google-Smtp-Source: AMrXdXu0j/2E0b3ocer/7EkDYA7PldWOqzGNLqaH9Q8rTRtPW0DSR4WRd1larKc5ooE6LUhs2C8f9g==
X-Received: by 2002:a05:6214:5c83:b0:4c7:b9b:eaa8 with SMTP id lj3-20020a0562145c8300b004c70b9beaa8mr89696866qvb.43.1673276337122;
        Mon, 09 Jan 2023 06:58:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9803:bdc5:6740:d9fa? ([2600:1700:e72:80a0:9803:bdc5:6740:d9fa])
        by smtp.gmail.com with ESMTPSA id bq11-20020a05620a468b00b0070209239b87sm5442453qkb.41.2023.01.09.06.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:58:56 -0800 (PST)
Message-ID: <9ac62cc6-db13-9a39-b3fd-a76311bdf92d@github.com>
Date:   Mon, 9 Jan 2023 09:58:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] bundle-uri: download in creationToken order
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
 <xmqqtu10wfwt.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu10wfwt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2023 10:22 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +struct sorted_bundle_list {
>> +	struct remote_bundle_info **items;
>> +	size_t alloc;
>> +	size_t nr;
>> +};
>> +
>> +static int insert_bundle(struct remote_bundle_info *bundle, void *data)
>> +{
>> +	struct sorted_bundle_list *list = data;
>> +	list->items[list->nr++] = bundle;
>> +	return 0;
>> +}
> 
> Especially given that the type of the list claims it to be "sorted",
> insert_bundle() is a misleading name for a helper that merely
> appends to it to make the list (tentatively) unsorted.
> 
> I am not opposed to "append all to make an unsorted list, then sort
> the list at the end" strategy.

...

> If I were doing this patch, I would call the type of the list of
> bundles "struct bundle_list" (without "sorted_" in its name), and
> name the variable of that type used here "sorted".  That would make
> it more clear that this particular bundle list starts its life as
> unsorted (with "append_bundle" function adding more elements) and
> then gets sorted in the end, from the above several lines.

Since "struct bundle_list" is taken, how about "bundles_for_sorting"
since that's the purpose of this struct (to be passed as data to
the for_all_bundles_in_list() and then to QSORT()).

Renaming insert_bundle() to append_bundle() is clearly better.

>> +static int compare_creation_token(const void *va, const void *vb)
>> +{
>> +	const struct remote_bundle_info * const *a = va;
>> +	const struct remote_bundle_info * const *b = vb;
>> +
>> +	if ((*a)->creationToken > (*b)->creationToken)
>> +		return -1;
>> +	if ((*a)->creationToken < (*b)->creationToken)
>> +		return 1;
>> +	return 0;
>> +}
> 
> Usually compare(a,b) returns the sign of (a-b), but the returned
> value from the above is the opposite.  This is because we want the
> list sorted from newer to older?  It may help developers to name
> such a (reverse) "compare" function differently.

Would renaming this to "compare_creation_token_decreasing" be clear
enough? (Plus a doc comment.)

Thanks,
-Stolee
