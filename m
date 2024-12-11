Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6D1EE7A5
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914398; cv=none; b=cVsL+0J0EipwnI8qKHGRxZjCI1PENFsvpR3P68HeIj/JFV+oOUgqtJu8Gj2029VMgFM+YBFtERAdUF1tB4eT64yB1S2f6OtAOHB8ysFtgQbxfuimvIc2g/H4jVNHH9AxSeCSrISjWVOZJ0cJmDXkfEWK+r4lS/cUhF5XIFcj3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914398; c=relaxed/simple;
	bh=PubPMK/xlAbfwqm0gFtI8AC7UTzvva9hi4gTOgGxTCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYS6uugfyrJjytAyGm7qlwNd57Sr/Gcf8WKvSy0bkyuXIYnHD0Z+ZEE5ekMENKMTi/H31FkRPFajO4d5ckjhn57mHyU5SB9o+LFgGfqLG7GGZcMYtlVK4O5zqa3zIeBLKblI0rAufGXaQSlckotuRyaunlfX1YQ9sicMi7JPfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FKCI2WQq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIUBzmIS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FKCI2WQq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIUBzmIS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 57CD31140272
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 05:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914394;
	 x=1734000794; bh=r5dPuSt4sqmM6+TSZ4KtTwSpUcDDhyCGnxdpl2fd0l0=; b=
	FKCI2WQqavy9iVDUj8Ou8SM+ddaUCwlhyVbG/rNCFTd6I3viLtn/T5oDaFLp01jh
	7aNTO+W5eEzIDRv4PWHmOFvm+Ym1DPG1TOU4/I7/Xw499UMYQ5miFpSxi+O4RMvE
	yL3cY1wh4gS6CXRvvh5SeqDaRVMnCYaAjqY/4STND4jJ60G+RETmQxmOoakpvU5p
	NroZu/QCMo6wkf+Q/F+mSVMy3oH5BQ31JWWUf0QyjdBPd2wQZBUMN7oGCcq6q93f
	Iu/Wbsg6zPxAw0HHrX4ceoyngqi7HsulH0fR4htoTDACGKp5a3EkstKEie/hwaLY
	IvxNH1IKfyRUnsQng9feRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914394; x=
	1734000794; bh=r5dPuSt4sqmM6+TSZ4KtTwSpUcDDhyCGnxdpl2fd0l0=; b=K
	IUBzmISsEksuMgCqnu3djUey/0HxKG9MZczXXxTJI27JmW9Fa3i0LUIv0MAXlJ+T
	ly57YYbvyjGo88LfTPUO4QPVAbi3kgww0k6WuaxYW7Z0LAEhfYifCwldLqQNJNJr
	s4gGRdAv/NoZ6j8xwRf14hjnTHwdWkCdlq8+eD09/T0LAKIFTJe9JhO8AKgrFt4/
	7rM/eJSZA62Xsq+7x9Aoahnk1tQt/zBwL0P6oZmu4Z4GfZ/ptME7M6w9z9zisfEj
	K/9jDEYkJuPcuKeCjAnziDZcC5Xjyl60tF3RiwAl9jI9d/ZYduuHy3LnRoHU4GQE
	fuuLTOS9CFwMekwfVuELg==
X-ME-Sender: <xms:Gm9ZZwdJyK_JLi97_VtlVSjZB_HKNyluyQai8jb3upqB0sQZ_zw7Uw>
    <xme:Gm9ZZyN-TXY_OGn-6pMYbzLVOqwH3F-ne1m0LIi2RdJ56w_koT67Z3n9EfGzBkT8K
    96fj-8SzqqD667-3w>
X-ME-Received: <xmr:Gm9ZZxh_9peXC3k2u_4xoXzUD6yjYCQCPYIWozgyK-Aqxl4lKr9dUwN9DK5EzTmwt-NYeRtpbnetiDjzD8G18Bg-UKzG-JqmQ-5W-6mmqd1qqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelhe
    efjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gm9ZZ18ZJ2n27pmjxsW_3Br03movRvx1RMDIf37Zplf9_jvcyQcHBA>
    <xmx:Gm9ZZ8vrSOi2lrxavus1sEcp3UtoTiDJtb2IG_9T896Na_-drpDsQQ>
    <xmx:Gm9ZZ8Fj71SX8RXVNNpTn5pdNlqBPT7VYjOzVQFSe9V_ZdoJCcsFbA>
    <xmx:Gm9ZZ7NwFgQQleLyfiuE_BVqujAOy1tWKvcIHl2OXGGPjLEXgTyTPg>
    <xmx:Gm9ZZ5VR3p1iSZ-1bkDF4caFM_D6t3sctEnO47WYhHE0ynUwF7nb5lZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93f03aff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:37 +0100
Subject: [PATCH 6/8] t: fix out-of-tree tests for some git-p4 tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Both t9835 and t9836 exercise git-p4, but one exercises Python 2 whereas
the other one uses Python 3. These tests do not exercise "git p4", but
instead they use "git p4.py" so that the unbuilt version of "git-p4.py"
is used that has "#!/usr/bin/env python" as shebang instead of the
replaced shebang.

But "git-p4.py" is not in our PATH during out-of-tree builds, and thus
we cannot locate "git-p4.py". The tests thus break with CMake and Meson.

Fix this by instead manually setting up script wrappers that invoke the
respective Python interpreter directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9835-git-p4-metadata-encoding-python2.sh | 48 ++++++++++++++-------------
 t/t9836-git-p4-metadata-encoding-python3.sh | 50 ++++++++++++++---------------
 2 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index 036bf79c6674f6f1f0d667c7270674168428ffee..02f9ec09053890a4d41b7dc95644066d6481bbb6 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -14,23 +14,25 @@ python_target_version='2'
 ## SECTION REPEATED IN t9836 ##
 ###############################
 
-# Please note: this test calls "git-p4.py" rather than "git-p4", because the
-# latter references a specific path so we can't easily force it to run under
-# the python version we need to.
-
-python_major_version=$(python -V 2>&1 | cut -c  8)
-python_target_binary=$(which python$python_target_version)
-if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
+# These tests are specific to Python 2. Write a custom script that executes
+# git-p4 directly with the Python 2 interpreter to ensure that we use that
+# version even if Git was compiled with Python 3.
+python_target_binary=$(which python2)
+if test -n "$python_target_binary"
 then
 	mkdir temp_python
-	PATH="$(pwd)/temp_python:$PATH" && export PATH
-	ln -s $python_target_binary temp_python/python
+	PATH="$(pwd)/temp_python:$PATH"
+	export PATH
+
+	write_script temp_python/git-p4-python2 <<-EOF
+	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
+	EOF
 fi
 
-python_major_version=$(python -V 2>&1 | cut -c  8)
-if ! test "$python_major_version" = "$python_target_version"
+git p4-python2 >err
+if ! grep 'valid commands' err
 then
-	skip_all="skipping python$python_target_version-specific git p4 tests; python$python_target_version not available"
+	skip_all="skipping python2 git p4 tests; python2 not available"
 	test_done
 fi
 
@@ -81,14 +83,14 @@ test_expect_success 'init depot' '
 test_expect_success 'clone non-utf8 repo with strict encoding' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4.py clone --dest="$git" //depot@all 2>err &&
+	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4-python2 clone --dest="$git" //depot@all 2>err &&
 	grep "Decoding perforce metadata failed!" err
 '
 
 test_expect_success 'check utf-8 contents with passthrough strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=passthrough p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=passthrough p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -100,7 +102,7 @@ test_expect_success 'check utf-8 contents with passthrough strategy' '
 test_expect_success 'check latin-1 contents corrupted in git with passthrough strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=passthrough p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=passthrough p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -114,7 +116,7 @@ test_expect_success 'check latin-1 contents corrupted in git with passthrough st
 test_expect_success 'check utf-8 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -126,7 +128,7 @@ test_expect_success 'check utf-8 contents with fallback strategy' '
 test_expect_success 'check latin-1 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -138,7 +140,7 @@ test_expect_success 'check latin-1 contents with fallback strategy' '
 test_expect_success 'check cp-1252 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -150,7 +152,7 @@ test_expect_success 'check cp-1252 contents with fallback strategy' '
 test_expect_success 'check cp850 contents parsed with correct fallback' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback -c git-p4.metadataFallbackEncoding=cp850 p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback -c git-p4.metadataFallbackEncoding=cp850 p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -162,7 +164,7 @@ test_expect_success 'check cp850 contents parsed with correct fallback' '
 test_expect_success 'check cp850-only contents escaped when cp1252 is fallback' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -174,7 +176,7 @@ test_expect_success 'check cp850-only contents escaped when cp1252 is fallback'
 test_expect_success 'check cp-1252 contents on later sync after clone with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$cli" &&
 		P4USER=cp1252_author &&
@@ -186,7 +188,7 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 	(
 		cd "$git" &&
 
-		git p4.py sync --branch=master &&
+		git p4-python2 sync --branch=master &&
 
 		git log p4/master >actual &&
 		grep "sœme more cp-1252 tæxt" actual &&
@@ -201,7 +203,7 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 test_expect_success 'passthrough (latin-1 contents corrupted in git) is the default with python2' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=passthrough p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=passthrough p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
index 63350dc4b5c6262480cd0be8fd88fba714c55428..5e5217a66b4fdb3c7fcf073a50952c7e9009e9fe 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -8,29 +8,29 @@ failing, and produces maximally sane output in git.'
 
 . ./lib-git-p4.sh
 
-python_target_version='3'
-
 ###############################
 ## SECTION REPEATED IN t9835 ##
 ###############################
 
-# Please note: this test calls "git-p4.py" rather than "git-p4", because the
-# latter references a specific path so we can't easily force it to run under
-# the python version we need to.
-
-python_major_version=$(python -V 2>&1 | cut -c  8)
-python_target_binary=$(which python$python_target_version)
-if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
+# These tests are specific to Python 3. Write a custom script that executes
+# git-p4 directly with the Python 3 interpreter to ensure that we use that
+# version even if Git was compiled with Python 2.
+python_target_binary=$(which python3)
+if test -n "$python_target_binary"
 then
 	mkdir temp_python
-	PATH="$(pwd)/temp_python:$PATH" && export PATH
-	ln -s $python_target_binary temp_python/python
+	PATH="$(pwd)/temp_python:$PATH"
+	export PATH
+
+	write_script temp_python/git-p4-python3 <<-EOF
+	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
+	EOF
 fi
 
-python_major_version=$(python -V 2>&1 | cut -c  8)
-if ! test "$python_major_version" = "$python_target_version"
+git p4-python3 >err
+if ! grep 'valid commands' err
 then
-	skip_all="skipping python$python_target_version-specific git p4 tests; python$python_target_version not available"
+	skip_all="skipping python3 git p4 tests; python3 not available"
 	test_done
 fi
 
@@ -81,14 +81,14 @@ test_expect_success 'init depot' '
 test_expect_success 'clone non-utf8 repo with strict encoding' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4.py clone --dest="$git" //depot@all 2>err &&
+	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4-python3 clone --dest="$git" //depot@all 2>err &&
 	grep "Decoding perforce metadata failed!" err
 '
 
 test_expect_success 'check utf-8 contents with passthrough strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=passthrough p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=passthrough p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -100,7 +100,7 @@ test_expect_success 'check utf-8 contents with passthrough strategy' '
 test_expect_success 'check latin-1 contents corrupted in git with passthrough strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=passthrough p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=passthrough p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -114,7 +114,7 @@ test_expect_success 'check latin-1 contents corrupted in git with passthrough st
 test_expect_success 'check utf-8 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -126,7 +126,7 @@ test_expect_success 'check utf-8 contents with fallback strategy' '
 test_expect_success 'check latin-1 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -138,7 +138,7 @@ test_expect_success 'check latin-1 contents with fallback strategy' '
 test_expect_success 'check cp-1252 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -150,7 +150,7 @@ test_expect_success 'check cp-1252 contents with fallback strategy' '
 test_expect_success 'check cp850 contents parsed with correct fallback' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback -c git-p4.metadataFallbackEncoding=cp850 p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback -c git-p4.metadataFallbackEncoding=cp850 p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -162,7 +162,7 @@ test_expect_success 'check cp850 contents parsed with correct fallback' '
 test_expect_success 'check cp850-only contents escaped when cp1252 is fallback' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -174,7 +174,7 @@ test_expect_success 'check cp850-only contents escaped when cp1252 is fallback'
 test_expect_success 'check cp-1252 contents on later sync after clone with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$cli" &&
 		P4USER=cp1252_author &&
@@ -186,7 +186,7 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 	(
 		cd "$git" &&
 
-		git p4.py sync --branch=master &&
+		git p4-python3 sync --branch=master &&
 
 		git log p4/master >actual &&
 		grep "sœme more cp-1252 tæxt" actual &&
@@ -202,7 +202,7 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 test_expect_success 'fallback (both utf-8 and cp-1252 contents handled) is the default with python3' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git p4.py clone --dest="$git" //depot@all &&
+	git p4-python3 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&

-- 
2.47.1.447.ga7e8429e30.dirty

