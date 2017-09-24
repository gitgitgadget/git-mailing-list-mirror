Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C97202A5
	for <e@80x24.org>; Sun, 24 Sep 2017 08:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdIXH76 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 03:59:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751039AbdIXH75 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 03:59:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B0A78F269;
        Sun, 24 Sep 2017 03:59:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8KHVa9pnBMwMzsoqCQBzQHDAooc=; b=HC39F8
        +/879bmMe0EKco44x4lRflPrw1hUAQTZf5OzrhEdbPZ19x4oFNZeQJEAxjukR/18
        f98AvworTyRUTZQXAJK34kSFmbwbweue/PXAlAb0PSdGkJBBNtnmhe5lCL9F9mCg
        z4AeYtrHYutOQ/jk4U54j1jfr+aYYEvqH6Bv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YzoQV4Q5wTmH70+kpDYOvUA0IN0rPPiH
        drOfyb5MGx2ac1N3s8boXqCYRjHAP5ZgX/2cjQU3qDDQUzi3nEUfx5fhY9fL3+BI
        9FmF0rf0Fb3r34PY7+KTINk35Cm1IBjMV/CKjMZaUXekP/Pi33XO41OenN6w+xtC
        j+OKOGeYsHM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8452B8F268;
        Sun, 24 Sep 2017 03:59:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7CBB8F267;
        Sun, 24 Sep 2017 03:59:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/9] Teach 'run' perf script to read config files
References: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
Date:   Sun, 24 Sep 2017 16:59:54 +0900
In-Reply-To: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
        (Christian Couder's message of "Sat, 23 Sep 2017 21:39:02 +0200")
Message-ID: <xmqqbmm0h6h1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A86B2E8-A0FE-11E7-91B6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> (It looks like smtp.gmail.com isn't working anymore for me, so I am
> trying to send this using Gmail for the cover letter and Submitgit for
> the patches.)

SubmitGit may want to learn the "change the timestamps of the
individual patches by 1 second" trick from "git send-email" to help
threading (you can view inbox/comp.version-control.git/ group over
nntp and tell your newsreader to sort-by-date).

> Highlevel view of the patches in the series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - Patches 1/9 to 4/9 were already in v1 and haven't changed.

It isn't quite clear what _did_ change in the series and what
lessons were learned form the previous round's discussion here.  The
sample configuration in the description above (snipped) seems to
have been extended and it shows that one of the use cases of the
feature is to allow comparing runs against two versions, which
looked more or less sensible way to express it.

> Christian Couder (9):
>   perf/run: add '--config' option to the 'run' script
>   perf/run: add get_var_from_env_or_config()
>   perf/run: add GIT_PERF_DIRS_OR_REVS
>   perf/run: add calls to get_var_from_env_or_config()
>   perf/run: add get_subsections()
>   perf/run: update get_var_from_env_or_config() for subsections
>   perf/run: add run_subsection()
>   perf/run: show name of rev being built
>   perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
>
>  t/perf/aggregate.perl | 11 +++++--
>  t/perf/perf-lib.sh    |  4 +--
>  t/perf/run            | 89 +++++++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 89 insertions(+), 15 deletions(-)

Thanks.  Let me see how well it works ;-)
