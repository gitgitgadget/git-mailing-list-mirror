Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AAB1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFUUIY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:08:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56463 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUUIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:08:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E51BE1534DF;
        Fri, 21 Jun 2019 16:08:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6rrJ34jldYoA
        SiFeCPMVqmzXwR0=; b=B/vZDIkjL9v71M/3FLZzno6pyc/IM/Ow8Ei1hn6pZBBj
        OEgmN9nHSm4HB2IPwvOlTN687wPhORNunJsdrbXQYHyVtEQO+HDgQWh1HlDrAji4
        iFgBJslo2rKfEM9n/unHQ+zIujYdMkD3oLRlDmp5uT/eM83kyzbLoztilYkRDG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OBjSGf
        gplxtjiv9b9C0hPR/Ln3duntWv6A/clXzX2BlwBoRh7XUfiLYy4Jvp/HR9q6KNyy
        5zUqpJ+9tAxWThWLrXzYrLWHPdeG2WGjo7LDQu5Gpdi7eaIBrtSnSckUNbUD9cCd
        X8Sl3jikyx/CnZ08EayTPbcjRwuSG+W5diCGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD0271534DE;
        Fri, 21 Jun 2019 16:08:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 336B91534DD;
        Fri, 21 Jun 2019 16:08:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] tests: mark two failing tests under FAIL_PREREQS
References: <20190513183242.10600-1-avarab@gmail.com>
        <20190620204227.8947-1-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1906212000580.44@tvgsbejvaqbjf.bet>
        <87a7ea94m9.fsf@evledraar.gmail.com>
Date:   Fri, 21 Jun 2019 13:08:21 -0700
In-Reply-To: <87a7ea94m9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 21 Jun 2019 20:26:38 +0200")
Message-ID: <xmqq4l4ik8ga.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51D64FBC-9460-11E9-A2CC-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... The effect of the FAIL_PREREQS mode is to set all
> prereqs to false, and therefore "test_have_prereq AUTOIDENT" is false,
> but "test_have_prereq !AUTOIDENT" is true.
>
> So this test that would otherwise get skipped gets run.
>
> I honestly didn't think much about these cases when I wrote dfe1a17df9
> ("tests: add a special setup where prerequisites fail", 2019-05-13), an=
d
> now I'm not quite sure whether it should be considered a bug or a
> feature, but in the meantime this un-breaks the test suite under this
> mode.

Yeah, reading the above alone, anybody's knee-jerk reaction would be
that fail-prereqs is buggy, but then I am not sure how we can "fix"
that, short of forbidding a prereq like this !AUTOIDENT one from the
test suite.  The test "predicts" how 'git' used in the test body
would behave, and skips it if we know that the predicted behaviour
breaks the test.  Forcing the prereq using FAIL_PREREQS without
actually making a matching change to the behaviour of 'git' has no
chance of producing sane results.

>>> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
>>> index 5868a87352..1f600e2cae 100755
>>> --- a/t/t0007-git-var.sh
>>> +++ b/t/t0007-git-var.sh
>>> @@ -17,7 +17,7 @@ test_expect_success 'get GIT_COMMITTER_IDENT' '
>>>  	test_cmp expect actual
>>>  '
>>>
>>> -test_expect_success !AUTOIDENT 'requested identites are strict' '
>>> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identites ar=
e strict' '
>>>  	(
>>>  		sane_unset GIT_COMMITTER_NAME &&
>>>  		sane_unset GIT_COMMITTER_EMAIL &&

For this particular one, given the test used to set/unset AUTOIDENT
lazily, I am not sure if it even makes sense to keep this test.  If
we break the underlying ident machinery that would be caught by this
particular test, it seems to me that it is very likely that the test
used to lazily set up AUTOIDENT prereq would fail the same way, so
I am not sure protecting it with !AUTOIDENT would still keep this
one useful.

>>> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.s=
h
>>> index 5733d9cd34..14c92e4c25 100755
>>> --- a/t/t7502-commit-porcelain.sh
>>> +++ b/t/t7502-commit-porcelain.sh
>>> @@ -402,7 +402,7 @@ echo editor started >"$(pwd)/.git/result"
>>>  exit 0
>>>  EOF
>>>
>>> -test_expect_success !AUTOIDENT 'do not fire editor when committer is=
 bogus' '
>>> +test_expect_success !FAIL_PREREQS,!AUTOIDENT 'do not fire editor whe=
n committer is bogus' '
>>>  	>.git/result &&
>>>
>>>  	echo >>negative &&
>>> --
>>> 2.22.0.455.g172b71a6c5
>>>
>>>
