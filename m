Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1C140E34
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996150; cv=none; b=W41L7fY6xVLHVv06RAR3I/ChXs1bCBeODPSsbPhGeBEb4/6i3AIYMC79Yq8iZlCr2ASIBgyoCM7OhqimVio4/yUlQjcMirXzsgunYalUyEK4PbUx3pRHURx4HtajCtmXD8eXVEZUDLhOpZz5e0LoNCcAttESgOLoMbjtUlEdLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996150; c=relaxed/simple;
	bh=GZnj2b29E/8TXk1PNN4gnPdxaFDeeF132IYSeMuC6rc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/pD86K5jGJdjED0MnCUnE3sSdHAyHIC9iMMh/nlppLuyPzgtvHfDJo9h7anC+Ii6ShQcWvG+IhllFaGIi7WLwikFcbUQNfXQQt6/Kj3Sqr+tJyI+VaZhRrCYIUL1Skd8Trbo80tm59a99oaJq8yFF5DWpKMKJaqy4yleXErmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sb653LOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rU1QdmvM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sb653LOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rU1QdmvM"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 537EE11401F3
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jul 2024 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996147; x=1722082547; bh=1LTNsuOJcF
	KJPqFpRl3qzga4ZdJJ4fZSTseYyUj7wj8=; b=Sb653LOmR388j/ISbcYFTRK5yo
	uLw6YGLFz4oiFf0IGFuoYv/pwX4jr7vCa0NxLFL176uV8Qa8qkFHgITRs4MSyqKK
	bzjIiM6/Se7JipNVnmCdper65p7+reoE1SQF/FZ8xxwoEJ7dJyl3Sp6veKN10jVk
	IPuUF8xJdK21CqKjsr2oIPmAL4W46svobV5g55AlGAKndxq/wFkPZro/tdHZboDM
	P15TBeDy295M+9Xy5WU4dUG1susLwPOubQxPK4/fY5ChzNsh3PmvKPeQe0XjcTZH
	dmTKgo1UIeBhcXiScbM3dC9yT59jkRVUO98dXoeY4v7j1p2zHZEqlYam7w9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996147; x=1722082547; bh=1LTNsuOJcFKJPqFpRl3qzga4ZdJJ
	4fZSTseYyUj7wj8=; b=rU1QdmvMuVwDB7V+K04o9dETnADIGWFXLOx6TChnkTyZ
	w6SWQgI8FEHUVyTSqDU10ynbtyv3g3I7MkrgjYitMFlBAXw7PukmOBN7pqymjEGY
	D0DNOjWRrDMy7VxDd9MT6HpMggo1DqBMIMgoxfsUzdRHG7IesJGioSNdN7jqvKIN
	LbNQCsldLXFje5mVbFb1Ar8rwZkzwRVKI2CkeOARxB+08xAhoqSFlUi9kbFFX6Zb
	ETUxOL84DsTYSE2+XX1ETvTqyoXvIRJb7xvutSFA/GP8F5Kf5LUYKyNaFEF1LZ6b
	CK6Sl/Zy8IAx2bDKnW/OhFcdU+ENJ8TLRgKX8N/MQA==
X-ME-Sender: <xms:c5OjZpJR1bi04tkjt7S75VC13RFNqiEoT16jqSyK5WSAZSgdWmqbTQ>
    <xme:c5OjZlIDq3Am4cls2oWNyoB6vSeuIeDw_Z02M6EXDTyG_Ti5abBNJI5zBiK5pDUkw
    5dEQ8KLOBGv8aoU8A>
X-ME-Received: <xmr:c5OjZhtuxMAcyL4FZ4fkMcRJUc7cP7WxA4_gkoBPQrTkqFaKjxGHIXce_oftM8ntkj71BJ0-cF-3pqzaUZP_yiLmEZQtLjW9oyHEjUrwYj5V99CH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:c5OjZqaPVr4tAP4Xqb3IIVcmQvNd9eo96ytwykhtoQF4kyfZigvgnQ>
    <xmx:c5OjZgYSNm2bh95kdU_Lnx8Q6ifvZx_NNoFGVrTD4JSyZTJH3EXo8g>
    <xmx:c5OjZuCspWYrvb1aOG17LtAydXUQY24KA26PXAkE_i7Tf9FnL6dMaQ>
    <xmx:c5OjZuZs-Z7TGtlGYJLi2hmPrQQFa0ZOnTxOY90P9Ij4wuGS--XRWg>
    <xmx:c5OjZryptUTs0uLeSTBvGW4PrXBRGrAP9v8XlLbsHsI5-13hP5AKuztH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6a7ce5a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:14:24 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:15:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/23] builtin/remote: fix leaking strings in `branch_list`
Message-ID: <6952fb2ff2cf453de39b63883a716a9f09cab7b7.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yim/X5RpfiDBlqLf"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--Yim/X5RpfiDBlqLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct string_list branch_list` is declared as `NODUP`, which makes
it not copy strings inserted into it. This causes memory leaks though,
as this means it also won't be responsible for _freeing_ inserted
strings. Thus, every branch we add to this will leak.

Fix this by marking the list as `DUP` instead and free the local copy we
have of the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 08292498bd..303da7f73f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -258,7 +258,7 @@ struct branch_info {
 	char *push_remote_name;
 };
=20
-static struct string_list branch_list =3D STRING_LIST_INIT_NODUP;
+static struct string_list branch_list =3D STRING_LIST_INIT_DUP;
=20
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
@@ -292,8 +292,8 @@ static int config_read_branches(const char *key, const =
char *value,
 		type =3D PUSH_REMOTE;
 	else
 		return 0;
-	name =3D xmemdupz(key, key_len);
=20
+	name =3D xmemdupz(key, key_len);
 	item =3D string_list_insert(&branch_list, name);
=20
 	if (!item->util)
@@ -337,6 +337,7 @@ static int config_read_branches(const char *key, const =
char *value,
 		BUG("unexpected type=3D%d", type);
 	}
=20
+	free(name);
 	return 0;
 }
=20
--=20
2.46.0.rc1.dirty


--Yim/X5RpfiDBlqLf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk2cACgkQVbJhu7ck
PpQlRQ/9EARNGIAOYyzM9C7ghMzu5KC5P7h0W7cT5KmYcHxDto4P0TAjqE0qYdXT
TlFhz5OHqTpVNRApFUPg4slQqHc3cFzyN0Fd+5WoMWJe/bXpbS2D1LMi6alwYrV/
qpVYXvJ3aBTe7Y91ODSeE3FFd1oseBX1xgBvchCFMQ5HATAdkXe/MDMIvqKrOZvk
On/egyEjX7LI39F8fiBhGi3vvwNv7vkcxKsz48RfKR9Cz3otjQ3FgKiz5Ke4gpDA
e0GN8z+1Mn5MBiGtKlIj/d8UA1ZaY9YFdgNIJZ+DeKwkdTf1SjaqgcfNun6ZNfFw
KP2s5SX+XHmLF9smfzg/XVmxtm4sQtqzUqMruMoJ4C+G9LprtIGcEztG9C2bAPxR
sdhHBAYP34gAGfKJdYTOMRGbGK6A5cQPVtFnDtd8VOiBSuArRvErlfnXkRmVDQh1
pVR/31folyrdIIIPz7BJ8hQebBOuAcF80fRhapzwSe/VI2QPaWjv9W/autjyTX3I
nzwEqa/+OIzRl+xfoTuwJHtiqEc0fl/Gp/DqbNZnNYzk/M7leWuUi55fc2VTszov
tDCu7KZyqv2/i1i8zEJOgbz8ivuvjfICm3Q7ntoEjHmcWZTEUvVO3wBKrohW/6IW
Yuje38fgqkSdm/RjRdZ4EH/GoJcbkTr3PsEqaDhm7YgBjlzDTfw=
=2d96
-----END PGP SIGNATURE-----

--Yim/X5RpfiDBlqLf--
