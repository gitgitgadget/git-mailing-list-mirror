Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130521F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdLLTfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:35:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751499AbdLLTfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:35:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7016EC032F;
        Tue, 12 Dec 2017 14:35:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Bsfddpsqh8ur
        hVvAM3EwSmfvOc4=; b=oN9ZxD/DVPjxWHah3Wm+NtRs3opiH+jyEN86H24BulSw
        u120tWFzUleH1HBZCN3H94MoVR4A1Tg4bFn6Ofs5cNyNBA+XoCG0yJzDmEgvcKIR
        uKpJZex7tZm7CEWyH0PWYA7KQpfYk+KNpKvib48QfudL/5KtWBDBqdCEfNIp1cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=g+Ip3A
        btz9Ol6PyF9tnpdYulXxKTWgDNvFsRIsTY2n4a45j5+17hqWI4NInwbsyLR3uPFB
        zi+asRYM/T7xXwJCL2J02rE3ls7ReRuu9fefEaq5jdfnXZuKlsbdcRRuGlEHC6HB
        rc+GZF2O/mHF5M0Lm3AGfWp7hsb4JnSO/qTu4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6775DC032E;
        Tue, 12 Dec 2017 14:35:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C72D0C032B;
        Tue, 12 Dec 2017 14:35:15 -0500 (EST)
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
Date:   Tue, 12 Dec 2017 11:35:14 -0800
In-Reply-To: <87fu8fddam.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 12 Dec 2017 19:14:09 +0100")
Message-ID: <xmqqwp1r20zx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94377FB4-DF73-11E7-97DB-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> My "Makefile: replace perl/Makefile.PL with simple make rules" currentl=
y
> cooking in pu changes that so that:
>
>  * We always at runtime test for the system CPAN module.
>
>  * In the case of Error.pm we happen to ship a fallback, in the case of
>    Mail::Address etc. we don't and have fallback code, but we could als=
o
>    just ship a copy and remove the fallback code.
>
> This makes more sense, we always "dynamically link" as it were, we'll
> just change the target to (a presumably newer) system module in the cas=
e
> of Error.pm if it's found on the system, otherwise use our fallback.

"When to fallback" aside, I think the above makes sense for the
send-email simply because we would be replacing "our own" fallback
we may need to maintain forever with something with an upstream that
we do not have to worry too much about.

A tangent; I thought I heard that use of Error.pm is strongly
discouraged several years ago---am I mistaken, or if I am not,
perhaps we should start looking into updating the users?

Thanks.
