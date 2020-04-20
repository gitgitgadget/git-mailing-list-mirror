Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06758C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D142D2084D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yVYtbSTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDTTjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:39:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56619 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgDTTjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 15:39:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86AB45910D;
        Mon, 20 Apr 2020 15:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YkTO59g4Q++q
        Z6MplHiYFKIQ/s0=; b=yVYtbSTpXgK5KIWpCw/IOyARF5lfHTSjApr7vAoazm6L
        ua6oHfBIe57luvlKc/EpnTdGvdegkaHlu6quIZ2XoiysMnNNDdBJHFCK6Cjt5Fs3
        cRdushy+srje6ea0mAQAlhPhOWFUpoSeSfNjQ3NnOIMLG9hMq5SbbWDSxqSHiIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JcqQL9
        IntiD1IvDr7LCchjYBd8i9cwJYbRg8DONmEDVgGipee7YpVA1ASp2YorthZd1OTv
        /rHt/nOVZU6UxqrF2+Ehl7mJ9oHcA0V0Cw/9XhDp2F/L+8Cf2XVoIOTrsAXpXh/S
        m5P/5aNjyCjb+Sm9XrqUW8NKYx1V8ltTBivQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 777105910C;
        Mon, 20 Apr 2020 15:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 008DD5910B;
        Mon, 20 Apr 2020 15:39:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/4] strbuf: introduce `strbuf_attachstr()`
References: <cover.1587240635.git.martin.agren@gmail.com>
        <cover.1587297254.git.martin.agren@gmail.com>
        <c3012f1da361af354a904f821b83d61f2534ccb2.1587297254.git.martin.agren@gmail.com>
Date:   Mon, 20 Apr 2020 12:39:16 -0700
In-Reply-To: <c3012f1da361af354a904f821b83d61f2534ccb2.1587297254.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 19 Apr 2020 14:32:29
 +0200")
Message-ID: <xmqqzhb6q74r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F3045A6-833E-11EA-81F8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> +/**
> + * Attach a string to a buffer similar to `strbuf_attachstr_len()`.
> + * Useful if you do not know the length of the string.
> + */
> +static inline void strbuf_attachstr(struct strbuf *sb, char *str)
> +{
> +	size_t len =3D strlen(str);
> +
> +	strbuf_attach(sb, str, len, len + 1);
> +}

This is somewhat worrysome in that the interface is _so_ simple that
people may fail to see that str must be allocated piece of memory,
and it is preferrable if string fully fills the allocation.

We should repeat that (instead of just trusting "similar to ..."
would tell them enough) in the doc, perhaps?

> diff --git a/trailer.c b/trailer.c
> index 0c414f2fed..56c4027943 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1095,7 +1095,7 @@ void trailer_info_get(struct trailer_info *info, =
const char *str,
>  	for (ptr =3D trailer_lines; *ptr; ptr++) {
>  		if (last && isspace((*ptr)->buf[0])) {
>  			struct strbuf sb =3D STRBUF_INIT;
> -			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
> +			strbuf_attachstr(&sb, *last);
>  			strbuf_addbuf(&sb, *ptr);
>  			*last =3D strbuf_detach(&sb, NULL);
>  			continue;

This is not wrong per-se, but it is unclear if use of strbuf_attach*
family to avoid an explicit malloc/copy/free is buying much at this
callsite.  Simplifying the code here of course is not within the
scope of this series.

