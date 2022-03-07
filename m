Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692BC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiCGOPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiCGOPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:15:07 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513F8A6EE
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:14:13 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so3070643otq.13
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wEVroOdxvgGNvSS9COvF8s0/VWddDVPUISGri3YGyyM=;
        b=i45WKOnDeBMwmksEUgU2kZDnJKBjV0FAkVqWL9wNMigU6EkKfGKn6SM9BPONIcegh1
         fv6/OtLmbaScdnuF+JRICIgoAAY4CtRvaqlc4152ueEC4316uFk8dDNIvvx3DOHwSKxf
         gGGwfSvJR1BR0Etm1Dy9el70zWcFRTjZj/LSJYUWs5FIgCjKELSEIskLchcr5iNKh3Tp
         ZyXsovSCTTjBQ+pZivZmDCD8RUQ4QByKjM9hWe6oHRdBdxBOkGWu1koitQrOIW1pedio
         YrlrwdHI5ok8QTmfOB9VLnGkWH0PQSFn9bSITislrk7o5vrvznrMbhHa84ud386Fl/Gp
         O9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wEVroOdxvgGNvSS9COvF8s0/VWddDVPUISGri3YGyyM=;
        b=CJjaI7mm13Ecv+0GWiOPLopoIjUI/F6PdeapXz//ixM7jdRhSDJFcHNmafjCxBOrl6
         iztpP0y4CTOZuQc1hsrXhEBx9d9cb7VgI5phD8pMEjjVu4XIroljzjBVmYpsD52ErBLI
         L5qgGsVg1ASdC0GgRr05g9AwdgQnWT8YJL/FV2Ijkh8BrnPGPciIoN7JuG2KJXCsbB6M
         T6Ev4bmDsENewuQKv8qvB6Hj9l0yE9sE9YXZWBuF66oHiPvLR0sRpVh+scEiR0Uvj/ar
         fqQKX//V4zgc3pXyqHtVKcpLSEg+2eoqT4sB0xKiOywn2rHLZDSVpMqVRzPlIhMaYpqV
         +7tg==
X-Gm-Message-State: AOAM53157U6MZ3WtGqlLjXIHij0MHB435hbsv1qhZQP+hcbtGVagBb5X
        v4zvaQ1gPEGN1TjyOa3uqfF/
X-Google-Smtp-Source: ABdhPJyTdilBFSkNt6wXInoZ7BQ9x8cjyC/H6V/6FU8mtTj1+jtjtc4YUWyt44CQI/wie2KL6uUueg==
X-Received: by 2002:a05:6830:1e91:b0:5ad:599a:96cb with SMTP id n17-20020a0568301e9100b005ad599a96cbmr5877642otr.329.1646662452678;
        Mon, 07 Mar 2022 06:14:12 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a14-20020a544e0e000000b002d97bda3874sm6307018oiy.57.2022.03.07.06.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:14:11 -0800 (PST)
Message-ID: <edb5897a-30f0-e5a6-1166-d03f5bdaeb47@github.com>
Date:   Mon, 7 Mar 2022 09:14:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 10/11] bundle: create filtered bundles
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
 <xmqq5yotxpdo.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq5yotxpdo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 6:35 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> A previous change allowed Git to parse bundles with the 'filter'
>> capability. Now, teach Git to create bundles with this option.
>>
>> Some rearranging of code is required to get the option parsing in the
>> correct spot. There are now two reasons why we might need capabilities
>> (a new hash algorithm or an object filter) so that is pulled out into a
>> place where we can check both at the same time.
>>
>> The --filter option is parsed as part of setup_revisions(), but it
>> expected the --objects flag, too. That flag is somewhat implied by 'git
>> bundle' because it creates a pack-file walking objects, but there is
>> also a walk that walks the revision range expecting only commits. Make
>> this parsing work by setting 'revs.tree_objects' and 'revs.blob_objects'
>> before the call to setup_revisions().
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
> 
> Now, the gem of the series ;-)

:D

>> +	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] ||
>> +	    revs.filter)
> 
> Did we need to wrap?  With these on a single line, the line is way
> shorter than the line with "because our hash algorithm is not" on
> it.

Perhaps I was thinking about having one line per "reason", which might
be extended in the future. But there's no reason to waste space right
now.

>> +	/*
>> +	 * Nullify the filter here, and any object walking. We only care
>> +	 * about commits and tags here. The revs_copy has the right
>> +	 * instances of these values.
>> +	 */
>> +	revs.filter = NULL;
>>  	revs.blob_objects = revs.tree_objects = 0;
>>  	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
>>  	object_array_remove_duplicates(&revs_copy.pending);
> 
> OK.  We prepare revs, and we save it to revs_copy, because we
> perform two traversals, one to determine which bottom commits are
> required to unbundle the bundle (which is done with the instance
> "revs"), and then later to actually enumerate the objects to place
> in the bundle (using "revs_copy").  Is there a reason why we need to
> remove .filter in order to perform the first traversal?
> 
> This is a tangent, but I wish we could reliably determine when we
> can optimize the first traversal away, by inspecting revs.  If there
> are any pending objects with UNINTERESTING bit, or members like
> max_count, max_age, min_age are set, we'd end up traversing down to
> all roots and the prerequisites list would be empty.

Noted for potential follow-up.
 
>> +	test_expect_success 'filtered bundle: $filter' '
...
> 
> OK.
> 
> It is somewhat curious why our bundle tests do not unbundle and
> check the resulting contents of the repository we unbundle it in.

I haven't checked your response yet, but hopefully this is answered in
the next patch which teaches Git how to unbundle bundles with this new
capability.

Thanks,
-Stolee
