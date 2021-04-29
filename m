Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8201C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9610261456
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhD2Duj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 23:50:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50423 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhD2Du1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 23:50:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C6FA131026;
        Wed, 28 Apr 2021 23:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lLV1E9gPnqGz
        ADtNj37MjLwqvrBaujVE80tRYq5+KaY=; b=FbC7bignbHVaU7TNuhWXcW1ynIjw
        ra8jWAfW5iYJjPnBhmeoGNMZgm4n0fJNwN4Je4r6caZDo94/zvO3OCGFMMHe1iVx
        kmeHuU3CPSdR15gqT6Dr5mYDEgQBDgd7Hc3vVKDKwoDBvXcT24P76Jqmq/xZ2Ly8
        QO59/ckFvRAU0T0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 291FD131025;
        Wed, 28 Apr 2021 23:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58C02131024;
        Wed, 28 Apr 2021 23:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 1/4] test-lib-functions: normalize
 test_path_is_missing() debugging
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
        <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
        <patch-1.4-26a3d552d88-20210423T072824Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 12:49:21 +0900
In-Reply-To: <patch-1.4-26a3d552d88-20210423T072824Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 23 Apr
 2021 09:29:43 +0200")
Message-ID: <xmqqr1it92da.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E2D388D8-A89D-11EB-BF66-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the test_path_is_missing() to be consistent with related
> functions.

Not very helpful to readers.  It is totally unclear what kind of
consistency is being sought by this patch.

> Since 2caf20c52b7 (test-lib: user-friendly alternatives to
> test [-d|-f|-e], 2010-08-10) we've been ls -ld-ing the bad path and
> echo-ing $* if it exists.

Yes, and it does not explain what's wrong with that behaviour.

If there were something like "... but no invocation of the shell
function passes $2 and subsequent arguments" (I didn't check if that
is the case) after the above, it might have been more
understandable, though.

> Let's just say that it exists instead.

As the earlier parts of the proposed log message are so weak, this
conclusion does not sound convincing.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib-functions.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 213b1988aa4..2914b398470 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -810,12 +810,7 @@ test_path_is_missing () {
>  	test "$#" -ne 1 && BUG "1 param"
>  	if test -e "$1"
>  	then
> -		echo "Path exists:"
> -		ls -ld "$1"
> -		if test $# -ge 1
> -		then
> -			echo "$*"
> -		fi
> +		echo "Path $1 exists!"
>  		false
>  	fi
>  }
