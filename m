Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75B152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810430; cv=none; b=PVHS3PZe9d/KwNSj86bA8ejN2B9c/GgmzbUpDHM3V1Vizy2eTXkG16dKhSM1HzvgPkYbpqtOp3s5gACX253oaQXa7/IZqb/vSnAyUxN3AgAak2xULTelLP77VLhW6iy3FffwXQoIkLbHNvWicBLi753YdM2U3+TAswGmRW3RUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810430; c=relaxed/simple;
	bh=Rat0pqM2tEYaOXEn9lzkvVlrpYE83yfLKtcdbV3Rcvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skc/alcNsij8cEO7EddMriv0J52uOFv7tn7fSpxzJ8LMbiqzBv2XFmH7JZWqMpCnruLjmiyMNI04NNhOc/WY78t5niY2pJRVz1d3+Vrnd4oqn5QssKv/NepD1kpBhwZ1Q+4DzvsKdbrV1DhFXDvSEtSZrC9c+VbDmUxCv+12uMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GE6auMX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpgWdOpc; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GE6auMX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpgWdOpc"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1E70E1C000AF;
	Mon, 27 May 2024 07:47:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 May 2024 07:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810427; x=1716896827; bh=T4i/tw5+bc
	VWL8EsYgyjcjMyEIJ5tpRrmarDwVsXUYA=; b=GE6auMX6qgMaQiQxGwahW51YFd
	Pwzyx+hm/crRzRCC1s3kWMHVG6KxD/iKCfMJk3SPFTI/aPfyuRGTYFSZAmFNF9Xm
	XCI/soWdXnrZhDSvquYWfzXKXSVjI1sUdAZGS6ZH8xURRBIyeL6zK7q7apsz/SUx
	rzvAVce7lXx3wUxZGGxoUR3paxCi2NWRVbgrFQSJBANfmaORcqpGjKAvL9/3rwRw
	Qqj9ZbbkrQJlg793rZUKAZBF6r42B5uDmaF2G0qH+UKAMcq9/zz9LmCCMFLH1bTz
	T3sCjQ93UBi4EfYRUy8mEufrPCItrWpp1KKXtoMZn+1qtZyfSa3i3KtHuVnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810427; x=1716896827; bh=T4i/tw5+bcVWL8EsYgyjcjMyEIJ5
	tpRrmarDwVsXUYA=; b=SpgWdOpcNreeeBG2NoQHm8BlUZDqdVY76e/uR0Jc+dp+
	9XoHBM0w8lQfdY/WSSmvTMTOpeN7DmrW1K/Re0FZ567iI9QOYHqkQMs2/YptcO4v
	cyim/Fo7OCLJWHM4BzpuuxHjKf8uo1j22w3VloJmI57it42GZAuO6J1y45O15Q7o
	ahXyNJU9cj7YfaX0igxhQeDZTbxfpP0Dcd/JFLX+I5YZulLQaPJ0Z9EYQteCKe9S
	rhVExH7qPh/N22hL5esvwLxTB8Z80U/jyIFXzV9NWuirSJ38H9BLR9gcmJrgkA9P
	Enzt0xGHDzUBWCkR90dCQULC18sX5Z4Kpx2A49M9Eg==
X-ME-Sender: <xms:u3JUZv63RnzvlnL_uk4Ku1cWCVrvW8-orne9-obahgshle-YVyKMRQ>
    <xme:u3JUZk6niJ1nMWcrvVIy4wT3iFt8utCYpe7aSfsNRjC7JcnvOLiU51SK5HTletD9t
    Rt6HCqtdVuWrHDDwg>
X-ME-Received: <xmr:u3JUZmeox7C2ZqiZCUDrrOfeEPYThPymY0PQC8jpmaDG8uA2UTHN4-H0S0EDD2XltiUl_XoFMKMywIW8XVEkf0BA7fVHMhJr4jLRbQ9Zm7VPX11kz14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:u3JUZgKqJnyt2rfpnieOIO1IVgCRfrqGRQ7DZ8aEjz4isovB74lEvA>
    <xmx:u3JUZjLzT0sGA4pEO6JWCk17tcUrr6mDxpktzFOaxYpmSgNunrsLQg>
    <xmx:u3JUZpwUiPR3DqhdzcIAENhn6FSfaNzDx4hQF9LXX3dSCqSJoqQUiA>
    <xmx:u3JUZvJ_4hpr4ZFQ1ELZLpamkh86HZx6JvmO-8_ltQzIovH2_pea-A>
    <xmx:u3JUZpibj8fP24KAAaj_txorjJt3b-GLeMENrWYM_xYDM8udUKRUNvTi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:47:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 59590790 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:56 +0000 (UTC)
Date: Mon, 27 May 2024 13:47:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 17/21] strvec: add functions to replace and remove strings
Message-ID: <0f61ee9929ab70d5231af28f118c3b395546d570.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3DtDly4Xoq2UK8H0"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--3DtDly4Xoq2UK8H0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add two functions that allow to replace and remove strings contained in
the strvec. This will be used by a subsequent commit that refactors
git-mv(1).

While at it, add a bunch of unit tests that cover both old and new
functionality.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                |   1 +
 strvec.c                |  20 +++
 strvec.h                |  13 ++
 t/unit-tests/t-strvec.c | 269 ++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/test-lib.c |  13 ++
 t/unit-tests/test-lib.h |  13 ++
 6 files changed, 329 insertions(+)
 create mode 100644 t/unit-tests/t-strvec.c

diff --git a/Makefile b/Makefile
index cf504963c2..d4000fb1d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
=20
 UNIT_TEST_PROGRAMS +=3D t-mem-pool
 UNIT_TEST_PROGRAMS +=3D t-strbuf
+UNIT_TEST_PROGRAMS +=3D t-strvec
 UNIT_TEST_PROGRAMS +=3D t-ctype
 UNIT_TEST_PROGRAMS +=3D t-prio-queue
 UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS=
))
diff --git a/strvec.c b/strvec.c
index 178f4f3748..d4073ec9fa 100644
--- a/strvec.c
+++ b/strvec.c
@@ -56,6 +56,26 @@ void strvec_pushv(struct strvec *array, const char **ite=
ms)
 		strvec_push(array, *items);
 }
=20
+const char *strvec_replace(struct strvec *array, size_t idx, const char *r=
eplacement)
+{
+	char *to_free;
+	if (idx >=3D array->nr)
+		BUG("index outside of array boundary");
+	to_free =3D (char *) array->v[idx];
+	array->v[idx] =3D xstrdup(replacement);
+	free(to_free);
+	return array->v[idx];
+}
+
+void strvec_remove(struct strvec *array, size_t idx)
+{
+	if (idx >=3D array->nr)
+		BUG("index outside of array boundary");
+	free((char *)array->v[idx]);
+	memmove(array->v + idx, array->v + idx + 1, (array->nr - idx) * sizeof(ch=
ar *));
+	array->nr--;
+}
+
 void strvec_pop(struct strvec *array)
 {
 	if (!array->nr)
diff --git a/strvec.h b/strvec.h
index 4715d3e51f..6c7e8b7d50 100644
--- a/strvec.h
+++ b/strvec.h
@@ -64,6 +64,19 @@ void strvec_pushl(struct strvec *, ...);
 /* Push a null-terminated array of strings onto the end of the array. */
 void strvec_pushv(struct strvec *, const char **);
=20
+/**
+ * Replace the value at the given index with a new value. The index must be
+ * valid. Returns a pointer to the inserted value.
+ */
+const char *strvec_replace(struct strvec *array, size_t idx, const char *r=
eplacement);
+
+/*
+ * Remove the value at the given index. The remainder of the array will be
+ * moved to fill the resulting gap. The provided index must point into the
+ * array.
+ */
+void strvec_remove(struct strvec *array, size_t idx);
+
 /**
  * Remove the final element from the array. If there are no
  * elements in the array, do nothing.
diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
new file mode 100644
index 0000000000..f17fb10d9e
--- /dev/null
+++ b/t/unit-tests/t-strvec.c
@@ -0,0 +1,269 @@
+#include "test-lib.h"
+#include "strbuf.h"
+#include "strvec.h"
+
+#define check_strvec(vec, ...) \
+	check_strvec_loc(TEST_LOCATION(), vec, __VA_ARGS__)
+static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
+{
+	va_list ap;
+	size_t nr =3D 0;
+
+	va_start(ap, vec);
+	while (1) {
+		const char *str =3D va_arg(ap, const char *);
+		if (!str)
+			break;
+
+		if (!check_uint(vec->nr, >, nr) ||
+		    !check_uint(vec->alloc, >, nr) ||
+		    !check_str(vec->v[nr], str)) {
+			struct strbuf msg =3D STRBUF_INIT;
+			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
+			test_assert(loc, msg.buf, 0);
+			strbuf_release(&msg);
+			return;
+		}
+
+		nr++;
+	}
+
+	check_uint(vec->nr, =3D=3D, nr);
+	check_uint(vec->alloc, >=3D, nr);
+	check_pointer_eq(vec->v[nr], NULL);
+}
+
+static void t_static_init(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	check_pointer_eq(vec.v, empty_strvec);
+	check_uint(vec.nr, =3D=3D, 0);
+	check_uint(vec.alloc, =3D=3D, 0);
+}
+
+static void t_dynamic_init(void)
+{
+	struct strvec vec;
+	strvec_init(&vec);
+	check_pointer_eq(vec.v, empty_strvec);
+	check_uint(vec.nr, =3D=3D, 0);
+	check_uint(vec.alloc, =3D=3D, 0);
+}
+
+static void t_clear(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_push(&vec, "foo");
+	strvec_clear(&vec);
+	check_pointer_eq(vec.v, empty_strvec);
+	check_uint(vec.nr, =3D=3D, 0);
+	check_uint(vec.alloc, =3D=3D, 0);
+}
+
+static void t_push(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+
+	strvec_push(&vec, "foo");
+	check_strvec(&vec, "foo", NULL);
+
+	strvec_push(&vec, "bar");
+	check_strvec(&vec, "foo", "bar", NULL);
+
+	strvec_clear(&vec);
+}
+
+static void t_pushf(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushf(&vec, "foo: %d", 1);
+	check_strvec(&vec, "foo: 1", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_pushl(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	check_strvec(&vec, "foo", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_pushv(void)
+{
+	const char *strings[] =3D {
+		"foo", "bar", "baz", NULL,
+	};
+	struct strvec vec =3D STRVEC_INIT;
+
+	strvec_pushv(&vec, strings);
+	check_strvec(&vec, "foo", "bar", "baz", NULL);
+
+	strvec_clear(&vec);
+}
+
+static void t_replace_at_head(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_replace(&vec, 0, "replaced");
+	check_strvec(&vec, "replaced", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_replace_at_tail(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_replace(&vec, 2, "replaced");
+	check_strvec(&vec, "foo", "bar", "replaced", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_replace_in_between(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_replace(&vec, 1, "replaced");
+	check_strvec(&vec, "foo", "replaced", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_replace_with_substring(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", NULL);
+	strvec_replace(&vec, 0, vec.v[0] + 1);
+	check_strvec(&vec, "oo", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_remove_at_head(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_remove(&vec, 0);
+	check_strvec(&vec, "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_remove_at_tail(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_remove(&vec, 2);
+	check_strvec(&vec, "foo", "bar", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_remove_in_between(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_remove(&vec, 1);
+	check_strvec(&vec, "foo", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_pop_empty_array(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pop(&vec);
+	check_strvec(&vec, NULL);
+	strvec_clear(&vec);
+}
+
+static void t_pop_non_empty_array(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_pop(&vec);
+	check_strvec(&vec, "foo", "bar", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_split_empty_string(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_split(&vec, "");
+	check_strvec(&vec, NULL);
+	strvec_clear(&vec);
+}
+
+static void t_split_single_item(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_split(&vec, "foo");
+	check_strvec(&vec, "foo", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_split_multiple_items(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_split(&vec, "foo bar baz");
+	check_strvec(&vec, "foo", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_split_whitespace_only(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_split(&vec, " \t\n");
+	check_strvec(&vec, NULL);
+	strvec_clear(&vec);
+}
+
+static void t_split_multiple_consecutive_whitespaces(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	strvec_split(&vec, "foo\n\t bar");
+	check_strvec(&vec, "foo", "bar", NULL);
+	strvec_clear(&vec);
+}
+
+static void t_detach(void)
+{
+	struct strvec vec =3D STRVEC_INIT;
+	const char **detached;
+
+	strvec_push(&vec, "foo");
+
+	detached =3D strvec_detach(&vec);
+	check_str(detached[0], "foo");
+	check_pointer_eq(detached[1], NULL);
+
+	check_pointer_eq(vec.v, empty_strvec);
+	check_uint(vec.nr, =3D=3D, 0);
+	check_uint(vec.alloc, =3D=3D, 0);
+
+	free((char *) detached[0]);
+	free(detached);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(t_static_init(), "static initialization");
+	TEST(t_dynamic_init(), "dynamic initialization");
+	TEST(t_clear(), "clear");
+	TEST(t_push(), "push");
+	TEST(t_pushf(), "pushf");
+	TEST(t_pushl(), "pushl");
+	TEST(t_pushv(), "pushv");
+	TEST(t_replace_at_head(), "replace at head");
+	TEST(t_replace_in_between(), "replace in between");
+	TEST(t_replace_at_tail(), "replace at tail");
+	TEST(t_replace_with_substring(), "replace with substring");
+	TEST(t_remove_at_head(), "remove at head");
+	TEST(t_remove_in_between(), "remove in between");
+	TEST(t_remove_at_tail(), "remove at tail");
+	TEST(t_pop_empty_array(), "pop with empty array");
+	TEST(t_pop_non_empty_array(), "pop with non-empty array");
+	TEST(t_split_empty_string(), "split empty string");
+	TEST(t_split_single_item(), "split single item");
+	TEST(t_split_multiple_items(), "split multiple items");
+	TEST(t_split_whitespace_only(), "split whitespace only");
+	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecut=
ive whitespaces");
+	TEST(t_detach(), "detach");
+	return test_done();
+}
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 66d6980ffb..3c513ce59a 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -318,6 +318,19 @@ int check_bool_loc(const char *loc, const char *check,=
 int ok)
=20
 union test__tmp test__tmp[2];
=20
+int check_pointer_eq_loc(const char *loc, const char *check, int ok,
+			 const void *a, const void *b)
+{
+	int ret =3D test_assert(loc, check, ok);
+
+	if (!ret) {
+		test_msg("   left: %p", a);
+		test_msg("  right: %p", b);
+	}
+
+	return ret;
+}
+
 int check_int_loc(const char *loc, const char *check, int ok,
 		  intmax_t a, intmax_t b)
 {
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index a8f07ae0b7..2de6d715d5 100644
--- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -75,6 +75,18 @@ int test_assert(const char *location, const char *check,=
 int ok);
 	check_bool_loc(TEST_LOCATION(), #x, x)
 int check_bool_loc(const char *loc, const char *check, int ok);
=20
+/*
+ * Compare two integers. Prints a message with the two values if the
+ * comparison fails. NB this is not thread safe.
+ */
+#define check_pointer_eq(a, b)						\
+	(test__tmp[0].p =3D (a), test__tmp[1].p =3D (b),			\
+	 check_pointer_eq_loc(TEST_LOCATION(), #a" =3D=3D "#b,		\
+			      test__tmp[0].p =3D=3D test__tmp[1].p,		\
+			      test__tmp[0].p, test__tmp[1].p))
+int check_pointer_eq_loc(const char *loc, const char *check, int ok,
+			 const void *a, const void *b);
+
 /*
  * Compare two integers. Prints a message with the two values if the
  * comparison fails. NB this is not thread safe.
@@ -136,6 +148,7 @@ union test__tmp {
 	intmax_t i;
 	uintmax_t u;
 	char c;
+	const void *p;
 };
=20
 extern union test__tmp test__tmp[2];
--=20
2.45.1.246.gb9cfe4845c.dirty


--3DtDly4Xoq2UK8H0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcrcACgkQVbJhu7ck
PpQRcRAAiaNTD3jREsqMkMMw2CFCy3UPqhDkdNua8O9h/ZqQHdCqcjHwhwivmERq
47gCgYKWaj10L0iFbuJ9pvQ7LgCT71YkXnHc+XnWkUMuwr/z9nbEiw547cg/DNkw
c+DscYZzbNdfVtt21TjxGg53vt+zgc35DQe1Mp4qANjPBisJvbYybwoIfohzCPGN
0UbfBFiI+c9RzrwaTEQeLVyKfXANw8L1NAHvt/ws4//YrEnPiBZI2gy9bUs7j14L
pPk2l2MCINeAnk5BaLNPyJ3PV9ERUp0rsDO3YW1c6AuwsrCydQLd6N73XAV2wAUQ
Zj+OT9zRR1pnP7jNuXAvBv4Qi0163uod1wXpec1NtoxoDmhFTup6NqOsoi1ROWrh
KoBmdpeHINiyJgBj3eNU65ZzvsryfKb+GSC56lXM0IdbDneD8TWpZBTTYey7Sws3
skPy3dTyX//ZvuhuNyKrdISW8DKLGLEhn8eX7yEN6I+ZbN3fPMPoV9QbeRE1DTQZ
KdoFKB5x7VG3PfPXKZ46cAMhMi+y1iwi9o1WCMIOe5yuJ0aC+kcgtWXhyTUdWA1S
vS6BYDVkSQcd1xNcXP6pdE1Lmly+V61OSO8/K3/pP5EDUjeckkQMxZbLfT0pOz75
c63cfp2G5XznzooIoEkcSHHCOL+jBIwcz1pnu4jKbtBKXW/6/Uc=
=PNQb
-----END PGP SIGNATURE-----

--3DtDly4Xoq2UK8H0--
