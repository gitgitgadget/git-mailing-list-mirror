Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A43605DC
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688089; cv=none; b=lrb0N+HH+qosuyIbOgvJGD4qkpYHG4s5LhCZJnfWYVnDEZLh3kjO6EY8mvJWsiLYbqkiJCHan+8zsiRToqHsZzbbk5pMAshC83KrtsThwZIiRl2fSrMgrUSS8gvveSlmBxNcanJXl1qPtQGMr1DSnb5ZGAXFiTFTGWpLxIjtFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688089; c=relaxed/simple;
	bh=IlWLkimwu7hDayLS0ixmfdfTQwJTSjJ2SHYVJf1wadI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2K/8wVGIrNXmNdph1+6Fouj7q1UcrcUPqa5uWajJT0qdTuxDDmN0ykcFa4mB9jvvR7iYyIsteS6xXDVXPou9L+4uzDuN4CVVwurQps2Tqwuao+K5nUIb6rEOUeQP6sCsACcS4TOze2H+lTJX++8Z2usKnS8iGrRhGUfVcYA3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eFwNA/3o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wLH9YROy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eFwNA/3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wLH9YROy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C3C481380055
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 03:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688086; x=1706774486; bh=MYUNbpIQs8
	u/2pZEKJB8VAF30s2V9E4S0hPAU82TYP4=; b=eFwNA/3ouMvpkydezaRr14dFWw
	McRFoXk42xCq+t0HKF44B5uq+YOk53Oj/qcFKMmqeSNbxsL6d71lI8RXz6i2hDHi
	eGwV/TYiA7hseZZiOj8mmxKgvVJZAFGhTPOvWX3IwWEXRcIuNLyzBSZ34UvlQTVm
	00Yt5vllPgVfLpQCooebavg4OWtFroUl69OtDMfBu9T2z2tRpvu9GppiJXFitHfj
	VqSb11novxKNtT8EyR1olwygWXu7z1koI836biiipUdVfUZFsfL4RM0xjYtRSLb5
	eZpAfIpZ721II/TfrhxHg8KXd+HAnw/IYYtsd14t35JSrc8TarAroyydVg6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688086; x=1706774486; bh=MYUNbpIQs8u/2pZEKJB8VAF30s2V
	9E4S0hPAU82TYP4=; b=wLH9YROySNmDJq4ph7eNdTQ60o1FfO0KG7Ngxwpj616y
	lQcbPEROufDeFLmsKaZOKS8yV3tLAMMjna6cb290ujQuSzmyIf2G9TMAC+XjqYAK
	UcZIG5EJ1RWbCHHz2d2k7qEjEfqGijCJ4uN/hyQMY7ATN6kglqsG7RxGf5ImLeVC
	VF6vvO5SWe+v37F/WOfCed3//MGnwkSY0DBPxJUdSb2njuyXgDp95urwJ7KrVyJ/
	BAxKOgMGgqUIKyiMeXtLnWFmZa/Z0xYaHXyvjAaNNDSBoUC7IBzEwdujp5Vl9u3T
	xGiewblo23DCzaRyytzLSWsvRi6c4nDojRU6WGqK/g==
X-ME-Sender: <xms:Vv65ZYZceZ6E1-bivHoZTb6yTzirNX1fQAm9k5krnTkZjX6R_lC1IQ>
    <xme:Vv65ZTblSkqEsAGWjbbS_HpovR-lHgG9kBjr0aKklpsGLGGQEPBQnN6Xfm8AmMkDc
    6kUcpXD5Z9FqIMb_A>
X-ME-Received: <xmr:Vv65ZS90-gRHj3-NRS6ptSgkGDrRGDncGyDINeT-7HhS76wn996uRl8idZHohudrToqBcFoMkykfl-nQk90JvnmIYR1a-RegGNrsha6_wVVuo5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Vv65ZSoePUX9w2gXqEZDHaNdmvGrU5X6Jp4itl2-vcDthflrJf2bkA>
    <xmx:Vv65ZTpYG9tow2J3VXw3otDCks4XLZI3ZDxD8YVyI-spaPLTklTqgQ>
    <xmx:Vv65ZQRJR_7EPmlmX4BJAJaolYNTdT4ZaWVH9t1DFsbcmEjqRlb9-g>
    <xmx:Vv65ZcAEBnAimVucsTxPSKhc2afc_FIZoCDOAcEBMSUZQl3Krca4SQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac0059d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:58:06 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/9] reftable/stack: use `size_t` to track stack length
Message-ID: <1ee9a4477f1bf49258a4d5e9bc446c6c7dae85fb.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvVP8icroGzeoacX"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--dvVP8icroGzeoacX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the stack length is already stored as `size_t`, we frequently use
`int`s to refer to those stacks throughout the reftable library. Convert
those cases to use `size_t` instead to make things consistent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c          |  7 +++----
 reftable/basics.h          |  2 +-
 reftable/merged.c          | 11 +++++------
 reftable/merged_test.c     | 14 ++++++--------
 reftable/reftable-merged.h |  2 +-
 reftable/stack.c           | 21 ++++++++++-----------
 6 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index af9004cec2..0785aff941 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -64,12 +64,11 @@ void free_names(char **a)
 	reftable_free(a);
 }
=20
-int names_length(char **names)
+size_t names_length(char **names)
 {
 	char **p =3D names;
-	for (; *p; p++) {
-		/* empty */
-	}
+	while (*p)
+		p++;
 	return p - names;
 }
=20
diff --git a/reftable/basics.h b/reftable/basics.h
index 4c3ac963a3..91f3533efe 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -44,7 +44,7 @@ void parse_names(char *buf, int size, char ***namesp);
 int names_equal(char **a, char **b);
=20
 /* returns the array size of a NULL-terminated array of strings. */
-int names_length(char **names);
+size_t names_length(char **names);
=20
 /* Allocation routines; they invoke the functions set through
  * reftable_set_alloc() */
diff --git a/reftable/merged.c b/reftable/merged.c
index 2031fd51b4..e2c6253324 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -45,11 +45,10 @@ static int merged_iter_init(struct merged_iter *mi)
 static void merged_iter_close(void *p)
 {
 	struct merged_iter *mi =3D p;
-	int i =3D 0;
+
 	merged_iter_pqueue_release(&mi->pq);
-	for (i =3D 0; i < mi->stack_len; i++) {
+	for (size_t i =3D 0; i < mi->stack_len; i++)
 		reftable_iterator_destroy(&mi->stack[i]);
-	}
 	reftable_free(mi->stack);
 	strbuf_release(&mi->key);
 	strbuf_release(&mi->entry_key);
@@ -168,14 +167,14 @@ static void iterator_from_merged_iter(struct reftable=
_iterator *it,
 }
=20
 int reftable_new_merged_table(struct reftable_merged_table **dest,
-			      struct reftable_table *stack, int n,
+			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id)
 {
 	struct reftable_merged_table *m =3D NULL;
 	uint64_t last_max =3D 0;
 	uint64_t first_min =3D 0;
-	int i =3D 0;
-	for (i =3D 0; i < n; i++) {
+
+	for (size_t i =3D 0; i < n; i++) {
 		uint64_t min =3D reftable_table_min_update_index(&stack[i]);
 		uint64_t max =3D reftable_table_max_update_index(&stack[i]);
=20
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index e233a9d581..442917cc83 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -88,18 +88,17 @@ static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
 			  struct reftable_reader ***readers, int *sizes,
-			  struct strbuf *buf, int n)
+			  struct strbuf *buf, size_t n)
 {
-	int i =3D 0;
 	struct reftable_merged_table *mt =3D NULL;
-	int err;
 	struct reftable_table *tabs;
+	int err;
=20
 	REFTABLE_CALLOC_ARRAY(tabs, n);
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
=20
-	for (i =3D 0; i < n; i++) {
+	for (size_t i =3D 0; i < n; i++) {
 		write_test_table(&buf[i], refs[i], sizes[i]);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
=20
@@ -263,18 +262,17 @@ static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
 			      struct reftable_reader ***readers, int *sizes,
-			      struct strbuf *buf, int n)
+			      struct strbuf *buf, size_t n)
 {
-	int i =3D 0;
 	struct reftable_merged_table *mt =3D NULL;
-	int err;
 	struct reftable_table *tabs;
+	int err;
=20
 	REFTABLE_CALLOC_ARRAY(tabs, n);
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
=20
-	for (i =3D 0; i < n; i++) {
+	for (size_t i =3D 0; i < n; i++) {
 		write_test_log_table(&buf[i], logs[i], sizes[i], i + 1);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
=20
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 1a6d16915a..c91a2d83a2 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -33,7 +33,7 @@ struct reftable_table;
    the stack array.
 */
 int reftable_new_merged_table(struct reftable_merged_table **dest,
-			      struct reftable_table *stack, int n,
+			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
=20
 /* returns an iterator positioned just before 'name' */
diff --git a/reftable/stack.c b/reftable/stack.c
index c1f8cf1cef..079ba7fde8 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -202,18 +202,18 @@ static struct reftable_reader **stack_copy_readers(st=
ruct reftable_stack *st,
 static int reftable_stack_reload_once(struct reftable_stack *st, char **na=
mes,
 				      int reuse_open)
 {
-	int cur_len =3D !st->merged ? 0 : st->merged->stack_len;
+	size_t cur_len =3D !st->merged ? 0 : st->merged->stack_len;
 	struct reftable_reader **cur =3D stack_copy_readers(st, cur_len);
-	int err =3D 0;
-	int names_len =3D names_length(names);
+	size_t names_len =3D names_length(names);
 	struct reftable_reader **new_readers =3D
 		reftable_calloc(names_len, sizeof(*new_readers));
 	struct reftable_table *new_tables =3D
 		reftable_calloc(names_len, sizeof(*new_tables));
-	int new_readers_len =3D 0;
+	size_t new_readers_len =3D 0;
 	struct reftable_merged_table *new_merged =3D NULL;
 	struct strbuf table_path =3D STRBUF_INIT;
-	int i;
+	int err =3D 0;
+	size_t i;
=20
 	while (*names) {
 		struct reftable_reader *rd =3D NULL;
@@ -221,11 +221,10 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
=20
 		/* this is linear; we assume compaction keeps the number of
 		   tables under control so this is not quadratic. */
-		int j =3D 0;
-		for (j =3D 0; reuse_open && j < cur_len; j++) {
-			if (cur[j] && 0 =3D=3D strcmp(cur[j]->name, name)) {
-				rd =3D cur[j];
-				cur[j] =3D NULL;
+		for (i =3D 0; reuse_open && i < cur_len; i++) {
+			if (cur[i] && 0 =3D=3D strcmp(cur[i]->name, name)) {
+				rd =3D cur[i];
+				cur[i] =3D NULL;
 				break;
 			}
 		}
@@ -870,7 +869,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config)
 {
-	int subtabs_len =3D last - first + 1;
+	size_t subtabs_len =3D last - first + 1;
 	struct reftable_table *subtabs =3D reftable_calloc(
 		last - first + 1, sizeof(*subtabs));
 	struct reftable_merged_table *mt =3D NULL;
--=20
2.43.GIT


--dvVP8icroGzeoacX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/lMACgkQVbJhu7ck
PpQKcg/+K/YoVZL4aQy0mkMG4mUOy9s+K9cZh1BMKCX+5xZY8BRZXhOKV2+GrA6D
ctXH2tIlFUHP/+Q1Af5cJoGgkKhzaWbOvXpIjNuGp9UcbdhZkWRDiVcGTD4nnk7f
cb1+LqSIEw35a12L9RsRLhhoUen0jiHjo40Ci6QibqzwdYNS07fwvchPyCbuyuF7
LktFqMCwh+2pGsN24edZnjsVRrGQvYbf92U9OvIviWQ5uS7xoqpdh2obJYmyxFcL
pbp+mD2j8oRkpUYBf1yB+GsdzrdnpK3otgKuGtQtaO82cnbfmtjc53dfNBkVQYtF
i9OGqk+5l+/ImEsMiGyQqe+ajj25osppBHIWLm+jlviUAM8plsgt9xEdgGbxlI67
j45qNuZsLaZ8+dww6VHiPns3hutrmWtG9TQyg3oTxDIVhVz17zBxf2LF4vz2J5vY
naHJ09+79jdes0z6LFutPRi/3YgW0uueOM2qez4MXoO2wBBGM/HcvnYEUfr97+bg
bMzmNGwkjwBSc4wp/tqXH9+GZmFZvcsojS8L3H9TFRW6eNn3+xbgkzeBuwJZKksb
R2kKyAgLpmNTxlhstF1TVXIFH8LRgZKKaceN8giVay7WC0UDXpUQu8HgOEisTksJ
e/UBNwpPHHFMUKyLuOVYcz2jEcmzYO7Z/mv60xpQVqxHxVZh050=
=uzRD
-----END PGP SIGNATURE-----

--dvVP8icroGzeoacX--
