Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CA3451A7
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992770; cv=none; b=uvZTyt3Qn4Hq3UTHdAOMjJXpbsPTnlA6KMctFrybEPJdu2Kslzo9+wcNSD4MwR+gQTmHkT1R9wcZxl3OYC+lkcrZdoPyrnAefocCmuzkGohyedQg6hP+hWAAn01GkNIV+UC9nSyh11C/lHAFB4+Exycj6jI+JpPkFdqpw1d8hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992770; c=relaxed/simple;
	bh=iILGNjEfkTPdKc61A5LZibiW+Cocptyig764nFFlWPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxJyaoTvLqAKqk+KWrNcB1rOgVcPCDem3D4N2Dpcx4E58JP+Seviik839FJkbSkCIbGx0g0gmstyYVcJokki9vlQBTe/bZm3FO6OLsTocTnfpUtB8mS5TaH8/o9dVSWMdOxSyGFgOgFUdrOA92Xd2ROjeX7p6P+AvRpNt0Mo2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXPHtd2N; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXPHtd2N"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836eac5682bso4370267b3.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786992767; x=1787597567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9siT+BEQOLjzuBpZ8J8/D9zDFfIhdORJGMEwgjxZ38=;
        b=iXPHtd2N/DR98aranCYPAsTKPdVsziRUfyYX3+Naqf9WWI3lhU8Gcij8n1w6sTQ6Ml
         zKqpMiMSfBPUT56mmS4naM4FVKZ/LylbH1G46xqu6/BoEk6Z0Ynmli7bEBZMEybEHair
         yGfMzi0wU9ZbFJfS7zUkKWm63yNyt6UNRDiR+ef2Z0LxWEFGu297gV+zAnDD7BAAgxEt
         F7foGlnCbsH2yakIJsEJhNqyQqpaijxNocQl7Hi1nzkNEtz2T4jo39bfiwiw2/ob3Rcv
         39N3MZ+r8wCAXMJKfBEO8+EGMde0AZ8DbnN5uSGxU3xkG1k22B19wht6Dqdfm1Qkn+PK
         Wggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786992767; x=1787597567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9siT+BEQOLjzuBpZ8J8/D9zDFfIhdORJGMEwgjxZ38=;
        b=LBWAjH8s1TMW0CCcdniDxUbeqRVT5IYnIYj82ty0cur0NiJB4eFwMnFuhIzusuO7Tc
         /ML3JrRradrlyvVXeNiKLBJCUVeMi161BhQh2du4eriTYITvMDmYKQyAS4INqgz/RqDd
         QlXQoXAYCCVFXMKSzdiaWhux7cmbqNWfMuFG8E7mYGwJ2b5+seyVw70c7tJgdWj7/Ra+
         1mJF4PfbSscxY+MybvPAs4WwEpXAbKG0cpheRzUQAqd8+CTrOC1taY9CjxeOAtnSXttq
         rZV8tpOXxhM5ZcWY2DE8uKHR8NPiVpivFgKsEDynxS6L9RcOYsCPHzbBQH/CUqivKAqi
         E6Zw==
X-Gm-Message-State: AOJu0YyDMHY+rue94JXFbt2JAAAXog6ULdGIMCzL1IufBCL3Cz4YifSH
	yN9rJuaCfhzNKPAGJwlTj0y4tpQeNhDzZHt9nLbw2KAqh2MBsUuuiR8X/zmsBwu/
X-Gm-Gg: AR+sD13HhLzhHDRljx6o5bY3Bmtq2ToRM7DPXkv7wiaB/VjM4BYEnH17+R3bW46fuis
	YhGvvcLMi0aBdeB246QlQ3ofjJItIl1Ao41Bvvbk8YI9yAScRjIKpVVGW+sk8ZMJ+U+SjQsuO+g
	d5q1A4tZeYqLmlybRZzE6HI2KaS8tk9pP7fpqYKpQU6276BGRF7rAPXUSPLGPWYo1RfrTLZCrhd
	hLzpgWwcZEnewnsxwZTW8aHcE0/Cls/lil53IuNgmKWyUbdkvvE3OUd1czh9UoevM9cjLsBI0qW
	ZaKd26A6IGkNI0G86kN1xSFYFvqR32dAYRac3eF93QY+AlhwA3yuSXu6Pn1yBXSdD3ml9/hh232
	A8f0H2/6qYSzgrQKo+mX2zbJl9wxupJYuOSVAhkmcNqeRqVfgdvRqNtW2X3oFiPgXm9tB2EhggM
	a6fQBGtXUWadnjDifxxgkGd6KlcBiMq/0qRPE5hdXaoLK5pJsTPnxHcahHEPaMXIt65B4jXUJxy
	DnIsAFwCfZNFyDoT3EFHNBB2sscp5PdNPiRrLlC4p9Zjw==
X-Received: by 2002:a05:690c:4a04:b0:81e:f337:494b with SMTP id 00721157ae682-841a00ec073mr5909757b3.8.1786992767085;
        Mon, 17 Aug 2026 11:52:47 -0700 (PDT)
Received: from ggordon--20250919-QJQMF.attlocal.net ([2600:1700:1d40:f4c0:b96c:fd9b:692b:f6a1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840695e241asm10589807b3.22.2026.08.17.11.52.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 11:52:46 -0700 (PDT)
From: graysongordon-gl <graysongordon1@gmail.com>
X-Google-Original-From: graysongordon-gl <ggordon@gitlab.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Grayson Gordon <graysongordon1@gmail.com>
Subject: [PATCH v4] http: add http.sslVerifyStatus to check stapled OCSP responses
Date: Mon, 17 Aug 2026 14:52:42 -0400
Message-ID: <20260817185242.22736-1-ggordon@gitlab.com>
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

git asks libcurl to verify the peer certificate and the hostname, but it
never sets CURLOPT_SSL_VERIFYSTATUS, so the "Certificate Status Request"
TLS extension is never requested and any stapled OCSP response the server
does send is ignored.

On an OpenSSL-linked build this is silent. OpenSSL hands the stapled
response to the application and takes no view on it:
SSL_CTX_set_tlsext_status_cb(3) says the callback "should determine
whether the returned OCSP response(s) are acceptable or not", and libcurl
only installs that callback when CURLOPT_SSL_VERIFYSTATUS is set. So git
will fetch from a server whose own staple says its certificate has been
revoked.

A GnuTLS-linked build behaves differently, and the difference does not
come from curl. GnuTLS consults a stapled response inside
gnutls_certificate_verify_peers(), so the failure surfaces through the
verifypeer branch of curl's GnuTLS backend (lib/vtls/gtls.c) whether or
not CURLOPT_SSL_VERIFYSTATUS was ever set. The same git, against the same
server, therefore enforces revocation or not depending only on how its
libcurl was built. That difference is documented here rather than papered
over: this option turns the check on where the backend needs asking, and
setting it to false does not turn the check off on GnuTLS.

Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
Because http_options() is the collect_fn of a urlmatch config, the
per-URL form works with no further changes:

    git config http.https://example.com/.sslVerifyStatus true

It defaults to false, and has to. The option is fail-closed: libcurl fails
verification when the server staples nothing at all, so turning this on
globally would break every remote that does not staple.

Leaving the default to libcurl is not an option either. The same
complaint was raised there in https://github.com/curl/curl/issues/15483
and closed as intentional ("Marked as enhancement since this was done on
purpose"), with the observation that stapling is expected to see less use
as Let's Encrypt drops OCSP support. If the check is to be reachable at
all, the lever has to come from the application.

If the TLS backend cannot check the staple, curl_easy_setopt() returns
CURLE_NOT_BUILT_IN. Fail loudly there rather than carrying on, since
silently not checking is precisely what this option exists to prevent.

CURLOPT_SSL_VERIFYSTATUS has been available since libcurl 7.41.0, well
below the 7.61.0 floor documented in INSTALL, so no version guard is
needed.

The tests go in t5551 and run only in its https pass, which t5559 provides
by sourcing t5551 with LIB_HTTPD_SSL set; that is the only https server
the suite has. They exercise the fail-closed path, which needs no CA and
no OCSP responder: lib-httpd's server staples nothing, so enabling the
option has to turn a working fetch into a failing one. Verified against an
unpatched build, where exactly the two assertions that depend on the new
option fail and the two controls still pass, and against OpenSSL, GnuTLS
and mbedTLS-linked builds of libcurl.

Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
---

v4: drop the new test script.  The four tests now live in t5551, keyed on
$HTTPD_PROTO so they run in the https pass (t5559) only.

To answer the question I skipped past in v3: no, we do not need a new
script.  t5559 is t5551 run with LIB_HTTPD_SSL set, and it is the only
https server the suite has, so a new script would have had to stand up a
second one to reach the same place.  Nothing is left over from t5567 or
t5568 and no test number is spent.

That also means the t/meson.build hunk is not squashed in.  t5551 is
already listed there.  Adding t5568 to the list now would break configure
the other way round, since the list is checked against ls in both
directions and errors with "Test files configured, but not found".

On the lost exit status: changed, but to test_might_fail rather than a
bare &&.  The ls-remote in the prerequisite is expected to fail, that is
the premise of the test, so && short-circuits on the expected failure and
leaves the prerequisite unsatisfied.  Run against the https server both
ways:

    bare &&              ok 51 # skip http.sslVerifyStatus=true fails
                                 without a staple (missing SSL_VERIFYSTATUS)
    test_might_fail      ok 51 - http.sslVerifyStatus=true fails
                                 without a staple

The first still reports "passed all 61 test(s)", which is the failure mode
the prerequisite was written to avoid.  test_might_fail keeps the chain
intact and says the status is ignored on purpose.

Also dropped the "ls-remote succeeds with http.sslVerifyStatus unset"
test.  It was a control for the standalone script, and in t5551 the
surrounding tests already exercise that URL throughout.

The rationale that sat in an in-code comment in v3 is in the log now, per
the earlier review.

Verified: t5551 over plain http and t5559 over https both pass all 61
tests, with the four new ones skipping on the former and running on the
latter.
 Documentation/config/http.adoc | 17 +++++++++++++++++
 http.c                         | 10 ++++++++++
 t/t5551-http-fetch-smart.sh    | 29 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..40b849bf7f 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -196,6 +196,23 @@ http.sslVerify::
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
++
+What it changes depends on the TLS backend libcurl was built against.
+An OpenSSL-linked build ignores a stapled response unless this is set.
+A GnuTLS-linked build consults the staple during ordinary certificate
+verification, so it already rejects a revoked certificate under
+`http.sslVerify` alone, and setting this to `false` does not disable
+that. Where a backend cannot check the staple at all, git fails with an
+error rather than continuing unchecked.
+
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
diff --git a/http.c b/http.c
index caccf2108e..94f8dd817a 100644
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
@@ -1133,6 +1138,11 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
 	}
 
+	if (curl_ssl_verify_status &&
+	    curl_easy_setopt(result, CURLOPT_SSL_VERIFYSTATUS, 1L) != CURLE_OK)
+		die(_("http.sslVerifyStatus is set, but the TLS backend of "
+		      "this libcurl cannot verify certificate status"));
+
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..c11e96c1ac 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -680,6 +680,35 @@ test_expect_success 'passing hostname resolution information works' '
 	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
 '
 
+test_lazy_prereq SSL_VERIFYSTATUS '
+	test "$HTTPD_PROTO" = "https" &&
+	test_might_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	! grep "cannot verify certificate status" err
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

