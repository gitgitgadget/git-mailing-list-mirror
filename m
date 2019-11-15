Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B371F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKOFNc (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:13:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64523 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfKOFNb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:13:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB7379B1F2;
        Fri, 15 Nov 2019 00:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kbohwZzPnLlQ
        fV7acYy0hezcY0Q=; b=YiPrq1dvTq8Y/jhxqc08Y5Q45WD+Dr1SmE/Tlyk2ZOR9
        Z/qxmOZvS755r8rbHTGAB4aY7gX1SmJvJfFiOV1DLgNG6cYy4Lg0burClfgGRepg
        IQL1hdgS7OGLFR2ZLSpP4TMlu7gyM7x/f3IpcNolbe8eo70eQnyhL/bJ9dSpGhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=urO1b6
        jnjc9oztWnHU0jKViM9jM1udNeIIRQWf/trdfgxOLAczVQ4srx/z8Z/D8pm8UmYr
        1nDR1l7UUhRP015ifzUYHy3YmlVsAfJKPflsI1i7qPdV05S2Uu9mGGL0vdKJ2YwJ
        yo7sR41JSqY9pMWHmqSWxvkQnbq2/xYzgPbkE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E24B09B1F1;
        Fri, 15 Nov 2019 00:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1583A9B1F0;
        Fri, 15 Nov 2019 00:13:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: coccinelle: merge two rules from flex_alloc.cocci
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
        <20191112175926.GA41101@generichostname>
        <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
        <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
        <CAN0heSqyGwkeGKv0m_gLDooaUp=gN2_tD7kJYNxeL7LALiPRhQ@mail.gmail.com>
        <1d08b49e-1f41-4290-a64b-dad9fd2288de@web.de>
        <20191114163527.GT4348@szeder.dev>
Date:   Fri, 15 Nov 2019 14:13:24 +0900
In-Reply-To: <20191114163527.GT4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 14 Nov 2019 17:35:27 +0100")
Message-ID: <xmqq5zjl90y3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7C5B6D2-0766-11EA-BA5A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Nov 14, 2019 at 09:15:47AM +0100, Markus Elfring wrote:
>> > If you could have some before/after numbers, that would be cool.
>>=20
>> Does any test infrastructure (or benchmarks) exist which you would tru=
st for
>> corresponding comparisons of software run time characteristics?
>
> Yes, just run:
>
>   make cocciclean
>   time make contrib/coccinelle/flex_alloc.cocci.patch
>
> before and after your changes, and include the timing results in the
> commit message if there is a notable difference.  If it gets faster,
> great!  If it gets slower, then update the commit message with a
> convincing argument about why the change is worth the performance
> penalty.

Also, the contents of the *.patch file before and after the change
needs to match, but for that test to be meaningful, you'd need to
resurrect the problems we fixed with the help of the existing cocci
scripts (otherwise, the resulting *.patch file being empty does not
prove much---our source may now be too clean to demonstrate the
difference of the before/after rules).

Thanks.
