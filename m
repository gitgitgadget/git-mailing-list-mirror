Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22638C3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE2420782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r/MQK6zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgDTT7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:59:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54439 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgDTT7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 15:59:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E5E059288;
        Mon, 20 Apr 2020 15:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jLfPuLro0vKd
        1eV0XHKOan5Ax+Y=; b=r/MQK6zhdidkLg8uSGzE2agtK2tI3ZwZ1/lcgNMuico9
        oNnNRtA19VC12rdqi0W7ZaU+bSW4f2uuz0bfwKV6MZ/r/fizlLYe3riMuS6nTFL6
        t+46t87OBgxCkOd9puAqcowAX872vcla2Xwy8iXDAXwsaBEP0vacSI+6NI9H8CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FbfOhH
        fdWA6Hrp3elj8/OqKh3EY4APItrymMYoFtGzYbflnd1flgBLeXjTV5qXDhHShs7l
        PxQX5W8zAoYrdf4z/OUyWJlWa0TVwttaCX5PmV4JYg3XzpcmkyuR5upqf+HQkvLA
        zpAziyVKTg/s2PSjARmBSQEfq5Y1MjJ9kyDTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6760A59287;
        Mon, 20 Apr 2020 15:59:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB05859286;
        Mon, 20 Apr 2020 15:59:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mailinfo.c::convert_to_utf8: reuse strlen info
References: <20200418035449.9450-1-congdanhqx@gmail.com>
        <cover.1587289680.git.congdanhqx@gmail.com>
        <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
Date:   Mon, 20 Apr 2020 12:59:37 -0700
In-Reply-To: <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Sun, 19 Apr
 2020 18:00:41 +0700")
Message-ID: <xmqqv9luq66u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76EFD3F6-8341-11EA-A3CB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
> index ddd35498db..98cda32d0a 100755
> --- a/t/t4254-am-corrupt.sh
> +++ b/t/t4254-am-corrupt.sh
> @@ -3,6 +3,36 @@
>  test_description=3D'git am with corrupt input'
>  . ./test-lib.sh
> =20
> +write_nul_patch() {

Style: SP on both sides of (), i.e.

	write_nul_patch () {

But isn't this misnamed?  You are interested in injecting '\0' byte
in the e-mail headers and bodies, not necessarily part of the patch,
but "nul-patch" somehow hints readers that we are writing out a Null
Patch (something that does not do anything, perhaps?).

sample_mbox_with_nul is the best alternative I can come up with
offhand, which is not great either, but at least it does not say
patch.

> +	space=3D' '
> +	qNUL=3D
> +	case "$1" in
> +		subject) qNUL=3D'=3D00' ;;
> +	esac

Style: case/esac aligns with case arms, i.e.

	case "$1" in
	subject) qNUL=3D'=3D00' ;;
	esac

> +	cat <<-EOF
> +	From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00 200=
1
> +	From: A U Thor <author@example.com>
> +	Date: Sun, 19 Apr 2020 13:42:07 +0700
> +	Subject: [PATCH] =3D?ISO-8859-1?q?=3DC4=3DCB${qNUL}=3DD1=3DCF=3DD6?=3D
> +	MIME-Version: 1.0
> +	Content-Type: text/plain; charset=3DISO-8859-1
> +	Content-Transfer-Encoding: 8bit
> +
> +	EOF

Since the above does have ${qNUL} interpolated, not quoting <<-EOF
is correct.  Good.

> +	if test "$1" =3D body
> +	then
> +		printf "%s\0%s\n" abc def
> +	fi

OK.  So we won't be able to inject NUL byte in both header and body
at the same time.  If you wanted to allow it, you could write

	case ",$1," in
	*,subject,*)	qNUL=3D"=3D00" ;;
	esac

in the early part, and then rewrite this one like so:

	case ",$1," in
	*,body,*)	printf "..." ;;
	esac

Then those callers who want to ask for both can say

	sample_mbox_with_nul subject,body

> +	cat <<-\EOF
> +	---
> +	diff --git a/afile b/afile
> +	new file mode 100644
> +	index 0000000000..e69de29bb2
> +	--$space
> +	2.26.1
> +	EOF

Doesn't this want to interpolate $space in the output?  I think you
want to say <<-EOF, without quoting.

    cd t && sh t4254-am-corrupt.sh -d && cat trash*.t4254-*/body.patch

tells me that "--$space" is left in the output, not "-- ".

> +}
> +
>  test_expect_success setup '
>  	# Note the missing "+++" line:
>  	cat >bad-patch.diff <<-\EOF &&
> @@ -32,4 +62,18 @@ test_expect_success 'try to apply corrupted patch' '
>  	test_i18ncmp expected actual
>  '
> =20
> +test_expect_success "NUL in commit message's body" '
> +	test_when_finished "git am --abort" &&
> +	write_nul_patch body >body.patch &&
> +	test_must_fail git am body.patch 2>err &&
> +	grep "a NUL byte in commit log message not allowed" err
> +'
> +
> +test_expect_failure "NUL in commit message's header" '
> +	test_when_finished "git am --abort" &&
> +	write_nul_patch subject >subject.patch &&
> +	test_must_fail git am subject.patch 2>err &&
> +	grep "a NUL byte in Subject is not allowed" err
> +'
> +
>  test_done
