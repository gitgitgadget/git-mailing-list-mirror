Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A3C4BA26
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B0021556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ2fX0Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBZUJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:09:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37066 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgBZUJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:09:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so343629edr.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CYgdvY/jwh6P+Sat0uPvvb/t1OcImnRTUZNc+CLAzmY=;
        b=GJ2fX0HsEzfGlXDjWr6EgGNLiqvDhVeD37mE+e73zUtuC1FuYikJo+gdNh5S895juh
         O9ttL5M8iaU4LPWLSKZwj62cZ7dUvoTkX7dOkUJ+OS9I41fHVGX5qo0T25vtRsWiRs2e
         LCBc8elsldNmKZ0FrFF1xGqm14dK1p3/VMOm/lN3Bxr81Lv8ENMBzAKqrZMv32Y9SlsG
         nYjY060m93ARCxMsd5Vc+68/GX624cbHkfaWdsr3mbLuH9V6+AJegnEROgnJLWLX2uOt
         4E0k52EJBEFBG3pSSz7w8cNh8+lrTzzq638pTG/X0MecS4K2lWVViFfiAG035u9x3o3P
         23cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CYgdvY/jwh6P+Sat0uPvvb/t1OcImnRTUZNc+CLAzmY=;
        b=SZneNwQMJsuV+5rz2gz7+uJNdjm6JPvtRvIi187bEEuG1mLhIOAurgmE9BOO+ouL5C
         rZVfOYeSbkbfglaUPfMjf2Zc6o5hCZxJt0b9btJrPPlPkc4cpl9xFimhgStlneC8FRRV
         eorCFyOXSoR+5Po0GaEh5anOuGkmJCnbAfBe1rUqyqXR9z10YTDYAPtT0UsRGnH/CqT6
         fTHwXujix8N8GGMOa9mlAWTDi8R5CcCV9fU6vH3+m9GEhLVQl066mhDczrF4Mmec2P85
         XdjFqwSBgVPC3lXHp/u787sLHyKqeZkhdxTFD95hkfrk7HxTQbOwsd88X/mBUcwjGJjo
         4zzA==
X-Gm-Message-State: APjAAAXDc5yMtjIfz9ReEIRmB9k1c137YE2c7fPlV1JVpGzTVTaGI03K
        +D3MdgruIX5HtSJ0Xq7Y+M0nYHHN
X-Google-Smtp-Source: APXvYqxYjsBFUHMrPyAOEwIGswypX2QfxeGhuS7uBP+vSQE3ya798UIr8cpBaUxei3u5dr/SXVrrCA==
X-Received: by 2002:a17:906:a81:: with SMTP id y1mr455134ejf.270.1582747777534;
        Wed, 26 Feb 2020 12:09:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm202135eds.31.2020.02.26.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:09:37 -0800 (PST)
Message-Id: <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 20:09:33 +0000
Subject: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Among other differences relative to GNU sed, BSD sed always ends its
output with a trailing newline, even if the input did not have such a
trailing newline.

Surprisingly, this makes three httpd-based tests fail on macOS: t5616,
t5702 and t5703. ("Surprisingly" because those tests have been around
for some time, but apparently nobody runs them on macOS with a working
Apache2 setup.)

The reason is that we use `sed` in those tests to filter the response of
the web server. Apart from the fact that we use GNU constructs (such as
using a space after the `c` command instead of a backslash and a
newline), we have another problem: BSD sed LF-only newlines while
webservers are supposed to use CR/LF ones.

Even worse, t5616 uses `sed` to replace a binary part of the response
with a new binary part (kind of hoping that the replaced binary part
does not contain a 0x0a byte which would be interpreted as a newline).

To that end, it calls on Perl to read the binary pack file and
hex-encode it, then calls on `sed` to prefix every hex digit pair with a
`\x` in order to construct the text that the `c` statement of the `sed`
invocation is supposed to insert. So we call Perl and sed to construct a
sed statement. The final nail in the coffin is that BSD sed does not
even interpret those `\x<hex>` constructs.

Let's just replace all of that by Perl snippets. With Perl, at least, we
do not have to deal with GNU vs BSD semantics, we do not have to worry
about unwanted trailing newlines, and we do not have to spawn commands
to construct arguments for other commands to be spawned (i.e. we can
avoid a whole lot of shell scripting complexity).

The upshot is that this fixes t5616, t5702 and t5703 on macOS with
Apache2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-httpd.sh                     |  2 +-
 t/lib-httpd/apache.conf            |  6 ++---
 t/lib-httpd/apply-one-time-perl.sh | 27 +++++++++++++++++++++
 t/lib-httpd/apply-one-time-sed.sh  | 24 -------------------
 t/t5537-fetch-shallow.sh           | 10 ++++----
 t/t5616-partial-clone.sh           | 38 +++++++++++++++++-------------
 t/t5702-protocol-v2.sh             | 12 +++++-----
 t/t5703-upload-pack-ref-in-want.sh |  6 ++---
 8 files changed, 66 insertions(+), 59 deletions(-)
 create mode 100644 t/lib-httpd/apply-one-time-perl.sh
 delete mode 100644 t/lib-httpd/apply-one-time-sed.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 656997b4d66..1449ee95e9e 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,7 +132,7 @@ prepare_httpd() {
 	install_script broken-smart-http.sh
 	install_script error-smart-http.sh
 	install_script error.sh
-	install_script apply-one-time-sed.sh
+	install_script apply-one-time-perl.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 5c1c86c193a..994e5290d63 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -113,7 +113,7 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
-<LocationMatch /one_time_sed/>
+<LocationMatch /one_time_perl/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
@@ -122,7 +122,7 @@ ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
-ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
+ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
@@ -135,7 +135,7 @@ ScriptAliasMatch /one_time_sed/(.*) apply-one-time-sed.sh/$1
 <Files error.sh>
   Options ExecCGI
 </Files>
-<Files apply-one-time-sed.sh>
+<Files apply-one-time-perl.sh>
 	Options ExecCGI
 </Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
diff --git a/t/lib-httpd/apply-one-time-perl.sh b/t/lib-httpd/apply-one-time-perl.sh
new file mode 100644
index 00000000000..09a0abdff7c
--- /dev/null
+++ b/t/lib-httpd/apply-one-time-perl.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+# If "one-time-perl" exists in $HTTPD_ROOT_PATH, run perl on the HTTP response,
+# using the contents of "one-time-perl" as the perl command to be run. If the
+# response was modified as a result, delete "one-time-perl" so that subsequent
+# HTTP responses are no longer modified.
+#
+# This can be used to simulate the effects of the repository changing in
+# between HTTP request-response pairs.
+if test -f one-time-perl
+then
+	LC_ALL=C
+	export LC_ALL
+
+	"$GIT_EXEC_PATH/git-http-backend" >out
+	perl -pe "$(cat one-time-perl)" out >out_modified
+
+	if cmp -s out out_modified
+	then
+		cat out
+	else
+		cat out_modified
+		rm one-time-perl
+	fi
+else
+	"$GIT_EXEC_PATH/git-http-backend"
+fi
diff --git a/t/lib-httpd/apply-one-time-sed.sh b/t/lib-httpd/apply-one-time-sed.sh
deleted file mode 100644
index bf7689d0202..00000000000
--- a/t/lib-httpd/apply-one-time-sed.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/sh
-
-# If "one-time-sed" exists in $HTTPD_ROOT_PATH, run sed on the HTTP response,
-# using the contents of "one-time-sed" as the sed command to be run. If the
-# response was modified as a result, delete "one-time-sed" so that subsequent
-# HTTP responses are no longer modified.
-#
-# This can be used to simulate the effects of the repository changing in
-# between HTTP request-response pairs.
-if test -f one-time-sed
-then
-	"$GIT_EXEC_PATH/git-http-backend" >out
-	sed "$(cat one-time-sed)" out >out_modified
-
-	if cmp -s out out_modified
-	then
-		cat out
-	else
-		cat out_modified
-		rm one-time-sed
-	fi
-else
-	"$GIT_EXEC_PATH/git-http-backend"
-fi
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 9e16512fe31..4f10057e9f1 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -237,7 +237,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	git -C "$REPO" config protocol.version 2 &&
 	git -C client config protocol.version 2 &&
 
-	git -C client fetch --depth=2 "$HTTPD_URL/one_time_sed/repo" master:a_branch &&
+	git -C client fetch --depth=2 "$HTTPD_URL/one_time_perl/repo" master:a_branch &&
 
 	# Craft a situation in which the server sends back an unshallow request
 	# with an empty packfile. This is done by refetching with a shorter
@@ -246,13 +246,13 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	printf "$(test_oid sed)" \
 	       "$(git -C "$REPO" rev-parse HEAD)" \
 	       "$(git -C "$REPO" rev-parse HEAD^)" \
-	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
+	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
-		fetch --depth=1 "$HTTPD_URL/one_time_sed/repo" \
+		fetch --depth=1 "$HTTPD_URL/one_time_perl/repo" \
 		master:a_branch &&
 
-	# Ensure that the one-time-sed script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-sed" &&
+	# Ensure that the one-time-perl script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-perl" &&
 
 	# Ensure that the resulting repo is consistent, despite our failure to
 	# fetch.
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9a9178fd281..0eb5b1c47b1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -398,14 +398,18 @@ intersperse () {
 	sed 's/\(..\)/'$1'\1/g'
 }
 
-# Create a one-time-sed command to replace the existing packfile with $1.
+# Create a one-time-perl command to replace the existing packfile with $1.
 replace_packfile () {
 	# The protocol requires that the packfile be sent in sideband 1, hence
 	# the extra \x01 byte at the beginning.
-	printf "1,/packfile/!c %04x\\\\x01%s0000" \
-		"$(($(wc -c <$1) + 5))" \
-		"$(hex_unpack <$1 | intersperse '\\x')" \
-		>"$HTTPD_ROOT_PATH/one-time-sed"
+	cp $1 "$HTTPD_ROOT_PATH/one-time-pack" &&
+	echo 'if (/packfile/) {
+		print;
+		my $length = -s "one-time-pack";
+		printf "%04x\x01", $length + 5;
+		print `cat one-time-pack` . "0000";
+		last
+	}' >"$HTTPD_ROOT_PATH/one-time-perl"
 }
 
 test_expect_success 'upon cloning, check that all refs point to objects' '
@@ -429,16 +433,16 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 	# \x01 byte at the beginning.
 	replace_packfile incomplete.pack &&
 
-	# Use protocol v2 because the sed command looks for the "packfile"
+	# Use protocol v2 because the perl command looks for the "packfile"
 	# section header.
 	test_config -C "$SERVER" protocol.version 2 &&
 	test_must_fail git -c protocol.version=2 clone \
-		--filter=blob:none $HTTPD_URL/one_time_sed/server repo 2>err &&
+		--filter=blob:none $HTTPD_URL/one_time_perl/server repo 2>err &&
 
 	test_i18ngrep "did not send all necessary objects" err &&
 
-	# Ensure that the one-time-sed script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
+	# Ensure that the one-time-perl script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
 '
 
 test_expect_success 'when partial cloning, tolerate server not sending target of tag' '
@@ -469,17 +473,17 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	# \x01 byte at the beginning.
 	replace_packfile incomplete.pack &&
 
-	# Use protocol v2 because the sed command looks for the "packfile"
+	# Use protocol v2 because the perl command looks for the "packfile"
 	# section header.
 	test_config -C "$SERVER" protocol.version 2 &&
 
 	# Exercise to make sure it works.
 	git -c protocol.version=2 clone \
-		--filter=blob:none $HTTPD_URL/one_time_sed/server repo 2> err &&
+		--filter=blob:none $HTTPD_URL/one_time_perl/server repo 2> err &&
 	! grep "missing object referenced by" err &&
 
-	# Ensure that the one-time-sed script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
+	# Ensure that the one-time-perl script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
 '
 
 test_expect_success 'tolerate server sending REF_DELTA against missing promisor objects' '
@@ -502,7 +506,7 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 
 	# Clone. The client has deltabase_have but not deltabase_missing.
 	git -c protocol.version=2 clone --no-checkout \
-		--filter=blob:none $HTTPD_URL/one_time_sed/server repo &&
+		--filter=blob:none $HTTPD_URL/one_time_perl/server repo &&
 	git -C repo hash-object -w -- "$SERVER/have.txt" &&
 
 	# Sanity check to ensure that the client does not have
@@ -543,7 +547,7 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 
 	replace_packfile thin.pack &&
 
-	# Use protocol v2 because the sed command looks for the "packfile"
+	# Use protocol v2 because the perl command looks for the "packfile"
 	# section header.
 	test_config -C "$SERVER" protocol.version 2 &&
 
@@ -556,8 +560,8 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 	grep "want $(cat deltabase_missing)" trace &&
 	! grep "want $(cat deltabase_have)" trace &&
 
-	# Ensure that the one-time-sed script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
+	# Ensure that the one-time-perl script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7fd7102c874..5039e66dc47 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -712,11 +712,11 @@ test_expect_success 'when server sends "ready", expect DELIM' '
 
 	# After "ready" in the acknowledgments section, pretend that a FLUSH
 	# (0000) was sent instead of a DELIM (0001).
-	printf "/ready/,$ s/0001/0000/" \
-		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+	printf "\$ready = 1 if /ready/; \$ready && s/0001/0000/" \
+		>"$HTTPD_ROOT_PATH/one-time-perl" &&
 
 	test_must_fail git -C http_child -c protocol.version=2 \
-		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
+		fetch "$HTTPD_URL/one_time_perl/http_parent" 2> err &&
 	test_i18ngrep "expected packfile to be sent after .ready." err
 '
 
@@ -737,12 +737,12 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 
 	# After the acknowledgments section, pretend that a DELIM
 	# (0001) was sent instead of a FLUSH (0000).
-	printf "/acknowledgments/,$ s/0000/0001/" \
-		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+	printf "\$ack = 1 if /acknowledgments/; \$ack && s/0000/0001/" \
+		>"$HTTPD_ROOT_PATH/one-time-perl" &&
 
 	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
 		-c protocol.version=2 \
-		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
+		fetch "$HTTPD_URL/one_time_perl/http_parent" 2> err &&
 	grep "fetch< .*acknowledgments" log &&
 	! grep "fetch< .*ready" log &&
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 8aeeaac5091..7fba3063bf9 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -314,7 +314,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		test_commit m3 &&
 		git tag -d m2 m3
 	) &&
-	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
+	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_perl/repo" &&
 	git -C "$LOCAL_PRISTINE" config protocol.version 2
 '
 
@@ -327,7 +327,7 @@ inconsistency () {
 	# RPCs during a single negotiation.
 	oid1=$(git -C "$REPO" rev-parse $1) &&
 	oid2=$(git -C "$REPO" rev-parse $2) &&
-	echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-sed"
+	echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-perl"
 }
 
 test_expect_success 'server is initially ahead - no ref in want' '
@@ -379,7 +379,7 @@ test_expect_success 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
+	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
 	test_must_fail git -C local fetch 2>err &&
 
 	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
-- 
gitgitgadget

