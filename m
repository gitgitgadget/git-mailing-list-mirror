Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1A01F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbcJEQOn (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:14:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63973 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754305AbcJEQOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:14:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8FA943834;
        Wed,  5 Oct 2016 12:14:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tv5NjxtdmVPF
        zMH0A8MVJSNY8d8=; b=rHpLGLOQ08fPz68HVd6RKsBSiYZOLf++/Twct1VRXsgT
        Tuc3n2Y/Xx/45FGRHQcg+bYvfnfxIxx8fYIKARDykfuQ0bFNluPD5UbohoVkDYr7
        WozBgnASB4YIYZLIgKWl6cZYS0SoWRBoZdU45FqPKHTxQcr51rEYjfSQheSIjR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QAZRV1
        W5AhGxXdGBFmOEgmFSD16dsvqjw5TflNuHFx0Zg0dPLiOe8rPulS9hth+DcevNN0
        05MwS166OCFFTA6SSUKIz5VLk4TRZ9tjgGNUccgWkedVLBeHPH9NQx2L1U2BG9r8
        +SGS3dF5EKtLrsVbu/MfveE1i85RxaQiEsIi8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E048043832;
        Wed,  5 Oct 2016 12:14:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5971943831;
        Wed,  5 Oct 2016 12:14:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
        <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
        <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
        <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
        <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
        <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
        <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
        <CAGZ79kap2ndp=FK4YdqrL4tJ8_VDuuAcSCk1dtX5X2H3aaj6kQ@mail.gmail.com>
        <2ea2f077-ab02-2631-4ce9-93cdd22c3c6b@gmail.com>
        <20161005144028.tjuvk3hkoqm3qjfd@sigill.intra.peff.net>
Date:   Wed, 05 Oct 2016 09:14:38 -0700
In-Reply-To: <20161005144028.tjuvk3hkoqm3qjfd@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Oct 2016 10:40:28 -0400")
Message-ID: <xmqqh98qrcwh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1A8F51A-8B16-11E6-97A0-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 05, 2016 at 03:58:53PM +0200, Jakub Nar=C4=99bski wrote:
>
>> I would prefer the following:
>>=20
>> #   A --> B --> C --> D --> E --> F --> G --> H
>> #      0     1     2     3     4     5     6
>
> Yeah, that is also more visually pleasing.
>
> Here's a squashable update that uses that and clarifies the points in
> the discussion with Jacob.
>
> Junio, do you mind squashing this in to jk/alt-odb-cleanup?

No, I don't.

> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index b393613..62170b7 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -39,13 +39,16 @@ test_expect_success 'preparing third repository' '
>  	)
>  '
> =20
> -# Note: These tests depend on the hard-coded value of 5 as "too deep".=
 We start
> -# the depth at 0 and count links, not repositories, so in a chain like=
:
> +# Note: These tests depend on the hard-coded value of 5 as the maximum=
 depth
> +# we will follow recursion. We start the depth at 0 and count links, n=
ot
> +# repositories. This means that in a chain like:
>  #
> -#   A -> B -> C -> D -> E -> F -> G -> H
> -#      0    1    2    3    4    5    6
> +#   A --> B --> C --> D --> E --> F --> G --> H
> +#      0     1     2     3     4     5     6
>  #
> -# we are OK at "G", but break at "H".
> +# we are OK at "G", but break at "H", even though "H" is actually the =
8th
> +# repository, not the 6th, which you might expect. Counting the links =
allows
> +# N+1 repositories, and counting from 0 to 5 inclusive allows 6 links.
>  #
>  # Note also that we must use "--bare -l" to make the link to H. The "-=
l"
>  # ensures we do not do a connectivity check, and the "--bare" makes su=
re
> @@ -59,11 +62,11 @@ test_expect_success 'creating too deep nesting' '
>  	git clone --bare -l -s G H
>  '
> =20
> -test_expect_success 'validity of fifth-deep repository' '
> +test_expect_success 'validity of seventh repository' '
>  	git -C G fsck
>  '
> =20
> -test_expect_success 'invalidity of sixth-deep repository' '
> +test_expect_success 'invalidity of eighth repository' '
>  	test_must_fail git -C H fsck
>  '
> =20
