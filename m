Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944522EBB99
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389529; cv=none; b=bxKXeG6NUlbRWByi1b0K9xDeATYpwSBfy0ugntZ9VV8aC6d2NbH9+2QN6LjknT+PCIgEhYiCWXQaflU0iFFPhbpL7ZXGipRhkMFtCOKOyo+XlAygA5nyNyRm/kL+5GOIKAJbLxvWWoOK0rJqt7MjalpelWwG0dJH78mTCaW1Ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389529; c=relaxed/simple;
	bh=vRgywpQjlmACeAsxEA/1rEzi+XP4mgmwUfgsRwqIygg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBOzjNDjDwLh+yaxsjWIKqDoKj9C4LLfuOzVXfa6AJLpkY6WslluL37uIj5tUx59TLWvJUekC1U5pnTQJONOt5oPyWAtH7lhmTa67vnYOk9jtPU6m/+8Q4IfRkuOUP6Md96asUehLN7JawWJabWSF+kprgqR/UUSCGF51wmr7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tJEjpnwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6F0B+MW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tJEjpnwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6F0B+MW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E08B21400188;
	Tue, 17 Feb 2026 23:38:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 23:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771389527;
	 x=1771475927; bh=KItjTiFhigK9AY4Z8Do+YUySD6GYDmeEgQRuNRDKTOQ=; b=
	tJEjpnwHR+cS7EJtM+bvYmTAUFAufuCkGr+5S8r4yDfvHotx9u/osDxTWwsQolIU
	MEwbrcfYJKeRc2eaYSPeE1lhSnIT4CnIc3hsd3guBvWJ6Tr42VX0wpvGRAOJ9ABt
	2aHNW0EEmNzzIFrq+AdWdpmJNltv2Y1+8SXwTeyN5CBT4FrMHuqS+XiCBnCNRaTt
	/7jTbGfO3hM9F4x1tZE0bBbboBvs8zToZwx9QDEKZKrpxrCMnjJAP8hwUghUY7nK
	8ZUWNqbtbO6PrRhHBc4E6y86EbMCEo2ZYke5Ag7BkD4/nMp2dkQWIOptKsc18/Fg
	y0O2DCvR16px0LIpZYcg9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771389527; x=
	1771475927; bh=KItjTiFhigK9AY4Z8Do+YUySD6GYDmeEgQRuNRDKTOQ=; b=O
	6F0B+MWsM+04S4EQQFVYRzjybKdFeqBQEA0pGSGaMaKkYYGg31ANKUf99G8SmxJO
	UMx1j+MEJys4P0GCy1sWrCO0ni9xDdeL7HKNkP8fJ8dfKSVvGsTqJz6Dk5EwwOgN
	lm5WLsq7bt9HXB2HT5Rerp9B+gpGM3Qza1HMluNKhU7rmzT5vObh3YOijGcmMVHy
	VJP9uMdSdh3AQqR/YdWlTNA8a2cbOUwg0hMlcqosA37n4w2mnJ4J3Mc2MetXttbX
	kyQv2NRKArrOVZfdROEwk9gIMuBC2ADt/Q+yomEdxSPtUVINwJv0WC0xsunnt4An
	5wvFimMvoPU2ndljAktXg==
X-ME-Sender: <xms:V0KVaTIwHVBkXAuEGd2iBcPPbY0OJc0N0-RshmTp-9KVLBltt7V7TQ>
    <xme:V0KVadIQZvj1aUqKJWioAeQ75NU12SpCbLuGbYm9xcQ_ARgAtjqowJ0b_PzxwHNp8
    Nf9dpQ0oduNCA9d667DUIKWrjfb23hugiVCtpw8m8C9mqiod32siCQ>
X-ME-Received: <xmr:V0KVaZXLckgFhAiAaxHY_QY6Ju966FDgTFmQNydvR7nX5ubSpas2tt0IIeXaRKqrx8LczEOr1KvfWKccwzUoQoQkYlc3VovVaay5_Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefgvedtvedufedutedugffhjefgleeghe
    ehffelgfegffehieegvdfgfeehuefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V0KVaXjV_ga5GQTE9nIzM9Ur7yjnJbKoS8iTxvvlzRGx0oqrO1q0_w>
    <xmx:V0KVac8xsbKW3L1xoOBve00kh0KnmHMZSRZ8HTfj1dD6B6C5iLJyyw>
    <xmx:V0KVaZAanlIfGvrS2Olh8Iqe9uJLugMs8fRlg4bx2xz-EM2aRPYoHw>
    <xmx:V0KVaRJig3EXlhkUClvLg7JRk-xA2RKtE8tfB-YoHNII4Npttpl-Cw>
    <xmx:V0KVaWg_GF_hTGi-CzCXPWa5JU6JwlckZY1R8jMGQ6rtJeZ0maMOK2cI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:38:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49513d66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:38:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Feb 2026 05:38:38 +0100
Subject: [PATCH v3 1/5] t: don't set ICONV prereq when iconv(1) is missing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-1-08c1ff3ffc9a@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
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

