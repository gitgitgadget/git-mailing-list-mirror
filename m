Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078FC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EED6610E9
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhKHTV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:21:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55053 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhKHTV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 14:21:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C208216B745;
        Mon,  8 Nov 2021 14:18:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qzOle2lrl4Sl
        0+4UqaSeLgsOQ29jCJvad4MSnl9WGBQ=; b=jh7CjR45FMKBJwODWq4UBDHIdu1L
        6T4lAlfWKHbwCcYhj3Ga5DdljDGd4CqNusapzAPdA8UiMc+6wItDDer7OJGcmF2n
        lGzI2Bgw+bFjUwRm0GNkRLBLw78XHFrUlJwAT9RxF38Qd7uEYkBdkpxNj8Q5eu8Z
        k+kviIgozEy5bCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA69E16B744;
        Mon,  8 Nov 2021 14:18:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1ADDA16B742;
        Mon,  8 Nov 2021 14:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 01/10] command-list.txt: sort with "LC_ALL=C sort"
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
        <patch-v3-01.10-c385e84c04c-20211105T135058Z-avarab@gmail.com>
        <xmqqbl2yw7b6.fsf@gitster.g>
        <211106.867ddlhp9j.gmgdl@evledraar.gmail.com>
Date:   Mon, 08 Nov 2021 11:18:37 -0800
In-Reply-To: <211106.867ddlhp9j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 06 Nov 2021 05:26:04 +0100")
Message-ID: <xmqq35o6v4ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD916A64-40C8-11EC-BD21-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Nov 05 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> In a subsequent commit I'll change generate-cmdlist.sh to use C sort
>>> order, and without this change we'd be led to believe that that chang=
e
>>> caused a meaningful change in the output,
>>
>> What I found misleading in this sentence (which hasn't changed after
>> I pointed it out in the previous iterations) is that[...]
>
> I tried to clarify what you raised in the previous iteration with the
> new paragraph after the one you're quoting. I.e.:
>
>     Note that this refers to the sort order of the lines in
>     command-list.txt, a subsequent commit will also change how we treat
>     the sort order of the "category" fields, but that's unrelated to th=
is
>     change.

Yeah, but my question was not about the order of category tokens on
each line.  My question was the order of these lines in the file.

The new pargraph is answering a question that wasn't asked.

>> Is this talking about the order of entries in command-list.h file?
>>
>> Also, if the script sorts the input, whether it is in C locale or
>> other locale, it would not matter how the input originally is
>> sorted, as the input does not have duplicated entries to make sort
>> stability matter, no?
>
> This change is just to make this consistent for human editors. I think
> we re-sort this wherever we display this in git, whether that's via
> help.c or the completion powered by git.c.

So

>> order, and without this change we'd be led to believe that that change
>> caused a meaningful change in the output,

is something irrelevant to explain what this change is, no?
