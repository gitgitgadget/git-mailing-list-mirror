Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9419F49E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348369; cv=none; b=vE2Pboqav0sf8+QHu85wXtPdvy9eyfW8hWQpz7qQ9zyyg+H86Oaj9l+zrxaLZpifWuf0liT70vm7Ec7R3Ei8xQLsPC3FP34ifO3CvCFrVWCp93rluY3IyJyXJ7zM2wp6RnKPWyNL8uI2vU20AmmFnt6726c4CVNq8s9PnmP9+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348369; c=relaxed/simple;
	bh=r2jp93goIRdT+BIB/XSbWAf0Q9mQ5Yc6bm0JF7E5LuE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JQZb2jSY8QK+4qei0zM9Dc6YvOMpQShpVtBvKpVslcqm11AwxQcg7mLYowC2t7UB+qY0XCCrTdolQH71VdX6lDmH/Qkh87h8CHclQBcOiMSufvkeSdWTX4Xjto9ntw/+3detMOhGsGzHT54YeuUOP6Z3LUVIuJpQU9E6nDMcqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mQ51gKfZ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mQ51gKfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348359; x=1722953159; i=l.s.r@web.de;
	bh=Jd4MUHctimRAoX9giffvGW6MUWwrJEmcC6U21ditm6w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mQ51gKfZ6HhXcWRw2uDtS9StisvmR28SVMKPmr9ODMqq2ifnztijxQdY7GdVy25l
	 LynExAD4jvZ6ztRfofwEucoBiaEXezy1j5HEBzGQI7SmtbphwzVgReD3AU3zV7hWy
	 hyagutEdSchG64fUxEymPqkUTCxXHi65Ylb1sSupURphAIcBYjjETisHxMYMbidtZ
	 B3wUFY2ibXfO2DKv0geNeaGEJb0W9Od/QVwV+JyOFe1+bZ67ElQO0OtgvsYJqKCkK
	 1PzaXGA6LIuauFczyx5/0sOF5n8jQBRsHgDrOajsnyCSFiZIKmvf04HHrRsgYErsa
	 UaWLZpkRCOTg1eW7DA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Ka-1sj94j0mqE-00X8kN; Tue, 30
 Jul 2024 16:05:59 +0200
Message-ID: <23498c37-1e30-45a9-92ae-d31a05778fca@web.de>
Date: Tue, 30 Jul 2024 16:05:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/6] t0080: use here-doc test body
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
X-Provags-ID: V03:K1:MYeOvxeeVMq5CT8eedAPsxZz06gP47DXWUSS0xp064xwQ+LH8hm
 N/nE8pFYhazGWqtark828zSS6AY0C+m9r2It6ClkL/DFAWS/CCgPStxvAefH8I6R3F9ka2A
 SOSnf2DXImluc1jZtteluHzYl9CmMwLNZU/e0KoMUTK+9tB0UB+TsWs0bAWjM05p4hQrkCz
 HqRP43cjvLW/hdt3hdY3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d9Ngw+kIsCE=;MmDXIOC9W52JGE30thPrQwabCal
 k2Wul2+91lroJlaA4b3Bj8+V27bc/0axruIm00exIhorZRyv+zqA0ILM6Xf7H5Xo9llfKMGEL
 DtnQ6Vx4dmor/DJmnJmbu+yu1eq+jnZ4cY87dWsUvHfHSwPf+SaFd749qPX0S6isP6BL08UQ9
 5EK5J02RuqBFddsPbFAtShWX62HVvPqket9unacof9y6Mng9fAZEPUZzn0tD/o1SQWRUTtMSr
 iOao3pk6QqL2XpAiIkqGZazZk2Vk5M6d3USKI/4ih9g3/8A/YCvYRAcgeOmnYdhFBlxArIISa
 llMZ9Tq3lfypuOIoh5x8qnwN8D7jdgyBcAKt6V0EenY+RWY47N+XFGSJRtaPtJrXr9WfPBskZ
 CwX4Bm17pNBoDTL8aYprbz38ppr+vVgYx0NflcPYPUSx1Z9FsfV+ceRgGlm0Bi21CkEFhOZqh
 8/K2LtgbZ4KPV3YwI5EbshFfZN2TXwaIG3MXaaqs7zX1pqro/RgFlIk97/oaInZG+EjMlf/zO
 e0VqkCMMZmEe64+ZRo8KXwfg99w/LLTs/tFx4BpBeNhc9kcPvvOPnb8h4oUntscVwh/Oz8tVq
 ItiTJmsu+H9WvzwbSaUl4lp8p6zUW9csg4PnV1cOU3K6JgoiWzulkO6F9Z59hF0ANIgFVTHnn
 6R+cX1tDMjKWKp6+NhA5AAV0Am8/g4jSIfuiRV0sAJxsGc2aqst1EfpyLfSJfrS3L0e8zC1yr
 LjaHEr1HbpfZKShUlvUvN7JSMt4bq8p+cHFFMETc3mpMEWaJojAFrPtE29AJ1K0hiPv77G3/5
 nXDwwO8G/esRVConOBLqEQRw==

Improve the readability of the expected output by using a here-doc for
the test body and replacing the unwieldy ${SQ} references with literal
single quotes.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t0080-unit-test-output.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 7bbb065d58..9ec47b7360 100755
=2D-- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -5,7 +5,7 @@ test_description=3D'Test the output of the unit test frame=
work'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

-test_expect_success 'TAP output from unit tests' '
+test_expect_success 'TAP output from unit tests' - <<\EOT
 	cat >expect <<-EOF &&
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
@@ -16,12 +16,12 @@ test_expect_success 'TAP output from unit tests' '
 	ok 4 - failing test and assertion return 0
 	not ok 5 - passing TEST_TODO() # TODO
 	ok 6 - passing TEST_TODO() returns 1
-	# todo check ${SQ}check(x)${SQ} succeeded at t/helper/test-example-tap.c=
:26
+	# todo check 'check(x)' succeeded at t/helper/test-example-tap.c:26
 	not ok 7 - failing TEST_TODO()
 	ok 8 - failing TEST_TODO() returns 0
 	# check "0" failed at t/helper/test-example-tap.c:31
 	# skipping test - missing prerequisite
-	# skipping check ${SQ}1${SQ} at t/helper/test-example-tap.c:33
+	# skipping check '1' at t/helper/test-example-tap.c:33
 	ok 9 - test_skip() # SKIP
 	ok 10 - skipped test returns 1
 	# skipping test - missing prerequisite
@@ -39,12 +39,12 @@ test_expect_success 'TAP output from unit tests' '
 	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
 	#    left: "NULL"
 	#   right: NULL
-	# check "${SQ}a${SQ} =3D=3D ${SQ}\n${SQ}" failed at t/helper/test-exampl=
e-tap.c:64
-	#    left: ${SQ}a${SQ}
-	#   right: ${SQ}\012${SQ}
-	# check "${SQ}\\\\${SQ} =3D=3D ${SQ}\\${SQ}${SQ}" failed at t/helper/tes=
t-example-tap.c:65
-	#    left: ${SQ}\\\\${SQ}
-	#   right: ${SQ}\\${SQ}${SQ}
+	# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:64
+	#    left: 'a'
+	#   right: '\012'
+	# check "'\\\\' =3D=3D '\\''" failed at t/helper/test-example-tap.c:65
+	#    left: '\\\\'
+	#   right: '\\''
 	not ok 17 - messages from failing string and char comparison
 	# BUG: test has no checks at t/helper/test-example-tap.c:92
 	not ok 18 - test with no checks
@@ -54,6 +54,6 @@ test_expect_success 'TAP output from unit tests' '

 	! test-tool example-tap >actual &&
 	test_cmp expect actual
-'
+EOT

 test_done
=2D-
2.46.0
