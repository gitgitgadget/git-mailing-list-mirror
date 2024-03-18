Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABD2E85B
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759162; cv=none; b=QcZKN7PMP9f3mzphyN8vCK7mhELPmTpaPW/N6b76dvXQSRoZCHeVmaat9nXWXnWD2N2HOObkJhwl04HuhbPM8MznF1emRujwWxG6whI6OAImUlLLrSBYElbR7W0osv8Je5CeoX7onQggG8+KkjeYEUQARM6rYMi39PmvKxh4s2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759162; c=relaxed/simple;
	bh=1hDFHlMhhZjVt3nrmFvWCE08g8TZldnJyqZ6KnvDg4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3f8sP3j06utbvx8QLV/vOrAjePiPGdY4t3rL4xjbvW+b9eNnmFu+UNt0LLbgzBCF3bma6vw2ZUFco6dFqYuKhuclT/qC2gENmHHKZaLEYZ15jcxXdpyzedURjpZb8gu3HQEctkLcHTQIGXUYImMHUjWIGILrhzRLdgWWfqqi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HBAx6MZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrqByIsv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HBAx6MZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrqByIsv"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81F3A13800D8;
	Mon, 18 Mar 2024 06:52:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 18 Mar 2024 06:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759159; x=1710845559; bh=Ny+fl7mAjf
	kfN5lr5eERPi/OCJ04ncOXXmkONsTr6KA=; b=HBAx6MZD88j0FXLykF45AsGBwy
	vqVKxCaAlRMlB8PPHY33cNsrf/pixnQRms0oMbwqli5f8Fko6PdLmoHk71Yl+/g1
	4VR3mTW1NDpnIcY4l5E0fwdrERd9+gjPtYj4D+GkVUJnD5UX58j0ChtCXStqABKN
	P/HU/W0SGb+8SO15ft+ux7Q302ahaEzj1IcYzUFn9J71b0qjWvQi0WlULERAiop3
	XcDB6P7ulCh6GKHy3GH6c6fMWEhD8HnHhuFl3VA/B7dHhFySrAdGMiqmnIdg15M2
	lDqe/SUi7fJliN7Oo6QChsj84JY8fI/FQerY6Ka6qGtCwh5Zxa3tNS4z43gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759159; x=1710845559; bh=Ny+fl7mAjfkfN5lr5eERPi/OCJ04
	ncOXXmkONsTr6KA=; b=KrqByIsv7kkK7UzRZO7nyYHMYJrPIMXzWbR8SBp183SL
	9mATJwx8uRLyVAfH68Ph/KfvKF176v8pHVf6U/DNdQyeXz0PCwXx7npFIXl2Y+Rv
	zkk1Z6hQHO/TXLNIvMZVimStfTpp+GiyWirPIh/BDptrwAaVIkleDpvCIWli5UNw
	OH3SBmnShCrOdkXY/2vwZuy/4GdVC4aL7rGS0cx19ZDcIqczDs/fJtzUk5pLlwU1
	hJnsuKd6NYcg0o/nBKGI85JUEFCCvCU+xeteg6edHA2bWMTHEmbw6aLs/U5QphZW
	VyM5y2BW/DlnVvu+DcSwG6o0c/BxbLbt3in7yamktw==
X-ME-Sender: <xms:9xz4ZRH9QyIvBng-jU1a2SAfepxQvs-Em11Tohl_V2JOtBTTxisAjA>
    <xme:9xz4ZWUi8v1FUAI6hfjP_gJf8f4wrUaXTU2E7pgHzFv2B73i0ZVvtuzrlDAq3Q8Xb
    4h4p_WZTPwvXxyrsA>
X-ME-Received: <xmr:9xz4ZTK7e-0PDhmdclhX_ZtOCq6zpv6NVABG-LlSvMdylOo8f7XI4NbtE6PHKuPaQlPYLd9AhZzglm6b397YIg9hFBBUFCH4VOKyb1oFgpDyfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:9xz4ZXEM2XozvvDXIYkxnhyJ36aqgSL4-eaMqo1qc2YADMdPUWH-ZQ>
    <xmx:9xz4ZXWWBwIsUxfkDx3R9XvPbCEWOxYSfJhqCS7RXHnK-tqMH77n4g>
    <xmx:9xz4ZSPKKlk4pnXEeHr28Heia9pycQQZUGDtSALcDUaP3OjH4GMxuw>
    <xmx:9xz4ZW0UtY0PEkSB-t-TF4wfem3O4jOLPP7sfVxvqyzQQ4m1W9gWEw>
    <xmx:9xz4ZSQxx-vNtDiampP97QD1_uSmooQuac57jkqb-ZUM3nHFlXz33w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 540720a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:47:47 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 03/15] reftable/stack: use error codes when locking fails
 during compaction
Message-ID: <ae2130ffda2135bdea11ea6764c08e98a2cc4905.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T0qmH5EA6gyzcYgi"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--T0qmH5EA6gyzcYgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Compaction of a reftable stack may fail gracefully when there is a
concurrent process that writes to the reftable stack and which has thus
locked either the "tables.list" file or one of the tables. This is
expected and can be handled gracefully by some of the callers which
invoke compaction. Thus, to indicate this situation to our callers, we
return a positive return code from `stack_compact_range()` and bubble it
up to the caller.

This kind of error handling is somewhat awkward though as many callers
in the call chain never even think of handling positive return values.
Thus, the result is either that such errors are swallowed by accident,
or that we abort operations with an unhelpful error message.

Make the code more robust by always using negative error codes when
compaction fails, with `REFTABLE_LOCK_ERROR` for the described benign
error case.

Note that only a single callsite knew to handle positive error codes
gracefully in the first place. Subsequent commits will touch up some of
the other sites to handle those errors better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index eaa8bb9c99..ba15c48ddd 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1003,7 +1003,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 					LOCK_NO_DEREF);
 	if (err < 0) {
 		if (errno =3D=3D EEXIST)
-			err =3D 1;
+			err =3D REFTABLE_LOCK_ERROR;
 		else
 			err =3D REFTABLE_IO_ERROR;
 		goto done;
@@ -1025,7 +1025,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 						table_name.buf, LOCK_NO_DEREF);
 		if (err < 0) {
 			if (errno =3D=3D EEXIST)
-				err =3D 1;
+				err =3D REFTABLE_LOCK_ERROR;
 			else
 				err =3D REFTABLE_IO_ERROR;
 			goto done;
@@ -1075,7 +1075,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 					LOCK_NO_DEREF);
 	if (err < 0) {
 		if (errno =3D=3D EEXIST)
-			err =3D 1;
+			err =3D REFTABLE_LOCK_ERROR;
 		else
 			err =3D REFTABLE_IO_ERROR;
 		goto done;
@@ -1187,7 +1187,7 @@ static int stack_compact_range_stats(struct reftable_=
stack *st,
 				     struct reftable_log_expiry_config *config)
 {
 	int err =3D stack_compact_range(st, first, last, config);
-	if (err > 0)
+	if (err =3D=3D REFTABLE_LOCK_ERROR)
 		st->stats.failures++;
 	return err;
 }
--=20
2.44.0


--T0qmH5EA6gyzcYgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HPMACgkQVbJhu7ck
PpQiJw/+OKXVzqEgLInOPVZJHjUOgAFQ84EhwBdn447ah3lZi7HXWy1W8nWvCPDx
AKQxXLOLzgYy8VBdHDiVeUMZdHtJ3Wqa37gxZ4L1FaLx1HcAC1mozxf9QBaO253q
MZgzmG0wZhBGFuwKOoHXGEoyIS5LLda8wZpqW1L5HNAilv6MxmK4orqJ6FaL0t4G
E+yvMbLt5iFpH7PBn4Lsi9fltyyGDhPg/zVYY2a9cT1JeMEvlQpNCKtEQNgnaSkc
r8lF9iLlQjXiUHh0fFOtKUC5Wb82lEyyWr3uKAxkrtj/ke+K/vlCi8Uk0NzBgYLr
sAkW77zYifbOLVWq5pJGSNEtPwjhPw090v7lKIcS6smwwXrxQtj5Ihf2o/xYZsMt
KNyRNInBz45AjRxDxax04OdQiX6BbynOXq2zRDddfA+p0sDmPZG3dZFwF1Xf7apL
9eMsEZli8JDuGCZFpp9lHBRB+Y8LnVg5pXSPRix3o2+Cm15OupTTLD7L4Lan3eE9
Uc957XJCxsx2WvFKPBMsfgvwwi8Jh2zIH4oVh23C4oHmqKXZ2L1V3YeurU8YsuoG
l7hrQDWJIgLVCpkT1LSo3NbqP82KU/mbqMc7yUNpH59xgEkxkhMDmBl85AVTQLnG
kHR5kY7FL7lxG+3dut+tPMBKkb8qEXDJpAEGVJtaXSTD4jusaYk=
=30QP
-----END PGP SIGNATURE-----

--T0qmH5EA6gyzcYgi--
