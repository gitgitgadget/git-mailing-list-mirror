Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5EFC55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8C20776
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TM3KHFde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDVRRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:17:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59929 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDVRRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 13:17:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88BE3C0200;
        Wed, 22 Apr 2020 13:17:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SqhNdZAHsuk3
        3sfX04JUyARdTSo=; b=TM3KHFde2w1OlLoGUd5MwWTRlGtNLBYPMeuRgYSFafSn
        fB0Jh5OqkFThv1W9c6zszOl1OK6qZ/0Xap6aIw0RMd0LmwNuIoizjTE4pxRAOMx7
        sgATqs3Tdr0meblNTVICMgb1cgTm8Owhojm1fqz6zac+pi5AYxq6oryf+scr05A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=l4+aVX
        0vEUecDLJ11u7tCrIZUWs+jnb3tHLmkSYb9N3LOHkK0v/etqF/y8EgmphmmC1WdC
        KX7LwuRNePOIumA9U3Fnfxwc2vYjDfUjOSRnRV+acSEk7jOBNvweDZp9LF/EIc3e
        yGVC9bQEeIq+3YcAmyeINKj0q7vju9K4c0RRQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72D59C01FE;
        Wed, 22 Apr 2020 13:17:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A29F2C01FB;
        Wed, 22 Apr 2020 13:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] date.c: allow compact version of ISO-8601 datetime
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587559135.git.congdanhqx@gmail.com>
        <225b6401bd1f7eddc245acfd2c4b37c50c978491.1587559135.git.congdanhqx@gmail.com>
Date:   Wed, 22 Apr 2020 10:17:35 -0700
In-Reply-To: <225b6401bd1f7eddc245acfd2c4b37c50c978491.1587559135.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 22 Apr
 2020 20:15:53 +0700")
Message-ID: <xmqqftcvjv80.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A03D11E-84BD-11EA-ADF0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  date.c          | 22 ++++++++++++++++++++++
>  t/t0006-date.sh |  3 +++
>  2 files changed, 25 insertions(+)
>
> diff --git a/date.c b/date.c
> index 62f23b4702..882242c2db 100644
> --- a/date.c
> +++ b/date.c
> @@ -672,6 +672,28 @@ static int match_digit(const char *date, struct tm=
 *tm, int *offset, int *tm_gmt
>  		n++;
>  	} while (isdigit(date[n]));
> =20
> +	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
> +	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
> +	if (n =3D=3D 8 || n =3D=3D 6) {
> +		unsigned int num1 =3D num / 10000;
> +		unsigned int num2 =3D (num % 10000) / 100;
> +		unsigned int num3 =3D num % 100;
> +		if (n =3D=3D 8 && num1 > 1900 &&
> +		    num2 > 0 && num2 <=3D 12 &&
> +		    num3 > 0  && num3 <=3D 31) {
> +			tm->tm_year =3D num1 - 1900;
> +			tm->tm_mon  =3D num2 - 1;
> +			tm->tm_mday =3D num3;
> +		} else if (n =3D=3D 6 && num1 < 60 && num2 < 60 && num3 <=3D 60) {
> +			tm->tm_hour =3D num1;
> +			tm->tm_min  =3D num2;
> +			tm->tm_sec  =3D num3;
> +			if (*end =3D=3D '.' && isdigit(end[1]))
> +				strtoul(end + 1, &end, 10);
> +		}
> +		return end - date;
> +	}
> +

Looks sensible except that on our planet, one day has only 24 hours
;-).

I think we should try to reuse existing helpers as much as possible
in date.c to avoid such stupid errors.  During my review of [1/2] I
found is_date() would be a good thing to try reusing and also
extracted is_hms() as another candidate we could reuse.

>  	/* Four-digit year or a timezone? */
>  	if (n =3D=3D 4) {
>  		if (num <=3D 1400 && *offset =3D=3D -1) {
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 80917c81c3..75ee9a96b8 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -82,6 +82,9 @@ check_parse 2008-02-14 bad
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
>  check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
> +check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
> +check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
>  check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400=
'
>  check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
>  check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
