Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428A524D6
	for <git@vger.kernel.org>; Tue, 21 May 2024 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278294; cv=none; b=kl92hchfDJDm0vrXoNinvJPaMbLhKy1I7Rm1EwrQgjwL3pw7PJ6ukd8efu9jjA6sviFGbYXI+ZLkAfOJGYh4L+fwABW269RwVOlVWLep4NVBUAo4DlVanppWxx6vuys87r7GC4X4L2FGKbE3DgTf6kNSTUKryCfV4p7p7UOzsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278294; c=relaxed/simple;
	bh=wsJWk8/kttZ9Ynh061WAQNEgKTZhwC2bbsyi14m9VSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POfKvE57R8ONWS78de2/QnDTsmwlptF9uG6pyJzwwe4AWu/meEbpmEU995c7oemhtpy4FQrSxetpPNFl+YK9WZGbMXTKLb8QGk17/CIDN98yeZckd7Gfpg3aN41GewXUmak9SCPFzdzFoXTxPyfUth8JkflTmzKAUNEyBLlu9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ot4ooEpo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcyDkM/d; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ot4ooEpo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcyDkM/d"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EBC2E1381493;
	Tue, 21 May 2024 03:58:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 May 2024 03:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716278291; x=1716364691; bh=lubH0oVYQg
	YBLIcxjf+ZcjShE2sgQmgHD5Yaw3LQv+o=; b=ot4ooEpon/Qu3Ez9Dz+aEOw0+C
	YNHAXXHJpeeHlnYF6uL/LTcsZg/o7o05pWvgPcJTwIqPoeiCFUKaQ11E9tS7uVM4
	zEDcEKOgBvHoZg3fepRgytcofqsEHxsxTdgLRpgIqhRm0yTJZ2VMoyLIlbIeMIz6
	orkUDTzTAv8n0zjfvdnrTrFCo8chZAO8qy8z49m43FRo9Ym1c+GAYhyz/v4GJTi5
	bpgSRhfvgIr5BR35S4y7/vNNbj6RgJ7Yfs7HtCGR7vTuFMOrsaERigcReoQ6/m7L
	iXkyY/oYf65ff9VL6zAo2FhSga3Jml/LRT96mg8bEh9DKreLp91B+sKIz8Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716278291; x=1716364691; bh=lubH0oVYQgYBLIcxjf+ZcjShE2sg
	QmgHD5Yaw3LQv+o=; b=QcyDkM/dpcZ+7yspJK3rFDWniRl1zWavKkPeg+VIwSSP
	Op7pXT7BqO3LlXRKENP/Wg+tL3IOgTJx63aiklebf3oVc1WC4oPXUWiqE38ib9YU
	JR7Q9R3b56SRF28lTb4FJF2iFwF+hWNO3GO6d5YtEV9a4W9ZsSmAEh5HrMDNkYXn
	id2yo3W8rlN6eBOz0A3HRIs75EF4N3Jj0ate9f4ILzYhuDZcLvNbw2umFxpvQK+K
	0teYD8jVHitBBNRYUg3tyApZL9RW7XbmbTSOebLqQ20K/AEl18SYoTr3fvYdQtQR
	IGrlO21i0NvHHA4jB4b2Ey847dSS85zMmoUBVQ8dGQ==
X-ME-Sender: <xms:E1RMZqFhe078MdTQynQbti17mjE1szQYVseFxidXOsi3Rfhia2n7MQ>
    <xme:E1RMZrVToSoAEnlFcqIDYwoqHAKYRtI-nJkPjFtHRCs-0w6PUKvB6uHoeR2MMiIcH
    AXuGvbenZvxZ7HlRQ>
X-ME-Received: <xmr:E1RMZkKaITC42qqgL_Xtsrxwlb7XsnUm3eRSuCCp6d_07p-pUoNudxzAESjQItbBxvQS0drv9G-ZvBroJd6oNvrrjWCWqyG4Dl5XSbMyi_F-JGNF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:E1RMZkFmoWTTkIdain1Bd35NRdhG2k9iUSjgjB7iF_BsUOV5weo8rA>
    <xmx:E1RMZgW0xrio-QFVYdUmNjOukQtz9mS7l0HVL9zwOxXfiTdkolj1bg>
    <xmx:E1RMZnPA2f2OaodgnWjbWY22ZUFO2J0N6NyjT8ZOTkV9GEvoVIETng>
    <xmx:E1RMZn3UP0_tcjpyE12Q4xieMSsTBgc8rTzMFF80AGcxCLhnQ5GMww>
    <xmx:E1RMZthc8BfA7eUAdBDqD2Qs3BqaI0Oo1yQxbfmj0gqV4XhMPgfN60eV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 03:58:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4578a3ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 07:58:08 +0000 (UTC)
Date: Tue, 21 May 2024 09:58:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 5/5] apply: fix uninitialized hash function
Message-ID: <ZkxUEP7HifEVlDZY@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
 <20240520231434.1816979-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3NXsvz/VfWsIJ8l"
Content-Disposition: inline
In-Reply-To: <20240520231434.1816979-6-gitster@pobox.com>


--j3NXsvz/VfWsIJ8l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 04:14:34PM -0700, Junio C Hamano wrote:
> "git apply" can work outside a repository as a better "GNU patch",
> but when it does so, it still assumed that it can access
> the_hash_algo, which is no longer true in the new world order.
>=20
> Make sure we explicitly fall back to SHA-1 algorithm for backward
> compatibility.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/apply.c         | 4 ++++
>  t/t1517-outside-repo.sh | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 861a01910c..e9175f820f 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1,6 +1,7 @@
>  #include "builtin.h"
>  #include "gettext.h"
>  #include "repository.h"
> +#include "hash.h"
>  #include "apply.h"
> =20
>  static const char * const apply_usage[] =3D {
> @@ -18,6 +19,9 @@ int cmd_apply(int argc, const char **argv, const char *=
prefix)
>  	if (init_apply_state(&state, the_repository, prefix))
>  		exit(128);
> =20
> +	if (!the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +

Do we also want to add a comment here that mentions that we may want to
make this configureable via a command line option, like we have in the
preceding commits?

Patrick

>  	argc =3D apply_parse_options(argc, argv,
>  				   &state, &force_apply, &options,
>  				   apply_usage);
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 2d8982d61a..557808ffa7 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -37,7 +37,7 @@ test_expect_success 'hash-object outside repository (us=
es SHA-1)' '
>  	test_cmp hash.expect hash.actual
>  '
> =20
> -test_expect_failure 'apply a patch outside repository' '
> +test_expect_success 'apply a patch outside repository' '
>  	(
>  		cd non-repo &&
>  		cp ../nums.old nums &&
> --=20
> 2.45.1-216-g4365c6fcf9
>=20
>=20

--j3NXsvz/VfWsIJ8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMVA8ACgkQVbJhu7ck
PpRyzRAAl6c5hjiCxflrw0shZRxdlh/funw8HeKWtWbMbRY6DbxdvN2ECKWTpKG5
pmlTpbxf1BX7kw30/P90GPOoJOgFAhHRYHocVHqIXVSeeaP4MbClTXhyJLNHWhAn
X/9v+xuR+s0ed3mEo1Ysp5hEKz8KWwjsofqdCAlopsBJ9oAFEbGA7bPD5nJ0kiQv
DF+rAwciasDMpZaJT0VNyPDMgNpFjeOTl9FQvaNBy1Gef7IqL5q0kcVErBhVQoij
j2kqCyfEbiZ+O/NQN5b0Y4WsPdljThgrqU4MXqRQlybJLTsj9zF3re1Q2xiSFjgo
Y6314GxIWb79j5PJFtinn/4Ln2Iaht6jueN87gHaRmyX0nDpjigPFrUudlHvgYip
2bK88nAlsyvSfB45a6sgJ10WX9ZW0uLNr5b6JnqjFd/ksdJIKfVjNRCUpFeJngl4
YeACAUkpsGe1Rd+PU0bqv9l5/8uuUh+016VJH64iYuUM5DKevRIqToW0sLTNsQe1
NVviHRwEuDRYgsVBW+m/nbzPQGXTbzSNDEHIraCGP4VkHVEy1Z35hVUgBpCs9psW
TIVLLptUBjrbQX1IrW+jR3EHK1vplVpNr6v0WwOrCHrJGUnE1wto9xOLnapSHCee
X3jaLIKKsUBCp45c82rkiEEBxzvV8K8q1KDoEnRWOcKW6J6z63k=
=S9BL
-----END PGP SIGNATURE-----

--j3NXsvz/VfWsIJ8l--
