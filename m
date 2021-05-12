Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF4C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A72961927
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELHBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:01:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60650 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELHBi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:01:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20BDA1248A8;
        Wed, 12 May 2021 03:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gdUngrh1xptTvHt4+9PITSYlshkuSPUtmIQwZH
        lz/CU=; b=v5BU5RxP3epxZvX4VeHQekIEOJqm69VAeOt1Nn1IsV2GkHizjhMqcu
        LSmRU25rxjuR00f2gMw+OwLwICn5OG8O8ZzG9vn90WzxQDYoeS1inWu1O+he19pb
        mvjup81NpKtWyXZQbUH9GPiL3YFm/93O3aiFoztBFDBoXCx2EZTKU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18ED11248A7;
        Wed, 12 May 2021 03:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3824B1248A0;
        Wed, 12 May 2021 03:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] INSTALL: note about make man with Asciidoctor backend
References: <20210512064128.15411-1-bagasdotme@gmail.com>
Date:   Wed, 12 May 2021 16:00:26 +0900
In-Reply-To: <20210512064128.15411-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 12 May 2021 13:41:29 +0700")
Message-ID: <xmqqtun8fncl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBCA84F6-B2EF-11EB-AAA5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> "make man" can now be also done with Asciidoctor's manpage backend
> instead of asciidoc+xmlto.
>
> Update INSTALL to reflect that.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
>  This patch is based on  "doc: add an option to have Asciidoctor build
>  man pages directly" series by brian m. carlson [1]. It can be added
>  to that series.

It's not like "can be"; it would not make any sense to queue this
patch before queuing those two patches below it ;-)

Not everybody with Asciidoctor can do the "man" without xmlto; they
must have recent enough vintage of Asciidoctor, or they need xmlto.
The second hunk makes it quite clear, but the updated text in the
first hunk falls a bit short to convey that and needs a bit more
work to clarify, I would think.

> diff --git a/INSTALL b/INSTALL
> index 66389ce059..89e31566c3 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -184,8 +184,9 @@ Issues of note:
>  
>     "make doc" builds documentation in man and html formats; there are
>     also "make man", "make html" and "make info". Note that "make html"
> -   requires asciidoc, but not xmlto. "make man" (and thus make doc)
> -   requires both.
> +   requires asciidoc, but not xmlto. "make man" requires either
> +   Asciidoctor or asciidoc+xmlto. "make doc" requires both asciidoc
> +   and xmlto.

As "make doc" is "make -C Documentaiton all",
   "make html" is "make -C Documentaiton html",
   "make man" is "make -C Documentaiton man",
and 
   "make -C Documentation all" is "make -C Documentation html man"

it seems that those who choose to go xmlto-less route for manpages
should not need xmlto while doing "make doc", so the last part of
the updated text is not quite accurate, no?

> @@ -201,6 +202,11 @@ Issues of note:
>     use Asciidoctor (requires Ruby) by passing USE_ASCIIDOCTOR=YesPlease
>     to make. You need at least Asciidoctor version 1.5.
>  
> +   You can also do "make man" using Asciidoctor's manpage backend in
> +   place of xmlto by passing USE_ASCIIDOCTOR_MANPAGE=YesPlease. Version
> +   2.0 or later is highly recommended, as these version properly handle
> +   apostrophes.
> +

Hmph, I wasn't closely following the previous discussion, but is the
apostrophes the primary reason why anything below 2.0 is not usable?

I actually do not mind, for clarity and brevity's sake, to give
readers a bit of white lie and just say something along the lines of

    If you use Asciidoctor version 2.0 or later, you can choose to
    directly generate manpages with its manpage backend, instaed of
    using xmlto in between, by passing USE_ASCIIDOCTOR_MANPAGE=YesPlease
    to "make man".

to _require_ 2.0 without even hinting that earlier versions might be
usable.

In any case, thanks for a good start.
