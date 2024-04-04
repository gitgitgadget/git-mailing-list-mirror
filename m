Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432B208AF
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209707; cv=none; b=BnK745j5Q8bLGobkEuYPEzISjgHAMT1VgP4EEv4TwOz5wQ/8JnpXBVFV61nFDX6H6ACHnSBPWsAZJ+dM69+70FOM6EeSWyQ4nqjilIH+O7ZOoDAQUEJz9L4MDb1rxm3wsi+0VjCAWYt02Z6unou0TpxvENMfbgn0ceQ3gXsVYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209707; c=relaxed/simple;
	bh=VqatXdmt81a+Q8ZObCFapN0Hzrsq4BnodRViVSB8V7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvoguucUYrV4KzjnJWLFRGL3mn12gIzpGuHoXLsjYNkhwn5NdCNkxwb0u3O9NzByqPCwdhdm/M5eqJ8JcIKIVwzwwcf0K6bWZYLzv7o77ETDwYT/VaEKvxpz2quemv2ioyXCw4rg2FxT72wdvn0j3t3fLQFluXzGC9iCAEMcI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a4I7Skhp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9asfKbJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a4I7Skhp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9asfKbJ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D868D1380128;
	Thu,  4 Apr 2024 01:48:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Apr 2024 01:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209704; x=1712296104; bh=xv5uUMVmUO
	kZfd5k2Z5g4oEwpOIAPE83Gw34xinVY/E=; b=a4I7SkhpyOGs+kYfKqpTzYVNlp
	Z4rhoWXndZSPsTdqIEFvQhb7pAr2lq9xWmZ5zH4yGkJPyMLLx51ONZJpmYrhJ6hI
	yy7eX6EuhmMU/+5UtAu6+QnCoeS9l5/Kl+srVTwEUF4qdn+DlvTYhJhGZije2jLA
	1ReT9fqZTI6Dh6CIxhwyhPP10bjKRla7GK3C7hOZafFlg0Y8ioZVDpBSpWWIqYom
	F1G26UgmGWQ1K2h/cg8jeHaH4gXXsveWNKHe8DsPiRJ2FHxyXE3n66jc2Mq6rRMW
	QURgaFbwbxBmExG4hxuVVkggQY+e6cYrTwJ1Fyh30bQUyFBRkRwtQcQSWS+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209704; x=1712296104; bh=xv5uUMVmUOkZfd5k2Z5g4oEwpOIA
	PE83Gw34xinVY/E=; b=l9asfKbJzMN7zpgEyDHAMQt7loNcFL5UEV+gz0rb7XML
	C7N75IO3piSje9iQH/wb1JAO59/JL6gmW6CM8pKvP4QdPh/MTzyl/LayRksW3Z8p
	kR9myxygqFvVb6KhzD0e67Uwr7Kph5CRySUy+FGRq/E8Xz2PrT2ufXpK9s5IiI9T
	idq0fVYzlR5E0AT/Vdm3sw4LiHxm0zMLf8nUCgLPfys+UMpXN1EXBWNEtwVnYXT6
	35pC8276uZfWGzQx+VwklAl5rWpjI78vZFDyGPcViJP+7EPxBadPInudjth17aE3
	bsaUCbZI+3QA8+2opX0Ew948007y+IFyFIQvqWk1AA==
X-ME-Sender: <xms:KD8OZuHJgm6wGWMIDGbrOtGEXxIiPESi_zFYXUp_tnlqcre5_GVEcA>
    <xme:KD8OZvU2chDjWzFqAfp1ZlpgN6y6ThE4jBSHqTKDZ0nEe2NRDLgBmWG4XldGQH1Qf
    6tU20jyfjmuNdCSXw>
X-ME-Received: <xmr:KD8OZoLcPbUnTRl47vzv35EnrNssM9YORbvbGmzCBF_wN5yOili7fLBEp84cqnbtjDS70cMVXDyI5AN0tPAZYPflVgPcFJDKZ2YRuRxkaGfT_ePE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgeeihfehkeduueeufeejueetfeelle
    ejkedukefhieffjeevjeehfeelleehffevnecuffhomhgrihhnpehgohhoghhlvgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KD8OZoEbLwi6gJsTXwZvjCVOZ5cAEFKE4QBdgShxVtwN9r6QfP_f4A>
    <xmx:KD8OZkVg9EOOdeFFC_huIULC69lCDVQijA_quQ1f33oRl2lzobCRsA>
    <xmx:KD8OZrOXDZTuzZQlAyTtBmryyTJdvk9l3Id4jgrLh-EQ-3twfwE8tg>
    <xmx:KD8OZr36tcW5hlRxOeWJw-Yff7A_AAMEX4XBPy4e8tlF4D5U8TCoaw>
    <xmx:KD8OZixEc3jSuI27ZPu0YmZDvZM4AQJtsiUBlSam7a6MmMsYB-MkK3qU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 47226a18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:20 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 04/11] reftable: remove name checks
Message-ID: <3497a570b4988e99c275acf41267f6d729717657.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YclY7MuovtiMbJJZ"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--YclY7MuovtiMbJJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the preceding commit we have disabled name checks in the "reftable"
backend. These checks were responsible for verifying multiple things
when writing records to the reftable stack:

  - Detecting file/directory conflicts. Starting with the preceding
    commits this is now handled by the reftable backend itself via
    `refs_verify_refname_available()`.

  - Validating refnames. This is handled by `check_refname_format()` in
    the generic ref transacton layer.

The code in the reftable library is thus not used anymore and likely to
bitrot over time. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                   |   2 -
 refs/reftable-backend.c    |   5 -
 reftable/error.c           |   2 -
 reftable/refname.c         | 209 -------------------------------------
 reftable/refname.h         |  29 -----
 reftable/refname_test.c    | 101 ------------------
 reftable/reftable-error.h  |   3 -
 reftable/reftable-tests.h  |   1 -
 reftable/reftable-writer.h |   4 -
 reftable/stack.c           |  67 +-----------
 reftable/stack_test.c      |  39 -------
 t/helper/test-reftable.c   |   1 -
 12 files changed, 1 insertion(+), 462 deletions(-)
 delete mode 100644 reftable/refname.c
 delete mode 100644 reftable/refname.h
 delete mode 100644 reftable/refname_test.c

diff --git a/Makefile b/Makefile
index c43c1bd1a0..05e3d37581 100644
--- a/Makefile
+++ b/Makefile
@@ -2655,7 +2655,6 @@ REFTABLE_OBJS +=3D reftable/merged.o
 REFTABLE_OBJS +=3D reftable/pq.o
 REFTABLE_OBJS +=3D reftable/reader.o
 REFTABLE_OBJS +=3D reftable/record.o
-REFTABLE_OBJS +=3D reftable/refname.o
 REFTABLE_OBJS +=3D reftable/generic.o
 REFTABLE_OBJS +=3D reftable/stack.o
 REFTABLE_OBJS +=3D reftable/tree.o
@@ -2668,7 +2667,6 @@ REFTABLE_TEST_OBJS +=3D reftable/merged_test.o
 REFTABLE_TEST_OBJS +=3D reftable/pq_test.o
 REFTABLE_TEST_OBJS +=3D reftable/record_test.o
 REFTABLE_TEST_OBJS +=3D reftable/readwrite_test.o
-REFTABLE_TEST_OBJS +=3D reftable/refname_test.o
 REFTABLE_TEST_OBJS +=3D reftable/stack_test.o
 REFTABLE_TEST_OBJS +=3D reftable/test_framework.o
 REFTABLE_TEST_OBJS +=3D reftable/tree_test.o
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7515dd3019..8a54b0d8b2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -247,11 +247,6 @@ static struct ref_store *reftable_be_init(struct repos=
itory *repo,
 	refs->write_options.block_size =3D 4096;
 	refs->write_options.hash_id =3D repo->hash_algo->format_id;
 	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~mask=
);
-	/*
-	 * We verify names via `refs_verify_refname_available()`, so there is
-	 * no need to do the same checks in the reftable library again.
-	 */
-	refs->write_options.skip_name_check =3D 1;
=20
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
diff --git a/reftable/error.c b/reftable/error.c
index 0d1766735e..169f89d2f1 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -27,8 +27,6 @@ const char *reftable_error_str(int err)
 		return "misuse of the reftable API";
 	case REFTABLE_ZLIB_ERROR:
 		return "zlib failure";
-	case REFTABLE_NAME_CONFLICT:
-		return "file/directory conflict";
 	case REFTABLE_EMPTY_TABLE_ERROR:
 		return "wrote empty table";
 	case REFTABLE_REFNAME_ERROR:
diff --git a/reftable/refname.c b/reftable/refname.c
deleted file mode 100644
index 7570e4acf9..0000000000
--- a/reftable/refname.c
+++ /dev/null
@@ -1,209 +0,0 @@
-/*
-  Copyright 2020 Google LLC
-
-  Use of this source code is governed by a BSD-style
-  license that can be found in the LICENSE file or at
-  https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-#include "reftable-error.h"
-#include "basics.h"
-#include "refname.h"
-#include "reftable-iterator.h"
-
-struct find_arg {
-	char **names;
-	const char *want;
-};
-
-static int find_name(size_t k, void *arg)
-{
-	struct find_arg *f_arg =3D arg;
-	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
-}
-
-static int modification_has_ref(struct modification *mod, const char *name)
-{
-	struct reftable_ref_record ref =3D { NULL };
-	int err =3D 0;
-
-	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D name,
-		};
-		int idx =3D binsearch(mod->add_len, find_name, &arg);
-		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
-			return 0;
-		}
-	}
-
-	if (mod->del_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->del,
-			.want =3D name,
-		};
-		int idx =3D binsearch(mod->del_len, find_name, &arg);
-		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
-			return 1;
-		}
-	}
-
-	err =3D reftable_table_read_ref(&mod->tab, name, &ref);
-	reftable_ref_record_release(&ref);
-	return err;
-}
-
-static void modification_release(struct modification *mod)
-{
-	/* don't delete the strings themselves; they're owned by ref records.
-	 */
-	FREE_AND_NULL(mod->add);
-	FREE_AND_NULL(mod->del);
-	mod->add_len =3D 0;
-	mod->del_len =3D 0;
-}
-
-static int modification_has_ref_with_prefix(struct modification *mod,
-					    const char *prefix)
-{
-	struct reftable_iterator it =3D { NULL };
-	struct reftable_ref_record ref =3D { NULL };
-	int err =3D 0;
-
-	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D prefix,
-		};
-		int idx =3D binsearch(mod->add_len, find_name, &arg);
-		if (idx < mod->add_len &&
-		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
-			goto done;
-	}
-	err =3D reftable_table_seek_ref(&mod->tab, &it, prefix);
-	if (err)
-		goto done;
-
-	while (1) {
-		err =3D reftable_iterator_next_ref(&it, &ref);
-		if (err)
-			goto done;
-
-		if (mod->del_len > 0) {
-			struct find_arg arg =3D {
-				.names =3D mod->del,
-				.want =3D ref.refname,
-			};
-			int idx =3D binsearch(mod->del_len, find_name, &arg);
-			if (idx < mod->del_len &&
-			    !strcmp(ref.refname, mod->del[idx])) {
-				continue;
-			}
-		}
-
-		if (strncmp(ref.refname, prefix, strlen(prefix))) {
-			err =3D 1;
-			goto done;
-		}
-		err =3D 0;
-		goto done;
-	}
-
-done:
-	reftable_ref_record_release(&ref);
-	reftable_iterator_destroy(&it);
-	return err;
-}
-
-static int validate_refname(const char *name)
-{
-	while (1) {
-		char *next =3D strchr(name, '/');
-		if (!*name) {
-			return REFTABLE_REFNAME_ERROR;
-		}
-		if (!next) {
-			return 0;
-		}
-		if (next - name =3D=3D 0 || (next - name =3D=3D 1 && *name =3D=3D '.') ||
-		    (next - name =3D=3D 2 && name[0] =3D=3D '.' && name[1] =3D=3D '.'))
-			return REFTABLE_REFNAME_ERROR;
-		name =3D next + 1;
-	}
-	return 0;
-}
-
-int validate_ref_record_addition(struct reftable_table tab,
-				 struct reftable_ref_record *recs, size_t sz)
-{
-	struct modification mod =3D {
-		.tab =3D tab,
-		.add =3D reftable_calloc(sz, sizeof(*mod.add)),
-		.del =3D reftable_calloc(sz, sizeof(*mod.del)),
-	};
-	int i =3D 0;
-	int err =3D 0;
-	for (; i < sz; i++) {
-		if (reftable_ref_record_is_deletion(&recs[i])) {
-			mod.del[mod.del_len++] =3D recs[i].refname;
-		} else {
-			mod.add[mod.add_len++] =3D recs[i].refname;
-		}
-	}
-
-	err =3D modification_validate(&mod);
-	modification_release(&mod);
-	return err;
-}
-
-static void strbuf_trim_component(struct strbuf *sl)
-{
-	while (sl->len > 0) {
-		int is_slash =3D (sl->buf[sl->len - 1] =3D=3D '/');
-		strbuf_setlen(sl, sl->len - 1);
-		if (is_slash)
-			break;
-	}
-}
-
-int modification_validate(struct modification *mod)
-{
-	struct strbuf slashed =3D STRBUF_INIT;
-	int err =3D 0;
-	int i =3D 0;
-	for (; i < mod->add_len; i++) {
-		err =3D validate_refname(mod->add[i]);
-		if (err)
-			goto done;
-		strbuf_reset(&slashed);
-		strbuf_addstr(&slashed, mod->add[i]);
-		strbuf_addstr(&slashed, "/");
-
-		err =3D modification_has_ref_with_prefix(mod, slashed.buf);
-		if (err =3D=3D 0) {
-			err =3D REFTABLE_NAME_CONFLICT;
-			goto done;
-		}
-		if (err < 0)
-			goto done;
-
-		strbuf_reset(&slashed);
-		strbuf_addstr(&slashed, mod->add[i]);
-		while (slashed.len) {
-			strbuf_trim_component(&slashed);
-			err =3D modification_has_ref(mod, slashed.buf);
-			if (err =3D=3D 0) {
-				err =3D REFTABLE_NAME_CONFLICT;
-				goto done;
-			}
-			if (err < 0)
-				goto done;
-		}
-	}
-	err =3D 0;
-done:
-	strbuf_release(&slashed);
-	return err;
-}
diff --git a/reftable/refname.h b/reftable/refname.h
deleted file mode 100644
index a24b40fcb4..0000000000
--- a/reftable/refname.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
-  Copyright 2020 Google LLC
-
-  Use of this source code is governed by a BSD-style
-  license that can be found in the LICENSE file or at
-  https://developers.google.com/open-source/licenses/bsd
-*/
-#ifndef REFNAME_H
-#define REFNAME_H
-
-#include "reftable-record.h"
-#include "reftable-generic.h"
-
-struct modification {
-	struct reftable_table tab;
-
-	char **add;
-	size_t add_len;
-
-	char **del;
-	size_t del_len;
-};
-
-int validate_ref_record_addition(struct reftable_table tab,
-				 struct reftable_ref_record *recs, size_t sz);
-
-int modification_validate(struct modification *mod);
-
-#endif
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
deleted file mode 100644
index b9cc62554e..0000000000
--- a/reftable/refname_test.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "basics.h"
-#include "block.h"
-#include "blocksource.h"
-#include "reader.h"
-#include "record.h"
-#include "refname.h"
-#include "reftable-error.h"
-#include "reftable-writer.h"
-#include "system.h"
-
-#include "test_framework.h"
-#include "reftable-tests.h"
-
-struct testcase {
-	char *add;
-	char *del;
-	int error_code;
-};
-
-static void test_conflict(void)
-{
-	struct reftable_write_options opts =3D { 0 };
-	struct strbuf buf =3D STRBUF_INIT;
-	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-	struct reftable_ref_record rec =3D {
-		.refname =3D "a/b",
-		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "destination", /* make sure it's not a symref.
-						*/
-		.update_index =3D 1,
-	};
-	int err;
-	int i;
-	struct reftable_block_source source =3D { NULL };
-	struct reftable_reader *rd =3D NULL;
-	struct reftable_table tab =3D { NULL };
-	struct testcase cases[] =3D {
-		{ "a/b/c", NULL, REFTABLE_NAME_CONFLICT },
-		{ "b", NULL, 0 },
-		{ "a", NULL, REFTABLE_NAME_CONFLICT },
-		{ "a", "a/b", 0 },
-
-		{ "p/", NULL, REFTABLE_REFNAME_ERROR },
-		{ "p//q", NULL, REFTABLE_REFNAME_ERROR },
-		{ "p/./q", NULL, REFTABLE_REFNAME_ERROR },
-		{ "p/../q", NULL, REFTABLE_REFNAME_ERROR },
-
-		{ "a/b/c", "a/b", 0 },
-		{ NULL, "a//b", 0 },
-	};
-	reftable_writer_set_limits(w, 1, 1);
-
-	err =3D reftable_writer_add_ref(w, &rec);
-	EXPECT_ERR(err);
-
-	err =3D reftable_writer_close(w);
-	EXPECT_ERR(err);
-	reftable_writer_free(w);
-
-	block_source_from_strbuf(&source, &buf);
-	err =3D reftable_new_reader(&rd, &source, "filename");
-	EXPECT_ERR(err);
-
-	reftable_table_from_reader(&tab, rd);
-
-	for (i =3D 0; i < ARRAY_SIZE(cases); i++) {
-		struct modification mod =3D {
-			.tab =3D tab,
-		};
-
-		if (cases[i].add) {
-			mod.add =3D &cases[i].add;
-			mod.add_len =3D 1;
-		}
-		if (cases[i].del) {
-			mod.del =3D &cases[i].del;
-			mod.del_len =3D 1;
-		}
-
-		err =3D modification_validate(&mod);
-		EXPECT(err =3D=3D cases[i].error_code);
-	}
-
-	reftable_reader_free(rd);
-	strbuf_release(&buf);
-}
-
-int refname_test_main(int argc, const char *argv[])
-{
-	RUN_TEST(test_conflict);
-	return 0;
-}
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 4c457aaaf8..3a5f5b92c6 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -48,9 +48,6 @@ enum reftable_error {
 	/* Wrote a table without blocks. */
 	REFTABLE_EMPTY_TABLE_ERROR =3D -8,
=20
-	/* Dir/file conflict. */
-	REFTABLE_NAME_CONFLICT =3D -9,
-
 	/* Invalid ref name. */
 	REFTABLE_REFNAME_ERROR =3D -10,
=20
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 0019cbcfa4..114cc3d053 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -14,7 +14,6 @@ int block_test_main(int argc, const char **argv);
 int merged_test_main(int argc, const char **argv);
 int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
-int refname_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
 int tree_test_main(int argc, const char **argv);
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 7c7cae5f99..3c119e2bbb 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -38,10 +38,6 @@ struct reftable_write_options {
 	/* Default mode for creating files. If unset, use 0666 (+umask) */
 	unsigned int default_permissions;
=20
-	/* boolean: do not check ref names for validity or dir/file conflicts.
-	 */
-	unsigned skip_name_check : 1;
-
 	/* boolean: copy log messages exactly. If unset, check that the message
 	 *   is a single line, and add '\n' if missing.
 	 */
diff --git a/reftable/stack.c b/reftable/stack.c
index 1ecf1b9751..e264df5ced 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -12,8 +12,8 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "merged.h"
 #include "reader.h"
-#include "refname.h"
 #include "reftable-error.h"
+#include "reftable-generic.h"
 #include "reftable-record.h"
 #include "reftable-merged.h"
 #include "writer.h"
@@ -27,8 +27,6 @@ static int stack_write_compact(struct reftable_stack *st,
 			       struct reftable_writer *wr,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config);
-static int stack_check_addition(struct reftable_stack *st,
-				const char *new_tab_name);
 static void reftable_addition_close(struct reftable_addition *add);
 static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 					     int reuse_open);
@@ -781,10 +779,6 @@ int reftable_addition_add(struct reftable_addition *ad=
d,
 		goto done;
 	}
=20
-	err =3D stack_check_addition(add->stack, get_tempfile_path(tab_file));
-	if (err < 0)
-		goto done;
-
 	if (wr->min_update_index < add->next_update_index) {
 		err =3D REFTABLE_API_ERROR;
 		goto done;
@@ -1340,65 +1334,6 @@ int reftable_stack_read_log(struct reftable_stack *s=
t, const char *refname,
 	return err;
 }
=20
-static int stack_check_addition(struct reftable_stack *st,
-				const char *new_tab_name)
-{
-	int err =3D 0;
-	struct reftable_block_source src =3D { NULL };
-	struct reftable_reader *rd =3D NULL;
-	struct reftable_table tab =3D { NULL };
-	struct reftable_ref_record *refs =3D NULL;
-	struct reftable_iterator it =3D { NULL };
-	int cap =3D 0;
-	int len =3D 0;
-	int i =3D 0;
-
-	if (st->config.skip_name_check)
-		return 0;
-
-	err =3D reftable_block_source_from_file(&src, new_tab_name);
-	if (err < 0)
-		goto done;
-
-	err =3D reftable_new_reader(&rd, &src, new_tab_name);
-	if (err < 0)
-		goto done;
-
-	err =3D reftable_reader_seek_ref(rd, &it, "");
-	if (err > 0) {
-		err =3D 0;
-		goto done;
-	}
-	if (err < 0)
-		goto done;
-
-	while (1) {
-		struct reftable_ref_record ref =3D { NULL };
-		err =3D reftable_iterator_next_ref(&it, &ref);
-		if (err > 0)
-			break;
-		if (err < 0)
-			goto done;
-
-		REFTABLE_ALLOC_GROW(refs, len + 1, cap);
-		refs[len++] =3D ref;
-	}
-
-	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
-
-	err =3D validate_ref_record_addition(tab, refs, len);
-
-done:
-	for (i =3D 0; i < len; i++) {
-		reftable_ref_record_release(&refs[i]);
-	}
-
-	free(refs);
-	reftable_iterator_destroy(&it);
-	reftable_reader_free(rd);
-	return err;
-}
-
 static int is_table_name(const char *s)
 {
 	const char *dot =3D strrchr(s, '.');
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 0dc9a44648..b88097c3b6 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -353,44 +353,6 @@ static void test_reftable_stack_transaction_api_perfor=
ms_auto_compaction(void)
 	clear_dir(dir);
 }
=20
-static void test_reftable_stack_validate_refname(void)
-{
-	struct reftable_write_options cfg =3D { 0 };
-	struct reftable_stack *st =3D NULL;
-	int err;
-	char *dir =3D get_tmp_dir(__LINE__);
-
-	int i;
-	struct reftable_ref_record ref =3D {
-		.refname =3D "a/b",
-		.update_index =3D 1,
-		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
-	};
-	char *additions[] =3D { "a", "a/b/c" };
-
-	err =3D reftable_new_stack(&st, dir, cfg);
-	EXPECT_ERR(err);
-
-	err =3D reftable_stack_add(st, &write_test_ref, &ref);
-	EXPECT_ERR(err);
-
-	for (i =3D 0; i < ARRAY_SIZE(additions); i++) {
-		struct reftable_ref_record ref =3D {
-			.refname =3D additions[i],
-			.update_index =3D 1,
-			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
-		};
-
-		err =3D reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT(err =3D=3D REFTABLE_NAME_CONFLICT);
-	}
-
-	reftable_stack_destroy(st);
-	clear_dir(dir);
-}
-
 static int write_error(struct reftable_writer *wr, void *arg)
 {
 	return *((int *)arg);
@@ -1097,7 +1059,6 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
-	RUN_TEST(test_reftable_stack_validate_refname);
 	RUN_TEST(test_sizes_to_segments);
 	RUN_TEST(test_sizes_to_segments_all_equal);
 	RUN_TEST(test_sizes_to_segments_empty);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 00237ef0d9..bae731669c 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -13,7 +13,6 @@ int cmd__reftable(int argc, const char **argv)
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
-	refname_test_main(argc, argv);
 	return 0;
 }
=20
--=20
2.44.GIT


--YclY7MuovtiMbJJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPyQACgkQVbJhu7ck
PpRQChAAih4IdgSjDxuRV0KEJyfkoiIUnD6gsdY8PFvFNyDCOsmMMGI4LiMHLmpG
RDP2kPPKn5CSnuFfA0Rwxxm4QE3co1RhhYY+qlJrj9Lq4G/PuF/tcYKw2gkYD7nF
c0rp0xr5ssFlD7OU3lZz9ZM1RP02uk8q3dOFC+eOI26lqYp4h50noZdAcJfHjyVR
e9fJx5vCVy9hnmaJD7qqLH3txLFnIWo+V+xjphx5WSH6rMPZw/6TtZBPnbEQbSxb
GFLINXCtihx11FsDRPfOKaHMqrObtm5gJKB72xukVMqPLwLtPYvuuHloIX37f+vG
GkR4L2JVCNEy8ka2vXg6Abdj/5lZfCTsfdWksFl7+08xUaf/8z+FhMiOWcuYYIKe
wXUnhO882+VXZ1O1zUqZoHUnfgUzUf85FTEVhQlYszoVPFmj2UE+z66G1Ehaqgqj
VCSEbEqqEL6m6AJ5xd8Wwo1pJM0sfnK4F6jfgmizRIUkZ1fPA+3laZXVn8xBoLn9
+IEnXiO7N56EDxIZZJXMzW0wi0YXPG0oaiPcmStxLAn/gKPb5PGfGeHLMULmBLQ5
xA3qrXH/ys6c2h2WUBa0+rvY4qEKlCmSNh8Ubnj8I9MCKiqLBS/Y5N+4/lZdjXeu
gd/QSGP34jybl9vpKN+IlVVSRfk8OUMFhChRJY2tmeizsMjCEig=
=Jrqr
-----END PGP SIGNATURE-----

--YclY7MuovtiMbJJZ--
