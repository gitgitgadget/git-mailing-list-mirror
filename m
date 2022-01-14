Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC5DC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 04:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiANETE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 23:19:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50993 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiANETD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 23:19:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F63E179DAE;
        Thu, 13 Jan 2022 23:19:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=22k2Z6i4IxJhE0ZulyiX5KljBtNB9bsw4KR7clDCzFY=; b=Jpjs
        mUJERLka6WOYEUv/pxlmykjTYOKvpzTeaLrpq76pNLENScL4hC2yXwB7p0hXTSsP
        s+N+L48AK9yvAEmTsvumEVrr/NuYJUwkPA8cZyUebEPFhQlyPo3z9zllZVzeXCvc
        Wxf39p+fC75voGOVaUgrrkC16OhVkeGYyBkaI70=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED8D8179DAD;
        Thu, 13 Jan 2022 23:19:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 511DD179DAA;
        Thu, 13 Jan 2022 23:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
References: <xmqq35lrf8g4.fsf@gitster.g>
Date:   Thu, 13 Jan 2022 20:18:59 -0800
Message-ID: <xmqqk0f3dk5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19629522-74F1-11EC-A10F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> There are a few "oops, what we merged recently is broken" topics
> that still are not in 'master', but otherwise what we have should
> be pretty much what we'll have in the final one.
>
>  - I am reasonably happy with ab/refs-errno-cleanup (just one patch)
>    that fixes the incorrect state of the code left by the earlier
>    parts of the topic that have already been merged during this
>    cycle.
>
>  - I am also OK with ab/reftable-build-fixes (two patches), one for
>    general type correctness fix, the other for helping older sub-C99
>    compilers.
>
> If there are fixes for regressions that we introduced during this
> cycle other than these two topics, I certainly am missing them, so
> please holler loudly and quickly, hopefully in time for me to tag
> the -rc1 tomorrow.

Oh, by the way, the tip of 'seen' has consistently failing the
leak-check test.  I didn't have chance, time or energy to see if
they are failing merely because an existing test script that used to
be leak-clean gained a use of command that has been known to be
leak-unclean without introducing any new leaks, or our recent change
did introduce new leaks to commands that have been leak-clean.
Somebody with too much time on their hand should go in and check to
help, before CI testing on 'seen' becomes useful again.

Thanks.
