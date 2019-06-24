Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103471F461
	for <e@80x24.org>; Mon, 24 Jun 2019 16:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfFXQrY (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 12:47:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59214 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfFXQrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 12:47:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 250057BA79;
        Mon, 24 Jun 2019 12:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g4QjdfFzoO7F
        0e7EH/vxHqSuL2I=; b=Iu+1O7/EJB2ptgPKZ1W+HYIM/6uVLDbzeZE/KIke3K4r
        ErrD/LDGImQOA1IwML4c6fe0OvZ5qy+DLUVbognLeqOILWvG3FKM4BivWHNjKeFb
        FY3eOfWTayD9oSqhB6YnRQi/hQ3ZJPr215KeQ/6xh1XEeQj6ebqfXGGiTz7cOWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ruhoTR
        qXS4UjwI9QoR72hrydrDQvYbr4oaUvHzUHuqEKIn9QbzCJoqYoU9Gw6NWwBEK7tS
        BaSHNinbQol/iHu2tz7Sp793jSyw2vVFrz4Ou4AWse71mnU8tm12oXYbIvajFxLX
        FgDwwZI/nf4lE/ujSmo7dy/CX4OdO/9c9jmEQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D8CD7BA78;
        Mon, 24 Jun 2019 12:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48D447BA76;
        Mon, 24 Jun 2019 12:47:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/8] tests: make GIT_TEST_GETTEXT_POISON a boolean
References: <20190620210915.11297-1-avarab@gmail.com>
        <20190621101812.27300-6-avarab@gmail.com>
Date:   Mon, 24 Jun 2019 09:47:15 -0700
In-Reply-To: <20190621101812.27300-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 21 Jun 2019 12:18:09 +0200")
Message-ID: <xmqqr27jhqwc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9D3A7F4-969F-11E9-9A65-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/config.c b/config.c
> index 374cb33005..b985d60fa4 100644
> --- a/config.c
> +++ b/config.c
> @@ -956,6 +956,15 @@ static void die_bad_number(const char *name, const=
 char *value)
>  	if (!value)
>  		value =3D "";
> =20
> +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> +		/*
> +		 * We explicitly *don't* use _() here since it would
> +		 * cause an infinite loop with _() needing to call
> +		 * use_gettext_poison(). This is why marked up
> +		 * translations with N_() above.
> +		 */
> +		die(bad_numeric, value, name, error_type);

;-)  Nicely explained.

> diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
> index e1d917fd27..8eef60b43f 100644
> --- a/git-sh-i18n.sh
> +++ b/git-sh-i18n.sh
> @@ -17,7 +17,9 @@ export TEXTDOMAINDIR
> =20
>  # First decide what scheme to use...
>  GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
> -if test -n "$GIT_TEST_GETTEXT_POISON"
> +if test -n "$GIT_TEST_GETTEXT_POISON" &&
> +	    git env--helper --type=3Dbool --default=3D0 --exit-code \
> +		GIT_TEST_GETTEXT_POISON

The helper is called only when GIT_TEST_GETTEXT_POISON has a
non-empty string as its value, so it's default is meaningless, no?
