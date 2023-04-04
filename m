Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09815C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 13:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjDDNEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjDDNEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 09:04:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70C19A4
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 06:04:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so2096232wmb.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680613443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6x/ubM8fi+8JrKF4XpRTpr/Bui8D1gCgmle4QvTZkpo=;
        b=X6wtmYT/iL/yjzcvNgstiYq9vE32XJRhxb1hhb0K2z4YUZlyFoK45iirZvU8psS3R5
         2dp+lRzhYwg3XD8pWZsuG8QlZTzmq7C57+3SzFhvGCD7o7VN4EN3B2B9KKgKLmji7Ece
         +aCg8Ad7miNdnMjHu+EEFKDVFLt9AqhdHwVwuQL5tFJVSlrzWPR10Y1U4OdVtsHcT7wG
         uc3XGakFaRxB1r92Lz+dGqIpxlkm7npHwdd4MxpY+kfP117/xqu5SU9y+gOUELX9LqPf
         ccmDF0Rov1OJ5drME1Jn0BZpIgpchua0/BqlSB9rZQAWg1xPl9ESIc2H0kGP79hPM8fW
         Ddtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680613443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x/ubM8fi+8JrKF4XpRTpr/Bui8D1gCgmle4QvTZkpo=;
        b=rp+5+AEl1HSgE5KRCYPVvhFvjAOgnMSTbHdQG17h45eqvdCgyDAzkR5Bx1SXZd4LZ4
         oNDgUPOqU118Vhb9rW2kqvEa4HoVXxkdItKIcAJHyUsLhI947amtzND63EWQv/DTEtSQ
         SUOmXXp50cJy/X7LhVkLEcUpB1JJwgud0tyhLHiemajXvi8YYOi0Pc6H0nqWCjFpjQ3x
         SAOlr1vudUzp52opCBBRqGB/ZshqMAo2vNUI1xZWwqe/3odphfvsLAZALoEtWoz/YZ0A
         tvRgduQ2m6d+wkt1z+7Ef+MR6dYrkoTiIUUIdeKYCGXaB91Ez3bg/QhG2HzZalEFNg1W
         QMcA==
X-Gm-Message-State: AAQBX9cm5x4hv73PtvTzAAP0pSs/LrQ91dQD/agW8GPiV+dF240lCrGO
        se8ezdcqAvonQXVDFQvw3qY=
X-Google-Smtp-Source: AKy350ZvSSdJZpO0sqfatnIze5wIXyIgyijUvBCpfGTkZNyeMHML5vn5oDK9USyyCsnhoTKZXfGDCQ==
X-Received: by 2002:a05:600c:2193:b0:3ed:2eb5:c2dd with SMTP id e19-20020a05600c219300b003ed2eb5c2ddmr2063367wme.39.1680613443103;
        Tue, 04 Apr 2023 06:04:03 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id q9-20020a1cf309000000b003f04f0c5a6fsm8404085wmq.26.2023.04.04.06.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:04:02 -0700 (PDT)
Message-ID: <f3bbbed3-b2d7-9d92-00cd-0a53ad4c676f@gmail.com>
Date:   Tue, 4 Apr 2023 14:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] rebase: remove a couple of redundant strategy tests
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
 <3e02eeff78b23711187de47a1a820f9bde683200.1678893298.git.phillip.wood@dunelm.org.uk>
 <CABPp-BGwj-_JRWose89tg2HXQoOoriPqHzW6XC0s5qJDayPTmQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BGwj-_JRWose89tg2HXQoOoriPqHzW6XC0s5qJDayPTmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/2023 20:31, Elijah Newren wrote:
> On Wed, Mar 15, 2023 at 8:38 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The test removed in t3402 has been redundant ever since 80ff47957b
>> (rebase: remember strategy and strategy options, 2011-02-06) which added
>> a new test the first part of which (as noted in the commit message)
>> duplicated the existing test. The test removed in t3418 has been
>> redundant since the merge backend was removed in 68aa495b59 (rebase:
>> implement --merge via the interactive machinery, 2018-12-11) as it now
>> tests the same code paths as the preceding test.
> 
> I was really confused by this commit message at first.  Eventually, I
> figured out you were talking about the changes in this commit, just in
> past tense.  Could we change it to imperative tense?  E.g.
> 
> Remove a test in t3402 that has been redundant ever since 80ff47957b
> (rebase: remember strategy and strategy options, 2011-02-06).  That commit added
> a new test, the first part of which (as noted in the old commit message)
> duplicated an existing test.
> 
> Also remove a test t3418 that has been redundant since the merge
> backend was removed in 68aa495b59 (rebase: implement --merge
> via the interactive machinery, 2018-12-11), since it now tests the
> same code paths as the preceding test.

Thanks, that is clearer, I'll use your suggested wording when I re-roll

Best Wishes

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   t/t3402-rebase-merge.sh    | 21 ---------------------
>>   t/t3418-rebase-continue.sh | 32 --------------------------------
>>   2 files changed, 53 deletions(-)
>>
>> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
>> index 7e46f4ca85..79b0640c00 100755
>> --- a/t/t3402-rebase-merge.sh
>> +++ b/t/t3402-rebase-merge.sh
>> @@ -131,27 +131,6 @@ test_expect_success 'picking rebase' '
>>          esac
>>   '
>>
>> -test_expect_success 'rebase -s funny -Xopt' '
>> -       test_when_finished "rm -fr test-bin funny.was.run" &&
>> -       mkdir test-bin &&
>> -       cat >test-bin/git-merge-funny <<-EOF &&
>> -       #!$SHELL_PATH
>> -       case "\$1" in --opt) ;; *) exit 2 ;; esac
>> -       shift &&
>> -       >funny.was.run &&
>> -       exec git merge-recursive "\$@"
>> -       EOF
>> -       chmod +x test-bin/git-merge-funny &&
>> -       git reset --hard &&
>> -       git checkout -b test-funny main^ &&
>> -       test_commit funny &&
>> -       (
>> -               PATH=./test-bin:$PATH &&
>> -               git rebase -s funny -Xopt main
>> -       ) &&
>> -       test -f funny.was.run
>> -'
>> -
>>   test_expect_success 'rebase --skip works with two conflicts in a row' '
>>          git checkout second-side  &&
>>          tr "[A-Z]" "[a-z]" <newfile >tmp &&
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index 42c3954125..2d0789e554 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -97,38 +97,6 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
>>          test_cmp expect actual
>>   '
>>
>> -test_expect_success 'rebase -i --continue handles merge strategy and options' '
>> -       rm -fr .git/rebase-* &&
>> -       git reset --hard commit-new-file-F2-on-topic-branch &&
>> -       test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
>> -       test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
>> -       mkdir test-bin &&
>> -       cat >test-bin/git-merge-funny <<-EOF &&
>> -       #!$SHELL_PATH
>> -       echo "\$@" >>funny.args
>> -       case "\$1" in --opt) ;; *) exit 2 ;; esac
>> -       case "\$2" in --foo) ;; *) exit 2 ;; esac
>> -       case "\$4" in --) ;; *) exit 2 ;; esac
>> -       shift 2 &&
>> -       >funny.was.run &&
>> -       exec git merge-recursive "\$@"
>> -       EOF
>> -       chmod +x test-bin/git-merge-funny &&
>> -       (
>> -               PATH=./test-bin:$PATH &&
>> -               test_must_fail git rebase -i -s funny -Xopt -Xfoo main topic
>> -       ) &&
>> -       test -f funny.was.run &&
>> -       rm funny.was.run &&
>> -       echo "Resolved" >F2 &&
>> -       git add F2 &&
>> -       (
>> -               PATH=./test-bin:$PATH &&
>> -               git rebase --continue
>> -       ) &&
>> -       test -f funny.was.run
>> -'
>> -
>>   test_expect_success 'rebase -r passes merge strategy options correctly' '
>>          rm -fr .git/rebase-* &&
>>          git reset --hard commit-new-file-F3-on-topic-branch &&
>> --
>> 2.39.2
> 
> Looks good otherwise.

