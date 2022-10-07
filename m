Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F1C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJGSKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJGSKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 14:10:02 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9CC13E3A
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 11:09:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1932415BEB8;
        Fri,  7 Oct 2022 14:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TOJkgb3DADY9
        13idajN5AB1bj11h6ylQKtN1bS4rmL4=; b=R+t3bPcdE4C91eKdm9q+HjwQTH+k
        6ePELkAy92qOyTEu46FLgcHHkvySM/nNgTLw8zrKHKJQ/o67jg/ZD0mVEnMQNysW
        16ivQQwpl3mSGIu9lrfR3h6DJXuREd17CAh9+07pN8JxiOlkg8ecu8tEeoQGk+eA
        JI87lwcqrr2OC2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1021715BEB7;
        Fri,  7 Oct 2022 14:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7712015BEB6;
        Fri,  7 Oct 2022 14:08:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] CodingGuidelines: update for C99
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
        <patch-1.5-5ea53989486-20221007T092505Z-avarab@gmail.com>
Date:   Fri, 07 Oct 2022 11:08:38 -0700
In-Reply-To: <patch-1.5-5ea53989486-20221007T092505Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 7 Oct
 2022 11:30:30 +0200")
Message-ID: <xmqqa667fqvt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11F4C714-466B-11ED-ADA8-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since 7bc341e21b5 (git-compat-util: add a test balloon for C99
> support, 2021-12-01) we've had a hard dependency on C99, but the prose
> in CodingGuidelines was written under the assumption that we were
> using C89 with a few C99 features.
>
> As the updated prose notes we'd still like to hold off on novel C99
> features, but let's make it clear that we target that C version, and
> then enumerate new C99 features that are safe to use.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/CodingGuidelines | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
> index 9fca21cc5f9..386ca0a0d22 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -204,10 +204,14 @@ For C programs:
>     by e.g. "echo DEVELOPER=3D1 >>config.mak".
> =20
>   - We try to support a wide range of C compilers to compile Git with,
> -   including old ones.  You should not use features from newer C
> +   including old ones.  As of Git v2.35.0 Git requires C99 (we check
> +   "__STDC_VERSION__"). You should not use features from a newer C
>     standard, even if your compiler groks them.
> =20
> -   There are a few exceptions to this guideline:
> +   New C99 features have been phased in gradually, if something's new
> +   in C99 but not used yet don't assume that it's safe to use, some
> +   compilers we target have only partial support for it. These are
> +   considered safe to use:
> =20
>     . since early 2012 with e1327023ea, we have been using an enum
>       definition whose last element is followed by a comma.  This, like

Looking good.
