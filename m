Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0982226D00
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135663; cv=none; b=oiS/MtMgZIuxv1VZaVY+J2AT2U60yGEayQYtOzAiuGiOdMB6UQftfnGsL3aUXp9H+hPH//9haDBOVYmZMERQkzG8rtISvZrI1HQJjT8jMTMBetI0zpF0X8P7eK20T45pISISQfgbI6taVss2ERHtxh6PnZQFvTWVJ87Y1DIjnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135663; c=relaxed/simple;
	bh=v4jhb9TrjkvZR87VylTvWloVFAcGDa4xDojYZoEH2xQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oszFLcXxXEw0whSBEGWpwYZWZ1Z6u6vThBwLqBwuxcDytltt/TL6jt+o5JhLjcx6c/Y/HkjJYC3QU4zMACH2Jku68ilTp60sDdcVocb+jsE3eQzQAWsLQE2mLrocNSCfRyK4gYQI4y8tz28GR7lOjFZZLQ/mFs6/B6pymzDC+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ld/Fagga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRgCjbRi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ld/Fagga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRgCjbRi"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D47381380FC3;
	Thu,  1 May 2025 17:41:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 May 2025 17:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135660; x=
	1746222060; bh=5vKmta+kteOpLPP5tcPt+e34gAjVWYRailpFgJHabZk=; b=L
	d/Faggax8vEzto1lA+0CxAcBbo0Sbv7ohpKffj/A95AWatGmh2Fn5604tiHx3kaK
	NojTilo4T7knV5cTfh4j5heDifGZYUAfWOMm9s7S3XGI7xlsvmEgF568oyO48HVI
	lPcVNNlCr/sqCrK3I8gzhGn/6OA8RyKZZUAvX793IML7LQry0ylKK/gxR95sUbV0
	SPu2LrZwDJbRsOoI+MNUBJ+T/N8cP+9EhFskzENUd2+3JfmKbFI+6AZvSL4HNuoJ
	ICRzdquDltiygztXhAYMbgJhIOlCgxgM6tUqqis4rteamkEHXVNQ0QyUJjiciizh
	dLVk0ZNQCDn8I0F27VETw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135660; x=1746222060; bh=5vKmta+kteOpLPP5tcPt+e34gAjV
	WYRailpFgJHabZk=; b=aRgCjbRiJFwMtdXMT3ar57J6utsSNt6l9K3sszJK7rTy
	z4fAXn8LfuQRQc1KAZcToqJBm9xWPwaQUpmBhw/iyD74fMe8niLRa+rxbJmkgPkE
	u2KE013gfj9f0CigjXuYyQz5fw7Rz1fjn9XfLJpDrz0Uj/9gw3PN9otJ2bZgkt7E
	+feHP2AiJBoy//CZTBtT9L66ZsIEMG+QqccUl8vnYxN68lvcQ5V+P0DFcdNRICC2
	zN7G1Rn5lCJCmqrbKsrOb/DKVWOPWNu6Ipg++gvceqfgZqT5r7AUIpWjlyozZwZn
	xfs5FmR8rFqyNHBRkzLzTUmqA2Bm8TF5mr8xOLyTTQ==
X-ME-Sender: <xms:bOoTaA8eDsMP6TkOhywUmaTolaO-kMMNwD1BJ9-aIR-N_bCuV7IY5A>
    <xme:bOoTaItizru1zqEmOhJG9O3-V5pa9qQ9-JUdaNEMOkQLcc4rA05CJUJe2bWcwHMnk
    7TfJXUelpFdihL4xQ>
X-ME-Received: <xmr:bOoTaGAv7byY1TVBvxYu4pOL4uz6DleIsGX54y81R2dfPNMWobeP5e1vGXdtaYNRSOfXPxoB8DzozfHiXJLvEWNXCn37wx9U95_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bOoTaAfY8Lpwoo4j9kSC4XTZcdQn2gSt1BBUWbWCwdPFb5xBUdDWJg>
    <xmx:bOoTaFMJWm-J37hnJbRUsDIfcm8FXOFnA_7wYC-l7GbcEBIE5_hYZA>
    <xmx:bOoTaKkmIWFqa-aQ6x74NOYeM0J_cd_2oJjAqrUS9hcH7TVZZRET3g>
    <xmx:bOoTaHvdQsjMJIr0MQgXDYzYCugF6BnoVPVHhjfNxE3x2HAhJX4eyw>
    <xmx:bOoTaM9rTposKWUeNPz3cHQkBxbYEV15lUU9QNYrxdfMXgQEMGFtUPaA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:41:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] t7500: make each piece more independent
Date: Thu,  1 May 2025 14:40:55 -0700
Message-ID: <20250501214057.371711-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501214057.371711-1-gitster@pobox.com>
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
 <20250501214057.371711-1-gitster@pobox.com>
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

