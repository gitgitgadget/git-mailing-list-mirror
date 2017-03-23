Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB6220958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbdCWROF (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:14:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751714AbdCWROE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:14:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78079882A7;
        Thu, 23 Mar 2017 13:14:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ppEGOJxm3kAB
        /Fj6rpV7I0TTnsw=; b=StmzjKvkwxu6lHtiXnteOh/kiw4LZprahDrqBNbdh94b
        PUwRp1rzHItxL7MHyhcdi0heERZtZaXnrAsaibtRnstWxNQkt2NzJDryaSWB4Bq/
        Mqdpqn5LTlp7KcHQ4EULQsqtHjsQ1w5pFONWlRea4L5+wWyo+6H7+iE9SYiAhOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Cg5Ky8
        f/of7BQqlFzQYI9NIWZ/thJn4xuhULT/hRcvLrMTRlddnNcVe/Ncl2uizHfR0CgZ
        2I+NWGB5CldXxI2x+OjeKlfAvtl7mqJ+JYw55GQUz8NpNvQHesMUOVHciQoPJoWZ
        mcLO7VXjY3GmamZPK+wTgdyoJYJ2P3xlDxHpg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FB38882A6;
        Thu, 23 Mar 2017 13:14:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EF34882A5;
        Thu, 23 Mar 2017 13:14:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 09/16] tag: add more incompatibles mode tests
References: <20170323130529.11361-1-avarab@gmail.com>
        <20170323130529.11361-10-avarab@gmail.com>
Date:   Thu, 23 Mar 2017 10:13:59 -0700
In-Reply-To: <20170323130529.11361-10-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Mar 2017 13:05:22 +0000")
Message-ID: <xmqqtw6jex0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B73B838-0FEC-11E7-95F6-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Amend the test suite to test for more invalid uses like "-l -a"
> etc. This change tests this code path in builtin/tag.c:
>
>     `(argc =3D=3D 0 && !cmdmode)`
>     ->
>     `((create_tag_object || force) && (cmdmode !=3D 0))`

What is this notation trying to tell us?  A range of lines starting
with the first one to the second one?  If so perhaps

	Add tests to detect more invalid combinations like "-a -l",
	to test code that defaults to the list mode when no other
	conflicting options are given and that detects conflicting
	requests.

would be easier to understand, I would think.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t7004-tag.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 63ee2cf727..92af8bb7e6 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1455,8 +1455,24 @@ test_expect_success 'checking that initial commi=
t is in all tags' "
> =20
>  test_expect_success 'mixing incompatibles modes and options is forbidd=
en' '
>  	test_must_fail git tag -a &&
> +	test_must_fail git tag -a -l &&
> +	test_must_fail git tag -s &&
> +	test_must_fail git tag -s -l &&
> +	test_must_fail git tag -m &&
> +	test_must_fail git tag -m -l &&
> +	test_must_fail git tag -m "hlagh" &&
> +	test_must_fail git tag -m "hlagh" -l &&
> +	test_must_fail git tag -F &&
> +	test_must_fail git tag -F -l &&
> +	test_must_fail git tag -f &&
> +	test_must_fail git tag -f -l &&
> +	test_must_fail git tag -a -s -m -F &&
> +	test_must_fail git tag -a -s -m -F -l &&
>  	test_must_fail git tag -l -v &&
> +	test_must_fail git tag -l -d &&
> +	test_must_fail git tag -l -v -d &&
>  	test_must_fail git tag -n 100 &&
> +	test_must_fail git tag -n 100 -v &&
>  	test_must_fail git tag -l -m msg &&
>  	test_must_fail git tag -l -F some file &&
>  	test_must_fail git tag -v -s &&
