Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E87C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F8623A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgLRF3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:29:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58681 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgLRF3s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:29:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DD1F9A608;
        Fri, 18 Dec 2020 00:29:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=je0iNSfWlTdkP2RmJjofhUW5ZCw=; b=oPmUU2
        N+NncC0Z7/1u5lhfIHoLfbyfguBUYfXt1KRS8+1Et68TdFmIqO7p8Fzvj/sW+Puk
        s4uo4uDHmzvjD0rX9O6YGSoMyTaFnMe3OLCKUN6116JcARdgzXSMA/gJdDiOsRfQ
        33UMU7ozsFFb1F7jNj5hr+E8QZm2p1do3pBXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d+yxdDTtXlheFxRqyGNkGPlG5APTW798
        0czT2phqIX1r2mNjIMwJj+FLGFwmLwJldNan9/ST3oI670xfMgO8xo2s5J8TBrBe
        SyBDT842S1iv24n6cyWWHJj4tBZGYhsvU6f8slceG2RV0iTTHTjaUhw5m7+uggU+
        4NfLNbiFF8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D7B9A607;
        Fri, 18 Dec 2020 00:29:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE5E69A606;
        Fri, 18 Dec 2020 00:29:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 00/17] propose config-based hooks (part I)
References: <20201014232447.3050579-1-emilyshaffer@google.com>
        <20201205014607.1464119-1-emilyshaffer@google.com>
        <20201216003408.GR36751@google.com>
        <xmqqlfdy6025.fsf@gitster.c.googlers.com>
        <20201216201625.GF3783238@google.com>
        <xmqqwnxh1g4h.fsf@gitster.c.googlers.com>
        <20201218020748.GI3783238@google.com>
Date:   Thu, 17 Dec 2020 21:29:05 -0800
In-Reply-To: <20201218020748.GI3783238@google.com> (Emily Shaffer's message of
        "Thu, 17 Dec 2020 18:07:48 -0800")
Message-ID: <xmqq7dpfy95q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F224A18C-40F1-11EB-BD59-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I don't have a reroll today. I have been trying to get to the bottom of
> a test which fails when built with clang but passes when built with gcc
> (t6030-bisect-porcelain.sh after patch 12 of the part II series) and
> have not made progress on that, let alone on the other tasks I wanted to
> do before sending the next version.

Thanks for an interim report.  No need to rush.

> Hope you enjoy your holidays.

You too, and have fun.
