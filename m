Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D014C5AE
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938673; cv=none; b=qCP45hzO1kfzmFERo2LZ24oTpgcRJy/Qzt2BdtGHzun8h3bcuOVTKEv+lrufjvEz7y/BlPwJLx+Xp5AQHCmsKiMIF7fwE1DEQXdtCGvq2cAN+1GO4Dsb2WlUez/6SHSX+AsDTtzUrRCyanBdbwH0qri/MAc7gxpKLtqm3vOi6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938673; c=relaxed/simple;
	bh=v4jhb9TrjkvZR87VylTvWloVFAcGDa4xDojYZoEH2xQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTvLeElNaK9zs9sngSO33VXcGspLfGnq1YNjeXk/SIGBz/8NTXRx9ouA6grWila4VhOC6KFxpnO7m9wLkJZRkPTGTDqLQPfWYn/wTXPo96z1aqytCwARNJHFVK5wEGmZQ7FoU0CS0NrSlcBhwz5gapMadVfI/Lk+3cb6WGLxV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rPzbIv0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuYhC+WQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rPzbIv0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuYhC+WQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EBFA11401B5;
	Mon, 14 Oct 2024 16:44:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 14 Oct 2024 16:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728938670; x=
	1729025070; bh=5vKmta+kteOpLPP5tcPt+e34gAjVWYRailpFgJHabZk=; b=r
	PzbIv0NrpfL86cf/+t8lRFeVJTo3DMfMknkgxhSueb9pAx4nF4rHNh5kmfPIqMaf
	GzlumIme2D4NTu2hxB7dc31txBa7UeG6EEiuRR9nRtra5wMnapfEXez4UX/q0bFs
	1ILxdQbg/bbT+oaltwe64Rh6O32e+DGqLitnWMVbcC6yVYHUD7S3MZV0MJBunMoo
	E20YQVmlFTlz41p3dfyG13igi/jAcLrIkCa4kja9L1EgBYaornpSfQSTo/q+rHzJ
	fw+WzCVBQ+/1bvtt3UCkUdwFGOP9mzhiulaTn2LyHDOwMNTgGkvQjv/NBmbg7VJT
	21Ce68wsRKL0hYlJzE85g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728938670; x=1729025070; bh=5vKmta+kteOpL
	PP5tcPt+e34gAjVWYRailpFgJHabZk=; b=WuYhC+WQQrSBnMUzFKF4fJEuF1ft/
	Ze7x/mAQy5dD+AShRFW3WiVgNPS8KaOFCYqAPjhOCq33ybZJBPBKt8rBfCjEG97p
	Qe2niOTn2ob+MHaxyNzoLAJ9/spPXO3Kgz6oJwWse6PtQrSzWKRXTZP4c8J77ll1
	qajCpFUle6L5lshZOj/MoBI/PrHW6/bDCkhJ04bV37vv57/cqjFHW0SXj16nOaGY
	o3ZHGvYNcWe9t+Tbj7zCPpM61hTMb9N+k4UVZl09hPcuP2bYC5RzzYEYjU5RvraT
	FBbtt77E7hMegvNpnOoaiUFCA4qgIPfYlYrYAsSFkFREMGL726aTAWbzw==
X-ME-Sender: <xms:roINZzVCvM0gCE-BmoTexKLj90y0ohvUjfw9ZkAlbHaxYzfkzRH1JA>
    <xme:roINZ7nqdQM65Fs41RQk5tFzt93_00DQU_aYmMeJuqGGH0-SLSvKS3q4gX7t9U0_N
    VyvRqHHU2pxnkqo8A>
X-ME-Received: <xmr:roINZ_Z-AzIcGEu3-Vi58Mz6YznzPDqRScWxVOmrPep_N10OX5GJHMOocHUW89WrRbggqyRJgzPM0Qw1J22bRb_40fVC8e-DoKLR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:roINZ-V-ORPhsVTtmjcfurJu2SSMm00B52pE0rrbXMkzmhF0XqRW3A>
    <xmx:roINZ9mJ3KTjBDx0cwb40XYeVihgt9FZwQb0VX5wdHNLyp10IVg2nQ>
    <xmx:roINZ7dDshiVfQQ0I16nPYovjnlqFrWKIpx1KE0xey3ljRdiX48LNQ>
    <xmx:roINZ3HQDj6KaS-AKn1qFhsG7Sr6MsTaDcA_hGNNaNQbd4NeqP57cA>
    <xmx:roINZyyZM6r8-Us5Q54I8AHdk3Zp7xk1qOjV4AJbJGyqgkvXs5_HxARa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:44:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] t7500: make each piece more independent
Date: Mon, 14 Oct 2024 13:44:25 -0700
Message-ID: <20241014204427.1712182-2-gitster@pobox.com>
X-Mailer: git-send-email 2.47.0-148-g19c85929c5
In-Reply-To: <20241014204427.1712182-1-gitster@pobox.com>
References: <20241014204427.1712182-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests prepare the working tree & index state to have something
to be committed, and try a sequence of "test_must_fail git commit".
If an earlier one did not fail by a bug, a later one will fail for
a wrong reason (namely, "nothing to commit").

Give them "--allow-empty" to make sure that they would work even
when there is nothing to commit by accident.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7500-commit-template-squash-signoff.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a7..4927b7260d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -50,33 +50,33 @@ test_expect_success 'nonexistent template file in config should return error' '
 TEMPLATE="$PWD"/template
 
 test_expect_success 'unedited template should not commit' '
-	echo "template line" > "$TEMPLATE" &&
-	test_must_fail git commit --template "$TEMPLATE"
+	echo "template line" >"$TEMPLATE" &&
+	test_must_fail git commit --allow-empty --template "$TEMPLATE"
 '
 
 test_expect_success 'unedited template with comments should not commit' '
-	echo "# comment in template" >> "$TEMPLATE" &&
-	test_must_fail git commit --template "$TEMPLATE"
+	echo "# comment in template" >>"$TEMPLATE" &&
+	test_must_fail git commit --allow-empty --template "$TEMPLATE"
 '
 
 test_expect_success 'a Signed-off-by line by itself should not commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-signed-off &&
-		test_must_fail git commit --template "$TEMPLATE"
+		test_must_fail git commit --allow-empty --template "$TEMPLATE"
 	)
 '
 
 test_expect_success 'adding comments to a template should not commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-comments &&
-		test_must_fail git commit --template "$TEMPLATE"
+		test_must_fail git commit --allow-empty --template "$TEMPLATE"
 	)
 '
 
 test_expect_success 'adding real content to a template should commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
-		git commit --template "$TEMPLATE"
+		git commit --allow-empty --template "$TEMPLATE"
 	) &&
 	commit_msg_is "template linecommit message"
 '
-- 
2.47.0-148-g19c85929c5

