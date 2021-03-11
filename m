Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338ABC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DB564F87
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCKS1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:27:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61333 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCKS1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 13:27:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0461121921;
        Thu, 11 Mar 2021 13:27:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XV89Ve0xKlF6
        EYhwJ8cf82/8js8=; b=yFFXGH9qNGU/gTGpN3ZMLS5mIvjPAW8sVMs2N6UNomZb
        AvRpnPJc2ufh3flGIsX7pLT/hYvAMZgskisGYN8L1B0RaekNRxitSKgHQQc4fTVO
        hbk/wn7sXCWJBxLXblr49iMQo3EIeEnbun5bEjwFujCnJpBcgLhc1Px09Z3N474=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oOUQAd
        4W0rJBqcx738xXDv8ElbbFcCuu7i43xfk9NaErAhEw7wm49fz0byT/HmcR06s+pC
        tXMQsttqgbOXQNEXulqnTVkk7hfRpVWd5E7jEmvxh4cbT7UiC8YHZIt1o27OBGo2
        49xsUNRoH0swGmNDQmfjfhva53y6DH3itBjBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C81E0121920;
        Thu, 11 Mar 2021 13:27:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1983C12191A;
        Thu, 11 Mar 2021 13:27:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
References: <xmqqmtvafl62.fsf@gitster.g> <87r1klhq3y.fsf@evledraar.gmail.com>
Date:   Thu, 11 Mar 2021 10:27:33 -0800
In-Reply-To: <87r1klhq3y.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 11 Mar 2021 12:44:17 +0100")
Message-ID: <xmqqy2etczqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 734FC638-8297-11EB-AE9D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 11 2021, Junio C Hamano wrote:
>
> Some notes, mostly on my own topics:

Thanks.

>> * ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
>>  - tests: get rid of $_x05 from the test suite
>>  - shortlog tests: rewrite to get rid of --abbrev=3D35 hardcoding
>>  - test-lib: remove unused $_x40 and $_z40 variables
>>  - git-bisect: remove unused SHA-1 $x40 shell variable
>
> FWIW (mostly for other readers) I suggested in
> https://lore.kernel.org/git/87tupigf02.fsf@evledraar.gmail.com/ just no=
w
> that we drop 4/4.

I do not trust myself; we need to get 2&3 reviewed independently
before we can move beyond discarding the $_x05 step.


>> * ab/fsck-api-cleanup (2021-02-18) 10 commits
>>  - fsck.h: update FSCK_OPTIONS_* for object_name
>>  - fsck.c: give "FOREACH_MSG_ID" a more specific name
>>  - fsck.c: undefine temporary STR macro after use
>>  - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
>>  - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
>>  - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
>>  - fsck.c: move definition of msg_id into append_msg_id()
>>  - fsck.c: rename variables in fsck_set_msg_type() for less confusion
>>  - fsck.h: use "enum object_type" instead of "int"
>>  - fsck.h: indent arguments to of fsck_set_msg_type
>>
>>  Preliminary fsck API clean-up.
>>
>>  Expecting a reroll.
>>  cf. <xmqqczwxc8bw.fsf@gitster.g>
>
> I think this note at least needs to be updated to say the re-roll exist=
s
> at https://lore.kernel.org/git/20210306110439.27694-1-avarab@gmail.com/

Sure.  But consider anything outside 'next' would be the same as
"discarded" to get a fresh start after a release.

>> * ab/make-cocci-dedup (2021-03-05) 4 commits
>>  - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>>  - Makefile/coccicheck: allow for setting xargs concurrency
>>  - Makefile/coccicheck: speed up and fix bug with duplicate hunks
>>  - Makefile/coccicheck: add comment heading for all SPATCH flags
>>
>>  An attempt to speed up the coccicheck target with incorrect
>>  results.
>>
>>  A reroll exists to address correctness issue, but not picked up.
>
> Any reason for not picked up other than "rc period etc...".

As I always say, please don't read anything more than "I happen to
have seen it" in being in 'seen'.  And that does not even mean
everything I saw would be on 'seen'.  Especially during the
pre-release freeze.  I may have time to pick up a replacement for a
topic that is already in 'seen', to make sure there aren't unexpected
new conflicts I'll later have to resolve, and if it is too bad, I may
even drop the old iteration (because it is stale and a new one exists)
and the new iteration (because it may be fresher but does not work
well with others).

> I'm
> confident the patch at
> https://lore.kernel.org/git/20210306192525.15197-1-avarab@gmail.com/
> addresses the intra-series bug, and the whole thing solves outstanding
> bugs on master.

I recall seeing you use a new option to coccinelle that I did not
get any hit on my search engine in the updated series.  Is the world
ready for the thing?

>> * ab/unexpected-object-type (2021-03-08) 7 commits
>>  - tag: don't misreport type of tagged objects in errors
>>  - object tests: add test for unexpected objects in tags
>>  - object.c: add a utility function for "expected type X, got Y"
>>  - tree.c: fix misindentation in parse_tree_gently()
>>  - oid_object_info(): return "enum object_type"
>>  - object.c: make type_from_string() return "enum object_type"
>>  - object.c: refactor type_from_string_gently()
>>
>>  Error reporting upon object type mismatch has been improved
>>
>>  Looked good.
>
> It still loks scary to me :)

Yes, I do think it was a mistake to rewrite <0 with =3D=3DBAD in this
series, and I won't be marking it to be merged down anywhere until
that gets fixed.  There may be other issues that may have been
pointed out by others' reviews I am not aware of.

> But I've had no feedback on 7/7, which is the real meaty chang in the
> series:
> https://lore.kernel.org/git/20210308200426.21824-8-avarab@gmail.com/
>
> It would be nice to know if that's beacuse others have nothing to add,
> or it just hasn't been looked over.

Yes.

> Just a point of clarification, are all the "Will cook in 'next'" lines
> here to be read equivalently to "Unless something comes up, will be in
> the first major post-release merge down to master?".

It is equivalent to "Will merge to 'master'" outside the prerelease
freeze period.  Unless something comes up, this is on course to be
eventually in 'master'.

> I.e. no pre-release merge of next->master is expected.

In the pre-release period, the contributors are encouraged to
concentrate on finding and fixing potential regressions and on
perfecting those topics that are already cooking (in this order of
priority) to help prepare for a smooth launch of the upcoming
release and the start of the next cycle after that.  It is not the
time to send out brand new patches with the expectation to be in
'seen'.

>> * ab/pickaxe-pcre2 (2021-02-18) 24 commits
>>  ...
>>  Needs review.
>>  cf. <20210216115801.4773-1-avarab@gmail.com>
>
> If anyone would like faster pickaxe reviews of this would be most
> welcome. It's not faster yet with this, but it's the required prep work=
.
>
> Alternatively, what do you think about picking this up up to 15/22?:
> https://lore.kernel.org/git/20210216115801.4773-16-avarab@gmail.com/
>
> Up until that point it's all trivial code changes and testing.

I'd welcome replacement submission that has only patches with
reduced scope, but after the release please ;-).
