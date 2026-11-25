Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630815;
	b=0OskzoeeAUIlYv4E+iFkjOVD8qYJrPdLcmTijDRmolEJfny03o9RmCBTuc4g0elM9Zld
	 vd5FY/TPlbTB5f5Xp3hpPwgKoVCGHPAqnfCd7hpi6kiPWLGTV3mzP44i+V4MubHMCthhI
	 lku4bvoaNMOAw6Mv3NzyFwSJ8wnZ3w1X1MiuP7cGzhHOvX7Tca9OGYBrJhjxVCPCviVAa
	 PBZnS4Okp2KlR1Tf2eUhIhFqTL15C/lJ1q7/M0cj/nfeC2cy5SufAnnHNu6Zotg8YTnDJ
	 xSNgd4F7ZOGYZT4kpzdSYZld2mjii9OA5HhrosCdbdKRSksHyM7rH9KB0YLdG3fTABQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630815;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BdnuOtMj57X2w8eUQlCIwktCMIE1qWsH3G0E5QQG0E4=;
	b=VyU7e+7Ada70TNv3BgxtzE/Y7gL9jAHHvItMjUlj0pp3Kc6ZoqI5YjgMXcfz8NL0xZ+f
	 jJAx86CooZUNCn17A+d881HavlMys8OvFzv4tj4diFIGNvRff63Vsi0oLM8LDMJQ2k6oZ
	 MJ6bGLLds6qVRHVW0KTvWI0xy+ZBrAajDyQbxE2qKqdtp0dWx60TBIQouzQHZoRYtX7W0
	 KfoDmje/e3D2tXNKOF2MdDQk6eCL+qadsCFH+ZIJRZKNmyz/egQ9hC998+SwiHd0WOFhj
	 Dh1ur2VX8Vh/CQndLwmRKEA9npMOpwlfjx2x24g1cRDqRYGrBmcZc4+GA8fCHhaRfHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=SMn117cw;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF06606A329
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DF06606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=SMn117cw
Received: from lena.gouders.net (ip-109-41-50-35.web.vodafone.de [109.41.50.35])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6APIJxx62481769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Nov 2026 19:20:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795630808; bh=BdnuOtMj57X2w8eUQlCIwktCMIE1qWsH3G0E5QQG0E4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SMn117cwrNjPPlegSwgHOMEQPvB/h9M7U3vu2srG6KJkpxjaVr/i/GxGQexKSgVau
	 HVVHMumREpH/EXjM3eL8coKjO4hj7Fj5ATY+hOGxIg4KEtN9irITp9ppPZnFYJzCvY
	 WS8y9T/iQo7KWUndqbSxhIEvHVKZzNXggrBRr2I8=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 25 Nov 2026 19:19:44 +0100
Subject: [PATCH v6 4/4] utf8: use bound for utf8_width() calls in
 utf8_strnwidth()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-master-v6-4-cb60af83d189@gouders.net>
References: <20261125-master-v6-0-cb60af83d189@gouders.net>
In-Reply-To: <20261125-master-v6-0-cb60af83d189@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=dirk@gouders.net;
 h=from:subject:message-id; bh=PUUabG8RFun/r3HSrHnCrMf0cp7rat56vBwgepGjNJU=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLLZ1a7Wt/HwPqg21mSd8U5JTuLrmV8fLk1oPr7H+v/+m
 6eNPe3SOhknsDAwcjFUiSmyLJ1UZJemsuJF2TfVTJhBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 zxDI0DFygMjxM2ikF6Q7pOeXpqQWFevlpZY4mloamRsZu5qZGZk4WrhamJu5mRmZmlk6mpiauzq
 6mBmbG5uaOFo6M3BxCsCs+yjA/lesVeXwWZlV12I6bC5m8O09m35d83TWcr7qtbs/NCi8ec9Spf
 xjw91nPF3q6W/yTn/aom27pS9hQbvA83lRQVMTt115ZLJMal2tmP/OJKeDoRkVfOuPOeS8Munau
 rFY9NOtmgfu2zSndl4JDj066//dP7MOnXb7/I6Z58ndvVxzOyVLK5pm7v9rHx9p8uHn/lnT5V6L
 7bc/HpHx+fj+Pb5WXdX8EU4nc3beVdq+ue/1u+t/9ikvXnpZiStj7b5JLaqO4W98xRL11837dTh
 6y8Zb+bf+se6Jedz31mDVcxaPD7UND9WaLYO/hYhfnj9NMoolrSrAOH8/0+Jjq+o+mtz99NHX6N
 9tnewlcaXJjh05AA==
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can be called with boundaries that effectively cause
incomplete multibyte sequences and we should return "len" in such
cases.

But, utf8_width() is called without its optional boundary argument and
will thus work beyond the given boundary.

Fix this by using the boundary argument for utf8_width()
and add some tests that cover such situations.

One might ask whether we can now drop the bounds-check in the
skip_ansi case.  No, that test is still needed, because utf8_width()
considers strings passed with *remainder = 0 as invalid UTF-8 and we
would then return len (and not width) for strings that end with escape
sequences.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 9 +++++++++
 utf8.c                      | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 4b6aa621ea..0408206b32 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -8,6 +8,15 @@
  * cl_assert_equal_i, for the tests.
  */
 
+/*
+ * Test utf8_strnwidth for cjk characters invalidated by len argument.
+ */
+void test_utf8_width__strnwidth_cjk_chopped(void)
+{
+	cl_assert_equal_i(1, utf8_strnwidth("三bytes long, 二columns wide", 1, 1));
+	cl_assert_equal_i(2, utf8_strnwidth("三bytes long, 二columns wide", 3, 1));
+}
+
 /*
  * Test utf8_strnwidth for strings with SGR sequences and corner case length
  * arguments.
diff --git a/utf8.c b/utf8.c
index 87d32f8bcd..6769f2b88b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -229,6 +229,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 	while (string && string < orig + len) {
 		int glyph_width;
 		size_t skip;
+		size_t remainder;
 
 		if (skip_ansi) {
 			while ((skip = display_mode_esc_sequence_len_counted(string,
@@ -239,7 +240,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 				break;
 		}
 
-		glyph_width = utf8_width(&string, NULL);
+		remainder = orig + len - string;
+
+		glyph_width = utf8_width(&string, &remainder);
 		if (glyph_width > 0)
 			width += glyph_width;
 	}

-- 
2.55.0

