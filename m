Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CE4C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 13:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiBYNyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbiBYNym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 08:54:42 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00421D307D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:54:09 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q5so7476211oij.6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pX+Iu+HH6JGrLGB7dNh8R5RyutAYOu9JSCFR5ZCdY4g=;
        b=Rygr4JRyoC92losSjdDrcVC+OJnfw2QqiAZdmGwSrL5K6WjacONRkuMWheziPy5ovp
         jRlmUUgJoPVY+nrI1q7dS4Wfn+xql057l92tePhfaHg+0nqLJ1CwbuS7QmzTodNSo6cb
         Mf96YsHhDbYTtmDOVPRJYYiOv3UHlFDumZgo5YHbqZdl2+H1xezvwbe1B/AF6LPFLtuC
         iiKFlVUGHJ2Jcr6OcP22THuOmRf/W3CZdo/WNLo07NEqEEVoLSNG2NknxZYWfIVTHJFv
         D6Tic4nso8c8Jg65ih/n3ci8Z7cyWJBuo2s9GoncKgYktGDiXRSyb63jsuUQEQW046ti
         93Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pX+Iu+HH6JGrLGB7dNh8R5RyutAYOu9JSCFR5ZCdY4g=;
        b=ShwFFc4KoCN+dA+hP7KN6tiU6CI0pgl8hctm4wzc9F4zJnl9ArbU1rX4e8yvY4GVlY
         DV2zDnFmPd1k/pDbZiaWuWweyTzX3/1KpgSzggiNbdRP/VFFxl7tuhX2+feaPxE121F4
         d56KuCBvVYMnCkiUhpe+fBj6Sd6xz44lOo2BFYEZSwzgasDC8Mo+zoaw08EqIbst2/VZ
         EU5wBAuRwpTNz3XrtKcxH0bdURKx11cfgGTtFMiIvk+o8eNZmJJ4oCJtvk6jgTRsi7hQ
         FbxdjmjAuvn6MiKa+HSQJi1Rfjgw1n0lWfVXqvyvuLoGANB2HK50Iae9sdjq1gjS40d9
         meIg==
X-Gm-Message-State: AOAM5320bBxYrdERJCQ0ULl3IY7M7rZjrl34ZtFSBi9uI1aQ/FbKk95v
        sDDYo8Ltthdp3GgGFpVZlHMm
X-Google-Smtp-Source: ABdhPJwjGc9f1B+QwaSrt2iAm0eMrnkP3ykzjBeoU5uv21uOlGa1VRw1bbCJD27dtl0KKDGWBIr6Og==
X-Received: by 2002:a05:6808:2101:b0:2d4:a0e5:68d3 with SMTP id r1-20020a056808210100b002d4a0e568d3mr1569016oiw.303.1645797249363;
        Fri, 25 Feb 2022 05:54:09 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i8-20020a4ad388000000b0031be0573b59sm1121990oos.5.2022.02.25.05.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:54:09 -0800 (PST)
Message-ID: <a78f0808-3a58-3bab-c958-ee623b2c43fc@github.com>
Date:   Fri, 25 Feb 2022 08:54:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 6/7] commit-graph: parse file format v2
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <28fe8824ba71ff9cda5ec5c034b6a6fb3c857654.1645735117.git.gitgitgadget@gmail.com>
 <xmqq1qzrkgxg.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq1qzrkgxg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 6:01 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The commit-graph file format v2 alters how it stores the corrected
>> commit date offsets within the Commit Data chunk instead of a separate
>> chunk. The idea is to significantly reduce the amount of data loaded
>> from disk while parsing the commit-graph.
>>
>> We need to alter the error message when we see a file format version
>> outside of our range now that multiple are possible. This has a
>> non-functional side-effect of altering a use of GRAPH_VERSION within
>> write_commit_graph().
>>
>> By storing the file format version in 'struct commit_graph', we can
>> alter the parsing code to depend on that version value. This involves
>> changing where we look for the corrected commit date offset, but also
>> which constants we use for jumping into the Generation Data Overflow
>> chunk. The Commit Data chunk only has 30 bits available for the offset
>> while the Generation Data chunk has 32 bits. This only makes a
>> meaningful difference in very malformed repositories.
>>
>> Also, we need to be careful about how we enable using corrected commit
>> dates and generation numbers to rely upon the read_generation_data value
>> instead of a non-zero value in the Commit Date chunk. In
>> generation_numbers_enabled(), the first_generation variable is
>> attemptint to look for the first topological level stored to see that it
>> is nonzero. However, for a v2 commit-graph, this value is actually
>> likely to be zero because the corrected commit date offset is probably
>> zero.
> 
> I see references to OVERFLOW_V3 that comes after OVERFLOW, but there
> is no OVERFLOW_V2.  Intended, or should it be V2 to match the "file
> format v2" of "generation number v2"?  It is getting awkward to have
> two different version scheme ("gen v2" means corrected committer
> timestamp, whose on-disk representation is different between "file
> v1" and "file v2", and this OVERFLOW vs OVERFLOW_V3 is about the
> difference between "file v1" and "file v2" if I am following the
> series correctly).

You're right that it would be clearer to rename OVERFLOW to
OVERFLOW_V2. I'll add that to my next version when these patches
appear on their own.

Thanks,
-Stolee
