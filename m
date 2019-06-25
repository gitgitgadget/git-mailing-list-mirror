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
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA5C1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFYNfy (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:35:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40569 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfFYNfx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:35:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so17903435wre.7
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yw4hG50qN2MKmnCZD/liGJWz2licCt3Wan5Dbvea/v0=;
        b=TLXURRzKWuYs9fvlmwLyO2nUGq6kv5R+rE+nSTkOuqMnIKfWyxNMI7n5esB+9Yg3/o
         60hYEhXeKGJJyA3220W3uPA2iahWBAmRLttK06jmNMole2nDc29YLkiV9TCTH8c8C5cx
         OIpcYuyEWeGuyHl8946X7/vX17u7sgdHCnC1UQYh46hVdMhQ+R2oCA3vIT5z2qSXvtVX
         mExbtqXyrGlC0M6B+g+I+84ixIxz2NqHGJEJ2UkjzAUNmoAXRr2hU6lYaxzV9imEqlhp
         xNKnPXpB8fG8jKfVa+hvSFgZHPUWGwGqEp3CiWt2wJRy15LBM/27EhyB7yzDwVoHZ9JS
         QLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yw4hG50qN2MKmnCZD/liGJWz2licCt3Wan5Dbvea/v0=;
        b=Ynz+Qmx3bdEF0kBBUfopqzOYPjqUkgI5Y9MfWy8kH9bN10y4b6l6cc8UMUE7EPq13Q
         DGMTlaieE22d6KQRAZrBsqlBcUjqVG5aCasL4sglwDwMKuhmO57ZY5d7KWWUcp/BXX3K
         DHhJ3EQ4ENxxflY1SWKlCH8AwG/fh5jFegxhvjDzFT75V4FNToYPH61RIVWrefs9UMGE
         zOAdxpvZ2UoAXiKIMxB5cy3QINVF6iYA4nvlkSBTeAgtqp0Az4mV8SyIc6jbGbIpLA76
         idWtmtlnd1KEfTV0DuENcBNBLPdaMtXjPYvEV8C0RlvagMiHpK+F+mGG/3sHi054UkdN
         W0DA==
X-Gm-Message-State: APjAAAWq3RAlpFx4Pd+MXCIkAnW5pLrdRqOugU3ojxC7iW3Z6wJOYcqC
        LWjAqC9sNy5azoREb41OXrXCHl+3
X-Google-Smtp-Source: APXvYqzI+0rhnTw5Pi6I5UYrGnQ9tre27EV0nUDb3zfLnFnrMc9SlpTSL7Z2lAJ0CJHbN4bfsR4WJA==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr2676430wrs.151.1561469752263;
        Tue, 25 Jun 2019 06:35:52 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id j32sm32521622wrj.43.2019.06.25.06.35.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:35:51 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
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
 <nycvar.QRO.7.76.6.1906251336150.44@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ad93318f-7304-2b99-2fe6-7c03d91989e2@gmail.com>
Date:   Tue, 25 Jun 2019 14:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906251336150.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 25/06/2019 12:38, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 25 Jun 2019, Phillip Wood wrote:
> 
>> On 24/06/2019 19:39, SZEDER Gábor wrote:
>>> On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
>>
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
>> 79a6226981 ("rebase -i: silence stash apply", 2017-05-18)). I can have a
>> think about a better way to do that, but is it still a problem? I just
>> tried to take a look at your CI output and
>> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11406
>> seems to be all green - have I missed something or has Gábor fixed the
>> issue?
> 
> AFAIU the test cases were patched to accommodate for the new output.
> Ideally, they would be changed to not need any changes in the future,
> certainly not to accommodate changes in unrelated areas (such as the
> progress).
> 
> So yes, the build is green, and the patches are probably good to go, but
> there is room for add-on patches to clean up the test cases to test
> succinctly what they are supposed to test.

Thanks, I'd missed the point entirely! As I said in my reply to Gábor, I 
think testing the whole output does have some use, but I can see that it 
would be very good to get rid of the whole Q thing

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 
