Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C261C209FA
	for <e@80x24.org>; Wed, 12 Apr 2017 08:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbdDLIVI (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 04:21:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56607 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752537AbdDLIVG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Apr 2017 04:21:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FBC720C18;
        Wed, 12 Apr 2017 04:21:05 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 12 Apr 2017 04:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=cPflzNgqLnnl1RWrpr
        9GCGMC4YjBYnj2KmatuVkkktE=; b=c5nYby4TIq7Btr3GQ6EUr2mWFKd/ae/6rx
        p7kRDssbIm2/f3/rIhJPxAtLvCENZhFuuedEFxTTjAVgocBZDKjyzNy0uHfIld6N
        hALGFmyYCLz17qbrSZK3Z/yVEs9xE2LFCPUraal6wafp6uNNRXDy6vCSMxeCFr1Q
        RCEIe579nf/634OfNIEp0ffEeOy3nxs31vHhzKxETxszsYYIbZA/OUAN5LNtsW3X
        aotSJXjc+wa2r6nKNwMysL7s55iMyNgAH3Sbhx/y3XeozQAzu1z8wFg5Ivz8/3hB
        pBkYq5V5RwIlpg52IRfgoKlZHe5MgWwT/NNbDlOvHjdTqm/OyGkw==
X-ME-Sender: <xms:cePtWOXI1z5_-dkgWv6vG2Tzxbz5IrO0AfBZnY46sMPbou6ChO9QNA>
X-Sasl-enc: mvEv9CASpRIORbeawXAGG2zIywbCxUivjTbg0dWpHpa/ 1491985264
Received: from localhost (p57a9704b.dip0.t-ipconnect.de [87.169.112.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id C34C87E442;
        Wed, 12 Apr 2017 04:21:04 -0400 (EDT)
Date:   Wed, 12 Apr 2017 10:22:05 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty
 prefix
Message-ID: <20170412082205.GA448@pks-xps>
References: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 11:16:56AM +0200, Patrick Steinhardt wrote:
> Previous to commit 5d8f084a5 (pathspec: simpler logic to prefix original
> pathspec elements, 2017-01-04), we were always using the computed
> `match` variable to perform pathspec matching whenever
> `PATHSPEC_PREFIX_ORIGIN` is set. This is for example useful when passing
> the parsed pathspecs to other commands, as the computed `match` may
> contain a pathspec relative to the repository root. The commit changed
> this logic to only do so when we do have an actual prefix and when
> literal pathspecs are deactivated.
>=20
> But this change may actually break some commands which expect passed
> pathspecs to be relative to the repository root. One such case is `git
> add --patch`, which now fails when using relative paths from a
> subdirectory. For example if executing "git add -p ../foo.c" in a
> subdirectory, the `git-add--interactive` command will directly pass
> "../foo.c" to `git-ls-files`. As ls-files is executed at the
> repository's root, the command will notice that "../foo.c" is outside
> the repository and fail.
>=20
> Fix the issue by again using the computed `match` variable when
> `PATHSPEC_PREFIX_ORIGIN` is set and global literal pathspecs are
> deactivated. Note that in contrast to previous behavior, we will now
> always call `prefix_magic` regardless of whether a prefix is actually
> set. But this is the right thing to do: when the `match` variable has
> been resolved to the repository's root, it will be set to an empty
> string. When passing the empty string directly to other commands, it
> will result in a warning regarding deprecated empty pathspecs. By always
> adding the prefix magic, we will end up with at least the string
> ":(prefix:0)" and thus avoid the warning.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

Just a short reminder on this patch, as I haven't seen it or
v1 being picked up by the What's Cooking reports. Am I simply
being too eager or was this an oversight?

Thanks
Patrick

>=20
> This is the second version of [1]. It fixes a bug catched by
> Brandon when the pathspec is resolved to the empty string and
> improves the test a bit to actually catch this issue.
>=20
> [1]: http://public-inbox.org/git/1556910880cfce391bdca2d8f0cbcb8c71371691=
=2E1491206540.git.ps@pks.im/T/#u
>=20
>=20
>  pathspec.c                 |  2 +-
>  t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/pathspec.c b/pathspec.c
> index 303efda83..3079a817a 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -505,7 +505,7 @@ static void init_pathspec_item(struct pathspec_item *=
item, unsigned flags,
>  	 * original. Useful for passing to another command.
>  	 */
>  	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
> -	    prefixlen && !get_literal_global()) {
> +	    !get_literal_global()) {
>  		struct strbuf sb =3D STRBUF_INIT;
> =20
>  		/* Preserve the actual prefix length of each pattern */
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index f9528fa00..2ecb43a61 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -436,6 +436,28 @@ test_expect_success 'add -p handles globs' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'add -p handles relative paths' '
> +	git reset --hard &&
> +
> +	echo base >relpath.c &&
> +	git add "*.c" &&
> +	git commit -m relpath &&
> +
> +	echo change >relpath.c &&
> +	mkdir -p subdir &&
> +	git -C subdir add -p .. 2>error <<-\EOF &&
> +	y
> +	EOF
> +
> +	test_must_be_empty error &&
> +
> +	cat >expect <<-\EOF &&
> +	relpath.c
> +	EOF
> +	git diff --cached --name-only >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'add -p does not expand argument lists' '
>  	git reset --hard &&
> =20
> --=20
> 2.12.2

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAljt460ACgkQEXxntp6r
8Sx1tQ/9GhJActNMp+4+neSE5yO/j17K0uLIQYLwm+TB2UQ9gcGES4JnMPP5E6Fv
m+vmQhmcrRDw6BMAUFdKpBqAIj2FJmxKUZ4Ywij9Is2AyDvcjYU+AbZxIHUe296L
g23GdVJGDa1IKl20WaBGlHvTd8N4ASFGGeETNY/QHbRKiJ68mj61f3GxmCnjol9P
5gVpm0U6jamxVFi0U7BUFyjnx7cNThDKXcfhxfp7Uk9pXVU+f1xOzzHkks1PEzLG
aH6cqxjKzDmRJeIQHKxbhvCXelR5syU7YRWSRgwZUPHKrYGzh3JtKEtl7kVDjW5/
A2n+xRzQZBAzWT1o5z+6Ph6AgOj5ai1AFCXz9v5Fdu+2Vcna5PESJjsFYV3A6LJi
c1GSBO0HvGbqkpd6iAIW25Xfnfjcw3KRKpqpDWt42zVDfs3Ykz8I20WBFD8kT3XK
6AXx3UIWgElO8sH6NaYA5yabViZQwkvhWIGtdZBtkkQcvJivLiC7Hljzh8E4Wx5c
LoCsPH391iFazjuP6skHZslHq3jdMKoogj6BwowUJuM2hcMuhdjC/Co1JAsyHwqa
GO2FnFsrR3Ns2YFACMGqmic4GWgbUKvoKnJ/wZAOKPfsWIoUBPwm1WiUu+87MWa8
Z1l/zI+K5nDh2GjsmLn5KdvJBpQzJAMRf1KNcLj0dbwQzVqAHJo=
=pK+/
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
