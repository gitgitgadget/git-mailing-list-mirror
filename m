Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A440C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA65E2072C
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhA0Ngz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:36:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55935 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S313218AbhAZWd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 17:33:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46A229CD86;
        Tue, 26 Jan 2021 17:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0OaO/VYE6gdZKxjnbVx0QJbQc0c=; b=QTJqB8
        BvMul458+J/ApxMh0lwurrLF4SZ1S6jndQTIKeGbTP70jr4HqEoMR0jo0n03ZBft
        gwbj24Yop3prHmQl2tL/m841iRtI15t64hBBs2ipB+Cvevbwag+FIUZsTpws6LU9
        b30IOsoQ4F/wwJce3H2yRvDZFXRUjuwKTuaPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HTiN8jIv67nacEYZN7sEBbYYzjnOhIPO
        xWzjilxbKp4UjhPOTpk2FuRPLyQ+C+XJTawKg3icZWLzDiz1NB+EfWwuYVBZxGhh
        ILVEqg2JOgCxO4hWpttk0D7ZconxhmCWxzu+j94PpQySQVOMWoWnYxQTjs6uITlq
        uss5QbyhYqg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DADC9CD85;
        Tue, 26 Jan 2021 17:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E1EA9CD84;
        Tue, 26 Jan 2021 17:32:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] Finish converting git bisect to C part 3
References: <20210125191710.45161-1-mirucam@gmail.com>
        <xmqqh7n337nq.fsf@gitster.c.googlers.com>
        <CAN7CjDDQw-Vr_pV=yM0eRXi02F4LjcMfE-9gs5iLS_MU-JPYKQ@mail.gmail.com>
        <CAPc5daWO8JT1p0xhBtNyAjvy1hzjt3s-ho7LCPxEe-E_y8-a-w@mail.gmail.com>
Date:   Tue, 26 Jan 2021 14:32:29 -0800
In-Reply-To: <CAPc5daWO8JT1p0xhBtNyAjvy1hzjt3s-ho7LCPxEe-E_y8-a-w@mail.gmail.com>
        (Junio C. Hamano's message of "Tue, 26 Jan 2021 12:05:09 -0800")
Message-ID: <xmqqv9bjz5vm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FC41A80-6026-11EB-8DD8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> > Did we lose [2/7] somewhere in the mailing list?  I see the same
>> > thing as what is shown in
>> >
>> > https://lore.kernel.org/git/20210125191710.45161-1-mirucam@gmail.com/
>> >
>> > i.e. a 7-patch series that lack its second part.
>>
>> I received the [2/7] patch:
>>
>> -------------------------------------------
>> De: Miriam Rubio <mirucam@gmail.com>
>> Date: lun, 25 ene 2021 a las 20:17
>> Subject: [PATCH v4 2/7] bisect--helper: reimplement `bisect_replay`
>> shell function in C
>> To: <git@vger.kernel.org>
>> Cc: Pranit Bauva <pranit.bauva@gmail.com>, Lars Schneider
>> <larsxschneider@gmail.com>, Christian Couder
>> <chriscool@tuxfamily.org>, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de>, Tanushree Tumane
>> <tanushreetumane@gmail.com>, Miriam Rubio <mirucam@gmail.com>
>
> It does not count---you are on the direct path of the message
> and are not relying on the list to relay it back to you.
>
> It seems that today's one of those days that the mailing list is
> hiccupping. The message I am responding to, which is sent both
> to the list and directly to me, hasn't appeared either on the public-inbox
> or the lore list archive, either.
>
> Hopefully we'll see all 7 messages eventually ;-).

Now I am seeing it on the lore NNTP server (so presumably it has
been relayed to list subscribers).

