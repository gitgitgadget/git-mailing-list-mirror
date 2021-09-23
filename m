Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7962C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C285B61019
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhIWQiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:38:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57040 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242108AbhIWQiK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 12:38:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF63015ED83;
        Thu, 23 Sep 2021 12:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nRdjLHfhWwoK
        153I8G2YbckG23ItWfuymY+VkYxcmpU=; b=ZYGW+mmNjh5sqXK1qnCh7U2Wpei9
        rnkDZ4SduGo6b6ZQlYHpsH3GuOVPoO52R8BJt68Pcgeabx4M0W5khcA6JzqhhNsd
        ZORnWqrX/Dn1XowpsQoO3INP0zT8zOcZarI5a9OIOdVr0D6uWRstr45efuquh9Gd
        OndV7iK1yr+M/Tc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7CC015ED82;
        Thu, 23 Sep 2021 12:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BF2215ED81;
        Thu, 23 Sep 2021 12:36:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2021, #06; Mon, 20)
References: <xmqq1r5iaj9j.fsf@gitster.g> <875yut8nns.fsf@evledraar.gmail.com>
Date:   Thu, 23 Sep 2021 09:36:32 -0700
In-Reply-To: <875yut8nns.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 22 Sep 2021 01:07:00 +0200")
Message-ID: <xmqqczoz2qr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6989BDC2-1C8C-11EC-B44A-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/sanitize-leak-ci (2021-09-20) 2 commits
>>  - tests: add a test mode for SANITIZE=3Dleak, run it in CI
>>  - Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS
>>
>>  CI learns to run the leak sanitizer builds.
>>
>>  Will merge to 'next'?
>
> Yes please, as noted in
> https://lore.kernel.org/git/87r1dh8r62.fsf@evledraar.gmail.com/ more
> leak fixes are waiting on this.

Isn't the direction of dependency the other way?  Once fixes go in,
checks will no longer complain, but until fixes are reviewed and
applied, checking at CI will break the testing and this would need
working around by marking various tests as "not ready to be tested".

> It seems due to the size of this series we might be better off splittin=
g
> up this already split-up series.
>
> I was trying to convince you to merge down the much more trivial change=
s
> up to the <mark0> above, which are purely build system prep work. Any
> chance you'd reconsider?
>
> I think a plan that might be better would be:
>
>  1. Eject both ab/config-based-hooks-base & es/config-based-hooks
>  2. I'd submit a series up to the <mark0>, hopefully that can land fair=
ly
>     soon thereafter.
>  3. Once that's in, another one for <mark0>..<mark1>, i.e. the "git hoo=
k
>     run" command, but only the more basic bits, and migrating fairly
>     simple hooks.
>  4. Then <mark1>..<mark2>, followed by <mark2>..ab/config-based-hooks-b=
ase
>  5. Then Emily's es/config-based-hooks.
>
> That's converting a 2-step process (ab/config-based-hooks-base +
> es/config-based-hooks) into 5 steps, but I suspect it would go faster,
> right now it seems there's no takers for a review of this rather large
> series. What do you & Emily think?

Today I learned a phrase "six of one and half a dozen of another" ;-)

I have been wondering if something like a book reading club is
doable on the list.  A chairperson nominates (and perhaps resends) a
series of patches that is of manageable size to be reviewed, perhaps
even prime the discussion with some comments, likeminded folks chime
in and we end up with a reviewed series?
