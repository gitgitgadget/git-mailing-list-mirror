Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C536F433
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081855; cv=none; b=ST6T2nvtFkSUVamsLoDlhfuPm6qD9uOgYl3LuiOTYKoDqG8rQfQx6gephQ/+80F/vXicRTDBCnbJfe5+zR5d+m2T3tpusQHos8T1CjVZiFR0ARqCyBQQksxGY2LldMXOqJExq7u/Tp9cCbEH83RMw9Ku0xmqlsEQXTUeUFygHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081855; c=relaxed/simple;
	bh=0EcsJPVELhdqTsgBaXievSaVlPvIkZLApfeSiW8jfoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExXVHioapZqKGIPrmLHsByp9+vDcnRE0w7LyhQOTVMojY5iICBJE8f6ekCPwo2mnn77DJCAUxjXLtcP6lg1XEQsZejKN2oCS8JnkTxsOL1m2zPJRyni60QFj/0TuYXiYJH0KDzBC32kXbT83ml01RYOPX0bQfEyqdkKUHEY9q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmQXLmGH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmQXLmGH"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81dfdbd86d1so4293627b3.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787081853; x=1787686653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsDpmSL7SgrsyTtRmTcr+z8i3VtZPey+obmSjHutLtk=;
        b=FmQXLmGHg40q9/XtY23XrU1s8S5Pp4laCgEhmwIXv3xL6KdVH8wY4Nm6aqXlf10SEH
         SvWllq7oq0JsNkL9+/SJFUoZzNPCAXiXeXl5yeJlGuX8OWEdSDIL3AFVRu/sXQIGnBEP
         Ex/HSAURcD0OiZb1U5qJrTPwnfItvaoxgU1t8HlEHKQqp/FZjN8wLWdM7As03JWIw9ug
         Yl0PuBLD4AQqK5AKeyN+jcCRytzcKRCfurLYpsSnDxVbjSNByD0qj21bHsE1ktiBGu/o
         oXIgQtX8aPAJ4Mn9aUe2myeux7mUPddn2Xk7qZUlDGGk19hpJD0Ut0i3kIsRlrcdjlvB
         gajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081853; x=1787686653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZsDpmSL7SgrsyTtRmTcr+z8i3VtZPey+obmSjHutLtk=;
        b=nf5qeZzopgpQ3uPDXbHxfBCBjkqOENNHLgctGucGi1DzSumR7Vb2DVf+mQYlfVimxW
         1zYg/nJ1Cck13WSybrpXPINeAPucS8DtzPPidXNG8R5lzUIH5ptUI2IdjmJasS4o2gCq
         fYhc1rX3XAZoDMozjcuORT1IMQ/m99wxGKdqgdl55qrYdC0WZH8TiF2/LK7WtMvCx2vM
         19XCpi3iGdFJFEUkcx53JQQXER+WWBrF/vJ+bW/Q0cmeEB7INyRb5eJB2x2uk1pQNxd1
         67NeN774cc67UjQRbCrkADX4m1UVyp9NRMvK6SwmRxD7VAX443vFdk5ulJYJjvhLC07Y
         zcnQ==
X-Gm-Message-State: AOJu0YzMPZS38DNtIoklW6QDEkhIl8COO9pU6BZmrF0YccoHvlJ1n9de
	gNIxNKAP0SwZWcYGhPYHkvM6IMvJjNVM0bLr4B7MJfaoFlpOtv95QWgtEOGtfxXhHAs=
X-Gm-Gg: AR+sD12FGomx2UFHx2aax2zCBEsuWIEBtr+56080SFM/Tzx1PHxidLnCbqk9//jfLqU
	U145tBmyN+R42uwVCLoHDiHLh8wo7thEwXOCgNQvt61lxjIv4Hz6Xzz0c/JNIiZ1r2LvJr9ukoi
	Gc8qqEyJkuYS90tPSUJJX5HFJXEpcQn9ral0Nq5umNImmUvlykMKkrYQ8z17UDT4J2q51kLk2Oa
	TpmHrZEb6K92dB3qSSv2Zuyo7T1V2yGJuR+MJzoj8hsmkjBevbkZIhXLfhyH/7Z2qpoS78XLBgh
	4tGKzKT0cggcWMtbhTNyVhBxJqPnicTkb63HFYndP2R6jutusWhV5knkD5FRweu0rjYD1RA61HY
	4Sjd2Eym8Wo7hYQYYWbexXq4O4daAq53KUkULk1++K0AC9CZpYWgCqDusxy8DpdGKoTISsxvYtP
	cKW1mqcKGFzcLTLDzOh0MvXD/BzM65r4mP1JAf4nVjYRtFUDhqDuwjM2FkDBg5V9TaWlS2DSTM4
	rOrc4HoRcRyEMrOcdCJd9RygVFZLH5vQ2Wocm50huqzE8U=
X-Received: by 2002:a05:690c:c6cc:20b0:80d:15a3:7b1c with SMTP id 00721157ae682-8370c93d2ffmr91114657b3.4.1787081853044;
        Tue, 18 Aug 2026 12:37:33 -0700 (PDT)
Received: from ggordon--20250919-QJQMF.attlocal.net ([2600:1700:1d40:f4c0:40a9:be24:84bb:5d49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068263c64sm26700697b3.9.2026.08.18.12.37.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 12:37:31 -0700 (PDT)
From: graysongordon-gl <graysongordon1@gmail.com>
X-Google-Original-From: graysongordon-gl <ggordon@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	avarab@gmail.com,
	ps@pks.im,
	Grayson Gordon <graysongordon1@gmail.com>
Subject: [PATCH v5] http: add http.sslVerifyStatus to check stapled OCSP responses
Date: Tue, 18 Aug 2026 15:37:10 -0400
Message-ID: <20260818193710.56955-1-ggordon@gitlab.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqmruqt36l.fsf@gitster.g>
References: <xmqqmruqt36l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grayson Gordon <graysongordon1@gmail.com>

git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
OCSP "Certificate Status Request" extension and any stapled response a
server sends is ignored, including responses that explicitly state the
certificate has been revoked.

Add an http.sslVerifyStatus boolean that maps to
CURLOPT_SSL_VERIFYSTATUS.
http_options() is already the collect_fn for a urlmatch config, so the
per-URL form works with no changes:

    git config http.https://example.com/.sslVerifyStatus true

Defaults to false/"off". This is due to the nature of the OCSP protocol.
If enabled, git would expect to receive OCSP stapled responses. If the
stapled responses were not present, the connection would be blocked as
the status of the server's certificate could not be verified. This would
break connections to legitimate services that don't use OCSP as their
certificate revocation mechanism.

If the backend can't check the staple, curl_easy_setopt() returns
CURLE_NOT_BUILT_IN. Error message includes curl_easy_strerror() with
the option name to enable users to more easily identify a libcurl
built without status verification.

CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
7.61.0 floor, so no version guard is needed.

Tests are in t5551.

Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
---
 Documentation/config/http.adoc |  9 +++++++++
 http.c                         | 14 ++++++++++++++
 t/t5551-http-fetch-smart.sh    | 29 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..6bc2e3823d 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -196,6 +196,15 @@ http.sslVerify::
 	over HTTPS. Defaults to true. Can be overridden by the
 	`GIT_SSL_NO_VERIFY` environment variable.
 
+http.sslVerifyStatus::
+	Whether to check the revocation status of the server
+	certificate using the stapled OCSP response supplied during
+	the TLS handshake ("OCSP stapling"). Defaults to false.
++
+This is fail-closed: if the server staples no response, verification
+fails. Set it per remote, e.g.
+`http.https://example.com/.sslVerifyStatus`, rather than globally.
+
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
diff --git a/http.c b/http.c
index caccf2108e..4a4dd40fe2 100644
--- a/http.c
+++ b/http.c
@@ -44,6 +44,7 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
+static int curl_ssl_verify_status;
 static int curl_ssl_try;
 static char *curl_http_version;
 static char *ssl_cert;
@@ -400,6 +401,10 @@ static int http_options(const char *var, const char *value,
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslverifystatus", var)) {
+		curl_ssl_verify_status = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp("http.sslcipherlist", var))
 		return git_config_string(&ssl_cipherlist, var, value);
 	if (!strcmp("http.sslversion", var))
@@ -1133,6 +1138,15 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
 	}
 
+	if (curl_ssl_verify_status) {
+		CURLcode ret = curl_easy_setopt(result,
+						CURLOPT_SSL_VERIFYSTATUS, 1L);
+		if (ret != CURLE_OK)
+			die(_("http.sslVerifyStatus is set, but could not "
+			      "enable OCSP status verification: %s"),
+			    curl_easy_strerror(ret));
+	}
+
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..75ab07f031 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -680,6 +680,35 @@ test_expect_success 'passing hostname resolution information works' '
 	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
 '
 
+test_lazy_prereq SSL_VERIFYSTATUS '
+	test "$HTTPD_PROTO" = "https" &&
+	test_might_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	! grep "http.sslVerifyStatus is set" err
+'
+
+test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=true fails without a staple' '
+	test_must_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git"
+'
+
+test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=false is a no-op' '
+	git -c http.sslVerifyStatus=false \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus applies to a matching URL' '
+	test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git"
+'
+
+test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus is not applied to other URLs' '
+	git -c "http.https://example.com/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
 # here user%40host is the URL-encoded version of user@host,
 # which is our intentionally-odd username to catch parsing errors
 url_user=$HTTPD_URL_USER/auth/smart/repo.git
-- 
2.50.1 (Apple Git-155)

