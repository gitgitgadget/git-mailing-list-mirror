Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6AC433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D627365147
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCJBE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 20:04:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56861 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhCJBEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 20:04:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5D35AD41E;
        Tue,  9 Mar 2021 20:04:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NXjSXZC3egfe
        xxidbLJvAaxBjL4=; b=N57VksNLFl8hw+vyxqU3Ag8X2Z4Sd+3o8W8MOMD7O/WH
        WAZyPv/TarC9mRLo3g6OmnCrcgZAC2vd7muGH9JEvYphbaPzKMybcWkFcJLXU2yS
        jdunrTmvSQ216iHlolCloxtbMrPrG4bWPc2n2+htXH2csoeXqVTMmhkZz8L2Z+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sfUfW0
        c/65jPQn4nYEOBk8yLeHlFli6FuJYQc16RE52qCHzemYKFtF2exN6tN1iDKKyuzF
        9XfvuACAAgJYTx3v0BS2jnvIpsRT+BptLAvikCrfugmKhBR+GRjwF0HXQBx0tkMW
        XIJhtbK//qy2UC//nzr19lfrtlk3LABoejgdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D8D5AD41D;
        Tue,  9 Mar 2021 20:04:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25F44AD41C;
        Tue,  9 Mar 2021 20:04:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] test-lib: remove test_external
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
        <20210309160219.13779-2-avarab@gmail.com>
Date:   Tue, 09 Mar 2021 17:04:47 -0800
In-Reply-To: <20210309160219.13779-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 9 Mar 2021 17:02:13 +0100")
Message-ID: <xmqqsg53yg28.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9C17C676-813C-11EB-94AE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the test_external function(s) in favor of running the Perl
> tests with a test_expect_success.
> ...
> My motivation for this is to eliminate a special case where things
> that aren't test-lib.sh are going to produce TAP, for reasons that'll
> be clear in subsequent commits.

Puzzled.

>  .../netrc/t-git-credential-netrc.sh           |  7 +-
>  t/README                                      | 26 ------
>  t/t0202-gettext-perl.sh                       | 10 +--
>  t/t9700-perl-git.sh                           | 10 +--
>  t/test-lib-functions.sh                       | 89 +------------------
>  t/test-lib.sh                                 | 42 ++++-----
>  6 files changed, 28 insertions(+), 156 deletions(-)

Reducing the number of lines is always good, but is this essentially
losing what the commit that added test_external wanted to add?

> diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contr=
ib/credential/netrc/t-git-credential-netrc.sh
> index 07227d02287..28118a9e194 100755
> --- a/contrib/credential/netrc/t-git-credential-netrc.sh
> +++ b/contrib/credential/netrc/t-git-credential-netrc.sh
> @@ -20,13 +20,10 @@
>  		'set up test repository' \
>  		'git config --add gpg.program test.git-config-gpg'
> =20
> -	# The external test will outputs its own plan
> -	test_external_has_tap=3D1
> -
>  	export PERL5LIB=3D"$GITPERLLIB"
> -	test_external \
> -		'git-credential-netrc' \
> +	test_expect_success 'git-credential-netrc' '
>  		perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
> +	'
> =20
>  	test_done
>  )

This is valid because we expect nobody runs this under tap?

> diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
> index a29d166e007..06a93b36790 100755
> --- a/t/t0202-gettext-perl.sh
> +++ b/t/t0202-gettext-perl.sh
> @@ -17,11 +17,9 @@ perl -MTest::More -e 0 2>/dev/null || {
>  	test_done
>  }
> =20
> -# The external test will outputs its own plan
> -test_external_has_tap=3D1
> -
> -test_external_without_stderr \
> -    'Perl Git::I18N API' \
> -    perl "$TEST_DIRECTORY"/t0202/test.pl
> +test_expect_success 'run t0202/test.pl to test Git::I18N.pm' '
> +	perl "$TEST_DIRECTORY"/t0202/test.pl 2>stderr &&
> +	test_must_be_empty stderr
> +'

So t0202/test.pl would still produce output that would confuse
whoever is reading our output as TAP, and it is OK?  If the
redirection discards its standard output to /dev/null [*], I would
sort-of understand how this may work (we would have let the perl
script to emit 13 "ok" or "not ok" to our output, but now we discard
that and write just one our own "ok" or "not ok", depending on what
comes out to the standard error stream (e.g. "# Looks like you
failed...").

But that is not what is going on.  We'll let these 13 "ok" or "not ok"
come out from the perl script and then add another on our own.

> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index 102c133112c..574c57b17f1 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -50,11 +50,9 @@ test_expect_success \
  >       git config --add test.pathmulti bar
>       '
> =20
> -# The external test will outputs its own plan
> -test_external_has_tap=3D1
> -
> -test_external_without_stderr \
> -    'Perl API' \
> -    perl "$TEST_DIRECTORY"/t9700/test.pl
> +test_expect_success 'use t9700/test.pl to test Git.pm' '
> +	perl "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
> +	test_must_be_empty stderr
> +'

Ditto.  It seems that we are still letting the script, i.e. one of
the "things that aren't test-lib.sh" to produce TAP anyway.


[Footnote]

* If we are truly somehow discarding these output that would be TAP
(13 tests in 0202 and uncounted in 9700) from being shown (by e.g.
redirecting output to /dev/null), it would be a regression for those
who debug breakage found by these tests.  They used to be told which
one failed and how but now they don't.  So I do not think that is a
useful way to go, either.


