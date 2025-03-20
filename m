Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455E224B1A
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463350; cv=none; b=eixxOX9qofVg1SOQgNcXEtOiZ+oM6VizXJ0aYOWXdgRooQAOAUtGOUUHZK1ehAFQGjw++p8TRosJGOfNnKc93gQb/+nHhFNyRefX/aQ7md5/b6ggsuIuJ+a0xDsBypX/UKajum89wAd3c4tinzpxSrVqyMxxSNqBqhxM/Jiak2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463350; c=relaxed/simple;
	bh=yZMa/B2KmNIylJyVX2fUoiFB3ucISyq0M7KGv2bt2Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1CgOyj1LdH+XLsFKTK8Y3xdCComCwMMo4MSeqJgTszx6WH/VgMICfXVTCGzRGqxVf5OS90E7WILB6GZG02X2S3/ZHqLZdSafBvpJqVPGjK/PS1RCTt6E3YrP9Q/hEcYlYjHh3jnfjrzVha+IhH0UiVdLmxzoCKKPPsi7SyOvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kOnzai66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tp/Qe09p; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kOnzai66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tp/Qe09p"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CC542540164;
	Thu, 20 Mar 2025 05:35:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 20 Mar 2025 05:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463347;
	 x=1742549747; bh=iHkT+Zi82h/UiW+XMCSELcFcfloM3kFdFubSvuZ/N48=; b=
	kOnzai66RlFVDcaJDKPVjFvNoFg5TIoP+/dUmTF1ybv04itIZiYgPWtjxNUoCSnq
	HLsVvzkuHeauzn5SIg/+9OgxF1t8NLPiOZQpt0sINPFOV4jD2lZ1lfIprug65D3O
	0GISxYdqwZYms7N9LfpH8L004SGgeTJHuLgcVeo9rubIhOkhdfPBcaBSWZKi/sNr
	aN/BYYZ2bru6yIHyJh5GqQ7L12CaMM0BW5FmPDCXR4QkS1GjbzJ7BRKSa3FYBSn7
	Jpn/Yrn+bcs98wQosTB+W1l2MVQBeb1lTl32Lh6Kq8pvMu/9FkJ7NTcZ/t9Bsujy
	dnN+I2EQh45gA1TEKKn9dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463347; x=
	1742549747; bh=iHkT+Zi82h/UiW+XMCSELcFcfloM3kFdFubSvuZ/N48=; b=t
	p/Qe09pYCVK33YmU7D2FmJJZ+VvEF80V1uRot+MEzJYVW5ZTXUvQtD7an3x6PHf2
	kn7AffMtZ7J9NOnKkzbn35oQxSDe6zhNrYzNS8AK+0hAE2wfLSiqMLItrsI/XjHa
	VFiSxDS6uzDS8GetgRXjDlThajxe+PkTG57oHo7oQUU99b9ZUpuMTS5rAX98AkSy
	yqeAMTH7V6GAJUvFGrzWuT220AHn3/WIsz9I0UY2Enk6tKQTnZbaD6O13s/RuECg
	bHUlY6cMhoIrH4gADC9Etmxgr/Qhnac7Uzu0M/dFdIIJmtiik/I/12EWCJKRsIXO
	gup1RgcZ1bttmxGWowAGQ==
X-ME-Sender: <xms:cuHbZwgw5pG9c_5ClV4VaU8x4EXQyQn115xpyIIE2RuknCmZQnr9NQ>
    <xme:cuHbZ5C_f228a-SIpwy6r1oQCoBDcD8n0ESG0nwq825kOz-tmQPLTKEJrIffGT1YO
    OlxauBz_rV62H52Kg>
X-ME-Received: <xmr:cuHbZ4FIoNUr9zIyNeild1Jwklf_VRRSHuIIsM2p43Td5_rQOEgaGy7LLR_n9TDbsLlCC6npsgkeMg-abkQnyPW755CPW0B6sqzCER_yHlgHSSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeigeeugfeuheefgefgteefiedvffehgfefheei
    heetfefgleeuteeihfelgefhfeenucffohhmrghinhephhhtthhpugdrshhhpdhhthhtph
    drshhhpdgrphhplhihqdhonhgvqdhtihhmvgdqphgvrhhlrdhshhdprghpphhlhidqohhn
    vgdqthhimhgvqdhstghrihhpthdrshhhpdhnphhhqdgtuhhsthhomhdqrghuthhhrdhshh
    dpuddvjedrtddrtddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c-HbZxQxMvCJaucMHXTHY1l-_deBj_eNUhSTr-3x4Qepo7YYhNIa-g>
    <xmx:c-HbZ9yhKjAWJea81TTHG0bHLQqedJMHi8xrqIOKEYAecDfOpDIs0w>
    <xmx:c-HbZ_4uSU93igUJ0Rz1S-RyV4VZyBWJoAKSOC4jDPO2xp3p4vQRFw>
    <xmx:c-HbZ6zHJouyNtCAAGus2f3H2NuPPgFReIsqOicAHaUMqpxE0cijsQ>
    <xmx:c-HbZ4-OnXU4RYakKgaY6UfeiQimolCh0kTKjX4NqsYMgAoOxeEeULDG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1bbbffd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:43 +0100
Subject: [PATCH 16/20] t/lib-httpd: refactor "one-time-perl" CGI script to
 not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-16-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

