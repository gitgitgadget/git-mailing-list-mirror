Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581072035F
	for <e@80x24.org>; Fri, 28 Oct 2016 20:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756771AbcJ1UxA (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 16:53:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755922AbcJ1Uw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 16:52:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BA1A4A1E0;
        Fri, 28 Oct 2016 16:52:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wW4lj+S7vE0RT/Lqfs6y5hiH2QY=; b=qxKta8
        asC3OZh07uoppbvs387rpHziqI/Uwe2G5/1QIP5HICJKjZC06evdRgb1cM6MWQU7
        jrhVyZNL4byLKwJrGN7NaYIKL4zkcvYjpwFpULmtHLcvvEba3sTtHDgyFS3SJ39Z
        0xNNlSgLg68Zd/NOcC2i0paBKqMNyEAR/stLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UHFVdIM/emYZ/C06AJVSpMzfJ/fAAe5b
        WXILYWUM33ygNnIGAojpT2ZjJ/ZZdOLlYYpCOHWZbrsvXRZ8l7hPoXw1zWHpZx7r
        7t4TxDKLrO9Fh8hWEOYPagkUY53iwS+XYZqijfI5pzb3JE7Wo9QT0hSBNQzzNVI/
        UZTvFIHgTcQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 339124A1DF;
        Fri, 28 Oct 2016 16:52:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A329C4A1DE;
        Fri, 28 Oct 2016 16:52:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
References: <20161026215732.16411-1-sbeller@google.com>
        <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
        <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
        <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
        <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
        <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
        <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
        <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
        <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
        <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
        <alpine.DEB.2.20.1610281356310.3264@virtualbox>
        <CA+P7+xoyF8EG079eC-dfTSj+YrbxhPWx356-jZ90gDs6SwyppA@mail.gmail.com>
        <38b70094-5550-8512-7735-a6739f435803@kdbg.org>
        <xmqqr370z07v.fsf@gitster.mtv.corp.google.com>
        <ab4c8148-2124-f08d-a770-e4f4e49a1c15@kdbg.org>
Date:   Fri, 28 Oct 2016 13:52:55 -0700
In-Reply-To: <ab4c8148-2124-f08d-a770-e4f4e49a1c15@kdbg.org> (Johannes Sixt's
        message of "Fri, 28 Oct 2016 22:49:04 +0200")
Message-ID: <xmqqbmy4yz4o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81878B54-9D50-11E6-A36D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 28.10.2016 um 22:29 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Another problem with the proposed patch is that there is no
>>> declaration for attr_start() before the call in compat/mingw.c. We
>>> would have to move the declaration of attr_start() to cache.h (for
>>> example), because #including attr.h in compat/mingw.c is plainly
>>> wrong. However, it would not be a major offense to #include attr.h in
>>> common-main.c. But when we do that, we can certainly spare the few
>>> cycles to call pthread_mutex_init.
>>
>> That sounds like a good argument to have it in common-main.c.
>>
>> Would it mean that the code that defines the mutex needs to have
>> #ifdef that defines a no-op attr_start() and defines the mutex with
>> PTHREAD_MUTEX_INITILIZER with #else that just defines the mutex
>> without initializatin, with the real attr_start(), though?
>
> No. My intent was to call pthread_mutex_init for all platforms.

Ah, OK, so there was no magic plan.  That's OK.

