Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DB4052B1
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489437; cv=none; b=cyr0DF3z+Qhnd+1Inpg4WXoU+qk8RKwEhGI9hARZBw+RF0D2pBIdOsg/Ob5wNszz/gKbh49/qXY8VhlSWv7xgpv2Fu13HzyuANiV5LDODaQArwzuj+9iEeLr/YN9KcJpgvFDGHQvLOK021BD5RHHz6QbtAxgh5VXSmp6/elZ66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489437; c=relaxed/simple;
	bh=WAmBpxgldI9MbzzRTat+ZEwSFbrzB3XwzqE3LFqjmqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSceypSDIK2I23ELzHiStnvbQLexpM34SPIwGMkhwtpnREnQb08UZfsWxuEaJFF0AMx4noWQegBkKl15vJPmoCLrt7W2uyuNjcKwW7UtR0tMt5kNy/Mt//H22eR7j5SUipOqE9hMluDFuYr4NHx0CRnc4M08FQlTp0EiQK+HT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJVoJdYj; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJVoJdYj"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab1ef11so708139d50.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789489434; x=1790094234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHivyDq7FFKUVyKFVgK0kEPhK6VQ69bMyXhdspPsmOg=;
        b=TJVoJdYj28bz4mbOSjHH35joKCmIjEAwSJN5veJZpCxs3+yM9eoKWsYW4oxGIxL9jm
         10SV1TjkY3YkDVH2Dzgcpc6oSoCMVwATdxCdv17VF7tGh0A4tbQ9U9vYrUeRiTCRWTPx
         7QFEx/n01pIwTYaqJlQxm+kjf61cQ4FHF6onLr15gfWPNBsFNTsMmNEvx34DkOlRRGUj
         8r6amV0jvaRoH45aZshtcmKHMjIKpUG4akVEN3u96g5/ZXZkf5ZE7GJT2DDz5g5k7iCn
         YfgZ17yZYtkfEyavBVD4w0yhNzN3OvbjNfAV7Wztkr6P81a8O1uDR0mTcOpLPJ3MEe56
         0PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489434; x=1790094234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHivyDq7FFKUVyKFVgK0kEPhK6VQ69bMyXhdspPsmOg=;
        b=Lwvy7zRfNum5GQNw1H5pZeVb8AwOuOv/JYztXoPD/mPI+GlMgIQdeV1V6h4YXFcSyY
         fr9L4JPQ6rvjfrLFL+BVRN6CSW7+NbMebg5MCEJ33YQShV5uD8hiSKf3HRcq0qcKQLZD
         gAK9p4h4YYmMFPFMbFrHhgXearTSwN0weUzWWWM4whjJrRw5qNXW1cXGvmDROH36gBqG
         O+Qz87QOSFxjZNJ7JGNWZDipaidAyyaUVnVExbxnAIWk6C1+f8CDzJaPcRNVIDaHwW71
         OkRDFCgl7OHUEiFmI7/ZFwcF+OzX/ImRCD3zuWLtKoHPwx1b+EeFt6DSWR7wbvMgjdUo
         XO2g==
X-Gm-Message-State: AFuF++l2aj3CaedhyiiWFSb67VpEMtvgpPfoOFP0iqyZ4bC1c3RATwga
	j6mLERbVCQ48b8UrNaA0fSl7rpq60axRqSnVh0dFyMbzS/y5IQLhvnr7pl7Q4UHHePI=
X-Gm-Gg: AYBFou2NArfiYuX3jHVy5anMZhVLhcIbEsSiML7uybs+AbJmi06Jl8Ffp7ZfWBpuVwe
	bnjcKVO2nR4ZRNXIPx6s+PK6HQhw+ZlDkKPNy6LfEd5+r4jsb+tsBcjDNDt11ZLw762QBNAYRXe
	4kGmo5VcBTajgTgrUNriXKoktqkIHxHLkGCF30QpvQsYXYBpUKYc1OzmCAKDQ8rNaDoJ7DPpM+l
	LO2JHGN1f0VVMW54urd+sgDDWtBYXbeVEG84TRai6j1QbPk8OPs0gIwgXRbm1vr9U1pP1TxmJ06
	kpZF6mUTyVCUE+IhOE9+MpPw7/2T9skDOe/x6+8dI10Zv5ovBgPcIHAMcmXJWPl1hgXr9HJj1Y/
	Bve5UZf75MUpJkiFFx41N8j27ORkC1TmH9zrerBA7I0oo5SyRXVWqbhWF09TN0iB6nRkaXdNvyJ
	vAB71waeyK1gqEUuvPIbg1X7AWfE2hei/8Cl1urv7ZzJFY9CrUUXpcZlSpfjlzMuU1fgJcbko4U
	ghZDP609g8gPXnJnPLSWhhCwVwHyvgHfwL3ml2pgtJsiS0Ta6cHTxrQPl2QUIaEoA==
X-Received: by 2002:a05:690e:488f:10b0:66f:c1bc:c085 with SMTP id 956f58d0204a3-6715cbd22femr611602d50.77.1789489433489;
        Tue, 15 Sep 2026 09:23:53 -0700 (PDT)
Received: from ggordon--20250919-QJQMF.attlocal.net ([2600:1700:1d40:f4c0:7166:b5e:74f5:dc08])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f5a3942sm153701d50.2.2026.09.15.09.23.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 09:23:52 -0700 (PDT)
From: graysongordon-gl <graysongordon1@gmail.com>
X-Google-Original-From: graysongordon-gl <ggordon@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	peff@peff.net,
	avarab@gmail.com,
	Grayson Gordon <graysongordon1@gmail.com>
Subject: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP responses
Date: Tue, 15 Sep 2026 12:23:48 -0400
Message-ID: <20260915162348.97792-1-ggordon@gitlab.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqecfez7ie.fsf@gitster.g>
References: <xmqqecfez7ie.fsf@gitster.g>
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
CURLOPT_SSL_VERIFYSTATUS. http_options() is already the collect_fn for a
urlmatch config, so the per-URL form works with no changes:

    git config http.https://example.com/.sslVerifyStatus true

Defaults to false/"off". This is due to the nature of the OCSP protocol.
If enabled, git would expect to receive OCSP stapled responses. If the
stapled responses were not present, the connection would be blocked as
the status of the server's certificate could not be verified. This would
break connections to legitimate services that don't use OCSP as their
certificate revocation mechanism.

If the backend can't check the staple, curl_easy_setopt() returns
CURLE_NOT_BUILT_IN. The error message includes curl_easy_strerror()
along with the option name, so a libcurl built without status
verification is easy to identify.

CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
7.61.0 floor, so no version guard is needed.

The tests that need no OCSP infrastructure stay in t5551, which t5559
runs over https. The rest need a certificate authority, a responder to
answer for it and a server configured to staple, so lib-httpd gains an
opt-in LIB_HTTPD_OCSP mode and t5585 uses it to check that a "good"
staple is accepted, a "revoked" one is refused, and that the revoked one
is ignored when the option is off.

Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
---

Junio, Patrick: this is the combined version we discussed. The
cases that need no OCSP setup stayed in t5551, since t5559 already
runs that file over https, and everything that needs a responder is
in the new t5585.

A note on the testing stuff. SSLUseStapling makes apache
create a mutex in a compiled-in system-wide runtime directory.
I set DefaultRuntimeDir in the OCSP block to keep that
mutex in the server root, the other way resolved to a path
on my box that didn't exist and prevented the server from starting.

Changes since v6:
  - added t5585 and LIB_HTTPD_OCSP support in lib-httpd, taken
    from Patrick's patch
  - moved the SSL_VERIFYSTATUS prereq into lib-httpd.sh so both
    files share one definition

 Documentation/config/http.adoc |  14 ++++
 http.c                         |  14 ++++
 t/lib-httpd.sh                 | 130 +++++++++++++++++++++++++++++++--
 t/lib-httpd/apache.conf        |  16 ++++
 t/lib-httpd/ocsp-ca.cnf        |  35 +++++++++
 t/meson.build                  |   1 +
 t/t5551-http-fetch-smart.sh    |  22 ++++++
 t/t5585-http-ssl-ocsp.sh       |  55 ++++++++++++++
 8 files changed, 282 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..b54f627969 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -196,6 +196,20 @@ http.sslVerify::
 	over HTTPS. Defaults to true. Can be overridden by the
 	`GIT_SSL_NO_VERIFY` environment variable.
 
+http.sslVerifyStatus::
+	Whether to check the revocation status of the server
+	certificate using the stapled OCSP response supplied during
+	the TLS handshake ("OCSP stapling"). Defaults to false, which
+	allows connections to servers without validating if the
+	certificate has been revoked by the certificate authority.
+	Enabling this option will prevent connections to servers that
+	have a certificate status other than "good" per RFC 6960.
+	Connections to servers that do not return a stapled response
+	will also be refused.
++
+Set it per remote, e.g.
+`http.https://example.com/.sslVerifyStatus`, rather than globally.
+
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
diff --git a/http.c b/http.c
index c8fcfd7693..9c2892cafb 100644
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
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 115455784c..554b0e44fa 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -25,6 +25,7 @@
 #    LIB_HTTPD_DAV               enable DAV
 #    LIB_HTTPD_SVN               enable SVN at given location (e.g. "svn")
 #    LIB_HTTPD_SSL               enable SSL
+#    LIB_HTTPD_OCSP              enable OCSP stapling
 #    LIB_HTTPD_PROXY             enable proxy
 #
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
@@ -183,15 +184,26 @@ prepare_httpd() {
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
+	if test -n "$LIB_HTTPD_OCSP"
+	then
+		LIB_HTTPD_SSL=t
+	fi
+
 	if test -n "$LIB_HTTPD_SSL"
 	then
 		HTTPD_PROTO=https
 
-		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
-			-config "$TEST_PATH/ssl.cnf" \
-			-new -x509 -nodes \
-			-out "$HTTPD_ROOT_PATH/httpd.pem" \
-			-keyout "$HTTPD_ROOT_PATH/httpd.pem"
+		if test -n "$LIB_HTTPD_OCSP"
+		then
+			prepare_ocsp_stapling
+			HTTPD_PARA="$HTTPD_PARA -DOCSP"
+		else
+			RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
+				-config "$TEST_PATH/ssl.cnf" \
+				-new -x509 -nodes \
+				-out "$HTTPD_ROOT_PATH/httpd.pem" \
+				-keyout "$HTTPD_ROOT_PATH/httpd.pem"
+		fi
 		GIT_SSL_NO_VERIFY=t
 		export GIT_SSL_NO_VERIFY
 		HTTPD_PARA="$HTTPD_PARA -DSSL"
@@ -262,6 +274,114 @@ stop_httpd() {
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
 }
 
+restart_httpd () {
+	httpd_pid=$(cat "$HTTPD_ROOT_PATH/httpd.pid") &&
+	stop_httpd &&
+	while kill -0 "$httpd_pid" 2>/dev/null
+	do
+		sleep 1
+	done &&
+	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
+		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
+		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
+}
+
+# Check if the linked libcurl can verify stapled OCSP responses.
+test_lazy_prereq SSL_VERIFYSTATUS '
+	test "$HTTPD_PROTO" = "https" &&
+	test_might_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL" 2>err &&
+	! grep "http.sslVerifyStatus is set" err
+'
+
+# Set up a certificate authority. It issues certificate "httpd.pem"
+# and is able to revoke it. Used instead of the self-signed
+# certificate when LIB_HTTPD_OCSP is set.
+prepare_ocsp_stapling () {
+	LIB_HTTPD_OCSP_PORT=$((LIB_HTTPD_PORT + 10000))
+
+	# Referenced by ocsp-ca.cnf.
+	OCSP_CA_DIR="$HTTPD_ROOT_PATH/ocsp-ca"
+	OCSP_URI="http://127.0.0.1:$LIB_HTTPD_OCSP_PORT"
+	export OCSP_CA_DIR OCSP_URI
+
+	mkdir -p "$OCSP_CA_DIR/newcerts" &&
+	>"$OCSP_CA_DIR/index.txt" &&
+	echo 1000 >"$OCSP_CA_DIR/serial" &&
+
+	openssl req -config "$TEST_PATH/ocsp-ca.cnf" \
+		-new -x509 -nodes -days 2 \
+		-subj "/CN=git-test-ca" -extensions v3_ca \
+		-keyout "$HTTPD_ROOT_PATH/ca.key" \
+		-out "$HTTPD_ROOT_PATH/ca.pem" &&
+	openssl req -config "$TEST_PATH/ocsp-ca.cnf" \
+		-new -nodes \
+		-subj "/CN=127.0.0.1" \
+		-keyout "$HTTPD_ROOT_PATH/httpd.key" \
+		-out "$HTTPD_ROOT_PATH/httpd.csr" &&
+	openssl ca -config "$TEST_PATH/ocsp-ca.cnf" -batch \
+		-cert "$HTTPD_ROOT_PATH/ca.pem" \
+		-keyfile "$HTTPD_ROOT_PATH/ca.key" \
+		-in "$HTTPD_ROOT_PATH/httpd.csr" \
+		-out "$HTTPD_ROOT_PATH/httpd.crt" &&
+	cat "$HTTPD_ROOT_PATH/httpd.key" "$HTTPD_ROOT_PATH/httpd.crt" \
+		>"$HTTPD_ROOT_PATH/httpd.pem"
+}
+
+run_ocsp_responder () {
+	openssl ocsp -port "$LIB_HTTPD_OCSP_PORT" \
+		-index "$OCSP_CA_DIR/index.txt" \
+		-CA "$HTTPD_ROOT_PATH/ca.pem" \
+		-rsigner "$HTTPD_ROOT_PATH/ca.pem" \
+		-rkey "$HTTPD_ROOT_PATH/ca.key" \
+		-nmin 60 >>"$HTTPD_ROOT_PATH/ocsp.log" 2>&1 &
+	echo $! >"$HTTPD_ROOT_PATH/ocsp.pid"
+
+	for i in $(test_seq 1 10)
+	do
+		if openssl ocsp -no_nonce \
+			-CAfile "$HTTPD_ROOT_PATH/ca.pem" \
+			-issuer "$HTTPD_ROOT_PATH/ca.pem" \
+			-cert "$HTTPD_ROOT_PATH/httpd.crt" \
+			-url "$OCSP_URI" >/dev/null 2>&1
+		then
+			return 0
+		fi
+		sleep 1
+	done
+	return 1
+}
+
+start_ocsp_responder () {
+	test_atexit stop_ocsp_responder
+
+	if ! run_ocsp_responder
+	then
+		cat "$HTTPD_ROOT_PATH"/ocsp.log >&4 2>/dev/null
+		test_skip_or_die GIT_TEST_HTTPD "OCSP responder setup failed"
+	fi
+}
+
+stop_ocsp_responder () {
+	if test -f "$HTTPD_ROOT_PATH/ocsp.pid"
+	then
+		kill "$(cat "$HTTPD_ROOT_PATH/ocsp.pid")" 2>/dev/null
+		rm -f "$HTTPD_ROOT_PATH/ocsp.pid"
+	fi
+}
+
+# Revoke the certificate used by httpd and make both the OCSP responder
+# and httpd aware of it.
+revoke_httpd_cert () {
+	openssl ca -config "$TEST_PATH/ocsp-ca.cnf" \
+		-cert "$HTTPD_ROOT_PATH/ca.pem" \
+		-keyfile "$HTTPD_ROOT_PATH/ca.key" \
+		-revoke "$HTTPD_ROOT_PATH/httpd.crt" &&
+	stop_ocsp_responder &&
+	run_ocsp_responder &&
+	restart_httpd
+}
+
 test_http_push_nonff () {
 	REMOTE_REPO=$1
 	LOCAL_REPO=$2
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 4149fc1078..de5ca45bb8 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -242,6 +242,22 @@ SSLSessionCache none
 SSLEngine On
 </IfDefine>
 
+<IfDefine OCSP>
+<IfModule !mod_socache_shmcb.c>
+	LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
+</IfModule>
+
+SSLCertificateChainFile ca.pem
+SSLUseStapling On
+# Stapling needs a mutex, which apache would put in a system-wide
+# runtime directory that need not be writable. Keep it in the server
+# root, or httpd refuses to start instead of skipping the tests.
+DefaultRuntimeDir .
+SSLStaplingCache shmcb:ssl_stapling(65536)
+# Staple non-"good" responses too, so clients get to see "revoked".
+SSLStaplingReturnResponderErrors On
+</IfDefine>
+
 <Location /auth/>
 	AuthType Basic
 	AuthName "git-auth"
diff --git a/t/lib-httpd/ocsp-ca.cnf b/t/lib-httpd/ocsp-ca.cnf
new file mode 100644
index 0000000000..47a58139b5
--- /dev/null
+++ b/t/lib-httpd/ocsp-ca.cnf
@@ -0,0 +1,35 @@
+[ ca ]
+default_ca		= CA_default
+
+[ CA_default ]
+dir			= $ENV::OCSP_CA_DIR
+database		= $dir/index.txt
+new_certs_dir		= $dir/newcerts
+serial			= $dir/serial
+default_md		= sha256
+default_days		= 2
+policy			= policy_anything
+email_in_dn		= no
+unique_subject		= no
+x509_extensions		= server_cert
+
+[ policy_anything ]
+commonName		= supplied
+
+[ req ]
+default_bits		= 2048
+distinguished_name	= req_distinguished_name
+prompt			= no
+
+[ req_distinguished_name ]
+# The subject is always given on the command line via -subj.
+
+[ v3_ca ]
+basicConstraints	= critical, CA:TRUE
+keyUsage		= critical, digitalSignature, keyCertSign, cRLSign
+subjectKeyIdentifier	= hash
+
+[ server_cert ]
+basicConstraints	= CA:FALSE
+subjectAltName		= IP:127.0.0.1
+authorityInfoAccess	= OCSP;URI:$ENV::OCSP_URI
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..72cbd12d8f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -728,6 +728,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5585-http-ssl-ocsp.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..c51b14291d 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -680,6 +680,28 @@ test_expect_success 'passing hostname resolution information works' '
 	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
 '
 
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
diff --git a/t/t5585-http-ssl-ocsp.sh b/t/t5585-http-ssl-ocsp.sh
new file mode 100755
index 0000000000..0d1310215f
--- /dev/null
+++ b/t/t5585-http-ssl-ocsp.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='verification of stapled OCSP responses via http.sslVerifyStatus'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+LIB_HTTPD_OCSP=1
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd
+start_ocsp_responder
+
+test_expect_success 'setup repository' '
+	test_commit one &&
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" HEAD:refs/heads/main
+'
+
+# lib-httpd.sh exports GIT_SSL_NO_VERIFY, which would keep us from ever
+# looking at the certificate. Trust our own CA instead.
+with_ssl_verification () {
+	(
+		sane_unset GIT_SSL_NO_VERIFY &&
+		GIT_SSL_CAINFO="$HTTPD_ROOT_PATH/ca.pem" "$@"
+	)
+}
+
+test_expect_success SSL_VERIFYSTATUS 'certificate verification works against test CA' '
+	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with stapled "good" OCSP response' '
+	with_ssl_verification git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_expect_success SSL_VERIFYSTATUS 'revoked certificate is rejected' '
+	revoke_httpd_cert &&
+	with_ssl_verification test_must_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	test_grep -i -e "ocsp" -e "revocation" -e "revoked" -e "certificate status" err
+'
+
+# Depends on the certificate revoked by the preceding test.
+test_expect_success SSL_VERIFYSTATUS 'revoked certificate is accepted without http.sslVerifyStatus' '
+	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_done
-- 
2.50.1 (Apple Git-155)

