Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D41C3C10
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086505; cv=none; b=k3SprOt/YROx4qb1h3wvY/W9+Ax3sHaJm12Yu2yPiBfY8dqFevx5tyl67AiK95R1zg/9MOUXDgK/NymyqGy9xbqIx7qTsn9JAfVsC8M0Ifn0dr9Ir9QxEdv2aV+uoe/pia/BIaLqeCqDDfTS/tog34np+SrhaVjQUaocbaCJK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086505; c=relaxed/simple;
	bh=W16MNM5afe7/zTN7GaQ2ggQiF3MXsT44PyT4lEN6vRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XYczY2t5lyQCGTNVnEt4siJj2wcP1fm6iliVIUaQE/2S7j5oWTcLVjx87Bgw0K8sfRhw5s/lIxdQzHzfQi6l8wKz99Obrdjqdw2PBaNCDwvg9wSqBi1N94zcY3q6XUWKz3/079US3OSSao99ro/M7TbvsIUSjaOS/hTzrGwRRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w0hfPjht; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgSIgWzu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w0hfPjht";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgSIgWzu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4DE0611401E2;
	Fri, 13 Dec 2024 05:41:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 05:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086502;
	 x=1734172902; bh=tyOpExDIk4uqeEC7bqZtX4Z27RZXqTQ5aB0l6+zdnGw=; b=
	w0hfPjhtSyXpXXHnLFumv65eGcKIZIQ2FuxvmhVmPpamFgAjf5oePWbGkXwHfqRy
	FmX3IciJm5MPy12feCF8w2esDTNnp3bLtqrU+UE2HvlCzycpK+70QlTooVX3YfnE
	qnfdc7VWLNehVtvda2h2kP+/NxcMR4cc1vPD8sQ6NYA6qSpn8zhinX2RH0R8RQv8
	vyQLoFmrVFRRITfzLQWgz5xLhJg0gxzq496A1xsGmOj+VkVM7Ht8CUHoyHkgsvMD
	Zk9DvL0HgUdUfYKOGJxFRhsVSFc7Iu2toqEjSoKNJMsPlqy7K5fi6KlZOUVg9cjp
	0NLrjJyBApZgZJyH0Akz+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086502; x=
	1734172902; bh=tyOpExDIk4uqeEC7bqZtX4Z27RZXqTQ5aB0l6+zdnGw=; b=l
	gSIgWzuoTPPGuadOcni7Y/dDRHdn4x8rnkqwXj5TPFg7MFC/52VMdX/21Rjb9zhU
	4B/LTJwS568qMwkOR8QSpIMQ+P5NpYmfnP3ePfojIuDLrwgu339jx0mV33UGGYk8
	9dPp1b5/my6yms7iR+paSs3OiaLv5JApnpL3yV1z5LaApNhdGytddz9mpjYaI7e3
	2wIXdeMqFjznu/NJvVN9GQLN31TIhYtMHkSLDBjOcW9ailq5m3dTceRrUrAQlC6U
	duT4EWv4u6NcvqZIBW+G0Sl7Nk2FBpMhwGzQsxcJINZW/euDmWxa3wn6/Yy9ZaeR
	vDCbZjUx/TAalHgGQ8G+Q==
X-ME-Sender: <xms:Zg9cZ_4mIdJ7Zaw-zdhbzDJLLk2BlO_qyFOhepvXG6Wogba2ZWQlpw>
    <xme:Zg9cZ07qQ7_-_-VmAPQHbkvf4PcI9CJArEyHwOuxxxPxaJFQcIgNDo4_YhVpDSfAn
    kosg5UsE6IKanzt2A>
X-ME-Received: <xmr:Zg9cZ2cvtQ8zGK61w3hHD9fDbWuHjOddQJfXrmBZQb8zvYEYFadOpohU92mXe3Eim8tId7mFajMACtl3q-yStSapqQF00WZnhyRWiRK4L_XoYsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtdduffdu
    veevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Zg9cZwIlk8LaeVarhOQ1dBz-GkXxb0MJ5nrBYpWzILDvQmnnC_wEeg>
    <xmx:Zg9cZzJSAiKItpD6E8EQDK3yxNtLAWbQHilLmk77XPKQJHiwCR5_WA>
    <xmx:Zg9cZ5yH1DNNHtn5ic_F9paeGIXnMCkdvU6e227jPCd7WfNW-677cQ>
    <xmx:Zg9cZ_J2wcHMdfpS7XfLQ3N2UyHe2lgBbn5IIqxCPitoLdLKdiy6KQ>
    <xmx:Zg9cZ73E0xEqflFJbWSHKOKiGPI7cpzK_ZbtuPzD2UssSnKVexQKcQ3P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 884f9568 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:21 +0100
Subject: [PATCH v2 6/8] t: fix out-of-tree tests for some git-p4 tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241213-pks-meson-ci-v2-6-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Both t9835 and t9836 exercise git-p4, but one exercises Python 2 whereas
the other one uses Python 3. These tests do not exercise "git p4", but
instead they use "git p4.py". This calls the unbuilt version of
"git-p4.py" that still has the "#!/usr/bin/env python" shebang, which
allows the test to modify which Python version comes first in $PATH,
making it possible to force a Python version.

But "git-p4.py" is not in our PATH during out-of-tree builds, and thus
we cannot locate "git-p4.py". The tests thus break with CMake and Meson.

Fix this by instead manually setting up script wrappers that invoke the
respective Python interpreter directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9835-git-p4-metadata-encoding-python2.sh | 50 ++++++++++++++---------------
 t/t9836-git-p4-metadata-encoding-python3.sh | 50 ++++++++++++++---------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index 036bf79c6674f6f1f0d667c7270674168428ffee..6116f806f631157aca7de6dbd33dcd94bbefb8aa 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -8,29 +8,29 @@ failing, and produces maximally sane output in git.'
 
 . ./lib-git-p4.sh
 
-python_target_version='2'
-
 ###############################
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
 
@@ -81,14 +81,14 @@ test_expect_success 'init depot' '
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
@@ -100,7 +100,7 @@ test_expect_success 'check utf-8 contents with passthrough strategy' '
 test_expect_success 'check latin-1 contents corrupted in git with passthrough strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=passthrough p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=passthrough p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -114,7 +114,7 @@ test_expect_success 'check latin-1 contents corrupted in git with passthrough st
 test_expect_success 'check utf-8 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -126,7 +126,7 @@ test_expect_success 'check utf-8 contents with fallback strategy' '
 test_expect_success 'check latin-1 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -138,7 +138,7 @@ test_expect_success 'check latin-1 contents with fallback strategy' '
 test_expect_success 'check cp-1252 contents with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -150,7 +150,7 @@ test_expect_success 'check cp-1252 contents with fallback strategy' '
 test_expect_success 'check cp850 contents parsed with correct fallback' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback -c git-p4.metadataFallbackEncoding=cp850 p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback -c git-p4.metadataFallbackEncoding=cp850 p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -162,7 +162,7 @@ test_expect_success 'check cp850 contents parsed with correct fallback' '
 test_expect_success 'check cp850-only contents escaped when cp1252 is fallback' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
 		git log >actual &&
@@ -174,7 +174,7 @@ test_expect_success 'check cp850-only contents escaped when cp1252 is fallback'
 test_expect_success 'check cp-1252 contents on later sync after clone with fallback strategy' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
-	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4-python2 clone --dest="$git" //depot@all &&
 	(
 		cd "$cli" &&
 		P4USER=cp1252_author &&
@@ -186,7 +186,7 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 	(
 		cd "$git" &&
 
-		git p4.py sync --branch=master &&
+		git p4-python2 sync --branch=master &&
 
 		git log p4/master >actual &&
 		grep "sœme more cp-1252 tæxt" actual &&
@@ -201,7 +201,7 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
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
2.47.1.668.gf74b3f243a.dirty

