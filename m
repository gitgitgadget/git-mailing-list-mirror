Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5401CC3B18C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20368206ED
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aZ72L6we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgBMQG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:06:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61692 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBMQG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 11:06:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8196FAC518;
        Thu, 13 Feb 2020 11:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4B1cMIfxqY6+luW9yWTBaOQCq64=; b=aZ72L6
        wer9xQndjZSse59wgnKuEYsx/CqzwG80VFDR0RYXBu23i+gLlUtWYvAOphJiWNm9
        zW4XQ/3qcBj926N1L4N+WGCLBHvb/UI2BkFi2l0vWDoPjQeKsB2ZLzIparF6jGe2
        EvszhUHdoqnEgoeBN4BKFYDcVwqWr6iWM/ya0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nb3wPwaCuALkEt5R5wYFnw8IcJtYtNP/
        X2UTjvqL2GJCibKNU6cW0cam151tMCt/3X/6oBK42BATAKCez7sHkYMzdxYie4C8
        hOTbTuVkNDtAQ+XNsMW+bYy0ko/8RC24Iw/KXpQvHaG5YTAEF7IDAM4GL7IYT+b6
        OJneZWgh/Ac=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7924FAC517;
        Thu, 13 Feb 2020 11:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81EB1AC513;
        Thu, 13 Feb 2020 11:06:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
Date:   Thu, 13 Feb 2020 08:06:49 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 13 Feb 2020 14:02:23 +0100 (CET)")
Message-ID: <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D89E3774-4E7A-11EA-8738-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 12 Feb 2020, Junio C Hamano wrote:
>
>> * yz/p4-py3 (2020-01-15) 14 commits
>>  . ci: also run linux-gcc pipeline with python3.5 environment
>>  - git-p4: use python3's input() everywhere
>>  ...
>>
>>  Update "git p4" to work with Python 3.
>>
>>  Hold.
>>  The last step is too wasteful to run full tests twice.
>>  cf. <20200122235333.GA6837@szeder.dev>
>>  cf. <20200123175645.GF6837@szeder.dev>
>
> All right, all right, all right! If we cannot find any better way than to
> just use Python2 in -clang and Python3 in -gcc (or was it the other way
> round, I forget), then we cannot find any better way, and I won't hold
> this up any longer.

OK, any one of you wants to do the honors of wrapping up the
proposed patch with a log message to replace the tip commit to allow
us to move forward?

Thanks.

