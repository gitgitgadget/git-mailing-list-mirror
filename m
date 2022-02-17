Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00322C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiBQUhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiBQUhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 15:37:17 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FD1029C1
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 12:37:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so9946361ejb.13
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=clM9z9uymqrTfWjpbNXoRZlaN/9hIGj6NvmrgYta3Xg=;
        b=E21/K80BpKIr4BUbpmddObJRMpjpUDYbrDAhbSFG4Ca8uSwmDnlBUm86etDqnRQ1jV
         k/sKGy7qxHXYBpT/qFnkUHc5PLwQ98dC1K7nhpmhux05ahRPWNA6SrrHUunaEyuCY8+F
         HDS47KVNO/UsUDw5F8e6kiVk7DRn6M9ob+M6ScWlttudpjiBVHhVd1bs1gikvPi9ZJu0
         l5MHUJ/+PpH32aREcvxVUY8t8JFxOrFK8GDxbHneaJyVykuga3rlm2G+UGJ7uywvshoq
         +SzGo98/bycwPNbOyp+4P5HJGzE4wj768BTQGLM5UmIbcz20ciHyywpQWFtgrWb4b5bx
         7hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=clM9z9uymqrTfWjpbNXoRZlaN/9hIGj6NvmrgYta3Xg=;
        b=uSeSEtgFJ2YeWcNFlyUDHZpm1XIyxxrOPQcioBumR2ePgKM6yWKsJEaAP0wPKwEDMI
         8JpcqZmT1kE9iG0GOWnFDEcihyvdE8LNbIF+8OG4VIOuLlwOlZW7FUGkX6nz/ui8j5in
         TcibAHBbQw9yzbmAZNDEpBuzQnXN5TXM6HUIj29tS4r+KcnRl7V7NARcRMEhiC4yarn2
         LUKaPSKmPhfaMgJyKEBYKQ6BZy2Xu7L9rDSEponXWfMEH5rAgk32BfP0F1kC6KNAg6Lf
         GaDdcErdnEahMO9rg1rnxVgZOscSIfHWaxZNVZGyB2O+e/yJ7ybebMDLWktDi7d1blHg
         TzKQ==
X-Gm-Message-State: AOAM531rxWtKVn4CX/bDajR2bbSf9EAm7DNXvWykcE4bMV3/jHvc8APB
        57I1dNNzu0stqDLJZ5fqutY=
X-Google-Smtp-Source: ABdhPJzBzHEt2RYxauYqlpj1/6+h3J1fOjGWXnyFyQhgULtYBglrweStQuXZ9MKVHY9YToKyT8eeBA==
X-Received: by 2002:a17:906:3cb1:b0:6ce:2a97:5ade with SMTP id b17-20020a1709063cb100b006ce2a975ademr3736746ejh.728.1645130219829;
        Thu, 17 Feb 2022 12:36:59 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id bh3sm1535450ejb.102.2022.02.17.12.36.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 12:36:59 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Robert Coup <robert.coup@koordinates.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tests for repack --filter mode
Date:   Thu, 17 Feb 2022 15:36:57 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <6BD2011A-9CD7-488C-8F17-F78FE59E93C7@gmail.com>
In-Reply-To: <CAFLLRp+9TmMKu5UpaN4sUr+o_9AGAVvtis0e87VMJsCva67q3w@mail.gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <d76faa1f16e8b5f8eb13284fdb162525fcbcb22e.1644372606.git.gitgitgadget@gmail.com>
 <CAFLLRp+9TmMKu5UpaN4sUr+o_9AGAVvtis0e87VMJsCva67q3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rob,

On 17 Feb 2022, at 11:14, Robert Coup wrote:

> Hi John,
>
> Minor, but should we use oid rather than sha1 in the list.sh/upload.sh
> scripts? wrt sha256 slowly coming along the pipe.

good point, I'll make those adjustments.

>
>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>> index e489869dd94..78cc1858cb6 100755
>> --- a/t/t7700-repack.sh
>> +++ b/t/t7700-repack.sh
>> @@ -237,6 +237,26 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
>>         test_must_be_empty actual
>>  '
>>
>> +test_expect_success 'repack with filter does not fetch from remote' '
>> +       rm -rf server client &&
>> +       test_create_repo server &&
>> +       git -C server config uploadpack.allowFilter true &&
>> +       git -C server config uploadpack.allowAnySHA1InWant true &&
>> +       echo content1 >server/file1 &&
>> +       git -C server add file1 &&
>> +       git -C server commit -m initial_commit &&
>> +       expected="?$(git -C server rev-parse :file1)" &&
>> +       git clone --bare --no-local server client &&
>> +       git -C client config remote.origin.promisor true &&
>> +       git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
>
> Does writing bitmaps have any effect/interaction here?

Currently writing bitmaps don't play well with promisor objects. If I'm reading
the code correctly, it seems that when we build a bitmap with
bitmap_writer_build(), find_object_pos() gets called and will complain if an
object is missing from the pack.

We probably need to do the work to allow bitmaps to play well with promisor
objects.

>
>> +       git -C client rev-list --objects --all --missing=print >objects &&
>> +       grep "$expected" objects &&
>
> This is testing the object that was cloned initially is gone after the
> repack, ok.
>
>> +       git -C client repack -a -d &&
>> +       expected="$(git -C server rev-parse :file1)" &&
>> +       git -C client rev-list --objects --all --missing=print >objects &&
>> +       grep "$expected" objects
>
> But I'm not sure what you're testing here? A repack wouldn't fetch
> missing objects for a promisor pack anyway... and because there's no
> '^' in the pattern the grep will succeed regardless of whether the
> object is missing/present.

Good point. I overlooked the fact that by this point in the test, repack has
already written a promisor file. I think I'll just remove these last couple of
lines.

>
> Rob :)
