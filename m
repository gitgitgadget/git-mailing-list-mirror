Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C252C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBB723382
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgLPR20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:28:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51616 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgLPR20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:28:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43E25FBD31;
        Wed, 16 Dec 2020 12:27:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zo6jXx5mY+Ut8/1hcLkPxnsLDCM=; b=NtrPGf
        +O7TWm1TsdezJSS2wwKOUgqmBxbKMMU1/xI5w/mJqSVh7hBttu1E4mnPKorpd0AS
        rITB2bzyJL0FUaXiQ8tWRCL+r8B49Rsuf9mbKuA32erVHgt8Z62FgyY6vsWAFSyx
        O0v2hMRu7d+RyFjXZnTP2Ago02Je17Eq1CEvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FZz/J0QDx4ye/UKDA8wwve0ef+WNDnZj
        MFgEmeVGnz3cGUZmJzZSn4gny8oYQ/4JaRgx6qN8aefJA0yrHgYQe4MatSyFPdTY
        ukIjf2jbMrPkzMeSkuRyvIG+VdBp8EN8afN6g0U1GqIREefsLoHBCqWpWXWm0BSV
        MMpS4AtIMKs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AE3AFBD30;
        Wed, 16 Dec 2020 12:27:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19B24FBD2F;
        Wed, 16 Dec 2020 12:27:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
        <xmqqeejraiw7.fsf@gitster.c.googlers.com>
        <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
        <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
        <xmqqzh2e7p6l.fsf@gitster.c.googlers.com>
        <X9ksfyBujBrYWmAW@coredump.intra.peff.net>
Date:   Wed, 16 Dec 2020 09:27:37 -0800
In-Reply-To: <X9ksfyBujBrYWmAW@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 15 Dec 2020 16:37:03 -0500")
Message-ID: <xmqqsg854q5y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FED0857E-3FC3-11EB-880B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 15, 2020 at 01:08:18PM -0800, Junio C Hamano wrote:
>
>> Elijah Newren <newren@gmail.com> writes:
>> 
>> > Doh, sorry for the bug.  Yeah, that's the exact fix I'd make.  Junio,
>> > do you want to just use the changes you've already got, or would you
>> > like me to submit a patch removing these two 'return's?
>> 
>> Nah, the other half of the reported issue was mine, so let me see if
>> I can quickly whip up a two-patch series.
>
> Thanks, both look OK to me. I probably would have kept "return -1" in
> the setitimer one, but I doubt it really matters much either way.

Yeah, we know that the return value does not matter as nobody looks
at it.  I just was a bit hesitant to clobber errno with ENOSYS.
