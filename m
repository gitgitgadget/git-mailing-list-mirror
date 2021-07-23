Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E84C43214
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0B260ED7
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhGWVW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:22:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55758 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhGWVWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:22:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB0F6D6E7D;
        Fri, 23 Jul 2021 18:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PqfGlXa7ee2Q
        iU9N5JmljwT4UErIUvcwEI+ds1Z+Trs=; b=L/JvhBeX31k0swHBeWXyZzp2DHOb
        g/DPmpSQaSHS8sF//aHKj3ZbVgPH2P2aG/E0qEMTn1yqsoCrKlc2yGc7SP6u2POC
        jVO3jaLBywAhOg32YanFyPTfcdEz/eHNtxHiEWegpB91olDQS+B4gCf88buuyKZ2
        cA3s8zW6+6KZmNc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1A0ED6E7B;
        Fri, 23 Jul 2021 18:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EF7FD6E7A;
        Fri, 23 Jul 2021 18:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/8] progress: assert "global_progress" + test fixes /
 cleanup
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
        <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
Date:   Fri, 23 Jul 2021 15:02:56 -0700
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 14:54:58 +0200")
Message-ID: <xmqq7dhglmcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCD48BA8-EC01-11EB-B2C8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> These patches were originally submitted as part of a much larger topic
> at [1]. The add a "global_progress" "struct progress *" which we
> assign/clear to as we start/stop progress bars.
>
> This will become imporant for some new progress features I have
> planend, but right now is just used to assert that we don't start two
> progress bars at the same time. 7/8 fixes an existing bug where we did
> that.
>
> To get there I fixed up the test helper to be able to test this, moved
> some code around, and fixes a couple of existing nits in 5/8 and 6/8..
>
> See also [2] which is a re-submission of that larger topic, but the
> two can proceed independently.

OK.

>
> 1. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z=
-avarab@gmail.com/
> 2. https://lore.kernel.org/git/cover-0.3-0000000000-20210722T121801Z-av=
arab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>   progress.c tests: make start/stop verbs on stdin
>   progress.c tests: test some invalid usage
>   progress.c: move signal handler functions lower
>   progress.c: call progress_interval() from progress_test_force_update(=
)
>   progress.c: stop eagerly fflush(stderr) when not a terminal
>   progress.c: add temporary variable from progress struct
>   pack-bitmap-write.c: add a missing stop_progress()
>   progress.c: add & assert a "global_progress" variable
>
>  pack-bitmap-write.c         |   1 +
>  progress.c                  | 116 ++++++++++++++++++++----------------
>  t/helper/test-progress.c    |  43 +++++++++----
>  t/t0500-progress-display.sh | 103 +++++++++++++++++++++++++-------
>  4 files changed, 178 insertions(+), 85 deletions(-)
