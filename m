Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EC13C693
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467193; cv=none; b=Esn7VUhRxeq8VwgADZ496D1913jULH5rOqFeK995TDk4Psl8S45z2k3/aL2thFHQtaPAeed6asvebNFKcJHlbGzuCsaz951eARxAMDG5yrVCXYujlTBCsiz0N0CQ3vftFTuKhum/RO+QsofEbizH6Ct3JXdExYiYzkXqqhPfj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467193; c=relaxed/simple;
	bh=kRpQQY4BqaReMukg9E5L6R+bLdohl4s8PG8a12fL5Dg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNtmg6UJ2508AYLlBGQhaCI0H+ohQgkcd5IcoNqySkq6dSDjeYmLm0xLdDx3kkw9QZal5s1x4BBsv3VJznHDGnSDzoZLj26uo098jLn0DM8av3hmyKcDlA2HDvFHJmrlwBeCf2C57Hje0WaYacpWZlLD5CRNVqOVeDWh5lxvd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qo3slZ4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJT1dd3Z; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qo3slZ4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJT1dd3Z"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 7F78A1C00175
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 May 2024 08:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467191; x=1716553591; bh=YCxeqQgVvv
	2I16GG0T9nOsPPe+zQXhyUY1aoQfmYBYY=; b=Qo3slZ4DnFtGt4gJX9ES5U7/iM
	oWScTmyr3eHZ8s6devkUee7xiBkQEqYVAtAmev8oohlh9xbi0sQZi1+Tx9oQ0CIw
	carohJfOswYtP5pOWwZ7cWAdtjm4fkq/62NBDnjezbPfHSjE+WMYm2mzJZelpf+H
	xiZeBnjRZh7HktuSgE4H0OenjY7W6xMsyuNwX7NxOhEkHN4e1P9b2Mqv8acC985T
	0VKGiLnBRqBEQuPLsB1FDRqPZBRiAtYyEKk+qJAN0Q4/+oKQvhCKVffVBQ2bpAXQ
	ob6q5YWCfN6juKbqrUpTwmK83OCESPe577vs+P6m1BQ5X5o9Nn1JyBBWrH0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467191; x=1716553591; bh=YCxeqQgVvv2I16GG0T9nOsPPe+zQ
	XhyUY1aoQfmYBYY=; b=TJT1dd3Zpi3EpGRg5nR80Vv9Ud8Ezlz7VLa59IuQm2kt
	9+9NjCLMN6VRXmyECAAtgDgmyVo5WIQLFPEuw9Hmc/WEzSul5HtYM1v46j8eUJZv
	mSFQPcFpwAuj3yrm7hRY6mzvbCqsL1X4HLmFl9a5+fzfjMTxQOsghi//P0tFnzmR
	X9oHhWROagHeWpRPg6IsrZ425JAmYJRF0c8ucNO5lgWs8TmT57uMhYIpCOKQl1iF
	L8VvlYIasrAbCaxlIVn0t/YPL4OgY90d76abE1KuMGTqJwZNgR93HnVGSQxYYeWE
	5BJG7SFMgeHgVquXo90sstdUdCuQ/SWtVv5YeOCObw==
X-ME-Sender: <xms:9jVPZvTP17RRbYwtXR7KrGullOx77sEqGJE1GaWyMWgh4G6QLDP97Q>
    <xme:9jVPZgzfnnmFktdY6CGEYCyOyLhWKeoQVjodz7gpkgZN8DWq-i1PWVHNZph7s4qBh
    EgM1B8ddpoWGiBuag>
X-ME-Received: <xmr:9jVPZk0YeoOkbcH7PS93XfjT30XGElUjkGxFVY7Hd0asctAy1e8uDVqiXxKwTTYVW9vu4bRcVtMIT_nwEDluWngSMx30dhc6XGBshWbeBUlQP822QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9jVPZvDysB5Jp5LlPV8A96fPYzLOts6Oarr9ejCllcGhgh14QSTX5Q>
    <xmx:9zVPZojUHl2EsGi-pLZay59KdDKD_qImpCw3Z38ZKC30AppWbE4_sQ>
    <xmx:9zVPZjpKWbepHLBe8wRxeQFPPctTohtULvxWzTWtdMNCMYxvR7ohCQ>
    <xmx:9zVPZjhIynU9AcbKgrndVivf4OYOt_yB_tO2eKfS4Yj9SNkJpdyk5g>
    <xmx:9zVPZkZsuSMFwVEIqDa_4AuuNBDO_LBVEK5drt0aOhkt84BNzPKENpCh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f209f50e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:24 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/20] strvec: add functions to replace and remove strings
Message-ID: <c43c93db3bdc0ea5283a6d5c71d37d6fe949dd8c.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sQKU24Rs44RGjo3s"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--sQKU24Rs44RGjo3s
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
 strvec.c                |  20 ++++
 strvec.h                |  13 ++
 t/unit-tests/t-strvec.c | 259 ++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/test-lib.c |  13 ++
 t/unit-tests/test-lib.h |  13 ++
 6 files changed, 319 insertions(+)
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
index 0000000000..c07ad62c7d
--- /dev/null
+++ b/t/unit-tests/t-strvec.c
@@ -0,0 +1,259 @@
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


--sQKU24Rs44RGjo3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNfMACgkQVbJhu7ck
PpQPfw/8C6k19bUeticwYF6vRS6Y9dv002JVSl0iwYzegoEheKPGlwZxte3W0MLh
A67WfOPdw7KBK0EMsoI45zAT75RclJcEbzMkJuAnCz9z96IsYHtkod0GdMio8zkm
YvjMl5wHgITJUkz/+qX3xXocI6B2/3KvVldIHI8tkKaAnGfmmZO/+gB7FiiOsbmM
tEyjAt1cZz0f6VKAgw8uquBD8HzFLiwP9l4gueefI4ruvPGinawhQ758Va8SpiFC
6MlHU6aXPGU021bSKrn9+DtvbQ/+PppeZMlsaPWGeBTbj0W/mohIHAv7uODysMX8
Lwf4qJ87m2Q9mVW8PE3McnYhQZ2LfmvQZZ7iuwcSECUsKDiPnns9g+hlNT8yuHpi
mWQnZDK9tW2ljV139ltPqFPeCvPN9mXvs5TacoOZ+DjtCsITqjvLLgiqfd2/s+7h
+SRvvtOTVauHmoc7GhMe4y3RqdA87YYWMYnlDcHEb3wYdvLGu6/mbETR2sVZQKf3
cC3qqx3YppS/n0k/l9BOD5mOlvQRkeoVCHxuhtyy0cazb9VKZaft3Rn+rEt9Eeyn
V82S/AY98zlTnNdIkrIb2biXUjM4SkWe808VGQBQZ8Udk5kormz9A0J3TdAKtoJQ
i+sVlM900oyPMfdG03eNReULT1uO6eJv9QxHqQETSQJ13/KHkgE=
=+oDx
-----END PGP SIGNATURE-----

--sQKU24Rs44RGjo3s--
