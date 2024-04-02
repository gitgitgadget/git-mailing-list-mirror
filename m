Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D93A1CB
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042632; cv=none; b=KthpHvy+PFDborokUXiZt04YtDeZvKJLmxdXDAjIh0Pcjf+IpYBYKHPhVz5mVF6PHRLmtz+Q8Xo8UoQ/82c5pQv5MOe86sTS4Nd15kisc8MclBq2w718sRV3oWcsG6USM7/tI4fhJxbq+HjO9rSNZhm3WYQtydOcWRVH9ugx1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042632; c=relaxed/simple;
	bh=q41idXZuDhVCQ+cO0I3zZkiDZ8zzTqWPra8zXNL7kCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URC6JPDyO1jIRsfbE5maxIkWjMdMR0Z8/cqYS93MNRgNqy+ZDmAGxQbCms1Gym6uOM+SOpIOZI2hYTtrTPUPsdhEIUaLfOLWZlCUewftVF8j4HKQEyQgk4+DqvN8GbIZkFWnl4/mNuWggPdjymTMi8S8uiZcRCIAVmHlO8wtL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QcVp7MYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epS2FGK3; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QcVp7MYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epS2FGK3"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 27C901C00089;
	Tue,  2 Apr 2024 03:23:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 03:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712042628; x=1712129028; bh=VtahT/VGRi
	DrR4ceQgxH3ZxGXcRkTTFiYlYVlr35/Cc=; b=QcVp7MYvMtzyFtbJN6UPjp/qo9
	Fhjqo9KRDGLRgczUkKASQ5V2iiHj6QJ0ca8rHF10v0MNtxk7Qry8nwMA4fJKiSpx
	208O31+IZmQTgAvztTZFaVLOZm32iqhzukBwXj+XgAEDA0/vWcTB/6hx5wBS78pV
	xR589dSPIKc/jxpRUIqp9lYrQR0wM7YZOz+VurS++lV260T1KoJUuy2meALFpJcU
	DMiZWk3fOeD6aj47niRTvMweNuhQpzDjUAckuI7OJKoWqJPVMGB2VWjecG/CTarb
	v+l3tgGBo1EnidZRWe41jLfMJpicrR2ncyGw8dYHvePj8HijTyZZovNWMJ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712042628; x=1712129028; bh=VtahT/VGRiDrR4ceQgxH3ZxGXcRk
	TTFiYlYVlr35/Cc=; b=epS2FGK3btI74uv6fu3/RY08hg/ciSO9MksfmSaYh1/k
	1jEAOtYzDUM+DbdTJHWm+RN4j/qsDzNR4lXH9Pnki6IAVGOZKPsEvERoPzsWOpPn
	V78+2R9Gu/v9dQbFLXJ74kaUcV+dSbeC+uX/ey06yw6IqIanwk1JPrLh9KWqxyE6
	IAeTfu/9QzautTD3ThbEWzJ2A9Ruc2HNqdix+SSsfbfzcYrCK3/qk5scm0wyr4XJ
	305vyrtXyMDVg/8J0I2jRXzNFzAML8SAEO8Orfxbmp+gZnKZQBoCWDpLMwzlXh2l
	aiVUp0Qd3F+uIqAlm3AnSYLTquWAT+SnLbyFYZdPBg==
X-ME-Sender: <xms:hLILZk36F12g4cT97P8Tqk_d2xH6u7CSC4kpfltyhAhiSM3V935xUA>
    <xme:hLILZvHcCPu_05emHq9daAQSIaQHp-rx3zFtWelUZL44HIFiuNE47MSy_gWL7v7b5
    YrOsjSESB9rBUfu6w>
X-ME-Received: <xmr:hLILZs7w0nzxQiqBXk75MV-19TT2d7fbZ0tN_ZCMeIvkB4dRflgd-RVy169mwrG9sRHednEiJV8mtdL5SIuLqfJVjPOMlmoWbYIqHJGTTNQsrnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:hLILZt0H9ZDjRFtzuSYJLY-46STJ2ufGL3HNr9-iuclByAgbOHRQuA>
    <xmx:hLILZnGrZP-Ut1g0yQ7mq4zw8OXTM0gcHZgfJnHGCUTj7Y5CrH96Xg>
    <xmx:hLILZm8h97qnaApadfYaokfsHHUdEGgLzU4HYBNNmldFGwBxSNewpQ>
    <xmx:hLILZsmHNCpSOlQXxLnUqnZT5PaXop-80vAigE9WxtHaDGXM8DppSg>
    <xmx:hLILZoOCOd-Ao1ah3QhK8tvAg1BPNh5A5vkwA9ks4uj3Qnwz5NrO00kC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 03:23:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d54bdfcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 07:23:39 +0000 (UTC)
Date: Tue, 2 Apr 2024 09:23:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/3] reftable/stack: add env to disable autocompaction
Message-ID: <ZguygYtc7plWTIA2@tanuki>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
 <2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gCAymL7nALASoKol"
Content-Disposition: inline
In-Reply-To: <2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>


--gCAymL7nALASoKol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 04:16:47AM +0000, Justin Tobler via GitGitGadget wr=
ote:
> From: Justin Tobler <jltobler@gmail.com>
>=20
> In future tests it will be neccesary to create repositories with a set
> number of tables. To make this easier, introduce the
> `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that, when
> set, disables autocompaction of reftables.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  reftable/stack.c           |  2 +-
>  reftable/system.h          |  1 +
>  t/t0610-reftable-basics.sh | 15 +++++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1ecf1b9751c..07262beaaf7 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -681,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition=
 *add)
>  	if (err)
>  		goto done;
> =20
> -	if (!add->stack->disable_auto_compact)
> +	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTAB=
LE_NO_AUTOCOMPACTION", 0))
>  		err =3D reftable_stack_auto_compact(add->stack);

The double-negation in `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dfalse` may be
somewhat hard to parse. Should we rename this to
`GIT_TEST_REFTABLE_AUTO_COMPACTION` with a default value of `1`?

Patrick

>  done:
> diff --git a/reftable/system.h b/reftable/system.h
> index 5d8b6dede50..05b7c8554af 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -17,6 +17,7 @@ license that can be found in the LICENSE file or at
>  #include "tempfile.h"
>  #include "hash-ll.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/
> +#include "parse.h"
> =20
>  int hash_size(uint32_t id);
> =20
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 686781192eb..434044078ed 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -299,6 +299,21 @@ test_expect_success 'ref transaction: writes cause a=
uto-compaction' '
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '
> =20
> +test_expect_success 'ref transaction: environment variable disables auto=
-compaction' '
> +	test_when_finished "rm -rf repo" &&
> +
> +	git init repo &&
> +	test_commit -C repo A &&
> +	for i in $(test_seq 20)
> +	do
> +		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo update-ref bran=
ch-$i HEAD || return 1
> +	done &&
> +	test_line_count =3D 23 repo/.git/reftable/tables.list &&
> +
> +	git -C repo update-ref foo HEAD &&
> +	test_line_count =3D 1 repo/.git/reftable/tables.list
> +'
> +
>  check_fsync_events () {
>  	local trace=3D"$1" &&
>  	shift &&
> --=20
> gitgitgadget
>=20

--gCAymL7nALASoKol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLsoAACgkQVbJhu7ck
PpQ0SA/+JpK1Dq2rIJJ985UQ61BaXrkXDWc3KTPzO+9cPG6/8y1Vp5xsx2u35FJ3
6csVenMkX15kmn9vvmZOT1rIVNHUJQco3dORJ0EfZBzdMx6gJMtBioF7Ggc2SaCS
YezByE317Ml7nV9BsNEunysJO7HEy3+Pns4acAgj6sWhKvc0WW4VCCigbmN1HdIs
o6wgILLOIBjBM49PeNPKQ6hTUQ7G+ZX433F2QXY3DMstqdwuFtBKl23y4ZTsFRn9
T1oJl0NPCitroNTi28j0hasXsXi3jvjlsVA7/aVHWAidA5ypsOJCMO3DEVoi7+eX
3D/u6wYLPm/n8iprLquuJPADX1RJk3n0I6JT9idspQzBXKbdCRkFVCJh3bifv6I3
go5bNLaMu3nnCsJEFiaZH34RPDSZbWKOjAieV/nvsKKafkokqWrxJlwOWNPlJPuG
2zTsTpSYxEP1UXA7YGxzRcewK+fAlovuq43yEL8i89phEM5m0Nxt8+tQLSQ12ctR
FZJ1MNbzV4O6znr+/RhDIL74zS2zikrM8ggMlGVYiNfXQPOxLc88yoOqEsNhEsaQ
Xtg4gHNzF3q2VYy6gtadUlkZvoxsLVMtxZsqtoa7O9pCjLG3yAPoay3pQXRqZRQV
Ub8lJlfOQlvprq5sOC5AOysSyloz4UIVY6764EGid9Qx0tzCqL8=
=Pbwe
-----END PGP SIGNATURE-----

--gCAymL7nALASoKol--
