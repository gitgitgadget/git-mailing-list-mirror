Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F14749C1
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559116; cv=none; b=MZY3b31KNs3xb6u+o24VxvVLOy48eYpEmrvtiPo6BvGLYgYoB+huYD3qj5Ne0BX/QMif3NHy/rLS9sJ0+Y0wRqy3gKMkQ+6VKkMmoUr2RChAsjaE35hCz3ryJXtFHW3+jxKqs11G9+ao9qmsmmd+8msmYZ9sdd4fvELstoidOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559116; c=relaxed/simple;
	bh=Wxq4k3uZxHQd34NPk2YNrrxRiL+eD1cuk8AUyvy1xX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jT5v1xbzg/59ujurSkh2wP7BgkgzFP3cT0OvnbQXWdcfRRV2Z3QZPoqo7owNcHfG2ayUQQ8utJvqIt40tl/w8IsIere7OZX4gXt9etCsgtXQrjdDkWEri85nhbPL2iGfy2gmvIDbzRR+GqmCt0DP/iD4HTgPzSztToklcb85TmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCtUYFxL; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCtUYFxL"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ee6b2da98so17729467b3.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786559113; x=1787163913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rS8CJiR6tRBt+RDm5s0cNkPTk52kwqiru7azyHdKwQ=;
        b=NCtUYFxLWUN79puhi0rHpbAeT3cW3IfvQDzsL+L+hDiKlz8I88KSnuzUDK+B7883fV
         dRVLDGryWeGRI7GLYNpyQGpHKqhK64GTwtYTbFgmmsL+37lPY+TDqlMIhszXxy5Ecop8
         zmdAV4VzAtRP5AEkbrSqo/PrJq6Fu2Q/4oMgRYQp85TlF+G+HwvYLbXXVwgMqPoWXd4x
         rzZt2LGuG/aE6sZ/z5NkL/MmrFch5BTrYUiLrWC16/FU/9uWoz32UZkKmmrAlnW/IpSw
         KIfr3oMs968wyqx/iLe14Ju4BWR0OGGhl/idU8qMiaPURU7zg2hjExIYB13pvWiKBqsx
         yxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559113; x=1787163913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rS8CJiR6tRBt+RDm5s0cNkPTk52kwqiru7azyHdKwQ=;
        b=GxldxzDSxK7rz5aSuzb5nQ185ly9FtZvgARIi/s/R4i/ArOGoubW9Hs88hCyrh+hCp
         ZlsRr6G4YhR6YehqpOUT3DSudXd/NGzYHedMODpEbfxwXRkC0JtoJ911y4VJVMdPaskn
         hsa0x5tojiE8z58J4TRNrvOqFrJYI2x7d+66znjuGHgzAD8Unytw69xEWlEr/5fNmq+S
         U4zK6niV8ZzWCcB79Duv+T79dzMze6oOucPhJzRUkVhTFXFDvmHr/nrVSVrncd4+k301
         zA1j470ocvEwATDGFzee7xnBp+8ZXb/z97Qk75w52/bCHl+k4+gZcD1bmp4jKh26FUN7
         Frdg==
X-Gm-Message-State: AOJu0YxoqLm4uU216DbTTZqZVlm6H5CxuWZz3kBWgUrj9iL15LqaI00w
	a/2FXWBKRvAOGzk0cxtV9aDKNXQZsuB4/gtj4jCSn3nacpk7eBdodrZQDEg+AuT6uuE=
X-Gm-Gg: AR+sD10Vw5rnydlP/OBhRX+9bAaFzQND36BHvxBmur0JN+PJO0bbfTC0eykHiWhS/rk
	BRrckoYuCWw7PPgu9CawlGu9mZ4bNwB9Kyio8b+JWhcPuxIbJLnC+/Oys7ofijfWlXkzbdJ6Z/0
	q0NyqWDi06HZFk+OZXuJYYGVlaQLK8o6BpB9o/fTiQfieYDgC5atDBUQUMQsxpOn+ucSgHHdzul
	rnyXlBo7gCkowoub2lCiM8lN4wCYtrlvX9OvdBArumt76+DwgDXZ5CATo0agBmdwcenkzXlRo5z
	sbTA5wrfdSWj6uhiqIxD6VO3piPLJI7FTe7O3wp90T7PLt06qfPtTJGeTAqSP3axYmh8ZBOTG0H
	6+HtyiAC37s/NyUalXpjWWzd/9LrGysANdo8dGcXbW+nA0blclOcmpJgp7JOiEyK4nOQW5Md7c5
	f3k39PXnTHSrfXsRGzUjj4bOO46EFF95WSaJbi7AKvXZ/4NtbkVWfVa0yD1UO8ronxRg4Q8lNsZ
	vReL3ha/wk0GP4v8V+xQ72F6Ws50tVRnpMf3TJMJYUmEA==
X-Received: by 2002:a05:690c:6f09:b0:81e:3965:40b5 with SMTP id 00721157ae682-8310a0eb1bamr33607747b3.28.1786559113326;
        Wed, 12 Aug 2026 11:25:13 -0700 (PDT)
Received: from ggordon--20250919-QJQMF.attlocal.net ([2600:1700:1d40:f4c0:c43c:c606:d461:4f02])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-834667a9430sm134007b3.12.2026.08.12.11.25.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 11:25:12 -0700 (PDT)
From: graysongordon-gl <graysongordon1@gmail.com>
X-Google-Original-From: graysongordon-gl <ggordon@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	avarab@gmail.com,
	ps@pks.im,
	Grayson Gordon <graysongordon1@gmail.com>
Subject: [PATCH v3] http: add http.sslVerifyStatus to check stapled OCSP responses
Date: Wed, 12 Aug 2026 14:25:09 -0400
Message-ID: <20260812182509.67358-1-ggordon@gitlab.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqldabzamj.fsf@gitster.g>
References: <20260811170200.43097-1-ggordon@gitlab.com> <20260811204407.52471-1-ggordon@gitlab.com> <xmqqldabzamj.fsf@gitster.g>
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

The new test exercises the fail-closed path, which needs no CA and no OCSP
responder: lib-httpd's server staples nothing, so enabling the option has
to turn a working fetch into a failing one. Verified against an unpatched
build, where exactly the two assertions that depend on the new option fail
and the three controls still pass, and against OpenSSL, GnuTLS and
mbedTLS-linked builds of libcurl.

Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
---
v3: rename the test from t5567 to t5568. t5567 is taken on 'seen' by
    mm/lib-httpd-cgi-safe. t5568 is free on master, next, seen, jch and
    maint as of b9720e4723, and sits next to the other http tests. No
    other change.

v2: drop the block comment above the setopt. What it explained (why the
    check is needed, and why the default is false) is already in the
    commit message, which is where "git blame" leads anyone debugging
    this. No code change otherwise.

 Documentation/config/http.adoc  | 17 +++++++
 http.c                          | 10 ++++
 t/t5568-http-verify-status.sh   | 72 +++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100755 t/t5568-http-verify-status.sh

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
index 5f0f42fb18..c1a66988e7 100644
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
diff --git a/t/t5568-http-verify-status.sh b/t/t5568-http-verify-status.sh
new file mode 100755
index 0000000000..c9167a05c2
--- /dev/null
+++ b/t/t5568-http-verify-status.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='http.sslVerifyStatus'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+LIB_HTTPD_SSL=t
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+# The test server staples no OCSP response, and that is what makes this
+# testable without standing up a CA and a responder: http.sslVerifyStatus is
+# fail-closed, so turning it on has to turn a working fetch into a failing one.
+#
+# lib-httpd.sh exports GIT_SSL_NO_VERIFY for its self-signed certificate. In
+# libcurl the status check is independent of peer verification, so it still
+# applies here.
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+test_expect_success 'create http-accessible bare repository' '
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public main:main
+'
+
+# A TLS backend that cannot check the staple makes curl_easy_setopt() fail,
+# which http.c reports with a distinct message. Skip in that case rather than
+# reporting a failure that really means "this libcurl was built differently".
+# Any other failure leaves the prerequisite satisfied on purpose, so a broken
+# server makes the tests below fail loudly instead of silently vanishing.
+test_lazy_prereq SSL_VERIFYSTATUS '
+	git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err
+	! grep "cannot verify certificate status" err
+'
+
+test_expect_success 'ls-remote succeeds with http.sslVerifyStatus unset' '
+	git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
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
+test_expect_success SSL_VERIFYSTATUS 'per-URL configuration applies to a matching URL' '
+	test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git"
+'
+
+test_expect_success SSL_VERIFYSTATUS 'per-URL configuration is not applied to other URLs' '
+	git -c "http.https://example.com/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_done
-- 
2.55.0

