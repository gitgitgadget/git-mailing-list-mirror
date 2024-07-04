Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871D101DB
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116270; cv=none; b=SVdA4aOfdgYLAHov58ypAt22yTrVrQ4oMr5j9Pw+Kdmui4PX248AnshwS9lOPGKOFCvrLr0MUL8xMgCY63eAr+fmIL5+fZIzMLRHFKYiw8OQLyE8x6S+SSjwTlOz9K/Tr6JUpYv//7c0yx5W24iEo9JV4/GkL+I9A0FI2YlboFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116270; c=relaxed/simple;
	bh=C2AF10K5TvfQrg1a7d+5XmNHRbfcpOsjiQ3pqTrSIl8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=b5OAejGhr9oZIyEHpftgbq/KO8aBz0nfjo4tGyZwoNDn7oeWcheLj1RI2yq9JsqwPtSU2zLi3JBnBnHzyqFiyuTKC2ubrb/0tbi9xIrZyBqfZ/oZIPQZwhHrV5PaScoan8HvpsitPkJXkVvaCGLyjwzcGiaTvpP0IXDFLtZhVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bZ9C7daS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bZ9C7daS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720116254; x=1720721054; i=l.s.r@web.de;
	bh=0h8BdrwCT4nPInF7GiJI48tU7DkyczbyfNwvLzO2JAM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bZ9C7daSCwAerzaOS8NyoRlMf9pFZlzhAqKsx50FFLlegB31pOI4FuR8fAGzYGl/
	 GdS0LpFQxIf1MCsGdnjGjaucOuUbeNHYOWytY1voVJf6ljaF3JO6xvehtc16MPwDI
	 kA5R2H+1+RK6UFl4XQWZtsMFcKlPDBlC6nF+4zEu3SdO8/h2wn7VNZ1STrPbl6fQh
	 qgG3NFthka055YeD2kWUJ56gQSG9OKGoTniEuXBdLHZ2drxFh3BuH3x19GjkBP4H+
	 /VnC9gonXl9LoiGqjUtYuN9o1kJNKK3QgjWWleCXqhJmCZUNSkLhMWE/JNJuq7RIx
	 w/HDWwc9k6KSqbuAMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1rsrTk2vaA-00qBmP; Thu, 04
 Jul 2024 20:04:14 +0200
Message-ID: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Date: Thu, 4 Jul 2024 20:04:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t-strvec: use test_msg()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3CjNPkDyCmxKdjMdMEnh0i4SGmiWIGMfi7NtA+ywD/trfY7jehi
 dv+jefCiCVDbLIp/EZFPRkH0Um5ToNiGtRIYIQIlGggxNURQyxFQCpmwxY/rW8PrzfRSJRL
 ru5boapP19nC/fn/VNbG6nyt+gDE7Y/lkW8Wlaa2Uh86Cf0vkEoo0Jef6QnJt7MtgUJ/VZA
 PR1vd3NIo5UT/JRPgdGiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VoALtLLS1Lw=;0uhXO5EIGO17YQAhpGXSedQUDyZ
 XW4V+E+7phYvpPiYFyacFIM24X1ZxJ+Fc/BMUbOLpD90iJ7k3RdZv9xtqxv4TnlyqSzyKEwZK
 C2gxv/ku6hDleIX91Sa753IwN1YuhGYRq8XaI8GjNu5xdiTTieOCZqshH8LDF1h48pn0aQqCA
 wu4tnIs0yaGX9nYEWDoFxxdez/sIbobVV8L27hnVIJGJEANFUdNFVFOfHjuJ1tzF3NUPPIXrk
 /3CAF9hhFB4xMgYnH+T6vAtZde3OdRwp6X8TkxUNtIotwqZ1MY0XqMkZ369Kno8xJnQKnLau2
 dQaXf5tXtFiBEZqtlBYxUhUN3P7iX9cutjtMtGisH6S74UPzlOlZStdA+oer6846D8lCdTeqK
 5txxiajZsHLPfPBUq4i6uY63cXkNnCgVxW5PqA5fAKJngRxPYS1m8y79K/nYFbpz9RUD5/p6w
 KKaOT0U6u7KUVIXWO1TQKDwzc2JIrTPdBVlXEO0W3yjO0uW2NAJ9lO5EGRMwdlHth0Bg6h+g2
 JbWpnTZ2qUTS8QxQ5HApSBvmGC+HOjM5MlTB0JCitapTRUmtwdoFO08g2VVb67Sn25dRuLfA8
 Ug0Cgod1V5jmJPve+FwTCrapSiaohr5kTTQI71Gjoo2eVS9EKvwfSFHNH7OghuUtnE3/7lvm4
 J/Kt1MWB2w3Q/kINRQTn2qUZNtBQTI3HKjcuHRVrd6HpS2eDZ4nGnr/bzGkc99clLbOIvNuQe
 Y6eqX8StSqKvLT59HoVvhjKYowKFfduOhCEyfPL8lLqNyJNsld/Kew46xHCNedTT3p7QFYLsK
 FXeDdBjytz2wv71xIfJqdT+tnGycUBj53pCtS+ks0IMCk=

check_strvec_loc() checks each the strvec item by looping through them
and comparing them with expected values.  If a check fails then we'd
like to know which item is affected.  It reports that information by
building a strbuf and delivering its contents using a failing assertion.

Here's an example in which there are less items in the strvec than
expected; the index of the missing item is reported in the last line:

   # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
   #    left: 1
   #   right: 1
   # check "strvec index 1" failed at t/unit-tests/t-strvec.c:71

Note that it is also reported in the third line, i.e. the variable
"nr" contains that index.

Stop printing the index explicitly for checks that already report it.
The message for the same condition as above becomes:

   # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
   #    left: 1
   #   right: 1

For the string comparison, whose error message doesn't include the
index, report it using the simpler and more appropriate test_msg()
instead.  Report the index using its actual name and format the line
like the preceding ones.  The message for an unexpected string value
becomes:

   # check "!strcmp(vec->v[nr], str)" failed at t/unit-tests/t-strvec.c:24
   #    left: "foo"
   #   right: "bar"
   #      nr: 0

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
=2D--
 t/unit-tests/t-strvec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index d4615ab06d..236203af61 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -17,12 +17,12 @@ static void check_strvec_loc(const char *loc, struct s=
trvec *vec, ...)
 			break;

 		if (!check_uint(vec->nr, >, nr) ||
-		    !check_uint(vec->alloc, >, nr) ||
-		    !check_str(vec->v[nr], str)) {
-			struct strbuf msg =3D STRBUF_INIT;
-			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
-			test_assert(loc, msg.buf, 0);
-			strbuf_release(&msg);
+		    !check_uint(vec->alloc, >, nr)) {
+			va_end(ap);
+			return;
+		}
+		if (!check_str(vec->v[nr], str)) {
+			test_msg("     nr: %"PRIuMAX, (uintmax_t)nr);
 			va_end(ap);
 			return;
 		}
=2D-
2.45.2
