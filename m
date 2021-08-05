Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A95C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 02:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261276105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 02:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhHECJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 22:09:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58644 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhHECJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 22:09:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68FA3E1696;
        Wed,  4 Aug 2021 22:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qeutovMaKAts
        3wanrFboBw7hQ+LWRIDn+7QsxI/+AkE=; b=KNjjlYBgGUHqndn7xUbpD7suoLYP
        aZLfUkNz8qFSwXUu84a8gDFrQ8ntBJJZ2KCaac2IfBGiUI8RyMqmt1YHyrrhXjeN
        MMUYU5i+zh7tBiHqpVab1+rNl59nNpwaFJWJOMkfoUgwZlLpn5r9oBy6uwou6duh
        3iIpf7uIVfSWEp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60301E1695;
        Wed,  4 Aug 2021 22:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEFCCE1694;
        Wed,  4 Aug 2021 22:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
References: <xmqqfsvpr8t5.fsf@gitster.g> <87wnp1mqv2.fsf@evledraar.gmail.com>
        <xmqq4kc5ozi7.fsf@gitster.g> <87lf5hm0v7.fsf@evledraar.gmail.com>
        <20210804212825.GH23408@szeder.dev>
        <87fsvon5xm.fsf@evledraar.gmail.com>
Date:   Wed, 04 Aug 2021 19:08:57 -0700
In-Reply-To: <87fsvon5xm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 05 Aug 2021 01:06:55 +0200")
Message-ID: <xmqq4kc4myme.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18752ECE-F592-11EB-AD97-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> How would it be forgotten? If you introduce tests like the ones changed
> in 1/3 of the series and expect git to pay attention to COLUMNS you'll
> find that they won't work, because if you set COLUMNS=3D123 we won't ta=
ke
> it over the GIT_TEST_COLUMNS=3D80 set in test-lib.sh.
> ...
> ...I'd be happy to remove the helper if Junio would take that version o=
f
> the patch; :)

FWIW, I didn't *request* it; the resulting test scripts that set and
unset both the standard COLUMNS and another test-only environment
variable looked typo-prone and hard to read, and that is why I
suggested to hide that behind a helper.

If we do not have to add a test-only enviroment variable at all, I
do not see the reason why we need a helper.

> By narrowly targeting a fix at one specific shell's cleverness around
> COLUMNS we'll leave open a window where we'll fail on other shells if
> they introduce similar cleverness.
>
> It hardly seems like a stretch that once bash starts doing that sort of
> thing other shells might think to follow suit, and all have their own
> non-standard way to turn it off.

Hmph. Wouldn't the same argument apply to the much simpler single
liner "shopt -u" solution?  When writing new tests, there is nothing
to remember, and a new shell that needs a different trick to defeat
the auto-COLUMNS would be detected quickly by running the tests in a
terminal whose width is different from 80, no?

> You also didn't address the other rationale for it, namely that it's
> also future-proofing us for submarine breakages in non-git programs
> which'll understand the new COLUMNS=3D10, but not GIT_TEST_COLUMNS=3D80=
.

Isn't that another downside of the approach you are advocating?

If we make Git rely on GIT_TEST_COLUMNS, we may honor it while
everybody else ignores it.  If we only have to deal with COLUMNS
like everybody else does, Git and other tools that are used in our
tests will be affected the same way by overly-clever shells, no?
