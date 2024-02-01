Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C29715A4B0
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772801; cv=none; b=MLWED2q1zJZjiADBWZ6uiL5v8ClM6Zh3pkTgRh8Bcm9yW9DquwroXB7+P5EeSQi9ze8IJLF3QOF1jAnULtY58VWfJGWDjNZMfDOB4sFTy+S3aTRZh0fplMhEE62fuq4GsQxYc7oMFjQUyECgFelOrORvEL3oiYs4chsh8py69M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772801; c=relaxed/simple;
	bh=1hHg6Y1vuGvkBLSiwTUY8+9bJ1eTXl2qdVkgXLMFyL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhfJAmZglab20dLnb5+0d32/C3lCzikFHDU/VYPIIH41kV8GFm96X+ru2G6O2aPn1YLT4aKEH3WlNfWpMVp08QFsTrB1eeTbCU44FmIsYxdRQJoD3V56+ve/zBxDs6gK2X4DdP4X4UZzZfsJv6mi7PXlGL7/EKsdQlggLJtIItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LWV2Sve+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCrUcgJo; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LWV2Sve+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCrUcgJo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 989BD1800085;
	Thu,  1 Feb 2024 02:33:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 02:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772798; x=1706859198; bh=m32ppqIUCY
	0iwopfj/zwcdOLxOtpyTtRN5ErP5ZQxuU=; b=LWV2Sve+PdoEx7Yqv7OH7v6NRn
	Oar3UNeohMBDfO9dCzurhd2VFsJ8iNCoBaFupoFxxTwOQyR+L/iL6y24UAzauNRi
	QQAYE7kOu8vHEECDbhPkTeEsbjILdPYdyyVAvBhR58EtSi8HpyxogzCo0XHwe5Kk
	VP3U6+UO+8CHgFMzqQ3jW4xTG8U7WpS21s7Q22S5ZU3UggjtwyGJpKAzDyf9h5ER
	DoNuWZlFR1a8i41UrLbCxEOcHxBWLAzwTZIgyqA3yzdX/B9E5uhqA3rGBaV1X7Fl
	3ltE/AANX/vKjX42rIFa7578y/IdYvHfUq3AA3e6Cj/hEFeSUUy2sJVorcwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772798; x=1706859198; bh=m32ppqIUCY0iwopfj/zwcdOLxOtp
	yTtRN5ErP5ZQxuU=; b=iCrUcgJorzxJXhg4SyMPPd8Dtb/rcaMukHVr5X2QATnM
	Amlz9BJt9rG74RRh5opKX8aTKQuVGOtFMyDiLY5jz+hikDqkRboA8l5YZOPMYEzB
	SFUnPkclwDZwvIR1369hHw6JA0/IyKsFruBJ5/ZJbGGfgUZSgcxvsBFO6qJEvqUN
	YaqSqL6WFLJtfDiPbIxf8Xvq5AVFpsYUVkDsQZaoydE5PeAiJDv8SONx/C5GuLmc
	bRwd4jsgFZe1HNh7S01Qjd2N4XgW8edC2SM11qIkyqSHbxZGInLUD9RuEpyjJDw3
	q2lr9WCe6WmadMEyvq8B/eQ4GhATx9Kb1df/7M7DgA==
X-ME-Sender: <xms:PUm7ZSTSo85BUk6UqPYFNQOnWi83IgFmifrUmvZSkfD4ApSQtjnOzA>
    <xme:PUm7ZXztsmMYcnrWP70CV8dPoJb3O1F_a2d0FfhydkKHp0aNiYoN3nWclz1oyVRqA
    f_Peo0_xHAP_yiMoQ>
X-ME-Received: <xmr:PUm7Zf3dPKIHhlavHHtfVDyiXHUHlm_waw4lKMckd3OgsRwcwWKTVKS9jmb1EUkChKH1azkvxWcBXLCE3FZZUD30WR0ItyahgYwrMe475iM3Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:PUm7ZeA-exOsoRZwHA4tQR9-_FY5WXK3QFUgq5TISvKN6TZvpNuCgA>
    <xmx:PUm7ZbjJunjERHNEKKJFqgAvA6Yp42Zddny6-PU18trg6CbIbHp6XA>
    <xmx:PUm7ZarPST9ALGf7uqud8ftODd4MvzRTpC7Y7MaaVcmeeX3PK_PMFQ>
    <xmx:Pkm7ZYvAuH8G6bLSEb64kb3pQL-6cQDtutH-NSek18vU8AR1izRKwxL8H_0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49dec31a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:54 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] reftable/stack: use `size_t` to track stack length
Message-ID: <55605fb53bfc0c81b9f2beec9c279df2634ebe4e.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+kOPel2z04Xju9Pe"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--+kOPel2z04Xju9Pe
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


--+kOPel2z04Xju9Pe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SToACgkQVbJhu7ck
PpTmHg//Q71Ho9efL2g8Bm3nSQaCedjQJgbk0ZBY35aP6Q+w3WfXGszSEx7s2sDQ
S+vGGnX8wzzDL0zRb6zb8K9j2C2t2ugy8Jt1YfLlF/0/PUQUsrLbeihjdw7rIeQ1
HESVGpGVJH9LM62RnqgiXovvOLYzC3zr74/6Q8korLA9DUkQS7Dsyq/m0xNXPwMt
bP214c9I65g0EipClEA2zpZUyyZ2O/bXGL8w6yiItRtrOmBkNo9SH86tMDLqVq73
KjFyaj10WlFOONDKqnurG6hJLOGBaxQLrtQMS7YtdnFI2Tx/k4R2wjxzR5D+1C+U
GTeoK6JOhClZ5SXPf+xHiPMt6cZvXFSQKU5wq04vwaAlEgLYKejNkmovBbDnLk7h
nF9XTwv+EBGC0rFQPTjZuZFwq/7h9EP4kqRcQ717+tSNZw5kPVnnLzE0nKjl8eYN
fmhKwQL1s5IEh9D72PTOPDx4AHCiRFsI9JUhPid+7f7MfbHIiEdNsoCKiIeFm/9f
3tpouL5uFfCwbVWjFlK30um8kuaGBVy8INujK6F2gl/iZEZwUsyVnCppDQlqbS8J
8rhBXX5E1gCuJcFVbc2B9wjYSiZfCfFJP9wFzm+1YoBq9uJ7qOzND/2jimoCrKui
ZZawJ7fy0/IdsJpmLx0wx+pPkvXFdusvwN+m/oaDVMnwlHUmkbY=
=n4sn
-----END PGP SIGNATURE-----

--+kOPel2z04Xju9Pe--
