Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893D1591F0
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832674; cv=none; b=loh52xSNg+KS1k0KauuL1IGR7rHeAo9OTkCLCbNr56TbUfri3UXSzBwsxbrN2Q4hAXGQ8jVfmuXTPRvXk8CR6tHK43ShecVrOM6f/XNYZq7C1YzD0HHWDbYP1kOMqMV7fG48/MkjQkQDCSUuBQOe+k6YfTOEEr/ukQo5mgE2Gng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832674; c=relaxed/simple;
	bh=JDq64RXePG+G8EDeSz5JWoDmqg39Hi1oSpwuaPQinyI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kk5/e1c7cQnvFtTp5uXQAMBnQb3DY5QDNHRgf7LZY2EHwA0bm6BFIjknZayNSRC8DH8bH1PPWTCugIKbKr2Jduv77QbXojyhEwNPNsZygpCHalumFNVkgTopZyBo4quEd0orBcGvCjZEUEVH4aLrF14tTfvuVEt73IACsJgv0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=c5ZE0vIP; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="c5ZE0vIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832659; x=1722437459; i=l.s.r@web.de;
	bh=eMTG/630xRM8kg9Zt0ucP/5EufuV5k0wWTLaXLoczgM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c5ZE0vIP1jUS+RLS5oc1nihWEYFIrB2/TdZ4ArOaKTN+2AXZLK3O6x4dVdKAeuxL
	 dvn6BnizQdosA0y9p55SaQjZ112FLyIUU77pBngCP1Yq+c7ATOL0yEsIvouNUxX9i
	 BpX4bkuy7612Yq/SoArrMIEjmzZ/k79lLCjy/AcargtwZXMwx4ht6tVIpwUX/jz7b
	 l2eGmDyzfJJXPSfp0uxdO5kFAMi1GZwBBV6xDyfbKwnZX77M/mpVbAU1Dkg2rCgcK
	 puGg+QwHlBunMSsJtSLBCK5KNrgOQPo4wLnaU1FNRyne/CAXAbxFF31ZemWwek8P+
	 Gzu3EdKQs1TRXtfWNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8gP-1sHAsc0S9h-00xZJv; Wed, 24
 Jul 2024 16:50:59 +0200
Message-ID: <92741509-106a-4eba-b662-74b50f7f859f@web.de>
Date: Wed, 24 Jul 2024 16:50:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/7] unit-tests: show location of checks outside of tests
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
X-Provags-ID: V03:K1:XOTP+chh/WrwqESJtiqRa/ULcPpLHHIbDcf7FpYhxgNEnmEb/Y6
 Q6aqf4yeYPPvI7Qd96gSLYv5/19pn7AsvqyYPDadg03RpYtjOAg8eZ/1slwyVsjkLTatPtU
 aWFLYhfZeUdhVOHBb3igX8h5W5ehfuW8NfcKMutYzcPRSiMuOoKFwFxE6Y33QKUTvEzOc8V
 Vj7KF5QEEpGEsacDVtYqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J6YbM3dobg4=;QG147Z5vXk5/V2CaouzoXiR1VLn
 ZFr/M1UXW/cpCV/gjYEfPh/429PceFEf4+JPz5JRudLKo4h3x96lHSGF1VZ57B5TIGPSo+QN7
 SqQ5OHcSgc/hwuYm15ng/BGgVwaFfc7+FsnkylpZ8frMPjIHcbBm5uGc1Iiew5uoU/blWP1SI
 WcI1iJaFzQJLWrzFk7PB65B+504bIjLqcabYiAz6QMItQZRrju9E3yUYNmlHRRuAukDdvcHZ4
 ARvdvtpPz6NkqfH5wa5hue+1dZVTwA6i3Kf+JkACd0In4rVp2cRsDgNIdZ1OM8pYpDDnt9M85
 HkXaRu0QGugFPcwi/Cv4jENG+adEsRo0UxDuxS3DQO4YCe8OBaImjx+5PxhWXQeePaaoIFIEx
 j9eT8M4VOkN7zcHLUoTrrwBtHtyASNfwynsQu9ElDM/f3sUFU5DFDkW5iacNDosbKTvDQKXqu
 p087uljJ5gzeRW06yk7jZhgIKH0DX3CQ888ixExfNFqKnX37tuWLTOw4KJAWgy5XLtpGimTan
 pFzv+SRelqv/pei8B5qGRGcwZOV+jEi4BX9kbCaKcjSfg+GJIwDWq6qTJns06Aki/6gI9rhOW
 pBRi/fZcUpxl9jNQUWfzYU4llM6ekudydxnRx4+UqiN9EbVZLh0LC0SQF8XJqkDYs/eT/Zc8n
 WqFG0O3c9K0r/X4UQvN9t7Y6icA8C/hpWUxIAKF8sveiwR8Cd3n0v2pTo+tnViJkbGvzGbFNz
 hBk14r6b/0IpLsfzbCJZA1RCJJMJcRUC3qc0aFqAzj2miPPX+d30VGI09sd7IVTQHfTugyrAP
 xF0LMnjuYFYDuC0ep/BH6g6g==

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
Supersedes 9cea2b43b9 (unit-tests: show location of checks outside of
tests, 2024-07-22) in seen.  Changes: Got a test.

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
2.45.2
