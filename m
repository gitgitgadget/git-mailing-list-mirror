Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E1EC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9842F61216
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbhI2QEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:04:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55145 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346228AbhI2QDp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 12:03:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BADB166678;
        Wed, 29 Sep 2021 12:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LJ7XdV/11802
        mxDF0CNqzrEctSBQ1P6Qf4CDFEoLMhE=; b=m2PWqU+jHrDK43po/QpSHq730Hdz
        NeduvSI4OzFq4OFCwlQIBgmzfAEzzDjsHSSy+U7roko+XJN19cnl+/nGKMhGmzKc
        2TGKZQjLF+qTOPEeWv0EuOWm6I/dbGqleizBzJlhQnKXQ2wWUQn/qmC4uPhy8Vda
        LsBbcG2jYkb2SFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25009166677;
        Wed, 29 Sep 2021 12:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E666166672;
        Wed, 29 Sep 2021 12:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 02/10] parse-options.[ch]: consistently use "enum
 parse_opt_flags"
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
Date:   Wed, 29 Sep 2021 09:02:00 -0700
In-Reply-To: <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 15:14:23
        +0200")
Message-ID: <xmqqy27fe5fr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95212892-213E-11EC-A601-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the "enum parse_opt_flags" instead of an "int flags" as arguments
> ...

> @@ -861,7 +864,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
>  	case PARSE_OPT_NON_OPTION:
>  	case PARSE_OPT_DONE:
>  		break;
> -	default: /* PARSE_OPT_UNKNOWN */
> +	case PARSE_OPT_UNKNOWN:
>  		if (ctx.argv[0][1] =3D=3D '-') {
>  			error(_("unknown option `%s'"), ctx.argv[0] + 2);
>  		} else if (isascii(*ctx.opt)) {

This part does not belong to this step or 03/10 (parse_opt_result).
It belongs to 04/10 (drop default from switching on enum).
