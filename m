Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7831F424
	for <e@80x24.org>; Thu, 26 Apr 2018 02:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeDZCL4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 22:11:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38324 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDZCLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 22:11:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id i3so10062326wmf.3
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 19:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MYfDuTBMpAN/wPWkgvi1P5cGtSLIBjdDtVeJMNck4Ow=;
        b=fxsDiSGH4A3Oxawl3kCsfEq1yAV40Fa+R5mcLeqhK2LhDQ1xQo3BlElkmrdl/1i4ZT
         aujT9x8HDtbuojc4+6UlOBJvc84gauu6lGUbV932Vrp3flI351U84hydCNJgSRjOF+ti
         SuW6HyX3ycYspunfkSOfgJxVASnOdmS/MeUEdhABjJgEp+P4CB5TzDLuuZtQ/VGHGXHY
         leTfmFkmrtBnn4D5mvASug/NYePzKI89qqbisMDfRPryQ4AR0HzLVa5+dDeTCqdmuK6+
         Y52PlFoG/Um/BpEOLJgO+7GthELezEJuh1FhldVRqqIaFvDTjCqH3qOUL7BGa5Dt2tvk
         5Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MYfDuTBMpAN/wPWkgvi1P5cGtSLIBjdDtVeJMNck4Ow=;
        b=NMH7WotYG6kQtj1SEGKc/FJovyhrIXLeGy8rPIf5myjXMHUWsaj0GRgpxSHv8nLLOO
         CoqTa2HPu2YzVZZSLKtR3s4dUTAiZuUnLu1d9BmYUQeIgLcQHqUunlLctqs6NK0p/OmO
         5hM91DEW3aXj9MORwIBxwn4jr9NBe5obT59mymBrIRdeWHltBZGHSJWEx+DsjJEjzCOf
         BwGNajX4B/Qt1qhOOYIPvz/0T30hTNYB49UJ2okEf5QRuJRrdw+tw+gsuP+OqCvkuWmy
         MBr6g6cpUQD63/cLBkxwl31Qf87ux3XB+8wGxIDejO3tDoecPx6+yiXiJ8MMZca4oq9L
         GAWw==
X-Gm-Message-State: ALQs6tCBVYRr1oA7uTZ0qbc48F8Oj7ZBAMGqtRh10eowRuTZXWY0HMKB
        nZMcQ4O6ikDUQhY9I7wuUAQ=
X-Google-Smtp-Source: AB8JxZrCYvS2m+Qx7fuNBpvRe+5lilj0cFiATsH4qyiJ5WM/iSsZL5rnl0o3HIOW4Huuqu0ILdOwCA==
X-Received: by 10.28.139.11 with SMTP id n11mr2348783wmd.12.1524708713034;
        Wed, 25 Apr 2018 19:11:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q15sm2608973wmf.11.2018.04.25.19.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 19:11:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues with quoted pathnames
References: <20180318012618.32691-1-szeder.dev@gmail.com>
        <20180416224113.16993-1-szeder.dev@gmail.com>
        <20180416224113.16993-2-szeder.dev@gmail.com>
        <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com>
        <xmqqlgdljok5.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjkQfTm+qnurvZ_545VXJH2PwuPfkhXaa1sLj5ePSPjBwA@mail.gmail.com>
Date:   Thu, 26 Apr 2018 11:11:51 +0900
In-Reply-To: <CAM0VKjkQfTm+qnurvZ_545VXJH2PwuPfkhXaa1sLj5ePSPjBwA@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 26 Apr 2018 02:25:34
 +0200")
Message-ID: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> These new tests, however, are primarily interested in the inner
> workings of __git_complete_index_file() in the presence of escapes
> and/or quotes in the path to be completed and/or in the output of 'git
> ls-files'.  For these kind of tests we could simply invoke
> __git_complete_index_file() directly, like we call __git_refs()
> directly to test refs completion.  Then we could set the current path
> to be completed to whatever we want, including spaces, because it
> won't be subject to field splitting like the command line given to
> 'test_completion'.
>
> So, I think for v2 I will rewrite these tests to call
> __git_complete_index_file() directly instead of using
> 'test_completion', and will include a test with spaces in path names.

Quite well thought-out reasoning.  Thanks.
