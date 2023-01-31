Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D233DC636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 19:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAaTbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 14:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAaTbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 14:31:13 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3611CAC1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:31:11 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1685cf2003aso383485fac.12
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrnffpXq5afl1wAWETrqtKp5cIVaZRQt7tiCP7Y848s=;
        b=jnjNHf3bGTzlUhyQ4ZvJSKcSbWCz1U2cYya/gpnR3KeEJBOen82XM5/9yUJhuGfERv
         3M4nwhNO3BlflXascmyJbLWCL4swHUkQDxVdu6qVcaJKaYswaLl9uw9qAonHZo4U+UMN
         jPa4AeTVpqLECNocRCNz+cXnigskds2F8QEnwvxZazmwhrA6rNYXtwNCkeAK2LnMYZFF
         wcHsx6JcxDcdCrxm7Epup0+LTuzh2xXfymCywnfZ/W7nRWYc/jsSYDd1Ufn7zRUd+NnB
         xrNA4CwiLH56pLh0SxLzJU9hLhr/QSofRp9UtlqNKkbosj6byouJM86Q+23iudKj7UJ8
         aiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrnffpXq5afl1wAWETrqtKp5cIVaZRQt7tiCP7Y848s=;
        b=lIkciZLMK2vaUp6FSuHqt/O4s7AUtIRR8cjl9NHdWrwh5dx+0PQ9DhZTgEG2oG0ce4
         a5/bI01rYEu51fm4BRV3O1bLApuSMNJljswsem3EaGlkYQ/akFPa1fKCV1C+Xr0R5QRF
         h52jaK2eDBQei9ON0RlniuGbJOnlEsh4n0Bi0tbRCrebvWdA49mz9MggoBPFO8iXkIvJ
         C/q+drZ6gbqF68nPXTB93yDzM+QK0O/gWJZYnmT6xt+SpEOCYnmojU9DLF31xuYXwn44
         3X2xC72Ypdwv4bWAGiuhfLyVH3Xip7jC+In4Vxv4bsqf/IyPZ5Ef+JKXQDPU4wi/lThu
         QsVA==
X-Gm-Message-State: AFqh2ko8RgrIYlASWs7GfOpliFRszOfVchG9ciH6+UfvUC1HQXqFI83z
        Q4Hc+OnBSOcixDHhTE3sW3V4
X-Google-Smtp-Source: AK7set9fsOGuh/bzvrljJKjJNN90ZlfMknTGpUsWr4qM/fuq60t7VAk9aHuVBh1adEw0NBBbsPBBNA==
X-Received: by 2002:a05:6870:a454:b0:160:bcee:d00e with SMTP id n20-20020a056870a45400b00160bceed00emr17227777oal.59.1675193470406;
        Tue, 31 Jan 2023 11:31:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f9e1:e62d:37a9:9e46? ([2600:1700:e72:80a0:f9e1:e62d:37a9:9e46])
        by smtp.gmail.com with ESMTPSA id pv10-20020a0568709d8a00b00152c52608dbsm6946832oab.34.2023.01.31.11.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:31:09 -0800 (PST)
Message-ID: <73c1d863-036b-81bb-50d3-2a084c2c2fb5@github.com>
Date:   Tue, 31 Jan 2023 14:31:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 02/11] bundle: verify using check_connected()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
 <20c29d37f9c1ba1367145331d25dd27f966312cd.1675171759.git.gitgitgadget@gmail.com>
 <xmqqr0vay5cz.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqr0vay5cz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/31/2023 12:35 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> +	/* TODO: preserve this verbose language. */
> 
> I am lost -- aren't we preserving the BUNDLE_VERBOSE code below?

Sorry, I put this in so I wouldn't forget to test that the
verbose message sticks, but I did forget to remove it.

>> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
>> index 38dbbf89155..7d40994991e 100755
>> --- a/t/t6020-bundle-misc.sh
>> +++ b/t/t6020-bundle-misc.sh
>> @@ -595,14 +595,14 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
>>  		# Verify should fail
>>  		test_must_fail git bundle verify \
>>  			../clone-from/tip.bundle 2>err &&
>> -		grep "Could not read $BAD_OID" err &&
>> -		grep "Failed to traverse parents of commit $TIP_OID" err &&
>> +		grep "some prerequisite commits .* are not connected" err &&
>> +		test_line_count = 1 err &&
>>  
>>  		# Unbundling should fail
>>  		test_must_fail git bundle unbundle \
>>  			../clone-from/tip.bundle 2>err &&
>> -		grep "Could not read $BAD_OID" err &&
>> -		grep "Failed to traverse parents of commit $TIP_OID" err
>> +		grep "some prerequisite commits .* are not connected" err &&
>> +		test_line_count = 1 err
>>  	)
>>  '
> 
> Especially with the new test added in the previous step, we know we
> are not trading correctness off.  Excellent.
> 
> I wonder how much the performance hit does this version incur over
> the "not safe at all" version and over the "use custom and
> stricter-than-needed" version, by the way?

I was able to simulate this in an extreme situation by taking a clone
of the normal Git fork, creating a ref at every first parent, then
creating a bundle of the difference between git/git and gitster/git.
Finally, I compared the performance of 'git bundle verify' on Git
compiled before this change and after this change:

Benchmark 1: old
  Time (mean ± σ):     324.7 ms ±   7.5 ms    [User: 228.0 ms, System: 95.7 ms]
  Range (min … max):   315.3 ms … 338.0 ms    10 runs
 
Benchmark 2: new
  Time (mean ± σ):     331.2 ms ±  20.2 ms    [User: 230.6 ms, System: 99.7 ms]
  Range (min … max):   302.8 ms … 360.2 ms    10 runs
 
Summary
  'old' ran
    1.02 ± 0.07 times faster than 'new'

So, there is a performance difference in the two situations, but it
is very slight, in what I can detect.

Of course, there is the case where the behavior differs because of
the more permissible behavior, but I expect the old algorithm to be
slower than the new case, because check_connected() can terminate
with success (due to seeing all the prerequisite commits) faster
than the old walk can terminate with failure (due to walking all
reachable commits).

Thanks,
-Stolee
