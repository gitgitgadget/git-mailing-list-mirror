Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3263B7B7D
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423075; cv=none; b=plphb4rGA6qDo6XDfi7RJJVuIBUUMmQbp2PVr+xAJRAautQNYkXQT/wkuITdE8Jr4AwjX2Rs5BT6O1VEEShV0XdrQmftx3Xf07WfKhx/GG+O/bhVzZ2jWyriN6DRtQSCIGLlDqHDkuXtfCoR8vXCIP8JURR58ZhY+pagJ3ZnE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423075; c=relaxed/simple;
	bh=qV6eEGupNGMd6U2yofUnR2s3tmdDSx9rBLB+S7CCkOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6TN359/NHg9UJ3TFsFOsqOVNaE9ZUlB9MEXaD3G4utnq0amjuu20uZbvqbXcXi0NkL8wzkxEOSqWPDknw+2uZlqxmpLKiFatmHOju8CbH0dFQ7hLsscDlfL6I1R6WxYS6n0Q+dYFc2Ob6S0y/iEU4VIhF1ElTedXT3dho2XOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SKQfyYnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOYAiX9O; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SKQfyYnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOYAiX9O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 51B84EC0103;
	Fri, 17 Apr 2026 06:51:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423071;
	 x=1776509471; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=
	SKQfyYnwIzJNu6hc2fPSdhcYORX0cUux0+5JCPpaQu5s93W9eUeGONHcy8siHea9
	ICgVqV/wv1EPh8aCLWgjUTmr3qI8F5p6VL9mS0xCooLXusEyGHsnFtmXuzDhCNJE
	0bLD8dy6zaHmkLIWf0yrKpJdTKDXVOQyghjt51MAEo4Ad5UJo11nxETbNhyaKkF4
	0jfWWQ3RUbvk2dzGYIr0r5/SF4LDR8Jiw5j3nKQ6I82OutrsD390FAx0gkXKSpl2
	BSMvSjGt1hxdQ8paZDemUzfUGEHNRiRiUhps4wK3pOSfrG9xq5GKZ82BD6ULsRsf
	BbbCu+SCWVVO5Gv0MKlOPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423071; x=
	1776509471; bh=udKANwLh2mEDENOzM7ntj3nLyIThxAX53mSdIku/7ds=; b=S
	OYAiX9OhEAel+XnfB08ilqs4GgqUjuIlZly33kLHDG3UQ7KLSt+QZ9ffklkGpLAt
	TCFMPkmmqBHFdg/It0u141gH6H5Pj6EM0QFmRoguGrMwmcAtBH1ebMVRVnECyx1u
	+vpaVEQDN6ICbPqqxYXVhStfDtOUIaWZMRqqtvCPrPOH2z+6lSUEY8cdD++j08GP
	OcemqFMJFglOXvzpvTKfA3XOdZHOV4UE+cna5NPeL/iKSTtBdbANPYal3IOUKqgW
	yNAl7W0r6X14R3VaBxwPmfTriLBJPHW+IekroN0NY3OigPVenUTcIU8X5GEeJe5h
	50PkTiShzjTc8wJAidChw==
X-ME-Sender: <xms:nxDiaRgtJ2TN1Gx1O_Buuu0hnX569EzRNVFdezcbN9y7PVuxBi-MAQ>
    <xme:nxDiadCDgJzYAtFej2xeqT2O4BpsbIGHddB799e4BigHsh_qJN-O2puMWoKp2j7ks
    4rBCxUmq1yxm2tRtIsc5JPXMZZno34tvaAULJp13HbY5W6ZDWIQAw>
X-ME-Received: <xmr:nxDiaWENz2rh-xdARS24cGUJzhAV0Qkn8PsdUbwsbaReiMdAN0-ql0IHZhScwSvEdi4b2oV02wudpb1uDCHFNQNskMuaTQz8SNsHfrN8TBu_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:nxDiaVLmucyZq2q4XH1LywftO3h9e419Ckw6VspB5cO5Wd1uq1MO4g>
    <xmx:nxDiaany7UxblyWvLT_0bpRKQgctZkvIgNFKgxl8ileSetp5ou1VIw>
    <xmx:nxDiadR1thmmBo5FF8zD05NM3CpYQg6ViB723mKGxeupNorZb6Smqw>
    <xmx:nxDiacK2598_fH3hANvCE7gW7dERbJgZQn753nfPCMTmkjJqEpUWKw>
    <xmx:nxDiaQBr2lJ_tz6Mcp-w2XqKPzD-FB_fAjXhtrmMrAPdsDbyZrFAOG_b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d13fba30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:51 +0200
Subject: [PATCH v4 05/12] t: prepare conditional test execution for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-5-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

