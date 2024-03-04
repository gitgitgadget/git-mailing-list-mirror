Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9F3838B
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550656; cv=none; b=nVRldvdMEEXRPcOK86I1Wcja8RQJawCzTgmEvqwoShhX927e6J6n39n/8dmmlgjSIkJLpj/1bxEO8rNUYK/jbbhoDaeDsM3VD6a/tVE0zyVRCS2mjwsRKlg/k3ah8I/1Q6+/efLCViOiNVzZYJx9VfsWGxMtTZUGQQNZ1vToN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550656; c=relaxed/simple;
	bh=fIz8TCCjFB1EQc1EOUJXiv88tkU/WVoNl4/RVzGl2ds=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNM0wqwkUPqfmTxuCj5Qohbqr+dB7HNAoYy1A78Mow0kWYdu+CQ4uq+ZiTPVs80wyKJjgqBEXBAwrqZg0dgHWp1MYeLpIncXVy6EloMjJtN0rYD+lbHkezp+ktGYANyl0kefw5t9CLN/VbxyoMik78M8fDy4JXD6650sbbDwcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XlgeAxmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eC7HjTbP; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XlgeAxmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eC7HjTbP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 4AB381C0009C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:10:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Mar 2024 06:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709550653; x=1709637053; bh=6SPLdU7tvj
	YYRAlufn0tMJULprNxta/hFSHlaVCY2aU=; b=XlgeAxmP1UHrRx/oNkNU0uzPmI
	Pk8Dy8gjIjU03CxJItH2HZaWm3BH3+VFrXYXUDsA/ZGgXNps8myO0B13MIs8ketG
	4kO+XQhqhCduhSar9c+06PQ+iWD959kIKwxSZHlgl+JB9iCSnPa0xqnwlYCYtJw8
	cDTc65W0AxtvjuY5bFtHiWzVe1q5Lvz5q9InwgJTP6hfchIxaU4jprKJGBD+pI8N
	8DNNK2eEFNTbwusVbgCpGyJY30tDlyGtga/tp2U6/ptUeuNFisD9fY0nOsEp+sZC
	zUp7ZvlbYBIil+DfJS10TyBzEdZ2ycYzXBN6LkcA4G4/zRPntsVHl9HTLMGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709550653; x=1709637053; bh=6SPLdU7tvjYYRAlufn0tMJULprNx
	ta/hFSHlaVCY2aU=; b=eC7HjTbPVBn4cLcyGfOUbsK125mB7hXqkxyfrAu+vSFt
	DRz9zaSwufhiUw6t21FJ3RnCGcSwFse6RwJ+mXnTe1r+jKtQqxekeJpuLoEOxbqM
	wVp1DlrUpSCaJ/O7wDOOmsvTTsKLX5Gd1zeUtIsEOA9S8fMYKtdd8y64wilbBoNL
	gCiXiU3ucPgT76NNslFaMcJFlO5mkjVjmY5hgu9UzFngyOir2yq5pA6iwdaako9L
	iKYGRQDQS4RDcSZGQfoAwnOZTAFCoUGy6r3W0XD3InVd+zvBhqya3WRf4/whsFfa
	cbJhHIzz+80mW2NPjgO37dIHqViHE2P7xYk295pgew==
X-ME-Sender: <xms:PazlZW1mWy6Ps4osTokjfWRR1gnwbIKrJDrRfurDDOEMDbzsOMO4LQ>
    <xme:PazlZZGmYhVUCXGDEznZoJFidCmaqsQIhPv0s6PZvzmeGmQb3F6oJ6GL0MxXlM-z3
    gjX6WRAiLIShI7GDw>
X-ME-Received: <xmr:PazlZe6Js__tXG6oadW9j5BJYqoemBsgflPUCPll8HgW6d2Ic26f4euKYdll7ZN5KxQWOolGvtptmqXVWGZvMvluPwRkg0rdkSDgjZAYjyGZXtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PazlZX36qP1MjGmPhTECKwwojk3Yh85XDabZ_Jr6E7jsbjs3B0ntOw>
    <xmx:PazlZZG5fl9IfcYEqUAqpYl63uJAbB65U_sPzbRggwYTiPx0auEEsw>
    <xmx:PazlZQ_lP9Q8G0Z9OeB1I_NW0JwMuC4fpdW076mhpJHAyFlZrgz6Hw>
    <xmx:PazlZXP4w5j6woUMIPnMvDQOxpadKxrvsyUUdexmJXDjrAOYMK-fKc12wxc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Mar 2024 06:10:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c068f74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Mar 2024 11:06:28 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:10:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tpdp0ZtF55LRFcu3"
Content-Disposition: inline
In-Reply-To: <cover.1709549619.git.ps@pks.im>


--tpdp0ZtF55LRFcu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not register new tables which we're about to add to the stack with
the tempfile API. Those tables will thus not be deleted in case Git gets
killed.

Refactor the code to register tables as tempfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index b64e55648a..81544fbfa0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -737,8 +737,9 @@ int reftable_addition_add(struct reftable_addition *add,
 	struct strbuf tab_file_name =3D STRBUF_INIT;
 	struct strbuf next_name =3D STRBUF_INIT;
 	struct reftable_writer *wr =3D NULL;
+	struct tempfile *tab_file =3D NULL;
 	int err =3D 0;
-	int tab_fd =3D 0;
+	int tab_fd;
=20
 	strbuf_reset(&next_name);
 	format_name(&next_name, add->next_update_index, add->next_update_index);
@@ -746,17 +747,20 @@ int reftable_addition_add(struct reftable_addition *a=
dd,
 	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
 	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
=20
-	tab_fd =3D mkstemp(temp_tab_file_name.buf);
-	if (tab_fd < 0) {
+	tab_file =3D mks_tempfile(temp_tab_file_name.buf);
+	if (!tab_file) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
 	if (add->stack->config.default_permissions) {
-		if (chmod(temp_tab_file_name.buf, add->stack->config.default_permissions=
)) {
+		if (chmod(get_tempfile_path(tab_file),
+			  add->stack->config.default_permissions)) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
 	}
+	tab_fd =3D get_tempfile_fd(tab_file);
+
 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
 				 &add->stack->config);
 	err =3D write_table(wr, arg);
@@ -771,14 +775,13 @@ int reftable_addition_add(struct reftable_addition *a=
dd,
 	if (err < 0)
 		goto done;
=20
-	err =3D close(tab_fd);
-	tab_fd =3D 0;
+	err =3D close_tempfile_gently(tab_file);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
=20
-	err =3D stack_check_addition(add->stack, temp_tab_file_name.buf);
+	err =3D stack_check_addition(add->stack, get_tempfile_path(tab_file));
 	if (err < 0)
 		goto done;
=20
@@ -789,14 +792,13 @@ int reftable_addition_add(struct reftable_addition *a=
dd,
=20
 	format_name(&next_name, wr->min_update_index, wr->max_update_index);
 	strbuf_addstr(&next_name, ".ref");
-
 	stack_filename(&tab_file_name, add->stack, next_name.buf);
=20
 	/*
 	  On windows, this relies on rand() picking a unique destination name.
 	  Maybe we should do retry loop as well?
 	 */
-	err =3D rename(temp_tab_file_name.buf, tab_file_name.buf);
+	err =3D rename_tempfile(&tab_file, tab_file_name.buf);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
@@ -806,14 +808,7 @@ int reftable_addition_add(struct reftable_addition *ad=
d,
 			    add->new_tables_cap);
 	add->new_tables[add->new_tables_len++] =3D strbuf_detach(&next_name, NULL=
);
 done:
-	if (tab_fd > 0) {
-		close(tab_fd);
-		tab_fd =3D 0;
-	}
-	if (temp_tab_file_name.len > 0) {
-		unlink(temp_tab_file_name.buf);
-	}
-
+	delete_tempfile(&tab_file);
 	strbuf_release(&temp_tab_file_name);
 	strbuf_release(&tab_file_name);
 	strbuf_release(&next_name);
--=20
2.44.0


--tpdp0ZtF55LRFcu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlrDoACgkQVbJhu7ck
PpQtaxAAiG+Q3MI4elFLOVe9Wkk5G1M4PND24o2vVi6B+t38oNHIXn3zW5UcLxMw
ebaX2z1D1h/n7tJzR1uXyj6x/FTgQ6dNBFaF4w/N6KA4F5DqwtL6C56dotMLvh0D
lBmQ/IBOz+jJAI1DjABtp/wdKdPiP8ASNNJspfmLIBF/sF/bHV4Se9JQRx/pbOsy
QPYf/ABahLdVbB20meLCdKAXoQ92MupHdcJG27QjnSKS/Vs9xxwzdlynkDEcra8d
y+ijGifBWMNQ+dTo5dJ1+l6cnZ/HU3rjqDQlHVk/WqBXbtYWyHD/o2VQVyMfrvZV
9N9UgESgR4xAeAXhT5Kk11cDGmgGafQgzSLiL8C8K/bNBgApa6rqfXlD9KHN6YnP
88D3NddzI7FNbd31bu9rm9WaJs+ChqdDfNhlnEHCVV/PA0om2GkE9OmhIzDSPzmh
pe+OOuymKuh0iseHSpLUEh9dTKZA2tnk0i3//mKPrafz3CkmTmjeHy2H/6c2VEyH
hpRVlN1zrKxw7ja6ZSTCBW58iJilX63n+6iE60K02aTXnKlbc/EVIB1n6eJvgXty
FzdxWrqJuDANpbFcD+if0se5Hfo2omjwIVctaQfC18QT2sO1xpZPcbzlgWIOODJR
2ulxz0iWpkzfyV9M4MpJU0p+GdHk/tddfQ6mIH9ByJDh6jDYxs4=
=sQDR
-----END PGP SIGNATURE-----

--tpdp0ZtF55LRFcu3--
