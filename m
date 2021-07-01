Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD368C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FCC6140B
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhGAOdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:33:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61133 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAOdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:33:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC48A1384A3;
        Thu,  1 Jul 2021 10:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ggO6p1amkzaR
        u5BNv38IuC6FZzoaSXICVbivhDwpw98=; b=ByGgVzNDpgil59wAK+XqG4DlldF3
        GBE6RG7oG9oWR0tkKvCtfxOASi3vOROWSdZ6UC1UOCEqmQmLEW/tPL6VgeAE+Uf6
        DnkoMmTxfItbwGBirlfafWtX+KJEIKH7stNUkfMDWlLerIibe2Nss7YfCifcv44W
        72x4eeStQl74qWY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3E841384A2;
        Thu,  1 Jul 2021 10:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3C1413849F;
        Thu,  1 Jul 2021 10:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 0/8] test-lib tests: split off subtest code in t0000
 into lib-subtest.sh
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
        <xmqq35tjzwz2.fsf@gitster.g> <87czsb1r85.fsf@evledraar.gmail.com>
        <877dibg7d2.fsf@evledraar.gmail.com>
Date:   Thu, 01 Jul 2021 07:30:26 -0700
In-Reply-To: <877dibg7d2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 30 Jun 2021 09:04:35 +0200")
Message-ID: <xmqqmtr6rtrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E18F595E-DA78-11EB-844A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jun 24 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Jun 15 2021, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> This refactors the testing of test-lib.sh itself in t0000 into a
>>>> lib-subtest.sh, fixing duplicate setup, bugs and various shell nits
>>>> along the way.
> ...
> Junio, just a reminder about this series: It has no conflicts with
> "seen", and that WIP patch it would have conflicted with it was replace=
d
> by another approach.

https://lore.kernel.org/git/cover-0.8-00000000000-20210614T104351Z-avarab=
@gmail.com/
reveals that this hasn't seen much reviews, though.  I'll try to
find time to read it through; no promises if it will be done by the
end of the week, though.

Thanks.

