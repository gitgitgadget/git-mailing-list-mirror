Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62B8BE5
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016835; cv=none; b=gE2ymqhz8wbxQ+MxTUGAaCiMsw9ltmB3XRfFk0jzJLdjvSj854nPvzQ2CxuZSSC+fhgQZ6eJfB3PNiHPp1gkuNqqtH3IJyoKM2Yd9PB22uM8y/csaZnMXHZbvmZzKE6ehAkbs9RjX0hhe7w+WNaVSS7TH46eydwP0Or9sTzBhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016835; c=relaxed/simple;
	bh=XiRWv22FfDcK2f3DhyIl8I1xHxuLRFWP77GQlPrQMRY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUGViOre3wlCt7f5K0z0eu+iUqNqm0gH/XwuROPCCj/iXH6neMUFrEYupjLuelwBrk9Z3qfPkk2ESu6s0Xo8kIWixlOo8TKAiiGevktU2whbq53RAQLN4QBoP2Ttqu+j9pTSRBVvohLVkdv9dPk3cNGG0E2/Cz50484NSSyzaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=N2TiWWNh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="N2TiWWNh"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712016830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GtRfJcTq40UnhofOB9ZXbS/h9YCOUIS1ORQlEq0rW8=;
	b=N2TiWWNhQ0F+k4gp3H03t9X717sZfU0SFxc+lBUgvZoPAsdXd1o5KxkcamI8nRoLIHZAl1
	5HQdQmY9CGZJTaIfvxb85NV0M/3H7vDDwd8DmN8xx06ai7qnRi6b1PJtN4JXPid+z6m5HO
	juoe5nrkODYxC+WcIvl75WmOXxIk3KKUunxUnA6PoO5lEWdzzOuPeh97xISPPcOdWTgs9k
	lfDFMga5z3b6a8wfdYttiHEBA9KEul5d5PwvyowJjmwuw0C1jrsUf+2YU12ITbuaEaRdCJ
	vLleXpNkUKht+9qZ0++GKe+zLnzMhogXnwTcagunuEckcksHvbuPWWDJm7ZODQ==
To: git@vger.kernel.org
Subject: [PATCH 2/3] t4015: whitespace in diff.wsErrorHighlight and --ws-error-highlight
Date: Tue,  2 Apr 2024 02:13:43 +0200
Message-Id: <cc9d9e561d7cf49eb9d43e8351f9dd9509792af0.1712016667.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712016667.git.dsimic@manjaro.org>
References: <cover.1712016667.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a few more tests to cover the support for optional placing of additional
whitespace characters around the commas in the multi-value, comma-separated
values for the "diff.wsErrorHighlight" configuration option and the
"--ws-error-highlight" command-line option.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 t/t4015-diff-whitespace.sh | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b443626afd72..22f4f3bba7f1 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1088,7 +1088,7 @@ test_expect_success 'ws-error-highlight test setup' '
 
 '
 
-test_expect_success 'test --ws-error-highlight option' '
+test_expect_success 'test --ws-error-highlight option with no spaces' '
 
 	git diff --color --ws-error-highlight=default,old >current.raw &&
 	test_decode_color <current.raw >current &&
@@ -1104,7 +1104,23 @@ test_expect_success 'test --ws-error-highlight option' '
 
 '
 
-test_expect_success 'test diff.wsErrorHighlight config' '
+test_expect_success 'test --ws-error-highlight option with spaces' '
+
+	git diff --color --ws-error-highlight="default, old" >current.raw &&
+	test_decode_color <current.raw >current &&
+	test_cmp expect.default-old current &&
+
+	git diff --color --ws-error-highlight="default , old" >current.raw &&
+	test_decode_color <current.raw >current &&
+	test_cmp expect.default-old current &&
+
+	git diff --color --ws-error-highlight=" default , old " >current.raw &&
+	test_decode_color <current.raw >current &&
+	test_cmp expect.default-old current
+
+'
+
+test_expect_success 'test diff.wsErrorHighlight config with no spaces' '
 
 	git -c diff.wsErrorHighlight=default,old diff --color >current.raw &&
 	test_decode_color <current.raw >current &&
@@ -1120,6 +1136,22 @@ test_expect_success 'test diff.wsErrorHighlight config' '
 
 '
 
+test_expect_success 'test diff.wsErrorHighlight config with spaces' '
+
+	git -c "diff.wsErrorHighlight=default, old" diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
+	test_cmp expect.default-old current &&
+
+	git -c "diff.wsErrorHighlight=default , old" diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
+	test_cmp expect.default-old current &&
+
+	git -c "diff.wsErrorHighlight= default , old " diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
+	test_cmp expect.default-old current
+
+'
+
 test_expect_success 'option overrides diff.wsErrorHighlight' '
 
 	git -c diff.wsErrorHighlight=none \
