Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66171F42D
	for <e@80x24.org>; Tue, 29 May 2018 05:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754430AbeE2FuJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 01:50:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeE2FuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 01:50:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id 18-v6so31381653wml.2
        for <git@vger.kernel.org>; Mon, 28 May 2018 22:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=im5+ynkzwDQ+LUBkYXtLxan+SxIRhKR11oj9LAlfuQo=;
        b=C6D0Lo6J0zY5dd1NcI6ZEvjdjyPAgW0EofCH/Xc+0BgEJgYotu0ELoH5WufglUIaD3
         3gr9EzLFWNcj2e/2obNcrhkaRTAsYY5pAuwUtO9TTSZE5WyMeFh3L52ebksoZvPm2OWD
         5+Q0IF181TYgDmvkj4OgKBdW5qCxGFmCGrxwKCQAir6Ev5QDOxF3u849pTmbE3dqVNNq
         PbV8bCHZlm9SNRjVn8olIGVxtvVV7AhUACCJiIV2MfGDAjDwMq4793lYocTdQfrbJiQF
         SYDUWSkT7uCSiH+K6sN+HmDL6kDxxpDiFeTLJNSmUC/xARjacrVOqsJ9ecAouH4hNUVo
         1sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=im5+ynkzwDQ+LUBkYXtLxan+SxIRhKR11oj9LAlfuQo=;
        b=XSqRRQyS9R5nN+GV+ze4WN+zawiVbH3c5o+8JHJy51twtnixpPoaoTNptxPWgN/Pm2
         mrTpivn7AQwcl9Cj3s8TnF3ePoodY3efaOPc1xOWAojLe7fm1YxhkRZDV2O/0HcHCtHq
         Kvjq26LvG4Zg5nw5wLNdj686yNEbYo7f3M2vGEsk91+dPtL6m82D9BM9drkBX1ZfftNO
         gfLWAUvYqJhRyQfuA9Ts+f46EfIM5tcSBIqWWbccY9QlcoFzh11rHL+DpPLPeQTAO8wM
         dBAw4RFBXoVm6iJjC6fp8YXV8K7U7GP2tabnei5bPPxr+pvyfZqu9eNoTmGCXrerAR5x
         2dUA==
X-Gm-Message-State: ALKqPweJFG0mN3FVZNTJHDBEkp2yvJKNobf/DsTWaIZDw+PAqGHgG/Nb
        vGnFc6T5m33yxItJlFr0s4s=
X-Google-Smtp-Source: ADUXVKIjurcKu2+K8KGYa8kKssHLfsIsYu3fW7xtbuuZGtUh4du/RU0DmiOR4WbuMkd/j3p2+vPJTg==
X-Received: by 2002:a1c:8cc8:: with SMTP id o191-v6mr5970564wmd.75.1527573007351;
        Mon, 28 May 2018 22:50:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r200-v6sm19390629wmb.39.2018.05.28.22.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 22:50:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just the first
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
        <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
        <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com>
        <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
Date:   Tue, 29 May 2018 14:50:06 +0900
In-Reply-To: <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 29 May 2018 06:49:39
 +0200")
Message-ID: <xmqqtvqrggdt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>>  - allow callers to align 1st prefix (e.g. "error: ") with the
>>    leading indent for the second and subsequent lines by passing the
>>    second prefix with appropriate display width.
>
> I suspect this second prefix would always consist of
> strlen(first_prefix) spaces? We should be able to construct it on the
> fly, without any need for manual counting and human mistakes.

I wouldn't be so bold to claim that, given especially that we are
talking about i18n/l10n where byte count, character count and
display width are all different even on a terminal with fixed-width
font.


