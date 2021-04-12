Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CCBC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1BD61042
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhDLXMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:12:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbhDLXMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 19:12:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 636A9AD3C1;
        Mon, 12 Apr 2021 19:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aT75p9GFksDhnZaVnTObPV7oboc=; b=auENz5
        oE00uUL3MFmt9GzpzySiPX2CkbaykJLSAg1GRThqMRsbT6xiqmihD14EDzkf2Aq6
        KFNs0TYAFGcvL4tbuBXGwluST+w6axHfFqNxlvLarvZGDo9f6dkfWRdmLCCqlnmD
        e5ds24pclPw4Q3Csi9oNzNbl6K/uzJb4V00tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oSOLjtRzrewYYlIiW9IUNM77afyUSedr
        DrP6QesZGetZpZoz6FYCo+I/9FirfFI17Hc6EpCKOzm+TGb38y+7ogHNyFn1gsKC
        Wjc1UcPOTKzrQH7yu8wCoVV5ol393/ISlrO4Ndll3SzEf22OlV9sDvu/f+HR5iO0
        QgPCDaFfjOQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59748AD3BF;
        Mon, 12 Apr 2021 19:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C03D5AD3BE;
        Mon, 12 Apr 2021 19:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to
 test_commit
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
        <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
        <xmqqk0p7b3d5.fsf@gitster.g>
        <CAPig+cQSS8yp-K8Z5q9eG1t-7sFAyuPEvFDNvX_JaY07BKcMhQ@mail.gmail.com>
Date:   Mon, 12 Apr 2021 16:12:12 -0700
In-Reply-To: <CAPig+cQSS8yp-K8Z5q9eG1t-7sFAyuPEvFDNvX_JaY07BKcMhQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 12 Apr 2021 19:04:22 -0400")
Message-ID: <xmqqpmyzm71v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84387984-9BE4-11EB-B4B2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I don't care for `--raw` either but couldn't think of anything better
> at the time. But perhaps a name such as `--allow-escapes` would be
> clearer, or perhaps not. `--c-style-escapes`?

It's printf(1) style escapes ;-)

> Anyhow, it's pure bikeshedding as I mentioned in my original email, so
> not a big deal. I brought it up only because the very first thought
> that popped into my head when reading the commit message saying it was
> adding `--printf` was "oh, interesting; how do I specify the arguments
> to interpolate into the `printf` format string?".
