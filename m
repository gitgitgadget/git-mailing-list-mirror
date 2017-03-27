Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DD01FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 18:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdC0Sky (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 14:40:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbdC0Skw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 14:40:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5151F8099F;
        Mon, 27 Mar 2017 14:40:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1oJ/GSyRWr3Z
        5fEZ/DYoFDFSLYU=; b=ag6XA40sHYkibkzeayv7O8Ru7UlFCMQFcD6ZevsM7Svs
        gR2aXEn2MKYFMXmDDeSA2NqW2h/+sfD/EomBCsdOpz78K5K9XuzmS+H6qzK71Mje
        C7pdtuuq1uaAzbm84pfEwEjgkLNPM6t84jukLLS9mlwKNhZn0ao+cYC2ERdFUiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VAA5KD
        3tZwcT0uchljBPjCiHjiOKvnjtaL3YMvigNEdyssVIphfvOv+IJFSKQcCzBEbgn6
        akh2kNa778Hl8qn2A7cHyKOLmyEJoV+/ZbURT+JgkmcAFsdLO454T2CQ06dyhL+K
        xzSCY6mcsEuh6YaZe0ESO5Tkq/nmtlC8I59iY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49B078099E;
        Mon, 27 Mar 2017 14:40:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC2088099D;
        Mon, 27 Mar 2017 14:40:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in strbuf_getcwd() on FreeBSD
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
        <xmqq1stj4kmp.fsf@gitster.mtv.corp.google.com>
        <kczrpegpzxhedtxmjptr@skdf>
Date:   Mon, 27 Mar 2017 11:40:15 -0700
In-Reply-To: <kczrpegpzxhedtxmjptr@skdf> (Zenobiusz Kunegunda's message of
        "Mon, 27 Mar 2017 07:55:19 +0200")
Message-ID: <xmqqo9wm1s34.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D26369D4-131C-11E7-A94F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl> writes:

> Od: "Junio C Hamano" <gitster@pobox.com>
> Do: "Ren=C3=A9 Scharfe" <l.s.r@web.de>;
> Wys=C5=82ane: 2:40 Poniedzia=C5=82ek 2017-03-27
> Temat: Re: [PATCH] strbuf: support long paths w/o read rights in strbuf=
_getcwd() on FreeBSD
>
>>=20
>> Nicely analysed and fixed (or is the right word "worked around"?)
>>=20
>> Thanks, will queue.
>
> Is this patch going to be included in next git version ( or sooner ) by=
 any chance?

Absolutely.  Thanks for your initial report and sticking with us
during the session to identify the root cause that led to this
solution.

Again, Ren=C3=A9, thanks for your superb analysis and solution.
