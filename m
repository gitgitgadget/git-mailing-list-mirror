Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8451C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6EC613FD
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhDTW3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:29:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60818 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTW3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:29:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44442D1223;
        Tue, 20 Apr 2021 18:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=59X93EaBM5GK
        6Gjfe1qv7VJmIvw=; b=F1t64BzFj2GcIfNSZ1yVT76W3X4caDZQXchvSox6mM8I
        gZxOX0nTAW0HAsNImkMdHsTWfo3X6lpRHxF8vlZMvR7o80HITQGssHPPytu90eLy
        eHPhEhYTz5FOHATc8ut2bj+VsYs2RjP+K/Fe2ogzAIi9a/ZbQWYqV0lyHxdZpZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JqwmVq
        tVlyB5vkUs4TJO/eVsw6lo4NevLuHJdoGMbH3fFgVHAT6aVrIzQU/43zWZpxu8Cf
        0dYavNOPZflRjjFNdlzSAe15UFAoD8+hMSS2yQndqviquaO6nwEOrjzRnIykVCZy
        0IwCGXKPOni8qS+/dXWZReRmYNvSBSg9uxJwI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B102D1222;
        Tue, 20 Apr 2021 18:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CC51D1220;
        Tue, 20 Apr 2021 18:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 02/12] test-lib: bring $remove_trash out of retirement
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
        <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
        <patch-02.12-39759d00ad-20210420T121833Z-avarab@gmail.com>
Date:   Tue, 20 Apr 2021 15:28:31 -0700
In-Reply-To: <patch-02.12-39759d00ad-20210420T121833Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:21:53 +0200")
Message-ID: <xmqqsg3k381c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD15DFBE-A227-11EB-999C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We carry around the "$remove_trash" variable because if the directory
> is unexpectedly gone at test_done time we'll hit the error about it
> being unexpectedly gone added in df4c0d1a792 (test-lib: abort when
> can't remove trash directory, 2017-04-20).

Makes sense, but then remove_trash should be initialized to a
non-empty string at the beginning, to avoid it leaking from end-user
environment, just like the way store_arg_to and opt_required_arg are
protected?

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3dec266221..7522faf39f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1169,7 +1169,7 @@ test_done () {
>  			esac
>  		fi
> =20
> -		if test -z "$debug"
> +		if test -z "$debug" && test -n "$remove_trash"
>  		then
>  			test -d "$TRASH_DIRECTORY" ||
>  			error "Tests passed but trash directory already removed before test=
 cleanup; aborting"
> @@ -1334,6 +1334,21 @@ then
>  	exit 1
>  fi
> =20
> +# Are we running this test at all?
> +this_test=3D${0##*/}
> +this_test=3D${this_test%%-*}
> +if match_pattern_list "$this_test" $GIT_SKIP_TESTS
> +then
> +	say_color info >&3 "skipping test $this_test altogether"
> +	skip_all=3D"skip all tests in $this_test"
> +	test_done
> +fi
> +
> +# Last-minute variable setup
> +HOME=3D"$TRASH_DIRECTORY"
> +GNUPGHOME=3D"$HOME/gnupg-home-not-used"
> +export HOME GNUPGHOME
> +
>  # Test repository
>  rm -fr "$TRASH_DIRECTORY" || {
>  	GIT_EXIT_OK=3Dt
> @@ -1341,10 +1356,7 @@ rm -fr "$TRASH_DIRECTORY" || {
>  	exit 1
>  }
> =20
> -HOME=3D"$TRASH_DIRECTORY"
> -GNUPGHOME=3D"$HOME/gnupg-home-not-used"
> -export HOME GNUPGHOME
> -
> +remove_trash=3Dt
>  if test -z "$TEST_NO_CREATE_REPO"
>  then
>  	test_create_repo "$TRASH_DIRECTORY"
> @@ -1356,15 +1368,6 @@ fi
>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>  cd -P "$TRASH_DIRECTORY" || exit 1
> =20
> -this_test=3D${0##*/}
> -this_test=3D${this_test%%-*}
> -if match_pattern_list "$this_test" $GIT_SKIP_TESTS
> -then
> -	say_color info >&3 "skipping test $this_test altogether"
> -	skip_all=3D"skip all tests in $this_test"
> -	test_done
> -fi
> -
>  if test -n "$write_junit_xml"
>  then
>  	junit_xml_dir=3D"$TEST_OUTPUT_DIRECTORY/out"
