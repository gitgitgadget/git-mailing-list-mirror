Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D1C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A353060F46
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhHaSS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:18:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57515 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHaSS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:18:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A6ED156563;
        Tue, 31 Aug 2021 14:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mT3RZDWIsHzd
        59s209KBJaD9yOGCeSsytqaJuSVnm5M=; b=DvGnyWVOrAM7cYWg0oqDW6SKDmh2
        BGwDJf9ODI16TjEOCMrlU/atIS6XxdCC/cdS8BQNg0fuX1cCSSd559kQTkEYBgi8
        eD9/sOvtYoleBj0IGHtMsJl92Ki4Fa905+InieZgmfdn1Cd4lPmoe8t/DRtXSKKh
        MZc/zu07A0eqPSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5350E156562;
        Tue, 31 Aug 2021 14:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFE0815655F;
        Tue, 31 Aug 2021 14:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jan Judas <snugar.i@gmail.com>
Subject: Re: [PATCH] gc: remove trailing dot from "gc.log" line
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
        <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
        <CAPig+cQ1V-sSZzrBwDWZYFEFJY-W8s1aq4igfhg9vPBNdLJusA@mail.gmail.com>
Date:   Tue, 31 Aug 2021 11:17:57 -0700
In-Reply-To: <CAPig+cQ1V-sSZzrBwDWZYFEFJY-W8s1aq4igfhg9vPBNdLJusA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 31 Aug 2021 12:15:04 -0400")
Message-ID: <xmqqpmtttr56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C5D18E96-0A87-11EC-AC59-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 31, 2021 at 10:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Remove the trailing dot from the warning we emit about gc.log. It's
>> common for various terminal UX's to allow the user to select "words",
>> and by including the trailing dot a user wanting to select the path to
>> gc.log will need to manually remove the trailing dot.
>>
>> Such a user would also probably need to adjust the path if it e.g. had
>> spaces in it, but this should address this very common case.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> Suggested-by: Jan Judas <snugar.i@gmail.com>
>> ---
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -502,7 +502,7 @@ static int report_last_gc_error(void)
>>                 warning(_("The last gc run reported the following. "
>>                                "Please correct the root cause\n"
>> -                              "and remove %s.\n"
>> +                              "and remove %s\n"
>
> Bikeshedding: Adding a colon after "remove" would give this a slightly
> more grammatically-correct feel:
>
>     Please correct the root cause
>     and remove: /path/to/repo/.git/gc.log
>
>>                                "Automatic cleanup will not be performe=
d "
>>                                "until the file is removed.\n\n"
>>                                "%s"),

OK.

> Even more bikeshedding:
>
>     Please correct the root cause and remove
>     /path/to/repo/.git/gc.log
>     to allow automatic cleanup to resume.
>
> or something.

I also found the line break before "and remove" strange, but I think
that is because the "Please" is not at the beginning of the
paragraph, but is a second sentence.  Perhaps unfolding "and remove"
would make the first line overly long?

THanks.
