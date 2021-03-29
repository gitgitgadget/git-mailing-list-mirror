Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10126C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C616191B
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC2X7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:59:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64212 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2X6o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:58:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56981C70E7;
        Mon, 29 Mar 2021 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=914tHo9qsBGj
        HSAtWDXQYmyoMAM=; b=kD+UgTOk08kQlNw2rojtWwjSbOpW0ey302yhqX4pBK/5
        PkrOw+x20Fnj9nf0dGcDSzf+Livm9svb+I8irJN0gKvnhB6Ur79Xb4YDIaTFQvqx
        UMwwXwqga9jhyE8h8ZQsiNVPCxPFGdW2qpFo2+q7weSdUHEwx1HBg7u1SnmTI0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K8VDDW
        Xv4nWPDEQL1BgIDeWKLvCNU2J/C93tbKfzotr2QfwD/pPaLcKeff8H/9PFyN9tyK
        99ICG3ZNbtuArm227uwEh1ERQUDewg3wafAp1dTpoLh9SgLZEM40RlUs1VrJ67jh
        R1jzBUwfVxGdTSKUEHT6S7t2uh2YvbLHfFNrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E02FC70E6;
        Mon, 29 Mar 2021 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6BD3C70E5;
        Mon, 29 Mar 2021 19:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
        <xmqqblb1kd47.fsf@gitster.g> <87a6qlmt9f.fsf@evledraar.gmail.com>
Date:   Mon, 29 Mar 2021 16:58:42 -0700
In-Reply-To: <87a6qlmt9f.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 30 Mar 2021 01:31:40 +0200")
Message-ID: <xmqqpmzhfr65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0D30BBC-90EA-11EB-9457-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Even if it's not available in all versions that's OK. You just won't ge=
t
> the nicer removal behavior on on error on such a jurassic gmake, but
> you'll probably have way bigger issues with your late-90s-era software.
>
> It's not a syntax error on a gmake or other make that doesn't know abou=
t
> it either, i.e. you can also add a target like:
>
>     .THIS_DOES_NOT_EXIST_AS_A_GMAKE_FEATURE:
>
> And gmake willl happily ignore it.

What I meant was that I would not tolerate "cc -o x+ && mv x+ x",
but I do not mind DELETE_ON_ERROR with "cc -o x" at all.
