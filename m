Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6305C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 19:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349511AbiDKTNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiDKTNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 15:13:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D871EECB
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 12:11:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AD68187F75;
        Mon, 11 Apr 2022 15:11:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A/eqXXJRKBAqwC+0YGK9IyEX/Qr3fMYG1qFLkO
        vWnW8=; b=mONei+ifAU13phCBIXOVpnUnDXcR/spgiT4u1FHsfkROAETlG+fj17
        n1MACwHpWAaXhWqmMg3oIxGJGYLAYs5i6zsPS6hlzOzV4wRcte13c0MJQV0ejLWW
        SZWFelZ1ulnov5RlYKDELJzuZm8HNpUs5/7djMcVBP90PebIQXTlk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FA15187F74;
        Mon, 11 Apr 2022 15:11:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E6A0187F72;
        Mon, 11 Apr 2022 15:11:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
References: <pull.1210.git.1649507317350.gitgitgadget@gmail.com>
Date:   Mon, 11 Apr 2022 12:11:19 -0700
In-Reply-To: <pull.1210.git.1649507317350.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Sat, 09 Apr 2022 12:28:37 +0000")
Message-ID: <xmqqtuazh1uw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BD69B26-B9CB-11EC-9CDC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As the address sanitizer checks for a superset of the issues detected
> by setting MALLOC_CHECK_ (which tries to detect things like double
> frees and off-by-one errors) there is no need to set the latter when
> compiling with -fsanitize=address.

Very good idea.

>     I'm submitting this now as it fixes a regression introduced in the
>     current cycle. Having said that there is an easy workaround (once one
>     has discovered GIT_TEST_NO_MALLOC_CHECK) so I'd be happy to wait until
>     the start of the next cycle given I've just missed -rc1.

Yeah, if this patch were broken, we'd be in worse place than we
currently are, so I'd rather not fast-track it.  I will queue it in
'seen' and possibly merge to 'next' as it is a good idea to avoid
using both at the same time, though.

Thanks.
