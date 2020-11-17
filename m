Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FAC64E69
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD7F2463D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YSRnN22g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgKQQKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:10:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:39665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQQKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605629413;
        bh=aEa2oLxM/lcSyf5q/VcrbMHY+Gke2o3aAynnRnRgKSc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YSRnN22g0NcPXCG53Kkvk15bFtrJIEVTAEkDFDw5cICEG90viQA0T4UHNVjeOPsDc
         q3On8CJxRRAw0co1rkg77PRAnFhOo1UIKQbpdgYg6EW+sUiJtSv1KkZ0RMAF1e3IRu
         MceC1qAD5/3twx5qhyf3NhCfCLilsl8YWhNqtfEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1kvCIq2Asn-00PgSv; Tue, 17
 Nov 2020 17:10:13 +0100
Date:   Tue, 17 Nov 2020 17:10:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/28] Use main as default branch name
In-Reply-To: <xmqqr1ot84fr.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011171651130.18437@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <xmqq361ccvot.fsf@gitster.c.googlers.com> <xmqqr1ot84fr.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3tkmNDqKilYSoddkF8Fo+l7+Zwoxp64zWBpOww2EYlOJwB7goQZ
 tkxUKtdHKtjE10yupr6ZHZVscWMtOwZcIYViV5yWcJ/J2Xgbj/U6N2b1qZZv5upMUF2R8ni
 Ou/jL341AFBjjn0X4Na44TnqE87V7n6a0wISaeE+e3fwFCVme9C/WyBWDwEbuRUamdNTfLV
 RABYvusPkp3uhtQnmWU9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OEYeSV4oLow=:2oePf0PVbSHxFEt+w7YdWa
 1kgFK7pVkQY2GH0zyhh3B/Mels1JzyXam5LfbM0zXLNyXElqgiAKmnbC4vKHauyV6iGPq3HdY
 ROb6dBEOsJ5neOuBDVRf0aLioQYBlptlULoWWEV+OiYxDyDSYBl+qYaR/qaC1CajOUYSISx5O
 Q2TL6jsqdzPKuX97ndFW/BUJGHGG+L6twDEUlOAGfT8DRwLt3G5rSVOLGiFBZXJ/4xFQ8R5Gg
 YMadkljJNTH4V0HEFKMtFT2ID8PhuKfvQkKMSxSQ8zLr8mIKF2hn6LcaK7J4c5Ypa/ip01oOi
 0cCbrTdmCHceSH/qmGiX1CNucINBUapsEVGBAnRSlOx7NSQZXMdu9IPUu6woQXp+efbMpxDje
 qyTgKDqbPr5o9++w/0L/XjOR9PPJbEwEc6cgVVcosV9dwUJZ5e7rXHN5hYqwkjrGJLh2sulBP
 K5MqEyQ1BuR4LcSrBD4DVn/9CC5S+GYVKcCEk/bNurdY/PqURn2kC+m1mNytn3oGDBEG//7nr
 lhNUIkKVW0hdSpYNq7yg5riAkWLrN4rykwsGfwZASFIlvmhGpkrH4UrM9N4wpK1NmHFsLv7Qn
 zJlPpTlwvB9lAyWVscUIfQxTYdXtia65TmmHK8w9JkOPOefoA+EK3YzHc4hr2y+HkLZ6Cdy/0
 TzZhvYDikONyYBxP/i64P4ZlVLE1Heo9mg5nXKwCsw1Va/5j814VrUA1k6tbcwghNV/PMcZda
 RMVUxTzvpU7xDtcRF9SBFbz2etS/hOa8+ubnnv50Vv3TmTDvAnxjphjjySFBzrNVtOZ2uZ0xF
 74MhhHzof9b33F0D1dfhFe7Ce40RDi6QE/olq+1bZUpYgZMaekBNjKCRdRyhWQEzQHp2Y2Xec
 B+oSVjtnyNAI/alPVEp6hyvN2yMUrgzBgu4AEW+00=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Nov 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >    Some test scripts may require setting init.defaultBranch=3D'master'
> >    at the top in the 'setup' part (I've shown how in my response to
> >    t4013 patchset) if the body of the test relies too heavily on the
> >    primary branch to be 'master'.
>
> Ah, I realized we have much better mechanism already in the form of
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment.
>
> So, my three wishes in this message now become
>
>  - lose PREPARE_FOR_MAIN_BRANCH prerequisite as quickly as possible

Okay, we're on the same page here.

>    by doing the following two.

A couple of test cases already have the `PREPARE_FOR_MAIN_BRANCH` prereq
(in preparation for transitioning the test suite, which is what I will
settle for in v2 of this patch series). Most notably, t5526 and t9902,
which I had to exclude to avoid clashing with branches that are currently
in flight.

So my goal is to transition the test suite as quickly as possible, by
first converting the majority in v2 of this patch series, and then
handling the rest of the test scripts individually, on top of the
in-flight topics.

>  - Use that mechanism to force 'main' in test scripts that now only
>    can work with 'main', even before we change the fallback default
>    from master to main in the production code, so that we won't lose
>    test coverage.

That's precisely what I do, incrementally, by adjusting that `case`
statement in `t/test-lib.sh` whenever a range of test scripts has been
transitioned. In patch 2/28, it looks like this:

	case "$TEST_NUMBER" in
	[01]*)
	       GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
	       export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
	       ;;
	esac

By patch 26/28, it looks like this:

	case "$TEST_NUMBER" in
	3404|4013|5310|5526|6300|7064|7817|9902)
		# Avoid conflicts with patch series that are cooking at the same
		# time
		# as the patch series changing the default of
		# `init.defaultBranch`.
		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
		;;
	*)
		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
		;;
	esac

>  - The same for test scripts that are not converted yet to force use
>    of 'master', so that we could change the fallback default from
>    master to main in the production code even before converting
>    these other scripts, so that we won't lose test coverage.

Okay, I could have done it that way by starting with

	case "$TEST_NUMBER" in
	[01]*)
		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
		;;
	*)
		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
		;;
	esac

But that would result in a funny-looking intermediate state with a
`master` arm, then `main`, then again `master`.

Besides, it would be more complicated because t/t5411-proc-receive-hook.sh
and t/t5515-fetch-merge-logic.sh already ask for `main`, but by setting it
before sourcing `test-lib.sh`, and therefore we would have to special-case
them in that `case` from the get-go.

Therefore, in the interest of making this patch series _slightly_ easier
to review (you still have to look at the _bottom_ of most of those patches
to catch the crucial change to `t/test-lib.sh`), I would like to keep the
patch series in the current shape.

Will send v2 in a moment.

Thanks,
Dscho
