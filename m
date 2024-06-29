Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD131E4B
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719676020; cv=none; b=LWsqLoQN5/uqoCA509//u0i5N5XSTBToIdYsYd/uimpmgeK4V2dkGMb9NpmN16TSP0519Y+AZQxESFjDrtrr9N4l2dfzSh8YVfUsddCOK2U3KfPOp16x34hi8B2Ttui0c6ZSFM222FmdZkwjX0e/j0qEWl2u8sAoWTqXgx7x3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719676020; c=relaxed/simple;
	bh=D4mang5fnCrNO2LM0qspuTpZ7p/Ex3GMVFJHGjk0XQ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hmFE1cT/g8lnBHgrNzIy8dLAmDGIqYPV04Cmt3yL2u0RXAXTT+dM4pZ7Xv8yf44cpTQ2Oc8FIriNw8SfFX7bh0Xece9Avpx1/vgjmqF0ePcXZ79AF+o0SI8QWiR5freMNbt05uAfe45orH7jpeyi/91QEkVA4wLHtwQN6PQJK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Y33IhuAG; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Y33IhuAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719676009; x=1720280809; i=l.s.r@web.de;
	bh=ViSyAcXAEqyUcuXfZuqO4BsXPfAN4tHNRoZrz17EUd4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y33IhuAGxOMeV8PrTy3cuK1jXhjPkH3ku9mEv8euaYUVDaRDCP9QqoULO0e6lgts
	 PPAL7NnS1jo4yt8QW2t7wyhyd0ObkQ8sG6saq6exEL02rKnG0AeREle8R8heoIkDg
	 uEUuLExi8RFGXTXJJ+3Fk47QH7F7ePZJf9qAsCDUTwzjTqfhiKzjutnu30p/5KN78
	 nK+29BG+UMSXgPELndq6AmSaflTZOhs+ALGIDlJeytqSYeMAuAv4Dx+PYZfgHCZ0M
	 Dm1BUA4KIivzfYQ4wFsIuHT2Wm/WqAbBP/qKKPeuzxZASFvqlW4noW1fpGp05Mbeg
	 vpJ3BIn3l6iYDvVN5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnFyI-1ryNwK3sG4-00gxs5; Sat, 29
 Jun 2024 17:46:48 +0200
Message-ID: <27cdab5f-15b3-45fb-89e1-530a6c0817a6@web.de>
Date: Sat, 29 Jun 2024 17:46:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/6] t-strvec: use TEST_RUN
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uTDR4orKkWstzlQjqPW7uW5fmxF88zNlonaB0fRfNGnLrZops3I
 N3/gnTIXNqx8Z12MT3/wwWPVBA++R97wnF96wLFkxXIX7R61ZuJ8NW7+PkaAoSW5SsG5Gef
 V+sI5cHRw0ilmdX5lJporhnTv45zyxGOF+92C1N7XinRPs/JWOFOb39U0ECTcp/QlSBL8Fk
 kj4wCCp/lf8jcz06zSEcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+idnqPVG+Pw=;dJADAhJlAvp9qTr1rLBYqF1iDKE
 SVS6w3D/03WJIfNaMbj2AhmkD8OHHzvPvguoaJZGwmHPYRpMhsSBiRFHMO1yqQRHVc2+r+Grq
 aWd+53wp7ijj+ISYoU6s5FB3TAFAwuEmvATRiWvaNbBFs+RYlJsy/vMEoxYkhtRRrTn15ZKBo
 VhkPXzBbM//x8F/iRbtYeLAXpi5pP2hMvr3ZqRnhGBc/Au21hwN86oribLQWYxmKrFOSlQyF2
 U6FJZgZ8Ip8Pft4BXTuhR+/g8iWVwkgBGGd1DC50QrVCjysD8KOUey/UZ+hvnvEzmrzgOAeyd
 flBr3KaRwkbTLeip2FMBxRJAog7B6J7ESENaHGELdwJ4OnLDKBtq+RXsblqVW1fdjcZgobxZI
 2C1lSJQ7mSEEE97boPKLbbp0rHAYqVAbk+BjfUrqOwtDtZyhiMVShLXmxszK6+Zj+viBSCBdc
 vmPfDzkxm6rNQLdxvEmuUj4P+dQfS6KXs8RRrJgymXdNubU+apM9axm0E2JIu595t7ixeyUzz
 45vmjgUQDTdXWYu+lRJEzsl/blsymX1oI7HOjAuR5a3sHUEMx16PfWM5D5KF1UmiV03Knu2F5
 Ysni+/LfZ7TdNCkfNYz6zinm/MubtpWoVJFoi8APtVqQy9XBhAaU/u19PFRR0cIQEoBVxu0Tc
 4DnUCsUmvT4L7Jo09/UFseG2+NkZVUs6PanZIly5vtS7ZtNGS5aepvh8rf2tzOC6DxIPbgw1x
 E656Caj5hBrAmknDJzoL0/BNpBdlIEqiTaJMji6JXlqjvsmB+K/JD/VtPaN8QyHD5y1y9m4QQ
 z+MlHVArUZGiSGqOrapvgPMIusJinDElTNOi4ZDumFji0=

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.

Remove the overhead of defining and calling single-use functions by
using TEST_RUN instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-strvec.c | 356 ++++++++++++++++++----------------------
 1 file changed, 156 insertions(+), 200 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index d4615ab06d..00ff7d4ae8 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -36,237 +36,193 @@ static void check_strvec_loc(const char *loc, struct=
 strvec *vec, ...)
 	check_pointer_eq(vec->v[nr], NULL);
 }

-static void t_static_init(void)
+int cmd_main(int argc, const char **argv)
 {
-	struct strvec vec =3D STRVEC_INIT;
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
-}
+	if (TEST_RUN("static initialization")) {
+		struct strvec vec =3D STRVEC_INIT;
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);
+	}

-static void t_dynamic_init(void)
-{
-	struct strvec vec;
-	strvec_init(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
-}
+	if (TEST_RUN("dynamic initialization")) {
+		struct strvec vec;
+		strvec_init(&vec);
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);
+	}

-static void t_clear(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_push(&vec, "foo");
-	strvec_clear(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
-}
+	if (TEST_RUN("clear")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_push(&vec, "foo");
+		strvec_clear(&vec);
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);
+	}

-static void t_push(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
+	if (TEST_RUN("push")) {
+		struct strvec vec =3D STRVEC_INIT;

-	strvec_push(&vec, "foo");
-	check_strvec(&vec, "foo", NULL);
+		strvec_push(&vec, "foo");
+		check_strvec(&vec, "foo", NULL);

-	strvec_push(&vec, "bar");
-	check_strvec(&vec, "foo", "bar", NULL);
+		strvec_push(&vec, "bar");
+		check_strvec(&vec, "foo", "bar", NULL);

-	strvec_clear(&vec);
-}
+		strvec_clear(&vec);
+	}

-static void t_pushf(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushf(&vec, "foo: %d", 1);
-	check_strvec(&vec, "foo: 1", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("pushf")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushf(&vec, "foo: %d", 1);
+		check_strvec(&vec, "foo: 1", NULL);
+		strvec_clear(&vec);
+	}

-static void t_pushl(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	check_strvec(&vec, "foo", "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("pushl")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		check_strvec(&vec, "foo", "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_pushv(void)
-{
-	const char *strings[] =3D {
-		"foo", "bar", "baz", NULL,
-	};
-	struct strvec vec =3D STRVEC_INIT;
+	if (TEST_RUN("pushv")) {
+		const char *strings[] =3D {
+			"foo", "bar", "baz", NULL,
+		};
+		struct strvec vec =3D STRVEC_INIT;

-	strvec_pushv(&vec, strings);
-	check_strvec(&vec, "foo", "bar", "baz", NULL);
+		strvec_pushv(&vec, strings);
+		check_strvec(&vec, "foo", "bar", "baz", NULL);

-	strvec_clear(&vec);
-}
+		strvec_clear(&vec);
+	}

-static void t_replace_at_head(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_replace(&vec, 0, "replaced");
-	check_strvec(&vec, "replaced", "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("replace at head")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_replace(&vec, 0, "replaced");
+		check_strvec(&vec, "replaced", "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_replace_at_tail(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_replace(&vec, 2, "replaced");
-	check_strvec(&vec, "foo", "bar", "replaced", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("replace at tail")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_replace(&vec, 2, "replaced");
+		check_strvec(&vec, "foo", "bar", "replaced", NULL);
+		strvec_clear(&vec);
+	}

-static void t_replace_in_between(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_replace(&vec, 1, "replaced");
-	check_strvec(&vec, "foo", "replaced", "baz", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("replace in between")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_replace(&vec, 1, "replaced");
+		check_strvec(&vec, "foo", "replaced", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_replace_with_substring(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", NULL);
-	strvec_replace(&vec, 0, vec.v[0] + 1);
-	check_strvec(&vec, "oo", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("replace with substring")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", NULL);
+		strvec_replace(&vec, 0, vec.v[0] + 1);
+		check_strvec(&vec, "oo", NULL);
+		strvec_clear(&vec);
+	}

-static void t_remove_at_head(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_remove(&vec, 0);
-	check_strvec(&vec, "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("remove at head")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_remove(&vec, 0);
+		check_strvec(&vec, "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_remove_at_tail(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_remove(&vec, 2);
-	check_strvec(&vec, "foo", "bar", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("remove at tail")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_remove(&vec, 2);
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_remove_in_between(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_remove(&vec, 1);
-	check_strvec(&vec, "foo", "baz", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("remove in between")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_remove(&vec, 1);
+		check_strvec(&vec, "foo", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_pop_empty_array(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pop(&vec);
-	check_strvec(&vec, NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("pop with empty array")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pop(&vec);
+		check_strvec(&vec, NULL);
+		strvec_clear(&vec);
+	}

-static void t_pop_non_empty_array(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-	strvec_pop(&vec);
-	check_strvec(&vec, "foo", "bar", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("pop with non-empty array")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+		strvec_pop(&vec);
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_empty_string(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "");
-	check_strvec(&vec, NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("split empty string")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "");
+		check_strvec(&vec, NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_single_item(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "foo");
-	check_strvec(&vec, "foo", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("split single item")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo");
+		check_strvec(&vec, "foo", NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_multiple_items(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "foo bar baz");
-	check_strvec(&vec, "foo", "bar", "baz", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("split multiple items")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo bar baz");
+		check_strvec(&vec, "foo", "bar", "baz", NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_whitespace_only(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, " \t\n");
-	check_strvec(&vec, NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("split whitespace only")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, " \t\n");
+		check_strvec(&vec, NULL);
+		strvec_clear(&vec);
+	}

-static void t_split_multiple_consecutive_whitespaces(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	strvec_split(&vec, "foo\n\t bar");
-	check_strvec(&vec, "foo", "bar", NULL);
-	strvec_clear(&vec);
-}
+	if (TEST_RUN("split multiple consecutive whitespaces")) {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo\n\t bar");
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_detach(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	const char **detached;
+	if (TEST_RUN("detach")) {
+		struct strvec vec =3D STRVEC_INIT;
+		const char **detached;

-	strvec_push(&vec, "foo");
+		strvec_push(&vec, "foo");

-	detached =3D strvec_detach(&vec);
-	check_str(detached[0], "foo");
-	check_pointer_eq(detached[1], NULL);
+		detached =3D strvec_detach(&vec);
+		check_str(detached[0], "foo");
+		check_pointer_eq(detached[1], NULL);

-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+		check_pointer_eq(vec.v, empty_strvec);
+		check_uint(vec.nr, =3D=3D, 0);
+		check_uint(vec.alloc, =3D=3D, 0);

-	free((char *) detached[0]);
-	free(detached);
-}
+		free((char *) detached[0]);
+		free(detached);
+	}

-int cmd_main(int argc, const char **argv)
-{
-	TEST(t_static_init(), "static initialization");
-	TEST(t_dynamic_init(), "dynamic initialization");
-	TEST(t_clear(), "clear");
-	TEST(t_push(), "push");
-	TEST(t_pushf(), "pushf");
-	TEST(t_pushl(), "pushl");
-	TEST(t_pushv(), "pushv");
-	TEST(t_replace_at_head(), "replace at head");
-	TEST(t_replace_in_between(), "replace in between");
-	TEST(t_replace_at_tail(), "replace at tail");
-	TEST(t_replace_with_substring(), "replace with substring");
-	TEST(t_remove_at_head(), "remove at head");
-	TEST(t_remove_in_between(), "remove in between");
-	TEST(t_remove_at_tail(), "remove at tail");
-	TEST(t_pop_empty_array(), "pop with empty array");
-	TEST(t_pop_non_empty_array(), "pop with non-empty array");
-	TEST(t_split_empty_string(), "split empty string");
-	TEST(t_split_single_item(), "split single item");
-	TEST(t_split_multiple_items(), "split multiple items");
-	TEST(t_split_whitespace_only(), "split whitespace only");
-	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecu=
tive whitespaces");
-	TEST(t_detach(), "detach");
 	return test_done();
 }
=2D-
2.45.2
