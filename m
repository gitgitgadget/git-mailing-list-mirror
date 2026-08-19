Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051C39792C
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127328; cv=none; b=I3q9P7gqv5uTc9Mxqk4iRKPiAf9mQwL297Fjm6CwPGRBJKB4oYchtMEZfLKCHuBN5plM7KKLg3wqvksVsFw0cUnrYCAL9t84fRA6h0Kk7nmPbgCYs1UI6qvloL9Z2i9YgvBG8cUnRffdrTRdPttt5jLDqzPEnG9E/v52U01PKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127328; c=relaxed/simple;
	bh=fr86On/RWMghhhXVrr3K8ab6yMICFuang1Pn7Ea3od8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaxV7tFsXLc0wYAuNIYaCF5a7reLAMPxVcZcsrTtQWQBC6n2oiuCsnHSL7FfiTNf69Eb0VQlhVeUDg9b/DFChEj32i3H0pzVc1zSDNRwXHNY9D1c0mmRxBi6QhaxvUGduHfP3Dj6ueSxHrpC13w7Uw4PY9KJKhsUD6RdErZnmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hlyYUHbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bczMmQuu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hlyYUHbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bczMmQuu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 038521D00044;
	Wed, 19 Aug 2026 04:15:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 04:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787127311; x=1787213711; bh=j7CkpngRdg
	Iow/eN+GV9Q8pQteRTd5a1ns8fRO7zNe0=; b=hlyYUHbsov66IZ9QM9laKDq7fM
	MrCPJB/GUBj3qtCe/KmscA5s13LWuXWDwAqDY+p825Q6rioufl6lqRpy70ZZdVKB
	v7+wHAXn4RJ+Cb2G1Iisw7wkl/cYQHT2m8lW6sYdG0NJBXdJZAaiiAfvShbgGs9H
	O7SrqWR4AEJjYpePyQOGyXZ0rjvjySAFoKRgHCb5MUPPeQhr3f8tXrn0jzOMbsYE
	tdmLospHH2OiUnIOpz5xc7QF1lc3DlHYKb4kWX1UJkjE2WxFOAAi76sQgt2VspIs
	sEXotMgarFooRgvy5N0wLN2liHVTIRwmG7UEHDr015sCzMLsuKqb30YJl11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787127311; x=1787213711; bh=j7CkpngRdgIow/eN+GV9Q8pQteRTd5a1ns8
	fRO7zNe0=; b=bczMmQuu8ayDYQjfpG8WQxcJOPMcYakAvLxu+yMEKtrX1XzbNUV
	AF6tBzkjjSnzviLoFzBaZRTlKTYj1fjch7AIpH79PbmANXTPkDhFec2Q2jWeB1iy
	t521ha6NtwZQ/U+9YVWYhoDONdImsTQRGvLimwXH4i5sOJUnjv8jkmisQKbMM0rK
	DRuvt1IlLgyOyXGo1wy6PDhPr0J3fW5p52GEbbh4t/24yH3MyuwZ0m25ahWW9KTW
	q7CIZK3joF9DVAeXPaOZFLXThkqqBsn57OsqKyQ6LuKGJbX4TkfbAS1HNdiZLonn
	nCYD6tRRqKH8JAfwSZc0tVrxFLDXcVoHrOg==
X-ME-Sender: <xms:D2aFakc_eY6uDvmDzV5fnOu9f_VJPgvftqdIPTw0RH4nSht13YsEEw>
    <xme:D2aFatqyvzFhzVNR340HgoCGUN9KVvME5IevtlRY8bcJ8jU3Pw0xTLUZadTTKnV-0
    OJfUXtWkuZlIkiddJNqf-t1Mt8pb3mKZoHcKIBbrIkprElMvu0xew>
X-ME-Received: <xmr:D2aFai4LxYo2ltCfqlzIz6Owk1FvthbPNZ2uqXebcdvUXQzwHYBABViMC-st5clCcGPdy7G6F-RmXbo8pE8r6uRyTXdLLQGaMoUAy1Gj>
X-ME-Proxy-Cause: dmFkZTFZUXfnxbgnDP6lf6s8+TRHmyzNCjEbwNqAhHW/Q/ITw670CLg/n0MEnIP1A1pzZx
    BzkB7sqvqixqU6j2wHEKVwmAZfSmGgod7f2aCE97633iQMBFiJz3zGJ+HkdeaNFviWNibc
    HZaKkCQA6OwHwAyoGiBjtL0RxIevtd++viugVkHhuq+5rlvI7M7ZxsPuL4R6T2ukCAPZIS
    Hc5zgcFCiZ+PplkO9NazRtuBt1z9NeNKMZ/M5w7Awh0gg9+b1LHIDrhxG7ZBxBCpJIoIik
    Ox1sHGv+NsXxP1St44BIOxTzqQgwccFJgN06B5IJa//tv1CWpsBA2aRxAfYigg9hdcultp
    UjBTc1e8onU9W74pmYIp/m/MOgSsI/J/JMxi71DQIPhsFnYl99lu1yI7Tgq0wZAADKoetl
    e3b/34GmLXw421hiPkCu3EM5/15VaBAAUcESf+BDJ/imeRU4yRGoqRVr1t1BN1Kl/Zo5hy
    8v/4zNKHz7I69NjuIKba7jF0PnI0/MaFg5kMtRqlCLA8xpAPacgEzVlphhmmBWfNKDB3Lz
    2aNmrptz2ETYpJHfQpg+joJ8y3L9Epa7OZpc/0GjzKH+Fw11+p4rSKXgYjf3iRMgvCYPO+
    egH0D7hBRkWVJarXKjKPArtIWl5/7qlLba/Hn76xl2xR5NfZsBh0nzn8K/Lg
X-ME-Proxy: <xmx:D2aFajqaIzlVRQg-F6YjeHJ94UbCtCxsHdOPT1kfeHxZv4DXqV2yPw>
    <xmx:D2aFakhCkjRvBOUhBoALduZh7v6S7BwvtfgU85pAV-oFWOFOL4s4hg>
    <xmx:D2aFatJpxF7UOYXfj3QuAX63-946TxamGCjSem64Q9hxirS-wJrt3Q>
    <xmx:D2aFakDEHui6CUkMQbFJG66E1FIl87jwXliUJHooosanvSBrc4f6zA>
    <xmx:D2aFapqxXd5-SDWDWjan0orcQ-aJwnj-2miLBs-BGVGQ4mlHlg20_11G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 04:15:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb3a4060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 08:15:08 +0000 (UTC)
Date: Wed, 19 Aug 2026 10:14:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Grayson Gordon <graysongordon1@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v4] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <aoVmA8jERvRXMsBi@pks.im>
References: <xmqqmruqt36l.fsf@gitster.g>
 <20260817185242.22736-1-ggordon@gitlab.com>
 <aoQOxISPfEwh-ik2@pks.im>
 <CALgUfNhxLEeTK5xH9Dw9ZPBG+oPq9Fw1qDgt=wbXqrnuEetJyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgUfNhxLEeTK5xH9Dw9ZPBG+oPq9Fw1qDgt=wbXqrnuEetJyw@mail.gmail.com>

Hi,

On Tue, Aug 18, 2026 at 10:51:08AM -0400, Grayson Gordon wrote:
> Patrick,

one hint: we prefer to not top-post on this mailing list and instead
answer inline.

[snip]
> ON GNUTLS VS OPENSSL DIFFERENCES
> 
> I appreciate you including the extra context around GnuTLS 3.8's
> GNUTLS_NO_STATUS_REQUEST flag, and curl 8.10 setting it when
> "verifystatus" is false.
> 
> Fair enough, said another way, if either of these are true:
> Condition 1: curl is being built with GnuTLS version < 3.8. (There's
> no NO_STATUS_REQUEST flag to set.)
> OR
> Condition 2:  curl version < 8.10. (Curl's not using the flag.)
> 
> You'll see a discrepancy in cert verification behavior between the
> versions of git built with GnuTLS vs OpenSSL.
> 
> While I appreciate the increased precision here, the purpose of my
> contribution was to expose the functionality that enables git users to
> set it if they so choose. As it stands today, this option is not
> presented. So while the discrepancy is what incited me to look deeper,
> it isn't the central reason I'm here.

That's fair, and I think adding support for OCSP is useful indeed. I
just want us to be more accurate in both the commit message and in the
docs, as the way is currently written is only partially true and thus
misleading both for developers and for readers of git-config(1).

[snip]
> ON COMPREHENSIVE TESTING
> 
> I'll leave this at you and Junio's discretion. I worked with him
> earlier in this thread to avoid introducing another test file and keep
> the testing succinct.
> Right now these tests are just limited to parsing the config and
> applying it to the user-provided remote.
> We COULD do the full suite of tests that cover the full range of
> cases/behaviors:
> - The flag is set AND
>     - no staple sent (should fail)
>     - good staple (should pass)
>     - bad staple (should fail)
> etc.
> 
> We're going to need a lot of infrax for that though:
> - test CA.
> - test server certificate issued by that CA.
> - OCSP responder which knows the certificate's status.
> - a way for the TLS server to obtain and staple that response.
> - a way to control the response so you can test good vs revoked/invalid.
> 
> I set all of that stuff up in my own experiment repo, emulating this
> with nginx in docker...

Yeah, it's certainly non-trivial to set all of this up as there's a
bunch of pieces to it. Something like the below patch would do it, but
I'm not a 100% sure whether it's really worth it given the complexity.

Patrick

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a216e5376f..0af506c950 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -25,6 +25,9 @@
 #    LIB_HTTPD_DAV               enable DAV
 #    LIB_HTTPD_SVN               enable SVN at given location (e.g. "svn")
 #    LIB_HTTPD_SSL               enable SSL
+#    LIB_HTTPD_OCSP              enable OCSP stapling (implies SSL); requires
+#                                the openssl(1) command and needs the caller
+#                                to run start_ocsp_responder after start_httpd
 #    LIB_HTTPD_PROXY             enable proxy
 #
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
@@ -171,15 +174,26 @@ prepare_httpd() {
 
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
@@ -250,6 +264,106 @@ stop_httpd() {
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
+# Set up a certificate authority whose certificate httpd.pem is signed
+# with, such that "openssl ocsp" can vouch for (or revoke) it. Used
+# instead of the self-signed certificate when LIB_HTTPD_OCSP is set.
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
index 4149fc1078..f3287566e0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -242,6 +242,19 @@ SSLSessionCache none
 SSLEngine On
 </IfDefine>
 
+<IfDefine OCSP>
+<IfModule !mod_socache_shmcb.c>
+	LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
+</IfModule>
+
+SSLCertificateChainFile ca.pem
+SSLUseStapling On
+SSLStaplingCache shmcb:ssl_stapling(65536)
+# Also staple responses whose certificate status is not "good", so
+# that clients get to see e.g. "revoked" responses.
+SSLStaplingReturnResponderErrors On
+</IfDefine>
+
 <Location /auth/>
 	AuthType Basic
 	AuthName "git-auth"
diff --git a/t/lib-httpd/ocsp-ca.cnf b/t/lib-httpd/ocsp-ca.cnf
new file mode 100644
index 0000000000..eec4b5b932
--- /dev/null
+++ b/t/lib-httpd/ocsp-ca.cnf
@@ -0,0 +1,35 @@
+[ ca ]
+default_ca              = CA_default
+
+[ CA_default ]
+dir                     = $ENV::OCSP_CA_DIR
+database                = $dir/index.txt
+new_certs_dir           = $dir/newcerts
+serial                  = $dir/serial
+default_md              = sha256
+default_days            = 2
+policy                  = policy_anything
+email_in_dn             = no
+unique_subject          = no
+x509_extensions         = server_cert
+
+[ policy_anything ]
+commonName              = supplied
+
+[ req ]
+default_bits            = 2048
+distinguished_name      = req_distinguished_name
+prompt                  = no
+
+[ req_distinguished_name ]
+# The subject is always given on the command line via -subj.
+
+[ v3_ca ]
+basicConstraints        = critical, CA:TRUE
+keyUsage                = critical, digitalSignature, keyCertSign, cRLSign
+subjectKeyIdentifier    = hash
+
+[ server_cert ]
+basicConstraints        = CA:FALSE
+subjectAltName          = IP:127.0.0.1
+authorityInfoAccess     = OCSP;URI:$ENV::OCSP_URI
diff --git a/t/meson.build b/t/meson.build
index 2133c840da..1413baed80 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -727,6 +727,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5585-http-ssl-ocsp.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5585-http-ssl-ocsp.sh b/t/t5585-http-ssl-ocsp.sh
new file mode 100755
index 0000000000..c279f0c9ca
--- /dev/null
+++ b/t/t5585-http-ssl-ocsp.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='test verification of stapled OCSP responses via http.sslVerifyStatus'
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
+with_ssl_verification () {
+	(
+		sane_unset GIT_SSL_NO_VERIFY &&
+		GIT_SSL_CAINFO="$HTTPD_ROOT_PATH/ca.pem" "$@"
+	)
+}
+
+test_lazy_prereq SSL_VERIFYSTATUS '
+	test_might_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	! grep "http.sslVerifyStatus is set" err
+'
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
+test_expect_success SSL_VERIFYSTATUS 'revoked certificate is accepted without http.sslVerifyStatus' '
+	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_done
