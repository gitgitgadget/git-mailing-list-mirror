Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42111C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230676135F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbhI1Uxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:53:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64313 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbhI1Uxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:53:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37F51E15C4;
        Tue, 28 Sep 2021 16:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=rW/h3IpTHBVljMi2Xnr7o7crR
        znnxaEIXWDjpj1kzX0=; b=XC4dMhe/IYq4CH9DyLyEOOd/BzoCS1u7g1W44Yl6F
        MQpIoWxIwxKHonuwJ45q0U+XdzDtEN/FTFKM0Vd2INIF0ZFxzLbqgb1jnFoOia0E
        JUsNBoBrwnH0XU+hGOZJosthlcwusR2EIOXgRJNaO5sUOgduxteP+k0mPh0rs7od
        RU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3B9FE15C1;
        Tue, 28 Sep 2021 16:52:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0EC1E15C0;
        Tue, 28 Sep 2021 16:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.org>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g> <87czotzaru.fsf@evledraar.gmail.com>
Date:   Tue, 28 Sep 2021 13:52:00 -0700
Message-ID: <xmqqfstojudr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EEC42170-209D-11EC-8341-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/http-pinned-public-key-mismatch (2021-09-27) 1 commit
>>  - http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors
>>
>>  HTTPS error handling updates.
>>
>>  Will merge to 'next'?
>
> I'd like it merged. I think a fair summary of Jeff King's
> https://lore.kernel.org/git/YU5CJC9XJvQITfr8@coredump.intra.peff.net/ i=
s
> "meh" though :)

Mine is also "I do not mind seeing it in or out."

>> * ab/pack-objects-stdin (2021-07-09) 5 commits
>>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>>  - pack-objects.c: do stdin parsing via revision.c's API
>>  - revision.[ch]: add a "handle_stdin_line" API
>>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>>  - upload-pack: run is_repository_shallow() before setup_revisions()
>>
>>  Introduce handle_stdin_line callback to revision API and uses it.
>>
>>  Expecting a reroll.
>
> I said I'd re-roll this into the larger "git bundle --stdin" topic I ha=
d
> in mind, but when doing so found one memory leak, which I really wanted
> the SANITIZE=3Dleak interface to fix.
>
> I think it's best to eject/discard this given the amount of other
> outstanding stuff I've got. I don't really *need* this for anything
> else, I'll loop back to it sometime after the SANITIZE=3Dleak testing h=
as
> landed.

OK, will mark as "Retracted for now".

>> * ab/fsck-unexpected-type (2021-09-22) 17 commits
>> [...]
>>  "git fsck" has been taught to report mismatch between expected and
>>  actual types of an object better.
>>
>>  Needs review.
>
> The "needs review" note here pre-dates v6, which got a thorough review,
> and Taylor seemed happy with the v7, aside from a minor issue I just
> re-rolled v8 with a fix for:
>
> https://lore.kernel.org/git/cover-v8-00.17-00000000000-20210928T021616Z=
-avarab@gmail.com/

Thanks.
