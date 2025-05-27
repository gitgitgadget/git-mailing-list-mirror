Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D126A0E0
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354583; cv=none; b=N5sxY9lKsBxV0ni67wS33otKGp7wUqfLwUIPJ9Lig2fRpXc1DN43vTo7DNEIA3AHZi9ZLxQ1qnN6Ui/AjPSTE1aD/OFaW51q/DXwdsKeda0D5WbHgmJ2Ek/Vmb6C50/8Go6/I7lQ/2lokl0/cbS75BJMWyGs7k4/55VYIS5y3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354583; c=relaxed/simple;
	bh=dzQl5bJ0bCZS2Rr6SRZyEWuTybpdaokQPgnKPZuog2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXvMrhdKD8i4ndLGwHLPhd66sCa0XHdj+9sl3vu1WAJkrB7VUdvtDBuaMrS4NtQUbR4h8Mgv/Wbya18sVQa7mnwlQXN6LADpl4worhV7OdOf1UX+7jjA5olIiSPYx7it+Ndt2F6mLi/SY9L6oYrOIalec3Ps/BuPLerrprrzLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OEhdoT1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W85cICIL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OEhdoT1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W85cICIL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2339F1383ABC;
	Tue, 27 May 2025 10:02:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354579;
	 x=1748440979; bh=+3FLMo9twZUJIAxF90gPJ8QJK49nv9+GgX4WUhvAum8=; b=
	OEhdoT1JEEZVDqAcTnMxiLkXQK/BStlOF/n47uGpMDeqhv12FFmg4Tz83epK+b/e
	qHeMNUDCsiMUP9nwRVOrmkRl4EqHzyG1/Wn6BfgUz4cMjH0g6Xr9jPEkFwH+yRe0
	I7Ypsuaknz+5vC+M12ZV24t4VOjqAqVCm/m5Uv4oDaRkTt0yjtJshvpzbFzo+l2Z
	eyw7GMu3n2A932sl7GlGgqxDaU7JIEuGuNuZwxYqLY9eDd5Fjze2XTBSFcRkd2Kp
	TMpDh6BeDJU7kuDEJSQYrA2ekquvfG+yA29+18uCBsAeos6rquPSpHLxIIoEhfK3
	f8L38R0ZSdFNJyZ2pQyZlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354579; x=
	1748440979; bh=+3FLMo9twZUJIAxF90gPJ8QJK49nv9+GgX4WUhvAum8=; b=W
	85cICILq9E285boq1YGvsQ+sYXnGD3Nue9L/GFwZLFL1NxET20+gHmXmwx8uujS4
	f7Sjk2MXhIsCcUSNBW8eFy8iBcmGs210sZQ67zATHM5NGXbvwYJ9O7zUYyjbqVwu
	YH3bysYakktX/E/Mws5s3R6g6qPQY/AoneZ810ZURZPyyORLxIJ/iSyqqlVrWA0o
	MPqgoF5nwbzb188Red0GSLoqTkYvPyrXtPS2+C6Dbifo/z6fO/AdEUqibL0ulN63
	7Le2IQJxWxeW0bpHy+Fi8Cs3ZdVQOr1S6VUzIjrug8fOTfJrF+5srwl676LAPKxy
	xaokT2F2AeWfiNJxxfcaA==
X-ME-Sender: <xms:EsY1aC_7HdQ3lDry2pS97E_kQeV9hoJ0lZnk3pHF7-nJl_TfX4R4qg>
    <xme:EsY1aCtJutnOCJ76IUPsk66OEEX6s-wohr0ZPiluKauqM0YIiUTSQa6TnbbzopFdk
    mSeEjJCO7Ha7bfZQg>
X-ME-Received: <xmr:EsY1aIAhEsfRFGKQmbnKHqQPxwNjlru07ENFFGy7seAUnQAV1DU7XBkYPfBexIWrjJkrm5sVqeBm6duD7isWxLeqCdBiQfghT2pVxsbQ_KbAMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfdvvddvteevkeef
    teegveffuedtkefhheehueejvdeivedvkeejieffieeghfeunecuffhomhgrihhnpegrug
    gupghfihhlvgdrfhhoohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EsY1aKevtDNs4FtY3q2BX8YatxCOO2JWcCZivBnZT3TqqfyolzxCpg>
    <xmx:EsY1aHOY9lWChd9YsoAcgG98RAaGyM8Eq6W2ZwtncC-j0JQ2Dchadg>
    <xmx:EsY1aEnX4OvYcAdxz9ZL3LC1Py9SGMOlHVNLBpKqwVXcpIKkeMCVNg>
    <xmx:EsY1aJvREKh-Vv6bl0WVTJNFhI572Kw5UPV_AKvfTGFfk9cOPJnhyw>
    <xmx:E8Y1aOBErIi9MS26DhxeaY4LucwvGBzfC1za9cKnq1brksoXtiGbS6_o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:02:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9ca2f3b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:02:49 +0200
Subject: [PATCH v2 1/6] t: fix cases where output breaks TAP format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pks-meson-tap-v2-1-ae360f77786e@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
In-Reply-To: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

The TAP format does not allow arbitrary output outside of a specific
test case. If a test suite wants to print any such diagnostic output,
then this output has to be prefixed with "#" to mark it accordingly.
A bunch of our tests generate output outside of `test_expect_*`
testcases anyway without such a mark, which breaks strict TAP parsers.

Upon further inspection, all of the output generated by such tests is
rather uninteresting. Refactor them so that we don't break the TAP
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0050-filesystem.sh                        |  5 -----
 t/t1007-hash-object.sh                       |  2 +-
 t/t3600-rm.sh                                |  5 -----
 t/t4000-diff-format.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             |  4 ++--
 t/t4060-diff-submodule-option-diff-format.sh |  2 +-
 t/t7401-submodule-summary.sh                 |  4 ++--
 t/t9500-gitweb-standalone-no-errors.sh       | 14 +++++++-------
 t/t9822-git-p4-path-encoding.sh              | 13 +++++++++----
 t/t9835-git-p4-metadata-encoding-python2.sh  |  4 ++--
 t/t9836-git-p4-metadata-encoding-python3.sh  |  4 ++--
 t/t9903-bash-prompt.sh                       |  4 ----
 12 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 5c9dc90d0b0..5f544d0f210 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -12,7 +12,6 @@ aumlcdiar=$(printf '\141\314\210')
 
 if test_have_prereq CASE_INSENSITIVE_FS
 then
-	say "will test on a case insensitive filesystem"
 	test_case=test_expect_failure
 else
 	test_case=test_expect_success
@@ -20,15 +19,11 @@ fi
 
 if test_have_prereq UTF8_NFD_TO_NFC
 then
-	say "will test on a unicode corrupting filesystem"
 	test_unicode=test_expect_failure
 else
 	test_unicode=test_expect_success
 fi
 
-test_have_prereq SYMLINKS ||
-	say "will test on a filesystem lacking symbolic links"
-
 if test_have_prereq CASE_INSENSITIVE_FS
 then
 test_expect_success "detection of case insensitive filesystem during repo init" '
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index b3cf53ff8c9..210cce56ec6 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -30,7 +30,7 @@ setup_repo() {
 
 test_repo=test
 push_repo() {
-	test_create_repo $test_repo
+	test_create_repo $test_repo >/dev/null
 	cd $test_repo
 
 	setup_repo
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 98259e2adaa..1f16e6b5228 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -17,11 +17,6 @@ test_expect_success 'Initialize test directory' '
 	git commit -m "add normal files"
 '
 
-if test_have_prereq !FUNNYNAMES
-then
-	say 'Your filesystem does not allow tabs in filenames.'
-fi
-
 test_expect_success FUNNYNAMES 'add files with funny names' '
 	touch -- "tab	embedded" "newline${LF}embedded" &&
 	git add -- "tab	embedded" "newline${LF}embedded" &&
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index a51f881b1c9..32b14e3a714 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -36,7 +36,7 @@ test_expect_success 'git diff-files -p after editing work tree.' '
 # that's as far as it comes
 if [ "$(git config --get core.filemode)" = false ]
 then
-	say 'filemode disabled on the filesystem'
+	skip_all='filemode disabled on the filesystem'
 	test_done
 fi
 
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 28f9d83d4c1..31f359ddf1e 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -48,7 +48,7 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
@@ -236,7 +236,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 '
 
 rm -f sm1 &&
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 head6=$(add_file sm1 foo6 foo7)
 fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'nonexistent commit' '
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 76b83101d3b..17ef40c0c9f 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -364,7 +364,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 '
 
 rm -f sm1 &&
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=diff HEAD >actual &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9c3cc4cf404..80bbb1b7b5b 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -38,7 +38,7 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
@@ -215,7 +215,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 "
 
 rm -f sm1 &&
-test_create_repo sm1 &&
+test_create_repo sm1 >/dev/null &&
 head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' "
 	git submodule summary >actual &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 7679780fb87..84196a10896 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -701,13 +701,13 @@ test_expect_success \
 # syntax highlighting
 
 
-highlight_version=$(highlight --version </dev/null 2>/dev/null)
-if [ $? -eq 127 ]; then
-	say "Skipping syntax highlighting tests: 'highlight' not found"
-elif test -z "$highlight_version"; then
-	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
-else
-	test_set_prereq HIGHLIGHT
+test_lazy_prereq HIGHLIGHT '
+	highlight_version=$(highlight --version </dev/null 2>/dev/null) &&
+	test -n "$highlight_version"
+'
+
+if test_have_prereq HIGHLIGHT
+then
 	cat >>gitweb_config.perl <<-\EOF
 	our $highlight_bin = "highlight";
 	$feature{'highlight'}{'override'} = 1;
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index 572d395498e..ddb2052ea7b 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -7,12 +7,17 @@ test_description='Clone repositories with non ASCII paths'
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
 ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
 
-ISO8859="$(printf "$ISO8859_ESCAPED")" &&
-echo content123 >"$ISO8859" &&
-rm "$ISO8859" || {
+test_lazy_prereq FS_ACCEPTS_ISO_8859_1 '
+	ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+	echo content123 >"$ISO8859" 2>/dev/null &&
+	rm "$ISO8859"
+'
+
+if ! test_have_prereq FS_ACCEPTS_ISO_8859_1
+then
 	skip_all="fs does not accept ISO-8859-1 filenames"
 	test_done
-}
+fi
 
 test_expect_success 'start p4d' '
 	start_p4d
diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index 6116f806f63..83eca4fa658 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -15,7 +15,7 @@ failing, and produces maximally sane output in git.'
 # These tests are specific to Python 2. Write a custom script that executes
 # git-p4 directly with the Python 2 interpreter to ensure that we use that
 # version even if Git was compiled with Python 3.
-python_target_binary=$(which python2)
+python_target_binary=$(which python2 2>/dev/null)
 if test -n "$python_target_binary"
 then
 	mkdir temp_python
@@ -28,7 +28,7 @@ then
 fi
 
 git p4-python2 >err
-if ! grep 'valid commands' err
+if ! grep -q 'valid commands' err
 then
 	skip_all="skipping python2 git p4 tests; python2 not available"
 	test_done
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
index 5e5217a66b4..da25edeb546 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -15,7 +15,7 @@ failing, and produces maximally sane output in git.'
 # These tests are specific to Python 3. Write a custom script that executes
 # git-p4 directly with the Python 3 interpreter to ensure that we use that
 # version even if Git was compiled with Python 2.
-python_target_binary=$(which python3)
+python_target_binary=$(which python3 2>/dev/null)
 if test -n "$python_target_binary"
 then
 	mkdir temp_python
@@ -28,7 +28,7 @@ then
 fi
 
 git p4-python3 >err
-if ! grep 'valid commands' err
+if ! grep -q 'valid commands' err
 then
 	skip_all="skipping python3 git p4 tests; python3 not available"
 	test_done
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654e..637a6f13a6d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -66,10 +66,6 @@ test_expect_success 'prompt - unborn branch' '
 	test_cmp expected "$actual"
 '
 
-if test_have_prereq !FUNNYNAMES; then
-	say 'Your filesystem does not allow newlines in filenames.'
-fi
-
 test_expect_success FUNNYNAMES 'prompt - with newline in path' '
     repo_with_newline="repo
 with

-- 
2.49.0.1266.g31b7d2e469.dirty

