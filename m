Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6469C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926142371F
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgLPXdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:33:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63231 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPXdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:33:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A51C0FEC7D;
        Wed, 16 Dec 2020 18:32:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/CG9Q1d0woFyVSoWOx2O8fOtg5c=; b=C+M02U
        XXYsbbeNvDTCb9cVuNOz5dinJiGKysfufxP1GRAm6xPWM996WSRsZGKTWloEsoFt
        jwE4hKwPF0+Qu8KpUYXyKT1m08mMsWvXiYmN0D7x+GYjtX1sX5Hz6IIRFu+hzLEe
        jFJ51IuIfg81m0HBI0lijRHTgY+7frGoFZn6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ng3tRglz/341IpQVKvFbqFWncFt5P746
        2N4uF4CrZXNCp9UzsVSk+98qz6y77O6tWIie5pA9+H4G2h6iGqMATVnr1VGyClzI
        In1HsQ3jItCVlCkudFeAIgsdmWVPu+/+FVuaaygazv1w3BDxY8XvldlBgAKopnTf
        //tCh11wM7M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D048FEC7C;
        Wed, 16 Dec 2020 18:32:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF601FEC79;
        Wed, 16 Dec 2020 18:32:47 -0500 (EST)
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
Date:   Wed, 16 Dec 2020 15:32:46 -0800
In-Reply-To: <20201216201625.GF3783238@google.com> (Emily Shaffer's message of
        "Wed, 16 Dec 2020 12:16:25 -0800")
Message-ID: <xmqqwnxh1g4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 017BE5F6-3FF7-11EB-8D9C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> By the way, es/config-hooks does not seem to pass 5411 (at least)
>> even as a standalone topic, and has been kicked out of 'seen' for
>> some time.  Has anybody took a look into the issue?
>
> Yeah, I looked at it today. Looks like an issue with not paying
> attention to master->main default config, since I added a new test to
> the 5411 suite (which means it wouldn't have made a conflict for someone
> to say "ah yes, s/master/main/g"). I am tracking down couple of other CI
> errors today and will send a reroll today or tomorrow.

Thanks.
