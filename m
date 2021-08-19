Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8403CC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62670610E5
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhHSUUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:20:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61449 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbhHSUUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:20:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AEB3D191D;
        Thu, 19 Aug 2021 16:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GuDESSnZFC5S
        ukvYB92TjzRrqUO1s3Z0qfQah6zktZE=; b=KAZPCaULbR4OVRqijzlNGwahifgq
        qRKZN+o/58NmFI6HjhOckvtgLqgmdIEqJie8EQryvK+7kHHN5nI67Qnmy9124uBm
        chp+DEg/Qxpt20MiaJeLyZ6Qa6We53nMw4XONWesmkyWQm9ZDq7iUbRKM0KjU85p
        zwoJHg9RL4Boaak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7374DD191C;
        Thu, 19 Aug 2021 16:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2EC8D191A;
        Thu, 19 Aug 2021 16:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] t6300: check for cat-file exit status code
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
        <cover.1629263759.git.congdanhqx@gmail.com>
        <68ee769121195eb61bb51fd6a27d22a8dddb13b6.1629263759.git.congdanhqx@gmail.com>
Date:   Thu, 19 Aug 2021 13:19:42 -0700
In-Reply-To: <68ee769121195eb61bb51fd6a27d22a8dddb13b6.1629263759.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 18 Aug
 2021 12:19:27 +0700")
Message-ID: <xmqqim01yyox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9F4654A-012A-11EC-9BFE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> In test_atom(), we're piping the output of cat-file to tail(1),
> thus, losing its exit status.
>
> Let's use a temporary file to preserve git exit status code.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  t/t6300-for-each-ref.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 93126341b3..cc0f5b6627 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -66,7 +66,9 @@ test_atom() {
>  			case $type in
>  			tag)
>  				# We cannot use $3 as it expects sanitize_pgp to run
> -				expect=3D$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
> +				git cat-file tag $ref >out &&
> +				expect=3D$(tail -n +6 <out | wc -c) &&

It is not wrong per-se, but do we need a redirect '<' here?  "tail"
takes filename(s) on the command line, but is there a reason to feed
the contents from the standard input?

> +				rm -f out ;;
>  			tree | blob)
>  				expect=3D"" ;;
>  			commit)
