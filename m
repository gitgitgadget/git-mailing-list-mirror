Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D142C56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AD2238E6
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XZtN5GwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgKSTaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:30:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56211 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgKSTaU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 14:30:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B40BE80E10;
        Thu, 19 Nov 2020 14:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TEeYDqxH+NLmIY3WoeLg8zt4e18=; b=XZtN5G
        wRc9iuJmOXPnCNR2u/jUPeC0iiJJkqRqkdh6BtkojXiEJ2QBjLLbr0m8OKBQOl+C
        qzvpdvbJUrQW0/ZXKjPfh4IZkkzskcm8a7qct1muZpL93veYIMz3isEJRmFwlQEB
        OptXMe4ajcqckIHmNz6hMyIx/T04L5RoEODQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SGCB0iH14iOIxEret1KCc+UyuCi+I/Nr
        pNA1aVF11D9q+KbfjTn7/oVgtHMXpkAksFe4LNLQKW3a0rXB5uctMRfPO1uZ2tpv
        94lNqlNa2haHqZiMZI5VcSPlyL5S+FYkCDelC6ssgBvu4Z0EsG99Wu8aZi/H8zzf
        vcrt4BwbRx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB28080E0E;
        Thu, 19 Nov 2020 14:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2888780E0C;
        Thu, 19 Nov 2020 14:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 28/27] tests: run tests omitted by
 PREPARE_FOR_MAIN_BRANCH
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <20201118114834.11137-1-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2011190044100.56@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Nov 2020 11:30:17 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011190044100.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 19 Nov 2020 00:56:20 +0100 (CET)")
Message-ID: <xmqqo8jtxhyu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A801B3E8-2A9D-11EB-BDDF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The conflicts might be trivial, but every conflict makes it harder to
> juggle branch thickets like Junio's `seen`. And those things add up.
> They're no fun, and they make life hard and tedious.

The worst part is they can easily be cause of unintended breakage
due to mismerge.

> t5526 conflicts _semantically_ with `pk/subsub-fetch-fix` (which touches
> t5526 and adds a new test case referring to `master`).
>
> t9902 conflicts with `fc/bash-completion-post-2.29`, and in contrast to
> the t5526 issue (which is trivial, even if it does require manual fixing),
> the t9902 is a bit more hairy to reason about.
>
> So yes, I would love to have that test coverage back, but not by making
> the transition to `main` even harder by reverting parts of it.

Hmph, wouldn't the forcing with GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
to 'master' be the right way to keep test coverage?  After all, the
primary goal is to prepare tests so that we won't lose coverage when
the fallback default of init.defaultbranch is switched to 'main',
and it is a secondary goal of much lessor importance to reduce the
number of hits from "git grep master t/".

> That's why I promised publicly to take care of the loose ends as quickly
> as I can, after the conflicting issues graduate to `next` (or when they
> become stalled or even dropped from `seen`).

Perhaps I should start to more aggressively drop topics from `seen`
that are not sufficiently reviewed?  The guiding principle ought to
be "unreviewed patches are not worth applying", but I have a feeling
that we have become more and more lax over time due to shortage of
quality reviews.  I dunno.

