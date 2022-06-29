Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F6C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 12:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiF2Mlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiF2Mll (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 08:41:41 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C415621E3F
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:41:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n10so8437043qkn.10
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A2oli/HUnMRs7PCLKkUH3mQbd3M13u7MsOLRyB5VeP0=;
        b=aGMfGHdhW3p2Pr3wMVYXIx2E4q+DbFvO6R4kcrnQkKO5iR16TAEnoLoLp+UqhQVyOA
         PhDCGveFgWC8517Qpk88rV+7uyeXNx9AeGW6qdmYpcexTmW+ixDmAuK5v1mHMww3/rGx
         z9RO0kabf5W2xP0cN2IoIUMKHIGokXYv6IEtkgA5PwTlXImn27GpYVJof3jbYZXoWqBB
         OQG7W/IdmtPjCbdrAjsxMZ1/EEw3gcOJvy2U9u3qrFNNMuVipFD5cJ4rjAwhLqUymrJV
         C8SWtvrQJeOPio4W/0GqUsXPeDPegkr6SYGDV/uIJhfPr8noPagZiHrPtwrGmSoZK+kC
         PFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A2oli/HUnMRs7PCLKkUH3mQbd3M13u7MsOLRyB5VeP0=;
        b=7ZSVTWtk/CCxmuR79ksiAoZHc5UYgqZBmAlOry8JfrSSnWFmy578GSOwwKlMr/nu0p
         7y9NLYcnAeBFTmVRROph+iRVRsuec6dQ8WGwUmbaWw0w1ieuVLBeuaoOtthgJ9QF4dTz
         MK7yh4HT31NcWg3W/G36wYy/8rXhgk6uC9pGZRkXXxpG84MFtgygq1VpImDkGVvAAGTs
         ksQBoxgUyT3IXg2b8phN2Ey5MR4Zqp10PtVkDYJ6hcpBODE9qeqfBzEsuqOTtApWZTBN
         5TMo3TzRWAnVdCVR9SvoYmxiZtXgGg7adjAolSY1F6BF7z4Cu50LuJJodkbV9n6p8HEv
         NRIQ==
X-Gm-Message-State: AJIora+szoJhpI/BRXhRhpfFSooh+5L4OU/T4wTZyBNCtkS5L80Fvb0t
        E1aCf1EMz0Y3H5q6CUoC+k4McffK7bZT
X-Google-Smtp-Source: AGRyM1s9UNwiqVsULQavMjAhu4CME3VLSEuBoZA4NePMSFIZj2WctNAMT43rDRh3Q0MelQgx/axFzw==
X-Received: by 2002:a05:620a:4111:b0:6a7:4b2c:a1c8 with SMTP id j17-20020a05620a411100b006a74b2ca1c8mr1789668qko.166.1656506499821;
        Wed, 29 Jun 2022 05:41:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b006a67d257499sm9245399qkb.56.2022.06.29.05.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 05:41:39 -0700 (PDT)
Message-ID: <aadf5592-c1aa-89ce-5637-d18af7ab45b4@github.com>
Date:   Wed, 29 Jun 2022 08:41:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
 <35e1e681-2666-a7fd-9b30-05a78ae9e957@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <35e1e681-2666-a7fd-9b30-05a78ae9e957@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/22 5:27 AM, Phillip Wood wrote:
> On 28/06/2022 21:02, Derrick Stolee via GitGitGadget wrote:
>> There are also a few minor cleanups in the process, including those
>> found by reviwers.
> 
> Not worth a re-roll on its own: s/reviwers/reviewers/

Thanks!

>> -git rebase has two primary backends: apply and merge.  (The apply
>> -backend used to be known as the 'am' backend, but the name led to
>> -confusion as it looks like a verb instead of a noun.  Also, the merge
>> +`git rebase` has two primary backends: 'apply' and 'merge'.  (The 'apply'
>> +backend used to be known as the `am` backend, but the name led to
> 
> I think we should keep single quotes around "am" as it is being used as a name like 'apply'

Thanks for your keen eye here. I searched the doc for all uses
of "apply" and "merge" to evaluate this quoting, but missed this
use of "am".

Thanks,
-Stolee

