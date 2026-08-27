Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997383FFFB3
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851717; cv=none; b=b9DJvlHC2UGeQqgtf5HxevR1Qkm5/EpTqmVrMqTLSreYviyK2Lwalm3fVo9xtkzQwEB4KJedAoIC4k+j5zHM2IgXfKgWaFaJFXpOe42lZzaD2jndHPBqieBl/LsWjxV//g3dbcH0oST5iUwcTvoDZqU1Ge7tte281F/X4GG8WGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851717; c=relaxed/simple;
	bh=Pyvzy1DXry7VgaEawOEKoTai+kzCXQqarqDV47a8e70=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0ZEegCg+M3CPWYE7DGNj153N/S9ZQOEok3MRDjvRZ2m8Q1XVM/VBJGbP/rSw9rAUrKyYIJ8H81Jhpy5VdxdKYkxHqft6yRwL87OnxHxWOR5LWfq1ajaIhXk+FmLsPE4DIce29k9qkWyILdlJ9iMX4sEiw/j0BZkcD6BjicQOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPfOWk8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7Y7uOfv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPfOWk8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7Y7uOfv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AB3D1400132;
	Thu, 27 Aug 2026 13:28:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 27 Aug 2026 13:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787851714; x=1787938114; bh=fZq5JxJ3fj
	iSHG83gL6nr3d8BsKb1YsK4x2+IylWHRQ=; b=oPfOWk8/JerfDKZrE6gtOwwK2q
	Jg10P+PDjc2m6goL45xbGY17QZlm8nH8SZjezWRupohsMmr7c3QbvzmGoTtv5fa7
	6Syfp18sB44y2VrVKzsmXxS/+eIvQoNZiNGrvlaIL9DUPOPunryEjp1qyyY/RTXQ
	gQtOWuvrK+o3fpTl916nQEfTDcyOL9P71rloN5QqlO5DgGHB0714D6EgESOMcs7C
	8N4HrRBe4VkvXZbZTdcPRi4EUOaC4m5tfxUNJziauPF5qo2u2CAHd9pePywr/Ski
	BtJg5Te+lXEAAuwLCI+A1gjjNF9OaS+fiCFqddj7jULQceq+8wVsNN/YaIjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787851714; x=1787938114; bh=fZq5JxJ3fjiSHG83gL6nr3d8BsKb1YsK4x2
	+IylWHRQ=; b=V7Y7uOfvpH3q3CxYMyAsteQIojbXwukey23PSPIC/V2fgp8/uZO
	pezn3QDuwCPgmsUBPms6aFxL5sphSQzYpzn9lPiao0m4wnnSrc51bJ31nkw7NYMS
	ZG4o6WoaEJY4UhLGXjEVGeCJUxvtzaFu8J1/c/Ri4O4gpaCC8PSwuaET6cuujnWK
	mobsY7xDYRusa53/JSJHD5Yo4CxW12OTqCGrsp2s6Wgv1OfEGpDzp+prr0dQmhH8
	KBiu8ubYmFPjE2SOzSAym8eSFK/8ve2rgn3VV5HndlbwehrNVLYRzMfr6OBvmepj
	BjXcE5JYLPuMM48E/8y2R08/paK/U5LWfWA==
X-ME-Sender: <xms:wnOQavSfkm1W25kGBEEldFkTiVt1ezSy5LHbzdvo7JT8ZU4zd_bAag>
    <xme:wnOQamzypkgNgiO0an0oaDrBpoDpIthlv65WK4sbszgUWHDbNhuj-mhG4QmeSmHyG
    KB97IxiU1jrVUBiFn4jqhVQSjjcHA0wBL7x8Af21Wiw6wzDsEKZM90>
X-ME-Received: <xmr:wnOQaic2u0RmB7SgN85XPndpAB4TydpGm0CBXBMZEGTuYUTURvmiXb-Om3J1vCdS4WUcMGyac0n1wSL7Ys5aZIMnDlxJzNPhoQ>
X-ME-Proxy-Cause: dmFkZTGXAIrT+oC2B7gktKCKeM9BXTe3Sm7IoTvmAd5oLr1YoeEQxjfOqv07Nke00AZArD
    7j718vMvaEo1JFaN0flSNoBXtWcnrmg5/ICXpUxfMI1MZzq7YeOjl54pbIy47OwFOjI0iT
    BDw2MN0XRZzSPuh46ZlTvN9qX2BVjrlrfuqWjXcmdZBP2dNMPF2RvcP0Kiwykw4/EoR8wU
    oHGzjoxDFDANahRnbRPid9OrujHqkkcUPciAFEykBnMR+ZuAS23ykkpsENhl7Z+Qnq0/My
    6rBEf6e1ox7ZW3M8IRn1pLOh7Wg0+0aJmdU/omUNL5zjKrqtBRdggZZPjACSd/3ee8J9sg
    che+FcPnHIcT9b16ovKahVMsN3/VvYjMVSOtRgh0jwJWCE60lpTXoKYM3qZB6awdZMRmXY
    1fkXMraRQZ95D4ma/35HEgx2ZbBDv3Uc7D6O/pueJY4Nz8XDzYJ5H7WKkBaQZF3Ic7zy0j
    PeQor70sAyfhZ4n+ggIGxDfD/A3kz3BMhnkei8kvR9dBi/Go/Zy2kA8AZdi7qFn3x3yfZM
    mesTkB+w8Vo4ksZF9BkjFsoOWYmuaRjgGkffkUcl1NEXUcA3YkJV2PdtTYfZEMwJ8dZtx/
    Ku7zcT0BimiXEUBUc1iVMUrHaAO0WbeQtjPMa9Zh+lEK/V7JWvtoRnAaE+PA
X-ME-Proxy: <xmx:wnOQaqJhK1xXV-Gor9o7QG9aKY995qIM9C1HP5ScxN_V9UCdrQ4g7w>
    <xmx:wnOQarGbTp8x1JH5uOnIwUOCVv-OFPiCLAusx5l2i-XbUBsIeClcUA>
    <xmx:wnOQaso7HReQ-Dej8PGFBtSVB0b0PdrK0iRwOz2QJX2__vthrEntgQ>
    <xmx:wnOQasSj9kC4ys_jWE5n2_5ovVKh9gDPHP6ZlAZd7kbEPFIONd2Brw>
    <xmx:wnOQaiq4mu65As4Wf9OB3XxrdVBC-NMcvV4jqaXoNBi-0miH2mO--ER->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 13:28:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] die_for_incompatible_opts(): unbounded number of options
In-Reply-To: <20260826233152.1703497-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Wed, 26 Aug 2026 16:31:50 -0700")
References: <20260826233152.1703497-1-gitster@pobox.com>
Date: Thu, 27 Aug 2026 10:28:32 -0700
Message-ID: <xmqqbjana2wv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We have die_for_incompatible_optN() (for 2 <= N <= 4) to check and
complain when two or more among N mutually incompatible options are
used.

What should a developer do if there are more than four options that
cannot be used at once?

Introduce die_for_incompatible_opts(), which can handle an arbitrary
number of mutually exclusive options, and rewrite existing variants
using it.

The new function takes N pairs of <bool optN, const char *nameN>,
followed by EOF.  Note that even if the caller passes bool, it is
promoted to platform-natural int when calling this variadic
function.  Thus, the implementation uses va_arg(ap, int) to extract
the value, which allows it to distinguish between bool and EOF
serving as the sentinel.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 29 +++++++++++++++++------------
 parse-options.h | 38 ++++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git c/parse-options.c w/parse-options.c
index 4519ead9dc..0aad1e5373 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -1535,26 +1535,31 @@ void NORETURN usage_msg_optf(const char * const fmt,
 	usage_msg_opt(msg.buf, usagestr, options);
 }
 
-void die_for_incompatible_opt4(int opt1, const char *opt1_name,
-			       int opt2, const char *opt2_name,
-			       int opt3, const char *opt3_name,
-			       int opt4, const char *opt4_name)
+void die_for_incompatible_opts(bool opt1, const char *opt1_name, ...)
 {
-	int count = 0;
+	unsigned count = 0;
 	const char *options[4];
+	va_list ap;
 
 	if (opt1)
 		options[count++] = opt1_name;
-	if (opt2)
-		options[count++] = opt2_name;
-	if (opt3)
-		options[count++] = opt3_name;
-	if (opt4)
-		options[count++] = opt4_name;
+	va_start(ap, opt1_name);
+	while (count < ARRAY_SIZE(options)) {
+		int opt_set = va_arg(ap, int);
+		const char *opt_name;
+
+		if (opt_set == EOF)
+			break;
+		opt_name = va_arg(ap, const char *);
+		if (opt_set)
+			options[count++] = opt_name;
+	}
+	va_end(ap);
+
 	switch (count) {
 	case 4:
 		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
-		    opt1_name, opt2_name, opt3_name, opt4_name);
+		    options[0], options[1], options[2], options[3]);
 		break;
 	case 3:
 		die(_("options '%s', '%s', and '%s' cannot be used together"),
diff --git c/parse-options.h w/parse-options.h
index d7f896a933..50bd715b86 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -441,29 +441,43 @@ void NORETURN usage_msg_optf(const char *fmt,
 			     const char * const *usagestr,
 			     const struct option *options, ...);
 
-void die_for_incompatible_opt4(int opt1, const char *opt1_name,
-			       int opt2, const char *opt2_name,
-			       int opt3, const char *opt3_name,
-			       int opt4, const char *opt4_name);
+/*
+ * Take N pairs of <bool optN, const char *opt_nameN> as parameters,
+ * followed by EOF.  The caller declares "The options opt_name1 through
+ * opt_nameN exist and the command line has options whose optN is set."
+ * and asks that an error be raised if two or more of these options are
+ * set at the same time.
+ */
+void die_for_incompatible_opts(bool opt1, const char *opt1_name, ...);
 
+static inline void die_for_incompatible_opt4(int opt1, const char *opt1_name,
+					     int opt2, const char *opt2_name,
+					     int opt3, const char *opt3_name,
+					     int opt4, const char *opt4_name)
+{
+	die_for_incompatible_opts(!!opt1, opt1_name,
+				  !!opt2, opt2_name,
+				  !!opt3, opt3_name,
+				  !!opt4, opt4_name,
+				  EOF);
+}
 
 static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
 					     int opt2, const char *opt2_name,
 					     int opt3, const char *opt3_name)
 {
-	die_for_incompatible_opt4(opt1, opt1_name,
-				  opt2, opt2_name,
-				  opt3, opt3_name,
-				  0, "");
+	die_for_incompatible_opts(!!opt1, opt1_name,
+				  !!opt2, opt2_name,
+				  !!opt3, opt3_name,
+				  EOF);
 }
 
 static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
 					     int opt2, const char *opt2_name)
 {
-	die_for_incompatible_opt4(opt1, opt1_name,
-				  opt2, opt2_name,
-				  0, "",
-				  0, "");
+	die_for_incompatible_opts(!!opt1, opt1_name,
+				  !!opt2, opt2_name,
+				  EOF);
 }
 
 /*
