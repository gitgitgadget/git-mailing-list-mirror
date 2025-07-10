Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676D2356D2
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185821; cv=none; b=AfqKCT8OJwrsAQI97GnHPblZrPBYP26U165AC8yNf2pRd9Gc/Ymun27/6GHf2JYzYIBLUpTFajwcw5Rss1ymAfTfbsSLokT5plinDambppWS+byOcyZT0sOslgVXYLqDXd8HkYoNDLik0ZOTj0/v9IImE9AHCP+WZhfiE+8z0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185821; c=relaxed/simple;
	bh=CAoZRQxLr93IhieBMC38f0U9t8vKJhZX+L0+svH5AjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKYLGJPayJc70vGp7+a0WFGEWJPQ/nyqp905l9uCWUKZujUPFnoTOFIohaG3/ynmhy4fmziWOTpl/BrvtoM8pAAQC/sKua0Cjqi+XrTdHd75yZYMMMvhMNPjf/MN3JaDlBqLWi2y1Z5wmPO5pn8Wglis1qrZhcgWvxjfHouJM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bgd9ayF+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bgd9ayF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752185817;
	bh=CAoZRQxLr93IhieBMC38f0U9t8vKJhZX+L0+svH5AjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=bgd9ayF+dgVgfggvKPs9eAQMGskxdxdgBEbhyIrkGO2d8NAaFiNtyKmGE0xkgZHG4
	 /4rw7JFu6Mqt5LP09ziN0hPoc8Q7FG7hwmR3JAqt5QqhCWyoEMkC0cl0FPutgtqSR5
	 zUlNwIkULcZk8nw9VzsGqugkhLQuOAJW9fYLpGcdgbAdeoOh5/KiFZ1Et8n3xsmHHc
	 srCaoNo9q5C0QQCOBx0fX/nwkVj9gG4yHiZpbb8X+bzwe4x9qFg+xW7/KQiBnK/JD+
	 EsaHpUo15EhaGkkOxGcWe8ICCw9+6OumsYkDFi9g5XbDOsIQ/YdDx33fera5yTp/IB
	 WhPCd0fhEdUmfZRn6MdjfGvOVxh+v9spyznteb/HLTvu0Gpy7c+LNLmJPvdev8AOQd
	 xUPfN8kgmcl7IhLwWTyOZINLN/KCoQ5R13+O114xIhGy56Pl8NXp10+NbjcsmF2Js0
	 1tqWrENzAzoJYdfLh/LKiQvlzr+662wdRRcXpTBs1LES0LBLUuK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AFE5D2007F;
	Thu, 10 Jul 2025 22:16:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
Subject: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
Date: Thu, 10 Jul 2025 22:16:41 +0000
Message-ID: <20250710221641.857081-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250710221641.857081-1-sandals@crustytoothpaste.net>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LANGUAGE environment variable is not specified by POSIX, but a
variety of programs using GNU gettext accept it.  The Linux manpages
state that it can contain a colon-separated list of locales.

However, not all locales are valid as languages.  The C and POSIX
locales, for instance, are not languages and are not registered with
IANA, nor are they a part of ISO 639.  In fact, "C" is too short to
match the ABNF production for a language, which must be at least two
characters in length.

Nonetheless, many users provide these values in the LANGUAGE environment
variable for unknown reasons and if they do, we do not want to send a
malformed Accept-Language header to the server.  If there are no other
valid language tags, then send no header; otherwise, send only the valid
tags, ignoring "C" and "POSIX" wherever they may appear, as well as any
variants (such as the "C.UTF-8" locale found on some Linux systems).

We do not reject all possible invalid language tags since doing so
would require bundling a copy of the IANA database and would risk poor
behavior in the face of uncommon languages or values that are not
registered but meet the production for private use or other restricted
interchange.  However, these two values are widely used in the LANGUAGE
header, are well-known and widely used non-language locales, and have
been seen in the wild on the server side.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c                     |  8 ++++++++
 t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/http.c b/http.c
index d88e79fbde..a96df4fcdb 100644
--- a/http.c
+++ b/http.c
@@ -2022,6 +2022,14 @@ static void write_accept_language(struct strbuf *buf)
 			s++;
 
 		if (tag.len) {
+			/*
+			 * These are not valid languages: do not send them to
+			 * the server.
+			 */
+			if (!strcmp(tag.buf, "C") || !strcmp(tag.buf, "POSIX")) {
+				strbuf_reset(&tag);
+				continue;
+			}
 			num_langs++;
 			REALLOC_ARRAY(language_tags, num_langs);
 			language_tags[num_langs - 1] = strbuf_detach(&tag, NULL);
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 538b603f03..96a6833e67 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -86,6 +86,24 @@ test_expect_success 'push to remote repository (standard) with sending Accept-La
 	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" git push -v -v 2>err &&
 	! grep "Expect: 100-continue" err &&
 
+	grep "=> Send header: Accept-Language:" err >err.language &&
+	test_cmp exp err.language &&
+
+	test_commit C-is-not-a-language &&
+	GIT_TRACE_CURL=true LANGUAGE="C" git push -v -v 2>err &&
+
+	! grep "=> Send header: Accept-Language:" err >err.language &&
+	test_must_be_empty err.language &&
+
+	test_commit POSIX-is-not-a-language-either &&
+	GIT_TRACE_CURL=true LANGUAGE="POSIX" git push -v -v 2>err &&
+
+	! grep "=> Send header: Accept-Language:" err >err.language &&
+	test_must_be_empty err.language &&
+
+	test_commit ignore-C-and-POSIX-as-languages-wherever-provided &&
+	GIT_TRACE_CURL=true LANGUAGE="C.UTF-8:ko_KR.UTF-8:POSIX" git push -v -v 2>err &&
+
 	grep "=> Send header: Accept-Language:" err >err.language &&
 	test_cmp exp err.language
 '
