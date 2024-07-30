Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E119F49E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348431; cv=none; b=bN+yTTCLNVMjsigrtbGgkfrHe/438Ryx5VYz0L+VVyK+gweZgyteYH/iaiK9QD25V0FITS0u3sz/gERjf37CzHap2nfPui2+nPSPzHbT1Qt51PAev0upatlxi7hpfc6/bFRBZPrTDtQFTJ14uEYZeKOnRDKiZuoZdvLPuavtmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348431; c=relaxed/simple;
	bh=CeMUahlXNhDiH93HWnZ+v5IXpOTKtlTALGqMCUmzOjc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AxTStBzGi+E1fk8AcrtuWTzGTaAErH1Jyrg2iYQgNyNdvfY1i/Dcl6+ubvTTHP0jwsk5M39CYQE2P4+zBsOOKuI6m+Plrt/zgzkYSfgWEXeQsnGBnXvhs2MPfXKcu3irwUFwFwYTD3RwpEvFY+ISTVNkDd3IX6ZUQqdzdpELAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wnVItC4c; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wnVItC4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348420; x=1722953220; i=l.s.r@web.de;
	bh=zRkQAjOa/f2lAkTjrn+U4hvvk7cBL/hkIlAC2hWStK0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wnVItC4cE9oPcb3MDucK1aNi8Qcc10La2d/d/IyJ5hsdBlkAoYb3yF/gf8pyeT6v
	 RuffsiFacnh8MzfwGH2tYRwdUUsSH4oSMbp3WRDoZgn/F4E5hu/aeKx1/nHB7s+P0
	 SeWNT7OvCz8z+LD+ZQ/cygDXI9UL4ShCSGAReF3yFp9AbxucTwRaa0YjlxV/54avZ
	 aIPqe6s1izXK3Ialn7icFedzxJz1g3xH58fRSCG0SMa4pTUtygZhbBnex200sS61u
	 m7KITM5gCNO2eFtEncImEW36MsXChN8TPNf8rXKUfkGbxiOkcdMLX3nA3PNPVn2v9
	 H3yMNXSwygs3NWyUsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1sqbMz2bqb-00QISk; Tue, 30
 Jul 2024 16:07:00 +0200
Message-ID: <4b27cee7-98eb-41ac-a68b-44f42e15a5d2@web.de>
Date: Tue, 30 Jul 2024 16:07:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/6] unit-tests: show location of checks outside of tests
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
X-Provags-ID: V03:K1:o2dHgSF1UZ7bj1YMY6VKtdx+3CHrfq/FwVePaTgPPN4TAiGrbt/
 H+c+TMVU32XtaTUIliFuARAtJ+8dV0vOWLe1jvXnXw0CaKI8/JIkTKyiblcQHmtEvABrD9a
 ylkCwUJhkXQ6FM/hypnri3hcSmICp6sJ3LplrIQL3jWFvnftc7O7Ddr7/TPaRKw7TUaYGpR
 e3/IOYm7eLA6/PG9PGUyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N/1roOzHAGE=;XvfYnJZ6blou5ig/NEXp7L0nobJ
 B5h6y995MuefGiwuzCqDVpx1FVDvxI+QN6/Rbj4/C7JbcW5Sl6mvnk/x9ktXYgZfUlGVBgW6S
 25Z3+cPbkKgIo9ascPOdbUC58FjPkPa8N1dr8Vq/sQpsud3eTGE+z5+HBzkyg0Szg1QRossYU
 tpW30SNbUOHBy+ysbKkw63ETE4FKFFbQ5YSbwMYr8a1AVIm+VqX8QLNFvbFey2xcPfhKTN4R2
 1EPuAEJcyUfsBuylB0mc3CdOuSG1aj2bRg8la+ejmk9JqkZ35sd4GF3+Ax7cTHPR39G6fqIFc
 UPdS4NBrODJZo7I+2tfOv7Ey8YX7rGO/LLxNunKZgQnqb7b1hkgWHRc3nNwtoSJ1B2sPG9rfK
 nZOH54HI8vbIh8Oj1/hAUoeir0RFFN1qxMstCppVZsp99fKHZhMrYb4EGOnSmzr2VJ7y2kr7N
 4BhoY71ARaQZZDugWXPkcVoJBuO8ancMON79eOVn0heEdt64dXY5Sl1mLcFJNnqR9SZJLsGpI
 9ba6Muusdrr19cLj9K5VNWekHwrmjvmquljkjF4bPHBYjs1KS7wiXu046oX2eKdkrfus2pG6M
 iDgZ9XUFeGbE6jpHIOPeJWwPniEeSWe3NGPcYv+2mORDMGO7m8bKekfxIJV40OjyIjjsdCLt4
 ZJdoz2f8pdY+JiJOkQG0oqSxuQlTzGadYwrrPJI4aHIqDg9pABzoFJEgmheP4XNDAbX3nkcWQ
 lu27AnULZKLwdXq2YEikr9uPdE/cx1jGOYk+ntHy2P+0DUQXbzSKHz1RzffTwixrw2DWLMkXc
 g4kPLSmLw1DGh/Ub9YJ6Zx7Q==

Checks outside of tests are caught at runtime and reported like this:

 Assertion failed: (ctx.running), function test_assert, file test-lib.c, l=
ine 267.

The assert() call aborts the unit test and doesn't reveal the location
or even the type of the offending check, as test_assert() is called by
all of them.

Handle it like the opposite case, a test without any checks: Don't
abort, but report the location of the actual check, along with a message
explaining the situation.  The output for example above becomes:

 # BUG: check outside of test at t/helper/test-example-tap.c:75

... and the unit test program continues and indicates the error in its
exit code at the end.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-example-tap.c | 2 ++
 t/t0080-unit-test-output.sh | 5 +++--
 t/unit-tests/test-lib.c     | 7 ++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index d072ad559f..79c12b01cd 100644
=2D-- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -72,6 +72,8 @@ static void t_empty(void)

 int cmd__example_tap(int argc, const char **argv)
 {
+	check(1);
+
 	test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 1), "passing test")=
;
 	TEST(t_res(1), "passing test and assertion return 1");
 	test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 2), "failing test")=
;
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 9ec47b7360..fe221f3bdb 100755
=2D-- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -7,9 +7,10 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue

 test_expect_success 'TAP output from unit tests' - <<\EOT
 	cat >expect <<-EOF &&
+	# BUG: check outside of test at t/helper/test-example-tap.c:75
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
-	# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:77
+	# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:79
 	#    left: 1
 	#   right: 2
 	not ok 3 - failing test
@@ -46,7 +47,7 @@ test_expect_success 'TAP output from unit tests' - <<\EO=
T
 	#    left: '\\\\'
 	#   right: '\\''
 	not ok 17 - messages from failing string and char comparison
-	# BUG: test has no checks at t/helper/test-example-tap.c:92
+	# BUG: test has no checks at t/helper/test-example-tap.c:94
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
 	1..19
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 3c513ce59a..989dc758e6 100644
=2D-- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -264,7 +264,12 @@ static void test_todo(void)

 int test_assert(const char *location, const char *check, int ok)
 {
-	assert(ctx.running);
+	if (!ctx.running) {
+		test_msg("BUG: check outside of test at %s",
+			 make_relative(location));
+		ctx.failed =3D 1;
+		return 0;
+	}

 	if (ctx.result =3D=3D RESULT_SKIP) {
 		test_msg("skipping check '%s' at %s", check,
=2D-
2.46.0
