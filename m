Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0419DF66
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485779; cv=none; b=u+CS/1UUtTjBW+qAFXuwNJPVcptwoIVMxtDXugga8ImFC3foTQEZmjbgOrX9hcoQfMnjgf1nErzI1vqDQU1F6Q5JAlDBrwyjFUgXqVy9GuRtHSQpDHqd8ym15K5h27nPK0qlwQsd684w4n6ubugrckk/Nhn9e5dY8Ebe+gqBenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485779; c=relaxed/simple;
	bh=9fHc4fP0nClmBO6aRuhVdGRjxIItcjY0SNct08k3MI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1EAow8ZDiubtDTj7ykZiOKeTBV7JHMpS0CV3KIOCkTOV/boLbnrxNrfEfE5E2FQ7A/s2cFeeGMwnApTE0pbjX5XvmBT6ra+vN6VGK0bW3zM2ZIvmfSo3sVfdxAEeKhnMZ1/wY5QALDaCMrmC5k8P9Uu2e8WYoDG2/iSAy21ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dJ/0lOrP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4uOkSV4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dJ/0lOrP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4uOkSV4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87F571140147;
	Wed,  9 Oct 2024 10:56:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 09 Oct 2024 10:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728485775;
	 x=1728572175; bh=jNzz5IGO12qS56QxVVggmltTjQc3if+dNNa5UbBSD4U=; b=
	dJ/0lOrPepPcuNmOTSI3556dDvoIQ8397SMLtoV7hkZ2/3JyobkUfSCIlAseeQoV
	fikiDvOCpzXnb2ybk+RVYKB3JCyaEfzOOxjr8ZXqwFKyiIfGkgP1XhjHNYp2fmOA
	GQXR2rtBIrTmr9Jhn1wM8pruYN0uxP3A3zmBHEwMMaOqKKaz20u+o73wwHXadAUd
	hJ3GPEh1LmMl0B3pi/JVX5/M9cp/UPgZYLOuoQ1Kv1SP+9rq8bSJpbSS6FqlTcgL
	sgVCPFpQp/QPl/ll8e+DxDXG1SaDkkd3roN7dCKOVLV8FWKTgHibYg24D6Ds3ECZ
	y8OYpLp/a1U3qOKqxDUWow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728485775; x=
	1728572175; bh=jNzz5IGO12qS56QxVVggmltTjQc3if+dNNa5UbBSD4U=; b=T
	4uOkSV4824eDoVohCzyTZ3Xqak3VIm4z63mZNEcQRwlfMtPYujt5OpPGNOhpFWKj
	d/54NVjfBNeYgnMrQoyJDgcfsT4mKMGS2DNbBJWOpAOU7iPFM1T1HRWBBZH3jvb2
	kVKL9ypIzM1r1qbof0oNqFr5HO4WmlS1rCT70X2OZqx9ZiscVlpVDLt0k9/kVCrQ
	6MqegUYh/hKpJBL+6yO/eyHWhkBIQbeXv8kxYyQiJkVmg14DXOZpae1Z38coFXc1
	Da8sZxlnmPkyL3884fz4A5aq6QFNANpp7xxmcuP1G9pSwUaCgAy9cdRUx5vzI9Lr
	t7sojvj5GKU5hxmkMZsug==
X-ME-Sender: <xms:j5kGZ8Li4yL9U1p8vhNawIhCodz--2WOAhSNdm_tJO3lE0tyVBpS-w>
    <xme:j5kGZ8L0jydrvmOg_iXqH-M72mU3xbFglfNEgt9NDWMK68UNWcR8bZEb_OtLkMepm
    Mtkk7laHRPWBDsMSQ>
X-ME-Received: <xmr:j5kGZ8vaaQR8eipjlclLygw2afFRyiJmz9fotgWGoLarTvHbbLfKpXSbCJIhiMBy5lHn7l4aedUJMnIwOaB5Jz2Lr3ic7frHi91sG4SNVX2oAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegiefhuefhkeetueeijeehheejveetveefvdfhleel
    hfeigeejtdfgtefhieeiteenucffohhmrghinhephhhtthhpqdhfvghttghhqdguuhhmsg
    drshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:j5kGZ5b2q_2Ro1Ch2fRXmMWAOLE8HHr6SPaucyqFNTqH5_ncylKLaw>
    <xmx:j5kGZzaGTiQRvtqvdveheJxKtUTzGCkCvgHoybTYqc8W_gJ-Ng6MJg>
    <xmx:j5kGZ1BFshAvG9wKyTTJtMDFWSG00tZYNYbLiDr5lqhcq9S5Zinrzw>
    <xmx:j5kGZ5b0iv5Whdm92jLL7ew4Rhui1q06HUpDpaU5ooHVn68f6SDVNw>
    <xmx:j5kGZ-yDqwAPPCVAoADgeWB_BYjVOrBPka_endYCNDOuKtYvordtuXi5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6e45c1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:10 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 02/24] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <5ec91ac12dab4d89c636c03b4515584d0e544dfa.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1728485139.git.ps@pks.im>

The iconv library is used by Git to reencode files, commit messages and
other things. As such it is a rather integral part, but given that many
platforms nowadays use UTF-8 everywhere you can live without support for
reencoding in many situations. It is thus optional to build Git with
iconv, and some of our platforms wired up in "config.mak.uname" disable
it. But while we support building without it, running our test suite
with "NO_ICONV=Yes" causes many test failures.

Wire up a new test prerequisite ICONV that gets populated via our
GIT-BUILD-OPTIONS. Annotate failing tests accordingly.

Note that this commit does not do a deep dive into every single test to
assess whether the failure is expected or not. Most of the tests do
smell like the expected kind of failure though.

Further note that there are several "!MINGW" conditions in t4201, and
all of these fail due to iconv-related errors. This is quite likely a
leftover from times before dce7d29551 (msvc: support building Git using
MS Visual C++, 2019-06-25), which switched Windows-based builds over
from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
adapt those tests to also use the new ICONV prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                                     |   1 +
 contrib/buildsystems/CMakeLists.txt          |   6 ++
 t/t0028-working-tree-encoding.sh             |   6 ++
 t/t2082-parallel-checkout-attributes.sh      |   2 +-
 t/t3434-rebase-i18n.sh                       |   6 ++
 t/t3900-i18n-commit.sh                       |   6 ++
 t/t3901-i18n-patch.sh                        |   6 ++
 t/t4041-diff-submodule-option.sh             |  16 ++-
 t/t4059-diff-submodule-not-initialized.sh    |  16 ++-
 t/t4060-diff-submodule-option-diff-format.sh |  17 ++--
 t/t4201-shortlog.sh                          |   8 +-
 t/t4205-log-pretty-formats.sh                | 102 +++++++++++--------
 t/t4210-log-i18n.sh                          |   6 ++
 t/t4254-am-corrupt.sh                        |   6 ++
 t/t5100-mailinfo.sh                          |  14 ++-
 t/t5550-http-fetch-dumb.sh                   |   4 +-
 t/t6006-rev-list-format.sh                   |  54 ++++++----
 t/t7102-reset.sh                             |  40 +++++---
 t/t8005-blame-i18n.sh                        |   6 ++
 t/t9300-fast-import.sh                       |   2 +-
 t/t9350-fast-export.sh                       |  10 +-
 t/test-lib.sh                                |   1 +
 22 files changed, 229 insertions(+), 106 deletions(-)

diff --git a/Makefile b/Makefile
index 2dde1fd2b8b..c094840426c 100644
--- a/Makefile
+++ b/Makefile
@@ -3172,6 +3172,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@+
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
+	@echo NO_ICONV=\''$(subst ','\'',$(subst ','\'',$(NO_ICONV)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 62af7b33d2f..1384c0eb6d3 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1109,6 +1109,7 @@ set(DIFF diff)
 set(PYTHON_PATH /usr/bin/python)
 set(TAR tar)
 set(NO_CURL )
+set(NO_ICONV )
 set(NO_EXPAT )
 set(USE_LIBPCRE2 )
 set(NO_PERL )
@@ -1122,6 +1123,10 @@ if(NOT CURL_FOUND)
 	set(NO_CURL 1)
 endif()
 
+if(NOT Iconv_FOUND)
+	SET(NO_ICONV 1)
+endif()
+
 if(NOT EXPAT_FOUND)
 	set(NO_EXPAT 1)
 endif()
@@ -1145,6 +1150,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DIFF='${DIFF}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_ICONV='${NO_ICONV}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index ad151a34670..510da4ca12d 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -12,6 +12,12 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 
 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping working tree encoding tests; iconv not available'
+	test_done
+fi
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index aec55496eb1..a040aa54cee 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -34,7 +34,7 @@ test_expect_success 'parallel-checkout with ident' '
 	)
 '
 
-test_expect_success 'parallel-checkout with re-encoding' '
+test_expect_success ICONV 'parallel-checkout with re-encoding' '
 	set_checkout_config 2 0 &&
 	git init encoding &&
 	(
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 26a48d6b103..97fc9a23f21 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -20,6 +20,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping rebase i18n tests; iconv not available'
+	test_done
+fi
+
 compare_msg () {
 	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3434/$1" >expect &&
 	git cat-file commit HEAD >raw &&
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index db7b403bc15..9d4b5ab1f95 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -8,6 +8,12 @@ test_description='commit and log output encodings'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping commit i18n tests; iconv not available'
+	test_done
+fi
+
 compare_with () {
 	git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
 	case "$3" in
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 5f0b9afc3fa..e0659c92935 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -11,6 +11,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping patch i18n tests; iconv not available'
+	test_done
+fi
+
 check_encoding () {
 	# Make sure characters are not corrupted
 	cnt="$1" header="$2" i=1 j=0
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 8fc40e75eb3..aa149e0085e 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -15,12 +15,18 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# Tested non-UTF-8 encoding
-test_encoding="ISO8859-1"
+# Test non-UTF-8 encoding in case iconv is available.
+if test_have_prereq ICONV
+then
+	test_encoding="ISO8859-1"
+	# String "added" in German (translated with Google Translate), encoded in UTF-8,
+	# used in sample commit log messages in add_file() function below.
+	added=$(printf "hinzugef\303\274gt")
+else
+	test_encoding="UTF-8"
+	added="added"
+fi
 
-# String "added" in German (translated with Google Translate), encoded in UTF-8,
-# used in sample commit log messages in add_file() function below.
-added=$(printf "hinzugef\303\274gt")
 add_file () {
 	(
 		cd "$1" &&
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index 668f5263038..28fd3cdb154 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -12,12 +12,18 @@ initialized previously but the checkout has since been removed.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# Tested non-UTF-8 encoding
-test_encoding="ISO8859-1"
 
-# String "added" in German (translated with Google Translate), encoded in UTF-8,
-# used in sample commit log messages in add_file() function below.
-added=$(printf "hinzugef\303\274gt")
+# Test non-UTF-8 encoding in case iconv is available.
+if test_have_prereq ICONV
+then
+	test_encoding="ISO8859-1"
+	# String "added" in German (translated with Google Translate), encoded in UTF-8,
+	# used in sample commit log messages in add_file() function below.
+	added=$(printf "hinzugef\303\274gt")
+else
+	test_encoding="UTF-8"
+	added="added"
+fi
 
 add_file () {
 	(
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 8ce67442d96..918334fa4c8 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -13,12 +13,17 @@ This test tries to verify the sanity of --submodule=diff option of git diff.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# Tested non-UTF-8 encoding
-test_encoding="ISO8859-1"
-
-# String "added" in German (translated with Google Translate), encoded in UTF-8,
-# used in sample commit log messages in add_file() function below.
-added=$(printf "hinzugef\303\274gt")
+# Test non-UTF-8 encoding in case iconv is available.
+if test_have_prereq ICONV
+then
+	test_encoding="ISO8859-1"
+	# String "added" in German (translated with Google Translate), encoded in UTF-8,
+	# used in sample commit log messages in add_file() function below.
+	added=$(printf "hinzugef\303\274gt")
+else
+	test_encoding="UTF-8"
+	added="added"
+fi
 
 add_file () {
 	(
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index c20c8857244..680e707ba1e 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -105,7 +105,7 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 	test_cmp expect log.predictable
 '
 
-test_expect_success !MINGW 'shortlog wrapping' '
+test_expect_success ICONV 'shortlog wrapping' '
 	cat >expect <<\EOF &&
 A U Thor (5):
       Test
@@ -126,13 +126,13 @@ EOF
 	test_cmp expect out
 '
 
-test_expect_success !MINGW 'shortlog from non-git directory' '
+test_expect_success ICONV 'shortlog from non-git directory' '
 	git log --no-expand-tabs HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
 '
 
-test_expect_success !MINGW 'shortlog can read --format=raw output' '
+test_expect_success ICONV 'shortlog can read --format=raw output' '
 	git log --format=raw HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
@@ -182,7 +182,7 @@ $DSCHO (2):
 
 EOF
 
-test_expect_success !MINGW 'shortlog encoding' '
+test_expect_success ICONV 'shortlog encoding' '
 	git reset --hard "$commit" &&
 	git config --unset i18n.commitencoding &&
 	echo 2 > a1 &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index eb63ce011fa..dbbd6125510 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -114,19 +114,19 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=test-foo
 '
 
-test_expect_success 'NUL separation' '
+test_expect_success ICONV 'NUL separation' '
 	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty="format:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'NUL termination' '
+test_expect_success ICONV 'NUL termination' '
 	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'NUL separation with --stat' '
+test_expect_success ICONV 'NUL separation with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
@@ -181,7 +181,7 @@ test_expect_success 'setup more commits' '
 	head4=$(git rev-parse --verify --short HEAD~3)
 '
 
-test_expect_success 'left alignment formatting' '
+test_expect_success ICONV 'left alignment formatting' '
 	git log --pretty="tformat:%<(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	message two                            Z
@@ -192,7 +192,7 @@ test_expect_success 'left alignment formatting' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left alignment formatting. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(40)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	message two                            Z
@@ -203,7 +203,7 @@ test_expect_success 'left alignment formatting. i18n.logOutputEncoding' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting at the nth column' '
+test_expect_success ICONV 'left alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1 message two                    Z
@@ -214,7 +214,7 @@ test_expect_success 'left alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting at the nth column' '
+test_expect_success ICONV 'left alignment formatting at the nth column' '
 	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1 message two                    Z
@@ -225,7 +225,7 @@ test_expect_success 'left alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting at the nth column. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	$head1 message two                    Z
@@ -236,7 +236,7 @@ test_expect_success 'left alignment formatting at the nth column. i18n.logOutput
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with no padding' '
+test_expect_success ICONV 'left alignment formatting with no padding' '
 	git log --pretty="tformat:%<(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	message two
@@ -258,7 +258,7 @@ test_expect_success 'left alignment formatting with no padding. i18n.logOutputEn
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with trunc' '
+test_expect_success ICONV 'left alignment formatting with trunc' '
 	git log --pretty="tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF >expected &&
 	message ..
@@ -269,7 +269,7 @@ test_expect_success 'left alignment formatting with trunc' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left alignment formatting with trunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	message ..
@@ -280,7 +280,7 @@ test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncodin
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with ltrunc' '
+test_expect_success ICONV 'left alignment formatting with ltrunc' '
 	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	..sage two
@@ -291,7 +291,7 @@ test_expect_success 'left alignment formatting with ltrunc' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	..sage two
@@ -302,7 +302,7 @@ test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncodi
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with mtrunc' '
+test_expect_success ICONV 'left alignment formatting with mtrunc' '
 	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF >expected &&
 	mess.. two
@@ -313,7 +313,7 @@ test_expect_success 'left alignment formatting with mtrunc' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	mess.. two
@@ -324,7 +324,7 @@ test_expect_success 'left alignment formatting with mtrunc. i18n.logOutputEncodi
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting' '
+test_expect_success ICONV 'right alignment formatting' '
 	git log --pretty="tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	Z                            message two
@@ -335,7 +335,7 @@ test_expect_success 'right alignment formatting' '
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting. i18n.logOutputEncoding' '
+test_expect_success ICONV 'right alignment formatting. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	Z                            message two
@@ -346,7 +346,7 @@ test_expect_success 'right alignment formatting. i18n.logOutputEncoding' '
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting at the nth column' '
+test_expect_success ICONV 'right alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1                      message two
@@ -357,7 +357,7 @@ test_expect_success 'right alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting at the nth column' '
+test_expect_success ICONV 'right alignment formatting at the nth column' '
 	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1                      message two
@@ -368,7 +368,7 @@ test_expect_success 'right alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
+test_expect_success ICONV 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	$head1                      message two
@@ -381,7 +381,7 @@ test_expect_success 'right alignment formatting at the nth column. i18n.logOutpu
 
 # Note: Space between 'message' and 'two' should be in the same column
 # as in previous test.
-test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
+test_expect_success ICONV 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
 	iconv -f utf-8 -t $test_encoding >expected <<-EOF &&
 	* $head1                    message two
@@ -392,7 +392,7 @@ test_expect_success 'right alignment formatting at the nth column with --graph.
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting with no padding' '
+test_expect_success ICONV 'right alignment formatting with no padding' '
 	git log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	message two
@@ -403,7 +403,7 @@ test_expect_success 'right alignment formatting with no padding' '
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting with no padding and with --graph' '
+test_expect_success ICONV 'right alignment formatting with no padding and with --graph' '
 	git log --graph --pretty="tformat:%>(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	* message two
@@ -414,7 +414,7 @@ test_expect_success 'right alignment formatting with no padding and with --graph
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting with no padding. i18n.logOutputEncoding' '
+test_expect_success ICONV 'right alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	message two
@@ -425,7 +425,7 @@ test_expect_success 'right alignment formatting with no padding. i18n.logOutputE
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting' '
+test_expect_success ICONV 'center alignment formatting' '
 	git log --pretty="tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	Z             message two              Z
@@ -436,7 +436,7 @@ test_expect_success 'center alignment formatting' '
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting. i18n.logOutputEncoding' '
+test_expect_success ICONV 'center alignment formatting. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	Z             message two              Z
@@ -446,7 +446,7 @@ test_expect_success 'center alignment formatting. i18n.logOutputEncoding' '
 	EOF
 	test_cmp expected actual
 '
-test_expect_success 'center alignment formatting at the nth column' '
+test_expect_success ICONV 'center alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1           message two          Z
@@ -457,7 +457,7 @@ test_expect_success 'center alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting at the nth column' '
+test_expect_success ICONV 'center alignment formatting at the nth column' '
 	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1           message two          Z
@@ -468,7 +468,7 @@ test_expect_success 'center alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting at the nth column. i18n.logOutputEncoding' '
+test_expect_success ICONV 'center alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	$head1           message two          Z
@@ -479,7 +479,7 @@ test_expect_success 'center alignment formatting at the nth column. i18n.logOutp
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting with no padding' '
+test_expect_success ICONV 'center alignment formatting with no padding' '
 	git log --pretty="tformat:%><(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	message two
@@ -493,7 +493,7 @@ test_expect_success 'center alignment formatting with no padding' '
 # save HEAD's SHA-1 digest (with no abbreviations) to use it below
 # as far as the next test amends HEAD
 old_head1=$(git rev-parse --verify HEAD~0)
-test_expect_success 'center alignment formatting with no padding. i18n.logOutputEncoding' '
+test_expect_success ICONV 'center alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(1)%s" >actual &&
 	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	message two
@@ -504,7 +504,7 @@ test_expect_success 'center alignment formatting with no padding. i18n.logOutput
 	test_cmp expected actual
 '
 
-test_expect_success 'left/right alignment formatting with stealing' '
+test_expect_success ICONV 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
 	git log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<-\EOF >expected &&
@@ -515,7 +515,7 @@ test_expect_success 'left/right alignment formatting with stealing' '
 	EOF
 	test_cmp expected actual
 '
-test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	short long  long long
@@ -564,22 +564,38 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git tag -d tag1 &&
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
-	cat <<-EOF >expected &&
-	$head2  (tag: refs/tags/message-one)
-	$old_head1  (tag: refs/tags/message-two)
-	$head1  (tag: refs/tags/tag2)
-	EOF
+	if test_have_prereq ICONV
+	then
+		cat <<-EOF >expected
+		$head2  (tag: refs/tags/message-one)
+		$old_head1  (tag: refs/tags/message-two)
+		$head1  (tag: refs/tags/tag2)
+		EOF
+	else
+		cat <<-EOF >expected
+		$head2  (tag: refs/tags/message-one)
+		$old_head1  (tag: refs/tags/tag2, tag: refs/tags/message-two)
+		EOF
+	fi &&
 	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 
 test_expect_success 'clean log decoration' '
 	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
-	cat >expected <<-EOF &&
-	$head2 tag: refs/tags/message-one
-	$old_head1 tag: refs/tags/message-two
-	$head1 tag: refs/tags/tag2
-	EOF
+	if test_have_prereq ICONV
+	then
+		cat <<-EOF >expected
+		$head2 tag: refs/tags/message-one
+		$old_head1 tag: refs/tags/message-two
+		$head1 tag: refs/tags/tag2
+		EOF
+	else
+		cat <<-EOF >expected
+		$head2 tag: refs/tags/message-one
+		$old_head1 tag: refs/tags/tag2, tag: refs/tags/message-two
+		EOF
+	fi &&
 	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 7120030b5c6..4a12b2b4979 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -5,6 +5,12 @@ test_description='test log with i18n features'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping log i18n tests; iconv not available'
+	test_done
+fi
+
 # two forms of é
 utf8_e=$(printf '\303\251')
 latin1_e=$(printf '\351')
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 661feb60709..cb03522d021 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -5,6 +5,12 @@ test_description='git am with corrupt input'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping am encoding corruption tests; iconv not available'
+	test_done
+fi
+
 make_mbox_with_nul () {
 	space=' '
 	q_nul_in_subject=
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 065156c1f39..23b2f218725 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -28,7 +28,12 @@ check_mailinfo () {
 
 for mail in 00*
 do
-	test_expect_success "mailinfo $mail" '
+	case "$mail" in
+	0004)
+		prereq=ICONV;;
+	esac
+
+	test_expect_success $prereq "mailinfo $mail" '
 		check_mailinfo "$mail" "" &&
 		if test -f "$DATA/msg$mail--scissors"
 		then
@@ -56,7 +61,12 @@ test_expect_success 'split box with rfc2047 samples' \
 
 for mail in rfc2047/00*
 do
-	test_expect_success "mailinfo $mail" '
+	case "$mail" in
+	rfc2047/0001)
+		prereq=ICONV;;
+	esac
+
+	test_expect_success $prereq "mailinfo $mail" '
 		git mailinfo -u "$mail-msg" "$mail-patch" <"$mail" >"$mail-info" &&
 		echo msg &&
 		test_cmp "$DATA/empty" "$mail-msg" &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 58189c9f7dc..3c873de17ec 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -344,12 +344,12 @@ test_expect_success 'git client shows text/plain with a charset' '
 	grep "this is the error message" stderr
 '
 
-test_expect_success 'http error messages are reencoded' '
+test_expect_success ICONV 'http error messages are reencoded' '
 	test_must_fail git clone "$HTTPD_URL/error/utf16" 2>stderr &&
 	grep "this is the error message" stderr
 '
 
-test_expect_success 'reencoding is robust to whitespace oddities' '
+test_expect_success ICONV 'reencoding is robust to whitespace oddities' '
 	test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
 	grep "this is the error message" stderr
 '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f1623b1c06d..2a01a62a2f3 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -13,21 +13,41 @@ TEST_PASSES_SANITIZE_LEAK=true
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_tick
-# Tested non-UTF-8 encoding
-test_encoding="ISO8859-1"
-
-# String "added" in German
-# (translated with Google Translate),
-# encoded in UTF-8, used as a commit log message below.
-added_utf8_part=$(printf "\303\274")
-added_utf8_part_iso88591=$(echo "$added_utf8_part" | iconv -f utf-8 -t $test_encoding)
-added=$(printf "added (hinzugef${added_utf8_part}gt) foo")
-added_iso88591=$(echo "$added" | iconv -f utf-8 -t $test_encoding)
-# same but "changed"
-changed_utf8_part=$(printf "\303\244")
-changed_utf8_part_iso88591=$(echo "$changed_utf8_part" | iconv -f utf-8 -t $test_encoding)
-changed=$(printf "changed (ge${changed_utf8_part}ndert) foo")
-changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t $test_encoding)
+
+if test_have_prereq ICONV
+then
+	# Tested non-UTF-8 encoding
+	test_encoding="ISO8859-1"
+
+	# String "added" in German
+	# (translated with Google Translate),
+	# encoded in UTF-8, used as a commit log message below.
+	added_utf8_part=$(printf "\303\274")
+	added_utf8_part_iso88591=$(echo "$added_utf8_part" | iconv -f utf-8 -t $test_encoding)
+	added=$(printf "added (hinzugef${added_utf8_part}gt) foo")
+	added_iso88591=$(echo "$added" | iconv -f utf-8 -t $test_encoding)
+	# same but "changed"
+	changed_utf8_part=$(printf "\303\244")
+	changed_utf8_part_iso88591=$(echo "$changed_utf8_part" | iconv -f utf-8 -t $test_encoding)
+	changed=$(printf "changed (ge${changed_utf8_part}ndert) foo")
+	changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t $test_encoding)
+else
+	# Tested non-UTF-8 encoding
+	test_encoding="UTF-8"
+
+	# String "added" in German
+	# (translated with Google Translate),
+	# encoded in UTF-8, used as a commit log message below.
+	added_utf8_part="u"
+	added_utf8_part_iso88591="u"
+	added=$(printf "added (hinzugef${added_utf8_part}gt) foo")
+	added_iso88591="$added"
+	# same but "changed"
+	changed_utf8_part="a"
+	changed_utf8_part_iso88591="a"
+	changed=$(printf "changed (ge${changed_utf8_part}ndert) foo")
+	changed_iso88591="$changed"
+fi
 
 # Count of char to truncate
 # Number is chosen so, that non-ACSII characters
@@ -198,7 +218,7 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
 
-test_format encoding %e <<EOF
+test_format ICONV encoding %e <<EOF
 commit $head2
 $test_encoding
 commit $head1
@@ -374,7 +394,7 @@ test_expect_success 'setup complex body' '
 	head3_short=$(git rev-parse --short $head3)
 '
 
-test_format complex-encoding %e <<EOF
+test_format ICONV complex-encoding %e <<EOF
 commit $head3
 $test_encoding
 commit $head2
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 2add26d7684..e9a6cc72658 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -13,21 +13,31 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-commit_msg () {
-	# String "modify 2nd file (changed)" partly in German
-	# (translated with Google Translate),
-	# encoded in UTF-8, used as a commit log message below.
-	msg="modify 2nd file (ge\303\244ndert)\n"
-	if test -n "$1"
-	then
-		printf "$msg" | iconv -f utf-8 -t "$1"
-	else
-		printf "$msg"
-	fi
-}
-
-# Tested non-UTF-8 encoding
-test_encoding="ISO8859-1"
+if test_have_prereq ICONV
+then
+	commit_msg () {
+		# String "modify 2nd file (changed)" partly in German
+		# (translated with Google Translate),
+		# encoded in UTF-8, used as a commit log message below.
+		msg="modify 2nd file (ge\303\244ndert)\n"
+		if test -n "$1"
+		then
+			printf "$msg" | iconv -f utf-8 -t "$1"
+		else
+			printf "$msg"
+		fi
+	}
+
+	# Tested non-UTF-8 encoding
+	test_encoding="ISO8859-1"
+else
+	commit_msg () {
+		echo "modify 2nd file (geandert)"
+	}
+
+	# Tested non-UTF-8 encoding
+	test_encoding="UTF-8"
+fi
 
 test_expect_success 'creating initial files and commits' '
 	test_tick &&
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 75da219ed1b..7a1f581c240 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -3,6 +3,12 @@
 test_description='git blame encoding conversion'
 . ./test-lib.sh
 
+if ! test_have_prereq ICONV
+then
+	skip_all='skipping blame i18n tests; iconv not available'
+	test_done
+fi
+
 . "$TEST_DIRECTORY"/t8005/utf8.txt
 . "$TEST_DIRECTORY"/t8005/euc-japan.txt
 . "$TEST_DIRECTORY"/t8005/sjis.txt
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3b3c371740a..6224f54d4d2 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3676,7 +3676,7 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
 ### series X (other new features)
 ###
 
-test_expect_success 'X: handling encoding' '
+test_expect_success ICONV 'X: handling encoding' '
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	commit refs/heads/encoding
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1eb035ee4ce..aa33791b77b 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -124,7 +124,7 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
-test_expect_success 'reencoding iso-8859-7' '
+test_expect_success ICONV 'reencoding iso-8859-7' '
 
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_config i18n.commitencoding iso-8859-7 &&
@@ -420,7 +420,7 @@ M 100644 :1 there
 
 EOF
 
-test_expect_success 'dropping tag of filtered out object' '
+test_expect_success ICONV 'dropping tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
@@ -437,7 +437,7 @@ msg
 
 EOF
 
-test_expect_success 'rewriting tag of filtered out object' '
+test_expect_success ICONV 'rewriting tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
@@ -666,7 +666,7 @@ M 100644 :13 file
 
 EOF
 
-test_expect_success 'avoid uninteresting refs' '
+test_expect_success ICONV 'avoid uninteresting refs' '
 	> tmp-marks &&
 	git fast-export --import-marks=tmp-marks \
 		--export-marks=tmp-marks main > /dev/null &&
@@ -685,7 +685,7 @@ from :14
 
 EOF
 
-test_expect_success 'refs are updated even if no commits need to be exported' '
+test_expect_success ICONV 'refs are updated even if no commits need to be exported' '
 	> tmp-marks &&
 	git fast-export --import-marks=tmp-marks \
 		--export-marks=tmp-marks main > /dev/null &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 241198ba95f..a278181a056 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1743,6 +1743,7 @@ esac
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_CURL" && test_set_prereq LIBCURL
+test -z "$NO_ICONV" && test_set_prereq ICONV
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

