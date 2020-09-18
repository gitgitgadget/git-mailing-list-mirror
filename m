Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2720C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF7320DD4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIRV5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:57:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33992 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgIRV5A (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Sep 2020 17:57:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D1F3260756;
        Fri, 18 Sep 2020 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600466188;
        bh=KISUR1rGC6E400BRvbkJzGrg3tQzj3zFLdzPXugu1Uo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ISK0KQ1hJvGQ7ica7U7H+LSXb2TxYIDPGgQQjgqF3hi9GELhpxbvf5B49bLotroyf
         1IPxQ8WryJw43FxkaPr91mMIkiNmRQ8Yfs2+k6QPrDJUZrmKhUrVFKu7zM9CtgJdlt
         YhyCEM4sQFqikuORqsPzBwXAneKKjhDhvV2qXdv0j6hWvUvyRoIgarRrTpjbbVjyS0
         Vcyfbx/7RgMkTH07yum4bmsQDa6U8RVzsOzZm76U18C4aMe6MoC5o+1vOdCmEcspwq
         4My3a5zIp2G5D/w2iDAwt1E6JIroQT4rRrTJvhWb6Y4MLohdPuHv/3gxeh5rDerDmV
         zgQHn3MuRASLY+SF2pTmigr7jmvY/LjeQu9JUJbqDb+l9Lxwv09mCioNdIgmfT8YUT
         wX3q0qcKgiMBid00juGXABDtgABUexcqiFtR/hheOhltGVxFE4MaUDlzKy/sugTs5S
         miQvHOiD63cZ+o8+zwsgi81O5yieWk7GapczzszEp4OGyQmdOI6
Date:   Fri, 18 Sep 2020 21:56:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     git@vger.kernel.org, dermoth@aei.ca
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918215623.GE67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <20200918113256.8699-3-tguyot@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-18 at 11:32:56, Thomas Guyot-Sionnest wrote:
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 7814eabfe0..779c686d23 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -41,6 +41,33 @@ static int read_directory_contents(const char *path, s=
truct string_list *list)
>   */
>  static const char file_from_standard_input[] =3D "-";
> =20
> +/* Check that file is - (STDIN) or unnamed pipe - explicitly
> + * avoid on-disk named pipes which could block
> + */
> +static int ispipe(const char *name)
> +{
> +	struct stat st;
> +
> +	if (name =3D=3D file_from_standard_input)
> +		return 1;  /* STDIN */
> +
> +	if (!lstat(name, &st)) {
> +		if (S_ISLNK(st.st_mode)) {
> +			/* symlink - read it and check it doesn't exists
> +			 * as a file yet link to a pipe */
> +			struct strbuf sb =3D STRBUF_INIT;
> +			strbuf_realpath(&sb, name, 0);
> +			/* We're abusing strbuf_realpath here, it may append
> +			 * pipe:[NNNNNNNNN] to an abs path */
> +			if (!stat(sb.buf, &st))
> +				return 0; /* link target exists , not pipe */
> +			if (!stat(name, &st))
> +				return S_ISFIFO(st.st_mode);

This makes a lot of assumptions about the implementation which are
specific to Linux, namely that an anonymous pipe will be a symlink to a
FIFO.  That's not the case on macOS, where the /dev/fd entries are
actually named pipes themselves.

Granted, in that case, Git just chokes and fails instead of diffing the
symlink values, but I suspect you'll want this to work on macOS as well.
I don't use macOS that often, but I would appreciate it if it worked
when I did, and I'm sure others will as well.

I think we can probably get away with just doing a regular stat and
seeing if S_ISFIFO is true, which is both simpler and cheaper.

> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 0168946b63..e49f773515 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -144,4 +144,193 @@ test_expect_success 'diff --no-index allows externa=
l diff' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'diff --no-index can diff piped subshells' '
> +	echo 1 >non/git/c &&
> +	test_expect_code 0 git diff --no-index non/git/b <(cat non/git/c) &&
> +	test_expect_code 0 git diff --no-index <(cat non/git/b) non/git/c &&
> +	test_expect_code 0 git diff --no-index <(cat non/git/b) <(cat non/git/c=
) &&
> +	test_expect_code 0 cat non/git/b | git diff --no-index - non/git/c &&
> +	test_expect_code 0 cat non/git/c | git diff --no-index non/git/b - &&
> +	test_expect_code 0 cat non/git/b | git diff --no-index - <(cat non/git/=
c) &&
> +	test_expect_code 0 cat non/git/c | git diff --no-index <(cat non/git/b)=
 -
> +'

As mentioned by others, this requires non-POSIX syntax.  /bin/sh on my
Debian system is dash, which doesn't support this.  You can either use a
prerequisite, or just test by piping from standard input and assume that
Git can handle the rest.  I would recommend at least adding some POSIX
testcases that use only a pipe from standard input to avoid regressing
this behavior on Debian and Ubuntu.
--=20
brian m. carlson: Houston, Texas, US

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2UtBwAKCRB8DEliiIei
gdpZAP40xPId/EVCl8cEfTkfzPMUphB1XlQchVLYtifJ7cPaEQEA3VJ2H9C/LuMs
LQrorElFjGqcvKnolVtCo8C+Mnuq0wM=
=KRQ/
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
