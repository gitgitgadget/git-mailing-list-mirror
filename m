Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089312E4E
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896768; cv=none; b=fo4EVjBylCspaW9Gc4hoIPUAZre/NYREBxO2mPPzC6BuEeOGFMkFggFxU0OHTYKIG8WNGXHDLU8wq1h//5GFp0kaW+jJuJcBMrddjsRbSYnXSYjrzm7/Saste+k4fBF+z+8wg2CXE36TzN3D2d6x9Q87u6kf1sas5tn/RJDIWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896768; c=relaxed/simple;
	bh=Y290ijkN9Bc0qwetvK+wIfYsTn02NVFMmyKM7F446VE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fki31JgZDUr/+FVon6D7pfBb1gKsmy3+w9Bp3WEf/lVyi8w1sdymkcsQbXQz7lPUsIGo+CmJP5gm1sP3m8n6sE/O/anKJabnjsRrfQtxcLh7YuEZkPDmmQJohgxTzvvDhu40KEU85OBtBS7EcjsE6l5AvX9kWWqEkxvKVPfIl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kxI8FhxF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xzO6sHxr; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kxI8FhxF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xzO6sHxr"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id CBD84180008A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Feb 2024 02:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896761; x=1707983161; bh=3xsv1JJJY5
	Azj8zuYFWG0QjCyygIAZ/MY6k2HLFXyEg=; b=kxI8FhxFjGm0STJnbYg2OPkP7a
	m8XUdCIU4qcf7MdDOVlR9Lv0xchgLlpCFt45t6CnaSxf1wVqZNLRyurI0Q2UCiuP
	YTA/BJKYBdOp2VlZ2oirGHyFwoGeh2M2d6U/W2LREW8R+TABs8F1WHxqy2xNpkkz
	3DKa5AFXP9AIBY+tWodaKvxnh/V9ssCErkQun08g4YKpb+GW4IVySGEx8mxRoA9O
	SYuEkKnPHzd0PTfWCJGO2nudBw5UeDeiK/YdldfoAGJZ+iJ8LDmiu+9vhOUPA8K8
	vWUuRnmIR9LroY5aPQpWFS1ETr0iULNuBtlfVdDwfjy9jtfAkrI6nQjTVx5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896761; x=1707983161; bh=3xsv1JJJY5Azj8zuYFWG0QjCyygI
	AZ/MY6k2HLFXyEg=; b=xzO6sHxrrpQBr0ztriLFGsVYj1kfBGqt33rjjVZpsi5R
	jlyzZE+JEYOyfBq3MB7EBLFHQc1HD9QTP0zQKF/0/Q5mwrJrerfhvKkajQUHJWh+
	ZKj+A3MrD/SzN/UWUXDE2y7SS4VJY4MqQGpqkoaAGaVoHEzde72/Ah/iFdToA+un
	UTTrrwQh/HiteRLfMf1WLlnXf91UwAlKk4NHX1kQmr7DLyOBaC2WAYLaFX9kQV9R
	za5Ek/FO2MLNudUkf5T1ETqBDV7OHyvYwm9TZj+piIkYPwzr8gCyGCm2odNw91E+
	EExwAAZUHCFib49wXhziBI0IJX6NzgY5ka5WK1DEsg==
X-ME-Sender: <xms:uW_MZRqA48NAKiURxe2is85ptkvocHKld0hOBMk3Gj2GSFhONUTtdA>
    <xme:uW_MZToD47hAQpO76XcfQ_DpV3z1ErwgG7o4pAdC0SsuVx6YxLiEX0xREg66ng0j9
    G3KKDCN9ZS0fAaGWw>
X-ME-Received: <xmr:uW_MZePTZupOXHZmR0J-PiEP_oWKh2p8rTQ_sk5hAMb1DNeUDfHHZKwhMLl0lHQOHN7I7GBBrXHxwYpEnA4l8PtR55MQ97dC73TSxWvCFm5wPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uW_MZc6VTaQakI-CCjKF1Yxee93tEWP4u07uDGO9h8RlrZi3C2clvQ>
    <xmx:uW_MZQ6hy6Nde7gYyUJEI-Wiof32Xel_AkcYOdVK1pYJltIFiVwm4Q>
    <xmx:uW_MZUjDNM7u7J_1XQ2iAbQ1yDU6jzXFSWddICmK7_jqBW_JUNNJJA>
    <xmx:uW_MZeRMKBIf6IuaCorVE5TsROXcsOXXNa-xligg3ang9dQarw4zQblTHmg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63fa9964 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:11 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:45:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/12] reftable/merged: remove unnecessary null check for
 subiters
Message-ID: <f1156dbf51c50ba2f63aff09e71f996d937c82a1.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7nkyLzHxATI7VWq"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--f7nkyLzHxATI7VWq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever we advance a subiter we first call `iterator_is_null()`. This
is not needed though because we only ever advance subiters which have
entries in the priority queue, and we do not end entries to the priority
queue when the subiter has been exhausted.

Drop the check as well as the now-unused function. This results in a
surprisingly big speedup:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     138.1 ms =C2=B1   4.4 ms    [User: 135=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   133.4 ms =E2=80=A6 167.3 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     134.4 ms =C2=B1   4.2 ms    [User: 131=
=2E5 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   130.0 ms =E2=80=A6 164.0 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.03 =C2=B1 0.05 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   |  5 -----
 reftable/iter.h   |  4 ----
 reftable/merged.c | 10 +---------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 8b5ebf6183..7aa30c4a51 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -16,11 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reader.h"
 #include "reftable-error.h"
=20
-int iterator_is_null(struct reftable_iterator *it)
-{
-	return !it->ops;
-}
-
 static void filtering_ref_iterator_close(void *iter_arg)
 {
 	struct filtering_ref_iterator *fri =3D iter_arg;
diff --git a/reftable/iter.h b/reftable/iter.h
index 47d67d84df..537431baba 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -16,10 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-iterator.h"
 #include "reftable-generic.h"
=20
-/* Returns true for a zeroed out iterator, such as the one returned from
- * iterator_destroy. */
-int iterator_is_null(struct reftable_iterator *it);
-
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
 	int double_check;
diff --git a/reftable/merged.c b/reftable/merged.c
index ae74234472..29ad09f3d8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -70,8 +70,7 @@ static void merged_iter_close(void *p)
 	reftable_free(mi->subiters);
 }
=20
-static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
-					       size_t idx)
+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
 {
 	struct pq_entry e =3D {
 		.index =3D idx,
@@ -92,13 +91,6 @@ static int merged_iter_advance_nonnull_subiter(struct me=
rged_iter *mi,
 	return 0;
 }
=20
-static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
-{
-	if (iterator_is_null(&mi->subiters[idx].iter))
-		return 0;
-	return merged_iter_advance_nonnull_subiter(mi, idx);
-}
-
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
--=20
2.43.GIT


--f7nkyLzHxATI7VWq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb7YACgkQVbJhu7ck
PpQs/hAArmz+nPtxW/EsS23IvP/KA8uECH3h1EpZMlwVJzOEDV8Tuou8qiy4tYS8
UJGNvCaoIMiP+nsJYxV1cl3IVJtXQ7jVRNXBLPhsQox2i/JJ3c/9Td9LMIG47pL1
ZmfqNUx42Zsmj6lSKBMSRrh5+IcXiqzoDQdSlIL1wOERVXx5SRSZEqOrnrd6Ug6m
2HPaAptqp9O2CCKUz8m1MNPwqe7Q/kOEQpdabeWPNdzCSZB1bKZ/YDhgbhgaGh+L
EuoMGNHh6TdXCqq8TPGb+ikPBwXkB/nbP5Ui/sDfOhIkGuU5sITViyoLoVT9n9LD
xEacB14Mi7WC/J51QOl1UFevyX+ytKBZxLveC7myXocOfaawCzN+nmH/Nk0XxFEN
WEc/tNc/G+FG0yu8v51k8r7eZe5dYVtF6mIMXj9UcexGweSFrySIrKtMdIR9YwV9
RFEtYDRx/vWPX2T/PtNCWKcErQ3lneuC6Hnb3bjWdN59jvUiklHh2PAGC0+Zf65s
dZuVidmMoRzUo9czhyWpRpW2OjozrQEyG/YSK4w7kbF8nzSoFrsP7P2Q/2jrN51o
01zDTLl89N98YcaQ0ckuHVjhu0TKkiUfSbE78IjQcEftAK5HwfTzeSTM6AeoCkSg
0US45FojC9k0yfo+4NMWppgYengqfEddoLvsuVGFnm62Wuvnn2g=
=dJ8L
-----END PGP SIGNATURE-----

--f7nkyLzHxATI7VWq--
