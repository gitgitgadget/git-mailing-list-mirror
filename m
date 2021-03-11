Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C0C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8021764FBB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCKBDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:03:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhCKBCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 20:02:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5994A124F86;
        Wed, 10 Mar 2021 20:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mzPsgZF/jy+K
        I4YCCzHV6qW/KwM=; b=WplDWZ5ebmHAPybSb77DfR4L5dQS/Z4t9BTbNoLK+0eB
        0cnHEgu2qK5a4NohRuOdBlaT8RSFheo9FXhwoUbunrvs9W+39O/H6zIt9Of4fUAZ
        85hRtPBR/k1G4hlQ8QdupXQV/b0pbtPiCknsePnY4vkyunNv1AUBIufWUNX/TtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M9tJoP
        rBeEqhQ2BzSIhFP2HHdN+yUCkQ0NC6Dfwm96uF3je8e+JqF2vJMBXRNV8dd5fgg8
        hwBwHyT6dX+FtgNl/14iLVBt4u7CBTn8V7PnMfxoDpyrBW2zqgTJEh0hxs4q+mLO
        wTZ8wmviCfxOKo74D9Xpa/vtbgqUS3Ozx/190=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 523CF124F84;
        Wed, 10 Mar 2021 20:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44DD0124F83;
        Wed, 10 Mar 2021 20:02:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] test-lib: remove unused $_x40 and $_z40 variables
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
        <20210311001447.28254-3-avarab@gmail.com>
Date:   Wed, 10 Mar 2021 17:02:35 -0800
In-Reply-To: <20210311001447.28254-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 Mar 2021 01:14:45 +0100")
Message-ID: <xmqqh7lih590.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 787F3A54-8205-11EB-8799-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> These two have fallen out of use with the SHA-256 migration.
>
> The last use of $_x40 was removed in fc7e73d7ef (t4013: improve
> diff-post-processor logic, 2020-08-21) and
>
> The last use of $_z40 was removed in 7a868c51c2 (t5562: use $ZERO_OID,
> 2019-12-21), but it was then needlessly refactored to be hash-agnostic
> in 192b517589 (t: use hash-specific lookup tables to define test
> constants, 2020-02-22). We can just remove it.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Nice.  Curious why we still want x5 and x35, but we'll learn soon
enough in this short series ;-)


> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d3f6af6a65..5f2ad2fd81 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -511,7 +511,7 @@ SQ=3D\'
>  # when case-folding filenames
>  u200c=3D$(printf '\342\200\214')
> =20
> -export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID=
_REGEX
> +export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
> =20
>  # Each test should start with something like this, after copyright not=
ices:
>  #
> @@ -1381,10 +1381,9 @@ then
>  fi
> =20
>  # Convenience
> -# A regexp to match 5, 35 and 40 hexdigits
> +# A regexp to match 5 and 35 hexdigits
>  _x05=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x35=3D"$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
> -_x40=3D"$_x35$_x05"
> =20
>  test_oid_init
> =20
> @@ -1393,7 +1392,6 @@ OID_REGEX=3D$(echo $ZERO_OID | sed -e 's/0/[0-9a-=
f]/g')
>  OIDPATH_REGEX=3D$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g'=
)
>  EMPTY_TREE=3D$(test_oid empty_tree)
>  EMPTY_BLOB=3D$(test_oid empty_blob)
> -_z40=3D$ZERO_OID
> =20
>  # Provide an implementation of the 'yes' utility; the upper bound
>  # limit is there to help Windows that cannot stop this loop from
