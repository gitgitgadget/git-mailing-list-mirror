Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4267C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A33D64F40
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCQSfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:35:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhCQSfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:35:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 828701193DB;
        Wed, 17 Mar 2021 14:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=RE5f66wz5vp4NQGUXxdoXrNKA
        Tc=; b=DEMGT4FGr5u0yQ41xhEmMWY4NlxGGogeDGlJCp25Dzm1YkCW0HBRs/7Kz
        fsXdDJritGxiGFL/R/9cUNhxpvno4ytuHMU4PDqtlTFBnkJdlT1FFBVlrrhOjejb
        WwF5gSif7CGWxJZuJSvDOmZhkZih/OQxwDa7b8/XuzNbrvFIxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=l9TXQTLa5FxgDyleD0v
        PMMOm2Mp46iaaivhySWpivNrfReKpspfi742iYHPXWtZj6HUSoAtJDu2CBASNCt5
        HWGnxcClHJyFXQ/XhrdL8dBd3n0A3wsBlKQWCyJPgHc8ejCdHhlBNS+7EES17fc+
        /SZUp+dSE+lmIAZqOR3O7BS0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B9D31193DA;
        Wed, 17 Mar 2021 14:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C61A11193D9;
        Wed, 17 Mar 2021 14:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 01/22] fsck.h: update FSCK_OPTIONS_* for object_name
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-2-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 11:35:19 -0700
Message-ID: <xmqq7dm5wrvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 875F2EE0-874F-11EB-9255-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add the object_name member to the initialization macro. This was
> omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
> go, 2016-07-17) when the field was added.

While this does not hurt, as the missing one was and is at the end
of the struct members, this has no effect.  As you'll be rewriting
everything into designated initializers anyway, does it matter, I
have to wonder (it would affect your commit count karma, but you
already have enough of them ;-)?

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.h b/fsck.h
> index 733378f126..2274843ba0 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -43,8 +43,8 @@ struct fsck_options {
>  	kh_oid_map_t *object_names;
>  };
> =20
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OID=
SET_INIT }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDS=
ET_INIT }
> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OID=
SET_INIT, NULL }
> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDS=
ET_INIT, NULL }
> =20
>  /* descend in all linked child objects
>   * the return value is:
