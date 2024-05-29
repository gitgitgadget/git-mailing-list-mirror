Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F6181B95
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986657; cv=none; b=ebafhHSOjlwx4lz0uQyJqBSUfnucbubTkwcOh313LNtWy4R/444YH9LrUF0F0dc7WeizGDbWP80Nuq3WBWbywKgsZV7ABsDT98CqrAuiGgxf76i90VIMBzdXlEx+IqnQ2fECsXUOwhZA/I9my82/T+znkbzpzRvxSinnsUJOoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986657; c=relaxed/simple;
	bh=RuZlLmGEsvttBhmFeEMJ4pT3fq3CUXXasLzvj/y9++I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPoNFsUGErdfsZxT50GcDVn0hakzmyl4TV4NfB0DDekEmtEI0wJpXBFl4D26a83JD2Qs3MLZ6tez/yWDz02tmhiZf3N09oK0b8SuP2e6nNBM6RY626ZD+wHxjN2kW6tJQ0DMt4miXZB1/U2GGCX++/D6UJiv01fbAFdRTcCFRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QvkwbK7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPiohkZp; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QvkwbK7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPiohkZp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 1361A1C000BF;
	Wed, 29 May 2024 08:44:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 08:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986654; x=1717073054; bh=JKuNXmKf0x
	8jkd+E4OJ5ht5rWpKYN4jbdROqCmu6FgI=; b=QvkwbK7ItTmBKxSd9sjDv27a25
	Crwc1Hzor9mGjj9T6UM1hkI3Ig5kn0taOeuuUN5ddsxS2v9VNQJHs/pZlCEWt2OC
	65Ctc1Zx7rGAL5IiaNjCwrxoWVvnF3MTRuVm8bQE+ctU7QY2I33+KZgFtj+Ljb2H
	79+LSubiiDyc3jn+3+pcDZ9V7HSXjFmuVacGGdFjMiJ78FjH+sjupuyTlUrNIZOh
	ASsoEKmDXGh/k8jqxI1BEFAkvJbfEabPsNuP+/+0lXEBn9aq+BA1e6APlZOsKCTS
	MQ0pX0SE5YUi45wCLRN34VwOaDRf9nYficawpVNML/aV5ryiB9oexaMBkb/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986654; x=1717073054; bh=JKuNXmKf0x8jkd+E4OJ5ht5rWpKY
	N4jbdROqCmu6FgI=; b=jPiohkZp8Sh+PvA3Crq9x+FiV5+d4QEemc09oVchDtRQ
	ILOP1/TPHm52y1jtBUZmqaxkHa1T3AERmu4cHhIiDCECCpwYRQxO0zSJ0SejY3ZZ
	J8AGRCw5X32h/0NuIOCErUQkQ4jnxnubRYY9b/QfTT54H4fGOU4A38Ig75WRDGhX
	8H1Q2svrz958BK6SjRgPHO5y83Li5xjrOBXh0iIjtQayU3aXDmIhyX0OP35he7G6
	V1/5akgeD1VEIy71ozf2O2UKzSrprNU1xBvPxbNVkR8Yg67V3E5l8+QSB4/WVfWk
	4/OdXGwdImPFVT/qDLusX4FQ0ZYtB7H7bM/k88v1+w==
X-ME-Sender: <xms:HiNXZhECfwRTo4PN_yS1w1i-60edR-GZhR0_gJQfWGaTfaPV2SqrUw>
    <xme:HiNXZmVDkfN4VE2iBqIWffcPOh7-gCbUrFrxu_HhFxdv7CEWAQIrXwJOoslTvSqN0
    tqUfcedwF9NyHQTEA>
X-ME-Received: <xmr:HiNXZjLI4uU-Jq97I4CQnhXpEafaBKn1DmWK7IiNX7EJ1Xf1R1yuAvfRIE8Yc7jjKoine2Cc9u4Mgfx7L6yrdtS_CHzSsDNEfQQ1AG8FI4PC9Oav>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HiNXZnGVZ9DXOCio-EL_o0m13IHh3sGJjAoRpdkowpd91l4YHIgmLA>
    <xmx:HiNXZnXrzcrmnpvIZ8aDigBYmY5ODLhP2E0l6meEsBOkcesgZT3sbg>
    <xmx:HiNXZiP7-mGZS0ewp5Ih2Af6TPsiLfG9d2J2zIrMNPOfkARKdn0Uow>
    <xmx:HiNXZm3xX4bmUKD6SToX0zrqupmXwNyMAOOHMmhXXf3dQyfucGT-OQ>
    <xmx:HiNXZkgSfXl5FWzXm4V2vbEyN9c9jFVxtocv4LK2EjPUdpsW2J9GqwaP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 019d52fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:43:59 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5/1T46GGjYZp2GgB"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--5/1T46GGjYZp2GgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are several cases where we initialize non-const fields with string
constants. This is invalid and will cause warnings once we enable the
`-Wwrite-strings` warning. Adapt those cases to instead use string
arrays.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c        | 3 ++-
 diff.c                  | 3 ++-
 entry.c                 | 7 ++++---
 ident.c                 | 9 +++++++--
 line-log.c              | 3 ++-
 object-file.c           | 3 ++-
 pretty.c                | 5 +++--
 refs/reftable-backend.c | 5 +++--
 8 files changed, 25 insertions(+), 13 deletions(-)

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
--=20
2.45.1.313.g3a57aa566a.dirty


--5/1T46GGjYZp2GgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIxoACgkQVbJhu7ck
PpTkAA//aBXzs6wZyrKXalWYM5bUYKDEMqy1MbtLTptmGIU0BSjAzVgb8RGHH/yx
AS9PVY3URNdWsomTZEgR6P18dn6cg14mZcE5fZi8ltojXQiOEzx3QIv0xqn3U3mA
HKtOpCRohiLSsC01gSwPBxu/3ObD1me5JoshCQdG3dei18bQVKjVpvni26lXnpyH
DImyMxHfjC1WVRYeyrxsdKzpn3Qof4Q3XxD9S2GBuZgXMpgAVLyx1rR06pnu4a4j
6uhk8LTU4fsmFXbf3n6LRdGQ69G9M/R0DIgi/EzlyKW38sgJWpIjLD+eccZIt87o
wSxDb7kMcSC6oHb7X+aI4gtxTAkRAwjSu2pjC7R0cNU+t1BQIeGArjVUJM03kFVk
BlV485H1UuXxmC5kcyxPk+y8o1uB4JWxSar4dXOzccj30fol7jYL4npUzoOx/ri/
wjSY5E/4C2I+CRQQQ0shAvvJchproUzyBBdRe1Grp5/madGjv3qna8SIAglR0U/s
z/5/9t75lF7yh3eVdaBXL7zKUSQd3XOKfPXx+Sw3zEC6APfgbNAN49Fetx6VNy5n
EpAWP/rTa1TwGGZs/5+dL/hRopBQZqnfME9rVq+7OP60dgmsP/ZqxXvxFA2kiXr1
5YTvZkEv7OCRNIXBwnHZZcDuGyvNeqxHkPzh9jzaf2QwjFT01ek=
=ACB5
-----END PGP SIGNATURE-----

--5/1T46GGjYZp2GgB--
