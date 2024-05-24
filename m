Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E484E09
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545077; cv=none; b=siot0c6l5o9qyaPNk/Q0sj7MczjsKgjpYyKu+TUktzTgz1V7BH5S566IYkewe2I9LUPKrn+2VRuHl0TSFLSOjg/SpBLyULmOMmbBUdHMHCkmLf2qJSeY2evfEAmQrIaI/iEtnQIoOZSCzQalo/r4dDAHx/WimMxxxsmz+zEzfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545077; c=relaxed/simple;
	bh=ViMNPMuWnpEM9zWqDlJR8sZLP2NRW4d2BnFYVy9ra+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC8QVY0fMS+Jhg78xuG0EE8xuj7KFgnSGcx1QwZQMNTkJK6V4rdANYZq6/defWcqGAX4cj6kHt7LHAQ7iR89vWkTm7BLFL1C18ooieNBwh5UDVGLauU2brzRAnKaSoyG7E2bm+wycMlmgsucaRJ9NycVKq33SBoYv+f0N/LSYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RgBdvN5d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m63Z/Zrb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RgBdvN5d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m63Z/Zrb"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 90A00114009F;
	Fri, 24 May 2024 06:04:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 May 2024 06:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545074; x=1716631474; bh=5DmpTH/j4X
	1+s7CLay2h0GmzMJACco8JgEl//BD9jtc=; b=RgBdvN5dZ3QsoGk2AxwpQhr5iz
	0ZmTIEHtLefFuw28bMtZNH8UIx0O3GL0S0dqML+NrXF4nhzs1ghS2Wx3FET7HZpb
	yc/b0GczerEkfXDscbIYdPszdqL0HoT5ToodrSq2HeB22aL6m2dYKWwLftGozLKc
	3SbzJt3tLWBa6YirDIaDDyyhUYdB6QEId5HFgYsJaC2s14X2RM6ATw9ACzrn7GCE
	Ep5K6jo3LGWNf94GO9nsQvxbUSI0j1C4Fc/oJ7uBasy+c/I7L7KwJ51B5W84VLax
	p1y4i3muecopNcqqZ6d6NCCsfjanc35tejkbOesvgQ8cHwz16Fq0kSyfocDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545074; x=1716631474; bh=5DmpTH/j4X1+s7CLay2h0GmzMJAC
	co8JgEl//BD9jtc=; b=m63Z/ZrbvQcuwBC8fEH0fJ8g1dkNfm2w8yYOMLqYT2YX
	dU3AUW900c4l+n96fiJfwSfD4wSI0tAscY/Nrc62+TfjY0Q/VpZTHuYCL5lm4Nrd
	j/hhXe7F/px0f+MxO5AlPIdZ0u4bqge1P0gpkKT0Rajj97VmaXZ5nSRiTdnk3/7C
	LvbjO6YxoPqmGehUohL5qwe5A+QZ/PlgyHZaD/nwhxz1RHSybKZb+awjjQ9pUiPr
	c5Z8s1zmZCaPoQEPYufL+XFfeJgmHppnL8jESspmFPJBnDFipAEszg/QsAUey/WI
	nVQJBKrwiVZILEXBjPuPaWtCl3mftrM239EvWWXMJw==
X-ME-Sender: <xms:MmZQZu51-Gdp2jfifr7IjtBQ8ORkyuDk8qdUPheMngaNxMUnci0gpA>
    <xme:MmZQZn4mHOIWi97uT9pBhi_6pgxjmAlEgzbn2_fUvBo7N_yPdFcN3EKsA4Odx3IDo
    O--pMsKum4BXV3q_Q>
X-ME-Received: <xmr:MmZQZtfvGUghdmtFxZuZ5cUn6Z68icaVEomL7eBe_TAG3BEJIF8mcK6wRWl_43yQA4Q3FlMXcx6rEpf9FB-q8kXG7HKfmZZX2EDUwSRhC_Zw6lY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MmZQZrK0ndEnYA4aaIigNCpVjPdU2peAT18kZ3aklER0M49cFUrJwQ>
    <xmx:MmZQZiKg2RyUvx1rBemvwqGk3hwY6BK3dwpEm09c9twlcukleOEjxA>
    <xmx:MmZQZsxWxmpPvrc7xoIhesUjgRh7MSWfchUxJ6nPSmile-wxZK3G9g>
    <xmx:MmZQZmLOGwdnpwidSHCMIycK_Ro62zYVTDHcRgaYB7jz1phyhN0HKQ>
    <xmx:MmZQZu1JnhhVvJl7Zy_h6e8aoIflui1ZyigHKdm_Es7dBhqKWxo1un-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 42748966 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:30 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/21] strvec: add functions to replace and remove strings
Message-ID: <128e2eaf7a03fe0dc203c2e505d96b11c26ff60a.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MXjKd/W3gMjakcF/"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--MXjKd/W3gMjakcF/
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
2.45.1.216.g4365c6fcf9.dirty


--MXjKd/W3gMjakcF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZi4ACgkQVbJhu7ck
PpRznQ/9EraDsfrOqwjlkCsX1NMRaiXcuPgrW6Hq2e1hfTXyT8jJliKpAw59lt3E
qapDjAsSneLXx5CDz4ycjbztMMVsizz0/VSk40roDHuh9AyNlkoiS1TNogyBBoz2
g2BJgRNVbVsjLrC0mQygWS+Szn8NsyXncJyyF5iO69eBv5/64ZKSIFsFP3z3T5wz
82yFDdPg3vPFr33P/htvbbZQsSPJuBt8p4B0OOEnv8X7TbIdufUYv2pmal74MyL3
tP9wo55f6aZMuE1uuZV1I9HlS4YASZSwNuXadvNm8WUULZUNxV5kKofgJV783hQ5
p2ciZ85oTRtzs0Upmm2NhlUdhGxDgS7Rm8gyjj6HIcfVZlyX3gjA+yhDlBD/Y2yj
vrF/dbUHTHfnqjXvAnK1YMfOZL8XtiS6qu/z6qe1xZng7f7WYVs4zqQmDHcIA8qI
xcDxwhVXMCGQZEL5YzsoDGQgVB3mbUBToPrMcjm0V61B4TwrhHrceabLIKQuO6s9
VZootsQiImF1AdeW+RCRu3eUJAn8KSc9cBW2nkkJfFmm4NNuBGEzZH3TeX9dYr9j
rjNgfOl3jHdua+fr73Si4QubawInoVrQRbLZqAIFny6x+MjguVHajgaa1oc0oEp9
XfzWH+peycBzqQqRIcQO5bQK1MTfTYetGF1npgpm4asP3g7d2b4=
=C5GE
-----END PGP SIGNATURE-----

--MXjKd/W3gMjakcF/--
