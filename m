Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99777207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbcI2T5q (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:57:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755583AbcI2T5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:57:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D824C42F87;
        Thu, 29 Sep 2016 15:57:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SbESo9Vs1/GcgH0TqIWHfvvrpok=; b=daZtIS
        6hBEMDLM5ieLuZMyIb5EFk1kEifem/oxOzpVDRAelrrjnz7akgZc7zpCsBe/e+Y/
        30rl/kOPo+1A8qtcVT1wLRa62x4NuUy3kP1HgvWkk/W1eRB6bgXmR5qLVH3ZCZb2
        Y2BpYVDg1qVu1Ophbx+ajJ0KfE10wCWi4u5U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x8vPXT3v6vUr5mTdSUYfPk1pN0XiXg7u
        5WRGzP2logvfjHhfhhkeKw65NZ+FMa7O/g9lpPSgOMYHdeyE8mJ4iFhpv78G89p5
        RF6NRdhN59YRZo/eiFFtTrg6cFYPgN+zDfeSRFhJPwbBnDy+rB3tW9aOdCuTj64R
        ju+cUG7IP70=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0E5942F86;
        Thu, 29 Sep 2016 15:57:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5655C42F85;
        Thu, 29 Sep 2016 15:57:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-3-gitster@pobox.com>
        <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
        <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
        <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
        <xmqqa8eqfsap.fsf@gitster.mtv.corp.google.com>
        <20160929191857.lxcgzf2cg5zfjkrq@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 12:57:41 -0700
In-Reply-To: <20160929191857.lxcgzf2cg5zfjkrq@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 15:18:57 -0400")
Message-ID: <xmqqshsieax6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC06615E-867E-11E6-903D-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I just don't see it being a problem. Adding core.abbrev for the whole
> test suite is just about not having a big flag day where we change all
> the tests. Changing one or two tests (and again, I'd be surprised if we
> even have to do that) doesn't seem like a big deal.

I've already wasted several hours whipping t1300 into shape, because
it was done in not so forward-looking future-proofed way.  I am not
worried about core.abbrev but I am worried more about the next thing
that requires us to add an entry to t/gitconfig-for-test.  Adding a
corresponding entry to retain the old default for that new config to
two places may not be a big deal, but it still makes me feel a bit
uneasy.

In any case, I suspect that Linus's "auto" thing may still need the
custom system config with t1300 clean-up to pass the test, even
though I suspect it would compute that 7 is enough for most of the
tiny repositories our tests use, so I'll polish this a bit more
while waiting for that discussion to settle.

Thanks.




