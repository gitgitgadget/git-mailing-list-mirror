Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38E78C88
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719676065; cv=none; b=E+tgFIfb6AugzltnXoOPQcqCJ1P8MCiGIfte3b+B/bY3YKrdHZ5c2kHOlAmeGrBduq/sXMoKnIYsJmz6blDx5WA8f8pw/U8UAliCihxxzyCTZPpHYcN7hZItZ40cA/0D8WPln4cKGgFJWyOVXyH4XghSMz1BzJnlfds0ZBDM3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719676065; c=relaxed/simple;
	bh=Dq0699fMSmt4XV5KWLE+PRNPz7CS0bWvg40BI6GncCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pYq41TVVsTFZRljUfHsCXYac1fIfNySsoSZ2NqXMcFpwHEFnkez4gUV8vhvMszPiDxLZONu+sWgohKr14c/tJV4v9QXiP97D+cS2bNtAkDNcJh7oD1zJ3gV1BpvcEEjQrvs4bWaL+bbMXlrGt5zaBKRnPuDAFecfJTgypJBjLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZurXRdR2; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZurXRdR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719676055; x=1720280855; i=l.s.r@web.de;
	bh=TLXDMpNoNVuhLOZMC2iTAu/dbeP4BPiwDZP3IdR5eRo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZurXRdR21cTuWGCB6jydJ7DLQHbAMyAMRHX3DLKGYmJh5Vt1GtBjc7G85G5NggRo
	 A9/r5bAeeryglD07KTvu1++263R2nV8UZmARmLlfmNgpJzUKJ+t0kfbG1ejbEFwi/
	 OAZiNXnFaWaGcT1hMQLbuCCyMCTywxqlkQDh19B1q3Zr8o1BnVn5WNNhfhYvXTkgP
	 Agvocbaa34GTVrj0NMN67JyMP7WS8d7+9fAkWc/KBIKPGOM6oWHTt9CiPXIiPvqMA
	 KiXsF/vdVwSsCHGiCOfz4cLb2XFRHmso0srs7eXWXg+/RDOzXafr2u7tQlUGzeX94
	 XtjG7ttAxlZkvwYthw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJSy-1s8w1t0dbu-010WUx; Sat, 29
 Jun 2024 17:47:35 +0200
Message-ID: <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
Date: Sat, 29 Jun 2024 17:47:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/6] t-strbuf: use TEST_RUN
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0F3GHx5dsdvvXDWDxvWEL7sBmbvevd+bvsvKMCXMzrV9vE7nILg
 3Y1MXSFNCQEWZdmOfqtFujQiaPBIPC1nnN75rqq7+8o9g6K+N/zOEWRpwsH2mCnxl/6gl0e
 4dui8iJyCkZCUwYsvP4WPoY+lR9pzN4zoO7bXTKdxt2EExQ24hpNr5S0ZHf2+atGXUncPtk
 5Vz9+tHFyHL1ZRNMmuWXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yCtiQVOcSBs=;61CxcOA61bEJXUw5eBJLyKFWGFC
 gxhV5L7gWrQngsUWoKfVeFN/lToOpR4rLbIEUpfnyER860usQIEWAi5csTjnKt5WencyNQvZO
 VQ+Zq9IGlmuKph7aWEEyxqgbVOvcxD12xGhka4eyA4dbnSm3ZIGpoelrSWA3KrDP2gHR6BXRA
 n0G1D3nWiywFbSebdo+WbO2OzgetPQjft/72NqpqTg0xO1RXxzdxt1i7Z91vp+u4wRAj1BdMX
 TAe9zugXpu9FGtY06OdHGvJl+XpykOLzVA9xpaNWbcgoVQdbnwLVw0sNqYQrnkWuuGpsuVIT2
 U0Xd8IPD1YOfb2iKT6RlMiaTeVhabIqMBuXgGxffvkoADUtYHocxhUY7d5cn0WGYyPxjvFOoy
 rVlTJ8haEge4XoUWJbxP+e8+AfvzADbEXuluMBus67HAL9AHa1A9zoZ8ugd8muLPz21r/DFgU
 ZMhsl77UWERPHzOsxx12/WhEiWrNjXeuC3kBdUxigApAVP1f8iXEIE1XRYeDQIxtirL+ulgJy
 lYFACSX2y+PNK9Q3a8Kb3uZAUi2r5A8W0ei3bKX+v3QjZnv/K2edMOb5xG3tLLIv6ZMqtUUiB
 8+LkZZxprq+KChxjI79jtZ/nsV0vKEWUov8C3TNsIJjjXbbwal1hqAuvX98G7fvWM5oTCpy1x
 CW77EcezaandSFjXVFA/pa59MrOjRHnl/3NswGN1A3zTl1uXgYMYBSYZVnSF7W+lv4NeU56dl
 Pj9vMaO89JppMarm89GO8Dy4bT+7gz7vLD7QF4jj85wnM/Z4qKXWBNLGzmKSm8QoQIifjUe/y
 Iqhm9UR9055i+Hk6B9ewfTpWwOE89SYfgNVup1EaZyZlc=

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.  The functions setup() and setup_populated() here
are used for that purpose and take another function as an argument,
making the control flow hard to follow.

Remove the overhead of these functions by using TEST_RUN instead.  Move
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
 t/unit-tests/t-strbuf.c | 79 +++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index 6027dafef7..c8e39ddda7 100644
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
@@ -66,10 +40,8 @@ static void t_dynamic_init(void)
 	strbuf_release(&buf);
 }

-static void t_addch(struct strbuf *buf, const void *data)
+static void t_addch(struct strbuf *buf, int ch)
 {
-	const char *p_ch =3D data;
-	const char ch =3D *p_ch;
 	size_t orig_alloc =3D buf->alloc;
 	size_t orig_len =3D buf->len;

@@ -85,9 +57,8 @@ static void t_addch(struct strbuf *buf, const void *data=
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
@@ -105,18 +76,50 @@ static void t_addstr(struct strbuf *buf, const void *=
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
 	if (!TEST(t_static_init(), "static initialization works"))
 		test_skip_all("STRBUF_INIT is broken");
 	TEST(t_dynamic_init(), "dynamic initialization works");
-	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
-	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
-	TEST(setup_populated(t_addch, "initial value", "a"),
-	     "strbuf_addch appends to initial value");
-	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
-	TEST(setup_populated(t_addstr, "initial value", "hello there"),
-	     "strbuf_addstr appends string to initial value");
+
+	if (TEST_RUN("strbuf_addch adds char")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addch(&sb, 'a');
+		t_release(&sb);
+	}
+
+	if (TEST_RUN("strbuf_addch adds NUL char")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addch(&sb, '\0');
+		t_release(&sb);
+	}
+
+	if (TEST_RUN("strbuf_addch appends to initial value")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addstr(&sb, "initial value");
+		t_addch(&sb, 'a');
+		t_release(&sb);
+	}
+
+	if (TEST_RUN("strbuf_addstr adds string")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addstr(&sb, "hello there");
+		t_release(&sb);
+	}
+
+	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		t_addstr(&sb, "initial value");
+		t_addstr(&sb, "hello there");
+		t_release(&sb);
+	}

 	return test_done();
 }
=2D-
2.45.2
