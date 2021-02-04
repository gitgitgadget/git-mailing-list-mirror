Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033ECC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AE564D92
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 10:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhBDKrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBDKrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 05:47:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF79C061573
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 02:47:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so4468272ejf.11
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 02:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hnIolJpgi+O6C+PF9kAJ4iW71J1/s1RllY9tbCriE10=;
        b=spE8huy/kS6w3nq3/ZHcWQWrCTiYYFjogCXtgsBCMCJXr8iP89hh3EVXbzNk6m5dnr
         pGHrNT42o85NmN8KPj0Ta1+iAW/mYwywlB4LnauR3KdxnZsXndBEJxsWQol9yVl4T0t5
         S8gqQ25IJU4ypbcQ546PopdmesoNLgN3u9/sY1HcsX4Zi57G5CSzLvjWu5KYxEF1bnDW
         KUdNhaJmcqzN/nWiWje2VengPzCpuUMb0SCq61Ugqzcj3tgNoz4Ru3F+o6EuTF5tXA2S
         QOaafKvF/xkYmf/Hl0rUHaXDcSj3kcA07NKjlrJGE1qpeBUMs+inJDVB2rI22TXCwK71
         GK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hnIolJpgi+O6C+PF9kAJ4iW71J1/s1RllY9tbCriE10=;
        b=WWHHC6/SQ8JKS6vOBj8n9Rsjx8Swvlfvrk0Mrz+L17gipNwXfnDHk3QvtL6Gvpjpib
         iD8t44sU+bOIc5gW68r+AlBppl4VtHJbX1suz9aR2sonDyF8TiDT3KBOoh9KF3DHCYpK
         kJ6Gdi96K0FBjhSaR9Nio55QPwNzUa18giowf9fxBs5MRNH7LgecLqL5izJESsY1bw9W
         Ukfz9C3gdh3IOAVWxDmsfC1PtJnc3AMzU2kwTnQrkTNIrP+YcDID2M5LSJ4ju24Uo1el
         lWb0GPQefPzGtIlv16V5i17k47Dr5YD6F8wMqEip0s0jSHb0wSg7lGbQ+zfCPmI745Ua
         4GiQ==
X-Gm-Message-State: AOAM530N+J1Hac4dE2zo/AdIEly+a4Asz9jK1Vx1UT3W/nmSGlPHMMmO
        FdjaR5Myv1wWfRS0cRj62so=
X-Google-Smtp-Source: ABdhPJy5oLHgy4S2axjeV7Tw/zNCLssQDVhyqqZh1UM0FvRj2UUFSHck+8rMHz7jNgcxcDYTtdqlgA==
X-Received: by 2002:a17:906:d84:: with SMTP id m4mr5471417eji.437.1612435618973;
        Thu, 04 Feb 2021 02:46:58 -0800 (PST)
Received: from [192.168.1.201] (65.16.7.51.dyn.plus.net. [51.7.16.65])
        by smtp.googlemail.com with ESMTPSA id u5sm2384261edc.29.2021.02.04.02.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:46:58 -0800 (PST)
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com>
 <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <54d1ef0f-6a50-b2cb-3ac6-c313cf9dd2f3@gmail.com>
Date:   Thu, 4 Feb 2021 10:46:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

Thanks for taking such a close look at this series.

On 02/02/2021 02:01, Eric Sunshine wrote:
> On Fri, Jan 29, 2021 at 1:25 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> [...] 
>> +       ORIG_AUTHOR_NAME="$GIT_AUTHOR_NAME" &&
>> +       ORIG_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" &&
>> +       GIT_AUTHOR_NAME="Amend Author" &&
>> +       GIT_AUTHOR_EMAIL="amend@example.com" &&
>> +       test_commit "$(cat message)" A A1 A1 &&
>> +       test_commit A2 A &&
>> +       test_commit A3 A &&
>> +       GIT_AUTHOR_NAME="$ORIG_AUTHOR_NAME" &&
>> +       GIT_AUTHOR_EMAIL="$ORIG_AUTHOR_EMAIL" &&
> 
> Are the timestamps of these commits meaningful in this context? 

I think we want to ensure that the timestamp of the commits created with 
the different author are different from the previous commits. We ought 
to be checking that the author date of the rebased commit matches the 
author date of the original commit and not the author date of the fixup 
commit created with the different author.

> If not, another way to do this would be to assign the new author
> name/email values in a subshell so that the values do not need to be
> restored manually. For instance:
> 
>      (
>          GIT_AUTHOR_NAME="Amend Author" &&
>          GIT_AUTHOR_EMAIL="amend@example.com" &&
>          test_commit "$(cat message)" A A1 A1 &&
>          test_commit A2 A &&
>          test_commit A3 A
>      ) &&
> 
> It's a matter of taste whether or not that is preferable, though.
> 
>> +       echo B1 >B &&
>> +       test_tick &&
>> +       git commit --fixup=HEAD -a &&
>> +       test_tick &&
> 
> Same question about whether the commit timestamps have any
> significance in these tests.

Same answer as above - we want different author dates so we can check 
the original author date is not modified.

I'm not sure that we are actually checking the dates yet though it looks 
like we only check the author name and email at the moment.

Best Wishes

Phillip

> If not, then these test_tick() calls
> mislead the reader into thinking that the timestamps are significant,
> thus it would make sense to drop them.
> 
>> +test_expect_success 'simple fixup -C works' '
>> +       test_when_finished "test_might_fail git rebase --abort" &&
>> +       git checkout --detach A2 &&
>> +       FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
> 
> I see that you mirrored the implementation of FAKE_LINES handling of
> "exec" here for "fixup", but the cases are quite different. The
> argument to "exec" is arbitrary and can have any number of spaces
> embedded in it, which conflicts with the meaning of spaces in
> FAKE_LINES, which separate the individual commands in FAKE_LINES.
> Consequently, "_" was chosen as a placeholder in "exec" to mean
> "space".
> 
> However, "fixup" is a very different beast. Its arguments are not
> arbitrary at all, so there isn't a good reason to mirror the choice of
> "_" to represent a space, which leads to rather unsightly tokens such
> as "fixup_-C". It would work just as well to use simpler tokens such
> as "fixup-C" and "fixup-c", in which case t/lib-rebase.sh might parse
> them like this (note that I also dropped `g` from the `sed` action):
> 
>      fixup-*)
>          action=$(echo "$line" | sed 's/-/ -/');;
> 
> In fact, the recognized set of options following "fixup" is so small,
> that you could even get by with simpler tokens "fixupC" and "fixupc":
> 
>      fixupC)
>          action="fixup -C";;
>      fixupc)
>          actions="fixup -c";;
> 
> Though it's subjective whether or not "fixupC" and "fixupc" are nicer
> than "fixup-C" and "fixup-c", respectively.
> 
>> +test_expect_success 'fixup -C removes amend! from message' '
>> +       test_when_finished "test_might_fail git rebase --abort" &&
>> +       git checkout --detach A1 &&
>> +       FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
>> +       test_cmp_rev HEAD^ A &&
>> +       test_cmp_rev HEAD^{tree} A1^{tree} &&
>> +       test_commit_message HEAD expected-message &&
>> +       get_author HEAD >actual-author &&
>> +       test_cmp expected-author actual-author
>> +'
> 
> This test seems out of place. I would expect to see it added in the
> patch which adds "amend!" functionality.
> 
> Alternatively, if the intention really is to support "amend!" this
> early in the series in [6/9], then the commit message of [6/9] should
> talk about it.
> 
>> +test_expect_success 'fixup -C with conflicts gives correct message' '
>> +       test_when_finished "test_might_fail git rebase --abort" &&
> 
> Is there a reason this isn't written as:
> 
>      test_when_finished "reset_rebase" &&
> 
> which is more common? Is there something non-obvious which makes
> reset_rebase() inappropriate in these tests?
> 
>> +       git checkout --detach A1 &&
>> +       test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
>> +       git checkout --theirs -- A &&
>> +       git add A &&
>> +       FAKE_COMMIT_AMEND=edited git rebase --continue &&
>> +       test_cmp_rev HEAD^ conflicts &&
>> +       test_cmp_rev HEAD^{tree} A1^{tree} &&
>> +       test_write_lines "" edited >>expected-message &&
> 
> It feels clunky and fragile for this test to be changing
> "expected-message" which was created in the "setup" test and used
> unaltered up to this point. If the content of "expected-message" is
> really going to change from test to test (as I see it changes again in
> a later test), then it would be easier to reason about the behavior if
> each test gives "expected-message" the precise content it should have
> in that local context. As it is currently implemented, it's too
> difficult to follow along and remember the value of "expected-message"
> from test to test. It also makes it difficult to extend tests or add
> new tests in between existing tests without negatively impacting other
> tests. If each test sets up "expected-message" to the precise content
> needed by the test, then both those problems go away.
> 
>> +test_expect_success 'multiple fixup -c opens editor once' '
>> +       test_when_finished "test_might_fail git rebase --abort" &&
>> +       git checkout --detach A3 &&
>> +       base=$(git rev-parse HEAD~4) &&
>> +       FAKE_COMMIT_MESSAGE="Modified-A3" \
>> +               FAKE_LINES="1 fixup_-C 2 fixup_-c 3 fixup_-c 4" \
>> +               EXPECT_HEADER_COUNT=4 \
>> +               git rebase -i $base &&
>> +       test_cmp_rev $base HEAD^ &&
>> +       test 1 = $(git show | grep Modified-A3 | wc -l)
>> +'
> 
> These days, we would phrase the last part of the test as:
> 
>      git show > raw &&
>      grep Modified-A3 raw >out &&
>      test_line_count = 1 out
> 

