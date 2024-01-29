Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479C605CC
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528930; cv=none; b=tQJAmeLYCU5VU1m+3gSQro6J+tjBzXjYTHEPoBJ8mdfeNG/J5qP8mYUJFmtcIKc8n2FxOAaJpLZraakFOm6eFOaaaOmmJp5Ga7ICTtaeqKaViRYylCJDniROOLYEu8cyQFfT942K2lNWOKQ9OgN+UctlrtlQ/FoO2ILCAvu7qm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528930; c=relaxed/simple;
	bh=S4IhB+C7KypkrUkxnlJv3ZXrFjgj01Pqk4+rDBIRj/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzyK65mCyfuRjsNKpo6f9VLDfG4Ijt15bVNpf7CTVibWv53CF0pVrTGaEEP6jgpl5/fkD0uscBj/tK1jEqf2mZUaMSLm67MgeabL1WAF0kIakn9jQEK5XZ6m+HDCE4k1vq9jdGM7K0owV2RvDMoJnzkWQ6eQKC4XkMdPn0FnbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h8zj+qqx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZazQGww; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h8zj+qqx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZazQGww"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 537AA1380095;
	Mon, 29 Jan 2024 06:48:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 06:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706528927; x=1706615327; bh=7lINtlbyyH
	+9C4BwcW+nTNI/KSNXIazIZRzV9Unv6RM=; b=h8zj+qqx0+oG9ll0DRS+sAKmqY
	dVFD98OTFYuC6RoXW6aJG9rUudJNblbz0QarBMZFOHKMQjtJSqgz1XiD4kNSRwtD
	X9Z0rD3UeOKpQS+UGI7o/3g0AI2O/XvglLOKrgp4Lrc8OqnGrhLq7Vw0ORGUixZg
	hZpCLWw1+dDg0htzQXIiK06vx2btUxvvJqDdQ4vByKBnXWincb+HJu1tosfShXqj
	obSehx0aJF8O1kHq8lakxfcOIlhZB5GIzJ0xXf+OsoU6vhBQHbAdmAl70Ycmox14
	yTpBraLaAEhAI2f1jL4qssw1Mndettk0UdOC2eVWfWgb9sRNqUqB7pgh5sag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706528927; x=1706615327; bh=7lINtlbyyH+9C4BwcW+nTNI/KSNX
	IazIZRzV9Unv6RM=; b=lZazQGwwcylwa9oi9G9ZBdOmF6I64g1vtdnUJi90F36y
	vAwyM0sdZkS7qPmhn3fLRYd3NgQNvtskVaMWNwrPhwXtFwszld+QT8CPoyui/Ngo
	ZpzTmeJQSkgmFnX/saXdcvNGWbEO3yy0a76ntKsMlPw/nDKggaSXXTgB6Kk5IAtb
	7JueCbp7nYOvFvCljsxAJlR90mHw/iP1L+pWZdQ4uVye5CYPwrppE7P/y2H2O2Db
	FFfIKh5RrmJ2/Zf6ZvhsoLbwOTK6+gPJSfoG55moSgES4cPW14S7DWrjssS3SxoK
	cBdXsgN/ioJWDZP2AZ5x5x9+z1JuyqznPZZ5gvj9/w==
X-ME-Sender: <xms:n5C3ZUrb64lzWcXvriCvzBuiDdtEDi6ldz0bAEuGZft1_Y1vpUjB_g>
    <xme:n5C3Zar2njyEZecJEw0ye1BZvKxlGYUwlDIgyJ0_F2wwLITpqOJ0Ngj0h4f_edqql
    AMoqe2aVfBTsRHkvg>
X-ME-Received: <xmr:n5C3ZZMaZGmkWOOW8bFE5gf7mXrZXxrjye3YEISeWLVkHHd-pyWeyAIwc01-Bjni5s-tInpe_3Tlqj9mNkZcoIktk1uzQwlmLXXqTOp3RtxMFEJrPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:n5C3Zb7O5g2stmQGMHO5W65954usB0jAsveOW2WPd02f5Ptz4KsjoQ>
    <xmx:n5C3ZT5_cOATdamBNrJ99WoTw66vuAIds7JQEfjIiV5guNtLrfw82w>
    <xmx:n5C3Zbh9RjRZmZEsWd7gdiigC_4XduNfs_7PqVfDpkP-FXjfSDY4bg>
    <xmx:n5C3ZTH2SHCQJxxUR5wbfL3xw2I47j0mjBQmdp7TRjyaWP-X6aRDyQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:48:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3de862a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:45:28 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:48:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] add-patch: compare object id instead of literal
 string
Message-ID: <ZbeQmv_KcChtrPqJ@tanuki>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240128181202.986753-3-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E4R5rTMCVuIZiYxN"
Content-Disposition: inline
In-Reply-To: <20240128181202.986753-3-shyamthakkar001@gmail.com>


--E4R5rTMCVuIZiYxN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 11:41:22PM +0530, Ghanshyam Thakkar wrote:

We typically start commit messages with an explanation of what the
actual problem is that the commit is trying to solve. This helps to set
the stage for any reviewers so that they know why you're doing changes
in the first place.

> Add a new function reveq(), which takes repository struct and two revision
> strings as arguments and returns 0 if the revisions point to the same
> object. Passing a rev which does not point to an object is considered
> undefined behavior as the underlying function memcmp() will be called
> with NULL hash strings.
>=20
> Subsequently, replace literal string comparison to HEAD in run_add_p()
> with reveq() to handle more ways of saying HEAD (such as '@' or '$branch'
> where $branch points to same commit as HEAD). This addresses the
> NEEDSWORK comment in run_add_p().
>=20
> However, in ADD_P_RESET mode keep string comparison in logical OR with
> reveq() to handle unborn HEAD.
>=20
> As for the behavior change, with this patch applied if the given
> revision points to the same object as HEAD, the patch mode will be set to
> patch_mode_(reset,checkout,worktree)_head instead of
> patch_mode_(...)_nothead. That is equivalent of not setting -R flag in
> diff-index, which would have been otherwise set before this patch.
> However, when given same set of inputs, the actual outcome is same as
> before this patch. Therefore, this does not affect any automated scripts.

So this is the closest to an actual description of what your goal is.
But it doesn't say why that is a good idea, it only explains the change
in behaviour.

I think the best thing to do would be to give a sequence of Git commands
that demonstrate the problem that you are trying to solve. This would
help the reader gain a high-level understanding of what you propose to
change.

> Also, add testcases to check the similarity of result between different
> ways of saying HEAD.
>=20
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> Should the return values of repo_get_oid() be checked in reveq()? As
> reveq() is not a global function and is only used in run_add_p(), the
> validity of revisions is already checked beforehand by builtin/checkout.c
> and builtin/reset.c before the call to run_add_p().
>=20
>  add-patch.c               | 28 +++++++++++++++-------
>  t/t2016-checkout-patch.sh | 50 +++++++++++++++++++++++----------------
>  t/t2071-restore-patch.sh  | 21 ++++++++++------
>  t/t7105-reset-patch.sh    | 14 +++++++++++
>  4 files changed, 77 insertions(+), 36 deletions(-)
>=20
> diff --git a/add-patch.c b/add-patch.c
> index 79eda168eb..01eb71d90e 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -14,6 +14,7 @@
>  #include "color.h"
>  #include "compat/terminal.h"
>  #include "prompt.h"
> +#include "hash.h"
> =20
>  enum prompt_mode_type {
>  	PROMPT_MODE_CHANGE =3D 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
> @@ -316,6 +317,18 @@ static void setup_child_process(struct add_p_state *=
s,
>  		     INDEX_ENVIRONMENT "=3D%s", s->s.r->index_file);
>  }
> =20
> +// Check if two revisions point to the same object. Passing a rev which =
does not
> +// point to an object is undefined behavior.

We only use `/* */`-style comments in the Git codebase.

> +static inline int reveq(struct repository *r, const char *rev1,
> +			const char *rev2)
> +{
> +	struct object_id oid_rev1, oid_rev2;
> +	repo_get_oid(r, rev1, &oid_rev1);
> +	repo_get_oid(r, rev2, &oid_rev2);
> +
> +	return !oideq(&oid_rev1, &oid_rev2);
> +}

I don't think it's a good idea to allow for undefined behaviour here.
While more tedious for the caller, I think it's preferable to handle the
case correctly where revisions don't resolve, e.g. by returning `-1` in
case either of the revisions does not resolve.

Patrick

--E4R5rTMCVuIZiYxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3kJkACgkQVbJhu7ck
PpTOtRAAkYroyOLO+WY3lbySIAbmzn3ft9nMqR+nKwR5UllKmtk56phgTYJh+i9M
UGXcOwdwyLhRgTlYytUVQdU/zLWWG7DsiagH8gxC5d+FuDiRitnMpEtntn4ak8r8
/DSRdW6N8vgd2aTj52ZpmjTOQJqx68LphRcFEgg0RsYxZGqnuSnYUjbb/R+gzVOP
YYP6ngHCB1Y2xJdQaKF6S0NRHjiQRJBA94+KNqQAKxYCN3BktqPPJ9HW6bM9ODHi
+RfIoxmRM8Am53WSks368a2q3IidbuW5bKcLU2IRu0BGjMJ52r/gymOVi8rYEily
DquU1Mem46ZRKJBRurlYqNHkAyMkkxIB8alKLkfnuSpyrJRRI2Fw4al6c+9+spCd
cS7pYffdqlMfz/xVLV+sSqJchJhnTYyt0wQj96NOBpLIF6m8xhGBOviHbJHf1NwP
jZ3oHECd36HMCldJ4TqR/7Tq+94rqfWWT8suDr5WGsC4JqKITcgPBWG9uJZFMGOc
4JvPnuLSBYAUv5lDzr5w2uyzw8sr52JDcNufEq6LGv1Sl49p5WeMWYhljI00coGn
IKuFIoQ8o96D19ND/MlnEyY01g+oKq/2ZkVPBtZx5cZEm9h+bhRuk4nfYS1hcctN
dXrKvttI5Fbtr5N47u+t34Cc8UxUxjRoiKhAP99/ZWsVdZCTVBM=
=D51I
-----END PGP SIGNATURE-----

--E4R5rTMCVuIZiYxN--
