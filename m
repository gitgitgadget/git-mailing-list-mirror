Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553BC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3238124676
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sbwf1htd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLST5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:57:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65389 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLST5u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:57:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D581E97B35;
        Thu, 19 Dec 2019 14:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6iK+y5oLRZIFWjWQTXa6lqHe7Fg=; b=Sbwf1h
        tdkdZ+qo0urUe5iF3yvl0SAXZQALD2hXZPAFXhUvFL1pPcxiS/In+dATDMb/jMk5
        7fX1MFRltRyQ0Q2tMYwXI2AUH5Se1JtRgT1GNz2zjDK/5NbBzJ+9AxWTcZR7D8qn
        NcSz7LA9pdomFWFcZdyMyGv2ildlVd9iGBzd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lgaotsgnwMr2UXMCrbBtcV59I/EnQtdG
        SvW8PU2UH6SQhZrXXrhCDNdhUGofyd+3/Zk+4EdfgLoWzF2Krq6J7Wzc/ZQSsl+j
        o0jFMiCq+6XHVgjSSV7dQij7J9y5dLmv5lZ4hekP8PuiEWdtJVLbn4+5Cpj19EZK
        yIXjSPfi8kA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD16497B34;
        Thu, 19 Dec 2019 14:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F178B97B24;
        Thu, 19 Dec 2019 14:57:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
        <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
        <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com>
        <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQZBXOZeYDJRH+9YLobTOP1_UndV_Snk+S0_LL1=h-aag@mail.gmail.com>
Date:   Thu, 19 Dec 2019 11:57:42 -0800
In-Reply-To: <CAPig+cQZBXOZeYDJRH+9YLobTOP1_UndV_Snk+S0_LL1=h-aag@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 19 Dec 2019 14:47:49 -0500")
Message-ID: <xmqqy2v89jgp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2CA225C-2299-11EA-A4A9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Dec 19, 2019 at 2:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>> In any case, here is what I tentatively have in my tree (with heavy
>> rewrite to the proposed log message).
>>
>> +test_expect_success 'commit without staging files fails and displays hints' '
>> +       echo "initial" >>file &&
>
> The use of '>>' here rather than '>' feels wrong, especially when
> "initial" is used for both the file body and the commit message,
> causing a reader of the test to wonder if this test somehow depends
> upon earlier tests.

Yeah, makes sense.  This was verbatim from v1 but I think starting
the file from scratch like you suggest makes it clearer what is
going on.


>
>> +       git add file &&
>> +       git commit -m initial &&
>> +       echo "changes" >>file &&
>> +       test_must_fail git commit -m update >actual &&
>> +       test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
>> +'
