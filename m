Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_C,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9EC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074C60F3A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbhHESrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:47:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65083 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhHESrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 14:47:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2586CCAA4F;
        Thu,  5 Aug 2021 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Feh9tl59qIF4F8wi20FXog1F+KErm7uUSxSHmaNQUaM=; b=sl/X
        xU4cQPtlAFsgyvrLjcieLK3j68T/SA8oI8QpkCq5p10OFL+hgkYZhdBy6X3C5zYR
        FTM0E4a7cRNfY4LYhRyZ6fxhS8Qq6RNZTEB51KQSn/gdKVxr2OPpzCKiWP9LQrlP
        mtssK+4aTF9QCEKmeRvMZjY4woF7miwAHZS7DaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10F8DCAA4E;
        Thu,  5 Aug 2021 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85558CAA4D;
        Thu,  5 Aug 2021 14:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/6] revision: separate walk and unsorted flags
References: <cover.1624858240.git.ps@pks.im> <cover.1628162156.git.ps@pks.im>
        <67232910acf4a248654060ad51a17af37acba0fb.1628162156.git.ps@pks.im>
Date:   Thu, 05 Aug 2021 11:47:23 -0700
Message-ID: <xmqqa6lvloec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92FFD226-F61D-11EB-87E6-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The `--no-walk` flag supports two modes: either it sorts the revisions
> given as input input or it doesn't. This is reflected in a single
> `no_walk` flag, which reflects one of the three states "walk", "don't
> walk but without sorting" and "don't walk but with sorting".
>
> Split up the flag into two separate bits, one indicating whether we
> should walk or not and one indicating whether the input should be sorted
> or not. This will allow us to more easily introduce a new flag
> `--unsorted-input`, which only impacts the sorting bit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/log.c    | 2 +-
>  builtin/revert.c | 3 ++-
>  revision.c       | 9 +++++----
>  revision.h       | 7 ++-----
>  4 files changed, 10 insertions(+), 11 deletions(-)

Every line of changes in the patch is very satisfying ;-)
