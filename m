Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E09361677
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336717; cv=none; b=VvjCpopK+Sh5v5YhDZSPOqid0iBR7KwAfQwvmoGg5kW1y/w3cgc4yORcENzfu+RAx+2OCESzi32UPLL+tSAZfitLx9VPM8M8h1FGHVjQdFbzDGKxt7wrho0QxysNcNxU0FhOumVPhIuDOQ31MdiJdDgtcibksvkVd7d/545GNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336717; c=relaxed/simple;
	bh=WD2oI1ual82oPsChn5S9vDgXE5J30fM1El5tHknmSKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4xQjOgvqrM/MgybI3LE9E4BLfNcCTndFpnPg+Hf2qKofF34ST2lMS9fnWCFbu4kpBX7JahFMzYUL/mD0+q5FdldFC/h4oslEZt9vmAidYKxda6xMPxnKfqdvGyRP/FsCE/g9zqAL5vRgFEL4hQJAWhu/0ISKB5iCiE6BnQStis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=am5L+yYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9fkRe1V; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="am5L+yYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9fkRe1V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 559921400176;
	Tue, 17 Feb 2026 08:58:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 08:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771336715;
	 x=1771423115; bh=Jo4BTdPni/XPbTzv85Y/A3JRupmp1oBm46Xjb7jEjO0=; b=
	am5L+yYAajqXcfh2w7PHVn+tzB9cDiR8NeXYwUwrr4aA5KJ8Fd/HarPJkH1Kza3T
	8rt8pztlCIB/fMO4mAMHWyyILqpBgdJ9KhOIBeJELL3+iAe0aOpM1LBK6B89Ioee
	1Ef1odbjYc3uARj1zy1B2hBfFCz9jdtflQ+twy+qXLP6fxf7ih0OwOrN9cb8Qxcm
	UPcAiJQrF01Pf+zfFlS9+HjlbNXqkQOhtbzhVkVuLH9lYYtJ0CcMitk/5Osjx69r
	AWzEPINCyqBy6Lcl6yzjCO3zAfD/b+/KOjpngzOSo00Bj4uWVV2fwnTD1gQnW7EK
	ctaLu8Rp2QI9iyDrZa3FnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771336715; x=
	1771423115; bh=Jo4BTdPni/XPbTzv85Y/A3JRupmp1oBm46Xjb7jEjO0=; b=p
	9fkRe1VxbM7PN3Ao+5P/f9cjeCJdAMV3PGaIuot3CBOcUZ7HqOote7Y9P2gvcJ1P
	mqlX80A5ypP7cV+9UgeYAWvjp3byUIlFb1cRd1HRCom2mvEFmCAkIh3+e200Iand
	rk2HP7fwvcDXlUAYDW/TlgWmRJkF+cLGWYAIpd7sMbvjF4M6mRiQjIkBhUa5vgdQ
	FuqrXp+7zvrq01LIUXrbReFAo1ttsXgLaiMMSWNP7xBQ8qs4TDitUEE7NCuy6WQ2
	A5rffn7spWrH7Onp15/PlokbECsXrgJlj/piZ/g2nqVXgPvnro4IfgHfTOtyTd1M
	Dy8anUiC2vZVkWYSt5uQQ==
X-ME-Sender: <xms:C3SUaWAAI4EkAp5sga3XWHJMw2RY96s93XHUfB7YVQjLVaVmVGBFEA>
    <xme:C3SUaWgIUd-S6S_eIMc-KKxAvdwsM3-u-U6xmxgdlSrZf4Tc3WdzDRit_0vEC2xEb
    RMYcm2WkMlDhyBxic_rp7243CqyuMuLwNfdttQ0MDdDgKrgI5RHeqw>
X-ME-Received: <xmr:C3SUaXP6NgeljPAZl3CiQc11OfsBenB7Z1d58vVZV0ROJ3m4jqvUNsyplsiT_0Urm9ZYEero2kBxpyyNI8QW_1bNrQg-S-qtTop0GOAOTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefgvedtvedufedutedugffhjefgleeghe
    ehffelgfegffehieegvdfgfeehuefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:C3SUaf49Sjs8VoRx8jtZIwPapZnicEMxrNvVZI9uYtBcCyo9aQhEPw>
    <xmx:C3SUad0WPUYNfvbYgSgGFIFSmZZ4x7CrbEMuwEJu2YejGAihT9oaVA>
    <xmx:C3SUaYY14SGzTC7SXV8zoVtJnpopVnq3lT21mW89h0f0cjeXGlo9TQ>
    <xmx:C3SUadDgFiqqehgoVq0mAt1SmiDGQs3mAReiKQKL8nXnY_l3Mffk2w>
    <xmx:C3SUaZa-343s_zVrLcfN68rraBoyUeN58FAmCV5IjN9gqtjM8IPlvfAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 08:58:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b09b4705 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 13:58:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Feb 2026 14:58:27 +0100
Subject: [PATCH v2 1/4] t4xxx: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-1-25491bc8dbf8@pks.im>
References: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
In-Reply-To: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a couple of tests that all use the iconv(1) executable to
convert the encoding of a commit message. All of these tests are
prepared to handle a missing ICONV prereq, in which case they will
simply use UTF-8 encoding.

But even if the ICONV prerequisite has failed we try to use the iconv(1)
executable. But it's not a safe to assume that the executable exists in
that case. And besides that, it's also unnecessary to use iconv(1) in
the first place, as we would only use it to convert from UTF-8 to UTF-8,
which should be equivalent to a no-op.

In fact, Git for Windows has recently (unintentionally) shipped a change
where the iconv(1) binary is not getting installed anymore [1]. And as
we use Git for Windows directly in MSVC+Meson jobs in GitLab CI this has
exposed the issue. The missing iconv(1) binary is considered a bug that
will be fixed in Git for Windows, but regardless of that it makes sense
to not assume the binary to always exist.

Fix the issue and skip the call to iconv(1) in case the prerequisite is
not set. This makes tests work on systems that don't have iconv at all.
Extend the ICONV prerequisite to cover these new semantics so that we
know to skip tests in case the iconv(1) binary doesn't exist.

[1]: https://github.com/git-for-windows/git/issues/6083

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4041-diff-submodule-option.sh             |  8 ++++++--
 t/t4059-diff-submodule-not-initialized.sh    |  8 ++++++--
 t/t4060-diff-submodule-option-diff-format.sh |  8 ++++++--
 t/test-lib.sh                                | 12 +++++++++++-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 4d4aa1650f..4dd4954260 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -37,8 +37,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index 0fe81056d5..bb902ce94d 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -35,8 +35,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index dbfeb7470b..d8f9213255 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -35,8 +35,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fb76f7d11..67d15ae079 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1720,7 +1720,6 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_CURL" && test_set_prereq LIBCURL
 test -z "$NO_GITWEB" && test_set_prereq GITWEB
-test -z "$NO_ICONV" && test_set_prereq ICONV
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
@@ -1731,6 +1730,17 @@ test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
 test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
 test -n "$PERL_PATH" && test_set_prereq PERL_TEST_HELPERS
 
+test_lazy_prereq ICONV '
+	# We require Git to be built with iconv support, and we require the
+	# iconv binary to exist.
+	#
+	# NEEDSWORK: We might eventually want to split this up into two
+	# prerequisites: one for NO_ICONV, and one for the iconv(1) binary, as
+	# some tests only depend on either of these.
+	test -z "$NO_ICONV" &&
+	iconv -f utf8 -t utf8 </dev/null
+'
+
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
 	GIT_TEST_CHECK_CACHE_TREE=true

-- 
2.53.0.352.gd1286b26eb.dirty

