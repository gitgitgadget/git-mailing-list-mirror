Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D91A08D0
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348768; cv=none; b=aajixOp3Ln/f+K5K7MiQZGrxXr7YUQndJ12LuZsMV5Tth8Ze5U8ET4A7tCgMOECEPlJlb31bkgBTy9U6r9rRq+g+YgDoRx6eB7RXb/hRgpic9dVyQ+edfcbjcEY9KdwNBzulxAKfekGTsZ4W2vx9P97aeWyC/y4UQavb6421spI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348768; c=relaxed/simple;
	bh=K/7RTRR48IPyVaA0xadWvcnA4/X6wrurtj/j0O4/xNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=szfMUTHC+pTRPrafdC3TyNlx3Jr/d8RCZ+ItcCYWABIGkyfGt5eUvj4h+ThYGcC7Z4Azht8u86rzz4eptk+t8aAGsjs5xf8rtfPMpzsOaye3BwXd2mvQWB9zp1Ln6sVCoGvo3MnoF1pEPWRrKAHohFbAwM4Q4Rv/0C9umpzVfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aNGhpjYL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aNGhpjYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348757; x=1722953557; i=l.s.r@web.de;
	bh=kltu9+m8isvVUz7CTPV00moo1ZYcPOa93v+db86W7BQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aNGhpjYLWqcDGLRpEf01IpIk9RvjxXjZqNJZxv2Vvv5OeC4pPOiSDb9mXWLSDTkC
	 qIKkZAp09P8+bFBnVkcq/enOsdpFIzYIMD9oOf1xXMg0dEAjTBXsBzvqfAXlcc72k
	 vrlGf+dfF3s67L06bxLbzK0JCfVaK36T75cjZgKdUMgFnVMrUttpwLfg0k9bsNXF4
	 tRJyWbyuXGo4sA0LCRQN4U571tvcjVLnRYBdN+LGV7bu60yyzofEovufP39h2lMQH
	 jDEO5kuVaWJFs2XUENJhkP+L8ssxkU8nwYDt6Mywb0umUc4KgFHKo/dAc/dxz/cl9
	 trRymRcIdE2bup5zOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qd5-1seYLY01Cf-007VL2; Tue, 30
 Jul 2024 16:12:37 +0200
Message-ID: <b4204fa2-dc48-4ffc-beb2-54e9647cbebb@web.de>
Date: Tue, 30 Jul 2024 16:12:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 6/6] t-strvec: use if_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Kyle Lippincott <spectral@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Language: en-US
In-Reply-To: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ub83y7Me/q1jAqO+i8OKmpTivGMU55oHlvyPyMd1X5MW38xuzX9
 MxeYRn8KlnIgauKuuz92FNbBdUb68PIzsOYNrrvo5/+MaZoloiBNRB6ZhZeEYnAl7ic6lt0
 nJNN0pdLtJZ/u1Kz6w3A9aorzvhLivI3C90YP/O/5ER5KUzbf/Qr62Jxs0PJPLsWt9uBSLO
 1EQc+hkjvor8I9YoYV+XQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l9uP3JxXtpI=;C34ugWa3m1znCfvKggrx3wfsHgf
 r5hqqsBDyG5Y48n1sBFQhEcosVB06IAXA0n8ntLiNUFoSptEvFssIGdSPEz5FkIAlbNhvWmP7
 NANUCpTXQQPaA+ttv++99UaaQxflLkyqDfK3FHSRiqq2Nh8b5JkqRmiSu90cK8R8yGswCnrQ8
 q1u6zTPBhOqT1s66a8h3TuPckRGfXfo3SZ0IkeIJhVnPIR/EdUzAHTCS2uibNXbT9xWvyuzrx
 +BErMqYOw4Jf990u1WLD9KbN39+jz0xzELwlkKyyLLm9PjCuGihSWwPBUqG76rmKYamxFGm/A
 La8YzywbomstC47fWV23B04elTI9mTNaHj3AbR2xrUIbMA5eJ2s1h1F9palQXTAuGmS9vjrjy
 mfH1lDUPaLcWL4vTgtC43CVkiathI9lEVjWVtpV1vBGYX22QpCYuyLJpgNO5k9en6+/tNVlWM
 SIvlkUtIwp/qVGCbSgH9CUd4txToorFNnLra7kryI7tOBLDbbgl/pky7JzhX9R1+Lbdk2m7is
 TxBe9MgWfg8KAw84wr4FNbXDCCcl2UB/qSNZaUUmDreqyzb7T2VaBebOvth16oLIS+jjnhLlv
 uK38DUv1TTu3AdiJoGSWyTxv9HqDR+5Ayat3mouKMDNIejdEmpH2UZnDAupvYW10boHOpjGtQ
 xx87ruJhahGvcO5TCRXjwUWiLZpMnOdF1vmbGnc8+RGtNXkWfZ+QNDGmunrDS1kJiNBYUCwSp
 Wxn3Knz+gxSHQTW6ZM3uxSdeNSzD5c27TfKzzck7LCK1WRtRd8TtEu+DJsrQuLbfiSGG9AX48
 0Bo8vMqiTdwnCwymBMNR6GmQ==

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.

Remove the cognitive overhead of defining and calling single-use
functions by using if_test instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-strvec.c | 356 ++++++++++++++++++----------------------
 1 file changed, 156 insertions(+), 200 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index d4615ab06d..557e9c835c 100644
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
+	if_test ("static initialization") {
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
+	if_test ("dynamic initialization") {
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
+	if_test ("clear") {
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
+	if_test ("push") {
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
+	if_test ("pushf") {
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
+	if_test ("pushl") {
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
+	if_test ("pushv") {
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
+	if_test ("replace at head") {
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
+	if_test ("replace at tail") {
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
+	if_test ("replace in between") {
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
+	if_test ("replace with substring") {
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
+	if_test ("remove at head") {
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
+	if_test ("remove at tail") {
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
+	if_test ("remove in between") {
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
+	if_test ("pop with empty array") {
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
+	if_test ("pop with non-empty array") {
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
+	if_test ("split empty string") {
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
+	if_test ("split single item") {
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
+	if_test ("split multiple items") {
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
+	if_test ("split whitespace only") {
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
+	if_test ("split multiple consecutive whitespaces") {
+		struct strvec vec =3D STRVEC_INIT;
+		strvec_split(&vec, "foo\n\t bar");
+		check_strvec(&vec, "foo", "bar", NULL);
+		strvec_clear(&vec);
+	}

-static void t_detach(void)
-{
-	struct strvec vec =3D STRVEC_INIT;
-	const char **detached;
+	if_test ("detach") {
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
2.46.0
