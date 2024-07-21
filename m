Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA734539A
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721543189; cv=none; b=tyrJ/ONKjMtobQj0sE10M1xsRdKckWK+AmAZFo2fu/x4O/OwpFVqXOf1qrc0KB33qWBod/LHiE/byZNiQDonAdv9iSckTS8YQHYEBoWLoRRT6xel2eUhfjZg62VXWa4LXrEQW8Cn28WiEXQjNbw25ag4pab5oIl7i9Ei/o+cnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721543189; c=relaxed/simple;
	bh=NH0xhiZeYjyAbANGJFRegjsDaLD3qj8V1LcMpOE46js=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RB/5aCXFxRKpjzsIhx8rOBX+X2ty+AH5UtasZyrLSfW5yhFtdkabeefqnGgsMZbCXcysDgpdmrvd2BW6bi3LtjbtLofi98ZsSL+0CmaJojBqYLB4P7Nz/8zdck6xkAt3V2CCCJaEVSUw6gYt4mYvOfwz6g0gs/DFaheuz9b+Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Uzz+Fmym; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Uzz+Fmym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721543177; x=1722147977; i=l.s.r@web.de;
	bh=D+q/D9n1r07ldtcZ4xTGsSWpAaMg0Mb0hujX0q2CZAU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Uzz+FmymNTsg+zSBs4m3CwSRzHTd/lvLQdIn6QoffYK8XGqEZPJNFo08w249gkAL
	 +FWF+bYS0jw6trBcX9/AKLPF7oVALPeniVd/gN7hy4wBnwvQrHdCIDSBia98X3eBR
	 ybb1P783Z/2b4bILVxk2SdCOHuUR4eT90bYVw6xYRdg/kr7GxgAg3zi3O1SZjSE19
	 tsL8z6R67Z5rKMJiYzOMs2UfF4fkaFcw04Kp4m+K8XP56Deq51Wcih7oPhrni1s71
	 8bRVWAVF96BRgdU5jRAG1yhL/56+X5+t19/8ZnYgZv0Mq5qBWu4i8tfDQegXX99+2
	 02ixSlH0B+WIDoVKfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1sUbD21Wlh-0017GR; Sun, 21
 Jul 2024 08:26:17 +0200
Message-ID: <b179d004-d00b-4ed7-8cc9-f3b388f101f4@web.de>
Date: Sun, 21 Jul 2024 08:26:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 6/6] t-strbuf: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Language: en-US
In-Reply-To: <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:muWYbUUTq/59excXTqVbB4JpY17mUw9zgXPlCEY9ergrefk0d6M
 JUWzox48Ey5bs0Fl09nbepFWnJ04riFqWtP9fKUXXzhcjx3JSVMzSH6Oas3F0cGp9tB6KKk
 KZrY19OsojmFg8xX5AnAoaDve25xRm6l0hRIGG3HyNuRuRrFqSsKm6oz8mlFBNFIFirpJrY
 Ut/L1X6w1ea/sSVIRNy0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4q+YS02GtlY=;PbnKve6TFpdpnetT9JHChZhPDer
 c5cIKrDvj51564tZzv6ve8D8f+Rfzs5vy+MTkcgjcKigBEE3ePBdcOxAw80P3PZ55jUAX6YKI
 4ltTlqLNu5Qs7DMt3k+rWTXdDkziSlJ154nqKVDP6pMaqp4rSSJIV41+h+MogedS4uSQY2tiC
 bzVZKW/A0+j++WdgKGaf6xqOO6CnwKGSpaMWM+Xrib8Y46mFmLBQBZ6OrzjJZyZpbSO9ijWNy
 /muzaGZg3h4RBBB8Z22kjW0reCtgg49i7CTtql3zfFKQ3mfM9ahk5BWSgLYWmgpaaSTLjR4z6
 +C0/08VqSzYbptG2v2QHhrGX5KhEK9Gr7w7npDRpGsiIK5eBEwTQ1xTZGFATGEOIeDhXZ6rpn
 9M4lnknmYCm3jqNbrKBvrlG5pKW75pYBrvVIQ+wP505SO/x3ocstAszmlpJTTQa7rdo7XKihL
 HxgrCFS0owyc3STeHVBWMwuII6ishMpnsLN8ok2fAZOkkW47cO7cIC2VmWJfJVgLNeW0nFI/L
 4pDOQjqEELNyIHLwoUHb+JnNlLbjFtProbf6eIVrviSH0yTHtazgjXifHph/eJSDLzESrqJko
 lDYQm6uAq6M1IaIOt0fFoEcl74bINIcbVwg5FyBgV7Gkqodc0o5AoJZnir9w6romwX+wfeBxB
 DWam0uk3dL5chcaxyb0qg3dyEBzfPBFBDEmikxEE8FASG7kdTqOIbvCa8l81SwzWTf/JPFWeg
 eRYXJpCdZ/2QioRbJj7Ift0aDE/ueVFJj+ceQksNwvI+OQ+TM7S5eFzC4HiSHighpC7mAzPr/
 4pwhG4AwjR5RVta15bDkK25A==

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
 t/unit-tests/t-strbuf.c | 122 ++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 62 deletions(-)

diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index 6027dafef7..82cae4cbe3 100644
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
@@ -105,18 +55,66 @@ static void t_addstr(struct strbuf *buf, const void *=
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
+		t_addch(&sb, 'a');
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addch adds NUL char") {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addch(&sb, '\0');
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addch appends to initial value") {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addstr(&sb, "initial value");
+		t_addch(&sb, 'a');
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addstr adds string") {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addstr(&sb, "hello there");
+		t_release(&sb);
+	}
+
+	for_test ("strbuf_addstr appends string to initial value") {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addstr(&sb, "initial value");
+		t_addstr(&sb, "hello there");
+		t_release(&sb);
+	}

 	return test_done();
 }
=2D-
2.45.2
