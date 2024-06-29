Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA11DFE8
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675342; cv=none; b=uAfj4NzoofFcvguEHfqbubYmTj7SW3Js5MCAe1o96XwhIMh/OHsw2BbVoA8mh2CjtsFOFrUV3qr2qLA5xMtS1bwOXiEjmsBKY7HZT4pNyek1l633RU5p0pyDfoVhGt4Pw7KrG+c9qHpM1yCaCk0OASYXc042VJGEXaMZ7TGc3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675342; c=relaxed/simple;
	bh=YyK3jzp7ErpZe2/uMplGBhSUT2DtitcUTovgN0Iyat4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a7SBH582NP8StDSU5msVK8vTfQWTGlUvphST6JveHifyaGe4kbBZEpnHeaT1MB/dKrLDqMKezc+kymVdDFlVaULG0fMpw9jRCWv8KpxyQLyWFCdlcRKQBqWWyQTbw2urZQRObU0TtDZP6rqEcvEb9mkvaez/WAlHGsGOYMXOyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=iJW62I1R; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="iJW62I1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719675332; x=1720280132; i=l.s.r@web.de;
	bh=vChOqHfkyfoog8JInnCFkAZ6GOnV8Wik2MQxV326SVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iJW62I1R1luOc1HSnuVzdx6JHU35hSnGvQhbAdPlXUjXHZWfPHrp9/Qu+WhAT6cA
	 WAUf3rUfjN3SfTrwh6FrmFXboySf0YFzenyKc4EhMf5Txm5DX02naqgIkhIhMjWPI
	 bZumq9W8fwlGW4fRHwCvBLHXyofS/34JsH9gaok/2EsvmApo6mAGrzTnjbD96mChT
	 C4C7oriPEkaUwCor7AtQCsBzcWI3gWVufXeEHIEESK/t64GqWVwNbdgMpvgmiAuqR
	 3egPKloN8fBJAJmV+sNzcf96fdIiYyxCAakYMtesuO93LtNPV0+zoJzNCLGYn1g6x
	 jZ2UJUg/MKMk89YJ1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vRm-1sG3cW1s4S-00uSE1; Sat, 29
 Jun 2024 17:35:32 +0200
Message-ID: <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
Date: Sat, 29 Jun 2024 17:35:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/6] t0080: move expected output to a file
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IySmVKi/O39Le73uMjy7cdg0Xq437iptjlJNFl9kDHkLZhBjIzI
 dDQmQJXcVjo/NlIZCv4qU6q/pnKlFq5G0iirFZgXEJa31fiT2NiEDQi0OMr23FMVbBf6gI7
 2mhq13oK+2CqJAATnO780+Uk7ETnquRRL799kYgG5X1/jH+KfChKxb58ADrHxNcHyTL6+kQ
 bnEFuKzRnlQbnbA1RC+gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QIe9S8Ddtp4=;1O117hPdEIZlM0Q3XzAre/Saglx
 +07lfIi8M4fr3bn9b9Nd2Lyt7TrAdI3wiYgJ0m3FlRdcvlidG0foxhH1PfX4y1+KsX387uyIq
 7CcmrejjDHVvgvqpZZymJyKLGbVQL9mJTM4kue/8C2N2YowBGIyuf6ciKv9Y5IaJLXzFohKxW
 4MYXdUMnNE2JZ8DhJr+8CO/gUcxSsgrKJamU3sOYwkSe07eUBihvw/G8gICwfYG1M9JTBppr2
 B/FpVQxliXZlz5q99+fJyKrg7VbBvpp3uwulK+M4047ivt2EI1PUPcvHgXfhq3HL6I8IsFgN8
 YsYn+m9OvITBargikmXUOGwLW3pIxG49GJF711umjqjcQLACJ8YdIXMjq/Qk0knB5tnJKKklr
 f+LvZKWFzI5HZQU0p3TZfSiCwD/2fNwELnCH3UR+RdaXyt1iIJT6MGqfofbVdcBlU+m9rB6hW
 kx6Kapi7O2qtgHdmoHKg7L/18CqV4SpHGPpZ/Wtb3I5HEtEXUxpiM+tfMh8RWEfYb6SFZt6K4
 uxfsUY4upybwB3H81xieKeCXoZh0KhAoTliEPx8VpXDqiSTW+K05BoMdlhC/Zdy1OvC5Eb8EN
 zNfmeEGe8TAzGOm3GL01FmmfLMIPv3KS8vmm4s/2SAPMljz9lxLB+UninAaAuFfhnjkFLoXk5
 THkotXDItzJgGNb7fE+/5NpLkPjEh4YcrHqdwazL1veMpzyqGi9H9AL+wsVZEekfVIYVvpPQn
 Z6JNd24WAvguVvuMOU6/vnixi8jjhvhL+rZgFU2j7Sz4C+9tOi4RQztuPdhIneexiOYPoOdJ9
 0lcamnE89u93oCwY701bfg5aWW7O9Ym7JshAm8u3/+GuM=

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
