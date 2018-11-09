Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53BB1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 02:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeKIMiW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 07:38:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMiV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 07:38:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so351641wrr.0
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 18:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xhMlVam9QVhhunpGPp7Y4Uvd4IeEKACeTpnwyBwzBso=;
        b=LNEOVNsyKXq392LmFKBvy+RdGgCnSktJIHBRoTQQz+9aNVbx6Bu4GIHPW5kB10Ih7F
         7GV59xTPlGHMvVh9f51HrSDA1EskHouUy3chBXdbFxomoHWAdg20n6zsdIqgNKT0l8bg
         smoOHYMY9VqHA6JwoOe51kFhue0cjxV2cHmbNSdBIe5astw6ErEkSpBL+cARISWJWBz8
         kk9O2+6iBTtj9nK+Rg407D1hjnO094dgMWLOkb3d9bPvUGYgMmE/pBJZQNg4q8JedwTG
         sneafezf7vH/yS38DvMXLtjDOWoiqUfZPUgxCqPDCMCfmHGB1bybbQ3l8LDfolBjniGz
         kKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xhMlVam9QVhhunpGPp7Y4Uvd4IeEKACeTpnwyBwzBso=;
        b=rhMqjXiKZCN03SuVtSbrV9lCsKITZY5BNAGRp+1qJHSga77trBEua8JZF2yQIfoHg9
         f9M0y8v4nomS4728vhQfg9+9ORfZlEidTi75tOMsyvsIn7DrSsEw3p53SnjcyvZdG5tv
         goVJiQapg1K6bvjji9KnnIkvZ7Q0L2ag7TkiUAWmCmpD8cskUN1iIhwoDEkPmiw2VZC0
         1GLUvnTYYDIKdHpQSn55dVQ0rflLnLLYPB652R2sT0I7viwgvGTmOIxh21niCsXKGTlW
         J7K3JlRKb18PYEHFg2luEiuHt1aIP8PO7n6DBdXpSsaJu/gYBHrTKLcNl95OOPEdQO4S
         y8YA==
X-Gm-Message-State: AGRZ1gLgHh88Wjw6NWdj9WmemdNkeAWjsqr7/6DLMfSFeOt095BsHeVB
        gMjmRAlZvAwI9ne5QdfDLTs=
X-Google-Smtp-Source: AJdET5fgAdkjmplNg3EWMRaJ8Co9+10uuxAJTRXnACjNpYbkP5SXi32IjYr3v1gSGjD5W8L3QHnncQ==
X-Received: by 2002:adf:b453:: with SMTP id v19-v6mr6206517wrd.47.1541732386002;
        Thu, 08 Nov 2018 18:59:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 78-v6sm143019wma.38.2018.11.08.18.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 18:59:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: install packages in 'ci/install-dependencies.sh'
References: <20181026013949.GN30222@szeder.dev>
        <20181101114714.14710-1-szeder.dev@gmail.com>
        <xmqqa7msrzaq.fsf@gitster-ct.c.googlers.com>
        <20181108215133.GC30222@szeder.dev>
Date:   Fri, 09 Nov 2018 11:59:43 +0900
In-Reply-To: <20181108215133.GC30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 8 Nov 2018 22:51:33 +0100")
Message-ID: <xmqqr2fv5528.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> > I'm not sure about the last paragraph, because:
>> >
>> >   - It talks about presumed benefits for a currently still
>> >     work-in-progress patch series of an other contributor, and I'm not
>> >     really sure that that's a good thing.  Perhaps I should have
>> >     rather put it below the '---'.
>> >
>> >   - I'm confused about the name of this Azure thing.  The cover letter
>> >     mentions "Azure Pipelines", the file is called
>> >     'azure-pipelines.yml', but the relevant patch I link to talks
>> >     about "Azure DevOps" in the commit message.
>> >
>> > Anyway, keep that last paragraph or drop it as you see fit.
>> 
>> I hope we'll hear from Dscho in one or two revolutions of the Earth
>> ;-)
>
> ... revolutions around what? :)

Originally I meant its own axis, but perhaps the moon.


