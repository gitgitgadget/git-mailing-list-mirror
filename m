Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1508B669
	for <git@vger.kernel.org>; Fri, 17 May 2024 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922060; cv=none; b=onmSAKotXUqFXdCobxs8MJIpMhMtvdvzZvRNtLAnnTW7B0PlsA1QwO6MKxHTOZxMWNyaF6knFOefZ0/A4+IwCmEHZGmG5nsJ3BZVpFlEGa+IhkKRYGlV27QPi8FeEsDJHNMgSYfhMibCs1vuCV2JcGl+JfCIVmCY7/8FkRk5GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922060; c=relaxed/simple;
	bh=eAWMOs3aMgE8bJ1Chonpa6IVVmS0dIZ3slo6TebFJQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcgWzEwsbL9CJPgoTQdAEG1uYSHtPt8rLGWxd+EKqQXBwJyt3p5oxEuwrIH2HQCCO4Dyox4B4kaaeOj+wVyyaRivgtagk5DNtZNps7LJIfZBc1ZqMUZNlAvMjS8yyQR4Gg1ZPZDaKdky74tY1fnWHGJormVpxdZTyH/dCTzxEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mGskiu9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSA1G3fW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mGskiu9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSA1G3fW"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A712513814FA;
	Fri, 17 May 2024 01:00:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 17 May 2024 01:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715922055; x=1716008455; bh=+dVGvAzl8M
	mTEUHC1aSo7xVuS+W1heiCfR6+KNuF2lg=; b=mGskiu9dPmZtfp+zhaq52CpeeQ
	EPh4VkZ8KpUBJOFpTnZmxzTg4kIAM6nY3Qlx6YjqzA6v8Qkh/X04odMF31Jpg0zT
	QpPP49n9dMyzWg727F97CC4ZPFkywzkToQvB/qAo635iQCeITVFtIkjYgffKFm0G
	Q9rJ2S3GhmFLmCf5l+iVJS2Up1jPApPIxWwY/pquypWIePRMh9Ikhrzyx0bqE53O
	R/lpMmdNKcobp9DLPvjR1WhMswvxUstzONXf0zP7PV7+oKmhT6A4x+9ZyTSiKmcQ
	4rKGZVtSqbqUBLK4k5ssCEIRI04HSoWEQGA3/gM3pLzpyUJTKQ6lwlsf9Dkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715922055; x=1716008455; bh=+dVGvAzl8MmTEUHC1aSo7xVuS+W1
	heiCfR6+KNuF2lg=; b=XSA1G3fWdHeLIxnhbNtFC6dajGmP5vV0hVvPvfmrlDN6
	HQyCMeWvNnhSHR1yEkm5+j77XCFwHPoDirzXWpdwl6VAPMyoClJH7OH70khkxZGl
	vzIjTK2pr6lXy2KqBhC1mZ8P7XYUBk4+GuM10vAOdQbmTzVU9fN8tNwfzl8O+UJx
	CcA59rSCMUoohEA4z9JjLqjSU1XGrJWhh2zaXW6dYFjo8ITHqtAmURKPsNpS+o7s
	367Pd/srKReVSmrx4646F4Kslg8OIrCUc9fQu/9mIDuVkPl/B0Phb+41uhBVUeMo
	4y0l2TegGwJeiiol3DjCZoZg6Dw40f18V8tbvzg6/g==
X-ME-Sender: <xms:huRGZvonDAEGnvJCZQ6IMbtLjHzwck0beEl3cnjPVqmgHfdZ2nwhug>
    <xme:huRGZpq9hUy9kA9Lg74EzUHQ-CZOy0rcvotuXEemQ4DVKfmJUknj_nx1krKm_mXGC
    or0nq9pA4E5eURTEQ>
X-ME-Received: <xmr:huRGZsNuogpnXUiHyQJb25oNd-Ss4L0u-loWKMk0FkSXDb37f_8l6Yec32ToHpMAucu-sQG3DVUitv-mdg_cHk5vKCc62VezcAXtOmjM_c4KqpudFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:huRGZi7HU_EeYfMae_jC6iz2ObZp0aRXKzcjw8RFlh8-AYjnLWHpdg>
    <xmx:huRGZu7mSsQVs9xolJPE7RpYaINmcZPwTrzsqCauqIUpejaTbDZD5w>
    <xmx:huRGZqjDrKeWHab4TJDOdBsxgoz3C-kau6JlmXa_6vnSAFm9g5z2DQ>
    <xmx:huRGZg7Q1R3BGknXSfKwuUAd0Y8r4_l5sBB6WAmIrRlgyy3fYIIzMw>
    <xmx:h-RGZp0SwL0ILiKWWqNA7jY5nHoLgaZoBVTumXQvSJ28ML3ey22xfbSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 01:00:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9f67a83c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 05:00:24 +0000 (UTC)
Date: Fri, 17 May 2024 07:00:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] bundle-uri: refresh packed_git if unbundle succeed
Message-ID: <ZkbkgT46mdNEhcf0@tanuki>
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xXnTSPHJRk1ILySl"
Content-Disposition: inline
In-Reply-To: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>


--xXnTSPHJRk1ILySl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 03:01:09AM +0000, blanet via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>

Long time no see :)

> When using the bundle-uri mechanism with a bundle list containing
> multiple interrelated bundles, we encountered a bug where tips from
> downloaded bundles were not being discovered, resulting in rather slow
> clones. This was particularly problematic when employing the heuristic
> `creationTokens`.
>=20
> And this is easy to reproduce. Suppose we have a repository with a
> single branch `main` pointing to commit `A`, firstly we create a base
> bundle with
>=20
>   git bundle create base.bundle main
>=20
> Then let's add a new commit `B` on top of `A`, so that an incremental
> bundle for `main` can be created with
>=20
>   git bundle create incr.bundle A..main
>=20
> Now we can generate a bundle list with the following content:
>=20
>   [bundle]
>       version =3D 1
>       mode =3D all
>       heuristic =3D creationToken
>=20
>   [bundle "base"]
>       uri =3D base.bundle
>       creationToken =3D 1
>=20
>   [bundle "incr"]
>       uri =3D incr.bundle
>       creationToken =3D 2
>=20
> A fresh clone with the bundle list above would give the expected
> `refs/bundles/main` pointing at `B` in new repository, in other words we
> already had everything locally from the bundles, but git would still
> download everything from server as if we got nothing.
>=20
> So why the `refs/bundles/main` is not discovered? After some digging I
> found that:
>=20
> 1. when unbundling a downloaded bundle, a `verify_bundle` is called to
>    check its prerequisites if any. The verify procedure would find oids
>    so `packed_git` is initialized.
>=20
> 2. after unbundled all bundles, we would enter `do_fetch_pack_v2`,
>    during which `mark_complete_and_common_ref` and `mark_tips` would
>    find oids with `OBJECT_INFO_QUICK` flag set, so no new packs would be
>    enlisted if `packed_git` has already initialized in 1.

And I assume we do not want it to not use `OBJECT_INFO_QUICK`?

> Back to the example above, when unbunding `incr.bundle`, `base.pack` is
> enlisted to `packed_git` bacause of the prerequisites to verify. Then we
> can not find `B` for negotiation at a latter time bacause `B` exists in
> `incr.pack` which is not enlisted in `packed_git`.

Okay, the explanation feels sensible.

> This commit fixes this by adding a `reprepare_packed_git` call for every
> successfully unbundled bundle, which ensures to enlist all generated
> packs from bundle uri. And a set of negotiation related tests are added.

This makes me wonder though. Do we really need to call
`reprepare_packed_git()` once for every bundle, or can't we instead call
it once at the end once we have fetched all bundles? Reading on.

> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>     bundle-uri: refresh packed_git if unbundle succeed
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2F=
blanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blane=
t/xx/bundle-uri-bug-using-bundle-list-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1730
>=20
>  bundle-uri.c                |   3 +
>  t/t5558-clone-bundle-uri.sh | 129 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>=20
> diff --git a/bundle-uri.c b/bundle-uri.c
> index ca32050a78f..2b9d36cfd8e 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -7,6 +7,7 @@
>  #include "refs.h"
>  #include "run-command.h"
>  #include "hashmap.h"
> +#include "packfile.h"
>  #include "pkt-line.h"
>  #include "config.h"
>  #include "remote.h"
> @@ -376,6 +377,8 @@ static int unbundle_from_file(struct repository *r, c=
onst char *file)
>  			       VERIFY_BUNDLE_QUIET)))
>  		return 1;
> =20
> +	reprepare_packed_git(r);
> +

So what's hidden here is that `unbundle_from_file()` will also try to
access the bundle's refs right away. Surprisingly, we do so by calling
`refs_update_ref()` with `REF_SKIP_OID_VERIFICATION`, which has the
effect that we basically accept arbitrary object IDs here even if we do
not know those. That's why we didn't have to `reprepare_packed_git()`
before this change.

Now there are two conflicting thoughts here:

  - Either we can now drop `REF_SKIP_OID_VERIFICATION` as the object IDs
    should now be accessible.

  - Or we can avoid calling `reprepare_packed_git()` inside the loop and
    instead call it once after we have fetched all bundles.

The second one feels a bit like premature optimization to me. But the
first item does feel like it could help us to catch broken bundles
because we wouldn't end up creating refs for objects that neither we nor
the bundle have.

Patrick

--xXnTSPHJRk1ILySl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZG5HsACgkQVbJhu7ck
PpT+sA//drlZZZOvn1PD6dsfTJ0pmGXckh8xBzzumyImA0KhvutGatRia9Rr8bUz
IYaKsHjSwPPhZaCb8lVu0cerb+FE+7aUMrZDpzuLfURwjYmU0couwiO7MYeoK2Bh
gDkUEwLfVfqChzcBk7saMcYh6LDeXBbHlpJr5v1+5vT3zIaM7fubM/7LelCYY3ZT
GraWOWsGTt/zcniRq29fdoYPOnF/qTdp3HTShEJr5CTNHNiLrRyoodgJT7I0Cvqk
vSIAIngoDEQiiRtw0nHmNLOFSYyJyOuJ202zUCkVqvwZ51FJ/UWV02r8DuiSW/W6
CL0DSRJ9WPj6nLQpNA4utL4bZA9IyozoQ174swBXdT5WfBMVQ9pkCDaNhfBTJfCB
K5fW8ntg/hsDImFzM+9W5ZfjcL2FEBPrTyMXP6oHIcVCYGl9/6sy6nWDcN//Cgoe
E2213c0EjL7u3SQaCGUbs8HFR+uh+QU+RvCeV3s7lfKZsYo6ncWxu79W4l9gZTKR
wxqJYhfqqTcoHjeTkuLknjZ2A7LJyxWX7X5VKap1T/Axuy4FWi8QUOjCSdRDxphm
ERmcXQNK8lAMAa/gsQkm2G44gRjzIdQ5QcdJvTNectLfdZZ1IZAlSuqvwji9z6lU
pgoycNc0l6rd97b40LD/O9svrLdvkboo4KEgbUOw2HyyI+LjYXc=
=IrLa
-----END PGP SIGNATURE-----

--xXnTSPHJRk1ILySl--
