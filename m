Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE9AC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 20:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiFFUTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiFFUSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 16:18:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0990662A24
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 13:18:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x18so8337760qtj.3
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvYr1KXopfC7XDgll6u4rG7pyq/30uK5JCf7ZkH/UhA=;
        b=OPvozR01rDay/qP1guFK0pP/rtP3ovy2PeMIjD5ORxm51xpxzz4hJS2BE0GFgVhscF
         DujoRqPTggUQuRW2tL06X1YPF/lkvIkJQMlwrWih1UQT5RiflVI9aYDqYhLHBFYSE/9o
         mrQuDdhg4lsecK1Bol6J9Bhx4hKcvhAaoOSpjWSM5ju0ug0kWb0rLmeDVqPfesgP2aCb
         dqC+Cmr5WCsnEGMVml8NoOzDwvz0tggYPlLm2hWJQh2MCZShGiYvEXMI9KqiAbpyj+Jy
         M4+27qaOohlOrhThCkFO4JH92zPHskHQhnRD8jFwjfXqzvw2Ekh6+tnlTRf0SUOswe7G
         m+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvYr1KXopfC7XDgll6u4rG7pyq/30uK5JCf7ZkH/UhA=;
        b=yvtDv3i91UhhsWhp9NLE0onR9JyA909IkqA2YVv/Q8Y/cfxUrIHWlUb3lQYhNNrF5v
         hBJrVT/A+ZCXreSS8pd48J+XrS+Bb5foeYGQzADqjEwZiKI+LlYMXPopwCRudE6aUuar
         8Ts6OSzKWkHUHp93z5GRdN8er06a4tvRQIQ5X2lIhJ2jUtDFxOVAXJNkZaDoYvBK1guu
         QbrEIkgNAPJusaQzT1JqTW5ecn3B4DHy/Y3qpyFOxFpbb2+St4hE0i3hNDVZ3vN2M5CH
         tQaBTWuej13CLZQ6I2araW80JcDIN+6H0/LA4/hcmoMF89G3aymjHu6OHD9HCHpul/uh
         ZRTQ==
X-Gm-Message-State: AOAM5308UacvOAyhOCapj1n2BvNrnBnTkm8AkBqDbxZdpLG/wBr41RKU
        qm/SpY6WLHLHXQ4myN1QC6NTkSweDz4=
X-Google-Smtp-Source: ABdhPJzIBmWZorWQJmf1nPCTqb3S5cMzr0I5HNha5kAY8WjRsmQT2y/MzN6r55nBjJhpTectvkGenQ==
X-Received: by 2002:ac8:4e86:0:b0:2f3:f4dd:82b5 with SMTP id 6-20020ac84e86000000b002f3f4dd82b5mr19742163qtp.444.1654546719944;
        Mon, 06 Jun 2022 13:18:39 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a056600b0069fc13ce23bsm11363419qkp.108.2022.06.06.13.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 13:18:39 -0700 (PDT)
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <538e55d9-f994-a270-3d6a-a8d2dae9a2cc@gmail.com>
Date:   Mon, 6 Jun 2022 16:18:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-06-02 à 11:36, Johannes Schindelin a écrit :
> Hi Philippe,
> 
> On Mon, 30 May 2022, Philippe Blain via GitGitGadget wrote:
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
> 
> This means that we can go two ways here: either we explicitly disable
> `diff.submodule` for the invocation that is spawned from `range-diff`, or
> we allow it but then handle the diff header as expected.
> 
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
> 
> Full disclosure: I do not see much value in range-diffs in the presence of
> submodules. Nothing in the design of range-diffs is prepared for
> submodules.
> 
> But since `--submodules=short` does not change anything when running
> `range-diff` in repositories without submodules, I don't mind this change.
> 
>>
>> Note that the test must use '--creation-factor=100' to force the second
>> commit in the range not to be considered a complete rewrite.
> 
> Thank you for this considerate note!
> 
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
>>
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
> 
> As I mentioned above, since this does not change anything in the intended
> scenarios (i.e. without submodules), I am fine with it.
> 
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
> 
> Just a suggestion: use `git commit -m sub-first sub` instead (one `git`
> invocation instead of two).

OK, good idea. I'll tweak that.

> 
>> +	sup_oid1=$(git rev-parse --short HEAD) &&
>> +	git checkout -b topic-sub &&
>> +	git -C sub checkout sub-second &&
>> +	git add sub &&
>> +	git commit -m "change sub" &&
>> +	sup_oid2=$(git rev-parse --short HEAD) &&
>> +	git checkout -b modified-sub main-sub &&
> 
> Another suggestion: instead of naming the branches, use the `sup_oid*`
> variables directly.
> 

I think I like the branch names, they make the test closer to a 
"real-life" scenario (in my opinion). So I think I'll keep them,
since you write later in your reply that you do not mind that much.

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
> 
> This test case is very clear and concise, even without my suggested
> changes. Therefore, if you want to keep the patch as-is, I am fine with
> that, too.
> 
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Thank you,

Thanks,

Philippe.	
