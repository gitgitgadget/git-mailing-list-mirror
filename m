Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639CC4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32CA221F5
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 00:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406916AbgLKX5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 18:57:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61981 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404297AbgLKX44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 18:56:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82AA992E1F;
        Fri, 11 Dec 2020 18:56:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AnhEsjVl+90KqMfEyuKfvfp7ZEA=; b=lAP+bB
        HeLodTQVRIwZxwyXylTI2UJHWhvSwEcRTQYgDwrercJcniPRsoCQ+fLlDO2V70lB
        WpWlyGLt3B2fhe+CXLYo4zV+plun/56Pmld/rnVDfNGf1EWgFOltTQifXObmpm5I
        PHMv0pl3hZxOYQgG/pkBf6rmxwrhuxiHNAPVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QGYKb/zPRN8q9F4Y//XX6CsSB95zPWef
        Qcjq3kLiJF4Xzlz2PZB3ZyYygYUVVNtJhbPAt3g1AUTRP0RgbD05jrjusrKsCitF
        ZsNQyn3Sx/q9e4bLAMSpCC+22sL2ewjSq/AaKrkVnHwBHnaH0WFNxHUYo29YSvMV
        ttOjkrF6fuQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 788AB92E1E;
        Fri, 11 Dec 2020 18:56:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 010FE92E1D;
        Fri, 11 Dec 2020 18:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-4-felipe.contreras@gmail.com>
        <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
        <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
Date:   Fri, 11 Dec 2020 15:56:11 -0800
In-Reply-To: <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
        (Felipe Contreras's message of "Fri, 11 Dec 2020 06:48:33 -0600")
Message-ID: <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72529BE2-3C0C-11EB-B065-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> We seem to be losing test coverage by checking how pull.ff=only prevents
>> the command from working in a non-ff merge.
>
> No we don't. Remove the "test_config pull.ff only" and the test fails,
> as expected.

> ...
> What do we get?
>
> not ok 4 - pull.rebase not set and pull.ff=true
> not ok 5 - pull.rebase not set and pull.ff=false
> not ok 6 - pull.rebase not set and pull.ff=only
> not ok 7 - pull.rebase not set and --rebase given
> not ok 8 - pull.rebase not set and --no-rebase given
> not ok 9 - pull.rebase not set and --ff given
> not ok 10 - pull.rebase not set and --no-ff given
> not ok 11 - pull.rebase not set and --ff-only given
>
> All failures. Exactly as expected.

Assuming only one kind of breakage and try to break exactly that
thing does not prove much.

I'll keep this short as I am supposed to be off officially.

With pulling without choosing between rebase/merge, the old code
had one behaviour wrt the message---it always advised, whether
the pull was ff or not.

The new code has two behaviour wrt this aspect.  It behaves
differently when the pull is ff or non-ff.  That would double the
possibility that needs to be tested if we wanted to keep covering
the original set of conditions *and* cover all new possibilities.

I am saying that you should keep the original ones, and add new ones
to cover the new cases if that matters.  Otherwise the conditions
under which the original tests were checking would no longer be
tested.

>  test_expect_success 'pull.rebase not set and --rebase given' '
> -	git reset --hard c0 &&
> +	git reset --hard c2 &&
>  	git pull --rebase . c1 2>err &&
>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '

This used to make sure an attempt to rebase c1 onto c0, which can be
fast-forwarded, would work fine, even though it used to give
warning.  We should keep testing the same condition.  The
expectation of seeing the warning is what must be changed, not the
test condition (i.e. rebasing c1 onto c2 instead of c0)---you are no
longer making sure that c1 can be rebased onto c0 cleanly.

