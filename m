Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5754EB27
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671572; cv=none; b=ZsD5hApPhrkojq6a7wfBDIJDyWYz9qY1OlvWhGSHDeZFcryqSTdJfM/dY3LhGG4sFvoJm79Br74M/hoq/GD2BqUUd8ze6Fh5idQgOOXcf06lUzo61zV9Sapu9lq7fUFpiAP+wN+opnLom/gBw7VOyPzalUtHMrzHFHokXaolYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671572; c=relaxed/simple;
	bh=jLEyehC1Dn5jAQfPWtqVP/eHhYSwKT+x2FxhEMY9KX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEDpbstIVBuTNlC3dc9+b6r6jFJzpvVIhSmt4HNycghs+qv9BweB96UFdrlpqjCXQ0WIt0fGZ3gnDRUM06xO6JeMwVsatuWikycZiiKY7O2+5LLkYwMDTgzL0XF7BDjZ8eWzK/0fdWA5Ng/uVXwVU62sLbKxOvnSCgAbt5/k1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O+Bg3u+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WctNb9C3; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O+Bg3u+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WctNb9C3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8F3BD3200AF9;
	Fri, 19 Jan 2024 08:39:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 19 Jan 2024 08:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705671569; x=1705757969; bh=p9pPzNI+aB
	iev7CV/2Pv0eVowSSrt+AtASSBY8jj23Q=; b=O+Bg3u+en3WIwC9bEXZe/iAI20
	Kgak8yB5IJOn3tWtqq1uNMpIuVsKfaVcthLAaPYQozSM3Fxuch3Gpu4AGz2ZsNyw
	4QPhZh/yMkoixXh4fmr3jr+LLSpbYYm9IfyIbOcNodCzI+4yt0SJ2Urnnl+GgCRM
	RsLu+gBdgFmm0P98iHc6+6W/IMqaKGNS/b0ac0hE5rPwu2YBB//RK9gBzH+wDvSC
	8T3slUIcR9lLOR47uZoSGdRsbwkK4VxXx5pssUdW2oCilybiw/kSNd3JzHaVK4Ne
	4Nc1cIUjlIzej9EEd/Ajmt2XoEmCIbSUqkYMGkKO9BJM+VcQ0sBClb9kwVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705671569; x=1705757969; bh=p9pPzNI+aBiev7CV/2Pv0eVowSSr
	t+AtASSBY8jj23Q=; b=WctNb9C305+lmYEil5qoHeal+6tew/jOpdpt3ltuvMl3
	K1IahSW0IM4DVEIr0kuXWWU2O/0VSX/9Gy/3HIzgL7RZyoYxJj+nFJJq0kJNOQex
	1m+z1V0hFuEUov9S6+sA4eCOJshCDdZydFZU793V45xic8NPGcrDaX2n01IcMTqf
	VWqEkRjfer633x1ezfS73v50RGHgE7O41aubbOVCvJJ4BV0pT8YpKq7QFcvaypN1
	jA1hx5aSFctWiRsL0FAZREl4krUlxfKt+Li9VEI6y/IQf4eUe/GlElbydjcg9YLU
	TnSixRNtTq6FD3RyAk/Sl72sLu4LSadBKnjLIq6O7A==
X-ME-Sender: <xms:kHuqZTllgw18J96RBXdMF5pB5gAap8NKJHtVukW6uqRxiM3ySWqRYA>
    <xme:kHuqZW1rZdTMBLdjVKTOUBW0FUllwYqWlP2r3u16pDJW3xOhJaI2BMQOi6Ov579N4
    Bq0outiSfpAv-D6nQ>
X-ME-Received: <xmr:kHuqZZoDjxOiQEPeRRJgB0M0UqBbH69WQIFAr6C2cg-J4V91s9uxKcc4s9yQi56glaQTe6zp1a3XGM24IYQA-Vz565hu_2pqW7I1-kpQ5gKNKmbqlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kHuqZblQ_PN2WqAlTb_eJ2UbQhUMYMgwaUdpGI2rlXz-xW6GGs7cLA>
    <xmx:kHuqZR1ZxKf8GCBQ_-KVPNfayfE9ziOSGYbC2qRLmktd8-lqMkq_vA>
    <xmx:kHuqZaubTKQqRmk7xhG3HItKqdgmtDtBDY8JzGBOFbF28rDjnUsjyg>
    <xmx:kXuqZS9avdZMEXwEoxSLUY2RTx_R1KEIsTP_xONp98Yxn81MFKte9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 08:39:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb04da35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 13:36:29 +0000 (UTC)
Date: Fri, 19 Jan 2024 14:39:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 10/12] t3903: move reffiles specific tests to t0600
Message-ID: <Zap7jfZlwlm-UZ1X@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <56a9c8f20dd7c8f3e9401b2bd3929fb9c53c7d27.1705521155.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IyTRVP5GW3AOFVr/"
Content-Disposition: inline
In-Reply-To: <56a9c8f20dd7c8f3e9401b2bd3929fb9c53c7d27.1705521155.git.gitgitgadget@gmail.com>


--IyTRVP5GW3AOFVr/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:52:33PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> Move this test into t0600 with other reffiles specific tests since it
> modifies reflog refs manually and thus is specific to the reffiles
> backend.
>=20
> This change also consolidates setup_stash() into test-lib-functions.sh
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t0600-reffiles-backend.sh | 27 +++++++++++++++++++++++
>  t/t3903-stash.sh            | 43 -------------------------------------
>  t/test-lib-functions.sh     | 16 ++++++++++++++
>  3 files changed, 43 insertions(+), 43 deletions(-)
>=20
> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index 704b73fdc54..bee61b2d19d 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -527,4 +527,31 @@ test_expect_success SYMLINKS 'ref resolution not con=
fused by broken symlinks' '
>         test_must_fail git rev-parse --verify broken
>  '
> =20
> +test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +		setup_stash
> +	) &&
> +	echo 9 >repo/file &&
> +
> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
> +	git -C repo stash &&
> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
> +
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $old_oid
> +	$old_oid $new_oid
> +	EOF
> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	test_cmp expect actual &&
> +
> +	git -C repo stash drop stash@{1} &&
> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
> +	cat >expect <<-EOF &&
> +	$(test_oid zero) $new_oid
> +	EOF
> +	test_cmp expect actual
> +'

I think that there is no need to make this backend-specific. What we're
testing here is that `git stash drop` is able to drop the latest reflog
entry. The calls to cut(1) are only used to verify that the contents of
the reflog entry look as expected while only verifying the old and new
object IDs.

So how about below patch to make it generic instead?

Patrick

-- >8 --

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 34faeac3f1..3319240515 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -200,7 +200,7 @@ test_expect_success 'drop stash reflog updates refs/sta=
sh' '
 	test_cmp expect actual
 '
=20
-test_expect_success REFFILES 'drop stash reflog updates refs/stash with re=
write' '
+test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
 	git init repo &&
 	(
 		cd repo &&
@@ -213,16 +213,16 @@ test_expect_success REFFILES 'drop stash reflog updat=
es refs/stash with rewrite'
 	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
=20
 	cat >expect <<-EOF &&
-	$(test_oid zero) $old_oid
-	$old_oid $new_oid
+	$new_oid
+	$old_oid
 	EOF
-	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	git -C repo reflog show refs/stash --format=3D%H >actual &&
 	test_cmp expect actual &&
=20
 	git -C repo stash drop stash@{1} &&
-	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	git -C repo reflog show refs/stash --format=3D%H >actual &&
 	cat >expect <<-EOF &&
-	$(test_oid zero) $new_oid
+	$new_oid
 	EOF
 	test_cmp expect actual
 '

--IyTRVP5GW3AOFVr/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqe4wACgkQVbJhu7ck
PpTKYRAAlQx3zF4KIMK73IypMOfQKBz1fXlV3TgMdFY1dczwcICPNDkRnU6kkU6y
6RjAsa/QYMea09zgWHpW/vKPpD9CfbZsqI56LbXr7x3yccwawArLQI9ES6C1XyiJ
zR5auw1w7NTGlAP14SCNnsMdB76rEEcfwZ7fKV9o8Ac6zrTToeYkxQxDLKVviuxz
5IBadeMqH9H/AzEjNK16gYi2B/XB0W1wS+FbyLVnlOLrxSpWS5O838EmgjTjkofk
8ayPn368BC7qS2Loq36HhtF/ah9XVe8BU5T1X3MoMoll7v9kHqVVMSHG7VXnfdNu
eQ5m475xP4VZ/zphO2ayPbtFWSPefuTPOMJwkLJiaUJNcw4N8PdZukzaYvytSUUr
ZDCzSnqts2H7xWDkkC3J+QRyynXyrwCQ/qdRE21Fv5M1WIVVaNaU42xz0bNipQ3Q
ZP9GX6ndTYD+9UjbG1ym+V2u+ZCcdrQG123S4EyfllfGaEUDXu2dc+vLYs55sQH8
bW/2HsHpXtXcqkoxP3KxRwhabZPFhFxq69Nw3+7W6PRcx5MjV9isSH5DNzUvKmf6
tSyBbcfK/jkEQ5WsvtmPjrhWw9gePJCOXMvLM8+hP835GTWqqmgJYSJ8U6CijrX8
g5uh/g9R0fLXsJBPhfJkmVjiCl47VxZluIYdAS1YMVG9Yfts5Qk=
=Jl3t
-----END PGP SIGNATURE-----

--IyTRVP5GW3AOFVr/--
