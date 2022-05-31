Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091CEC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 02:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbiEaCWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 22:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiEaCWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 22:22:16 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110969344C
        for <git@vger.kernel.org>; Mon, 30 May 2022 19:22:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id r84so12220644qke.10
        for <git@vger.kernel.org>; Mon, 30 May 2022 19:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bXhXN518MYi/67nSuq35g/bl62UDaIG2Gue8dOnrYOQ=;
        b=atim4uTMylOIRo2HFjkV/dN3TQgfMBYD2WC+pNQCyx6A8DD+SZavi5Q7naWUAIEzrr
         w9s4sLkyaRp0iRordscUJY66Om7d/taOzixcAquceh6lN2dBVEQ9w95gxomI4rRyGUM9
         wRm44R7csN63C99ZcNe6gwFk1S8fHRJZmVXdQZJ7Q4fGJNOzlEaJqlUto8YZZ9hh1NZX
         1GXm2i7oLuNFe2iS1Or1n9tnqjkG2msIslSQM0l/sCo3dC5an+/Z4HVxmcDMXiUR796O
         MmLvqTROEby3JzVIQ9aB0p+zoxH5b/dAD/3bwzDq6/jYvvvZPJdwydm9JgFaKIdwPmmo
         6qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bXhXN518MYi/67nSuq35g/bl62UDaIG2Gue8dOnrYOQ=;
        b=o9qAGaW3FFhg4ffmf6ZgYbJVsyP0CbKR1Xz44BlULLAR0UEqSpQ4bdNeCs0x/gs+oH
         asPPM2QUUx/7d+Z1gfGrnlmhhZuPKZP6NYhEy19+tnYdYlD7MhdrilHTOWtquM+Qezpw
         LJJH6qLKDNPBW4h5Ihvmng7Eaa/OqrCDp50Gp+yx5OiK0aMmb2bPcqk1tsr5xEoWPot0
         n1l2jCyguKwxEpHl2JxAdrneeBp4grwZ6WaqK+hm146GFTA2y88wZyJv6JRiRdG3YiQs
         ar6wnTdVIolhgMyD4BvPAh6pH9ow3V407zZH9xuWK7juVbgfWjfkxaCy+7cxMEOeXaRm
         fXEQ==
X-Gm-Message-State: AOAM532Y51MAOdYp20rNbPAvK5rEeh3hXD9APmjFMFH6oe+nWZ45OKTm
        c5DJAAP0Un+F56FH9eCKzrK8uy0P6GQ=
X-Google-Smtp-Source: ABdhPJxub5ErAtA6+8GIM7HSZXUZ28X6O+7hwPQG0mTbl3YxkawFti+MOATpLClk07zUJynWBdfVKg==
X-Received: by 2002:a05:620a:d4c:b0:6a6:2df0:4d97 with SMTP id o12-20020a05620a0d4c00b006a62df04d97mr5559560qkl.478.1653963734122;
        Mon, 30 May 2022 19:22:14 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id k4-20020ac80204000000b002f9303ce545sm8814219qtg.39.2022.05.30.19.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 19:22:13 -0700 (PDT)
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
 <220530.867d632kso.gmgdl@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5b43fb27-3a57-937f-1106-516ce939d66c@gmail.com>
Date:   Mon, 30 May 2022 22:22:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <220530.867d632kso.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2022-05-30 à 09:46, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Mon, May 30 2022, Philippe Blain via GitGitGadget wrote:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> After generating diffs for each range to be compared using a 'git log'
>> invocation, range-diff.c::read_patches looks for the "diff --git" header
>> in those diffs to recognize the beginning of a new change.
>>
>> In a project with submodules, and with 'diff.submodule=log' set in the
>> config, this header is missing for the diff of a changed submodule, so
>> any submodule changes are quietly ignored in the range-diff.
>>
>> When 'diff.submodule=diff' is set in the config, the "diff --git" header
>> is also missing for the submodule itself, but is shown for submodule
>> content changes, which can easily confuse 'git range-diff' and lead to
>> errors such as:
>>
>>     error: git apply: bad git-diff - inconsistent old filename on line 1
>>     error: could not parse git header 'diff --git path/to/submodule/and/some/file/within
>>     '
>>     error: could not parse log for '@{u}..@{1}'
>>
>> Force the submodule diff format to its default ("short") when invoking
>> 'git log' to generate the patches for each range, such that submodule
>> changes are always shown.
>>
>> Note that the test must use '--creation-factor=100' to force the second
>> commit in the range not to be considered a complete rewrite.
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>     range-diff: show submodule changes irrespective of diff.submodule
>>     
>>     This fixes a bug that I reported last summer [1].
>>     
>>     [1]
>>     https://lore.kernel.org/git/e469038c-d78c-cd4b-0214-7094746b9281@gmail.com/
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1244%2Fphil-blain%2Frange-diff-submodule-diff-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1244/phil-blain/range-diff-submodule-diff-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1244
>>
>>  range-diff.c          |  2 +-
>>  t/t3206-range-diff.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> Thanks for picking this up again, and nice to have a test on this
> iteration!

Well, what I sent last summer was really just a bug report with a "I think
this should fix it" diff, in case anybody wanted to pick it up. 
It was not sent as a patch, I would not send a 
patch fixing a bug without correponding tests ;)

> 
>> diff --git a/range-diff.c b/range-diff.c
>> index b72eb9fdbee..068bf214544 100644
>> --- a/range-diff.c
>> +++ b/range-diff.c
>> @@ -44,7 +44,7 @@ static int read_patches(const char *range, struct string_list *list,
>>  
>>  	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>>  		     "--reverse", "--date-order", "--decorate=no",
>> -		     "--no-prefix",
>> +		     "--no-prefix", "--submodule=short",
>>  		     /*
>>  		      * Choose indicators that are not used anywhere
>>  		      * else in diffs, but still look reasonable
>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>> index e30bc48a290..ac848c42536 100755
>> --- a/t/t3206-range-diff.sh
>> +++ b/t/t3206-range-diff.sh
>> @@ -772,4 +772,48 @@ test_expect_success '--left-only/--right-only' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
>> +	git init sub-repo &&
>> +	test_commit -C sub-repo sub-first &&
>> +	sub_oid1=$(git -C sub-repo rev-parse HEAD) &&
>> +	test_commit -C sub-repo sub-second &&
>> +	sub_oid2=$(git -C sub-repo rev-parse HEAD) &&
>> +	test_commit -C sub-repo sub-third &&
>> +	sub_oid3=$(git -C sub-repo rev-parse HEAD) &&
>> +
>> +	git checkout -b main-sub topic &&
>> +	git submodule add ./sub-repo sub &&
>> +	git -C sub checkout --detach sub-first &&
>> +	git add sub &&
>> +	git commit -m "add sub" &&
>> +	sup_oid1=$(git rev-parse --short HEAD) &&
>> +	git checkout -b topic-sub &&
>> +	git -C sub checkout sub-second &&
>> +	git add sub &&
>> +	git commit -m "change sub" &&
>> +	sup_oid2=$(git rev-parse --short HEAD) &&
>> +	git checkout -b modified-sub main-sub &&
>> +	git -C sub checkout sub-third &&
>> +	git add sub &&
>> +	git commit -m "change sub" &&
>> +	sup_oid3=$(git rev-parse --short HEAD) &&
>> +
>> +	test_config diff.submodule log &&
>> +	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
>> +	cat >expect <<-EOF &&
>> +	1:  $sup_oid1 = 1:  $sup_oid1 add sub
>> +	2:  $sup_oid2 ! 2:  $sup_oid3 change sub
>> +	    @@ Commit message
>> +	      ## sub ##
>> +	     @@
>> +	     -Subproject commit $sub_oid1
>> +	    -+Subproject commit $sub_oid2
>> +	    ++Subproject commit $sub_oid3
>> +	EOF
>> +	test_cmp expect actual &&
>> +	test_config diff.submodule diff &&
>> +	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
>> +	test_cmp expect actual
>> +'
>> +
> 
> I'd find this much easier to follow if this were a two-part where we do
> most of this test code in the 1st commit, and assert the current
> (failing) behavior with a test_expect_failure.
> 
> Then this commit would narrowly be the bugfix itself.

I agree that I would prefer if it were the norm to do it this way in this 
project. This way you can check that the test you are adding actually fails
without the fix, not only that it passes with the fix. This is what I usually
do locally before sending.

However Junio has expressed his view about that approach before [1] and he prefers
to see regression / bug fixes as a single commit with code and tests. So that's why
I sent this as a single commit.

> 
> I also see that the --creation-factor=100 isn't necessary and seems
> somewhat orthagonal, i.e. we'd like to test this *without* that option
> and see how we behave, i.e. we'll emit the "full replacement".
> 
> Why not compare the output without --creation-factor=100, and then just
> have another --creation-factor=100 test to show what we emit if we "look
> into" those commits and diff their contents?
> 

OK, I think this makes sense. It's true that even without '--creation-factor=100',
with '-c diff.submodule=log' we end up showing the second commit as an exact match
in both ranges, which is wrong. I'll add that to the test.

Thanks for taking a look,

Philippe.


[1] https://lore.kernel.org/git/37DD13D4-FBE4-4DB7-85F5-824E850BA9AE@gmail.com/
