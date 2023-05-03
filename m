Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A552C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjECRbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjECRbo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:31:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0FBF
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:31:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4efd6e26585so6400497e87.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683135072; x=1685727072;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smMHwmYSMyFI8truzw66tQjjXgEWIOwrxGL1ZnXD+F0=;
        b=NxstQHvxRVotkI6WMRQDgCknSTEnr7hlq8rliadettA2eoJ7pTqTuT4MHTgxic/KT8
         bosQ8AdFm7mHka6VRYGmLRCR2V3av2FcZSd0OqfJ7H6VbGMq84pp4AkpvebZkOFOOwMg
         HZUKCECSqxDubwpMWlGVWM9ztj5KvuNZDYJhQZfEaTTwwhQtzacqDTRZK9O4Tv4k7Q6E
         AZC96IOGEKNx4CvCfwUqUyS0MhVljS0qdizmkfUPN2qtRrtfN/thlwNgKvr5OHtQta2y
         m2Pk92wjAtSv+ypVQnUvEAZSvcAaukCznO7xfF9HCp1nTSYJFUz6euq+bW5M+TiDzWsI
         ExcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135072; x=1685727072;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smMHwmYSMyFI8truzw66tQjjXgEWIOwrxGL1ZnXD+F0=;
        b=YOiGemyIXv6m3JqhMzu1v4MCUiQXbNWizflk2laHJri3MA3w313CTN1osE/wrd5vX8
         3WFAPa7P0r65Z64N+lYJnoenpzYC1tzVjBzXjGRtasfgD9YVnkBO6DknDExKtVGrUwsW
         tu2wddMQ9ddKZBdJjVr8Nu7pqYqkvjaWAGl0CnnTFlQmsLQmrSPo9ReKdybc7MB51mRC
         xQ/CahnSVny+BayOjfF3WtyYQCA786r/yK/wxGrh1t9qR9UIQkFRevm/1G2cbjdG/Mbj
         kHPzSJNIBKp58SPmtl/PCwA4wAxJ6bofLl1wgeshl5UCxxsBLbLDoqlbOXMiLXVhqocZ
         4j4g==
X-Gm-Message-State: AC+VfDwb/qujrhcETuAO3VoWlXQVMOGY5z3aRblRcG0yyZxXmpTlTiJy
        Q2awJVlmd8oPwIDxGH3HT9h1iFMcXLA=
X-Google-Smtp-Source: ACHHUZ78WC6jZ+DwBbphCci6k+1V305MfPyTq9ZhHvL+l2OnBCJOxOa9lWLZpr8hHhONptb14qOiPQ==
X-Received: by 2002:ac2:508b:0:b0:4eb:dd2:f3d2 with SMTP id f11-20020ac2508b000000b004eb0dd2f3d2mr1307043lfm.43.1683135071733;
        Wed, 03 May 2023 10:31:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g6-20020ac25386000000b004edb2cb3500sm6052966lfh.279.2023.05.03.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:31:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g>
Date:   Wed, 03 May 2023 20:31:10 +0300
In-Reply-To: <xmqqsfcdtkt0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 09:57:15 -0700")
Message-ID: <874jote2zl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> --patch followed by --no-patch is to be a no-op according to the "git
>> log" manual page.
>
> I briefly wondered if it is a bug in the documentation.  But it is
> clear (at least to me) that "git log -p --stat --no-patch" wants to
> show only "--stat", and when "git log -p --raw" shows both patch and
> raw, I do not think of a reason why "git log -p --raw --no-patch"
> should not behave similarly.
>
>> Add a test_expected_failure case for the issue.
>
> That is unsatisfactory, though.  Can you back-burner it and send in
> a fix with the same test flipping expect_failure to expect_success
> instead?

No problem from my side, but are you sure?

 - test_expect_failure [<prereq>] <message> <script>

   This is NOT the opposite of test_expect_success, but is used
   to mark a test that demonstrates a known breakage.

Don't we need exactly this in this particular case? Demonstrate a known
breakage?

I'm confused.

>
> Thanks.
>
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  t/t4013-diff-various.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 5de1d190759f..f876b0cc8ec3 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -457,6 +457,17 @@ diff-tree --stat --compact-summary initial mode
>>  diff-tree -R --stat --compact-summary initial mode
>>  EOF
>>  
>> +# This should succeed as --patch followed by --no-patch sequence is to
>> +# be a no-op according to the manual page. In reality it breaks --raw
>> +# though. Needs to be fixed.
>> +test_expect_failure '--no-patch cancels --patch only' '
>> +	git log --raw master >result &&
>> +	process_diffs result >expected &&
>> +	git log --patch --no-patch --raw >result &&
>> +	process_diffs result >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>>  test_expect_success 'log -m matches pure log' '
>>  	git log master >result &&
>>  	process_diffs result >expected &&

Thanks,
-- Sergey Organov


