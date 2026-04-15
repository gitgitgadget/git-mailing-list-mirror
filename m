Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D638D011
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258413; cv=none; b=E7TFpVczEsqxtkBI8AtOQrJ2O0vm3tRpz1bc89KkgDVweRPTQO7Iml6KF4XQV4TKi+V9+HEiQlYXs9B1xj3RWaBY4i361QKqyOyG6Ll3MokMu3VAAWRtqaYvskqCPrabzo7xj10k99CFhlsF8QDi9RgpyOpxsTi/FNHjjsay4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258413; c=relaxed/simple;
	bh=qV6eEGupNGMd6U2yofUnR2s3tmdDSx9rBLB+S7CCkOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9vHDfWfnM79Qw0C0wG6/DT7+K3gHyXLFxA0x6RvtdDgjf2O+nqdFH32dOXLolQGqEFRjRGCQoXCkWM86Uiv5WeBCTXMknodUoCTF+ghFqU1s+fXSWNHr0b+f8qUQk9oUzF/fOQCyBymYsqdLS1X9BuoCL7w0KHAjm6CR54LzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QkCjfr7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQmkh9EL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QkCjfr7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQmkh9EL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B6C8EC0197;
	Wed, 15 Apr 2026 09:06:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Apr 2026 09:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258411;
	 x=1776344811; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=
	QkCjfr7BK7w6tczkGaj0HLJ7datSSNQRdyidRTFA9rAQIreQ2ug2m2kpNUCNN0Ko
	ouLtyf6te/Wfp2yQNnxGOmneLwCOCMrg0JCHo+CX4/6N3vO0pk99jwoThZQUPZu/
	charmdW86fj/Yc48At6jkleUkXytuR92iz56AoqPbPz3ZTwyCXqnflgRAmXPGwMo
	fhy/pDiSjVOJd4pccswbTo/rlSkXtfpGxgasLhklnBdqSSEYmF3Ovhr34ghTKLKd
	XY9p2Q5UaxPgTrPD/zyD6rd/gbB/1dbEEdgur2s7YvjAqhpqnGg/zlIPXfH7BX5/
	K7PyjsU4h5Sh8P9MVsvtrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258411; x=
	1776344811; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=W
	Qmkh9ELDzrEftTSgOHVPMg8vEOqEjVmWSQsKVXjSYG4vvMOdltyzNOYoffbMAdBV
	RX/dzcJE2X+csaxdLHxhaCQFWofRy0t6mb4wBSdAzLcUGs62ZyUg4RvDnTokywIp
	q0SZayyW1N7y9z8b/gXslWWdoUKl2Nwcvgenl6LJK6T2g+H0HjNUOWsIuBFd8LKa
	QSb0q1rGnTKiaXZgF3aWqm7P0EqucHrPyPwdJMgYuHVXhzp2JMvHAtlz2iW+kWPg
	YXejCn24yzuGQTadg24NI17i22fZXcLWbP51k/oQXRwK3cV/RYPNFUe5pHa9J+/i
	jSpRcSa29lKaUR2RlERkw==
X-ME-Sender: <xms:a43faYdzF7zlI_OwLFzGWPOJL2xrvtxGFAxhB_CqfokzgXsmapRICQ>
    <xme:a43faRpyDWzxuzpTdV7QbRWVW2fB6Sy2Kz3WGYLOSFktgiRe_Eo6H2QiM3KwjwACA
    0QXCfmvGuvZjo7A3BvXRIGEIdVSQzdED4X-iSOPiO7duPCBba5jqQ>
X-ME-Received: <xmr:a43faW75sgbyzTyy91jvc6QVzgwnpOnsZIEi7PRNcjDS7dr_Ce5WlGXhKK6XNEH8ZljhWgkGYhub88p84aqX94hMIQc537zlPuSXP5OzJRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:a43faXqLf-RaQWrKgp7HUlaJSpNak-iG_5024t2k7btbkmz1dqzqSA>
    <xmx:a43faYh6d6yl2HyK4jdF4icMoUdflW2KAyDd47886CAMvjiVtYs-TA>
    <xmx:a43faRLd5rbv7ZdzVNJxHkYe4zI8ucHyVvzeWoFzo0-siWBdQyWNZA>
    <xmx:a43faYBWVSFLf6d5QdN1JBhpSSxSFFeKqUw2rl_EruREvUKq-jo_4Q>
    <xmx:a43faaZQtTwhaZ4HHOiXWf0775cgNMV4YAMQ4hIedSoiALzU2Be5UGeE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d41f4e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:38 +0200
Subject: [PATCH v2 05/12] t: prepare conditional test execution for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-5-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

We have some test in our test suite where we use the pattern of
`test ... && test_expect_succeess` to conditionally execute a test. The
problem is that when we decide to not execute the test, we'll indeed
skip the test, but the overall statement will also be unsuccessful. This
will become a problem once we enable `set -e`.

Prepare for this future by turning this into a proper conditional, which
is also a bit easier to read overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 12 +++++++-----
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index c98eb6abb2..2d216fb70f 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -40,11 +40,13 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	test -f $expected &&
-	test_expect_success "$label: check output" "
-		git $cmd $file | grep -v '^index ' >actual &&
-		test_cmp $expected actual
-	"
+	if test -f $expected
+	then
+		test_expect_success "$label: check output" "
+			git $cmd $file | grep -v '^index ' >actual &&
+			test_cmp $expected actual
+		"
+	fi
 }
 
 cat <<EOF >expected.f1.0.1 || exit 1
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index f512eed278..8cc86522b2 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -220,17 +220,19 @@ check_dotx_symlink () {
 		)
 	'
 
-	test -n "$refuse_index" &&
-	test_expect_success "refuse to load symlinked $name into index ($type)" '
-		test_must_fail \
-			git -C $dir \
-			    -c core.protectntfs \
-			    -c core.protecthfs \
-			    read-tree $tree 2>err &&
-		grep "invalid path.*$name" err &&
-		git -C $dir ls-files -s >out &&
-		test_must_be_empty out
-	'
+	if test -n "$refuse_index"
+	then
+		test_expect_success "refuse to load symlinked $name into index ($type)" '
+			test_must_fail \
+				git -C $dir \
+				    -c core.protectntfs \
+				    -c core.protecthfs \
+				    read-tree $tree 2>err &&
+			grep "invalid path.*$name" err &&
+			git -C $dir ls-files -s >out &&
+			test_must_be_empty out
+		'
+	fi
 }
 
 check_dotx_symlink gitmodules vanilla .gitmodules

-- 
2.54.0.rc2.529.gd9106f7525.dirty

