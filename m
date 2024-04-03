Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035E4CB4E
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124251; cv=none; b=symNsHjn7mIhGW2iawU6s1tCMVtPA7c1/j7ifM95WXJtJ3lwOX5hzwqb2O4wgBNScNfwjRXI6IndqcTxyeOI2Cfy62vIvls8xT9pPvH0Dd5JHlDqzDaVvbufPLVxjCS84Kh+q8AWtCG+UUC0g9hcoScDUK0hQAkzgFHoETS4CYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124251; c=relaxed/simple;
	bh=5ZU7/Ko/ReUk52oiPuCnYiaFeWGXNIb3xmS0kh4H0Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEth1M5LfNmDhcuFtE9xy8pWlXVrHMygKpCxDlxkK9TILZcPYN6Krek++P7kezvpf74inq1Paaiy6nF1SB7NOlPtva5oL1+98Tbyp1vKZTy/oJvhlMiLBjD3gf1mjAlbwVkVbchqzqkCiKOHUO0nIZgFXtjdZ0C7PmC6HtQnAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bExGUeNd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBwSeYhV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bExGUeNd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBwSeYhV"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 75B8D13800F3;
	Wed,  3 Apr 2024 02:04:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 02:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124248; x=1712210648; bh=yy0ugzm3sC
	8NlpEsaYgfnwZMnXQewmQGcGTUMi6wiNU=; b=bExGUeNdojaXMOPHw1gNRqS9X3
	apBnHW9u5sVANIebwaFogoOsv4wiksNwo7cDG9tIud7lWAlp7JeHjZY16uix1T0U
	zke2ingxj6PQhbKQ0miLgK15RiQ9h5VUHOJsR138DLZaypgtn/i7vWRYVZdwNURS
	/MPL+vXAqJf5bb2JY8ueLuflTKXrvxwjmanzeJEK2hk0QMTwHUJthFfne0U7HnmN
	AW/dqyDsi1I5819qJpKmRKCQ6ka9bG+1nydQ16F8U6Y5xYmY60d5KQYbcX3ImfyX
	gpeTN4lRwSBa7RoeTKQIjPmG2YRcBg9kk7BuoA+3B8+yfvxMTt4UisJ83/PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124248; x=1712210648; bh=yy0ugzm3sC8NlpEsaYgfnwZMnXQe
	wmQGcGTUMi6wiNU=; b=fBwSeYhVSkqy01SfV2x1/ZzpEUnl4Ud5N0HCQ5OqtGOJ
	pBDA18RCWfQDv9m0L/5PXfnt5AudRLobcAZuwrk6DS1gnRgc825nJcGm8E/dPmkK
	/iCqshTZiytJs2yXoVcrc3S4buWCjv5Z9IIJNEK++W/AudxbRUQkdfc0BWoUbd8H
	WOz96kzvPH4LSfEzk4Zp8b2Dy31fCPMy3S93gv6+w7bJjXu7jWT2HCeRbCu+UqY0
	/HBmiMT0EEAvXn9w739c0niBPERA5d9LMJrrgHQIAnk761QDx8h2ZGBmiP0z1FH+
	kQilKcmxlYKA0H04nsxPFj+6sg17e4i3VxK2yGXqRQ==
X-ME-Sender: <xms:WPEMZj60pJzr3lrTEpYOuhj9nrbhjY_sMDhcnBYT5k1b8Ve_TIMSyA>
    <xme:WPEMZo6OLuH4tvRtNXbhhmjdzD5Xau6lUF9XNkj1gmZCKHRTmLH9fEZFHA5d32WUR
    FcJ6zAbNL4V3GPJAg>
X-ME-Received: <xmr:WPEMZqeeLjtqHFCxomiMopvoAUz_P6EmZTX7QfampjOt7lfvJTK0shV_9Z_Rj3K9FxxjhR-eVHNpCWL_QwapfTRGkAmPAZYZVIQHVmwWhZx3Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WPEMZkIDO27AP8pRgWxeLRd8iE25dAsLCMtjmit_gkMdTM7DLJbMjw>
    <xmx:WPEMZnJzKW1ZPjpRs2hBptUrRgNLNge3KFBq_Fo-F-UxiAjjXXEOEA>
    <xmx:WPEMZtwvXYL92teKuysfnPVPNVEe7L4Nw1TdvR-PckQFDqnhwoTBVA>
    <xmx:WPEMZjKaGpQMaNaX3MqoObeRi8FJKkzrVeB5UsvcXypPBMRAT3Gx_g>
    <xmx:WPEMZv00MSMf-Efsg-0VkB6lbxJHWBgb8m5baE9Tmjq5T5rQxULnPisg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:04:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cabdcb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:03:57 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:04:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/7] reftable/refname: refactor binary search over refnames
Message-ID: <f5bf65e0dde70e7753e715b1fd207ef0e556669c.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2IZwrJdt3kK8tI+J"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--2IZwrJdt3kK8tI+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is comparatively hard to understand how exactly the binary search
over refnames works given that the function and variable names are not
exactly easy to grasp. Rename them to make this more obvious. This
should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/refname.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/reftable/refname.c b/reftable/refname.c
index 64eba1b886..bbfde15754 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -12,15 +12,15 @@
 #include "refname.h"
 #include "reftable-iterator.h"
=20
-struct find_arg {
-	char **names;
-	const char *want;
+struct refname_needle_lesseq_args {
+	char **haystack;
+	const char *needle;
 };
=20
-static int find_name(size_t k, void *arg)
+static int refname_needle_lesseq(size_t k, void *_args)
 {
-	struct find_arg *f_arg =3D arg;
-	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
+	struct refname_needle_lesseq_args *args =3D _args;
+	return strcmp(args->needle, args->haystack[k]) <=3D 0;
 }
=20
 static int modification_has_ref(struct modification *mod, const char *name)
@@ -29,21 +29,21 @@ static int modification_has_ref(struct modification *mo=
d, const char *name)
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D name,
+		struct refname_needle_lesseq_args args =3D {
+			.haystack =3D mod->add,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args);
 		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
 			return 0;
 	}
=20
 	if (mod->del_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->del,
-			.want =3D name,
+		struct refname_needle_lesseq_args args =3D {
+			.haystack =3D mod->del,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args);
 		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
 			return 1;
 	}
@@ -71,11 +71,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D prefix,
+		struct refname_needle_lesseq_args args =3D {
+			.haystack =3D mod->add,
+			.needle =3D prefix,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args);
 		if (idx < mod->add_len &&
 		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
 			goto done;
@@ -90,11 +90,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 			goto done;
=20
 		if (mod->del_len > 0) {
-			struct find_arg arg =3D {
-				.names =3D mod->del,
-				.want =3D ref.refname,
+			struct refname_needle_lesseq_args args =3D {
+				.haystack =3D mod->del,
+				.needle =3D ref.refname,
 			};
-			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args);
 			if (idx < mod->del_len &&
 			    !strcmp(ref.refname, mod->del[idx]))
 				continue;
--=20
2.44.GIT


--2IZwrJdt3kK8tI+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8VQACgkQVbJhu7ck
PpRKvg/9FxrBYOghFUhoizsLwa1R5Vpc7R0woL0GwFhw+uLLgH8xSo+5bl88O27z
niS8rALyvVf7wGiPonU/kcWRmw5zpVU/Clt2FDUJ1n+ljzZpOfQxaw0v09ATd19I
98OqdD+7wpR13P0x7mupx6BpmtVi5IHxJgLRnPNQBU+zRiCK8BfZ2s/3dD9wmiLI
lJEtnWaZMaTZtetJWYYRC58slqcfMrkfuwSTH9hS/0KPseMu4h7wMFa0U36RUi2x
BWhfXAgr4ADCrnoUBUZBjwxK5yfpEWI/1XjB8vSv1iTE7x+9krNsyAvxqgse8ZGL
eYgpxFAr5A4GpVQCEwY46lBkpBagX8ryMicdh+xtrotIxg2g4iPtQjnhg/9S2Ikc
AmpAS2XqUo8dELsB5c+YU8iHlmEaF3P4SdAtUHM03gVWU22Of8BQqbKuyTItpcye
FSw9hpJO3jKm9QfBa5BlJm436185TMf66tjdroBndUML9RGe2Dc0a2P+Bm5lDC+b
c3IRpoNwkfI40bOusMljGciMGHM6EAb3bpHsW7LoxRzd+ZpH5s4qKjpdTBju90f/
ltrOUgE6yGo9bspzAFStxKHnCSM2Qx+pn9MSyeqru5DObdGjezbbcElkwOHYRAgo
L/CjWJCII96YWmVOnzHfNzie9bxIouCp2mWET/cjsbTJH5BDZ44=
=VOII
-----END PGP SIGNATURE-----

--2IZwrJdt3kK8tI+J--
