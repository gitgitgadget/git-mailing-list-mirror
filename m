Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26212C550
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817041; cv=none; b=qXHRE4fW1VXOLpiS8qPLtii0oBPA2EG6BEeRlRevxfev7v456+D8ZW5tr4q9yrwVbfofl2EgPmE1BWhrLpmqqbejmeJRwIOn2f2p7YACqWBRYKNK2OZ3tUot/5Nd+MJmIGGY+M52H7cCGO2GjTOIsK/N3NVng2s0uq+2Y30pdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817041; c=relaxed/simple;
	bh=hT+IMz2PUL5//j8w9LpXSRa+5bwdv6XKHvlmQtNDEdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6N4AYYWHIvGnelMGTlPBqRpmpTXnBZta8nQxpfiZRvpPrD7VwDRASYg448LyvL1tvwhGJEl8ZUse0l/2ItBmPDz8BHnTuaHKI3B9h55oErmS0F9ptNcKHj2zkN58kilm1ssAXPkO4OVDq3hJj1aU84Qyif5u1ZmKj3176Or5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mKZKImxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d/VbxLOl; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mKZKImxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d/VbxLOl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D6D011C0006C;
	Thu,  7 Mar 2024 08:10:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 08:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709817038; x=1709903438; bh=XDZeEXDNFc
	7dmdpfDXgCoAzvF53nK3IJCOs+md+uzUw=; b=mKZKImxd9TEd/EGrrYLTr7GBWe
	C1El8YIYffPjt+jZrqTiiNtomwvTcYpm5rZZUIUfKvPQoxjVEOsYDHxK970DplWw
	9Vn1nPgZawrTkIWdW8FeBEViAPsfSTa0igsguT4MvyRzV5t5AzF6mS7wYF8ndPmK
	M2fBHxcAa1JoQf2Er6TgPMytuvBwziLdToy5GK0iBe111+rHIaJ59fEwpMqMy+OE
	lQRxKwvPxtDw4kAeYXt0Zx7PcWw6rv0RoWu+pK2RFF43X+GurdpgRnlCr7NimO75
	SAVJZIZ5J9szPN5tiNctjgXnnTpThf4Cla6lxEzKaxmpEeLoxLJzt+/p0OlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709817038; x=1709903438; bh=XDZeEXDNFc7dmdpfDXgCoAzvF53n
	K3IJCOs+md+uzUw=; b=d/VbxLOluR/CfoEtQrBXFDJYFnZZzHKLCeS5t+nrmOn7
	2a8yqgT4XaVCBzCda3Rdq5eqhjGD7prmAqB1fRG0inKOfiGzbs06St8PKSoXlr7m
	U6fRWMvQ1KItU+sZ9t2hXmlt+djMVzSsHM7Yoca39REwZb79PPEgsAa9on3hobuz
	jaw8Zm+c42s8cEjeGZ7xMii5KAPUGEYOGj/0EjUyhcXSxJd08dfBjPupbpVbcjwb
	DiMdNXRfaIhkdnletaKT8uBPmqHYV0d7oPdv0bm1o/ngRmzcGJptJlfdHbUQqCL8
	HkbGKnhfEKnIWCxNkDIN9kbPc7avQZw/RyXgsSGgQA==
X-ME-Sender: <xms:zrzpZQNilsxJsyz5-rCFJiMpsvt4PiVH8_vnhgIKYj5Jv4yRHKi6OQ>
    <xme:zrzpZW-J0HRqSBd8XTirkd6qLKK9KLiKxzwJJER_2sWIXgVxus6KwN4Cpoptk-JbP
    VhGCO-TcEcCgtf2Ig>
X-ME-Received: <xmr:zrzpZXSW-AOxVdRkygiAPm0Df2m7Jvkmbyzmf6FU_NmVfrXaJiLczsa9moCsfttJYIOOZ5TZMiS8F1iYTMbN2NRYC3mBE2f7MHWNtcMLx7dvJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:zrzpZYuz15dXOUCIOVccvMV008nG8oksNR9B-aYYTv9ax78HPVKKDw>
    <xmx:zrzpZYcYjrw1dvP-6WLMgWY5YO0jiI8Jays3frF2O7GvqG-jxKXIoQ>
    <xmx:zrzpZc1X5CFPNSSFNxwX781kxwYIDR87c2e-ZLAmv2B3HSBzJgpdUg>
    <xmx:zrzpZX57Nd6ku2NSBYtYCJX5XtR4KhdjOP5QIr0_Sxv9Ck0qF7KUH_IZGHM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 08:10:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b0ac4ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 13:06:06 +0000 (UTC)
Date: Thu, 7 Mar 2024 14:10:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <5dbc93d5be38552dd62d8d7d2566c73fc2dca162.1709816483.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
 <cover.1709816483.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7cWzhWtfQtDgC8+n"
Content-Disposition: inline
In-Reply-To: <cover.1709816483.git.ps@pks.im>


--7cWzhWtfQtDgC8+n
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


--7cWzhWtfQtDgC8+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpvMoACgkQVbJhu7ck
PpTm1BAAreLbJgsK41YxS7W6GE0uTF1xnX1+/LvYJgCUpdfT1TeXrw+hLGGfqQ4e
V/8LrFwzdCTsWTZLzr7uoXcx4+VG2WL/QTjZz8m5lbu/HvRz4LPBKf93HxhmWF+o
ZhkvwjYIGc5ZcljLXCxcVNV5+/eHGojo26W/WTyE3RZh7sbGCSdfTmnzUBJgSDSg
CfpJGYeW1iHGvmXphUBygfEghrwCeaHpH4t5KACJuwOs116TmBntKj24IfzwjN3s
aTZaVJJw5UW06pcdco1QBCbILK8QsqafrJaWrklhvhRkjcfdLkzUNf/rc7k5t4uU
uRqE6dXzmgxuKcKe3G0P/rRDEGoVCf6abbTpY4FRI/Vl29TLhyRaGid1d5zEibYD
FuH2ugKsMyV/iivcrweNHIQimTVqzeB4xXBYanJ7ee6PXXQIj+7vvbuR7ZkgUEgr
n3+pA5o3YkAEgRXfGo5ZJ+Gq1x8xvTHoHeoulKTVb8UVgaKbeaSUXcH/isD+dsAG
rQ7/EUExf7A1aFVao7ukPmfrEh7rlGRupvWDS1fbImmewXViiPGud3A5ODm/hppe
V3qhwRmnE2JLxToECqA+BBQqdUbrdxtj+k/FnfVhV7CMWWUGRWHTXu94zr7GmkU0
MQNVYXPipWfMoFjBJrIBBXfy5Q3FsaX+K7wInc/5+74iKhhZd48=
=Upnj
-----END PGP SIGNATURE-----

--7cWzhWtfQtDgC8+n--
