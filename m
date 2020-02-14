Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96A2C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8882168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eD/gKB9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbgBNSKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:10:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54875 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbgBNSKv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:10:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 049863CB25;
        Fri, 14 Feb 2020 13:10:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ufzv5cRW3sNV
        nYyBUZhmpvLNT+c=; b=eD/gKB9On5y7yfWxsHJOAKojiT9Rf4IcECo6RC0i27es
        7xMHFNJGtwkOt190y3SndlqEiFs3xmdpPuGLyXzCGawweS2YgT1dFnamVoU2jNf+
        OrREPKtfHQyL8DY04q5/ULQ6uoDrpu3jwFXhBs9F1w5nyskRjOZfAwgm41jiUjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AvAADL
        KW1ULaPyMd1T4B0L0ArGcoRgRZrFj6Mncpqp0w8DSnVoDT+4FLp3WXPzDm/6d8Fs
        3AHtHvl5ycqusEnLl5FImK0DtFjfY/KWSqavuPqtU5xK1MPA4qUNffBYqXY9C7hw
        5VolXZ/FN1H7chr36dVmdEYPKjxci1WNqmqDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF56A3CB24;
        Fri, 14 Feb 2020 13:10:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59C673CB23;
        Fri, 14 Feb 2020 13:10:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
        <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
        <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
        <xmqqtv3tpzto.fsf@gitster-ct.c.googlers.com>
        <20200214051505.GA16130@generichostname>
        <7fc48fbe-4cf4-7a0a-22f6-eac9692abc9b@gmail.com>
        <xmqq8sl5p0hf.fsf@gitster-ct.c.googlers.com>
        <9d1d3f2e-fef2-bcba-8065-c33ff6c5c0c3@gmail.com>
Date:   Fri, 14 Feb 2020 10:10:44 -0800
In-Reply-To: <9d1d3f2e-fef2-bcba-8065-c33ff6c5c0c3@gmail.com> (Ben Keene's
        message of "Fri, 14 Feb 2020 12:05:15 -0500")
Message-ID: <xmqqimk9nior.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51F22C9A-4F55-11EA-BD32-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Keene <seraphire@gmail.com> writes:

> On 2/14/2020 12:01 PM, Junio C Hamano wrote:
>> Ben Keene <seraphire@gmail.com> writes:
>>
>>> On 2/14/2020 12:15 AM, Denton Liu wrote:
>>>> This change comes from 'git-p4: restructure code in submit' in
>>>> 'bk/p4-pre-edit-changelist' which introduced the use of the `<>`
>>>> operator. In Python 2, this is valid but in Python 3, it was removed=
.
>>>>
>>>> We can simply replace the `<>` with `!=3D` which is the new way of
>>>> writing "not equals".
>>> Absolutely. I'm committing the change now.
>> Thanks.
>>
>> I didn't mean that the use of <> was the only bug in 'pu' wrt Python
>> 3.  I see you sent a new round out, but has it been tested under
>> Python 3 already?  Just checking to set my expectation right.
> I have not been able to test my changes under Py3. Unfortunately I
> don't have the bandwidth at present to incorporate Yang's code into
> this code for testing. I've been having to work with Python 2 at
> present and using my changes locally.=C2=A0 I have tried to not use Pyt=
hon2
> only code, but cross compatible code but I'm not sure what other
> errors might be present.
>
> I'm fine if this needs to stay pending until Yang is complete and
> I can then retest with the new code.

Nah, I'd have replaced and rebuilt 'pu' anyway.  I just wanted to
know how much I should be surprised if I saw any other Python3
issues when Travis sees the updated 'pu' later today.
