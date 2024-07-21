Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC1443D
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721542561; cv=none; b=U42z8wEtzvJeVy2BXX4lFJPlH4SMMZRTl7FfSl2lteQKtK+kx8FGV9IA9Nbuf1oy4+iHUaddmMf9U4n9bHA8grPEjH4xOUjbG0VfEb0OHXcMTgHabzu6KKSG6AIUmBs1MK+SsO5jGYPQ7TJ6vDRddyWf2RaIj7tAvaGaBahHEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721542561; c=relaxed/simple;
	bh=YyK3jzp7ErpZe2/uMplGBhSUT2DtitcUTovgN0Iyat4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VQZppJ5mA0XHt5qdltEhDxcWJXG7+Id5eVl9Tg1OLbTxI9ZSOP7bNk45XZ334cWav+ezh0TY2vv+Q8HDEE7EXqZ/QN+m+z0wToYIqk2qjqhDpNcg4f8ZpNe9Eo0TSSQRhoOOs0+9/lbxH4ZK5RLDUKg/CDlV7HKjWWH0xZ6CCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bjYmvWbT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bjYmvWbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721542549; x=1722147349; i=l.s.r@web.de;
	bh=vChOqHfkyfoog8JInnCFkAZ6GOnV8Wik2MQxV326SVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bjYmvWbTtJXmV5dRxCU0coB+7RUNJ987COZIWkZc8rDzoSAN166LkWwyFTPRIzBY
	 RDajT433XVk1+EOoRn6EqF4oQUMXw9z1MVPhSoz2E0Hd/1wmI2CvtzvQyJ1gyPJaI
	 pzUl/RlZzTlBvJs8UlPH0xqvsGdafh9X8jQOa0l44/8H6as6q2sNEFyPPqFEW5Kny
	 nU4ph0ElDPQoSiM/8z5qiUkvb+pVHD61NdGB/srBos45MlsF2th0JyljDZmi47efy
	 0ubh8Dk9MrhLGfv5VhM/pHE2Nfg5dW19FIrHdrnpdwEzquln0A0nG6QUH+TZpeuyf
	 cb2pK4DkcTEPTBgyiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1rvWXi3T8w-00be5V; Sun, 21
 Jul 2024 08:15:48 +0200
Message-ID: <af5b8fef-073a-4e85-b660-9672b7d5f629@web.de>
Date: Sun, 21 Jul 2024 08:15:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/6] t0080: move expected output to a file
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
X-Provags-ID: V03:K1:bq29t4BrIXky7JFYV8sVpTcOMsIUSHuqXTJsCHyb/SY1WTSamFm
 8+KMm7rILEfPwHRfSYnvgaxsEoMORNuASNmOgYCaNmPglxn009T3fhsmgFBVv33ZC1Nhjhq
 u/gyk5S7CpCg9p3jMFDopSuQ6ShKFljgAFM66JldRTVredAVP0JIIb38Sb2+YNfyZe4d50E
 55zDbS5UjJRw1wUobLtQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K6ZdSgU0U3A=;WOCBhSvJhGutpmQHwvag2bNa/IE
 lQh3yKTuV+fXJGHvLBTVngS2H+s67VhF3gYdPXV0+KEaWFUtfVv7SPqI4nwtcl6TqL5C0c6Bo
 /qJIYJ/Jyfu4LUH2zxpt6KModKlbVQvk3zNh+aJhwyk0O1ULHobkPG5VOAwGv1gelR21C6sjY
 q31ErPePmQsc807p3XvYeuTmCAa44jC1OXE3ywhwTcssm6CFV8FmVOC2x0onaapRdkeFjS2oW
 yliUIOzpPIPkGiCZkgPpQcaMAB4D4Hdnww3f6WDkja2H90xkDOwGD5lwH4sUG6LxiyA+re4Ye
 ilX5Cd33SwX9t6dHg066QlSMDnj5vaJVwn7ZG/iPhVhtUl58VCdtyf0ogTaFMAmfeNnfRdzbh
 1GWvDRJ50mzBOOFauoeVP8Y4d50Ge9is4h3xi7I0Z2fzxG3C37fOviBRumWG3nJDNpWCrCTX0
 IdWqCh0yzdxES952uSjktxHYLht1jN8M1LXhyndTjdxSkcHtvY1GJ3iPVTjpk5i7f76WEqZBU
 yHLkZaXopfhSjUOc2FYP7BRVGSoBdo73NSITDSV80CR52bkJjRNjiv3SCLn5irWgXDttRfMug
 PUOD4fDsSx7lJIU3p2r+BUQ5x1cE66fKUgZVY5Ck5ee6T3Fr84N+Z56EoBR0RCy+B4cpR+33G
 uO0+18SjPCgga4cs6HuMm1gugU+vC3nsyhrcpGWbO0R2+jx421pVpL7mvLQxlfKnaVfLUgxuc
 BmBIVOTF7uWIQIXL54fTlzDfL3elfQuc5uDqNqu49NQQmA/CLOFTfXTx82mQeKCeqRC+hcNSO
 /LADQOzifyN1NC4Yt+Ity/kw==

Provide the expected output of "test-tool example-tap" verbatim instead
of as a here-doc, to avoid distractions due to quoting, variables
containing quotes and indentation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t0080-unit-test-output.sh | 48 +------------------------------------
 t/t0080/expect              | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 47 deletions(-)
 create mode 100644 t/t0080/expect

diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 7bbb065d58..93f2defa19 100755
=2D-- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -6,54 +6,8 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

 test_expect_success 'TAP output from unit tests' '
-	cat >expect <<-EOF &&
-	ok 1 - passing test
-	ok 2 - passing test and assertion return 1
-	# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:77
-	#    left: 1
-	#   right: 2
-	not ok 3 - failing test
-	ok 4 - failing test and assertion return 0
-	not ok 5 - passing TEST_TODO() # TODO
-	ok 6 - passing TEST_TODO() returns 1
-	# todo check ${SQ}check(x)${SQ} succeeded at t/helper/test-example-tap.c=
:26
-	not ok 7 - failing TEST_TODO()
-	ok 8 - failing TEST_TODO() returns 0
-	# check "0" failed at t/helper/test-example-tap.c:31
-	# skipping test - missing prerequisite
-	# skipping check ${SQ}1${SQ} at t/helper/test-example-tap.c:33
-	ok 9 - test_skip() # SKIP
-	ok 10 - skipped test returns 1
-	# skipping test - missing prerequisite
-	ok 11 - test_skip() inside TEST_TODO() # SKIP
-	ok 12 - test_skip() inside TEST_TODO() returns 1
-	# check "0" failed at t/helper/test-example-tap.c:49
-	not ok 13 - TEST_TODO() after failing check
-	ok 14 - TEST_TODO() after failing check returns 0
-	# check "0" failed at t/helper/test-example-tap.c:57
-	not ok 15 - failing check after TEST_TODO()
-	ok 16 - failing check after TEST_TODO() returns 0
-	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-ex=
ample-tap.c:62
-	#    left: "\011hello\\\\"
-	#   right: "there\"\012"
-	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
-	#    left: "NULL"
-	#   right: NULL
-	# check "${SQ}a${SQ} =3D=3D ${SQ}\n${SQ}" failed at t/helper/test-exampl=
e-tap.c:64
-	#    left: ${SQ}a${SQ}
-	#   right: ${SQ}\012${SQ}
-	# check "${SQ}\\\\${SQ} =3D=3D ${SQ}\\${SQ}${SQ}" failed at t/helper/tes=
t-example-tap.c:65
-	#    left: ${SQ}\\\\${SQ}
-	#   right: ${SQ}\\${SQ}${SQ}
-	not ok 17 - messages from failing string and char comparison
-	# BUG: test has no checks at t/helper/test-example-tap.c:92
-	not ok 18 - test with no checks
-	ok 19 - test with no checks returns 0
-	1..19
-	EOF
-
 	! test-tool example-tap >actual &&
-	test_cmp expect actual
+	test_cmp "$TEST_DIRECTORY"/t0080/expect actual
 '

 test_done
diff --git a/t/t0080/expect b/t/t0080/expect
new file mode 100644
index 0000000000..0cfa0dc6d8
=2D-- /dev/null
+++ b/t/t0080/expect
@@ -0,0 +1,43 @@
+ok 1 - passing test
+ok 2 - passing test and assertion return 1
+# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:77
+#    left: 1
+#   right: 2
+not ok 3 - failing test
+ok 4 - failing test and assertion return 0
+not ok 5 - passing TEST_TODO() # TODO
+ok 6 - passing TEST_TODO() returns 1
+# todo check 'check(x)' succeeded at t/helper/test-example-tap.c:26
+not ok 7 - failing TEST_TODO()
+ok 8 - failing TEST_TODO() returns 0
+# check "0" failed at t/helper/test-example-tap.c:31
+# skipping test - missing prerequisite
+# skipping check '1' at t/helper/test-example-tap.c:33
+ok 9 - test_skip() # SKIP
+ok 10 - skipped test returns 1
+# skipping test - missing prerequisite
+ok 11 - test_skip() inside TEST_TODO() # SKIP
+ok 12 - test_skip() inside TEST_TODO() returns 1
+# check "0" failed at t/helper/test-example-tap.c:49
+not ok 13 - TEST_TODO() after failing check
+ok 14 - TEST_TODO() after failing check returns 0
+# check "0" failed at t/helper/test-example-tap.c:57
+not ok 15 - failing check after TEST_TODO()
+ok 16 - failing check after TEST_TODO() returns 0
+# check "!strcmp("\thello\\", "there\"\n")" failed at t/helper/test-examp=
le-tap.c:62
+#    left: "\011hello\\"
+#   right: "there\"\012"
+# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
+#    left: "NULL"
+#   right: NULL
+# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:64
+#    left: 'a'
+#   right: '\012'
+# check "'\\' =3D=3D '\''" failed at t/helper/test-example-tap.c:65
+#    left: '\\'
+#   right: '\''
+not ok 17 - messages from failing string and char comparison
+# BUG: test has no checks at t/helper/test-example-tap.c:92
+not ok 18 - test with no checks
+ok 19 - test with no checks returns 0
+1..19
=2D-
2.45.2
