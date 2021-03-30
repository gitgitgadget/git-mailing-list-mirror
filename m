Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FBC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5C761998
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhC3SnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:43:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61106 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhC3Smp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 14:42:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAC0CAE6B3;
        Tue, 30 Mar 2021 14:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jdUDAp4m/lOz
        rKLzFXpf/9hg9AE=; b=jMNjw3fjjnsUdZI3V+PTTQH5AEO5bw2nQ0fN9vewWL3B
        EnWFOy7Rs/a1BnU7jYgWL0BJsXlcNE9187NKGbUsA7QACjPvVIsZjK03Bi7+3cbs
        nFDkAqSU7nAgWgfJudC2hnt2ye9givsAhoJgxNlCYDfWi0TBWylJDbxc4K8e+no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sFMza3
        lBvWaUy4qJvd5Fo7xKGqtDe+OtMwyuK0gtwnFhsxFR6dnjEH2zpuPD+Qm/ygBXco
        uryiaktHnQWPJ4A7StRz8FlnVVOnS7en+75Vj06376P6VFKzU2eZvOqh99Bi9eP/
        RfMud8PoT3E79QQkG4KUCtrTBlIhD/yFNsa+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0EC6AE6B1;
        Tue, 30 Mar 2021 14:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B5C3AE6B0;
        Tue, 30 Mar 2021 14:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
        <xmqqblb1kd47.fsf@gitster.g> <87a6qlmt9f.fsf@evledraar.gmail.com>
        <YGM/i+k4r0q8FKg2@coredump.intra.peff.net>
Date:   Tue, 30 Mar 2021 11:36:06 -0700
In-Reply-To: <YGM/i+k4r0q8FKg2@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 30 Mar 2021 11:11:07 -0400")
Message-ID: <xmqqft0cebft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA892982-9186-11EB-9BBF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 30, 2021 at 01:31:40AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> >> Use the GNU make ".DELETE_ON_ERROR" flag.
>> >
>> > Yay!
>> >
>> > With versions of $(MAKE) where this feature is available, it is far
>> > more preferrable to use it than "generate into temporary and rename
>> > to the final" dance.
>> >
>> > We do require / depend on GNU but I do not offhand know if this is
>> > available in all versions that still matter.  If we know we can
>> > assume the presence of this feature the I do not mind if we jump
>> > directly to this step without those "do the same for $(CC)" steps
>> > (which I deem crazy) before it.
>>=20
>> Even if it's not available in all versions that's OK. You just won't g=
et
>> the nicer removal behavior on on error on such a jurassic gmake, but
>> you'll probably have way bigger issues with your late-90s-era software=
.
>>=20
>> It's not a syntax error on a gmake or other make that doesn't know abo=
ut
>> it either, i.e. you can also add a target like:
>>=20
>>     .THIS_DOES_NOT_EXIST_AS_A_GMAKE_FEATURE:
>>=20
>> And gmake willl happily ignore it.
>
> Yes, I think it's fine to treat it as "nice if we have it, but OK
> otherwise". But also, .DELETE_ON_ERROR first shows up in the GNU make
> git repository in version 3.71.5 from 1994. So I think we can probably
> just assume it's everywhere.

OK.  That raises my hopes up that we may be able to simplify things
like this

    config-list.h:
            $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
                    >$@+ && mv $@+ $@

into

    config-list.h:
            $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@

