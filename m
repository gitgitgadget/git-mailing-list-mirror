Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEBC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB80E22280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRQ5Mznb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKBWbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F8BC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n18so16374146wrs.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNo3HHFrvckJ2g1JZzITLls5hIPnIl3q/krruX3HAY8=;
        b=JRQ5MznboXSRgUuZSNEn0KzhrcmQnZRdvRxN4GL4eFUjEb13Ygyfdtf8QZRqN6yVbh
         UPnHk2opvxEdx3k4+ti1In1qyZW/vduwa/apm9UUqUNtw3FbfE6YSAYUPiMP0yz/5ky+
         ZGGLComYtLrdrqTjU8j6T4ct8QrORfx7s4iCCAiHGPuqn9Ua/s4FcXRvQA3lGIOeMJKw
         aAPC3a4dSkSW8EEJaY3fjsksh20N6PsMoL6wzRWiOCTd6bQd5e8MKUcIqwqKXfh1PmQs
         NyznamET8yiL/3Jp87eLVnrq8Gav9i+vvMGAJyxoqeWmz+PcvmWLeNmKY/x7wCGJyBof
         7umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNo3HHFrvckJ2g1JZzITLls5hIPnIl3q/krruX3HAY8=;
        b=QPhpfv6YyuNhYeZ5ons6d4QLHduclu1ZxFcVe5LCuNpTOPEzKQP0OgzjHF8ZdTDf9x
         4xxoSAJ7Ql3V0sjbB9X7MGr6t0UZzWWhE5rpumtRqkvwyC9KEll/ox1x3O4miaDKuJ+t
         oqeegsfwz8l/YZ+qBzp5k/NhdkfakZXCXUC7gWA+nPGYT6xt42ouCC3zNPFEWvla5tk4
         b+o67FSMOYo86QuZau5EPMwpgeW6wzZ6+mEt5/CM2nmnX4uY8xGtHEm65CQszhiVxHrv
         aiF9AYyU3mx7OFLASi5MckgVuYqeC9B2ed+AJB1SX0u9rqdG5nw9ZkHAVgFHVtOSvVNj
         XAUw==
X-Gm-Message-State: AOAM533FeTxp/aUYgXI3s6VwW9mevIeDKu5VYP2xy8zLcN43pp2LdYAS
        PaITRmUAqTfxXXZ/5jODxoQ5+Ny8cHQ=
X-Google-Smtp-Source: ABdhPJyLEK3V8rabbzkt1u5cxMtyFbWjQu/dE1cv1ShsQvgiCRZIAPvM9ZlQENYO7WSb5hlh0XW1Cg==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr23083373wrv.148.1604356292562;
        Mon, 02 Nov 2020 14:31:32 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-298-75.w86-199.abo.wanadoo.fr. [86.199.81.75])
        by smtp.gmail.com with ESMTPSA id x1sm23554924wrl.41.2020.11.02.14.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 14:31:32 -0800 (PST)
Subject: Re: ag/merge-strategies-in-c, was Re: What's cooking in git.git (Oct
 2020, #04; Tue, 27)
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011020333440.18437@tvgsbejvaqbjf.bet>
 <xmqqv9ensao7.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <693f417c-5612-7878-a055-2810f62af3b4@gmail.com>
Date:   Mon, 2 Nov 2020 23:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9ensao7.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Johannes,

Le 02/11/2020 à 22:36, Junio C Hamano a écrit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Tue, 27 Oct 2020, Junio C Hamano wrote:
>>
>>> * ag/merge-strategies-in-c (2020-10-06) 11 commits
>>>  - sequencer: use the "octopus" merge strategy without forking
>>>  - sequencer: use the "resolve" strategy without forking
>>>  - merge: use the "octopus" strategy without forking
>>>  - merge: use the "resolve" strategy without forking
>>>  - merge-octopus: rewrite in C
>>>  - merge-recursive: move better_branch_name() to merge.c
>>>  - merge-resolve: rewrite in C
>>>  - merge-index: don't fork if the requested program is `git-merge-one-file'
>>>  - merge-index: libify merge_one_path() and merge_all()
>>>  - merge-one-file: rewrite in C
>>>  - t6027: modernise tests
>>>
>>>  The resolve and octopus merge strategy backends have been rewritten
>>>  in C.
>>
>> From where I sit, this is ready for `next`.
> 
> I just went back to the thread.
> 
> https://lore.kernel.org/git/20201005122646.27994-1-alban.gruin@gmail.com/
> 
> It seems that the topic saw quite a few comments and help by Phillip
> Wood in its earliest iteration, but I didn't see any review from
> those other than myself on the last iteration v3, and the review
> comments on the iteration haven't been acted upon yet.
> 
> That was why I threw the topic in "needs review" bucket.  The later
> half of the series got no comments (I lost steam after reviewing the
> earlier half) and I suspect they would have be adjusted for fixes
> and improvements done to polish the earlier parts, so I am not sure
> where your "ready for 'next'" comes from.
> 
> Thanks.
> 

Sorry, I am short on time to work on this these days, but I’m still
planning to apply Junio’s latest suggestions.  So I agree with you, this
is not yet ready for `next'.

Cheers,
Alban

