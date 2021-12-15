Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B7CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhLORch (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:32:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52879 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344055AbhLORcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 12:32:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF646F0B63;
        Wed, 15 Dec 2021 12:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0yQPdYxjBOilGJcPHScZBwu46YcdLbJl6LMsvW
        dytaE=; b=sQerKQqc1JpQpntCIIoUur9Tu8EShBsMnQRoLe0kSGt8/c8/TOexLS
        O/O2uDIWr6LOPhuLTnNM4idGoWIk5yf+FHCDm36cEl9+i5sBiVazMOYerP9f+xdz
        ZGQKg2YOOr24M3xShM9UMbrazYe6jO4LNVdBlYaaUH9bu2ZW7CZpI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A792FF0B61;
        Wed, 15 Dec 2021 12:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 130ABF0B60;
        Wed, 15 Dec 2021 12:32:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
        <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
        <20211212163207.GA3400@szeder.dev>
        <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
        <20211212201441.GB3400@szeder.dev> <xmqqo85kcp99.fsf@gitster.g>
        <YbjJuh4dVijL7jw4@coredump.intra.peff.net>
        <xmqqh7b994tw.fsf@gitster.g>
        <YbojKafkC/JcX4d1@coredump.intra.peff.net>
Date:   Wed, 15 Dec 2021 09:32:31 -0800
In-Reply-To: <YbojKafkC/JcX4d1@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Dec 2021 12:17:29 -0500")
Message-ID: <xmqqczlx93kg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC669E18-5DCC-11EC-A62E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 15, 2021 at 09:05:15AM -0800, Junio C Hamano wrote:
>
>> Still.  I wonder if keeping BASH_XTRACEFD helps developers, when
>> they need to diagnose a new breakage?  If their new test fails only
>> in the "dash -x" run but not "bash -x" at the CI, for example?
>
> I have done that, but usually only after realizing that "./t1234-foo.sh"
> passes and "./t1234-foo.sh -x" does not. So I think just tweaking use of
> "-x" would be the main tool.

Ah, that's true.  You only need to compare "sh -x test.sh" with "sh
test.sh" with any value of "sh", especially after BASH_XTRACEFD is
removed, demoting "bash" to the same state as "dash" wrt "-x".

OK, I am more OK with the removal of BASH_XTRACEFD support than
before ;-)



