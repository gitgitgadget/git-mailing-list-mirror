Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE73B389B
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073783; cv=none; b=puHlUMKlKSvBkp/8yeN5N/ObQJXbKfgPO0ZIER0p7fA6RJBGpYqXZ05hqArMFWaz3beRy3go5L9hS2Cb2WDXZo1KPtzZjIpcSW2sHYXJ0xpN+/azEzoEbg9QyXtumkykz1r6tckzLqeIHJj01dhREeAo6s1Hey9KIxtlgMtzeAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073783; c=relaxed/simple;
	bh=5fs2o/dXdoTVePX6W6vWqR0NyZFxwe/R07cemVXgUJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anHsVDcFt0z7+qg3Q4AxZ+ZCdFuBd4CMzN07Wh4cVKOJRoWFEagpQSi/6ajOAe5TwdKRCvJy9fu2oPMxnrT/YLxz/S9ZqFCXT2xZbb5Sw+CZBRRyeTHAoJGYN/eRqixLaNJXOiD7HrboFUjVX4khcabBLTtiwINzwiW4nDTzMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TDwPidIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UalRuVOK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TDwPidIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UalRuVOK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D499140011B;
	Mon, 13 Apr 2026 05:49:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Apr 2026 05:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073781;
	 x=1776160181; bh=bJrb3cs5Oov0JQZIv5EtxiSd8/lhfOqyQCDjpLremtw=; b=
	TDwPidIW5MFG/kwDLj2cyuc2PyP/T8/9rOy0Q6Y8nXAspcaet9SpBpmXg4ziXXT9
	vawLYLN/44ZapVzQ+m3IgolXZwxIz8T8x3wQzixPtUZTDrlVBGP1/etU1o9qqQ/R
	RArHB6Hj9dUddndiEHedcoirrfaIBal4I4AgiVD3a2FDAfpBXzKSzD20sgTQO1wJ
	74zCV1TS4SSXNobSOkD+sw/r7esMBhfmiPtnA+3fvAZDlISrNAsG2DihKjpYn92B
	hTt7bkmI/bpXYDYoBHgsbSWMVOEH8+0TkTweXq6R1mtmoTb5srOSYOnLPOP5BS2u
	cs7idsJn10cbbtIUN78XuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073781; x=
	1776160181; bh=bJrb3cs5Oov0JQZIv5EtxiSd8/lhfOqyQCDjpLremtw=; b=U
	alRuVOKySc3jwA+y+shh3N1zhFTokyCCxrq8jbxpVsEB5x7iJ28irfUhCnv021x3
	WFaq+Fx5p1flB4baRu4wGjp3H0A0MeeQqpLlTr3WmebXe1g/qRXSG7l8XlEOicHG
	sh43wD6fwcGZG6MNzV9M+FktYp1rn0u9GhwATvRv4S3qnO9kI9h/wlkamwMk7TKY
	X2+q5Y36/AAGJGhuDraZ6DpvKXS021gFKbXNr7490HAylpoCGjFcCJwq/chTBzpH
	cmmCth9MCU6ov4xMOMnLngCPsK1Nf6KXD5GaAsKdy3xRhHDsRPnOxwtWQeSqdzK9
	n/sXXhehlZcCDJBg2W8CQ==
X-ME-Sender: <xms:NbzcaWsBr_BbTzrvyTO1xGrtLAFwqLksDFh4r19R2S7pW9Eb6WRKIg>
    <xme:NbzcaRdcAafpbcvFbJgf-CkdaVlHPlh4FJXUeipqW9C09FXE7m5MaPoVTG7PDm8Ht
    b-guxrUzojnnSvJn3R0Enab3g21DExI7Q1azCVJqfL-8SqYnF4uGgw>
X-ME-Received: <xmr:NbzcafbVzV_tDE7MBxnsCkLj0gp1TMFz9xejYGt9fmAR3c3J7piYnbJJBLoq9IHlt3LLTdgbzQwjLgyk_sttdlw1h0DohzdCyumSbNMcwMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NbzcacVmgXN_UrS_Wlkl5hs_7QJQOOEEXCufwoI8ubTlwB5IcrF4ag>
    <xmx:NbzcaZg90O3OlI93IODv_-642dNV9ye-fVXPmoZVLnaXyf8rUU0jtg>
    <xmx:NbzcaSW1uI48Nve-IdPqU60jT2IGOZis4rqVgCfhUDIZyztH6ShvCA>
    <xmx:NbzcaYMRFacdfB7zEpRIY-F0gP1j3djnEs8G-qKbTgCuGhH84V3WZA>
    <xmx:NbzcaSEhsFhVQXv_hLxAqjT33KHvRyExYxOaORTRaNM0v82FTvdR1ckk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f915289f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:26 +0200
Subject: [PATCH 05/12] t: prepare conditional test execution for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-5-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.54.0.rc0.707.g0fbf48f4d6.dirty

