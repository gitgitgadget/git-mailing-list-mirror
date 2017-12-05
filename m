Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC6520A40
	for <e@80x24.org>; Tue,  5 Dec 2017 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdLENIs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 08:08:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53350 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752042AbdLENIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 08:08:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A348BB84B;
        Tue,  5 Dec 2017 08:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6YK2zV7bzwj4
        3LYuCpsl6WEg1iI=; b=ejEvaKvqIdjm/av2JJuN+mLmeJ39EXhMS1CcsyVCi6xS
        RMXFHLg2XtuRfRmzZHnIJ4EA8w86CDMb0Q/QMmjdQIwpVdJHQgG4mbxcAZD8uWbd
        DMNrhtCDoImW14tSOL+v1WhmYTUD7YK0b4BqrQ0RohTVILZb5AQ4yau3oUqPzFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Wfqpe8
        pL184zbvebPmSciaseEv5Wm2rBb8KMvdILFRZ255pBqAeiClJs0vdOn1q2f6DlN2
        vuPe4K+yB/kKmuZGZyegF+oKQG4B/10/Cu28xWTbC8/fbotfuBsTbtMsopxWWszY
        X5XGqKtGwBk7pcIQwL0/kIYwzrZBEjP541tWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21E79BB84A;
        Tue,  5 Dec 2017 08:08:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8046CBB849;
        Tue,  5 Dec 2017 08:08:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule by default
References: <20171128213214.12477-1-avarab@gmail.com>
        <20171128213214.12477-4-avarab@gmail.com>
        <20171205070249.GC4788@sigill.intra.peff.net>
        <87bmjdscdr.fsf@evledraar.booking.com>
Date:   Tue, 05 Dec 2017 05:08:45 -0800
In-Reply-To: <87bmjdscdr.fsf@evledraar.booking.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 05 Dec 2017 11:22:08 +0100")
Message-ID: <xmqqh8t5jp9e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D6E8488-D9BD-11E7-948E-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I'm not sure how I feel about this. I see your point that there's no
>> real value in maintaining two systems indefinitely.  At the same time,=
 I
>> wonder how much value the submodule strategy is actually bringing us.
>>
>> IOW, are we agreed that the path forward is to get everybody using the
>> submodule?
> ...
> In no particular order:
>
>  * I don't feel strongly about 2-4/4 in this series. I just hacked this
>    up because it occurred to me that I'd left this sha1dc stuff in some
>    in-between state and we'd talked about eventually moving forward wit=
h
>    this.

Good.

>    We've had two releases with the submodule being purely optional, if
>    we're going to keep it it seems logical to start at least using it b=
y
>    default.

With a need for a patch like 1/4, I suspect two release cycles is
way too short for making a move like 2-4/4, though.
