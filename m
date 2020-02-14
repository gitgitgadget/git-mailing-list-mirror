Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D35C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3652F20656
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTK1OXMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404562AbgBNRBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:01:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61266 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404052AbgBNRBG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:01:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C043B6250;
        Fri, 14 Feb 2020 12:01:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E3P4aqt6LXrWvNCKx4Zh/hRFt1Y=; b=hTK1OX
        MbfCzf2GsxQyylHVu0EeZsyceUfDV8vs6/fEdJhWWbqB5hhnSB5Ml3Hqt+tilT09
        pnrKIrUvEwvrrKME6gqp6i5UR1c2msDZcbpZMpgn0+WHm+HSYeNBTMsC1z5q7rjE
        S0u08Jfd929f49KvAypMFVNwNWHKigitwJraA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OhHBNCbuAxV+khZxmSCZy4xTFpDbC0rK
        +yCuagYJBx/HcdJVBtUza5C/+55lajMQ/+n4UUqORNWAZhNWrt5dmT6ih9v5lCJT
        /d2j41Ib7e3eclNrbouvrnui5uBUWPNm1HLQrfY43wC0Tyz4WOKBfJv4qRkNPcSk
        uyzh14/auqM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 545D4B624F;
        Fri, 14 Feb 2020 12:01:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77838B6249;
        Fri, 14 Feb 2020 12:01:03 -0500 (EST)
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
Date:   Fri, 14 Feb 2020 09:01:00 -0800
In-Reply-To: <7fc48fbe-4cf4-7a0a-22f6-eac9692abc9b@gmail.com> (Ben Keene's
        message of "Fri, 14 Feb 2020 09:39:50 -0500")
Message-ID: <xmqq8sl5p0hf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 955A4378-4F4B-11EA-AA88-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Keene <seraphire@gmail.com> writes:

> On 2/14/2020 12:15 AM, Denton Liu wrote:
>> This change comes from 'git-p4: restructure code in submit' in
>> 'bk/p4-pre-edit-changelist' which introduced the use of the `<>`
>> operator. In Python 2, this is valid but in Python 3, it was removed.
>>
>> We can simply replace the `<>` with `!=` which is the new way of
>> writing "not equals".
> Absolutely. I'm committing the change now.

Thanks.

I didn't mean that the use of <> was the only bug in 'pu' wrt Python
3.  I see you sent a new round out, but has it been tested under
Python 3 already?  Just checking to set my expectation right.

