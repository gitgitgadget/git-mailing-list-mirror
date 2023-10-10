Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A4CCD68ED
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 07:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442434AbjJJHVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442419AbjJJHVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 03:21:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C69F
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 00:21:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BBC3E5C027F;
        Tue, 10 Oct 2023 03:21:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Oct 2023 03:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696922477; x=1697008877; bh=wc
        ji1nTXMBMPJywb/mfQYu8SBlCDsB0BzNuzF0ZfTu4=; b=fEZv78sBQexJOIFaJ9
        SXU5u2+T3iCT0RXYATO9p8jv3ZMlaq43slrggagaLb91/OwnTrEQhu+/qnNoyMyi
        X7A2gqRBJlcCpMdoHAh41psCJj49XqPMowuBWTUMtGHiCSgRyQoqS6valzh+8xx4
        m/s1RGNploN5iLiYZV6Q66FftMQmuz5A9qmcHIVy3rTivWCQmcryufmA3V41Zt5B
        L7gVxdLxqsFp9LZ3ULjE3pNg0w5DawYjdQUuFdkWb281/7yvGYmpY/oCEwon81a2
        N8ImiD7ovpI2yW1NmQjRI8Hy2D+5tlQw+Zt58O33yD8R0bgwtZ66/B+8xhT+APmo
        l/Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696922477; x=1697008877; bh=wcji1nTXMBMPJ
        ywb/mfQYu8SBlCDsB0BzNuzF0ZfTu4=; b=leAYKxkIoD7XeiXVL+0eQzP7MjlEN
        HZxxj5eix5+8pPYikvrpi4WrWl3t/JYFMneZq4n0aGCiNn7x+66TQOuQU0RSJt3c
        r6/00PxtDWZOIpUN6T2dz8+n1YtJTbgSDi/iQkb38YYG8jIJKur4p8lFIYSqLfbU
        htKeY7itQE2gZIQKsN0kjre7NdiRU1XbnRfe+7xN9qBGDHWQaFrE6CRLnfNgXil2
        BqyOpKO/qVy+otSGXNohmvSqX2coyzr1+lB/egBM6S2272/XkCx2tYEgCMwndCCe
        hQsIHGZzPXUhQQHmuW0cCt4UmKKquCaK6Cm0YmyjvYIJ8rP0M75UxZuug==
X-ME-Sender: <xms:bfskZdJ4wZltX_tNjoIbBVRoiupyDrvxpi8qlCH1jXGmlTnQa0WD2A>
    <xme:bfskZZI5ew8fbidruWxDRNd57i2r-o3ZJ8knZTE2Y_fqR-XQWKYCEBLVCnrvB4ndg
    tT6XB4eIzSrgSIJAg>
X-ME-Received: <xmr:bfskZVsHKfOAWVT5AJfYB4hPmTR__JeLR1qW6HsXniRx9akJOYQFUgvjG4TQZP-lVAPXWTJ8XlPbKKHqgFShjXr9l26AqtAR0kOdzN1N3o4kY5fl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheeggdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bfskZeZP21v4-qzeOvv4sGQTIAbU-WBAkDCZxvWwoR5f4O9j0a8pHQ>
    <xmx:bfskZUZtdX44u8lWLqthIeZbZ0T2djeBDVoo8ZAPWSWNm3h45pmLVA>
    <xmx:bfskZSAHm0lwEIiVH0H9vhK5BMRpvDvV1i6AuDfK0O5RUQPRIjAZ7Q>
    <xmx:bfskZfwxeo-od79Xg_y3rjRJq_uxGq06NcN56tjHdiPvDIYZ3wc2DA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 03:21:16 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 080b176a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Oct 2023 07:21:13 +0000 (UTC)
Date:   Tue, 10 Oct 2023 09:21:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 1/4] ref-cache.c: fix prefix matching in ref iteration
Message-ID: <ZST7aPwZrB5JR2Ig@tanuki>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
 <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
 <402176246ea9d722a71a0ca4e970dfce8a4bf776.1696888736.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UzPi22djLa+VDU7M"
Content-Disposition: inline
In-Reply-To: <402176246ea9d722a71a0ca4e970dfce8a4bf776.1696888736.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UzPi22djLa+VDU7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 09:58:53PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Update 'cache_ref_iterator_advance' to skip over refs that are not matched
> by the given prefix.
>=20
> Currently, a ref entry is considered "matched" if the entry name is fully
> contained within the prefix:
>=20
> * prefix: "refs/heads/v1"
> * entry: "refs/heads/v1.0"
>=20
> OR if the prefix is fully contained in the entry name:
>=20
> * prefix: "refs/heads/v1.0"
> * entry: "refs/heads/v1"
>=20
> The first case is always correct, but the second is only correct if the r=
ef
> cache entry is a directory, for example:
>=20
> * prefix: "refs/heads/example"
> * entry: "refs/heads/"
>=20
> Modify the logic in 'cache_ref_iterator_advance' to reflect these
> expectations:
>=20
> 1. If 'overlaps_prefix' returns 'PREFIX_EXCLUDES_DIR', then the prefix and
>    ref cache entry do not overlap at all. Skip this entry.
> 2. If 'overlaps_prefix' returns 'PREFIX_WITHIN_DIR', then the prefix matc=
hes
>    inside this entry if it is a directory. Skip if the entry is not a
>    directory, otherwise iterate over it.
> 3. Otherwise, 'overlaps_prefix' returned 'PREFIX_CONTAINS_DIR', indicating
>    that the cache entry (directory or not) is fully contained by or equal=
 to
>    the prefix. Iterate over this entry.
>=20
> Note that condition 2 relies on the names of directory entries having the
> appropriate trailing slash. The existing function documentation of
> 'create_dir_entry' explicitly calls out the trailing slash requirement, so
> this is a safe assumption to make.
>=20
> This bug generally doesn't have any user-facing impact, since it requires:
>=20
> 1. using a non-empty prefix without a trailing slash in an iteration like
>    'for_each_fullref_in',
> 2. the callback to said iteration not reapplying the original filter (as
>    for-each-ref does) to ensure unmatched refs are skipped, and
> 3. the repository having one or more refs that match part of, but not all
>    of, the prefix.
>=20
> However, there are some niche scenarios that meet those criteria
> (specifically, 'rev-parse --bisect' and '(log|show|shortlog) --bisect'). =
Add
> tests covering those cases to demonstrate the fix in this patch.
>=20
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  refs/ref-cache.c              |  3 ++-
>  t/t1500-rev-parse.sh          | 23 +++++++++++++++++++++++
>  t/t4205-log-pretty-formats.sh | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 2294c4564fb..6e3b725245c 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -412,7 +412,8 @@ static int cache_ref_iterator_advance(struct ref_iter=
ator *ref_iterator)
> =20
>  		if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR) {
>  			entry_prefix_state =3D overlaps_prefix(entry->name, iter->prefix);
> -			if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_DIR)
> +			if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_DIR ||
> +			    (entry_prefix_state =3D=3D PREFIX_WITHIN_DIR && !(entry->flag & R=
EF_DIR)))
>  				continue;
>  		} else {
>  			entry_prefix_state =3D level->prefix_state;
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 37ee5091b5c..3f9e7f62e45 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -264,4 +264,27 @@ test_expect_success 'rev-parse --since=3D unsqueezed=
 ordering' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'rev-parse --bisect includes bad, excludes good' '
> +	test_commit_bulk 6 &&
> +
> +	git update-ref refs/bisect/bad-1 HEAD~1 &&
> +	git update-ref refs/bisect/b HEAD~2 &&
> +	git update-ref refs/bisect/bad-3 HEAD~3 &&
> +	git update-ref refs/bisect/good-3 HEAD~3 &&
> +	git update-ref refs/bisect/bad-4 HEAD~4 &&
> +	git update-ref refs/bisect/go HEAD~4 &&
> +
> +	# Note: refs/bisect/b and refs/bisect/go should be ignored because they
> +	# do not match the refs/bisect/bad or refs/bisect/good prefixes.
> +	cat >expect <<-EOF &&
> +	refs/bisect/bad-1
> +	refs/bisect/bad-3
> +	refs/bisect/bad-4
> +	^refs/bisect/good-3
> +	EOF
> +
> +	git rev-parse --symbolic-full-name --bisect >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 16626e4fe96..62c7bfed5d7 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -956,6 +956,36 @@ test_expect_success '%S in git log --format works wi=
th other placeholders (part
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'setup more commits for %S with --bisect' '
> +	test_commit four &&
> +	test_commit five &&
> +
> +	head1=3D$(git rev-parse --verify HEAD~0) &&
> +	head2=3D$(git rev-parse --verify HEAD~1) &&
> +	head3=3D$(git rev-parse --verify HEAD~2) &&
> +	head4=3D$(git rev-parse --verify HEAD~3)
> +'
> +
> +test_expect_success '%S with --bisect labels commits with refs/bisect/ba=
d ref' '
> +	git update-ref refs/bisect/bad-$head1 $head1 &&
> +	git update-ref refs/bisect/go $head1 &&
> +	git update-ref refs/bisect/bad-$head2 $head2 &&
> +	git update-ref refs/bisect/b $head3 &&
> +	git update-ref refs/bisect/bad-$head4 $head4 &&
> +	git update-ref refs/bisect/good-$head4 $head4 &&
> +
> +	# We expect to see the range of commits betwee refs/bisect/good-$head4

Nit: s/betwee/between. Probably not worth rerolling this series only
because of this typo though.

Patrick

> +	# and refs/bisect/bad-$head1. The "source" ref is the nearest bisect ref
> +	# from which the commit is reachable.
> +	cat >expect <<-EOF &&
> +	$head1 refs/bisect/bad-$head1
> +	$head2 refs/bisect/bad-$head2
> +	$head3 refs/bisect/bad-$head2
> +	EOF
> +	git log --bisect --format=3D"%H %S" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'log --pretty=3Dreference' '
>  	git log --pretty=3D"tformat:%h (%s, %as)" >expect &&
>  	git log --pretty=3Dreference >actual &&
> --=20
> gitgitgadget
>=20

--UzPi22djLa+VDU7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUk+2cACgkQVbJhu7ck
PpROsA//fTFZKDpi1bSG2/ClWGYiHDO+QDp1/ZGSuFrf1RJHsGh8XFZzCx1xfr+z
ssNNBY0V+W27ESLg0HjeDDUuAkDKGduAQ+1/YqzMIoWQzXgswtIlwCwOe7tXwsUp
X5ZsxrUHm8blQ+BSJjSXVDW8ytfen8NPgWZ90mPZwUFMX+lb/XWA++3bgSkwlt+R
YWL5e/O9kKhAwa6DfzhT+iB2g/PO1iCPb6REF5WkjP6B36yXFpMXzH0BFCnSACqZ
fDeYfU3cb8QpxMmUo0r6HG1Ql51ZZtmKja1cD9oCaFLWrg7mofnoGcOlgEiwTKpZ
NpG1k0ialSGsJGXhS468r6JZntntExQdSlXNJP890YlIgoGD+TrDDRKXUkxKHgun
VYHt19sorE1AVUE1g+cehEJPvLrAJibTTSSFaXt8IhCjsP9xw4xK5w6WE961rkSu
IcOwdyjyEapL59XDSI+NDGPXockL2kA9zRjZfjx260M/t2+p3jPTw2+XrCox2QZE
U+PkVIBcIFUPyQtrPmstZ+MdaP5emlnQtQzTgwwOxczN5SxGGycKSIMqI3d08HRy
C4d02r4G5S96QiSZXob0F1G0VlXSGo0mhLDQGKdvCVfQ6xbZv2embZI2JzgA/gfm
9NXW9FeTblezpM+AptWVuU4DmG21Z+YQ6EdfvN6LtacZjUt7hkg=
=/zx/
-----END PGP SIGNATURE-----

--UzPi22djLa+VDU7M--
