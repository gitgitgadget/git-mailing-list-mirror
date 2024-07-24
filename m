Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C41CAA1
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832954; cv=none; b=d93ILbLmZJBAYf2yuTJvgwlfw5/lmk9BGyQ3cLML5br6Zyg8vXB00sFGwo3BXMAGgyaWlgXv9Q6cpyQa3UKuhejXMYWS1Hyb19ouKxeQQMXabebtfwQHPoy2LC7Hvm42kVwSFoWWl7MXXxbUUZGLeYNMgg1V4/qqu+b+uyZ6sFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832954; c=relaxed/simple;
	bh=drkeA6Sv3wtBP0CemUwWGF89r/xsi/dMoOI0g0WkalA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iCB7O8EKTKKdWgsEKbjLWTn/1bEy4n/TAadqCAcZTY4czUMfU1291GUh9a+alqTGeEYNRfrXbhfdQJOXw8JW6kmHZcKgREJoWdzIX8EqOTv83m8NZ6e2YtBU8e7WF2rdd413Z+njAg0kqVaFIb8rUXOYIdqDXXXaO9GQ6S53qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=konQO/PE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="konQO/PE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832942; x=1722437742; i=l.s.r@web.de;
	bh=9UUNj+ssLcqeIn16ObzSImh7ZHEU2slYp0ve932h9lM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=konQO/PEQbjLQInD3yoYDIbeH/pplE6AWgpU2qyjfQwX9M61vhgr3JpbCWQPajME
	 KlM2lLCIjXpY0CGLsqO8RWM3meQyEqvx6LsnMvyrZJPekx13F8rMA5JqbxvMzVAg8
	 Rw9VnUZNoU1SQ3sxOauDAY7AEnq0HEvZDcHthok9ZwN3kDXyvDPb1au5U8tGi2TxL
	 EkRQuJRKwSEu6/+MXAZHNq+C3L4pZsDJHZPrRUF7ccfWxmYm7Libnes5E6En855Sp
	 L+DotoVdRwq/lhLbY8WzfA026p3cy7++eexQMMUWfH92ZGgDmLfHICURDUQ5eItEq
	 nRy1mzKMvVBHowD4Zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1sXjKc3ORo-005tFi; Wed, 24
 Jul 2024 16:55:42 +0200
Message-ID: <a899a8be-3d14-4b93-ac38-ccb2a5ef1e22@web.de>
Date: Wed, 24 Jul 2024 16:55:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 7/7] t-strbuf: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Language: en-US
In-Reply-To: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzdAaI5gW5WY4PcNdEFsmPB0hpe8Awe2k4sClwR/tpDA791VbID
 fFvkOVSC/0rREXZHEHakaV8Ld9LAlI6b1rC7q04WokSMLvo+/0gGowh/29wfy3nEDUDm0zP
 bdurGaDy4N2elVcKRMAd5HEnIZ9A0cbLWWsaklz3KGmDxGzIPbLiOzM4L3DYz60sPVQAUGK
 ihFVNzreCdCalDv/fwwfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b0UHleiQ41E=;4tOt7FMOs5nqqm2bsMasBKnpAew
 dxQjgNOiCONMehgyf3iefib5r5jBvPY6GxUzYbcis/Sunzb52u7NT0rndb6iy7Dk+SIuhrg+9
 K2QYrYW3sbitUwPRDkV529m/UjbPOzOT4HxMhwUSyYjMfLSX8Vdgb8f87qIa3Gr4Lp9WWX9Md
 wUnDus0GY520392HN8Idq6ys59/qlir+0+ZFmU4S/Om0Togh7WxeXGPYBT9C1yCuQiYBA9zRH
 +ajKogq1AVS7A/30bi7oMiYcYdobMp/6Bu1LeoBkIiV31IWZrLmoAA1fK6TdTYjZhwv6U8B9Q
 FmFF21AYylY9nhXVPZDVEzfO4cUvKByFcIag/mXgcmsUxIGGtUwc3+HXCgOuzazK/6V7qc/uD
 KLhP6mauPds6o0+HXycu5PGbw3WwxqfvAXAD6UjP7pYm9uILgCQMJJPUPmCf3ogIWz3DHmD7H
 NZ5rP6zrHPR5aGIdD/QnT35Fc8oAIapB9XwP5iQVGsv3AU3l2/iVmlO2EX1tFlC2ciBAlh/sM
 cWkHZe5i+kgUpAnjnOfBhJ5+gKvKpVgqfWZS59FhKX/4PNwT+XD9fRndNK0TnnjFwF6V39ySP
 tYspCcNaVmnnOC8LRTe4Yr68B/uGcllhnLqBFNIqY3DgGU5oR6IOH3+NmP0dhkY0b7w4EaqN+
 TFrUA0QAjIRytuND+skhVzN1XvI28jBdJv0RRfD2x6Z4XAWbJtZqlcZ1HtKX+dL9ZwkVIRG7v
 cRaTscnz4SJZqtBwJBSKEKWsNUsjWrscGr7vOdKiQ2Aa1WdK7N7o4og3AxBRQH55I7FObRt0U
 tpVH+wzeZh0WbdvOFasrBPsQ==

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.  The functions setup() and setup_populated() here
are used for that purpose and take another function as an argument,
making the control flow hard to follow.

Remove the overhead of these functions by using for_test instead.  Move
their duplicate post-condition checks into a new helper, t_release(),
and let t_addch() and t_addstr() accept properly typed input parameters
instead of void pointers.

Use the fully checking t_addstr() for adding initial values instead of
only doing only a length comparison -- there's no need for skipping the
other checks.

This results in test cases that look much more like strbuf usage in
production code, only with checked strbuf functions replaced by checking
wrappers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-strbuf.c | 127 ++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index 6027dafef7..1e4a7885c9 100644
=2D-- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -1,32 +1,6 @@
 #include "test-lib.h"
 #include "strbuf.h"

-/* wrapper that supplies tests with an empty, initialized strbuf */
-static void setup(void (*f)(struct strbuf*, const void*),
-		  const void *data)
-{
-	struct strbuf buf =3D STRBUF_INIT;
-
-	f(&buf, data);
-	strbuf_release(&buf);
-	check_uint(buf.len, =3D=3D, 0);
-	check_uint(buf.alloc, =3D=3D, 0);
-}
-
-/* wrapper that supplies tests with a populated, initialized strbuf */
-static void setup_populated(void (*f)(struct strbuf*, const void*),
-			    const char *init_str, const void *data)
-{
-	struct strbuf buf =3D STRBUF_INIT;
-
-	strbuf_addstr(&buf, init_str);
-	check_uint(buf.len, =3D=3D, strlen(init_str));
-	f(&buf, data);
-	strbuf_release(&buf);
-	check_uint(buf.len, =3D=3D, 0);
-	check_uint(buf.alloc, =3D=3D, 0);
-}
-
 static int assert_sane_strbuf(struct strbuf *buf)
 {
 	/* Initialized strbufs should always have a non-NULL buffer */
@@ -45,31 +19,8 @@ static int assert_sane_strbuf(struct strbuf *buf)
 	return check_uint(buf->len, <, buf->alloc);
 }

-static void t_static_init(void)
+static void t_addch(struct strbuf *buf, int ch)
 {
-	struct strbuf buf =3D STRBUF_INIT;
-
-	check_uint(buf.len, =3D=3D, 0);
-	check_uint(buf.alloc, =3D=3D, 0);
-	check_char(buf.buf[0], =3D=3D, '\0');
-}
-
-static void t_dynamic_init(void)
-{
-	struct strbuf buf;
-
-	strbuf_init(&buf, 1024);
-	check(assert_sane_strbuf(&buf));
-	check_uint(buf.len, =3D=3D, 0);
-	check_uint(buf.alloc, >=3D, 1024);
-	check_char(buf.buf[0], =3D=3D, '\0');
-	strbuf_release(&buf);
-}
-
-static void t_addch(struct strbuf *buf, const void *data)
-{
-	const char *p_ch =3D data;
-	const char ch =3D *p_ch;
 	size_t orig_alloc =3D buf->alloc;
 	size_t orig_len =3D buf->len;

@@ -85,9 +36,8 @@ static void t_addch(struct strbuf *buf, const void *data=
)
 	check_char(buf->buf[buf->len], =3D=3D, '\0');
 }

-static void t_addstr(struct strbuf *buf, const void *data)
+static void t_addstr(struct strbuf *buf, const char *text)
 {
-	const char *text =3D data;
 	size_t len =3D strlen(text);
 	size_t orig_alloc =3D buf->alloc;
 	size_t orig_len =3D buf->len;
@@ -105,18 +55,71 @@ static void t_addstr(struct strbuf *buf, const void *=
data)
 	check_str(buf->buf + orig_len, text);
 }

+static void t_release(struct strbuf *sb)
+{
+	strbuf_release(sb);
+	check_uint(sb->len, =3D=3D, 0);
+	check_uint(sb->alloc, =3D=3D, 0);
+}
+
 int cmd_main(int argc, const char **argv)
 {
-	if (!TEST(t_static_init(), "static initialization works"))
-		test_skip_all("STRBUF_INIT is broken");
-	TEST(t_dynamic_init(), "dynamic initialization works");
-	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
-	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
-	TEST(setup_populated(t_addch, "initial value", "a"),
-	     "strbuf_addch appends to initial value");
-	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
-	TEST(setup_populated(t_addstr, "initial value", "hello there"),
-	     "strbuf_addstr appends string to initial value");
+	for_test ("static initialization works") {
+		struct strbuf buf =3D STRBUF_INIT;
+
+		if (!check_uint(buf.len, =3D=3D, 0) ||
+		    !check_uint(buf.alloc, =3D=3D, 0) ||
+		    !check_char(buf.buf[0], =3D=3D, '\0'))
+			test_skip_all("STRBUF_INIT is broken");
+	}
+
+	for_test ("dynamic initialization works") {
+		struct strbuf buf;
+
+		strbuf_init(&buf, 1024);
+		check(assert_sane_strbuf(&buf));
+		check_uint(buf.len, =3D=3D, 0);
+		check_uint(buf.alloc, >=3D, 1024);
+		check_char(buf.buf[0], =3D=3D, '\0');
+		strbuf_release(&buf);
+	}
+
+	for_test ("strbuf_addch adds char") {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		t_addch(&sb, 'a');
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addch adds NUL char") {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		t_addch(&sb, '\0');
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addch appends to initial value") {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		t_addstr(&sb, "initial value");
+		t_addch(&sb, 'a');
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addstr adds string") {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		t_addstr(&sb, "hello there");
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addstr appends string to initial value") {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		t_addstr(&sb, "initial value");
+		t_addstr(&sb, "hello there");
+		t_release(&sb);
+	}

 	return test_done();
 }
=2D-
2.45.2
