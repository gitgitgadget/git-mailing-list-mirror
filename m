Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D16BB23
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579053; cv=none; b=nhiK9rUzGHMV12cwazDCyoTFPxlkr+P53jTxgXgUsW1m3g7WHa0avNEWlFMlmXHooCdazakASYOqBfWd3nIEKCQUO3Lz9yoS8fssFBZ+5lmnbHm7s7gds5UVJC5pUUChyDjIKK3o/BQbQNsMhzXwm7mG2kjvKm8ZLFbgeIz3ivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579053; c=relaxed/simple;
	bh=Hhx4iOIn1uMbW0oJpEhMXloqHv0u+EFrVisA3LyMgN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOOPOhdwH0NAJxciIWZvHl8GdHV9B1REJe8hzXHuYONRelWwJZHcoj2AAskjxkN6JSj7vwj9S4MUwflbIpo1wmSRtHiZS+7zUEyoCgcmOgcB+gFEFqAu6LZULDN9AeYO/77AItSoy/gfDNmfnJewkaAqVRkZbopmy27MGWKypeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZVzMvOJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHrSp6uM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZVzMvOJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHrSp6uM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6979911400E0;
	Mon,  8 Apr 2024 08:24:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 08:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579050; x=1712665450; bh=N1t4zfVEqR
	fazGQ3CfKlzKQ9nLul0NSJ41Crk3ULLCU=; b=ZVzMvOJJW4kRQLXI/KMKcJxVyY
	baT/ET1NHb8ug1ukxVpQ8PjoTx7+M7V0+p+dY1gAH1GpmAD3uZTvRLZe5yZT2OAx
	5B9S6336jKBXzG70nXRA4TH3C533NMo8dDj5H1N2Kf25gErXg7udMojd6v2hzboB
	bS87WFe9k5IIWv7xfJCTcWP52qbD9w1o7C+bhtP92n6Ttz8fJ1qxRRx58DDALL3D
	E+EWauxWWXRSgSIRsx2/gv3wObpCitL5AUq4AuGRISbZeFv1YKQUKqXNmRral+xB
	HNg21Mi/+A/wqQm1TGIHQstdmBVff+TUi6FMW6Q+dL2ZYmxofHIMaQc6Jp9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579050; x=1712665450; bh=N1t4zfVEqRfazGQ3CfKlzKQ9nLul
	0NSJ41Crk3ULLCU=; b=CHrSp6uMK3aOhQ3rkCi+Uwg19fkB5NjSqI0tNdpUx+ix
	WRanXrsNkjx3d0Otr1Np5KfZhKL4JihaPbW4ih6XtRpCXlSKkv34zWWqViSlvbFW
	us/DwT6IgvNnrpVbAP3AMkOT5DF8Y0CuMxufo2V7SByu5eTEm/7mz4ozdUiU69Jv
	VsPmUsBqKL7IT1GZyy+PkMmWAKPXvL/Ouhy9tYbKfDZQVtNcOq/ZgNOfjJsuzwDP
	U8cWNTZCxFZ59pIIL0yYcoxqdQrYb0UJR0FauJODYS2/MkxXPvCAMUctKrOXI92G
	ttkiw+jTgCcRasd3WsU89kEbpGCLdOPwNCqmHL4cKw==
X-ME-Sender: <xms:6uETZgP35YKRqPJHOODgoH8RFxU6vVbSOt1mC4wvi9E-zCDVoH7XCQ>
    <xme:6uETZm_6kPDqeQojZwdvOZCkIULBgM6znY1SlnKE9J67oYXct4kjoZxlpZ2gO4v1H
    eIERENunpE27xf2jw>
X-ME-Received: <xmr:6uETZnSzbsasNfLQK8YQuWEXFiDB1ppXBrIOB4EK_TWo2shF3Zsv5Hp1keLDiD4do0sIe9teCY4QL2TAvvlBINXtEFONnu5kck2LGqZ2jWGZsPVw1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeegiefhheekudeuueefjeeuteefleelje
    ekudekhfeiffejveejheefleelheffveenucffohhmrghinhepghhoohhglhgvrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6uETZosMMD5ss7c7R52o-iL_qTf-eebP4qfEvbcuDQuPGt4pv-uJiw>
    <xmx:6uETZof9Ifz00ljAcHRCLM2CZ4SiyBxgPy4CA7G6yZsczM3UxeH3sw>
    <xmx:6uETZs3Ymi-oKcRw3NHOPbmLBTGnGX79O-pJMiZx6E4eIKUfY7k2gg>
    <xmx:6uETZs8OUHl-GtxU-5N7HvO0hFprjD6WlPdxi7d38AmEqRYyudl_3w>
    <xmx:6uETZg6r5t2oJvZg7kG_aBk2NeFFXKp4Bs64jJNUHsPyKsNPWUaMdaU7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be6e92dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:02 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 04/11] reftable: remove name checks
Message-ID: <2a5f07627a445f214940bf093487af9492e27684.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QHwN8QRil86B7mOt"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--QHwN8QRil86B7mOt
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
 reftable/refname.c         | 206 -------------------------------------
 reftable/refname.h         |  29 ------
 reftable/refname_test.c    | 101 ------------------
 reftable/reftable-error.h  |   3 -
 reftable/reftable-tests.h  |   1 -
 reftable/reftable-writer.h |   4 -
 reftable/stack.c           |  67 +-----------
 reftable/stack_test.c      |  39 -------
 t/helper/test-reftable.c   |   1 -
 12 files changed, 1 insertion(+), 459 deletions(-)
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
index bbfde15754..0000000000
--- a/reftable/refname.c
+++ /dev/null
@@ -1,206 +0,0 @@
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
-struct refname_needle_lesseq_args {
-	char **haystack;
-	const char *needle;
-};
-
-static int refname_needle_lesseq(size_t k, void *_args)
-{
-	struct refname_needle_lesseq_args *args =3D _args;
-	return strcmp(args->needle, args->haystack[k]) <=3D 0;
-}
-
-static int modification_has_ref(struct modification *mod, const char *name)
-{
-	struct reftable_ref_record ref =3D { NULL };
-	int err =3D 0;
-
-	if (mod->add_len > 0) {
-		struct refname_needle_lesseq_args args =3D {
-			.haystack =3D mod->add,
-			.needle =3D name,
-		};
-		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args);
-		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
-			return 0;
-	}
-
-	if (mod->del_len > 0) {
-		struct refname_needle_lesseq_args args =3D {
-			.haystack =3D mod->del,
-			.needle =3D name,
-		};
-		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args);
-		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
-			return 1;
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
-		struct refname_needle_lesseq_args args =3D {
-			.haystack =3D mod->add,
-			.needle =3D prefix,
-		};
-		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args);
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
-			struct refname_needle_lesseq_args args =3D {
-				.haystack =3D mod->del,
-				.needle =3D ref.refname,
-			};
-			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args);
-			if (idx < mod->del_len &&
-			    !strcmp(ref.refname, mod->del[idx]))
-				continue;
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


--QHwN8QRil86B7mOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4eUACgkQVbJhu7ck
PpRq6w/9Hhyho0TkmHY0vVUfY64X+Dd9W6oLNFBp+Cbdf9gnh+6JLet32Hpac0FB
VRcZVCdEijp8cSrQEHjfZonZSvV6jk4KD1qnix/x8luT1uKxYn/V4209v86DMW8C
yLbnZXtGlhoXCRWHbwyA6A3Eo3WbV5Qzrdq26qeE3tVBkcvn7dBSHPmCohqAiPnT
kQrM96A2ufwm6vVTPDkBfbxKtj/nB6ujgiDxLX+O+bVkB7TijnH2gPWGMQqXbsij
jmO434iaJlCNL6isauuL+dMmBdY2oYyVsmSkjlrUs0+ASRgcRJCPyPIg+TwXCfhw
jGLVMZTjWKdFKNrcgkwywopf6uZ0Rvfqtz6EW1LGFXwEvA6HbhwXxWAxDLH9QiJG
AnsjfVvdcR/A1ml4/u2cM+ARXhTmRs07o6m5r/hySzSPwocNKALjLOhYj7jnqXP/
HfHEf+pbth9gue41ICNarpuzhmkxvstfcb+SmrEF6tdl19j6u4FBgN2LEGSlxQ7o
RQjVx+GfcBMGKX9343G5EGJt59ALJN9TN1M/lS331KgZf7C08KNkWeJV2vbb1FaN
bJZ2RQtyjA3HZNAowxmCzeitpzGtRvDaWhmPyKs4mrQ633NsHZiIF4G12S+SuFcZ
jusCqXovJEyjDA8P2F2uyenrf27gNlpFkTCTyEC5K67saWPeSNg=
=fz/E
-----END PGP SIGNATURE-----

--QHwN8QRil86B7mOt--
