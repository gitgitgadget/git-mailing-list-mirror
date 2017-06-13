Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D08A1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbdFMU6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 16:58:22 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34463 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdFMU6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 16:58:21 -0400
Received: by mail-io0-f196.google.com with SMTP id a96so14293695ioj.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c+9tqsNjS/WS9RpSUMP+YTKXRAc29Mz8sDW3i8OVJx4=;
        b=R/U4v9HBU+ikQT/0lcpcj5W3X0KyTe1RKE32ndYNb82KHlbxdMSUctZRs3KAXrAVlY
         TT0AmImBxM3Ynz/d4TDtM+ScB4g+4SPtmlRrqMsSORZ33E02eYaGrvdMeOr9QRtiPgdf
         TLyRMAcXktC9XF1s66s4Z2aThirGd95US3bO+wB59HLnch5y+ZmigKI4P+3t29brskgu
         ifXwen0y2YoU4F5E9632Eo6B5fR50wAoeAnBT8i6Wc1FRqwBw3v3ZUOlta437h93bYKN
         iw03o5aOgwFRusa6jK+fFeKvWZ5FCj272VhHw52p0A0dpEgBFYYLtsGyKcLNA08X6aBU
         O2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c+9tqsNjS/WS9RpSUMP+YTKXRAc29Mz8sDW3i8OVJx4=;
        b=kyVGs/VLL4qQRspjfADH40I5OA+tHh0KDeCxcKGdTtqmbiQZ/DeAftO8wG7tyUAPYy
         FeKHua8QPyn/zS0kj+dkRJ7yiIo5S6d/ky78GxJweBbSPdr0Y7EjaLkMhAJVjRXUZjYT
         ykTIF0pc/4F5iUCR7ReNhesvCUXDSQdfNCsJxQ7X0FIYitSJDdqoEDrNZ7J0p8m8zkNq
         5rG9vtP6QPOzEg+CKiY3Dgb8t54tkLt95MDtIbSMIYwcsqW1ekbvQyim3px98+xYhHvl
         UPB35M2BDZsjqTkyx9x/YcWBMsjv0jVeImjJ8u53/5l5ZT0Labb75rr5KrTr0zNnYK1B
         VKUA==
X-Gm-Message-State: AKS2vOz78mZDHu2Es1C/VTdI19ZejkoXvEq/UT4e5yMPda74Z/+tHa9T
        UmC3eQ7WFcVf6g==
X-Received: by 10.107.28.76 with SMTP id c73mr2381372ioc.142.1497387500925;
        Tue, 13 Jun 2017 13:58:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 73sm69918ion.11.2017.06.13.13.58.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 13:58:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 3/5] stash: add test for stashing in a detached state
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-4-joel@teichroeb.net>
        <xmqqa85b65a8.fsf@gitster.mtv.corp.google.com>
        <CA+CzEk8U6P58OqruPkP1HePFurNWjgf=Q-h=Hu57zoHpDeenmA@mail.gmail.com>
Date:   Tue, 13 Jun 2017 13:58:17 -0700
In-Reply-To: <CA+CzEk8U6P58OqruPkP1HePFurNWjgf=Q-h=Hu57zoHpDeenmA@mail.gmail.com>
        (Joel Teichroeb's message of "Tue, 13 Jun 2017 12:48:54 -0700")
Message-ID: <xmqq1sqn61w6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

>>> +test_expect_success 'create in a detached state' '
>>> +     test_when_finished "git checkout master" &&
>>> +     git checkout HEAD~1 &&
>>> +     >foo &&
>>> +     git add foo &&
>>> +     STASH_ID=$(git stash create) &&
>>> +     HEAD_ID=$(git rev-parse --short HEAD) &&
>>> +     echo "WIP on (no branch): ${HEAD_ID} initial" >expect &&
>>> +     git show --pretty=%s -s ${STASH_ID} >actual &&
>>> +     test_cmp expect actual
>>> +'
>>
>> Hmph.  Is the title automatically given to the stash the
>> only/primary thing that is of interest to us in this test?  I think
>> we care more about that we record the right thing in the resulting
>> stash and also after creating the stash the working tree and the
>> index becomes clean.  Shouldn't we be testing that?
>
> In this case, the title is really what I wanted to test. There are
> other tests already to make sure that stash create works, but there
> were no tests to ensure that a stash was created with the correct
> title when not on a branch.

Ah, OK.

Thanks.
