Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A9267F7A
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908482; cv=none; b=nb8KRbAK6VTe4zuufZJSrpM7Jq3C+HQXLRqQj4wwRLS6iparlhOoZUoHp+A53EigDsaMA+kcNWZy7fItcPIM14Czi7lx6jSsZB4LzbAL1yENoTq9IiLqpL5JaxXoYNP7NqwnZCRvw8hKh2ho4hYm77zyuiRpoc0Ol/YZwbk7gTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908482; c=relaxed/simple;
	bh=yZMa/B2KmNIylJyVX2fUoiFB3ucISyq0M7KGv2bt2Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXClAGV8KEsOyoZYT2MjqS/L3UtpP8KbEdDE+6oYwugmN4zIN2PUXhPpCIIxjoop0CIV6taR00w/i4qGtEUNrer5r4d5Hfp1ch1NoMcLHmNk4XpIQviBcWEa72hyIwLG0swRTY1PNSfYNpk2qV+v3eS2cKQLjBTGZxkMEKSYbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fuSQPIGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWkdamwr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fuSQPIGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWkdamwr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 75213138383D;
	Tue, 25 Mar 2025 09:14:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Mar 2025 09:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908479;
	 x=1742994879; bh=iHkT+Zi82h/UiW+XMCSELcFcfloM3kFdFubSvuZ/N48=; b=
	fuSQPIGx++ReUXc3unm4Y4ukMNgTIMlHWSMCgyk/XrofmQUoWdgg0BDlz5r5Q6jF
	ZVMtAGHZFWXqnsRvqN6ciHx435XOWyfbuUI1Ty3riN1SD0uQUNWtMJAI3DqjD5MF
	iAMOxVXzVwGHDsKEtBF7CsQx1X46q2I0ex45E3+w9aTKg8JxneO3B56KtjpyhD7m
	gFvfXNdkEJSKObxDzpFDUZsOBPDXCoarg4c5++wlH03MIrpj2stLuv9nidU9+vV0
	LjI1Glzaqqy/sCE+CA+xQqFlJxp8TDbv8449zyjX7RGkMGC3jrFLSQUn0QQQEYC6
	34PJpmz5b1HRpxZTgifYbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908479; x=
	1742994879; bh=iHkT+Zi82h/UiW+XMCSELcFcfloM3kFdFubSvuZ/N48=; b=O
	WkdamwrF5GVxdYpGRSXEelS1pTgR1Wdzl+fAprp01zwLs43hfCGWAxLw8/tv8/bD
	C9+/Pt85nFjrDyhIhoxBtI4gEoQ4pLkPSjHgL8r0eCjGabkpcmJHtgxfgZ7uyFqM
	m9eUyig1VsBFFUuwm0ZwrnPvWTpJj46vPjXIqbYjwTfFogdNjK6LMMcYnfndCyrT
	gFCIy5sHoKvykYvcpP/7A313XkKC+HyHSum1ZU+3GSHJyuCBtXpG1mvHgWqKIaq8
	IsXdmVNQXjJP+wxQFN/fB3OutQWd1cfkfAfWAAwloDdWPcMoNBnEdq99kb9bKren
	OsGHuRJEIQ7qB/58n5/Bw==
X-ME-Sender: <xms:P6ziZwL8_WZXpicXgdAwyEMQSiI8HIIVkkmyRF-Q-c3fElHbety6qg>
    <xme:P6ziZwI1XGCOz2J1K1mVCnYaiUAifsdcZ_nwwCmA8z9vb6Er5i2BXMY3Uo3JfFlMt
    COXA-0LePXwa1hHTA>
X-ME-Received: <xmr:P6ziZwu2GnBOryHQ3LcFu9tmNFIugEfGqHcCblT_ypNsrt7yAmXghLgnoXKT2csHkhT15-2vU3gDjMu-SsXKVut_0lNiTF8rDAyedwGuhKrsHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeigeeugfeuheefgefgteefiedvffehgfefheei
    heetfefgleeuteeihfelgefhfeenucffohhmrghinhephhhtthhpugdrshhhpdhhthhtph
    drshhhpdgrphhplhihqdhonhgvqdhtihhmvgdqphgvrhhlrdhshhdprghpphhlhidqohhn
    vgdqthhimhgvqdhstghrihhpthdrshhhpdhnphhhqdgtuhhsthhomhdqrghuthhhrdhshh
    dpuddvjedrtddrtddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:P6ziZ9bQ9FsuiuTYGzkhu0ty992y83tzWyYbvDJZ0JImBj9aDP9KMg>
    <xmx:P6ziZ3bzaHCLXHrFBk7Rvq6eDpPsEzlIkFCifWZjwfiEQ3m8qbNO9w>
    <xmx:P6ziZ5BJGm2ijl3vwzy7imGmn4TzuhoH7OHCIG0y8d05wmXhm57r6g>
    <xmx:P6ziZ9ZDpjUF658u--yl7JIDRcwfbV3cisbcycz5IxEW9-kbCOeS_A>
    <xmx:P6ziZyxK8fv4jpLtod2b0RftUGLFlVg0qMzxNT4b9__yyU_cCMcyLvsG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40e5175c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:34 +0100
Subject: [PATCH v2 16/20] t/lib-httpd: refactor "one-time-perl" CGI script
 to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-16-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Our Apache HTTPD setup exposes an "one_time_perl" endpoint to access
repositories. If used, we execute the "apply-one-time-perl.sh" CGI
script that checks whether we have a "one-time-perl" script. If so, that
script gets executed so that it can munge what would be served. Once
done, the script gets removed so that it doesn't execute a second time.

As the name says, this functionality expects the user to pass a Perl
script. This isn't really necessary though: we can just as easily
implement the same thing with arbitrary scripts.

Refactor the code so that we instead expect an arbitrary script to
exist and rename the functionality to "one-time-script". Adapt callers
to use shell utilities instead of Perl so that we can drop the
PERL_TEST_HELPERS prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-httpd.sh                       |  2 +-
 t/lib-httpd/apache.conf              |  6 ++---
 t/lib-httpd/apply-one-time-perl.sh   | 27 --------------------
 t/lib-httpd/apply-one-time-script.sh | 26 +++++++++++++++++++
 t/t5537-fetch-shallow.sh             | 17 ++++++-------
 t/t5616-partial-clone.sh             | 48 +++++++++++++++++++-----------------
 t/t5702-protocol-v2.sh               | 27 +++++++++++---------
 t/t5703-upload-pack-ref-in-want.sh   | 10 +++++---
 8 files changed, 86 insertions(+), 77 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d83bafeab32..5091db949b7 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -165,7 +165,7 @@ prepare_httpd() {
 	install_script broken-smart-http.sh
 	install_script error-smart-http.sh
 	install_script error.sh
-	install_script apply-one-time-perl.sh
+	install_script apply-one-time-script.sh
 	install_script nph-custom-auth.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 022276a6b9a..e631ab0eb5e 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -135,7 +135,7 @@ SetEnv PERL_PATH ${PERL_PATH}
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
-<LocationMatch /one_time_perl/>
+<LocationMatch /one_time_script/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
@@ -159,7 +159,7 @@ ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
-ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
+ScriptAliasMatch /one_time_script/(.*) apply-one-time-script.sh/$1
 ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
@@ -182,7 +182,7 @@ ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
 <Files error.sh>
   Options ExecCGI
 </Files>
-<Files apply-one-time-perl.sh>
+<Files apply-one-time-script.sh>
 	Options ExecCGI
 </Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
diff --git a/t/lib-httpd/apply-one-time-perl.sh b/t/lib-httpd/apply-one-time-perl.sh
deleted file mode 100644
index d7f9fed6aee..00000000000
--- a/t/lib-httpd/apply-one-time-perl.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-
-# If "one-time-perl" exists in $HTTPD_ROOT_PATH, run perl on the HTTP response,
-# using the contents of "one-time-perl" as the perl command to be run. If the
-# response was modified as a result, delete "one-time-perl" so that subsequent
-# HTTP responses are no longer modified.
-#
-# This can be used to simulate the effects of the repository changing in
-# between HTTP request-response pairs.
-if test -f one-time-perl
-then
-	LC_ALL=C
-	export LC_ALL
-
-	"$GIT_EXEC_PATH/git-http-backend" >out
-	"$PERL_PATH" -pe "$(cat one-time-perl)" out >out_modified
-
-	if cmp -s out out_modified
-	then
-		cat out
-	else
-		cat out_modified
-		rm one-time-perl
-	fi
-else
-	"$GIT_EXEC_PATH/git-http-backend"
-fi
diff --git a/t/lib-httpd/apply-one-time-script.sh b/t/lib-httpd/apply-one-time-script.sh
new file mode 100644
index 00000000000..b1682944e28
--- /dev/null
+++ b/t/lib-httpd/apply-one-time-script.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+# If "one-time-script" exists in $HTTPD_ROOT_PATH, run the script on the HTTP
+# response. If the response was modified as a result, delete "one-time-script"
+# so that subsequent HTTP responses are no longer modified.
+#
+# This can be used to simulate the effects of the repository changing in
+# between HTTP request-response pairs.
+if test -f one-time-script
+then
+	LC_ALL=C
+	export LC_ALL
+
+	"$GIT_EXEC_PATH/git-http-backend" >out
+	./one-time-script out >out_modified
+
+	if cmp -s out out_modified
+	then
+		cat out
+	else
+		cat out_modified
+		rm one-time-script
+	fi
+else
+	"$GIT_EXEC_PATH/git-http-backend"
+fi
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 77d20d19110..9dfcfb46df0 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -256,7 +256,7 @@ start_httpd
 
 REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
 
-test_expect_success PERL_TEST_HELPERS 'shallow fetches check connectivity before writing shallow file' '
+test_expect_success 'shallow fetches check connectivity before writing shallow file' '
 	rm -rf "$REPO" client &&
 
 	git init "$REPO" &&
@@ -271,22 +271,21 @@ test_expect_success PERL_TEST_HELPERS 'shallow fetches check connectivity before
 	git -C "$REPO" config protocol.version 2 &&
 	git -C client config protocol.version 2 &&
 
-	git -C client fetch --depth=2 "$HTTPD_URL/one_time_perl/repo" main:a_branch &&
+	git -C client fetch --depth=2 "$HTTPD_URL/one_time_script/repo" main:a_branch &&
 
 	# Craft a situation in which the server sends back an unshallow request
 	# with an empty packfile. This is done by refetching with a shorter
 	# depth (to ensure that the packfile is empty), and overwriting the
 	# shallow line in the response with the unshallow line we want.
-	printf "$(test_oid perl)" \
-	       "$(git -C "$REPO" rev-parse HEAD)" \
-	       "$(git -C "$REPO" rev-parse HEAD^)" \
-	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
+	sed "$(printf "$(test_oid perl)" "$(git -C "$REPO" rev-parse HEAD)" "$(git -C "$REPO" rev-parse HEAD^)")" <"\$1"
+	EOF
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
-		fetch --depth=1 "$HTTPD_URL/one_time_perl/repo" \
+		fetch --depth=1 "$HTTPD_URL/one_time_script/repo" \
 		main:a_branch &&
 
-	# Ensure that the one-time-perl script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-perl" &&
+	# Ensure that the one-time-script script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-script" &&
 
 	# Ensure that the resulting repo is consistent, despite our failure to
 	# fetch.
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bc7e0fec8dc..f878592a377 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -737,21 +737,25 @@ intersperse () {
 	sed 's/\(..\)/'$1'\1/g'
 }
 
-# Create a one-time-perl command to replace the existing packfile with $1.
+# Create a one-time-script command to replace the existing packfile with $1.
 replace_packfile () {
-	# The protocol requires that the packfile be sent in sideband 1, hence
-	# the extra \x01 byte at the beginning.
-	cp $1 "$HTTPD_ROOT_PATH/one-time-pack" &&
-	echo 'if (/packfile/) {
-		print;
-		my $length = -s "one-time-pack";
-		printf "%04x\x01", $length + 5;
-		print `cat one-time-pack` . "0000";
-		last
-	}' >"$HTTPD_ROOT_PATH/one-time-perl"
+	cp "$1" one-time-pack &&
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF
+	if grep packfile "\$1" >/dev/null
+	then
+		sed '/packfile/q' <"\$1" &&
+		# The protocol requires that the packfile be sent in sideband
+		# 1, hence the extra \001 byte at the beginning.
+		printf "%04x\001" \$((\$(wc -c <"$PWD/one-time-pack") + 5)) &&
+		cat "$PWD/one-time-pack" &&
+		printf "0000"
+	else
+		cat "\$1"
+	fi
+	EOF
 }
 
-test_expect_success PERL_TEST_HELPERS 'upon cloning, check that all refs point to objects' '
+test_expect_success 'upon cloning, check that all refs point to objects' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	rm -rf "$SERVER" repo &&
 	test_create_repo "$SERVER" &&
@@ -776,15 +780,15 @@ test_expect_success PERL_TEST_HELPERS 'upon cloning, check that all refs point t
 	# section header.
 	test_config -C "$SERVER" protocol.version 2 &&
 	test_must_fail git -c protocol.version=2 clone \
-		--filter=blob:none $HTTPD_URL/one_time_perl/server repo 2>err &&
+		--filter=blob:none $HTTPD_URL/one_time_script/server repo 2>err &&
 
 	test_grep "did not send all necessary objects" err &&
 
-	# Ensure that the one-time-perl script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
+	# Ensure that the one-time-script script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-script"
 '
 
-test_expect_success PERL_TEST_HELPERS 'when partial cloning, tolerate server not sending target of tag' '
+test_expect_success 'when partial cloning, tolerate server not sending target of tag' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	rm -rf "$SERVER" repo &&
 	test_create_repo "$SERVER" &&
@@ -818,11 +822,11 @@ test_expect_success PERL_TEST_HELPERS 'when partial cloning, tolerate server not
 
 	# Exercise to make sure it works.
 	git -c protocol.version=2 clone \
-		--filter=blob:none $HTTPD_URL/one_time_perl/server repo 2> err &&
+		--filter=blob:none $HTTPD_URL/one_time_script/server repo 2> err &&
 	! grep "missing object referenced by" err &&
 
-	# Ensure that the one-time-perl script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
+	# Ensure that the one-time-script script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-script"
 '
 
 test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against missing promisor objects' '
@@ -845,7 +849,7 @@ test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against
 
 	# Clone. The client has deltabase_have but not deltabase_missing.
 	git -c protocol.version=2 clone --no-checkout \
-		--filter=blob:none $HTTPD_URL/one_time_perl/server repo &&
+		--filter=blob:none $HTTPD_URL/one_time_script/server repo &&
 	git -C repo hash-object -w -- "$SERVER/have.txt" &&
 
 	# Sanity check to ensure that the client does not have
@@ -899,8 +903,8 @@ test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against
 	grep "want $(cat deltabase_missing)" trace &&
 	! grep "want $(cat deltabase_have)" trace &&
 
-	# Ensure that the one-time-perl script was used.
-	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
+	# Ensure that the one-time-script script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-script"
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index ad5e772cd72..27434b1f07a 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1120,7 +1120,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	! grep "git< version 2" log
 '
 
-test_expect_success PERL_TEST_HELPERS 'when server sends "ready", expect DELIM' '
+test_expect_success 'when server sends "ready", expect DELIM' '
 	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
@@ -1132,15 +1132,16 @@ test_expect_success PERL_TEST_HELPERS 'when server sends "ready", expect DELIM'
 
 	# After "ready" in the acknowledgments section, pretend that a FLUSH
 	# (0000) was sent instead of a DELIM (0001).
-	printf "\$ready = 1 if /ready/; \$ready && s/0001/0000/" \
-		>"$HTTPD_ROOT_PATH/one-time-perl" &&
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	sed "/ready/{n;s/0001/0000/;}" <"$1"
+	EOF
 
 	test_must_fail git -C http_child -c protocol.version=2 \
-		fetch "$HTTPD_URL/one_time_perl/http_parent" 2> err &&
+		fetch "$HTTPD_URL/one_time_script/http_parent" 2> err &&
 	test_grep "expected packfile to be sent after .ready." err
 '
 
-test_expect_success PERL_TEST_HELPERS 'when server does not send "ready", expect FLUSH' '
+test_expect_success 'when server does not send "ready", expect FLUSH' '
 	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
@@ -1157,12 +1158,13 @@ test_expect_success PERL_TEST_HELPERS 'when server does not send "ready", expect
 
 	# After the acknowledgments section, pretend that a DELIM
 	# (0001) was sent instead of a FLUSH (0000).
-	printf "\$ack = 1 if /acknowledgments/; \$ack && s/0000/0001/" \
-		>"$HTTPD_ROOT_PATH/one-time-perl" &&
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	sed "/acknowledgments/,//{s/0000/0001/;}" <"$1"
+	EOF
 
 	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
 		-c protocol.version=2 \
-		fetch "$HTTPD_URL/one_time_perl/http_parent" 2> err &&
+		fetch "$HTTPD_URL/one_time_script/http_parent" 2> err &&
 	grep "fetch< .*acknowledgments" log &&
 	! grep "fetch< .*ready" log &&
 	test_grep "expected no other sections to be sent after no .ready." err
@@ -1446,14 +1448,15 @@ test_expect_success 'http:// --negotiate-only' '
 	grep "$COMMON" out
 '
 
-test_expect_success PERL_TEST_HELPERS 'http:// --negotiate-only without wait-for-done support' '
+test_expect_success 'http:// --negotiate-only without wait-for-done support' '
 	SERVER="server" &&
-	URI="$HTTPD_URL/one_time_perl/server" &&
+	URI="$HTTPD_URL/one_time_script/server" &&
 
 	setup_negotiate_only "$SERVER" "$URI" &&
 
-	echo "s/ wait-for-done/ xxxx-xxx-xxxx/" \
-		>"$HTTPD_ROOT_PATH/one-time-perl" &&
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	sed "s/ wait-for-done/ xxxx-xxx-xxxx/" <"$1"
+	EOF
 
 	test_must_fail git -c protocol.version=2 -C client fetch \
 		--no-tags \
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index f59d47aa6c6..ac7266126a0 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -468,7 +468,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		test_commit m3 &&
 		git tag -d m2 m3
 	) &&
-	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_perl/repo" &&
+	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_script/repo" &&
 	git -C "$LOCAL_PRISTINE" config protocol.version 2
 '
 
@@ -481,7 +481,9 @@ inconsistency () {
 	# RPCs during a single negotiation.
 	oid1=$(git -C "$REPO" rev-parse $1) &&
 	oid2=$(git -C "$REPO" rev-parse $2) &&
-	echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-perl"
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF
+	sed "s/$oid1/$oid2/" <"\$1"
+	EOF
 }
 
 test_expect_success 'server is initially ahead - no ref in want' '
@@ -533,7 +535,9 @@ test_expect_success 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	echo "s/main/rain/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	sed "s/main/rain/" <"$1"
+	EOF
 	test_must_fail git -C local fetch 2>err &&
 
 	test_grep "fatal: remote error: unknown ref refs/heads/rain" err

-- 
2.49.0.472.ge94155a9ec.dirty

