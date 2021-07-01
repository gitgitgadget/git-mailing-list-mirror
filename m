Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37685C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B354613F4
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhGAPX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:23:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58665 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhGAPX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:23:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BB8BD38C5;
        Thu,  1 Jul 2021 11:21:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WDVs7D7ZNaEC
        0GskoSCo4z/yk98HjCawz3+IXHB9UzY=; b=p47WAVW2LCZKFgwhHG+L4eB04QOp
        DEBe7XSaJBlbpgHBizpcB+mF3Px79T3nHT3RMRhWhKZKj9UpeGGxRqntieS2llIp
        igo79KdyzTs3P0dPkwMxbGNdUz/Xa/3zVyjVpmU5ugQWTAWVD60jqlTV4YjdwyYr
        z+IpwpRabIh44PQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FA06D38C4;
        Thu,  1 Jul 2021 11:21:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1D22D38C3;
        Thu,  1 Jul 2021 11:21:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
References: <xmqq4kdft122.fsf@gitster.g> <87o8bmcd9a.fsf@evledraar.gmail.com>
Date:   Thu, 01 Jul 2021 08:21:27 -0700
In-Reply-To: <87o8bmcd9a.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 01 Jul 2021 16:00:01 +0200")
Message-ID: <xmqqczs2rrew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0162400A-DA80-11EB-AB6D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> And:
>
>>  - Makefile: remove an out-of-date comment
>>  - Makefile: stop hardcoding {command,config}-list.h
>>  - Makefile: mark "check" target as .PHONY
>
> https://lore.kernel.org/git/cover-0.3-0000000000-20210629T190137Z-avara=
b@gmail.com/
>
> But you re-combined them. If it makes things easier for you I'm all for
> it, but it seems better to me keep them split if that mean that some
> parts can advance faster, and thus make the rest easier to review.

I am all for that reasoning, but in this case (and other topics that
I "combined", as well), one had textual dependencies on the other,
and didn't make sense to split them into two, as neither part can
advance without affecting the other, if I recall correctly.

>> * ab/doc-retire-alice-bob (2021-06-16) 6 commits
>>  - pack-protocol doc: use "www-data" in place of "alice"
>>  - doc: replace "alice" and "bob" with "jdoe" and "msmith"
>>  - fast-import doc: change "bob" in an example to "file.txt"
>>  - daemon doc + code comments: reword "alice" example
>>  - gitcvs-migration doc: replace "alice" and "bob" with "you" and "www=
-data"
>>  - gittutorial doc: replace "alice" and "bob" with "you" and "www-data=
"
>
> Having re-read the discussion now I don't know if there's anything
> outstanding to change about this series. It's gotten a lot of attention
> so far, so it's more of a matter of if you're willing to take this sort
> of documentation change or not.

I actually do agree with the objection that www-data is a contrived
thing to use in the examples, not because the user www-data is
distro specific, but because it involves one physical human user
acting on two accounts, instead of two human users interacting with
each other.
