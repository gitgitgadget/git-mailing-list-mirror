Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C466C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F6D611AB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDOIPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:15:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhDOIPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:15:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B5B9C2F56;
        Thu, 15 Apr 2021 04:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=e7a9cIvYr97BOZgsZCXDvyvsR
        vQ=; b=dmPXoOkwl/cPNNr58CdTnsA3A2TAiAUP/yq9YmQ2oFzltQdCGd3UPr8vC
        UlN7NzhAQE5pkyETgeP+5ksSOppKlxXGp/FwcD5EK4yBWX5blQvXyZImh/S93t7u
        MF5/DyfypGIojjtlObs6/lsOdqhEpAdOTGnDP34YafX9kbEis0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=UYcUt6NYomfCFWMyVv7
        mahxQ1ibw9intoNnwQdKtIqBq+76Lqr2aHWMMx5cwymbz6Gxoelxl4xHa8nW5/56
        hwu0kGAYnizGISoL0yuuAhNWp0MlYVFTt2Mhi2nqCePxxUKFBAINgubHKOaVwr2l
        CMW21EcPVcM8hrJEtYkN6f7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83191C2F55;
        Thu, 15 Apr 2021 04:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08F61C2F54;
        Thu, 15 Apr 2021 04:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        <874kg92xn0.fsf@evledraar.gmail.com> <xmqqim4pz83e.fsf@gitster.g>
        <871rbd2u47.fsf@evledraar.gmail.com> <xmqqblahz4hx.fsf@gitster.g>
        <87y2dl18mg.fsf@evledraar.gmail.com>
Date:   Thu, 15 Apr 2021 01:14:38 -0700
Message-ID: <xmqqlf9krmkx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F86B176-9DC2-11EB-AFB0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What I am saying is that it's incompatible to have:
>
>  1. Failing tests
>  2. Not removing scratch files that would otherwise be removed
>
> And:
>
>  3. Knowing that the rest of the tests pass in the case of #1 without
>     reading them all.
>
> Hence the suggestion that we should use test_when_finished without
> exception for such patterns.

I disagree with the above; t4013's "read magic cmd" part is designed
to be independent from each other; I do not think you need to read
all of the parts enclosed in << ... EOF to understand that.

In short,

 * "test_when_finished 'rm ...'" is a good tool to ensure something
   gets removed no matter what else happens in the same test.  Since
   it does not run the clean-up under "-i", it can even be used on
   files that would be useful in diagnosing failures.  But under
   "-d", it does clean-up to avoid affecting the following test.

 * $actual was made unique so that even under "-d", a failing test
   would not negatively affect the subsequent ones.  Removing it for
   failure cases is actively wrong, so use of test_when_finished,
   which may be an expedient way to remove artifact that would
   negatively affect later test pieces, does not apply --- existing
   code is doing better than test_when_finished can offer, and
   replacing it with test_when_finished is a regression.

 * And the most important part: the unnecessary removal of $actual
   was not even part of the "flakyness-causing" bug you started this
   topic to fix anyway.  We should just remove the regression caused
   by unnecessary use of test_when_finished and focus on the "don't
   place the actual output from a brand new test under the file used
   for the expectation the next time---instead place it under
   temporary file and call for attention" part, which was the real
   improvement.

>> Please do not advocate for and encourage newbies who would be
>> reading the discussion from sidelines to use test_when_finished out
>> of dogmatic principle without thinking.
>
> Is Matheus the newbie here? I think he's contributed enough to form his
> own opinion.

No, those "reading the discussion from sidelines" are not on To: or
Cc:, but are eager to learn by reading what is available to git@
subscribers (including the lore archive).  I do not want those of us
whose name appear often in the list archive to be sending a wrong
signal to them.

> In any case, I think it's best to just drop this series.

That is a sad and wrong conclusion.  We should just realize what we
really wanted to fix in the first place and keep the improvement;
otherwise all the review time was wasted.

And next time, I'd suggest you not to spend too many bytes on "while
at it".  Clear and obvious clean-up while the tree and the project
is otherwise quiescent is very much no-brainer welcome, but
otherwise...

Thanks.
