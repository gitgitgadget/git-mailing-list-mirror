Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B6C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 16:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356838AbiDLQFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiDLQFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 12:05:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDC64E3AF
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 09:02:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71D7911A6CA;
        Tue, 12 Apr 2022 12:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=03pkyGoK5t7d
        XpO9HqV8TV/kwNPgHEsMPqqp5mfxPwM=; b=Xv9dGPVlYsB8Yo//6eUkcsp9c+Qs
        fh283YGr+DCOksUUodo8ztQKgofCus7zwCCvxhdeopm3sq5EIsQz+PT2p5LYJ5DH
        QbCF6aUfXbJ3NE7d7KNBMBPAnDV3uD/95yrajN6CqbWjUNwuLdZQx2C9R1DJ4w/Y
        KJeTm3bqGH7yyEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6913B11A6C9;
        Tue, 12 Apr 2022 12:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83C9D11A6C8;
        Tue, 12 Apr 2022 12:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Makefile: add a prerequisite to the
 coverage-report target
References: <20220409043033.1288946-1-gitter.spiros@gmail.com>
        <xmqqv8vfiidm.fsf@gitster.g>
        <220411.86fsmji970.gmgdl@evledraar.gmail.com>
        <xmqqpmlnfcq1.fsf@gitster.g>
        <220412.8635iiivgm.gmgdl@evledraar.gmail.com>
Date:   Tue, 12 Apr 2022 09:02:56 -0700
In-Reply-To: <220412.8635iiivgm.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 12 Apr 2022 09:51:35 +0200")
Message-ID: <xmqqh76ycmrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0513504C-BA7A-11EC-93E2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But that's not what I'm talking about here, I'm just saying that we'd d=
o
> a normal "make test" where we write the gcov tests per-test into
> t/test-results/t0001 and join them at the end of the run.

OK, instead of per directory .gcov, we allow separate recording area
per test, ...=20

> No, on a multi-core machine the inability to run with -jN is the main
> factor in making this run slow. E.g. on my 8 core box the tests run in
> 2-3 minutes with -j8, with -j1 it's 20-25 minutes.

... and that would make it easier to run the same binary from
different tests in parallel, which makes sense.

I missed that you were talking about running tests in parallel when
you brought up the "running tests can be made cheaper".

> So I'm wondering if the desire to keep the old coverage report around i=
s
> synonymous with the current implementation running so slowly.

Possibly.
