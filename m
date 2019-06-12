Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F521F462
	for <e@80x24.org>; Wed, 12 Jun 2019 17:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfFLRuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 13:50:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52066 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfFLRuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 13:50:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3714B6FC9D;
        Wed, 12 Jun 2019 13:49:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CoqKvrKXCOst
        Y6de1fRIpSoeIHo=; b=nmvLf3IFIZ8wOHEvKchtXqmM92Zo/06/x72LaWa/9sBz
        LH9R1WAxgPcQm3xyR9AVqE4K0xTuV8kbxOuVcWh4wjFRApn8kD95cosX9Hk9EJxv
        tx8RInhRrYiHufa9LD0nZnQm8kjokymjU0fGusqAzcWn+W/6j7NSkxU0wu2fxsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FszshX
        WVP3hP7Q+s+YLvNxE1jPFhai5XMZe0xI2SHEM8ptoeK/FXYYVG/DhGt6oBmEge6F
        XxMf/NDs5twQB8bzKn4EuPBMOmiKQduQH7fcg1NOyEiys04JRne5xN3/0zKbGrkY
        qlIhnKRKxRnmR3vUatzSjIXqbZoobypAgZ2MA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E0F56FC9C;
        Wed, 12 Jun 2019 13:49:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 582146FC9B;
        Wed, 12 Jun 2019 13:49:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] Revert "test-lib: whitelist GIT_TR2_* in the environment"
References: <20190519144309.9597-1-szeder.dev@gmail.com>
        <20190612142941.22056-1-avarab@gmail.com>
Date:   Wed, 12 Jun 2019 10:49:54 -0700
In-Reply-To: <20190612142941.22056-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 12 Jun 2019 16:29:41 +0200")
Message-ID: <xmqq1rzyk81p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D71E19A-8D3A-11E9-8B41-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This reverts my commit c1ee5796dc ("test-lib: whitelist GIT_TR2_* in
> the environment", 2019-03-30), which is now redundant.
>
> Since e4b75d6a1d ("trace2: rename environment variables to
> GIT_TRACE2*", 2019-05-19) the GIT_TRACE2* variables match the existing
> GIT_TRACE* pattern added in 95a1d12e9b ("tests: scrub environment of
> GIT_* variables", 2011-03-15), so we no longer need to list TR2 here.

Yeah, makes sense.  Thanks.


>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 599fd70e14..57f7c30377 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -386,7 +386,6 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" =
-e '
>  	my @env =3D keys %ENV;
>  	my $ok =3D join("|", qw(
>  		TRACE
> -		TR2_
>  		DEBUG
>  		TEST
>  		.*_TEST
