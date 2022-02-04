Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E521C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 20:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiBDUwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:52:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57235 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiBDUwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 15:52:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C92B7FB40A;
        Fri,  4 Feb 2022 15:52:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Be9fqK3q6tJG
        rvR2OtCAuhr2iFL9XJV7asciiv1Zd/M=; b=LqeJfs87siPNQNZiXkth/pVecT58
        EnKzSIF0+7ykHyL5w5yNIf1QnY9MlsC0THETrSviDyG46DVlvDWNGNHvHMwsgyIm
        PpsfeYJnlYIjmtxpxCeEXi5uC6+akrcaIc2w6vo3ixlH4/Jnozk1CNRqH13yTTRb
        JI8KmIRnN0Kvk5k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C187BFB409;
        Fri,  4 Feb 2022 15:52:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30B19FB408;
        Fri,  4 Feb 2022 15:52:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 04/11] object-file API: have write_object_file() take
 "enum object_type"
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
        <patch-v2-04.11-d259f901114-20220204T135005Z-avarab@gmail.com>
Date:   Fri, 04 Feb 2022 12:52:08 -0800
In-Reply-To: <patch-v2-04.11-d259f901114-20220204T135005Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 4 Feb
 2022 14:51:18
        +0100")
Message-ID: <xmqqtudel5hj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52643E40-85FC-11EC-9662-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 05d60483e82..d81acaeaf78 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -199,9 +199,8 @@ static void prepare_note_data(const struct object_i=
d *object, struct note_data *
> =20
>  static void write_note_data(struct note_data *d, struct object_id *oid=
)
>  {
> -	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
> +	if (write_object_file(d->buf.buf, d->buf.len, OBJ_BLOB, oid)) {
>  		int status =3D die_message(_("unable to write note object"));
> -
>  		if (d->edit_path)

Unrelated change here.  It would be OK if it were an improvement,
but it is not X-<.

Everything else in this change looked sensible.
