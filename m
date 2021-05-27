Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0851C47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 02:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713F4613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 02:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhE0Cl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 22:41:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61299 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhE0Cl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 22:41:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B487BCAEB;
        Wed, 26 May 2021 22:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wNaynbZahKlR
        YNpaMK/IArIANUtasDuN/Qo7i6lSGAw=; b=oRzIPqipWtrSBci10VRkmZ7YK2qx
        dIlh8MtDfyl8DBit8T77FtI5+6k0QsYe2ZxPdPXi3O1ghTfJuydAuUaf8dWqU8vF
        VpMb7qF5PgB9hFSlTeZL1XLNaivZGeFAwhLzlBj9sfy0Uj6A3Aho34sAnz0yBw5I
        Wty4WvK/ls6uG6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53FE0BCAE9;
        Wed, 26 May 2021 22:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4B0DBCAE8;
        Wed, 26 May 2021 22:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: move builtin-only code to its own header
References: <878s41m5nc.fsf@evledraar.gmail.com>
        <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
Date:   Thu, 27 May 2021 11:40:25 +0900
In-Reply-To: <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 27 May
 2021 02:52:51 +0200")
Message-ID: <xmqqeedsaoh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E441A922-BE94-11EB-BFC5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the code that's only used in builtin/pack-objects.c to a new
> builtin/pack-objects.h header and out of pack-objects.h.
> ...
>  builtin/pack-objects.c | 174 +++++++++++++++++++++++++++++++++++++++--
>  pack-objects.h         | 159 -------------------------------------
>  2 files changed, 167 insertions(+), 166 deletions(-)

Neither the title or the description reflects the reality, though.

move builtin-only "static inline" code from the header to its sole
consumer?
