Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE870C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbiDKSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349025AbiDKSCL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 14:02:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F337A2B
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 10:59:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2773F115789;
        Mon, 11 Apr 2022 13:59:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rh8nfp03qQgD
        SHRFXGa93Cj9cL8M4HESI1aBn8cGF/8=; b=njMeX2FAv0Vb+rSjB3GtaH6SDapC
        YCEDqNvbwc3SdCuT9pZdMneQycl8wNNLrpX5CWeuCsbAn3yeomLzH0fxq0x9jXHz
        o+Bn8zGMvicF454BOYzVm/qk5zp71BKR+8GLKp1mqIDr0rX4UqXgBI3b5exVaeBz
        qvU5O+HXlmyiZpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DBCD115787;
        Mon, 11 Apr 2022 13:59:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84404115784;
        Mon, 11 Apr 2022 13:59:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Christian Couder <christian.couder@gmail.com>,
        jurgen_gjoncari@icloud.com, git <git@vger.kernel.org>
Subject: Re: Make commit messages optional
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
        <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
        <220408.86r167bxra.gmgdl@evledraar.gmail.com>
        <CA+JQ7M-uSatD4=HHxaqe4yVAJ5WGuWC_BprX4hnfKSrt6-1GEg@mail.gmail.com>
        <220411.865ynfkj7r.gmgdl@evledraar.gmail.com>
Date:   Mon, 11 Apr 2022 10:59:47 -0700
In-Reply-To: <220411.865ynfkj7r.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 11 Apr 2022 12:24:41 +0200")
Message-ID: <xmqq4k2zjyb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D8B8A62-B9C1-11EC-B19E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Apr 08 2022, Erik Cervin Edin wrote:
>
>> At the risk of bikeshedding.
>>
>> The case in favor of not allowing empty commit messages by default is
>> that most of the time, empty commit messages are useless.
>>
>> I've written my fair share of poor commit messages (-,..., wip, foo).
>> Sometimes I've fixed that retroactively, sometimes not. The advantage
>> I see with empty commit messages is that it's more ubiquitous to
>> "write something better" or "whatever". The downside is I can't git
>> log --grep '^$' to find them.
>
> You can:
>
>     git log --invert-grep --grep '.'

Wow, that's nasty.

In any case, "--allow-empty-messages" exists, and that is where we
draw the line.  We will not bend over backwards beyond it.

Thanks.
