Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2303C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7929022472
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgL1Wzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55754 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgL1Wv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 17:51:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBC038904E;
        Mon, 28 Dec 2020 17:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOROFkEJd0+Aj4doIF4RglcCDyU=; b=Qt/0cL
        mx9U309W0rZFT+/20zFlIhTib8flDnCzkgLKxRIiEkJ2DZkRyI6gxRgVL5Xjd3Bk
        pAi1/aVKhMAxNTi4NSPkjK9b5m828l3a3SaGZ0Av+pfp+ryqYB9zhYyvdlE/BDkd
        45Stq7DZ5SzNt0M1QKLEwRfrjFgrp65RgXupE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fMz2f1BR2RgHDqN/vwRUN4s8xR3R9l4D
        /EO/blfgu375sE39OdwMB36FEMXFRjMnVl8Tj4Ka5dw7fFQDwXDEVkhzh68Q1jAc
        k9vozM3uknXyw65o6dW41gdWGAdj4oEgRi/aiGmLbmnFKM+9H8i7OBijtrlc1p2I
        POH8aL9ik1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D008B8904D;
        Mon, 28 Dec 2020 17:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50F568904C;
        Mon, 28 Dec 2020 17:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
References: <20201222000220.1491091-1-emilyshaffer@google.com>
        <xmqqft3yk2ti.fsf@gitster.c.googlers.com>
        <20201228183445.GJ3783238@google.com>
Date:   Mon, 28 Dec 2020 14:50:42 -0800
In-Reply-To: <20201228183445.GJ3783238@google.com> (Emily Shaffer's message of
        "Mon, 28 Dec 2020 10:34:45 -0800")
Message-ID: <xmqqr1n9ee9p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DAC73FA-495F-11EB-9C49-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, Dec 21, 2020 at 06:11:05PM -0800, Junio C Hamano wrote:
>> 
>> Emily Shaffer <emilyshaffer@google.com> writes:
>> 
>> > Since v6:
>> >
>> >  - Converted 'enum hookdir_opt' to UPPER_SNAKE
>> >  - Coccinelle fix in the hook destructor
>> >  - Fixed a bug where builtin/hook.c wasn't running the default git config setup
>> >    and therefore missed hooks in core.hooksPath when it was set. (These hooks
>> >    would still run except when invoked by 'git hook run' as the config was
>> >    called by the processes which invoked the hook library.)
>> 
>> Thanks.  Queued both series (it probably is easier to think of these
>> as a single 34-patch series, as long as they both are in flight at
>> the same time).
>> 
>
> Do you want me to send them as a single thread for next version?

Unless we deliberately focus on stabilizing the early 17 patches
into a shape that they won't need updating while working on the
later part of the series, I'd guess that your next resend would
contain updated versions of these 17 patches, so the only effect
that it has to pretend that the patches belong to two separate
series is to invite mistakes while queuing on my part.  So either
(1) a single thread of all patches, or (2) just the early part to
really make sure everybody is happy with them, so that we can
graduate it early even while the remainder may be going through
revisions, would be more preferrable than the way they have been
structured so far.

Thanks.
