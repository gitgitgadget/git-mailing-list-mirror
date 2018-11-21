Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3870E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 00:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeKUK7T (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 05:59:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52359 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeKUK7S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 05:59:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B819630BBE;
        Tue, 20 Nov 2018 19:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bBeP6cmTJoVl
        r4K2A80FUIaFtg8=; b=O3y5Oo9Nr7Eo2J635JgQ0XP3D1GhYcAnbxPFuCzXxWPT
        BRg8dNgkZJZUmQag7WB7JeX4PvnVEfkR+G9dwcFZvs2pnCuzf05op/GV5kwrQE9l
        EombNl6zBkQ9l+Mi3pNNNXrRoFiRWtqidLAvCJ+lU/TljjaiJgLx4yr2+DvMRGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OpL5xN
        DICzaC+UEujAz4hPfJjPuRZlNonQh0E8JOxvJMrI0BWS13PxJezoK56zH4zjfIiT
        0QMt5IKPLVlpu0aahmkHGXn0uqm5LyBbLrPhHcELrrsoFX3ak0Lhm27t0iNMguSk
        d8WrZf/agsFRrsnYWzO2nry8gzVbdYdhAJBEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFD3330BBD;
        Tue, 20 Nov 2018 19:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C30D230B9A;
        Tue, 20 Nov 2018 19:27:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
        <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
        <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
        <20181112131247.GL3956@sigill.intra.peff.net>
        <xmqqwophyc9s.fsf@gitster-ct.c.googlers.com>
        <CAL21BmmK_ZS=wuGXRLj=s0=dqMvUWFiLLBZWx5ymnFjyasX=sA@mail.gmail.com>
Date:   Wed, 21 Nov 2018 09:27:17 +0900
In-Reply-To: <CAL21BmmK_ZS=wuGXRLj=s0=dqMvUWFiLLBZWx5ymnFjyasX=sA@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Tue, 20 Nov
 2018 12:17:59
        +0300")
Message-ID: <xmqqa7m39swq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34F91098-ED24-11E8-9EBF-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F  <oly=
atelezhnaya@gmail.com> writes:

>> I am OK if we avoid PRIdMAX and use PRIuMAX instead with a cast to
>> the corresponding size in this codepath, as long as we properly
>> handle negative oi.disk_size field, which may be telling some
>> "unusual" condition to us.
>
> Maybe we want to change the type (from off_t to unsigned) directly in
> struct object_info? That will help us not to make additional
> checkings. Or, at least, I suggest to add check to
> oid_object_info_extended() so that this function will give a guarantee
> that the size is non-negative.

I am fine with the approach.  The potential gain of allowing
oi.disk_size is it would allow the code to say "I'll give these
pieces of info about the object, but the on-disk size is unknown"
without failing the whole object_info_extended() request.  And I
personally do not think such an ability is not all that important
or useful.

