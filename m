Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED4F1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeIKDIs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 23:08:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46479 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKDIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 23:08:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so23526008wrc.13
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MX2Statu2IlnBg7t0HULqZ25dP8pkNutM+r3C+zuEi8=;
        b=S/XtIgvMiKKfnicvcR74mM9K59P9UyvXPIglfO6OixEl5nOHiPbU+RQSdUX8L9M2nF
         hsswX9aqIGRAIzeqzpnHz9/X2Znbz0YL2Xo5u3FlZa8o6VxMsjeMX6w2eFkY0e8bDTWr
         Bch+yLwV/9MAdr7N/zbogt3nwxT/N1juhSO/jcN9yxM0yPL2CX1PPNFGv8TYq1lu/jtn
         lJsqMcCr07wK0Ii8ZdiThcHI4zllPA956WRTtO0OrrIHd96C8P6sPh5JwhdraIpKgR78
         GpIxCMR1OTYCmrhodoFMEySXmLplEZ24TGsU/EWsWw/fbA8Wo51S2TaoIm6w5K/6MV3C
         fUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MX2Statu2IlnBg7t0HULqZ25dP8pkNutM+r3C+zuEi8=;
        b=bTK/HUQEBggJ/WbUNp2m4NRWWLxtDYHlGqh5XCMWB0d+Jzs0r9qGRwv93pcJ2/KTw8
         dcyW2KdiiLtfC4vWDRcsoS9j9ePFIx8axemhO7GqjKiNNza4iavPeGtky4cPGrmL0aeZ
         56DZWtHSufOiv090yqlDQuzKvTmYiof1mXMCUzjEJ1HN8UUi/8tDpGgi+owEapY/lZQQ
         7oQAv+NG+MZRm83YLL/f+LRWrN/hdiTHqRVyxmHkmrLBWdMdbt6+3NOfUFwjyDWMO/Rz
         bmcS8ck5lJ/liFaud493AAgFDVohjBxcJ5oUvgBySAu3REPhMPD2kDTzfY4YtduyUXCW
         QatA==
X-Gm-Message-State: APzg51AN/Y4a56lhxF8Axgj5G8FmXTs/mLmRbmU/JULKQiL17SzG+CaQ
        ES0SKygiT/0g6FFj+2ADd1w=
X-Google-Smtp-Source: ANB0VdZaRBfdRkkIbK2y07kfQcYbzBzbH11yMTBV/w1IcwsDCyJQ3REJIIrrTtcYCVzvAJaQYYMkDQ==
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr17082710wre.5.1536617557512;
        Mon, 10 Sep 2018 15:12:37 -0700 (PDT)
Received: from [192.168.0.137] (5-13-141-254.residential.rdsnet.ro. [5.13.141.254])
        by smtp.gmail.com with ESMTPSA id s13-v6sm22326848wrq.39.2018.09.10.15.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 15:12:36 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] split-index: smudge and add racily clean cache
 entries to split index
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Joel Teichroeb <joel@teichroeb.net>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
 <20180906024810.8074-6-szeder.dev@gmail.com>
 <87va7ireuu.fsf@evledraar.gmail.com> <20180906151439.GA8016@localhost>
 <87lg8er6ir.fsf@evledraar.gmail.com> <87k1nyqzq2.fsf@evledraar.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <c7343fc4-b7ad-6c39-33bb-5b9d50bffb8d@gmail.com>
Date:   Tue, 11 Sep 2018 01:12:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87k1nyqzq2.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 06.09.2018 20:53, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 06 2018, Ævar Arnfjörð Bjarmason wrote:
> 
>> On Thu, Sep 06 2018, SZEDER Gábor wrote:
>>
>>> On Thu, Sep 06, 2018 at 02:26:49PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>>
>>>> On Thu, Sep 06 2018, SZEDER Gábor wrote:
>>>>> Several tests failed occasionally when the test suite was run with
>>>>> 'GIT_TEST_SPLIT_INDEX=yes'.  Here are those that I managed to trace
>>>>> back to this racy split index problem, starting with those failing
>>>>> more frequently, with a link to a failing Travis CI build job for
>>>>> each.  The highlighted line shows when the racy file was written,
>>>>> which is not always in the failing test (but note that those lines are
>>>>> in the 'after failure' fold, and your browser might unhelpfully fold
>>>>> it up before you could take a good look).
>>>>
>>>> Thanks for working on this. When I package up git I run the tests
>>>> under a few different modes, in the case of split index I've been
>>>> doing:
>>>>
>>>>      GIT_TEST_SPLIT_INDEX=true GIT_SKIP_TESTS="t3903 t4015.77"
>>>
>>> Yeah, I noticed that you mentioned this in an unrelated thread the
>>> other day, that's why I put you on Cc.  ... and that's why I pulled
>>> this series from the backburner and cleaned it up for submission.
>>> (Gah, most of these commits have an author date back in February...)
>>>
>>>> Since those were the ones I spotted failing under that mode, but
>>>> I still had occasional other failures, I don't have a record of
>>>> which, maybe some of these other tests you mention, maybe not.
>>>
>>> I poked around the Travis CI API, and managed to get the logs of all
>>> build jobs that failed with 'GIT_TEST_SPLIT_INDEX=yes' but succeeded
>>> without it.  Here is the list of failed test scripts, along with how
>>> many times they failed:
>>>
>>>        1 t0027-auto-crlf.sh
>>>        1 t0090-cache-tree.sh
>>>        1 t3404-rebase-interactive.sh
>>>        1 t5520-pull.sh
>>>        1 t5573-pull-verify-signatures.sh
>>>        1 t5608-clone-2gb.sh
>>>        1 t7406-submodule-update.sh
>>>        2 t2200-add-update.sh
>>>        2 t4002-diff-basic.sh
>>>        2 t5504-fetch-receive-strict.sh
>>>        3 t0028-working-tree-encoding.sh
>>>        4 t1000-read-tree-m-3way.sh
>>>        6 t4015-diff-whitespace.sh
>>>       10 t4024-diff-optimize-common.sh
>>>       17 t3030-merge-recursive.sh
>>>       17 t3402-rebase-merge.sh
>>>       17 t3501-revert-cherry-pick.sh
>>>       17 t6022-merge-rename.sh
>>>       17 t6032-merge-large-rename.sh
>>>       17 t6034-merge-rename-nocruft.sh
>>>       17 t6042-merge-rename-corner-cases.sh
>>>       17 t6043-merge-rename-directories.sh
>>>       17 t6046-merge-skip-unneeded-updates.sh
>>>       17 t7003-filter-branch.sh
>>>       17 t7601-merge-pull-config.sh
>>>       23 t3903-stash.sh
>>>
>>> I doubt that this racy split index problem is responsible for all
>>> these failures; e.g. I looked at the failures of a few merge-related
>>> test scripts, and these logs show that they tend to fail because of
>>> memory corruption, i.e. with 'Aborted (core dumped)' or 'Segmentation
>>> fault (core dumped)'.
>>>
>>>> To test how this this series improves things, I've been running
>>>> this on a 56 core CentOS 7.5 machine:
>>>>
>>>>      while true; do GIT_TEST_SPLIT_INDEX=yes prove -j$(parallel --number-of-cores) t3903-stash.sh t4024-diff-optimize-common.sh t4015-diff-whitespace.sh t2200-add-update.sh t0090-cache-tree.sh && echo "OK $(date) $(git describe)" >>log2 || echo "FAIL $(date) $(git describe)" >>log2; done
>>>>
>>>> While, in another window to get some load on the machine (these seem to
>>>> fail more under load):
>>>>
>>>>      while true; do prove -j$(parallel --number-of-cores) t[156789]*.sh; done
>>>>
>>>> The results with this series applied up to 4/5. I.e. without the actual
>>>> fix:
>>>>
>>>>       92 OK v2.19.0-rc2-6-ged839bd155
>>>>        8 FAIL v2.19.0-rc2-6-ged839bd155
>>>>
>>>> I.e. when running this 100 times, I got 8 failures. So 8%.
>>>
>>> Lucky you ;)
>>>
>>> I could only get t3903 to fail on me, but not the others.  That was
>>> enough to eventually track down and fix the problem (fun! ;), and then
>>> I looked at the logs of failed git/git Travis CI build jobs to see,
>>> what other failures might have been caused by it.
>>>
>>>> With this patch applied:
>>>>
>>>>      389 OK v2.19.0-rc2-5-g05a5a13935
>>>>       11 FAIL v2.19.0-rc2-5-g05a5a13935
>>>>
>>>> This time I ran the tests 400 times, and got 11 failures, i.e. a
>>>> ~2.8% failure rate. I don't have a full account of what stuff
>>>> failed (this was just scrolling past in my terminal), but most
>>>> were:
>>>>
>>>>      t0090-cache-tree.sh          (Wstat: 256 Tests: 21 Failed: 3)
>>>>        Failed tests:  10-12
>>>>        Non-zero exit status: 1
>>>>
>>>> I.e. these tests:
>>>>
>>>>      ok 10 - commit --interactive gives cache-tree on partial commit
>>>>      ok 11 - commit in child dir has cache-tree
>>>>      ok 12 - reset --hard gives cache-tree
>>>
>>> But hey, 't0090 --verbose-log -x -i' just failed on me with the fix
>>> applied while writing this email, yay!  In its logs I see the
>>> following errors in all three tests you mention:
>>>
>>>    error: index uses ?½þA extension, which we do not understand
>>>    fatal: index file corrupt
>>>
>>> Test 13 then starts with 'rm -f .git/index', and then all is well for
>>> the remaining tests.
>>>
>>> There was a recent discussion about a similar error starting at:
>>>
>>>    https://public-inbox.org/git/20180901214157.hxlqmbz3fds7hsdl@ltop.local/
>>>
>>> and leading to a fix in 6c003d6ffb (reopen_tempfile(): truncate opened
>>> file, 2018-09-04).  I certainly hope that not my fix is buggy, but
>>> combined with 'GIT_TEST_SPLIT_INDEX=yes' it can occasionally trigger
>>> the same error, and Peff's (Cc'd) fix will resolve it as well.
>>>
>>> Could you run your stress tests with Peff's fix merged with mine?
>>> Apparetly your setup is much more capable of triggering these issues
>>> than mine...
>>
>> I get the same sort of thing on t0090-cache-tree.sh with -v -x,
>> i.e. failures due to:
>>
>>      error: index uses �)�? extension, which we do not understand
>>      fatal: index file corrupt
>>
>> It turns out that my inability to reproduce that earlier was because I'd
>> forgotten to set GIT_TEST_SPLIT_INDEX=yes in the environment for that
>> while loop, so I wasn't testing the split index at all.
>>
>> I'm now running the tests in a lop with 6c003d6ffb cherry-picked on
>> top. I'll report back when I have enough data to say if/how it helped.
> 
> I got 436 OK runs with that and 3 failures before I gave up and ctrl+c'd
> it. And the 3 failures were:
> 
>      t3903-stash.sh               (Wstat: 256 Tests: 90 Failed: 1)
>        Failed test:  55
>        Non-zero exit status: 1
> 
> So it's back to failing on the same test as before your patches.
> 
> I did try merging in "pu" to get git-stash in C. There I had 2 failures
> and 135 OK before I gave up. The C version failed tests 5 & 20, so there
> may be some new regressions in the C version related to this.
> 

Sorry for late replay. I have been pretty busy these days.

Indeed, test 5 & 20 also causes problems for me. I tried to find the 
root cause, but, unfortunately, I couldn't.

For test 5 (`apply does not clobber working directory changes`), it 
seems that `git stash apply` works when it should fail.

When test 20 (`stash -k`) fails it acts like `-k` wasn't specified. In 
the following code path (or Github link below), it seems that `out` is 
not filled with names of modified files.

	cp1.git_cmd = 1;
	argv_array_pushl(&cp1.args, "ls-files", "-z",
			 "--modified", "--", NULL);
	add_pathspecs(&cp1.args, ps);
	if (pipe_command(&cp1, NULL, 0, &out, 0, NULL, 0)) {
		ret = -1;
		goto done;
	}

Github link: 
https://github.com/ungps/git/blob/git-stash/builtin/stash.c#L1358

I will look more into it tomorrow.

Best,
Paul
