Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE6C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F9623102
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge7p2DGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgJMN2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgJMN2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 09:28:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2961C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 06:28:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d81so20908757wmc.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kKMN/PsRJjiH+4tPu9eK4J6AUA58RLeqihj7eYTmFV8=;
        b=Ge7p2DGm1TDGQUtZFM5IR0+bWVv+vSLpWpBBBhv3x3uHSzQLWzoTwv5JrE50PC6WMc
         7WHrfrXYA4Qj7mD9OdCSGDLEGixfdmZfzYx4ILRCuvfhakjl2gd7hMNNgw66QjaFdK2t
         sc8Un3yVikvuGvNi8jxxALBMWNQocpugu9/A2VgBl4ivC1juylPJBRx2xsIUJm4h5fdc
         /1/KM0hHbWpKv8JqDUhz1RG8rTn9CN0eVN2SNi5eMA+mBK4f9ohzOcdQnB3O/Lhi0Dro
         Z1JQxQzKnXBq7C7P7Liudjy3ufWEJ28CxkiWiYsyva7hCu0qoUk2K3pqFzkFSbhXYIBU
         xMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kKMN/PsRJjiH+4tPu9eK4J6AUA58RLeqihj7eYTmFV8=;
        b=ZXQ7TSPCqOSvaHN5Hps46Y0wAOUqB4QAmcqifoddxi9A+ouJI9heJ9Q+DbSpcVN0Un
         y++YZWoiyJOR0s97RRljBnqFh0OvvO1npU/um43lR+lWMytZiDV+y8Nqbu4Ugb7HHr02
         JkOu8Qo7kXFR3zAT8xt2i1ER4DHHLRDH4IjjFhuN2SNP5mwLEUMuCMb8uFd+9J5ZqvtX
         lR4wlQW0ecNF0F8e1q/4WqCmaGFZgvSZsBPMbw1cKy5jqMU7jh5lIIJ84yeNqz4XGzaB
         UBJ+CwMoOH9CwfpydK+rvAsTKiNFA4W8M0kIsgR9vyQvWl/awbS5aSxiZbaz+0vJlX09
         S0wg==
X-Gm-Message-State: AOAM53190GIJDTXTt7PgG0acZWsDmf6WTgwddyTZpo+EnK2kipGxazdw
        aqtqkkckoteWEhLKCdFxink=
X-Google-Smtp-Source: ABdhPJxctLiXCKKe0zyXXJNWqYfeKg41Lvbkd5YP7ollQFFuj8Ef7If4X9H0pvdTDv43z4FMddHEqg==
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr14944771wmm.115.1602595702397;
        Tue, 13 Oct 2020 06:28:22 -0700 (PDT)
Received: from [192.168.1.240] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.gmail.com with ESMTPSA id m1sm26008477wmm.34.2020.10.13.06.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:28:21 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
 <20201013105159.rfpczn563agvih5y@fastboi.localdomain>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1bc5b455-68f7-eb7a-763d-d541086ddcdb@gmail.com>
Date:   Tue, 13 Oct 2020 14:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013105159.rfpczn563agvih5y@fastboi.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel

On 13/10/2020 11:51, Samuel Čavoj wrote:
> Hi Phillip,
> 
> thank you very much for the feedback.
> 
> On 13.10.2020 11:02, Phillip Wood wrote:
>> Hi Samuel
>>
>> On 13/10/2020 00:49, Samuel Čavoj wrote:
>>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>>
>>> When performing a rebase with --rebase-merges using either a custom
>>> strategy specified with -s or an octopus merge, and at the same time
>>> having gpgsign enabled (either rebase -S or config commit.gpgsign), the
>>> operation would fail on making the merge commit. Instead of "-S%s" with
>>> the key id substituted, only the bare key id would get passed to the
>>> underlying merge command, which tried to interpret it as a ref.
>>>
>>> Fix the issue and add a test case as suggested by Johannes Schindelin.
>>>
>>> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
>>> ---
>>> changed v1 -> v2:
>>>       added test case
>>> ---
>>>    sequencer.c                | 2 +-
>>>    t/t3435-rebase-gpg-sign.sh | 6 ++++++
>>>    2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 00acb12496..88ccff4838 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>>>    		strvec_push(&cmd.args, "-F");
>>>    		strvec_push(&cmd.args, git_path_merge_msg(r));
>>>    		if (opts->gpg_sign)
>>> -			strvec_push(&cmd.args, opts->gpg_sign);
>>> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>>>    		/* Add the tips to be merged */
>>>    		for (j = to_merge; j; j = j->next)
>>> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
>>> index b47c59c190..f70b280f5c 100755
>>> --- a/t/t3435-rebase-gpg-sign.sh
>>> +++ b/t/t3435-rebase-gpg-sign.sh
>>> @@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
>>>    	test_must_fail git verify-commit HEAD
>>>    '
>>> +test_expect_success 'rebase -r, GPG and merge strategies' '
>>> +	git reset --hard merged &&
>>> +	git rebase -fr --gpg-sign -s resolve --root &&
>>> +	git verify-commit HEAD
>>> +'
>>
>> Unfortunately I've just noticed that the test above runs
>>
>> 	git config commit.gpgsign true
>>
>> So this test would pass anyway if merge picks up that config setting.

That's predicated on my misunderstanding of the behavior without your 
patch but it would be good to fix the test anyway

>> The
>> previous test needs to be changed to
>>
>> 	test_config commit.gpgsign true
> 
> Should I do that now, maybe as a separate part of the patch series? Or
> just override the config with a `test_config commit.gpgsign false` in
> the test I added?

As you've found another instance that needs changing it would probably 
be better as a separate patch

> There is another usage of `git config` in the file, in the
> test_rebase_gpg_sign function.

Well spotted, that should be changed as well

>> so that the config setting is cleared when that test finishes. That previous
>> test would then be a good template for testing `rebase -r --no-gpg-sign` if
>> you wanted to add a test for that to the next patch as Junio suggested.
> 
> Yes, I will definitely do that in v3.

Thanks

> Also, the previous test is expect_failure,
> that means its a known bug?

Yes, `rebase -p` is deprecated and it looks like it was skipped by the 
recent fix for `rebase --no-gpg-sign` in c241371c04 ("rebase.c: honour 
--no-gpg-sign", 2020-04-03)


Best Wishes

Phillip

> Regards,
> Samuel
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>>    test_done
>>>
>>
