Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837AEC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEF3613BA
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhDMVmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:42:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58677 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhDMVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:42:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7A24B62EB;
        Tue, 13 Apr 2021 17:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KHlXbZZFxNwS
        HgmqdsOGUh9bZ/c=; b=kpKlIVUQ5W7BMENYClMz9ukmFyxIZ3PgcvWDuDU2B1bQ
        r2jl16pmPLtaGqOtVdVemWihXSHv2a+h6s0KKK6Rzlfo099v28O/r6A+SXlQL+TY
        1Nb06RUM8GV/Kmg75+VTRnRwf0OgsK2nakQD6oGD3+1tGwGTg7zAmuGRzp8jIs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rZL7nb
        ejk54NrZqGjcwNz9k6CUO3pg+FP5MTLVpkxNvfcmBiIswlMJo/ufCR3K3NAI3s+m
        qic+oOFAeUvSX3LXuUo9f+yOSEtDlamCPxRgMuVeQQgw8zr8vUvRRO1fiQeQNtTo
        ttkRMIyp6hkSDjVtYMmncpMNL2tViDiDSKcNs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF7CEB62E9;
        Tue, 13 Apr 2021 17:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D239B62E8;
        Tue, 13 Apr 2021 17:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff tests: un-flaky and post-gettext-poison cleanup
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
Date:   Tue, 13 Apr 2021 14:42:32 -0700
In-Reply-To: <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 13 Apr
 2021 14:28:32 +0200")
Message-ID: <xmqqpmyxkgjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 279E726A-9CA1-11EB-9D75-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In reply to [1] because they're related post-GETTEXT_POISON cleanup,
> but both apply on top of master.
>
> I had a flaky t4013 test with some local WIP code that I hadn't
> investigated, as it turns out re-running the test was hiding the
> failure. 2/2 fixes that, 1/2 is a minor post-GETTEXT_POISON cleanup.

I feel somewhat offended to see t4013's "auto preparation of the
expected output" feature (which of course I invented) as "flakey" ;-)
but I agree that was a misfeature.  Thanks for taking a look.
