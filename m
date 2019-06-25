Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761021F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfFYKIJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:08:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55705 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFYKIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:08:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2159781wmj.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kdeuDxBXWyr6A9Au3hXQiCitG0S57pQm9lAlg4flMHY=;
        b=uVAEKAs+qeXg/YOKrrEya5+qZ+QFVUb4ChUryNwcRJQZuytGVLfocZ8Oc1IhR4xnr7
         TmdbrVQwEOlFww2toGUyxOeaU9jTZCePuBRsc+KQgQsj2H8DbYq0NPMf0NKa6Ddeu1FW
         tOhvUJgcqUkzuUsxJPFnLltIHpZy3deLPfN4+oGQW8Aw9F7CINCKnw8TRyvwIZulyzo5
         c8jCTf9X1Hv1fikyAHMXB4HyGGLd4TELs+EfmuYTaEeUaWpGplE7zWlDHLlfy8gFiIja
         kCektgm2Dba6g+pclQUBCeHDDIEkmRJ8sx7WQv6SNJg5RTLaY1V+Sc8rkvA+F21HR5W4
         CuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kdeuDxBXWyr6A9Au3hXQiCitG0S57pQm9lAlg4flMHY=;
        b=IXOj/xzky5KZ+4/mdTrbDFodPsGxgWSoumSWKAgGu7jBmkHVF7y9p9Ho+Fy6r32/s7
         5QHasuY4jz8g3RlqJByzQTFafA1Bm2HArz2IQSUOi+sg4lu9PO1ncr6am2jdOirPuTf8
         pq7hfm0irWJB+sI95uYSPr8E4IEo6caNDuRH2fjUn5UD8NwU7EkDgF/NfO0LAaseyq9G
         pZ4/qciaflTThGhoAzDnG51U1Ye+llLCNc7793PEHZ9JoLXl5oJr9k6lv7qS48easnIb
         vpjGUUAOBnuRxSSEFadDw7WFwpzK5qd7hpxZT1kkfk5dZdUAN1yx7AsYjqpDrXlcUTSf
         af9g==
X-Gm-Message-State: APjAAAVttuydMTwPm3PwlB6NT8SHlzatskXKmmhRmkLaQRoybbJeuYuQ
        1rLEZopEv4QcVwc1rvpIoqoFWSor
X-Google-Smtp-Source: APXvYqxv6IW1jy3OjLGvFPA3byR5XB6ZIkxTsmX8WH5Yl7n4+3Q41+HGk8/9xQ37CNjukXBcZYUafg==
X-Received: by 2002:a05:600c:303:: with SMTP id q3mr19719766wmd.130.1561457286051;
        Tue, 25 Jun 2019 03:08:06 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id p26sm34675764wrp.58.2019.06.25.03.08.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:08:05 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190624183927.GA10853@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <efc4a141-071a-6549-f25d-21cc6256832a@gmail.com>
Date:   Tue, 25 Jun 2019 11:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624183927.GA10853@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho and Gábor

On 24/06/2019 19:39, SZEDER Gábor wrote:
> On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 11 Jun 2019, SZEDER Gábor wrote:
>>
>>> On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
>>>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>>>
>>>>> -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
>>>>> +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
>>>>>  EOF
>>>>
>>>> Yuck,
>>>
>>> Oh yeah...
>>>
>>>> ... but I do not see how else/better this test can be written
>>>> myself, which makes it a double-yuck X-<
>>>
>>> Perhaps hiding those spaces behind a helper variable e.g.
>>> 'dump_term_clear_line=Q<80-spaces>Q' and embedding that in the here
>>> docs specifying the expected output in these three tests could make it
>>> ever so slightly less yuck...
>>>
>>>> Are we forcing out test to operate under dumb terminal mode and with
>>>> a known number of columns?
>>>
>>> 'test-lib.sh' sets TERM=dumb relatively early on, and in these tests
>>> we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
>>> term_columns() defaults to 80.
>>>
>>> However, if the terminal were smart, then we would have to deal with
>>> ANSI escape suddenly popping up...
>>
>> And I fear that is *exactly* what makes
>> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=10539&view=ms.vss-test-web.build-test-results-tab
>> fail...
>>
>> You cannot easily see it in that output (probably because of incorrectly
>> encoded Escape sequences in the `.xml` output), so I'll paste what I see
>> here, locally, when running `t3404-*.sh -i -V -x`:
>>
>> -- snip --
>> [...]
>> ok 99 - rebase -i respects rebase.missingCommitsCheck = ignore
>>
>> expecting success:
>>         test_config rebase.missingCommitsCheck warn &&
>>         rebase_setup_and_clean missing-commit &&
>>         set_fake_editor &&
>>         FAKE_LINES="1 2 3 4" \
>>                 git rebase -i --root 2>actual &&
>>         test_i18ncmp expect actual &&
>>         test D = $(git cat-file commit HEAD | sed -ne \$p)
> 
> [...]
> 
>> ++ test_cmp expect actual
>> ++ GIT_ALLOC_LIMIT=0
>> ++ test-tool cmp expect actual
>> diff --git a/expect b/actual
>> index 05fcfcb..9555e34 100644
>> --- a/expect
>> +++ b/actual
>> @@ -6,4 +6,4 @@ To avoid this message, use "drop" to explicitly remove a commit.
>>  Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
>>  The possible behaviours are: ignore, warn, error.
>>
>> -Rebasing (1/4)^MRebasing (2/4)^MRebasing (3/4)^MRebasing (4/4)^M                                                                                ^MSuccessfully rebased and updated refs/heads/missing-commit.
>> +Rebasing (1/4)^MRebasing (2/4)^MRebasing (3/4)^MRebasing (4/4)^MESC[KSuccessfully rebased and updated refs/heads/missing-commit.
>> error: last command exited with $?=1
>> not ok 100 - rebase -i respects rebase.missingCommitsCheck = warn
>> #
>> #               test_config rebase.missingCommitsCheck warn &&
>> #               rebase_setup_and_clean missing-commit &&
>> #               set_fake_editor &&
>> #               FAKE_LINES="1 2 3 4" \
>> #                       git rebase -i --root 2>actual &&
>> #               test_i18ncmp expect actual &&
>> #               test D = $(git cat-file commit HEAD | sed -ne \$p)
>> #
>> -- snap --
>>
>> (I copy-pasted this from the output of `less` so that the control sequences can be seen.)
>>
>> To be utterly honest, I really fail to see a reason why a test case that
>> purports to verify that `git rebase -i` respects
>> `rebase.missingCommitsCheck=warn` should fail when the progress is shown in an
>> unexpected format.
>>
>> It strikes me as yet another poorly written test case that fails to catch the
>> intended regressions, instead it catches a bug *in the test case itself* when
>> legitimate changes are made to the progress code.
>>
>> Nothing in a test suite is worse than a test that fails (or succeeds) for the
>> wrong reasons.
>>
>> To make things even worse, the code that generates that `expect` file is
>> outside the test case.
>>
>> Here it is, in its full "glory":
>>
>> -- snip --
>> q_to_cr >expect <<EOF
>> Warning: some commits may have been dropped accidentally.
>> Dropped commits (newer to older):
>>  - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
>> To avoid this message, use "drop" to explicitly remove a commit.
>>
>> Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
>> The possible behaviours are: ignore, warn, error.
>>
>> Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
>> EOF
>> -- snap --
>>
>> May I please *strongly* suggest to fix this first? It should
>>
>> - completely lose that last line,
>> - be inserted into the test case itself so that e.g. disk full problems are
>>   caught and logged properly, and
>> - the `test_i18ncmp expect actual` call in the test case should be replaced
>>   by something like:
>>
>> 	sed "\$d" <actual >actual-skip-progress &&
>> 	test_i18ncmp expect actual-skip-progress
>>
>> This should obviously be made as a separate, introductory patch (probably with
>> a less scathing commit message than my comments above would suggest).
>>
>> And that would also remove the double-yuck.
> 
> Unfortunately, this addresses only one of the "Yuck"s; see v3 of this
> patch series [1].
> 
> The other yucks affect the following four tests in
> 't3420-rebase-autostash.sh':
> 
>   16 - rebase --merge --autostash: check output
>   23 - rebase --merge: check output with conflicting stash
>   26 - rebase --interactive --autostash: check output
>   33 - rebase --interactive: check output with conflicting stash
> 
> These tests come from commits b76aeae553 (rebase: add regression tests
> for console output, 2017-06-19) and 7d70e6b902 (rebase: add more
> regression tests for console output, 2017-06-19), and are specifically
> about checking the (whole) console output of 'git rebase', so I left
> the updates to them as they were.
> 
> In any case, Cc-ing Phillip to discuss whether something could be done
> about them (now perhaps preferably (for me :) as a follow-up, and not
> another preparatory patches).

Those tests were added to check that `git stash` was being silenced (see
79a6226981 ("rebase -i: silence stash apply", 2017-05-18)). I can have a
think about a better way to do that, but is it still a problem? I just
tried to take a look at your CI output and
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11406
seems to be all green - have I missed something or has Gábor fixed the
issue?

Best Wishes

Phillip

> 
> 
> [1] https://public-inbox.org/git/20190624181318.17388-3-szeder.dev@gmail.com/T/#u
> 

