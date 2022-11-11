Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C844EC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiKKWfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiKKWfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:35:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542321826
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:35:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a14so8124221wru.5
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm7sgHPkPrsEbODF43NykX5a74zh2qi8cxTW4+5l3og=;
        b=dYqEMhlogKQ+RO6jpcET144xyz7Rir/puML7cMcfA8iGTaL7VWqdh+SEt0tBqUzhol
         Yttzx7NxgQtSSjIPQSB4EjOq/WfrMPcFgqRcZ/gHwkZaz+CFwFnhehaPh0UcAIkgkNrc
         ndxaghzjMIDa8lLJSJXyKcwqZBeb6jGWGCjNBdB4X0H3AIi4sjPOiJx9U9SzFx+c0ES/
         Zp/+4fE4pdjBd7pVrUaCFzHRlHupgFvOvSakbLdBNhgroRdyPcT0Nt2/PUvwi1xWMWYs
         JEWLRxC6vWS1MhqqvHBNFJfB0Kbm1nnff5CGEtU/H8JmL/KR/GVelLwuGSQJLSs/wg4E
         V+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm7sgHPkPrsEbODF43NykX5a74zh2qi8cxTW4+5l3og=;
        b=3MhTcFFsrTLltf8OoyMf//3ihg4R9SspJyMKdZ4EE4kN5lw41MNSEH7p78elvlG6vJ
         QKOq5dbH4cGWsGse9bVMTlaS02pyKB5Romw64N797w1T3qREEh0I5d84M16BF4gkDCV9
         jk3VGHK8gFbmK96AgIxHz7ulQQOqVkWaz4C64QVv4UV//YauG0dkhLuUY1+71Ggplgpn
         Xy7336VdgfBTnevTk/w7FNTtKkLjL4VWzNzvoDRq4z4hFasAWOZ7kB+5xohZVGHPreqf
         zddFulZ4wdkMia93uTRk7agtGOYnOSuvhXS9vz88KS6ANdU11tVVYU36kj9a2yKOtnZI
         9rDA==
X-Gm-Message-State: ANoB5pkq9XrqptgjdO2Mig1hPYJO1ana+Pk0m8SQUTpP64M2BomnCSky
        HvaygnHhoLSVbkvROQw5JjI13TToxrg=
X-Google-Smtp-Source: AA0mqf7HBDTtFfxkGffrNCTMzcuW7Ef+g+H9h/LN2PHH8fWnajn9rffIo4SU4BWV7twJdS1rXRt5rw==
X-Received: by 2002:a5d:674a:0:b0:22e:35e3:4427 with SMTP id l10-20020a5d674a000000b0022e35e34427mr2271595wrw.44.1668206108665;
        Fri, 11 Nov 2022 14:35:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m66-20020a1c2645000000b003cfd58409desm327826wmm.13.2022.11.11.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:35:08 -0800 (PST)
Message-Id: <09194dba8cd3fac72c5a21ad29d3c7cde3efd049.1668206106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
References: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
        <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 22:35:05 +0000
Subject: [PATCH v3 1/2] t: run t5551 tests with both HTTP and HTTP/2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Jeff King <peff@peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We have occasionally seen bugs that affect Git running only against an
HTTP/2 web server, not an HTTP one. For instance, b66c77a64e (http:
match headers case-insensitively when redacting, 2021-09-22). But since
we have no test coverage using HTTP/2, we only uncover these bugs in the
wild.

That commit gives a recipe for converting our Apache setup to support
HTTP/2, but:

  - it's not necessarily portable

  - we don't want to just test HTTP/2; we really want to do a variety of
    basic tests for _both_ protocols

This patch handles both problems by running a duplicate of t5551
(labeled as t5559 here) with an alternate-universe setup that enables
HTTP/2. So we'll continue to run t5551 as before, but run the same
battery of tests again with HTTP/2. If HTTP/2 isn't supported on a given
platform, then t5559 should bail during the webserver setup, and
gracefully skip all tests (unless GIT_TEST_HTTPD has been changed from
"auto" to "yes", where the point is to complain when webserver setup
fails).

In theory other http-related test scripts could benefit from the same
duplication, but doing t5551 should give us a reasonable check of basic
functionality, and would have caught both bugs we've seen in the wild
with HTTP/2.

A few notes on the implementation:

  - a script enables the server side config by calling enable_http2
    before starting the webserver. This avoids even trying to load any
    HTTP/2 config for t5551 (which is what lets it keep working with
    regular HTTP even on systems that don't support it). This also sets
    a prereq which can be used by individual tests.

  - As discussed in b66c77a64e, the http2 module isn't compatible with
    the "prefork" mpm, so we need to pick something else. I chose
    "event" here, which works on my Debian system, but it's possible
    there are platforms which would prefer something else. We can adjust
    that later if somebody finds such a platform.

  - The test "large fetch-pack requests can be sent using chunked
    encoding" makes sure we use a chunked transfer-encoding by looking
    for that header in the trace. But since HTTP/2 has its own streaming
    mechanisms, we won't find such a header. We could skip the test
    entirely by marking it with !HTTP2. But there's some value in making
    sure that the fetch itself succeeded. So instead, we'll confirm that
    either we're using HTTP2 _or_ we saw the expected chunked header.

  - the redaction tests fail under HTTP/2 with recent versions of curl.
    This is a bug! I've marked them with !HTTP2 here to skip them under
    t5559 for the moment. Using test_expect_failure would be more
    appropriate, but would require a bunch of boilerplate. Since we'll
    be fixing them momentarily, let's just skip them for now to keep the
    test suite bisectable, and we can re-enable them in the commit that
    fixes the bug.

  - one alternative layout would be to push most of t5551 into a
    lib-t5551.sh script, then source it from both t5551 and t5559.
    Keeping t5551 intact seemed a little simpler, as its one less level
    of indirection for people fixing bugs/regressions in the non-HTTP/2
    tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh                    |  5 +++++
 t/lib-httpd/apache.conf           | 19 ++++++++++++++++---
 t/t5551-http-fetch-smart.sh       | 19 ++++++++++++++-----
 t/t5559-http-fetch-smart-http2.sh |  4 ++++
 4 files changed, 39 insertions(+), 8 deletions(-)
 create mode 100755 t/t5559-http-fetch-smart-http2.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 1f6b9b08d1d..ba9fe36772a 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -174,6 +174,11 @@ prepare_httpd() {
 	fi
 }
 
+enable_http2 () {
+	HTTPD_PARA="$HTTPD_PARA -DHTTP2"
+	test_set_prereq HTTP2
+}
+
 start_httpd() {
 	prepare_httpd >&3 2>&4
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 706799391bd..0294739a77a 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -29,6 +29,11 @@ ErrorLog error.log
 	LoadModule setenvif_module modules/mod_setenvif.so
 </IfModule>
 
+<IfDefine HTTP2>
+LoadModule http2_module modules/mod_http2.so
+Protocols h2c
+</IfDefine>
+
 <IfVersion < 2.4>
 LockFile accept.lock
 </IfVersion>
@@ -64,12 +69,20 @@ LockFile accept.lock
 <IfModule !mod_access_compat.c>
 	LoadModule access_compat_module modules/mod_access_compat.so
 </IfModule>
-<IfModule !mod_mpm_prefork.c>
-	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
-</IfModule>
 <IfModule !mod_unixd.c>
 	LoadModule unixd_module modules/mod_unixd.so
 </IfModule>
+
+<IfDefine HTTP2>
+<IfModule !mod_mpm_event.c>
+	LoadModule mpm_event_module modules/mod_mpm_event.so
+</IfModule>
+</IfDefine>
+<IfDefine !HTTP2>
+<IfModule !mod_mpm_prefork.c>
+	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
+</IfModule>
+</IfDefine>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6a38294a476..ad0a0639e6b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -1,13 +1,19 @@
 #!/bin/sh
 
-test_description='test smart fetching over http via http-backend'
+: ${HTTP_PROTO:=HTTP}
+test_description="test smart fetching over http via http-backend ($HTTP_PROTO)"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
+test "$HTTP_PROTO" = "HTTP/2" && enable_http2
 start_httpd
 
+test_expect_success HTTP2 'enable client-side http/2' '
+	git config --global http.version HTTP/2
+'
+
 test_expect_success 'setup repository' '
 	git config push.default matching &&
 	echo content >file &&
@@ -194,7 +200,7 @@ test_expect_success 'redirects send auth to new location' '
 	expect_askpass both user@host auth/smart/repo.git
 '
 
-test_expect_success 'GIT_TRACE_CURL redacts auth details' '
+test_expect_success !HTTP2 'GIT_TRACE_CURL redacts auth details' '
 	rm -rf redact-auth trace &&
 	set_askpass user@host pass@host &&
 	GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
@@ -206,7 +212,7 @@ test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 	grep -i "Authorization: Basic <redacted>" trace
 '
 
-test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
+test_expect_success !HTTP2 'GIT_CURL_VERBOSE redacts auth details' '
 	rm -rf redact-auth trace &&
 	set_askpass user@host pass@host &&
 	GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth 2>trace &&
@@ -347,7 +353,10 @@ test_expect_success CMDLINE_LIMIT \
 test_expect_success 'large fetch-pack requests can be sent using chunked encoding' '
 	GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
 		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
-	grep "^=> Send header: Transfer-Encoding: chunked" err
+	{
+		test_have_prereq HTTP2 ||
+		grep "^=> Send header: Transfer-Encoding: chunked" err
+	}
 '
 
 test_expect_success 'test allowreachablesha1inwant' '
@@ -473,7 +482,7 @@ test_expect_success 'fetch by SHA-1 without tag following' '
 		--no-tags origin $(cat bar_hash)
 '
 
-test_expect_success 'cookies are redacted by default' '
+test_expect_success !HTTP2 'cookies are redacted by default' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
 	echo "Set-Cookie: Bar=2" >>cookies &&
diff --git a/t/t5559-http-fetch-smart-http2.sh b/t/t5559-http-fetch-smart-http2.sh
new file mode 100755
index 00000000000..9eece71c2c2
--- /dev/null
+++ b/t/t5559-http-fetch-smart-http2.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+HTTP_PROTO=HTTP/2
+. ./t5551-http-fetch-smart.sh
-- 
gitgitgadget

