Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819C61F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeKZRpa (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:45:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56687 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZRpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:45:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1050E10EC23;
        Mon, 26 Nov 2018 01:52:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZYyxPHp6EEak
        5JOPDBe5TeCaWOI=; b=NRdv1LWWidQvInBTVVT3S9STSLtsa3xCZ7In+sSCvnWa
        Xa02JUCEs2+kDBLozI5ozk+LBg+8gMYpinHnsTGkuAJB59TU7nNOlUjwoMnVhYsU
        K/QoEZaeTvcsMz0DghfueyiQEBt0GAmJIo+xwNFNwaTWS6UzZfIrafu20BKPPkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R9O41l
        eAv5NM9b5MNqh9LooAahDkRjR29Kjk6rj04lFDQ7Js3JkA+aXcrms+oKVWsNP6bZ
        9NtPVb+iDnxKL218g31XYiG3AKZNGS7ySFTD2cfMfvySPtI2b8qDAGgwFOEcJ3B9
        rnL1ydJAmsd1rsyCGuc+se4D74Q7C7SiYIKOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 093F810EC21;
        Mon, 26 Nov 2018 01:52:21 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78E0F10EC20;
        Mon, 26 Nov 2018 01:52:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] t5004: use GNU tar to avoid known issues with BSD tar
References: <cover.1543143503.git.carenas@gmail.com>
        <48f223add200dfcf02f280fcc577cc94255820ce.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:52:19 +0900
In-Reply-To: <48f223add200dfcf02f280fcc577cc94255820ce.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:49
        -0800")
Message-ID: <xmqq8t1gxrdo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D21F9352-F147-11E8-B7B8-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 56ee96572a ("t5004: resurrect original empty tar archive test", 2013-05=
-09)
> added a test to try to detect and workaround issues with the standard t=
ar
> from BSD, but at least in NetBSD would be better to instead require GNU=
 tar
> which is available from pkgsrc
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t5004-archive-corner-cases.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-c=
ases.sh
> index ced44355ca..baafc553f8 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -31,6 +31,8 @@ test_lazy_prereq UNZIP_ZIP64_SUPPORT '
>  	"$GIT_UNZIP" -v | grep ZIP64_SUPPORT
>  '
> =20
> +test $uname_s =3D NetBSD && TAR=3D"gtar"
> +

This smells wrong.

Isn't the top-level Makefile ask you to use TAR=3Dgtar if that is the
usable implementation of tar on your platform, and isn't what you
specify as $(TAR) exported down to the t/Makefile to be used here?

>  # bsdtar/libarchive versions before 3.1.3 consider a tar file with a
>  # global pax header that is not followed by a file record as corrupt.
>  if "$TAR" tf "$TEST_DIRECTORY"/t5004/empty-with-pax-header.tar >/dev/n=
ull 2>&1
