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
	by dcvr.yhbt.net (Postfix) with ESMTP id 132BB1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfFYNdi (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:33:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYNdd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:33:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so17939494wrl.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHBLVgIN2uad6PpYN4omzLpvgV01tRlZnR4Uu5inakg=;
        b=k9QvWbdSl9BvyMBkkEIyEXX+xsZJ6NOZBuRLGrkdUG3rYeaTuzkUZ7KgaTH+kBvhGf
         xtjspWaN3TnykfC2HbTiu0Zu8aeHVmizvzxrQejUmb1WQD4qLNEcbCzPCKKrGCHVcLVo
         th2fC+HzGPNSdAWa2McPQ5xCs2xID+Y2L4VC8pt9TElRoLbsGb+jQTpVbvx8HW9A8uQu
         SX9M1f17+pnGn3ZMpMQETi6yPK/KqsqvSZqnHNJXxA0vprUnXlSFqBmCE6G58skGCGFx
         E3gPhaRq8VRKnJHsbzKvR2sDOtewFK3DbwAQ9j4Q4bPOtVkdhnwV3XiW8FreCIrfB/3q
         549w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yHBLVgIN2uad6PpYN4omzLpvgV01tRlZnR4Uu5inakg=;
        b=k5kcm8WQaEcvDNcRNAdIAyl1TxdhhUpL1b/vo1dcPqRCyZcLlI6U8eeSn0Hm10DKVf
         mZJ7FxGTw3G9P6kERRVbOGLvJv48BMAr4ntGD08TUCvPrdCllMEkhvsE6JNsCSYq7SyG
         +KADSaRn+OMSB/JLtm08dQurIXnvWgLbvpCGqvHZmi5KiTD8w2NpXtU84kmEQKUTrish
         ld600+2epE1ap0XBQ7cAL209ihR+xxKDlKymrEyuyIBGYlMQCt1fyx/4Ax1KZJ5IIOJC
         J2243aY+vcjlciUIwjOR35m+lnwDdeiU+uVpE94GzHzbae2SJEGO7g0ShPVqTrGcfo+R
         3Dqg==
X-Gm-Message-State: APjAAAVNBijimcStmJVJ6h1gYshKZIsjsEVbv/PkLM0IKZq9WiGqHz1I
        m3rFGJ7zkCVnCAxWI8MvZFIJbzafjA0=
X-Google-Smtp-Source: APXvYqydeBiczdHmc5is9WT8xhNK+vNtyZgBovjMTKgSRtkp8IDbsknVjva+QcpF9O6X4NaZ41vB0Q==
X-Received: by 2002:adf:d843:: with SMTP id k3mr3097396wrl.332.1561469610368;
        Tue, 25 Jun 2019 06:33:30 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id l4sm1772196wmh.18.2019.06.25.06.33.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:33:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
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
Message-ID: <a6aef2a0-bacd-9af2-0e96-9048da6c9a93@gmail.com>
Date:   Tue, 25 Jun 2019 14:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625113103.GB10853@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/06/2019 12:31, SZEDER Gábor wrote:
> On Tue, Jun 25, 2019 at 11:08:04AM +0100, Phillip Wood wrote:
>>>> Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
> 
> 
>>>> May I please *strongly* suggest to fix this first? It should
>>>>
>>>> - completely lose that last line,
>>>> - be inserted into the test case itself so that e.g. disk full problems are
>>>>    caught and logged properly, and
>>>> - the `test_i18ncmp expect actual` call in the test case should be replaced
>>>>    by something like:
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
>>>    16 - rebase --merge --autostash: check output
>>>    23 - rebase --merge: check output with conflicting stash
>>>    26 - rebase --interactive --autostash: check output
>>>    33 - rebase --interactive: check output with conflicting stash
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
>    git rebase --options... >out &&
>    test_i18ngrep ! "<something specific that only 'git stash' would print if it wasn't silenced>" out

Yes we could do something like that, but I think there is merit in 
testing the whole output as it catches any changes that accidentally 
start polluting what the user sees. It also means that any changes to 
the output are deliberate. It may be a pain to have to update a test 
case when the output changes but at least it ensures the change was 
deliberate. I'm not sure what we can do to get around the problems that 
in creates for unrelated changes such as this series.

>> I can have a
>> think about a better way to do that, but is it still a problem? I just
>> tried to take a look at your CI output and
>> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11406
>> seems to be all green - have I missed something or has Gábor fixed the
>> issue?
> 
> No, it was Dscho who fixed the Azure CI issue, see
> 
>    https://public-inbox.org/git/nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet/
> 
> elsewhere in this thread (it's a long one, but well worth the read
> IMO).


Thanks for the pointer, I'll have a read

> However, the point here is not that Azure CI failure, but rather the
> fact that tests had to be updated to include the new line clearing
> sequence in the expected output, and that "Q<...80 spaces...>Q" looks
> yuck indeed.

Ah, thanks for explaining

Best Wishes

Phillip

