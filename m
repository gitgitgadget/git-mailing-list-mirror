Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB472C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEE1207FF
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sMOTLbh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgLAVAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:00:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51816 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgLAVAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 16:00:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1C9910E4DA;
        Tue,  1 Dec 2020 15:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fl4yJ0HQQR1v
        HXLh16fFX2DGG/M=; b=sMOTLbh/uj50EIfvRjpoJkwKNNntoLI+NXRkzSB1qi1P
        QanH4PQhy8fCTTSU4njwznIXhI2f1Xr1AtS13goeCIb/6XZDWT1iAyKKpbnLc9MG
        +slPGSLz5j9bsVqrSmv4TIjsddVtNCfuAI+SNuShQNhjrzXY8ocvipVxen5oRkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ekv4d9
        rzL9z/qNcUtkivZZaQPIptCsGpxr/nVs2SrDRCu0s79wKo8deMKLxEto5lpWNLdf
        hT7ZTLcbWNlInszr2YLc3Qwf89j/RG+dYteIMw5QSeOdn1MqVF96oR1PUVAWBNZ0
        zBUjMI28tV60CoP5DVWjrGlHbrpUwng5bf4+s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA6B310E4D1;
        Tue,  1 Dec 2020 15:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED04910E4D0;
        Tue,  1 Dec 2020 15:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] mktag doc: update to explain why to use this
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-11-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 12:59:32 -0800
In-Reply-To: <20201126222257.5629-11-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Nov 2020 23:22:57 +0100")
Message-ID: <xmqq8sahnsy3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D4502EE-3418-11EB-BC60-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +Reads a tag contents on standard input and creates a tag object. The
> +output is the new tag's <object> identifier.
> +
> +This command accepts a subset of what linkgit:git-hash-object[1] would
> +accept with `-t tag --stdin`. I.e. both of these work:
> +
> +    git mktag <my-tag
> +    git hash-object -t tag --stdin <my-tag

It's misleading to say "both of these work", I am afraid.  If the
former works, the latter would.  That is what "accepts a subset"
means, no?

> +The difference between the two is that mktag does the equivalent of a
> +linkgit:git-fsck(1) check on its input, and furthermore disallows some
> +thing linkgit:git-hash-object[1] would pass, e.g. extra headers in the
> +object before the message.

Good description.

> @@ -34,6 +44,17 @@ exists, is separated by a blank line from the header=
.  The
>  message part may contain a signature that Git itself doesn't
>  care about, but that can be verified with gpg.
> =20
> +HISTORY
> +-------
> +
> +In versions of Git before v2.30.0 the "mktag" command's validation

Hardcoding v2.30.0 here feels problematic.  If the series cooks in
'next' while 2.30 gets released, it has to be kicked out of 'next'
to update this line before it gets allowed in 'next'.

> +logic was subtly different than that of linkgit:git-fsck[1]. It is now
> +a strict superset of linkgit:git-fsck[1]'s validation logic.

It may be a better direction to go to drop this section.

Also, I somehow have a feeling that we'd rather want to loosen the
"no other headers allowed" in the longer run to be consistent with
what "fsck" does.

I also wonder if we want to teach "commit-tree" to also run fsck
check like this new version of mktag does.  It is outside the scope
of this "mktag" series, of course.

Thanks.

> +SEE ALSO
> +--------
> +linkgit:git-hash-object[1],
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
