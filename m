Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E4139586
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717694; cv=none; b=FJR/th5Fhz2TC5gUl214f9chzGCWqz2uI3LpZrNqakRKlnTgYpnmHdtVOYl3IRg6UGqqvq2Ckpozizti/oLOfyxao9xFsIT3V4lT7p9IcZTlhk7b2LGQo0RdnTxOai6Dw13PoWrQqnGzDxtGaIIYZEs1c/Q1Z9ATLvGY2PqddAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717694; c=relaxed/simple;
	bh=c5H/zKLTrro7uZ6Ekz0yFf/qhkxy0Ri3hbBx9k3NzTU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZNSENYeE0e8h/mtACPm8ToBgwlbsW/gzjMmx5GKR93Dbby+F0u9DRUqkVW0xm+2dqdC9/GUmndrvKbJjw3JobJujBbbSPWmMQF5bEGpPS3cCm43SnuN4vrFKKwddZrFUgl9JyVvHaiBxZ9f9aIxrhOPr8sysCN+K2ocWM4j5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NP7xED6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/vyWEhY; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NP7xED6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/vyWEhY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 96C9E1C00128
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:28:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 May 2024 02:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714717692; x=1714804092; bh=9A+3WlYDtW
	oLSeNTVLG7ilWj7RND0v4sqXe6G/SWWks=; b=NP7xED6KpJZd7BnR2YmhWW/yxj
	sw43K76FcNxnZJvTmK/Oil5TS5Wu4sUtaoDkKCASnvE5njWppqAmS5TeZpNKeXHM
	2fmLsp1hwOj4cuqJGwaKoTBw3Q4W8rBh8cMnsclpIz3DLPwH/yz65uuEPV8pPjp0
	4/8Umw2FMIH6EIqffytnrUri8g9XyfRs4tZdap30LxiG20bRXrogI9v3iqGyLBKi
	UNNv+hsrA50XTCvRhH/mbicVubirObhzOz0lZi1aGdBerX/PpCGv2nvIu7ryBSx+
	m3qIYTWpe/FcIOfb1/0o/zMsYl4ohsSnVubHeuBXtrxUeqCgxq3ljw08j4rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714717692; x=1714804092; bh=9A+3WlYDtWoLSeNTVLG7ilWj7RND
	0v4sqXe6G/SWWks=; b=U/vyWEhY7qk7eee/VjuNZMn1PU3DjnPHGHQv9J7GOkre
	mATiSpbuJAMBe8ELiRKmzt9iDpkpItFZiAFIfFbDZX4pqPaBnJR8BbtTV811QXrZ
	y6cs8q/xySeT9j/T97DWhbDdvSkgzbdnk1NE53Z+VMJfvufT0wNJZfxL1gUeOVKV
	SokVZbJ5SGwpyu34gKupMIvPsAoJlIeVeamU625Rd8FzuY8zxtC5kXT/mPMphDLB
	KHXN/b/UIkPDpm0X4ycoxWlr0xEePVX9dlixTyyr8xljwtzLRINd592JvWgqtutZ
	72STGGDBifrTlSlDWR7VmDwmXG3vA/6WSa0Fx7AZgQ==
X-ME-Sender: <xms:_IM0ZrQf4IgLB_L1VdGFojMRUuFD2oMxWrw9IGNac2hZ_qb3Ihwe4g>
    <xme:_IM0ZsxTzz0DcuGKf7yXCP8MjOyMZQtlyKv5TR5f6OAlNlufKLYID5spqc4sfL8xx
    NWWZh7DNK19PuaRDw>
X-ME-Received: <xmr:_IM0Zg1OALbsHNJldwGft3hsHeoY2uocSNU5vbIweIIye4WkKC6odEl61V2hX0OtJWgzHxrWJJWOEqbBtiZrdGsWOc-fARZb08jmN5A8tmWtn6Rc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_IM0ZrBVIEMZ6Cay0JTx-M_ATqs8VMjHKQ0F2WouHH4qrgS8ZPUbhw>
    <xmx:_IM0ZkhgRHwQiR7GOYaCFA7E4CrJdbfUhaTEa3OFTkRJqYQRO6e7bg>
    <xmx:_IM0ZvpK5Aq3dlrfvMx7MRgnPyBzaPW7aq4SLAOjmsSDBuF2UgybRw>
    <xmx:_IM0ZvgZphsy3MNwuf_48e-ct91pXg0cTYsRvnWzszuuYyHxGJIiMA>
    <xmx:_IM0ZgZnKorO2eKTY2-s99QYgnQ8Ts-JBKCHFU7D46ghwm8NePPpHcNR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 May 2024 02:28:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f762cfd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 May 2024 06:27:44 +0000 (UTC)
Date: Fri, 3 May 2024 08:28:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/5] cocci: introduce rules to transform "refs" to pass ref
 store
Message-ID: <ffe83f7482615c4523237bd18387ff9d3b16554d.1714717057.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WRpekNvEBkUIT7WJ"
Content-Disposition: inline
In-Reply-To: <cover.1714717057.git.ps@pks.im>


--WRpekNvEBkUIT7WJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Most of the functions in "refs.h" have two flavors: one that accepts a
`struct ref_store`, and one that figures it out via `the_repository`.
As part of the libification efforts we want to get rid of the latter
variant and stop relying on `the_repository` altogether.

Introduce a set of Coccinelle rules that transform callers of the "refs"
interfaces to pass a `struct ref_store`. These rules are not yet applied
by this patch so that it can be reviewed standalone more easily. This
will be done in the next patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/coccinelle/refs.cocci | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 contrib/coccinelle/refs.cocci

diff --git a/contrib/coccinelle/refs.cocci b/contrib/coccinelle/refs.cocci
new file mode 100644
index 0000000000..31d9cad8f3
--- /dev/null
+++ b/contrib/coccinelle/refs.cocci
@@ -0,0 +1,103 @@
+// Migrate "refs.h" to not rely on `the_repository` implicitly anymore.
+@@
+@@
+(
+- resolve_ref_unsafe
++ refs_resolve_ref_unsafe
+|
+- resolve_refdup
++ refs_resolve_refdup
+|
+- read_ref_full
++ refs_read_ref_full
+|
+- read_ref
++ refs_read_ref
+|
+- ref_exists
++ refs_ref_exists
+|
+- head_ref
++ refs_head_ref
+|
+- for_each_ref
++ refs_for_each_ref
+|
+- for_each_ref_in
++ refs_for_each_ref_in
+|
+- for_each_fullref_in
++ refs_for_each_fullref_in
+|
+- for_each_tag_ref
++ refs_for_each_tag_ref
+|
+- for_each_branch_ref
++ refs_for_each_branch_ref
+|
+- for_each_remote_ref
++ refs_for_each_remote_ref
+|
+- for_each_glob_ref
++ refs_for_each_glob_ref
+|
+- for_each_glob_ref_in
++ refs_for_each_glob_ref_in
+|
+- head_ref_namespaced
++ refs_head_ref_namespaced
+|
+- for_each_namespaced_ref
++ refs_for_each_namespaced_ref
+|
+- for_each_rawref
++ refs_for_each_rawref
+|
+- safe_create_reflog
++ refs_create_reflog
+|
+- reflog_exists
++ refs_reflog_exists
+|
+- delete_ref
++ refs_delete_ref
+|
+- delete_refs
++ refs_delete_refs
+|
+- delete_reflog
++ refs_delete_reflog
+|
+- for_each_reflog_ent
++ refs_for_each_reflog_ent
+|
+- for_each_reflog_ent_reverse
++ refs_for_each_reflog_ent_reverse
+|
+- for_each_reflog
++ refs_for_each_reflog
+|
+- shorten_unambiguous_ref
++ refs_shorten_unambiguous_ref
+|
+- rename_ref
++ refs_rename_ref
+|
+- copy_existing_ref
++ refs_copy_existing_ref
+|
+- create_symref
++ refs_create_symref
+|
+- ref_transaction_begin
++ ref_store_transaction_begin
+|
+- update_ref
++ refs_update_ref
+|
+- reflog_expire
++ refs_reflog_expire
+)
+  (
++ get_main_ref_store(the_repository),
+  ...)
--=20
2.45.0


--WRpekNvEBkUIT7WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0g/gACgkQVbJhu7ck
PpRxIw/+PB7I9axZceMdhR95JLHrkHxyohw6Nu1SQBNne2BhTXC8X1maSJgO9dj2
8pxUDI5PsrX2oDDy9F0OVAqRkW2SUnM51IyBXet3DOjYfouzSsjBnZCbWQdVr0Uo
VYJf0JSMJgCUbuusJdTtCsKt7yvyDY3KPj8vOkBsoIzYMS0qa2Yywpdz7Io9dGHn
xBBQYXrmp9RlNtXtf17GwS/tOcb4dNFcynsGrhtETwyKKrBVGRi2jlMwyL9FH/Kg
64cV1h/WzapapgktcREvH8e7agdX6Kxs4qdawqV1lk4TJf0t5EZ4JY8ziJHKennK
BDEB+ytxguaUduMf1qvMYUQ/8R/irfbFea/eufbOFlY044lcAMWk5CXtfvzjuD4u
nC00aPNcI47lNfM6ZED1rjxTPA9+UmyA5aYzawsCJccPv9nIw++toblDKrzOczhr
8y7IfNx5zmxDz391o2NKp27wgNBo3a8iaM2oMm0nSLb9XiQZNJuRkZO/YQ9Psi6z
264cfcawoEq5mjhSikG6LsPAMshCSrB+Ky27D6ihARfUzEI2wxd7fgYlyNHojabz
IDdNJGx2/B5mmL7+6BJww/pesrklxlypg9rwMnA5jDPpPgtt31un9BUZJi+0a8Fi
0P1kPszbCvnSo1K8vH9NPtigxihYcCTasm/CnC8oWsM720l6kS0=
=z3H5
-----END PGP SIGNATURE-----

--WRpekNvEBkUIT7WJ--
