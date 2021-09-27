Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA8C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360DE60EB4
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhI0U06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:26:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53995 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhI0U06 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:26:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86713F7E17;
        Mon, 27 Sep 2021 16:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=80g+Yi7DmXUc
        yXVEQfLfTcJv71Vd15PXdvWJG37zRf8=; b=fSg5VnKBfiSLKee28Np0hcH43hs2
        zTcIAlX7hZa+xDNqwURYfipQxjCbs3kjcJZIzIW1B8+1Uo/sS5JhWDq7AjgDrlmu
        /55MhdsLWnRkdXv6+Np8vR28zW4EGgNL5DGQ3Xr3dKi4k1bzbjz934m5DYggIBXd
        hPoAAoEfl0II2W4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D3D7F7E16;
        Mon, 27 Sep 2021 16:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4612F7E15;
        Mon, 27 Sep 2021 16:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
        <patch-2.5-d612e7df7a5-20210927T003330Z-avarab@gmail.com>
        <68c9c6da-d215-a39b-64f5-8b8930ce5a09@kdbg.org>
Date:   Mon, 27 Sep 2021 13:25:17 -0700
In-Reply-To: <68c9c6da-d215-a39b-64f5-8b8930ce5a09@kdbg.org> (Johannes Sixt's
        message of "Mon, 27 Sep 2021 08:35:25 +0200")
Message-ID: <xmqqfstppxzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0842F702-1FD1-11EC-88F6-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.09.21 um 02:39 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> diff --git a/entry.h b/entry.h
>> index 7c889e58fd7..04bc8bb59f0 100644
>> --- a/entry.h
>> +++ b/entry.h
>> @@ -16,7 +16,7 @@ struct checkout {
>>  		 clone:1,
>>  		 refresh_cache:1;
>>  };
>> -#define CHECKOUT_INIT { NULL, "" }
>> +#define CHECKOUT_INIT { 0 }
>
> This is not an equivalence transformation and does not belong in this p=
atch.

Thanks for carefully reading.  This is the kind of mistake I hate
about these mind-numbing "let's do the clean-up" series.

