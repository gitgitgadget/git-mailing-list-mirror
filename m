Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2753358AE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575970; cv=none; b=X/wOuMK7UKMVFj6TtAMaY8G+cxo4n9+rpMgUfIIPIesnn7rKm5sbtEJ/kHqEAfU1RXGiSMbPGvzPu0RUgxQWAFbxi47JOenB+FBAgUG8XfHd7VeHsTBvnvXnDZVEg0jSFWYtK/ZtuzLgMbe/Xf5KXYzqAjLT6tYfr67bcxRWOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575970; c=relaxed/simple;
	bh=vRgywpQjlmACeAsxEA/1rEzi+XP4mgmwUfgsRwqIygg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7fGi/QgWvS4aJV/dl3kChVOrKN1UahWhz7XT2MWiOHj/kCIdRBJ7aiWtZMNtbFvI1dy4PCnBgz5+ooxnmb6NMEl/VfvT5EFEGLAny784zFzLIL7cZMlzgAAMvDVdawIwvzMRpabCrXX2c8imGWkaxszTCl/4zfabG1pu4r+zcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p2aqTJHX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=esaxj3Zy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p2aqTJHX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="esaxj3Zy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CFDC21D000B5;
	Fri, 20 Feb 2026 03:26:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 20 Feb 2026 03:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575967;
	 x=1771662367; bh=KItjTiFhigK9AY4Z8Do+YUySD6GYDmeEgQRuNRDKTOQ=; b=
	p2aqTJHXVyuI6N1rRbQyT88zkzX9smTs/p70nKQLNUyQz8YImIyiUODWnxUwX5M2
	KgmAPAU/2rgraN0qTGVHxU/5umj6nBlXt81Fw/lo368gIc6tayyrFU9+Go7km4/a
	o0Dd67RNBnC5UNmZvyxzHNSyUlrG/BU9gzIYFmbyDbFNLTMl85xJH7YSQiOk3E0t
	WGhJhejhFwEQeGAuEZ8hm7VI/od2WHAPR5YjmoqnrP/Mn91frdrIHttgSK7Lup9+
	ePf2CiRhpcYv2dCCP2xJ5zBLy2NPJmsDUjsQZ8Q4/oztiIbuWUASAum2dQH/TrKr
	LdO+nPcYCI3c9Ixrp56wFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575967; x=
	1771662367; bh=KItjTiFhigK9AY4Z8Do+YUySD6GYDmeEgQRuNRDKTOQ=; b=e
	saxj3ZyE4jMeBquE99eMDn4jiqZUrVuu4JoScBB8776iJPZ+Jf1ZAojtvOba8yld
	XkF+smNyqYMTMdZjYn2Izm4bqYp74AK8SFmsD7FW0ZGdmkCWRliuVD9p/LTH5oUr
	AMYJlTLPAdR5GCr10QyDYP6sxm3F2ZEG5AouEr7SnSf20nK6/tp1LH0PUPOajM3d
	kBOjvTRqJjCo2Lh5fdM3dPZ0dSu5PRoy6VnThgHJ6GdY3HmOHo8YUy3lsvnmqhak
	olV4Zdjm+TZjRPbRYSl0JIW9NB4APATneyMoGbANM5DMbDBg0rnKcxG1fHnCd4wa
	C6B9xkzQaoB+Ocl10JAAA==
X-ME-Sender: <xms:nxqYaaUdFYiSx50Mca1byUPgX15o4Rp6OoAIf-3KjdqV4F3JrvyXxg>
    <xme:nxqYadmd6rbJBQKfU1HOkI-lWcTc_pjL4g9TT4bNrWVV2J5PlFUi9fkpBSbn60Lu-
    kUvEczEnoTuY8IngSztNXh2TO5SZbSWSVDFUsgvXo39Kx1aT3XvO7c>
X-ME-Received: <xmr:nxqYaTY5rMs7mYCfzMVE1mSG1v_tnwQmSP-79wnKY04fzwr1Ik9IbRopXcdOsqpXkQvUbbud2BWOX-vpu4Wmd318Qn8M_2jOW-Mdf27PEUdH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefgfevtdevudefudetudfghfejgfelgeehhefflefggeffheeigedvgfefheeugfen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    gthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:nxqYaQPuot6ef4CK5p3oOMhcrwAwPTkierusgbhWlaklTbCH6qIlhg>
    <xmx:nxqYaQY_O99FpxV6KMKkbzNeaw3ndMHB1zDo4a6J4T6GSwRcN7OciA>
    <xmx:nxqYaW2H9-K14v4M-euANvmZVnwuRIMWnldDDgRBENKuudxjN3kW0Q>
    <xmx:nxqYaeeqd-3E3t4_Qb6P4VveNWvkqlBi8qG1zWv8H0eKw-ZqQMOPDg>
    <xmx:nxqYaUoJKD_8XU0KJVlssI8N0NcsYkQGvXr6BQ4lT2vgoXgxBMA9rEG7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:26:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1eb88cdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:26:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:25:59 +0100
Subject: [PATCH v4 1/5] t: don't set ICONV prereq when iconv(1) is missing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-1-e0e6bbcaeb5b@pks.im>
References: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
In-Reply-To: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a couple of tests that exercise Git with different encodings,
typically around commit messages. All of these tests depend on the ICONV
prerequisite, which is set when Git was built with support for iconv.

Many of those tests also end up using the iconv(1) executable to
reencode text. But while tests can rely on the fact that Git does have
support for iconv, they cannot assume that the iconv(1) executable
exists. The consequence is thus that tests will break in case Git is
built with iconv, but the executable doesn't exist. In fact, some of the
tests even use the iconv(1) executable unconditionally, regardless of
whether or not the ICONV prerequisite is set.

Git for Windows has recently (unintentionally) shipped a change where
the iconv(1) binary is not getting installed anymore [1]. And as we use
Git for Windows directly in MSVC+Meson jobs in GitLab CI this has caused
such tests to break. The missing iconv(1) binary is considered a bug
that will be fixed in Git for Windows. But regardless of that it makes
sense to not assume the binary to always exist so that our test suite
passes on platforms that don't have iconv at all.

Extend the ICONV prerequisite so that we know to skip tests in case the
iconv(1) binary doesn't exist. We'll adapt tests that are currently
broken in subsequent commits.

[1]: https://github.com/git-for-windows/git/issues/6083

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

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
2.53.0.414.gf7e9f6c205.dirty

