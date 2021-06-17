Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C009C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB0B613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhFQAwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:52:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFQAwH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 20:52:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB7BC1375E7;
        Wed, 16 Jun 2021 20:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c61vuHadl81J
        PI9Dmmd3As6GtBVtbkH5tw3oHF9fquk=; b=Wyqgl7JMWkDSDSJqBJaOSBddbnt/
        d1Cq0RnzWoV9yluEhptR834C9ICrUPeG6fIfTDmA3V58G7/iDt74DWyY+yD9yS+3
        jWxn9NTKyDIipsMMOeubWHPg2vq9Tq5b+nGB6MqKQTRJ+VMHWEtdnRxWPrplqwkm
        agMtAW91dxRaTxk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D883E1375E6;
        Wed, 16 Jun 2021 20:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22E0F1375E5;
        Wed, 16 Jun 2021 20:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>
Subject: Re: [PATCH 0/5] serve: add "configure" callback
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
        <YMoljEd/0Nv19dl7@coredump.intra.peff.net>
Date:   Thu, 17 Jun 2021 09:49:56 +0900
In-Reply-To: <YMoljEd/0Nv19dl7@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 16 Jun 2021 12:23:40 -0400")
Message-ID: <xmqq8s39nwln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F07F5956-CF05-11EB-A866-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jun 16, 2021 at 04:16:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> This is a refactoring of what a callback in serve.c needs to do to
>> aquire config. Currently two of them want that, and grab it in ad-hoc
>> ways themselves, now they can insted configure a "configure" callback
>> along with the existing "advertise" and "command", by the time they're
>> called their config will already be read with their callback.
>>=20
>> I split this prep work off from an upcoming series where I wanted to
>> add a new capability, but I think this stands nicely on its own, and
>> simplifies the existing code.
>
> The first four seem like obviously-good cleanups. I'm not so sure
> about the last one, though. I left some comments there.

I had the same impression.  Thanks, both.
