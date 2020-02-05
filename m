Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F00C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052C214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="amp8xcYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBEVSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:18:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50924 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 16:18:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6F15AFC9F;
        Wed,  5 Feb 2020 16:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TDbjYdfwqRuG4rpdh/G+nxZeOUI=; b=amp8xc
        YD8OMzuVd3Q+jcjcgKA/QEb+UzG6CkU5at12bedPmwtAQIbW32qKR6Uu5Xc7oCpg
        D0FkquF4vzBl/buBKoefeFRjKpCwn3MKHASKP4EvTcKEyan/szIgTMUXVGsAZvqc
        6H323YiT6H3O4Xerj3EgF+lvVC+JtvAB+CMW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qt+pQhYEVSCmcAP4KNyAQf2dB9is86Rp
        mcCH0goJLzTuhTgQBFmAWdLyJdt1Fn2t1StBTDNj5DlYGeMv7SfmKFh3Nuq5PsjG
        QEY8JgqPhvCcLlmrngF+VtFkXBd7uBVS2kRYqQA1ir0tdihLmjwUKHqsTrv/m0c+
        cowE4H7Cs1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D08E7AFC9E;
        Wed,  5 Feb 2020 16:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9744BAFC9B;
        Wed,  5 Feb 2020 16:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] add: use advice API to display hints
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
        <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com>
        <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
        <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com>
Date:   Wed, 05 Feb 2020 13:18:32 -0800
In-Reply-To: <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com>
        (Heba Waly's message of "Sat, 1 Feb 2020 00:16:31 +1300")
Message-ID: <xmqq7e10hgwn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11395024-485D-11EA-8742-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> On Fri, Jan 31, 2020 at 10:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Heba Waly <heba.waly@gmail.com>
>> >
>> > In the "add" command, use the advice API to display hints to users,
>> > as it provides a neat and a standard format for hint messages, and
>> > the message visibility will be configurable.
>> >
>> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
>> > ---
>> >     [Outreachy] add: use advise API to display hints
>> >
>> >     In the "add" command, use the advice API to display hints to users, as
>> >     it provides a neat and a standard format for hint messages, and the
>> >     message visibility will be configurable.
>>
>> The topic has been in 'next' for the past week or so already.  If we
>> need to make further changes, please do so incrementally.
>
> Will do, thanks.

I was reviewing the draft of the "What's cooking" report and noticed
that this update is not there---did I miss one?

Thanks.
