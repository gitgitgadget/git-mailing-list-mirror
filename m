Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDFFC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7CD6186A
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBRWYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:24:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60026 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBRWYK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:24:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC5BA12C07F;
        Thu, 18 Feb 2021 17:23:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZP/76CY8qofp
        PF9SOsqKJcF+WFg=; b=ammWVIDU64qQVV3VH/yg3DkEswg/KymRnTouJjt2s6GX
        bFCg/sEGRmhffVAyVJYotbp+eNXpKzCTHLkTsV+kWoxDTlrsMNT3ezGuh+r4Wx6R
        vBXjgi6YzNjDHezx43KuP4TIKgkoiRwQj7iSxvMykNR/5/0deT4D2qq9NTXfxkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RFZoEY
        uUwy/WfCfRZ4eQz3AGB/Cg5/32xkby7Ny9ba0Li3Mhk9Otxo6yaCauP/AlJb7L/g
        wU1mpC5b4dQkLOYMORDwhvzg82Xti6F8W2b7VYNkpvbuqvZdNLVupde/G9nhpzgJ
        7iatdGCyptokvdg1WTlqCHPGNhtEPmjI+aZ/c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92E9312C07E;
        Thu, 18 Feb 2021 17:23:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA58512C07D;
        Thu, 18 Feb 2021 17:23:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 05/10] fsck.c: rename remaining fsck_msg_id "id" to
 "msg_id"
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-6-avarab@gmail.com>
Date:   Thu, 18 Feb 2021 14:23:24 -0800
In-Reply-To: <20210218105840.11989-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 11:58:35 +0100")
Message-ID: <xmqq35xtdnhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB2A2574-7237-11EB-8C35-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Rename the remaining variables of type fsck_msg_id from "id" to
> "msg_id". This change is relatively small, and is worth the churn for
> a later change where we have different id's in the "report" function.
> ---
>  fsck.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Up to this point I have no objections to the patches themselves, but
this one is not signed off.

> diff --git a/fsck.c b/fsck.c
> index 1070071ffec..dbb6f7c4ee2 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -264,19 +264,19 @@ void fsck_set_msg_types(struct fsck_options *opti=
ons, const char *values)
>  	free(to_free);
>  }
> =20
> -static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
> +static void append_msg_id(struct strbuf *sb, enum fsck_msg_id msg_id)
>  {
> -	const char *msg_id =3D msg_id_info[id].id_string;
> +	const char *msg_id_str =3D msg_id_info[msg_id].id_string;
>  	for (;;) {
> -		char c =3D *(msg_id)++;
> +		char c =3D *(msg_id_str)++;
> =20
>  		if (!c)
>  			break;
>  		if (c !=3D '_')
>  			strbuf_addch(sb, tolower(c));
>  		else {
> -			assert(*msg_id);
> -			strbuf_addch(sb, *(msg_id)++);
> +			assert(*msg_id_str);
> +			strbuf_addch(sb, *(msg_id_str)++);
>  		}
>  	}
> =20
> @@ -292,11 +292,11 @@ static int object_on_skiplist(struct fsck_options=
 *opts,
>  __attribute__((format (printf, 5, 6)))
>  static int report(struct fsck_options *options,
>  		  const struct object_id *oid, enum object_type object_type,
> -		  enum fsck_msg_id id, const char *fmt, ...)
> +		  enum fsck_msg_id msg_id, const char *fmt, ...)
>  {
>  	va_list ap;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	int msg_type =3D fsck_msg_type(id, options), result;
> +	int msg_type =3D fsck_msg_type(msg_id, options), result;
> =20
>  	if (msg_type =3D=3D FSCK_IGNORE)
>  		return 0;
> @@ -309,7 +309,7 @@ static int report(struct fsck_options *options,
>  	else if (msg_type =3D=3D FSCK_INFO)
>  		msg_type =3D FSCK_WARN;
> =20
> -	append_msg_id(&sb, id);
> +	append_msg_id(&sb, msg_id);
> =20
>  	va_start(ap, fmt);
>  	strbuf_vaddf(&sb, fmt, ap);
