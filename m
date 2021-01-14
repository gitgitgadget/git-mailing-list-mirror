Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F46C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A323117
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbhANUBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:01:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhANUBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:01:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B5EF10F5E7;
        Thu, 14 Jan 2021 15:00:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3uagkfNm8EMk
        iYulRAJsMliQ378=; b=WRex1HwfMWHBrJH8Om7eUdA8OWmCSXGfXq/zhivGq+eS
        HJiBwa6SWDcs1OwGePMD+2meyizAWD6CEbvZVxspOWEIsBDr2Rcvo9iYKXg+9NGA
        pr0oYdqumUuDjRblsFpwF6wa6jz0whvKKr9jMmuxo3N7gtw0BO4RimdhxvwMnDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TuRMQC
        6Sr48bEOKgZ/S2ArCAQ2tnZYe1oN0XoGwbNFhdxcgrDBPSqpivPZdK5eFunpiyFR
        QeRLLGg54IeQox9I62TNNPgR+xRMY67kdQ14m9UeuX3eZfqhYXC4Drtivb3zAQ0x
        qmv94DqYoqy9G9XVl+eKp0lk7pSbCaWIiKGuU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8CD210F5E6;
        Thu, 14 Jan 2021 15:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDD2810F5E1;
        Thu, 14 Jan 2021 15:00:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 06/22] mailmap tests: modernize syntax & test idioms
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-7-avarab@gmail.com>
        <X//4ErmvlK+lIju9@generichostname>
Date:   Thu, 14 Jan 2021 12:00:32 -0800
In-Reply-To: <X//4ErmvlK+lIju9@generichostname> (Denton Liu's message of "Wed,
        13 Jan 2021 23:51:46 -0800")
Message-ID: <xmqqft33xp9b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2971950C-56A3-11EB-91FC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Tue, Jan 12, 2021 at 09:17:50PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> @@ -480,7 +545,7 @@ test_expect_success 'log.mailmap=3Dfalse disables =
mailmap' '
>>  	Author: nick1 <bugs@company.xx>
>>  	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
>>  	EOF
>> -	git -c log.mailmap=3DFalse log | grep Author >actual &&
>> +	git -c log.mailmap=3Dfalse log | grep Author >actual &&
>
> While you're doing test cleanup, here's another suggestion: we should
> break all these pipes where git is in the upstream of a pipe. The retur=
n
> code of a pipe comes from the last thing run which means if git outputs
> correctly but then somehow fails after, we won't detect the failure.
>
> In general, I've stopped my crusade against these because it seems like
> it's more noise than it's worth in most cases but in this case, since
> we're exercising mailmap codepaths that aren't tested in other test
> cases, this pipe could plausibly hide a failure that isn't seen
> anywhere else.

Yeah, I agree with your assessment that it does make sense to make
sure this "log" does not crash silently.

I find it unlikely for "log" to crash while giving an expected
Author line to its output stream, though.

Can you make your suggestion into a follow-up patch to be applied on
top of the series?

Thanks.
