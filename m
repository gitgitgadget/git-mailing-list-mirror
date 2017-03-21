Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C3F2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758199AbdCUSjD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:39:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55212 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758194AbdCUSjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:39:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D93665482;
        Tue, 21 Mar 2017 14:32:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1pM4+ZVxUC31
        kC79HMso0wbv6vY=; b=cyrupQOFtxMpR4dm7Dgs8kq5sCJZDw1mrdv/UH1ZRtdr
        CqQpFZuYaZUqn78KauSZTwGcUL1OGC9Gha8fuLSEQiyZ9i72WHi8SlqHlX2rPG69
        ovFHlU9r1dHesFxCpyRqkmQe6thjZYI0RO8u/nUZW1qo3mdLnAaq4Kdf4Nd87i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MgBtIm
        djvhI0ZPyoQG4e+Fiud7a1zDZpjc14JpcHgg6kHYwDjYOWoCOA7MIsyVuX1hRYrK
        UplGX1gf75DhEpVrVUIl/0wvVJLCB8FAyGxPF+WIZyfrhRcH/NFaMd/yIuBU1taY
        IH73deng9mCrTOZUmXKJ2vHJKajTIXQVMvgWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34D0465481;
        Tue, 21 Mar 2017 14:32:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8541E6547F;
        Tue, 21 Mar 2017 14:32:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/16] for-each-ref: partly change <object> to <commit> in help
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-9-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:32:22 -0700
In-Reply-To: <20170321125901.10652-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:53 +0000")
Message-ID: <xmqqwpbipjk9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9E31B64-0E64-11E7-8BC4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change mentions of <object> to <commit> in the help output of
> for-each-ref as appropriate.
>
> Both --[no-]merged and --contains only take commits, but --points-at
> can take any object, such as a tag pointing to a tree or blob.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

This definitely is a correction worth doing. =20

Do these strictly require commit, or does any commit-ish also do?

>  builtin/for-each-ref.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index df41fa0350..1a5ed20f59 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -8,8 +8,8 @@
>  static char const * const for_each_ref_usage[] =3D {
>  	N_("git for-each-ref [<options>] [<pattern>]"),
>  	N_("git for-each-ref [--points-at <object>]"),
> -	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
> -	N_("git for-each-ref [--contains [<object>]]"),
> +	N_("git for-each-ref [(--merged | --no-merged) [<commit>]]"),
> +	N_("git for-each-ref [--contains [<commit>]]"),
>  	NULL
>  };
