Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69B13211A
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073446; cv=none; b=jqrpO+m7txSBRcgxELnJUZSwf02IPfXZWM8rIQCNaHYOSvPkjbFPyC8B7aTPfYMHgHJZ5F6kDta8x2xYkUXzd28rKWsq44MTMaS6pIwuvMxZPJ/3O3r5YwZCB5OnnOy7viI+UWRQ8bq27L9UIIPuHoeDjs8bozCJJx01XOnv2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073446; c=relaxed/simple;
	bh=pTexTDulOorsbhvcG6gtnJqwW0BHo9okGrKxPrMHQp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzb2iuKGumO093Yrwe2RvipH+Ndx9ihBHrTIpFzrHPGoFiY8BuUx7BQ+VqhU441+o5qoLvn3Z815PH1Fy01OTxIBZR7N1oIxrjDxM/yuzy8M63UyiQWLzUVwXykXNi0wHHcfJcgaBz0mJlG+JPEWxx3Rpvjno7VsW6hXFy4w6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CGf/QTLV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyGGd2Rs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CGf/QTLV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyGGd2Rs"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 608CC13800D8;
	Thu, 30 May 2024 08:50:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 30 May 2024 08:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073443; x=1717159843; bh=XPfEL/aVLf
	YbGRAyIAiTjwnRciSLM5Tl1ozR2eckK/o=; b=CGf/QTLV1izoB1ykvJb3x0weiJ
	77qfSlOEaWUsFxv6hreehVa5fym+2dD4vz6oq27J0q4fOtEa0aRx0ayhroA1zsOK
	avDcgf6kRIvmDUtDe9wzzHNuIaiIm7nUZi0ub0zB+9zlZXyl+UL/qjZXJFjtaTXP
	9Qkn2Eftv6apPszvgfAqXll8sBV9MMtqSbDgksvLMVptqJaEgIiN2YjoQzclXYsh
	IMqXFkowJ+LIg5Q4i77hl+KqW896CO81M26BNVeYJn7ecYpG8eTbXYU2RJujWVNC
	1FpFj2JcGpwMr/g7g0gDbcaWTVvkspH1EX65S1yQjW725jSruzOL5+rrX3RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073443; x=1717159843; bh=XPfEL/aVLfYbGRAyIAiTjwnRciSL
	M5Tl1ozR2eckK/o=; b=EyGGd2RsMPfUCPS4QXLOWKVLYnAK5oblfkKDBy5Dxk6M
	BFx75ygmYsWM/viQ6SRNPyX3I/O19tZkEgstOEsEChFNo9YfaidZ//9MOruXAapU
	GmXWDr//tGqFqR0mYFqKjQGa63VYzKHfOM4Mtywigd7zCMgSsbkCV7b7Alpajztj
	XGOX2S4IELBD7UNofCxfobSTSyurwnRO/5JOtqc5e2QX5QwTo0T7JyRXBiB/88yr
	WwiywBO77/raehv7bVZ2SLxlhQRSCbdyUDAIitNXJv8fvq4vA8FFB3ATwqnwxosz
	ca0b1lKFy8mDLyAY108tPSWfub5qlT2ONYxqFRhQNw==
X-ME-Sender: <xms:I3ZYZsvuICiPkTbdzRWxsxozZ2sZp7J_NkQJw5rgTcnuG7Evu6USgw>
    <xme:I3ZYZpcqqiFMEexm6h0qGNfGZyiaWtSxSPLPprwtCSHyhd_r785APYjAnKL7WmCL_
    WDFVIjCo9ubhpOPFQ>
X-ME-Received: <xmr:I3ZYZnwkTGTvEiox3EFe-DZvlwQMpmV_T95OvEJpXRGeu2Spa-4fFRwzqq23Oi0E_K96HB9uyWKYp8CvEqHqwzdyI6Gy1ewitJMjGdmW4DzHh95cvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeegtddvkeegveejjeefgfdvffetfedvie
    dvleeuieelleffteegvdevvdejveekffenucffohhmrghinhepuhhpuggrthgvrdhnvgif
    pdhuphgurghtvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:I3ZYZvNcZoxFTGKnN6jEYjP1eEeA03m2KwL5EcZVI_n4-l_5Dr34bA>
    <xmx:I3ZYZs-pX2Xhq-yaB_uoHs1jJPHUZQnj4rbejGnWF6OF28Y2NsjEuA>
    <xmx:I3ZYZnXjBaocG0vUYZYRlnLdEt_UiBmQjONQ_x2jv8BWOcTrjhdfWw>
    <xmx:I3ZYZleIVkcGY1xNwuF0oQByhv4PiTmJi3No9j53iMx2w5sv76-3Ag>
    <xmx:I3ZYZrZimQN9kFxamX3yLZlMPARhHxN_jXUsa8-in4FxfE_4mjgKiZUs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:50:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3d532152 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:26 +0000 (UTC)
Date: Thu, 30 May 2024 14:50:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/19] global: assign non-const strings as required
Message-ID: <3430bcc09bbb4a9fe86ba40b0b3a0d4864c92e4f.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eMsxGwOrL5kTA1Kp"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--eMsxGwOrL5kTA1Kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several cases where we initialize non-const fields with string
constants. This is invalid and will cause warnings once we enable the
`-Wwrite-strings` warning. Adapt those cases to instead use string
arrays.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c          |  3 +-
 diff.c                    |  3 +-
 entry.c                   |  7 ++--
 ident.c                   |  9 +++-
 line-log.c                |  3 +-
 object-file.c             |  3 +-
 pretty.c                  |  5 ++-
 refs/reftable-backend.c   |  5 ++-
 reftable/basics_test.c    |  5 ++-
 reftable/block_test.c     |  4 +-
 reftable/merged_test.c    | 52 ++++++++++++-----------
 reftable/readwrite_test.c | 60 ++++++++++++++++-----------
 reftable/stack_test.c     | 87 +++++++++++++++++++++------------------
 13 files changed, 144 insertions(+), 102 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d52b1c0e10..0324a5d48d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -494,11 +494,12 @@ static int get_head_names(const struct ref *remote_re=
fs, struct ref_states *stat
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
 	struct refspec_item refspec;
+	char refspec_str[] =3D "refs/heads/*";
=20
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.force =3D 0;
 	refspec.pattern =3D 1;
-	refspec.src =3D refspec.dst =3D "refs/heads/*";
+	refspec.src =3D refspec.dst =3D refspec_str;
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
diff --git a/diff.c b/diff.c
index ffd867ef6c..1439a5a01d 100644
--- a/diff.c
+++ b/diff.c
@@ -7231,11 +7231,12 @@ size_t fill_textconv(struct repository *r,
 		     struct diff_filespec *df,
 		     char **outbuf)
 {
+	static char empty_str[] =3D "";
 	size_t size;
=20
 	if (!driver) {
 		if (!DIFF_FILE_VALID(df)) {
-			*outbuf =3D "";
+			*outbuf =3D empty_str;
 			return 0;
 		}
 		if (diff_populate_filespec(r, df, NULL))
diff --git a/entry.c b/entry.c
index b8c257f6f9..2fc06ac90c 100644
--- a/entry.c
+++ b/entry.c
@@ -175,6 +175,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 	struct string_list_item *filter, *path;
 	struct progress *progress =3D NULL;
 	struct delayed_checkout *dco =3D state->delayed_checkout;
+	char empty_str[] =3D "";
=20
 	if (!state->delayed_checkout)
 		return errs;
@@ -189,7 +190,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
 				errs =3D 1;
-				filter->string =3D "";
+				filter->string =3D empty_str;
 				continue;
 			}
 			if (available_paths.nr <=3D 0) {
@@ -199,7 +200,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
 				 */
-				filter->string =3D "";
+				filter->string =3D empty_str;
 				continue;
 			}
=20
@@ -225,7 +226,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
-					filter->string =3D "";
+					filter->string =3D empty_str;
 					continue;
 				}
 				ce =3D index_file_exists(state->istate, path->string,
diff --git a/ident.c b/ident.c
index cc7afdbf81..df7aa42802 100644
--- a/ident.c
+++ b/ident.c
@@ -46,9 +46,14 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	pw =3D getpwuid(getuid());
 	if (!pw) {
 		static struct passwd fallback;
-		fallback.pw_name =3D "unknown";
+		static char fallback_name[] =3D "unknown";
 #ifndef NO_GECOS_IN_PWENT
-		fallback.pw_gecos =3D "Unknown";
+		static char fallback_gcos[] =3D "Unknown";
+#endif
+
+		fallback.pw_name =3D fallback_name;
+#ifndef NO_GECOS_IN_PWENT
+		fallback.pw_gecos =3D fallback_gcos;
 #endif
 		pw =3D &fallback;
 		if (is_bogus)
diff --git a/line-log.c b/line-log.c
index 8ff6ccb772..d9bf2c8120 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1032,6 +1032,7 @@ static int process_diff_filepair(struct rev_info *rev,
 	struct range_set tmp;
 	struct diff_ranges diff;
 	mmfile_t file_parent, file_target;
+	char empty_str[] =3D "";
=20
 	assert(pair->two->path);
 	while (rg) {
@@ -1056,7 +1057,7 @@ static int process_diff_filepair(struct rev_info *rev,
 		file_parent.ptr =3D pair->one->data;
 		file_parent.size =3D pair->one->size;
 	} else {
-		file_parent.ptr =3D "";
+		file_parent.ptr =3D empty_str;
 		file_parent.size =3D 0;
 	}
=20
diff --git a/object-file.c b/object-file.c
index 610b1f465c..c9e374e57e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -282,12 +282,13 @@ static struct cached_object {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
=20
+static char empty_tree_buf[] =3D "";
 static struct cached_object empty_tree =3D {
 	.oid =3D {
 		.hash =3D EMPTY_TREE_SHA1_BIN_LITERAL,
 	},
 	.type =3D OBJ_TREE,
-	.buf =3D "",
+	.buf =3D empty_tree_buf,
 };
=20
 static struct cached_object *find_cached_object(const struct object_id *oi=
d)
diff --git a/pretty.c b/pretty.c
index ec05db5655..1a0030b32a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1583,9 +1583,10 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 		return 1;
 	case 'D':
 		{
+			char empty_str[] =3D "";
 			const struct decoration_options opts =3D {
-				.prefix =3D "",
-				.suffix =3D ""
+				.prefix =3D empty_str,
+				.suffix =3D empty_str,
 			};
=20
 			format_decorations(sb, commit, c->auto_color, &opts);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..1908e74dea 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1285,6 +1285,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	struct strbuf errbuf =3D STRBUF_INIT;
 	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
 	const char *committer_info;
+	char head[] =3D "HEAD";
 	int ret;
=20
 	committer_info =3D git_committer_info(0);
@@ -1387,7 +1388,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		if (append_head_reflog) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			logs[logs_nr] =3D logs[logs_nr - 1];
-			logs[logs_nr].refname =3D "HEAD";
+			logs[logs_nr].refname =3D head;
 			logs_nr++;
 		}
 	}
@@ -1463,7 +1464,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	string_list_clear(&skip, 0);
 	strbuf_release(&errbuf);
 	for (i =3D 0; i < logs_nr; i++) {
-		if (!strcmp(logs[i].refname, "HEAD"))
+		if (logs[i].refname =3D=3D head)
 			continue;
 		logs[i].refname =3D NULL;
 		reftable_log_record_release(&logs[i]);
diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index 997c4d9e01..23fab22eb1 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -58,8 +58,9 @@ static void test_binsearch(void)
=20
 static void test_names_length(void)
 {
-	char *a[] =3D { "a", "b", NULL };
-	EXPECT(names_length(a) =3D=3D 2);
+	char a[] =3D "a", b[] =3D "b";
+	char *names[] =3D { a, b, NULL };
+	EXPECT(names_length(names) =3D=3D 2);
 }
=20
 static void test_parse_names_normal(void)
diff --git a/reftable/block_test.c b/reftable/block_test.c
index 26a9cfbc83..d5967b214d 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -19,7 +19,7 @@ license that can be found in the LICENSE file or at
 static void test_block_read_write(void)
 {
 	const int header_off =3D 21; /* random */
-	char *names[30];
+	char *names[30], empty_str[] =3D "";
 	const int N =3D ARRAY_SIZE(names);
 	const int block_size =3D 1024;
 	struct reftable_block block =3D { NULL };
@@ -42,7 +42,7 @@ static void test_block_read_write(void)
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
=20
-	rec.u.ref.refname =3D "";
+	rec.u.ref.refname =3D empty_str;
 	rec.u.ref.value_type =3D REFTABLE_REF_DELETION;
 	n =3D block_writer_add(&bw, &rec);
 	EXPECT(n =3D=3D REFTABLE_API_ERROR);
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 530fc82d1c..fd5a065e42 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -123,14 +123,15 @@ static void readers_destroy(struct reftable_reader **=
readers, size_t n)
=20
 static void test_merged_between(void)
 {
+	char a[] =3D "a", b[] =3D "b";
 	struct reftable_ref_record r1[] =3D { {
-		.refname =3D "b",
+		.refname =3D b,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D { 1, 2, 3, 0 },
 	} };
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D "a",
+		.refname =3D a,
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
@@ -163,40 +164,41 @@ static void test_merged_between(void)
=20
 static void test_merged(void)
 {
+	char a[] =3D "a", b[] =3D "b", c[] =3D "c", d[] =3D "d";
 	struct reftable_ref_record r1[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D a,
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D "b",
+			.refname =3D b,
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D "c",
+			.refname =3D c,
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		}
 	};
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D "a",
+		.refname =3D a,
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
 	struct reftable_ref_record r3[] =3D {
 		{
-			.refname =3D "c",
+			.refname =3D c,
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 2 },
 		},
 		{
-			.refname =3D "d",
+			.refname =3D d,
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
@@ -289,48 +291,52 @@ merged_table_from_log_records(struct reftable_log_rec=
ord **logs,
=20
 static void test_merged_logs(void)
 {
+	char a[] =3D "a";
+	char name[] =3D "jane doe", email[] =3D "jane@invalid";
+	char message1[] =3D "message1", message2[] =3D "message2";
+	char message3[] =3D "message3";
 	struct reftable_log_record r1[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D a,
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 2 },
 				/* deletion */
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message2",
+				.name =3D name,
+				.email =3D email,
+				.message =3D message2,
 			}
 		},
 		{
-			.refname =3D "a",
+			.refname =3D a,
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message1",
+				.name =3D name,
+				.email =3D email,
+				.message =3D message1,
 			}
 		},
 	};
 	struct reftable_log_record r2[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D a,
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.new_hash =3D { 3 },
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message3",
+				.name =3D name,
+				.email =3D email,
+				.message =3D message3,
 			}
 		},
 	};
 	struct reftable_log_record r3[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D a,
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_DELETION,
 		},
@@ -400,13 +406,13 @@ static void test_merged_logs(void)
=20
 static void test_default_write_opts(void)
 {
+	char master[] =3D "master";
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-
 	struct reftable_ref_record rec =3D {
-		.refname =3D "master",
+		.refname =3D master,
 		.update_index =3D 1,
 	};
 	int err;
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a6dbd214c5..064d693111 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -56,6 +56,7 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 	int i =3D 0, n;
 	struct reftable_log_record log =3D { NULL };
 	const struct reftable_stats *stats =3D NULL;
+	char message[] =3D "message";
=20
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
=20
@@ -86,7 +87,7 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 		log.update_index =3D update_index;
 		log.value_type =3D REFTABLE_LOG_UPDATE;
 		set_test_hash(log.value.update.new_hash, i);
-		log.value.update.message =3D "message";
+		log.value.update.message =3D message;
=20
 		n =3D reftable_writer_add_log(w, &log);
 		EXPECT(n =3D=3D 0);
@@ -111,23 +112,28 @@ static void write_table(char ***names, struct strbuf =
*buf, int N,
=20
 static void test_log_buffer_size(void)
 {
+	char refname[] =3D "refs/heads/master";
+	char name[] =3D "Han-Wen Hienhuys";
+	char email[] =3D "hanwen@google.com";
+	char message[] =3D "commit: 9\n";
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_write_options opts =3D {
 		.block_size =3D 4096,
 	};
 	int err;
 	int i;
-	struct reftable_log_record
-		log =3D { .refname =3D "refs/heads/master",
-			.update_index =3D 0xa,
-			.value_type =3D REFTABLE_LOG_UPDATE,
-			.value =3D { .update =3D {
-					   .name =3D "Han-Wen Nienhuys",
-					   .email =3D "hanwen@google.com",
-					   .tz_offset =3D 100,
-					   .time =3D 0x5e430672,
-					   .message =3D "commit: 9\n",
-				   } } };
+	struct reftable_log_record log =3D {
+		.refname =3D refname,
+		.update_index =3D 0xa,
+		.value_type =3D REFTABLE_LOG_UPDATE,
+		.value.update =3D {
+			.name =3D name,
+			.email =3D email,
+			.tz_offset =3D 100,
+			.time =3D 0x5e430672,
+			.message =3D message,
+		},
+	};
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
=20
@@ -149,6 +155,9 @@ static void test_log_buffer_size(void)
=20
 static void test_log_overflow(void)
 {
+	char refname[] =3D "refs/heads/master";
+	char name[] =3D "Han-Wen Hienhuys";
+	char email[] =3D "hanwen@google.com";
 	struct strbuf buf =3D STRBUF_INIT;
 	char msg[256] =3D { 0 };
 	struct reftable_write_options opts =3D {
@@ -156,15 +165,15 @@ static void test_log_overflow(void)
 	};
 	int err;
 	struct reftable_log_record log =3D {
-		.refname =3D "refs/heads/master",
+		.refname =3D refname,
 		.update_index =3D 0xa,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D "Han-Wen Nienhuys",
-				.email =3D "hanwen@google.com",
+				.name =3D name,
+				.email =3D email,
 				.tz_offset =3D 100,
 				.time =3D 0x5e430672,
 				.message =3D msg,
@@ -290,17 +299,20 @@ static void test_log_zlib_corruption(void)
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	const struct reftable_stats *stats =3D NULL;
+	char refname[] =3D "refname";
+	char name[] =3D "My Name";
+	char email[] =3D "myname@invalid";
 	char message[100] =3D { 0 };
 	int err, i, n;
 	struct reftable_log_record log =3D {
-		.refname =3D "refname",
+		.refname =3D refname,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.new_hash =3D { 1 },
 				.old_hash =3D { 2 },
-				.name =3D "My Name",
-				.email =3D "myname@invalid",
+				.name =3D name,
+				.email =3D email,
 				.message =3D message,
 			},
 		},
@@ -727,8 +739,9 @@ static void test_write_empty_key(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	char refname[] =3D "";
 	struct reftable_ref_record ref =3D {
-		.refname =3D "",
+		.refname =3D refname,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_DELETION,
 	};
@@ -750,20 +763,21 @@ static void test_write_key_order(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	char a[] =3D "a", b[] =3D "b", target[] =3D "target";
 	struct reftable_ref_record refs[2] =3D {
 		{
-			.refname =3D "b",
+			.refname =3D b,
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D "target",
+				.symref =3D target,
 			},
 		}, {
-			.refname =3D "a",
+			.refname =3D a,
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D "target",
+				.symref =3D target,
 			},
 		}
 	};
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7889f818d1..c6d88e6ea8 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -83,7 +83,7 @@ static void test_read_file(void)
 	char out[1024] =3D "line1\n\nline2\nline3";
 	int n, err;
 	char **names =3D NULL;
-	char *want[] =3D { "line1", "line2", "line3" };
+	const char *want[] =3D { "line1", "line2", "line3" };
 	int i =3D 0;
=20
 	EXPECT(fd > 0);
@@ -116,13 +116,14 @@ static void test_parse_names(void)
=20
 static void test_names_equal(void)
 {
-	char *a[] =3D { "a", "b", "c", NULL };
-	char *b[] =3D { "a", "b", "d", NULL };
-	char *c[] =3D { "a", "b", NULL };
-
-	EXPECT(names_equal(a, a));
-	EXPECT(!names_equal(a, b));
-	EXPECT(!names_equal(a, c));
+	char a[] =3D "a", b[] =3D "b", c[] =3D "c", d[] =3D "d";
+	char *abc[] =3D { a, b, c, NULL };
+	char *abd[] =3D { a, b, d, NULL };
+	char *ab[] =3D { a, b, NULL };
+
+	EXPECT(names_equal(abc, abc));
+	EXPECT(!names_equal(abc, abd));
+	EXPECT(!names_equal(abc, ab));
 }
=20
 static int write_test_ref(struct reftable_writer *wr, void *arg)
@@ -155,11 +156,12 @@ static void test_reftable_stack_add_one(void)
 	};
 	struct reftable_stack *st =3D NULL;
 	int err;
+	char head[] =3D "HEAD", master[] =3D "master";
 	struct reftable_ref_record ref =3D {
-		.refname =3D "HEAD",
+		.refname =3D head,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D master,
 	};
 	struct reftable_ref_record dest =3D { NULL };
 	struct stat stat_result =3D { 0 };
@@ -215,17 +217,18 @@ static void test_reftable_stack_uptodate(void)
 	char *dir =3D get_tmp_dir(__LINE__);
=20
 	int err;
+	char head[] =3D "HEAD", branch2[] =3D "branch2", master[] =3D "master";
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D "HEAD",
+		.refname =3D head,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D master,
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D "branch2",
+		.refname =3D branch2,
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D master,
 	};
=20
=20
@@ -262,12 +265,12 @@ static void test_reftable_stack_transaction_api(void)
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_addition *add =3D NULL;
-
+	char head[] =3D "HEAD", master[] =3D "master";
 	struct reftable_ref_record ref =3D {
-		.refname =3D "HEAD",
+		.refname =3D head,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D master,
 	};
 	struct reftable_ref_record dest =3D { NULL };
=20
@@ -310,10 +313,11 @@ static void test_reftable_stack_transaction_api_perfo=
rms_auto_compaction(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
+		char master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D master,
 		};
 		char name[100];
=20
@@ -355,8 +359,9 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
=20
 static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 {
+	char master[] =3D "refs/meads/master";
 	struct reftable_ref_record ref =3D {
-		.refname =3D "refs/heads/master",
+		.refname =3D master,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D {0x01},
@@ -404,21 +409,21 @@ static int write_error(struct reftable_writer *wr, vo=
id *arg)
 static void test_reftable_stack_update_index_check(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	struct reftable_write_options cfg =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
+	char name1[] =3D "name1", name2[] =3D "name2", master[] =3D "master";
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D "name1",
+		.refname =3D name1,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D master,
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D "name2",
+		.refname =3D name2,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D master,
 	};
=20
 	err =3D reftable_new_stack(&st, dir, cfg);
@@ -560,8 +565,12 @@ static void test_reftable_stack_log_normalize(void)
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
+	char branch[] =3D "branch";
+	char onetwomessage[] =3D "one\ntwo";
+	char onemessage[] =3D "one";
+	char twomessage[] =3D "two\n";
 	struct reftable_log_record input =3D {
-		.refname =3D "branch",
+		.refname =3D branch,
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
@@ -582,11 +591,11 @@ static void test_reftable_stack_log_normalize(void)
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
=20
-	input.value.update.message =3D "one\ntwo";
+	input.value.update.message =3D onetwomessage;
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT(err =3D=3D REFTABLE_API_ERROR);
=20
-	input.value.update.message =3D "one";
+	input.value.update.message =3D onemessage;
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
=20
@@ -594,7 +603,7 @@ static void test_reftable_stack_log_normalize(void)
 	EXPECT_ERR(err);
 	EXPECT(0 =3D=3D strcmp(dest.value.update.message, "one\n"));
=20
-	input.value.update.message =3D "two\n";
+	input.value.update.message =3D twomessage;
 	arg.update_index =3D 2;
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
@@ -691,15 +700,14 @@ static void test_reftable_stack_tombstone(void)
 static void test_reftable_stack_hash_id(void)
 {
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	struct reftable_write_options cfg =3D { 0 };
 	struct reftable_stack *st =3D NULL;
 	int err;
-
+	char master[] =3D "master", target[] =3D "target";
 	struct reftable_ref_record ref =3D {
-		.refname =3D "master",
+		.refname =3D master,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "target",
+		.value.symref =3D target,
 		.update_index =3D 1,
 	};
 	struct reftable_write_options cfg32 =3D { .hash_id =3D GIT_SHA256_FORMAT_=
ID };
@@ -874,12 +882,12 @@ static void test_reftable_stack_auto_compaction(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
-		char name[100];
+		char name[100], master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D master,
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -910,10 +918,11 @@ static void test_reftable_stack_add_performs_auto_com=
paction(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i <=3D n; i++) {
+		char master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D master,
 		};
=20
 		/*
@@ -959,12 +968,12 @@ static void test_reftable_stack_compaction_concurrent=
(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
-		char name[100];
+		char name[100], master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D master,
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -1009,12 +1018,12 @@ static void test_reftable_stack_compaction_concurre=
nt_clean(void)
 	EXPECT_ERR(err);
=20
 	for (i =3D 0; i < N; i++) {
-		char name[100];
+		char name[100], master[] =3D "master";
 		struct reftable_ref_record ref =3D {
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D master,
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
--=20
2.45.1.313.g3a57aa566a.dirty


--eMsxGwOrL5kTA1Kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdh8ACgkQVbJhu7ck
PpR2JQ/8DOLdq8B7EoTE4slvxTZtvZhcfSrr2NADNoVnrOpQwEOpPQrGlHs5V3c+
SeyKPQ+e1QhrOFyqrVlIeGp4kjNIpb/I0nQXAy3msiCmn+QYUiemCyJfc/UHSTjc
rtaU2iVNF5pj5grhDo7uLK8wc44fAmbMKUBVzIW3lCBqSdjtuQr84qh8diu0myM2
O0JS/ysBnuWpV/Q+UOq/2OgDDeqQxpzrmdZn7T3DAKY4f/XityarwKgTphb/ZYYc
Y0599CctZ+PT5l1/l8JFdnnja1mV1PllgoCZkkiTzjlttr1U1Lt0ic7604woEsZ9
0l4k4HRQHw6JAjZXGD/XLk2MNIXhOX/V4QcmieDRwyFyJ9hiAEmvlhnZEPlPQ5qz
m9x+N2wBNrs2N+KzJJpuelg2OFFVJ+em4Ywikac3+s0M/z7q04EkQYZCDMj8e3Bx
d7PMdkt/+Mga78AvjvZuv6bBIgJAcxjlULt+C9YBtlp64Q40wJe9+0Y5vmFVj60h
7Uf27aQz7YgYcVio1FGJmuY+9fbiay6eALuds0NJIXP8EQVckrJmwPI8NOLFQBOj
6N3qPQWpWr0o4ZCNrj2sdoKwo7cOMY0KKUA1SFjGl4nsLkyRLdcJT9WqX1kMuwxP
wIeL9i59mTPtTSsh+9QNeajr8di1RqbliptcMbKdxPdqhUeHKU8=
=JWw3
-----END PGP SIGNATURE-----

--eMsxGwOrL5kTA1Kp--
