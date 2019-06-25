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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3C01F461
	for <e@80x24.org>; Tue, 25 Jun 2019 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfFYSAs (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 14:00:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfFYSAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 14:00:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so17720067wrs.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wfA+CX6w2ZK+NZAZkHOuM4D7xwNaQwRcYi0lQK5WGdM=;
        b=W/MdIHd699FyFfDEp/rvyFSYgg5nDiKURBWnHWiSfzEC1neaaCUTjEnfi8lB6/0Avn
         QwzX+vz61t0WBMBQHioAxiKMYDz1182p1p+8aMJyPnog931VEEZgH+ahkBLaPDsoCa4L
         LpTyVjvRaeSWVBe2aE2W5jmf5IxD6E19NBvePrvjSLlc17zznNDxa/2MsC7O/nDTXO+r
         koqq9izIWrpL12AX8sWrUKm0oARLxoJwBosMFH/LyoDQmUTzXrlxTnqR511L0k7pROrT
         4F96rvMVo1PhO8Tz7bBXOwRkqJyXwSCl9S22AFqwUojhMbAzBw829FeIBX+fwreOikH0
         Qvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wfA+CX6w2ZK+NZAZkHOuM4D7xwNaQwRcYi0lQK5WGdM=;
        b=YrdYIDOWgilC6yg9PbLFf/JhVdgAwk0RJ/arIG1ZF/NMAVE30PINblRaCSywP/Vj4g
         kD/E5xaZDU4bD1LxMdp0g6IHLgLIEkM7d6aB8nwMtv8tWdG612CQWezMc2geLPtFQcKu
         R5iNB8zl1phvAzWpXaCSryPNo9lEGAYJDCsdGKCMKMULrUQWH5DXVXFF9J/BOCT1ucXN
         a1kLnOY3vXne7QG2la4ISqLJ1Zu2Vu9Plt85j82kaBhnDgnx/OKgB2vgAjux/4B0+mkA
         VDrGtQwCUuLW7chJoKGOeYvA9BkU6ss+uw/t3kMNKmwaTYYJR0SlQCT+7rA1ONTRTYh6
         QJcw==
X-Gm-Message-State: APjAAAUZ1VDcHxqv3UY1B/5B3M6FuKvYMBHDlCliQjtDkM0TqiarCTDv
        0DUQnRZSzmLz2tYmVDTjeYGp98DfHgw=
X-Google-Smtp-Source: APXvYqw8bwV3MKHPBfl4P0YLDTK4ICfYBmmTOGkZXvWujZlLbfKZQMJX9fLMx7qZrif+7fg7eNuiog==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr54157471wrp.353.1561485645072;
        Tue, 25 Jun 2019 11:00:45 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id z5sm3137723wma.36.2019.06.25.11.00.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 11:00:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190624183927.GA10853@szeder.dev>
 <efc4a141-071a-6549-f25d-21cc6256832a@gmail.com>
 <20190625113103.GB10853@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <573b9280-939b-879e-6e5e-b63779836740@gmail.com>
Date:   Tue, 25 Jun 2019 19:00:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625113103.GB10853@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gábor and Dscho
On 25/06/2019 12:31, SZEDER Gábor wrote:
> On Tue, Jun 25, 2019 at 11:08:04AM +0100, Phillip Wood wrote:
>>>> Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
> 
> 
>>>> May I please *strongly* suggest to fix this first? It should
>>>>
>>>> - completely lose that last line,
>>>> - be inserted into the test case itself so that e.g. disk full problems are
>>>>   caught and logged properly, and
>>>> - the `test_i18ncmp expect actual` call in the test case should be replaced
>>>>   by something like:
>>>>
>>>> 	sed "\$d" <actual >actual-skip-progress &&
>>>> 	test_i18ncmp expect actual-skip-progress
>>>>
>>>> This should obviously be made as a separate, introductory patch (probably with
>>>> a less scathing commit message than my comments above would suggest).
>>>>
>>>> And that would also remove the double-yuck.
>>>
>>> Unfortunately, this addresses only one of the "Yuck"s; see v3 of this
>>> patch series [1].
>>>
>>> The other yucks affect the following four tests in
>>> 't3420-rebase-autostash.sh':
>>>
>>>   16 - rebase --merge --autostash: check output
>>>   23 - rebase --merge: check output with conflicting stash
>>>   26 - rebase --interactive --autostash: check output
>>>   33 - rebase --interactive: check output with conflicting stash
>>>
>>> These tests come from commits b76aeae553 (rebase: add regression tests
>>> for console output, 2017-06-19) and 7d70e6b902 (rebase: add more
>>> regression tests for console output, 2017-06-19), and are specifically
>>> about checking the (whole) console output of 'git rebase', so I left
>>> the updates to them as they were.
>>>
>>> In any case, Cc-ing Phillip to discuss whether something could be done
>>> about them (now perhaps preferably (for me :) as a follow-up, and not
>>> another preparatory patches).
>>
>> Those tests were added to check that `git stash` was being silenced (see
>> 79a6226981 ("rebase -i: silence stash apply", 2017-05-18)).
> 
> Hmm, so would it then be possible/sensible to do something like this
> instead:
> 
>   git rebase --options... >out &&
>   test_i18ngrep ! "<something specific that only 'git stash' would print if it wasn't silenced>" out
> 
>> I can have a
>> think about a better way to do that, but is it still a problem? I just
>> tried to take a look at your CI output and
>> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11406
>> seems to be all green - have I missed something or has Gábor fixed the
>> issue?
> 
> No, it was Dscho who fixed the Azure CI issue, see
> 
>   https://public-inbox.org/git/nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet/
> 
> elsewhere in this thread (it's a long one, but well worth the read
> IMO).
> 
> However, the point here is not that Azure CI failure, but rather the
> fact that tests had to be updated to include the new line clearing
> sequence in the expected output, and that "Q<...80 spaces...>Q" looks
> yuck indeed.

I've come up with a sed based solution to remove the progress
notifications from the output - see
https://github.com/gitgitgadget/git/pull/276 If you're both happy with
the basic idea I'll clean it up and submit it (I've just noticed I left
some debugging bits in one of the tests). I was worried using "\r" in a
sed expression wouldn't be portable but the tests pass on gitgitgadget.
If it proves to be a problem on other platforms we could use always tr
to convert "\r" to some unique string and use that string in the sed
expression.

Best Wishes

Phillip

