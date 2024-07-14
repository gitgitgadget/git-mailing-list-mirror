Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BD13BC02
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976825; cv=none; b=H0oOjHpWaubuWMpwJocFnAyxj7Lyd26/88lv1QadfLanb6JmXtrOIE62TIg6LqXcbNnrWDo+4eCy2+2gZgoRfvdIEkKnaBpElKvk/3XG41NM5ehhzWzwJcJLB4kkXf9g4Y3f6I3sxoRKqkaGiCcRjcZkJmNMz+sJAUf6uwyhF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976825; c=relaxed/simple;
	bh=9q82KXBiZhTc3oQ+E65hCjDAnovDUd01OaXSsWiv4gs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M5LSAXtZo/8z79g+W7XK0ZULrSNEv24api8kEudjWh5/g4WJoVqZhELRFXcxr2y1+tu1jPziV5xa4ATckqsl/ROXHHDZVqdXWD3tGSo+1onM+1v2oh2C6AK5V6SZimMOQXJbpk+awkyjCNTGXYJWYAlgB8KHfaHbqs5y+V5iWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=waCnsZrl; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="waCnsZrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720976811; x=1721581611; i=l.s.r@web.de;
	bh=7xVT1kMZaZxEcBI9hQO9zr7VuNhAP/Tp5LxtJjpgFXg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=waCnsZrl9uKypgXyv4U2nlY7jWv7HBO0oqkj0riCYOUkdqBKmCn6Z1olFydv29uI
	 KDkLEeQrq37v8GRWC2w6e/9i1xm9jDJj0IcZ8nZhLO65H9Iw0B/LmjEtclnWT5YMx
	 +Hikyc0GirTVD9TXRRl4acagDqGlsfiHlTJ507laTCiyY6cuNToVa6vBgpk0FaFCA
	 dkqmIOI0BtgqXkQCFaRJM+DUAjpuho6SxP6DYKsYsv2gGCc/vBLzu1MM/V1VZRGqR
	 1qrfK94tjws7LgqUCjjO6KKCWXrvrUMfp6djAWzXI4FJhPPkc4RWgfG5KjC5biPjr
	 3eSpUZMBauY9vtBORw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyeU-1snTFJ2i6s-00P3qY; Sun, 14
 Jul 2024 19:06:51 +0200
Message-ID: <f2bcee2b-88fa-4dcd-8247-f68d842c6a4c@web.de>
Date: Sun, 14 Jul 2024 19:06:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/1] t-strvec: improve check_strvec() output
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Eric Sunshine <sunshine@sunshineco.com>,
 Jeff King <peff@peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
Content-Language: en-US
In-Reply-To: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UVIdXfd0BOkhLCMuYEFTQVKU1fzF336wCFrQWJv6bKTtzeynSUp
 xGpMiwQ+hM8A3/oL6kbyU6LMpd13TsoLeCd7Yohvg8FgMMhddtiycV4F7exiq14ta5li3DA
 fUgsqfBpXTvkVogdmO0jm31utGPqlULMNnLa8bIpVcQW2bYCQTkjSK7JLw+UbiprFqzNBpq
 pGMt5NVG8ucacaG+VyP/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mICgL1lyP+Q=;qAC/D7qzyedIXw27apAU7gLU2ha
 Hrw9YzeNMfMCFzG72lGC4XT4iqG8oK38vyh65g3Gqkelz7Mgdj9057M1TngjQ3ibNlNW8WR37
 vAgJ6kd8D8odipeamzvA2WQy10x5NgfVqT1oztrKuc4KHnO9uVgubOqpy/QWGVPevvm8g05y8
 l4klIaDH18A93/YAuQemOodZM1B1XCjgqTovL1DeFvgt8qQsKMknjQehVh/wf1nKEjjmsgjs4
 mEbAcnvqktvSsIdjr9+1AOxWHtpSzASC7ojElhYQPofgBnia/kNQcKA0uIXBJdy0JEh+1NhQL
 iEizEEseOysrAV4tDEBnwllMzaLwrDMrYO03r/UnEyKpdDTjuCpnI4qRIuxADYOOmnxkjXtns
 6O6Izg+UIlOma5DzpSEsxYUb9Uo9K2MejI3QeeFCXaAautss/WLv2P3K0pnDqANta2GVU9cuv
 75PbEmEOxb42xOB4ICZHWR3vdG1JnNj6mSv+8QesHQfK9SpAD3T1WbIDMCE5okh9MZoOO+lIS
 Nv++9+pHtkFtT0JHF6sQRjW902tPyMXwpZ9N8J+8NNA6FEPMirN1uewJ3mK0nRUm3J6STaOoc
 ZI6z8jRVPjoNrQf0SCtesgrK6Blij6c28eDim/kElt8yPbCXEVRniirbFus5lCut15E/ObF3u
 XN4ftma/IQDmAEailIVMIt1aretl4BP6ULapvZe1LWh/AEvNLXA6p+E1BixX7t9dE/ZZrPUs4
 5SfM+O2NIBh5ew3RtOaX5qAUXzpK6S9DdmfRfanPy3o7jfoCBan6qD7fTDSjzTQlNUtGiSCxe
 BtoGmj+iYksQYJy8CpjMmzxA==

The macro check_strvec calls the function check_strvec_loc(), which
performs the actual checks.  They report the line number inside that
function on error, which is not very helpful.  Before the previous
patch half of them triggered an assertion that reported the caller's
line number using a custom message, which was more useful, but a bit
awkward.

Improve the output by getting rid of check_strvec_loc() and performing
all checks within check_strvec, as they then report the line number of
the call site, aiding in finding the broken test.  Determine the number
of items and check it up front to avoid having to do them both in the
loop and at the end.

Sanity check the expected items to make sure there are any and that the
last one is NULL, as the compiler no longer does that for us with the
removal of the function attribute LAST_ARG_MUST_BE_NULL.

Use only the actual strvec name passed to the macro, the internal
"expect" array name and an index "i" in the output, for clarity.  While
"expect" does not exist at the call site, it's reasonably easy to infer
that it's referring to the NULL-terminated list of expected strings,
converted to an array.

Here's the output with less items than expected in the strvec before:

 # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
 #    left: 1
 #   right: 1

... and with the patch:

 # check "(&vec)->nr =3D=3D ARRAY_SIZE(expect) - 1" failed at t/unit-tests=
/t-strvec.c:53
 #    left: 1
 #   right: 2

With too many items in the strvec we got before:

 # check "vec->nr =3D=3D nr" failed at t/unit-tests/t-strvec.c:34
 #    left: 1
 #   right: 0
 # check "vec->v[nr] =3D=3D NULL" failed at t/unit-tests/t-strvec.c:36
 #    left: 0x6000004b8010
 #   right: 0x0

... and with the patch:

 # check "(&vec)->nr =3D=3D ARRAY_SIZE(expect) - 1" failed at t/unit-tests=
/t-strvec.c:53
 #    left: 1
 #   right: 0

A broken alloc value was reported like this:

 # check "vec->alloc > nr" failed at t/unit-tests/t-strvec.c:20
 #    left: 0
 #   right: 0

 ... and with the patch:

 # check "(&vec)->nr <=3D (&vec)->alloc" failed at t/unit-tests/t-strvec.c=
:56
 #    left: 2
 #   right: 0

An unexpected string value was reported like this:

 # check "!strcmp(vec->v[nr], str)" failed at t/unit-tests/t-strvec.c:24
 #    left: "foo"
 #   right: "bar"
 #      nr: 0

... and with the patch:

 # check "!strcmp((&vec)->v[i], expect[i])" failed at t/unit-tests/t-strve=
c.c:53
 #    left: "foo"
 #   right: "bar"
 #       i: 0

If the strvec is not NULL terminated, we got:

 # check "vec->v[nr] =3D=3D NULL" failed at t/unit-tests/t-strvec.c:36
 #    left: 0x102c3abc8
 #   right: 0x0

... and with the patch we get the line number of the caller:

 # check "!strcmp((&vec)->v[i], expect[i])" failed at t/unit-tests/t-strve=
c.c:53
 #    left: "bar"
 #   right: NULL
 #       i: 1

check_strvec calls without a trailing NULL were detected at compile time
before:

 t/unit-tests/t-strvec.c:71:2: error: missing sentinel in function call [-=
Werror,-Wsentinel]

... and with the patch it's only found at runtime:

 # check "expect[ARRAY_SIZE(expect) - 1] =3D=3D NULL" failed at t/unit-tes=
ts/t-strvec.c:53
 #    left: 0x100e5a663
 #   right: 0x0

We can let check_strvec add the terminating NULL for us and remove it
from callers, making it impossible to forget.  Leave that conversion for
a future patch, though, since this reimplementation is already intrusive
enough.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
For next, on top of c6f35e529e t-strvec: use test_msg().

 t/unit-tests/t-strvec.c | 46 +++++++++++++----------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index 236203af61..fdb28ba220 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -3,38 +3,20 @@
 #include "strvec.h"

 #define check_strvec(vec, ...) \
-	check_strvec_loc(TEST_LOCATION(), vec, __VA_ARGS__)
-LAST_ARG_MUST_BE_NULL
-static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
-{
-	va_list ap;
-	size_t nr =3D 0;
-
-	va_start(ap, vec);
-	while (1) {
-		const char *str =3D va_arg(ap, const char *);
-		if (!str)
-			break;
-
-		if (!check_uint(vec->nr, >, nr) ||
-		    !check_uint(vec->alloc, >, nr)) {
-			va_end(ap);
-			return;
-		}
-		if (!check_str(vec->v[nr], str)) {
-			test_msg("     nr: %"PRIuMAX, (uintmax_t)nr);
-			va_end(ap);
-			return;
-		}
-
-		nr++;
-	}
-	va_end(ap);
-
-	check_uint(vec->nr, =3D=3D, nr);
-	check_uint(vec->alloc, >=3D, nr);
-	check_pointer_eq(vec->v[nr], NULL);
-}
+	do { \
+		const char *expect[] =3D { __VA_ARGS__ }; \
+		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
+		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
+		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
+		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
+			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
+				if (!check_str((vec)->v[i], expect[i])) { \
+					test_msg("      i: %"PRIuMAX, i); \
+					break; \
+				} \
+			} \
+		} \
+	} while (0)

 static void t_static_init(void)
 {
=2D-
2.45.2
