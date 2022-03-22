Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35857C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 15:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiCVPTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiCVPTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 11:19:22 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DFA8878C
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 08:17:54 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bp39so2938729qtb.6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NQh33LntbK00pThF1qhPZi5V9Ggx/W82SWnhejyCRDA=;
        b=i99QPSUJvLbf4RbLXDHYJr3PMWRjwMqw1pJEo5tRVxGBgUBWy7MLNfzFmhwG4H3hL7
         /C3CP2GqoQm+671+Vd76qLNRdAO4ZQZ+89V/Vi23REQoFK/H56aSosg4pcXYSs13geCG
         7TFB0P2c9hE03H6E/4EsME4RA20pr1taiIafbV+GYr8iZS+wXBeeKdPDglWYYp5hURIg
         J+RrvJb7eTBbhPPhhlobj3aRTkitnFQdCcOKKnlc09sPI6A5MTU74my69Owyjv2F8wZX
         y09DE5tJda0BHPyRgoQVQa80zUQqeS1quS3YKzrvNXZaUDq47MDtYMCgB9FuIu1YzUl2
         PEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NQh33LntbK00pThF1qhPZi5V9Ggx/W82SWnhejyCRDA=;
        b=ceI/JUghg9umVSZ5pt9pFLPSHSAHVd5NBw+GiSrrIs/oA8m/nLkB5eOwz/BTxJcLjI
         1ASjmRpoz3R3t33An26Se7jXRgM4r5nuiQ9i8GB9Hovs5oyEVNY2BQmnxMkmEQDrIPZR
         F5+yu4BpTwuN6paGIfqKtmItdicnk0vqfcCKgSobNJg+DPVGXyUYiCCrhgSEJjZnNkNS
         jkQrCxjRBBDzsrYtZnUi6eT9q0Ni57Wh8MDcAqYd41BTv/Sj1aDYeeebSeI8VKsJFmI3
         ad2QUDZiGah31h4W3jiIxgvd/8ex5wqihu0NbzR4kI49M8ubBR7/RJS1SmOcvi1p3cOk
         AIug==
X-Gm-Message-State: AOAM530oG/gURrzTXLWQs/24E8lDtj9F+Y0hMfET04JJxfdN4Sy6yl8w
        PQMifgbCkkFaLG8+Nc81SFaL
X-Google-Smtp-Source: ABdhPJxWYOJWewb30Pi8I4OBCnpF/idA8w5mZqDOwhiwF8Du6bQ6JjAeRcz8bf5NKLCr/yyvyQ8fiA==
X-Received: by 2002:a05:622a:24f:b0:2e1:d658:a595 with SMTP id c15-20020a05622a024f00b002e1d658a595mr20439911qtx.657.1647962272410;
        Tue, 22 Mar 2022 08:17:52 -0700 (PDT)
Received: from [192.168.20.184] (GITHUB-INC.bear2.Charlotte1.Level3.net. [4.4.99.78])
        by smtp.gmail.com with ESMTPSA id n13-20020ac85b4d000000b002e227ddc3c0sm706011qtw.73.2022.03.22.08.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 08:17:52 -0700 (PDT)
Message-ID: <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
Date:   Tue, 22 Mar 2022 11:17:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/22 4:34 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The implementation of test_subcommand_inexact() was originally
> introduced in e4d0c11c0 (repack: respect kept objects with '--write-midx
> -b', 2021-12-20) with the intention to allow finding a subcommand based
> on an initial set of arguments. The inexactness was intended as a way to
> allow flexible options beyond that initial set, as opposed to
> test_subcommand() which requires that the full list of options is
> provided in its entirety.
> 
> The implementation began by copying test_subcommand() and replaced the
> repeated argument 'printf' statement to append ".*" instead of "," to
> each argument. This has a few drawbacks:
> 
> 1. Most importantly, this repeats the use of ".*" within 'expr', so the
>    inexact match is even more flexible than expected. It allows the list
>    of arguments to exist as a subsequence (with any other items included
>    between those arguments).
> 
> 2. The line 'expr="$(expr%,}"' that previously removed a trailing comma
>    now no longer does anything, since the string ends with ".*".
> 
> Both of these issues are fixed by keeping the addition of the comma in
> the printf statement, then adding ".*" after stripping out the trailing
> comma.
> 
> All existing tests continue to pass with this change, since none of them
> were taking advantage of this unintended flexibility.

For some reason, I thought I had run all tests on my machine to
passing, but I was wrong.

Instead, t7700-repack.sh fails because of this test:

test_expect_success '--write-midx -b packs non-kept objects' '
	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
		git repack --write-midx -a -b &&
	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
'

Specifically, "git pack-objects" has several options before
"--honor-pack-keep" including the temporary pack name and
a "--keep-true-parents" flag.

So, this patch is incorrect about keeping things working. The
options are:

1. Keep the repeated ".*" and be clear about the expectations.
   (This could drop the "remove trailing comma" line.)

2. Find another way to test this --write-midx behavior while
   keeping the stricter test_subcommand_inexact helper.

3. Something else???

Thanks,
-Stolee
