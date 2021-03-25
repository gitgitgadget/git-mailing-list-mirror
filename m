Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A557EC433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C42061A36
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCYUC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:02:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhCYUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 16:02:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB96710E136;
        Thu, 25 Mar 2021 16:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YzhZRic4hEIA
        hpVzHTU4Eb+Jf9Y=; b=aCJ1sv27Cho4nAJy0VFuOQPAcFM/iWm/ilEJviPViACg
        xKeCV+xIfvvBv2C2ggowek1L66omXILHgD+n4rLkCAJ92/DYuh1P2i3uu0VF+ffD
        v3lQJs2s/vjceyVeiKESSaswpgUCf9Nx8SX6hbxRJ1Vq7jmT1Eg0aN9TKLNftLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YRjv0W
        jXmRxxgN9hykQcGr0QwSY7BV72P90RytPF7n5VibyjSb2J2NknU7n/eb5bvS/Qb4
        J1PDOQAVB5+mNfNJEjShLR/znmbO7FUChX5xN1vUvqI48T+quItCJ/I3Q+EI9Djk
        hiagyQR1DNi/h+87lvstR50VpKY4IbncRVj90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D413010E135;
        Thu, 25 Mar 2021 16:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1218610E134;
        Thu, 25 Mar 2021 16:02:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
References: <20210111144740.6092-3-avarab@gmail.com>
        <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
        <YFvbE1K2tZ5ych7z@coredump.intra.peff.net>
        <87ft0kox24.fsf@evledraar.gmail.com>
Date:   Thu, 25 Mar 2021 13:02:09 -0700
In-Reply-To: <87ft0kox24.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 25 Mar 2021 02:13:07 +0100")
Message-ID: <xmqqv99fuhmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC3C6024-8DA4-11EB-A119-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>>> index e0dd5d65ced..2280c2504ac 100755
>>> --- a/t/t1300-config.sh
>>> +++ b/t/t1300-config.sh
>>> @@ -679,7 +679,7 @@ test_expect_success 'invalid unit boolean' '
>>>  	git config commit.gpgsign "1true" &&
>>>  	test_cmp_config 1true commit.gpgsign &&
>>>  	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
>>> -	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign=
." actual
>>> +	grep "bad boolean config value .1true. for .commit.gpgsign." actual
>>>  '
>>
>> why are we losing test_i18ngrep here? The message is still marked for
>> translation. I know we've discussed dropping all of the test_i18n
>> helpers, but that seems unrelated to the rest of the patch.
>
> For new tests we're suggesting not to use it, so while I'm holding off
> on some general s/test_i18ngrep/grep/ refactoring, it seemed natural to
> adjust the test added by the commit whose code I'm modifying.

It would have been understandable if the proposed log message said

    Remove a use of GIT_TEST_GETTEXT_POISON added in f276e2a4694 (config:
    improve error message for boolean config, 2021-02-11), together with
    a new test added.

and removed the test.

But the test still has value for the remaining codebase, just like
all the other tests that happen to use test_i18n{grep,cmp}.  In a
sense, the original mixed two separate things into one commit
(i.e. use of TEST_GETTEXT_POISON to decide if the message given to
die() is localized, and a test to see how "git config --bool --get"
behaves when a malformed boolean value is given), and that may have
been justifiable back in the world where GETTEXT_POISON was a thing,
making these two things closely interrelated.  Since we left that
world behind, I think we should treat them as two separate things.

In short, I do not think "The C code we are removing was added in
the same commit" is a good excuse for this "while at it" change.

Putting it another way, imagine back then there was the t1300 test
and there was no die_bad_bool().  The test may have been expecting
"bad numeric" or "invalid unit", with grep (with a known bug that
the test would not pass under GETTEXT_POISON).

In such an alternative past, the change you are reverting may have
been only to config.c to make the die(_()) work correctly with
GETTEXT_POISON, and turned grep to test_i18ngrep.  And your "we are
reverting the whole commit" may have made more sense.

But we are not living in such an alternative world.

Having said all that, I do not particularly care when, in which
exact commit, a use of test_i18n* in t/ among 1100+ of them lost
its i18n-ness (it just felt a bit out of place in this particular
commit, that's all).

Thanks.
