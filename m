Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E339FEF
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674537; cv=none; b=D32ALNJ4Rl7RCxKFKcv2DaVoFB9KxUSITRI6fMhfhnp+Du0hCSCTkHHA9ijthkTaZfK/7EoiI+0X5x/uURyXQjrXcHUzYKZhLkMDysHa5ax7VjSc3yI1CoWldDCDgQKTQ9DHqdy8y92zkxQTSm50b4dpxVy21pPS65fMFde03uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674537; c=relaxed/simple;
	bh=Yv3CKsXUVxnNMr6k7ZHG91WFNzFu/wREwtF75P+aa74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1vtliUiXnst/2TTIG27b47wh7vEOTIhl/Thsty5cOXLf8dLNJigzNaCz/Q5M1shSQKjHYJmvs0dY8DqTXf+BK8nUSsMqNfMZn6hRLjcSLnkQATBEc0UB7yYs5JzN7RatvbeRE1/wcov9kgiCwlth4YyAaLASEjCESbiQamq7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cn/puWB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9ouOO9J; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cn/puWB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9ouOO9J"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DB6121140218;
	Thu,  6 Jun 2024 07:48:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 07:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717674533; x=1717760933; bh=GxYXdcwnyl
	tScYKhrBSqdzs8af0031NbOFdhXv3H5tw=; b=Cn/puWB8DsJ9AhKeH4/ILbu3IO
	5ctQXgrwSW0xayFu8bbvnSGmO/e9phLzGUzU+nD6YzdTy1XV43tYe4lV3Jz/PfFQ
	aPM22iGCx/6TyArXx+I6Y0bUxaPJWeiKE0bsWfNqtYYisJYur6EKgLELL8xMqK8b
	WZA9JpqmSHSfZCnEnm95rxrwHxKvJYG1kT+z0emcTTUq9d2ip5ulPe/hPtjokmim
	fAqtuGEqSuNkFGEHA/aYmTKA3wN658vi+aBRbFvXuaoAxp5qTC1IYAZoG+GVgJqd
	MQuoyaOVwoXtNIqJZ22fYh7kw3ULS9VNCut+PhwHG7q9bWLgoooyEsGLRPPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717674533; x=1717760933; bh=GxYXdcwnyltScYKhrBSqdzs8af00
	31NbOFdhXv3H5tw=; b=S9ouOO9J9iS9lIV4WMA0ZPN1XtI82leH4samiQjAm4nD
	aAjaOrQqvxvfJrO/OiYTOKEZx9ruHWgZMUNYOkmSIj9lpOEw99ngHtSZ5S1vpWx5
	Jlusrec+mBDXYPRIdmHD/J8q+hnvIxgDkPVJRuRIemuMWVrvB4yN+1D+kax4rCVw
	tSiwmTuIy4z/nGpUH1yJj/B7TqIArk3oeb/Y5Lboxjmw15aKjZD2DUG8TSgZ06YW
	NXzlDQSNeon5Ax37Cybcxi4oOu/lS3ZhY9YaC8VpSON7LxwuJfRExhMrzAwqdlLM
	R3Q+n7Mjbr7jr++xRORbeX/LiO2CD3epONgBuvQNsg==
X-ME-Sender: <xms:JaJhZpqUzrNaphID4ujrw-XXr1beX0l_GvioswlSm1JHlH80Wxpx1g>
    <xme:JaJhZrq9ZfoDVLoyh9sGN7ybAsZE_7-4csyXP9VFLoeNWBtErbQQoOWK-bbHeYqpO
    CW1EEKenr4Py9XIFA>
X-ME-Received: <xmr:JaJhZmM8nzCL0jacCZB-ieWfcjy5hcvKzpshqGhwkhBbR-tfoIUY2a7u_qMgJF_jJH6BlspX6XxTsqiwmOykg9tuMkswY7PIH5m6sgy7mJbi4hsV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdffgfelkeegjeeguefgtdegleehieevteegveehgfekueevhfduffduvedtteeh
    necuffhomhgrihhnpehgohhoghhlvgdrtghomhdplhgvnhdrihhnthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JaJhZk4UNY6scQjYHkm_fXtVN0Wve7G6JLjy5iejupXC5SZfM3za-g>
    <xmx:JaJhZo59A9USVD-KyFhXylXBEwOkXxDlbiu0AxhzL5a93N1ZwS6ctQ>
    <xmx:JaJhZsilGDnlsL40oJxeC0p205TPQZmK5KSumWK-_SJyw_FntzaL9A>
    <xmx:JaJhZq7XbSs0g7a3p9EmiEjgcUu_9YT0eFVteKGy1gtwY6dk322SZA>
    <xmx:JaJhZmn8tL62lKZbKZ6T9Mdu2mMRJlI4GQzVkKQUg_icW5U3FnoSze3S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 07:48:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c341e4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 11:48:18 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:48:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH 2/6] t: move reftable/pq_test.c to the unit testing
 framework
Message-ID: <ZmGiH5fxkrby0JyQ@tanuki>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606075601.6989-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HbdagU13cgzaS/Zx"
Content-Disposition: inline
In-Reply-To: <20240606075601.6989-3-chandrapratap3519@gmail.com>


--HbdagU13cgzaS/Zx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 01:10:46PM +0530, Chandra Pratap wrote:
> reftable/pq_test.c exercises a priority queue defined by
> reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit
> testing framework. Migration involves refactoring the tests
> to use the unit testing framework instead of reftable's test
> framework.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  Makefile                                      |  2 +-
>  t/helper/test-reftable.c                      |  1 -
>  .../pq_test.c =3D> t/unit-tests/t-reftable-pq.c | 35 ++++++++-----------
>  3 files changed, 15 insertions(+), 23 deletions(-)
>  rename reftable/pq_test.c =3D> t/unit-tests/t-reftable-pq.c (64%)
>=20
> diff --git a/Makefile b/Makefile
> index 59d98ba688..1cabe4cc69 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
>  UNIT_TEST_PROGRAMS +=3D t-ctype
>  UNIT_TEST_PROGRAMS +=3D t-mem-pool
>  UNIT_TEST_PROGRAMS +=3D t-prio-queue
> +UNIT_TEST_PROGRAMS +=3D t-reftable-pq
>  UNIT_TEST_PROGRAMS +=3D t-strbuf
>  UNIT_TEST_PROGRAMS +=3D t-strcmp-offset
>  UNIT_TEST_PROGRAMS +=3D t-trailer
> @@ -2675,7 +2676,6 @@ REFTABLE_TEST_OBJS +=3D reftable/basics_test.o
>  REFTABLE_TEST_OBJS +=3D reftable/block_test.o
>  REFTABLE_TEST_OBJS +=3D reftable/dump.o
>  REFTABLE_TEST_OBJS +=3D reftable/merged_test.o
> -REFTABLE_TEST_OBJS +=3D reftable/pq_test.o
>  REFTABLE_TEST_OBJS +=3D reftable/record_test.o
>  REFTABLE_TEST_OBJS +=3D reftable/readwrite_test.o
>  REFTABLE_TEST_OBJS +=3D reftable/stack_test.o
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index bae731669c..86a2b0f91a 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -9,7 +9,6 @@ int cmd__reftable(int argc, const char **argv)
>  	record_test_main(argc, argv);
>  	block_test_main(argc, argv);
>  	tree_test_main(argc, argv);
> -	pq_test_main(argc, argv);
>  	readwrite_test_main(argc, argv);
>  	merged_test_main(argc, argv);
>  	stack_test_main(argc, argv);
> diff --git a/reftable/pq_test.c b/t/unit-tests/t-reftable-pq.c
> similarity index 64%
> rename from reftable/pq_test.c
> rename to t/unit-tests/t-reftable-pq.c
> index b7d3c80cc7..dcde73de66 100644
> --- a/reftable/pq_test.c
> +++ b/t/unit-tests/t-reftable-pq.c
> @@ -6,35 +6,28 @@ license that can be found in the LICENSE file or at
>  https://developers.google.com/open-source/licenses/bsd
>  */
> =20
> -#include "system.h"
> -
> -#include "basics.h"
> -#include "constants.h"
> -#include "pq.h"
> -#include "record.h"
> -#include "reftable-tests.h"
> -#include "test_framework.h"
> +#include "test-lib.h"
> +#include "reftable/constants.h"
> +#include "reftable/pq.h"
> =20
>  void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
>  {
> -	int i;
> -	for (i =3D 1; i < pq.len; i++) {
> +	for (int i =3D 1; i < pq.len; i++) {

If we're changing this already, then we can also convert it to `size_t
i` while at it to match the type of `pq.len`.

>  		int parent =3D (i - 1) / 2;
> -
> -		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
> +		check(pq_less(&pq.heap[parent], &pq.heap[i]));
>  	}
>  }
> =20
>  static void test_pq(void)
>  {
> -	struct merged_iter_pqueue pq =3D { NULL };
> +	struct merged_iter_pqueue pq =3D { 0 };
>  	struct reftable_record recs[54];
> -	int N =3D ARRAY_SIZE(recs) - 1, i;
> +	size_t N =3D ARRAY_SIZE(recs) - 1, i;
>  	char *last =3D NULL;
> =20
>  	for (i =3D 0; i < N; i++) {
>  		struct strbuf refname =3D STRBUF_INIT;
> -		strbuf_addf(&refname, "%02d", i);
> +		strbuf_addf(&refname, "%02ld", (long)i);

This should rather be:

    strubf_addf(&refname, "%02"PRIuMAX, (uintmax_t) i);

This is splitting hairs though as it does not matter in practice. But
I'd either drop this change to convert `N` and `i` to become a `size_t`,
or I'd do it correctly.

>  		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
>  		recs[i].u.ref.refname =3D strbuf_detach(&refname, NULL);
> @@ -48,7 +41,6 @@ static void test_pq(void)
> =20
>  		merged_iter_pqueue_add(&pq, &e);
>  		merged_iter_pqueue_check(pq);
> -
>  		i =3D (i * 7) % N;
>  	} while (i !=3D 1);

This removed newline is of dubious value, but I guess that's
subjective.

Patrick

--HbdagU13cgzaS/Zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhoh4ACgkQVbJhu7ck
PpRR/g/7BzeN3K6YkypN9K58ihWON9MdNkYM7b22zfdgge+myYScYyj4h5GYiOZ4
19FBtePbRgI74ajDypxqGOomaJvd1KlAPdy6D98SmWTKfy6WsZUfid+QqGpwFv32
3NKisyXXe/xibjaOHyVpQzrmIi/BIXTW65nQiBBv6nVIpoASLckk6+yPqRNSjzcT
T7/HpUqqtZmNLaqS1gz+kxu+51JAf8PBknsfTveMoeb2L1PkZCXDnkbNaUk+HdhV
eeOdDNneY2aL+w3kCk1f9WayG2+1dU9+arES0ajKM7wv9umzHTqJApoLuAXBAyp+
qw3SKfvavzMOGHtqtd0BdvNfp50GeIIiiauDdbBbQqpr+x2mKR+q8R0EB7MtU87D
7v3PITf+EikGhH1JVlArAHK3f+dsRU5OK7ZtTrV7Boa39XA6jKY0Kkt4Cxv1Q/vj
BwOxeOd994B8kQA34oTq5Q/dt3HcXrru30mqRkHMIcgeFiMia2pJTkI4I7kEZJ55
JM2e99XOyknTAJ7qks2a/Yk7VhOBG/Bril9KuxUVRnx/Ag7F7HpuIWfVV/0ag/jZ
pkwmwseb/VFdji3/Cs+MEZX/VUqQnWb25r+OEAOCyXXqBZv0CrGoJqSrOdPhd5po
JodlX5ZQMXwoNWFzi5lOPHNuPYST1avI774VENc00qQgk6ieJe8=
=wWMA
-----END PGP SIGNATURE-----

--HbdagU13cgzaS/Zx--
