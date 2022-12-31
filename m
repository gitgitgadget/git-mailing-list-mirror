Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAC8C3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 14:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiLaO4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 09:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLaOz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 09:55:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB271110A
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:55:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso15398739wmb.3
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/GSEMEDMrQ3oH30498JTOBRlFjale9Rq3XJFSQV8QE=;
        b=PGu5qdFYIGMg5OBG8PeyUF6V0YS5dBPPfuL4Pu5q1QXa2CtAiEznIHcIDf7W3LShN1
         nQI1AFtRjkUdfJG4Rgmw2DeVOUgWmch/Vy91eYgJgBomrJ25cf/e1h+k8VmSPwemD0fU
         xItt5YZWETfBD+5+t9NsnMUU45LS94x6JIb9mCB7tjXbYj6s9gWsb6f+vM7HsyMSzPLf
         x/zSJEfXyiFcqAtrhRa7NI8rzsLtJcQpuwRQqlHF3V4k8C6gAX6ujChtRCJuTi13kVpg
         1mB+g0Hbq7hbM4CHR6wXXPqrMdNDQ9VU6SUhsHKm9iozB7vbjicfq3IjzZQwF1bR2fvn
         O/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/GSEMEDMrQ3oH30498JTOBRlFjale9Rq3XJFSQV8QE=;
        b=nWh33tte93oiBvC/cqrnCOKJE2iCRWWmdRxtO2VdU8LApxwrf/3xpZt9YD3Fab0mSU
         wntxGmEIJHCRZmtpY1v9GI6RAJiUXPi16SIEUHSzcZoqrKc69ozDfYTTeDCki2lANcNg
         hrXvL/XASR8M6EABQSIqMKrUDkR+GZRfXXdZTYsZ0ijka7u0h39AohDnLDyVTMuGRTpp
         nMMxKWtgnUgsOnHd8YGOafShAREotqYlRRNU5QSKvqzvIp5q35WHgpNxSxcx3aVEB+Zw
         YLMmgQmD/KkC1t8R7PgMuOk8jOnKdvpmsLAm2dyoZVz197X4jNJScMFa1Gijxt/zsB3F
         bDPQ==
X-Gm-Message-State: AFqh2krMXL5pLNikc6EWfPvT2jHz0D7yEi2y4W+hBpRGVGq5x//YJoFa
        PtZS7U2vgy9a0EYSOLpKszg=
X-Google-Smtp-Source: AMrXdXvNiQWrlKwNZF7Nfr4STuIM6xnPEPYoaJEa3ge00FQSLbl7CGCLEbXHIt5xPAZL0+ds1+GACA==
X-Received: by 2002:a05:600c:16c5:b0:3d1:f687:1fd0 with SMTP id l5-20020a05600c16c500b003d1f6871fd0mr25129443wmn.12.1672498556530;
        Sat, 31 Dec 2022 06:55:56 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003d1f2c3e571sm40711192wmq.33.2022.12.31.06.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 06:55:56 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cacace0b-822a-e4fe-2d01-cb0058f83fd9@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 14:55:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/10] builtin/revert.c: fix common leak by using
 replay_opts_release()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-05.10-e2895bb9795-20221230T071741Z-avarab@gmail.com>
 <3a823d76-9ea3-d6a0-c9ed-9e84fe57042c@web.de>
In-Reply-To: <3a823d76-9ea3-d6a0-c9ed-9e84fe57042c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/12/2022 23:37, René Scharfe wrote:
> Am 30.12.22 um 08:28 schrieb Ævar Arnfjörð Bjarmason:
>> Use the replay_opts_release() function introduced in a preceding
>> commit to fix a memory leak in run_sequencer().
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>   builtin/revert.c                  | 1 +
>>   t/t3419-rebase-patch-id.sh        | 1 +
>>   t/t3425-rebase-topology-merges.sh | 2 ++
>>   t/t3501-revert-cherry-pick.sh     | 1 +
>>   t/t3502-cherry-pick-merge.sh      | 1 +
>>   t/t3503-cherry-pick-root.sh       | 1 +
>>   t/t3506-cherry-pick-ff.sh         | 1 +
>>   t/t3511-cherry-pick-x.sh          | 1 +
>>   8 files changed, 9 insertions(+)
>>
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index e956d125a2b..2f656b25619 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -240,6 +240,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>>   		cmd == 's' ? sequencer_skip :
>>   		sequencer_pick_revisions;
>>   	ret = cbfun(the_repository, opts);
>> +	replay_opts_release(opts);
> 
> Is this the right place for this call?  opts is passed in by this function's
> two callers.  They should clean it up instead, no?  That would add one line,
> but avoid the need for patch 4.  Would make patch 6 easier to read as well.

Yes I agree that would be a better approach.

Best Wishes

Phillip

>>   	return ret;
>>   }
>>
>> diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
>> index 7181f176b81..6c61f240cf9 100755
>> --- a/t/t3419-rebase-patch-id.sh
>> +++ b/t/t3419-rebase-patch-id.sh
>> @@ -5,6 +5,7 @@ test_description='git rebase - test patch id computation'
>>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>
>>   scramble () {
>> diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
>> index 63acc1ea4da..a16428bdf54 100755
>> --- a/t/t3425-rebase-topology-merges.sh
>> +++ b/t/t3425-rebase-topology-merges.sh
>> @@ -1,6 +1,8 @@
>>   #!/bin/sh
>>
>>   test_description='rebase topology tests with merges'
>> +
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>   . "$TEST_DIRECTORY"/lib-rebase.sh
>>
>> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
>> index 1f4cfc37449..2f3e3e24169 100755
>> --- a/t/t3501-revert-cherry-pick.sh
>> +++ b/t/t3501-revert-cherry-pick.sh
>> @@ -13,6 +13,7 @@ test_description='test cherry-pick and revert with renames
>>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>
>>   test_expect_success setup '
>> diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
>> index 5495eacfec1..1b2c0d6aca6 100755
>> --- a/t/t3502-cherry-pick-merge.sh
>> +++ b/t/t3502-cherry-pick-merge.sh
>> @@ -11,6 +11,7 @@ test_description='cherry picking and reverting a merge
>>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>
>>   test_expect_success setup '
>> diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
>> index 95fe4feaeee..76d393dc8a3 100755
>> --- a/t/t3503-cherry-pick-root.sh
>> +++ b/t/t3503-cherry-pick-root.sh
>> @@ -5,6 +5,7 @@ test_description='test cherry-picking (and reverting) a root commit'
>>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>
>>   test_expect_success setup '
>> diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
>> index 7e11bd4a4c5..b71bad17b85 100755
>> --- a/t/t3506-cherry-pick-ff.sh
>> +++ b/t/t3506-cherry-pick-ff.sh
>> @@ -5,6 +5,7 @@ test_description='test cherry-picking with --ff option'
>>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>
>>   test_expect_success setup '
>> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
>> index 84a587daf3a..dd5d92ef302 100755
>> --- a/t/t3511-cherry-pick-x.sh
>> +++ b/t/t3511-cherry-pick-x.sh
>> @@ -2,6 +2,7 @@
>>
>>   test_description='Test cherry-pick -x and -s'
>>
>> +TEST_PASSES_SANITIZE_LEAK=true
>>   . ./test-lib.sh
>>
>>   pristine_detach () {
> 
