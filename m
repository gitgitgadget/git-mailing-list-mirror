Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF63C433E9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488D964E22
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBRTct (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58967 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhBRTNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:13:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D994BB0BB3;
        Thu, 18 Feb 2021 14:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hdJ7lRgXrnYd
        TiHW7taRpkpy4g8=; b=maYhGfbwGJhvnn3xQe83sUY/2avXBtMTHP/0kPXRxaE8
        zXiaTcCW0v8+VhByXqCy3yXwCJkCCCrMSyMWC7wP5dYU5FASj81DEUk+PzhmptZc
        Rai5sSERD3XZuQuYAJEkg+ZhZq5KKyrl3UfL7i+8FhgGi3vuV0iOzXqLLEu96Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GN+CjT
        5pbXHTmOMWQpdfhC6a4S2doz7Jq/eyo28R611PDMEqR46WIckBmaU5JW2nlj4BCK
        EI+69Fh9fnzLUQehu0baJvqcG5i12uHGauRxNglqvY4NXqwu6MvNfZh7ojTXrvgD
        sIwGDV9rah7ezKcIwZoWnKLIB/WPzzljO8RxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0EBAB0BB2;
        Thu, 18 Feb 2021 14:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 594BAB0BB1;
        Thu, 18 Feb 2021 14:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
References: <87blcja2ha.fsf@evledraar.gmail.com>
        <20210217194246.25342-1-avarab@gmail.com> <xmqqo8gijtl7.fsf@gitster.g>
        <87zh028ctp.fsf@evledraar.gmail.com>
Date:   Thu, 18 Feb 2021 11:12:26 -0800
In-Reply-To: <87zh028ctp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 18 Feb 2021 01:00:18 +0100")
Message-ID: <xmqqtuq9faw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D59796E-721D-11EB-AAD1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Let's get this reviewed now, but with expectation that it will be
>> rebased after the dust settles.
>
> Makes sense. Pending a review of this would you be interested in queuin=
g
> a v2 of this that doesn't conflict with in-flight topics?

Not really.  I am not sure your recent patches are getting
sufficient review bandwidth they deserve.

> Patches 01..09 & 13/14 can live conflict-free with what's in "seen" now
> (I'd have made the 13th the 10th in v1 if I'd noticed). Then I could
> re-roll the remainder of this once the other topics land.
