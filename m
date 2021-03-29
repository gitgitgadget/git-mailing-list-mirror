Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCDC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFE06192F
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhC2XJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:09:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54462 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhC2XIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:08:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34031111E30;
        Mon, 29 Mar 2021 19:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pFfqgNMj6icC
        t+I7trL/t9VEO4U=; b=QdwtiMph/EWo9mDhCvBrpjcq8DPFlvNGT1ayM4wN0RAV
        tbudLOzCvTeWUzN3faksFN6DPpXJbjQ9higE59ok7bSpKx5+KaRike5ufhIZcDY9
        T4AS56fXolCx5eKE4gUqyxMugc3mLyZv7IxIhCwpQcMeit1/e8uGxbia+deMGuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ni6z9/
        CdGL/v7jIrCaMV/f5b9Xj0sFMM6IFGdazI1kPAnhfCJrIITJrALOOkr3tbGQ+coI
        dJn//uqcBj2JUaLe8aRXLWR3QVt/fvLhef+4TtUcv4IMmjR1KCApim2X4XWpz9kF
        8oNz6fpc9D4A17cLDLGaXlGmyqfstC50Aj8XE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CADA111E2F;
        Mon, 29 Mar 2021 19:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6548D111E21;
        Mon, 29 Mar 2021 19:08:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Makefile: make non-symlink & non-hardlink install sane
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 16:08:36 -0700
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:38 +0200")
Message-ID: <xmqq7dlph823.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2102020-90E3-11EB-891C-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is on top of my just-submitted "Makefile: don't die on AIX with
> open ./git" series: [1]
>
> This series introduces no "real" behavior changes I'd expect anyone to
> notice, but refactors a lengthy copy/pasted test/if/else in the
> Makefile into a simple helper script.
>
> The "real" behavior change is that we no longer ask the user how
> they'd like to install (symlinks, hardlinks, neither?) and then
> proceed to ignore what was asked of us and optimistically fallback in
> case of errors. I.e. the inability to create symlinks or hardlinks.
>
> Instead we'll just die, the old behavior is still available as
> INSTALL_FALLBACK_LN_CP. In practice I think exactly nobody actually
> wanted the existing behavior.

I read most of the patches in the series.

While I like the general direction to allow builders/installers more
precisely to specify what methods of installation are preferred, I
do not know if I agree with the exact execution.  It does not help
that the series is built on top of that "generate in temporary and
move to the final, even for $(CC)" series, most of which I do not
think I agree with.

Thanks.
