Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25713C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiLLNzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiLLNzS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 08:55:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAB1B58
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 05:55:08 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h16so8952280qtu.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 05:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7VhqtBh4YiBgzCtI0+befFbHN2mQiC09yedxD6XcOqc=;
        b=a9V76J4aCaikmKNvySujXjgvv2PTD21Vtk3INOCrvymAQI4gNjnKLdkhXxKHUajKYH
         YThclyu8rjkkMwbjP6Z3M3wqQk+AVWu8EoxIghk1HHV1VPRNdfOnvcv/pIZAhCMnUNCu
         JdGRhj/GgUlYzxjm9tsBOyuchpeMMFsnO40xnNYs8eMQveQ2/TbK38zE2FFEbsqrFWOG
         A2/lU0soR/eOczLvmh9VOdB8Pvt7U0JfM7bpNvubcoVcoKLdWuFDJhv5XueN5l7/OanN
         YuJEHYKgdXovtQr9f/CBPsU7uZD5ZKO+RQFUhhKQ3uo5l5E0VtgXFIqMQMju3usGOIrs
         Sv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VhqtBh4YiBgzCtI0+befFbHN2mQiC09yedxD6XcOqc=;
        b=DCVPW/kwQoKHSj3X/E3DLNhWmrzdjDYo9+7Jk6Yfhd3trFftELZgU8PSw1+CaXvZw9
         c+FLiUSg7WB9N5FJc/jkmbEc9q30LAiEmy0avAHl1tgiFuX7jR3NCf7xgnuwIxusa39x
         iZw52w1NHML1mgQZ+FJHuQh/YReiTh5P0sQCaMsjEIJTFYDYtK5JIFC0kplG2NMlWq/1
         qhrhtBpNQCllB6G/Q6MWwfxRlfUr5yLAip+1KvisHkWRMrdE9SjCJNrcsrSoxtUCMHWX
         OIIj6Sx/OvjK3DuerMiIa2UdWZ34bO0ghuLGkmPTIdt+R5LN6UB8s55IerCQH81MVUIa
         QgpQ==
X-Gm-Message-State: ANoB5plnAmO+wsMWCy9Mr5q8nVB6CgaTL3T4xFgPfqUtc5wNIc9L7T2f
        8yCdvWh5dqa3EMS0azzknZ7NVVbJedt7aUc=
X-Google-Smtp-Source: AA0mqf5wV4H4WRIyOwpOq1BqAIC5iMUz8xO+vhzR6mO9RrvDQfZg8rdDlHb6fsTf1CR99f6t4wgsrg==
X-Received: by 2002:a05:622a:250a:b0:39c:da20:d452 with SMTP id cm10-20020a05622a250a00b0039cda20d452mr22698335qtb.43.1670853307137;
        Mon, 12 Dec 2022 05:55:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:84c8:9ef9:1297:e16e? ([2600:1700:e72:80a0:84c8:9ef9:1297:e16e])
        by smtp.gmail.com with ESMTPSA id d12-20020ac8118c000000b0039492d503cdsm5758436qtj.51.2022.12.12.05.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:55:06 -0800 (PST)
Message-ID: <f07abb23-781b-8381-d839-ab21e725e625@github.com>
Date:   Mon, 12 Dec 2022 08:55:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: ds/packed-refs-v2 (was Re: What's cooking in git.git (Dec 2022, #04;
 Mon, 12))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfsdkspnl.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfsdkspnl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2022 8:43 AM, Junio C Hamano wrote:

> * ds/packed-refs-v2 (2022-11-07) 30 commits
>  - refs: skip hashing when writing packed-refs v2
>  - p1401: create performance test for ref operations
>  - ci: run GIT_TEST_PACKED_REFS_VERSION=2 in some builds
>  - t*: skip packed-refs v2 over http tests
>  - t3210: require packed-refs v1 for some tests
>  - t5502: add PACKED_REFS_V1 prerequisite
>  - t5312: allow packed-refs v2 format
>  - t1409: test with packed-refs v2
>  - packed-backend: create GIT_TEST_PACKED_REFS_VERSION
>  - packed-refs: write prefix chunks
>  - packed-refs: read optional prefix chunks
>  - packed-refs: read file format v2
>  - packed-refs: write file format version 2
>  - packed-backend: create shell of v2 writes
>  - config: add config values for packed-refs v2
>  - packed-backend: create abstraction for writing refs
>  - packed-backend: extract iterator/updates merge
>  - packed-backend: extract add_write_error()
>  - refs: extract packfile format to new file
>  - chunk-format: parse trailing table of contents
>  - chunk-format: allow trailing table of contents
>  - chunk-format: store chunk offset during write
>  - chunk-format: document trailing table of contents
>  - chunk-format: number of chunks is optional
>  - refs: allow loose files without packed-refs
>  - repository: wire ref extensions to ref backends
>  - config: fix multi-level bulleted list
>  - extensions: add refFormat extension
>  - read-cache: add index.computeHash config option
>  - hashfile: allow skipping the hash function
> 
>  Waiting for review.
>  Seems to break CI.
>  linux-TEST-vars
>  cf. https://github.com/git/git/actions/runs/3598165328
>  source: <pull.1408.git.1667846164.gitgitgadget@gmail.com>

Please eject this series. It was only an RFC on purpose, and
the first few patches have been replaced with a new series [1]
(which I will send a new version of soon)

[1] https://lore.kernel.org/git/pull.1439.git.1670433958.gitgitgadget@gmail.com/

Meanwhile, Keanen Wold and I are discussing with John Cai
about capacity around ref storage mechanisms. I also haven't
had time to do the deep-dive on reftable that I promised.

Thanks,
-Stolee
