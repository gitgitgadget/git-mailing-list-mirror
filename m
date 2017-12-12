Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE06C1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 22:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdLLWTX (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 17:19:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54299 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752320AbdLLWTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 17:19:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 976F8C2F61;
        Tue, 12 Dec 2017 17:19:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nh7R3ES6YCZO
        3s+7LY9onrcUcIQ=; b=K6MMUdwS4INXTsmiyqB64HOcECIJpR2B5TW5K51bhxus
        VHXPraqNeLI8pMi6m/ZrB6ieK+rKd7aEIjoQEZZNqC4mjx1YlQV0TKcuMUSe37F+
        8rnuVZ0J+b4Bku4L5VVkkj7XQRapHlxoTkOgA/rcVxVMSfbD5qGH6Uma8R+xUOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PWn2t8
        2wCr8pvPeurqAJUo8Cwuaofbafw0dl5ZvjUPe9gDzDkJs8iUCPGrvTxXeWxeNxtt
        ufvj3w0Kvw1dnVIFEqTPjAgzw31/rGFkPtKp5GcjZV+62112dBTC9VREWJvEAt6b
        v4oD9nxdPHqZxa/aqY/lnY6JoS+eGaOLP5AYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F245C2F60;
        Tue, 12 Dec 2017 17:19:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0279CC2F5F;
        Tue, 12 Dec 2017 17:19:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Thomas Adam <thomas@xteddy.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org>
        <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
        <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop>
        <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com>
        <87mv2p89wu.fsf@linaro.org> <20171211172615.jfsjthkvs4itjpcn@laptop>
        <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com>
        <20171212103040.jbgkyet5rapqxi44@laptop> <87indb99xy.fsf@linaro.org>
        <87fu8fddam.fsf@evledraar.gmail.com>
        <xmqqwp1r20zx.fsf@gitster.mtv.corp.google.com>
        <87d13jd4fd.fsf@evledraar.gmail.com>
Date:   Tue, 12 Dec 2017 14:19:19 -0800
In-Reply-To: <87d13jd4fd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 12 Dec 2017 22:25:42 +0100")
Message-ID: <xmqqa7ynzj14.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8068FE56-DF8A-11E7-9161-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Ripping out Error.pm for our few internal callers is one thing, trying
> to maintain bugwards compatibility with how it throws exceptions for
> users expecting Error.pm objects is another. I think at that point it's
> easier to just stay with Error.pm.
>
> Probably easier to stay with it either way, don't poke sleeping dragons
> and all that, it's working code, even if we wouldn't write it like that
> today the churn probably isn't worth it.

OK, I'm inclined to defer to your judgment.

THanks.
