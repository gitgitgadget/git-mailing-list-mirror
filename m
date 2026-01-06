Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA931ED9D
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706098; cv=none; b=htQoT2GdDKso6CdoDc9stWoQjqb+sikTw6dIaXwxm7J4Byv32nZFxdrJzBiGgqcZNdmrDGgK2t42JOgU6FAR+ifmkLWCZlvnarTnfaLjouT+/F6Mm1BT5F7EJMfibuQdXSjCCTWxcdi9ucZ4IFJIM08Z3aihSCcBl0rcrRsG4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706098; c=relaxed/simple;
	bh=EAyMl1POEkeSH/BF3pkAlwMolEKCl6nTALm3m808uYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQmcq/m/g123uxtACXTI0WSiF1H3dfk3cTLmHOuSTgW4sLqX1xyYI2YircG9PONQfTMWG1zaLVNQYxqbbme1QYmJB/hK0fdW8505q+fye4jDitH1tnacMXh1TnmxGqF0UHUksUwZ6r11YYXGd/EEvtGgbEDdvFUklqZPHTelLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iqVWe4D2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ms4hHUlO; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iqVWe4D2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ms4hHUlO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 7951813801F4;
	Tue,  6 Jan 2026 08:28:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 08:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767706094; x=
	1767709694; bh=TzFi/7g1SdDvI40lVlUhMM7r8LPetPQFRscNgR/T+FM=; b=i
	qVWe4D2oyKeh750wQDQ3X+JA5Oy3ZkjWSsuqTzw4SGoP+CLgsjVVnELMfbNlnp06
	aPiQyj88d/4/nSSaNDMhu+cxyKE8Leug8a+aAadjyeGSozs1qzk8j4xRMEikmJmE
	HzggHxNE13yHsTeL8eDPJwTh5fxZ9ySSVojTzv0Gm7KLFMGOJ6Htnbs/fG666JL1
	3chfiB431YNHIvpq/JjUF5bhwMWtcEZMrcyDn5xjy48iRbJ3yKLTmsYok7N5Asi1
	50YilCpn2uRoiXyCQTHLMBEXuqXu6mBDXFtCv+GksjBq/tmXUBSzpNvKjnCyhGsm
	e/DimMgjtaEWEAJtNXNuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767706094; x=1767709694; bh=T
	zFi/7g1SdDvI40lVlUhMM7r8LPetPQFRscNgR/T+FM=; b=ms4hHUlOYjVMhE27P
	jQ4eIymesJIx7E6pcaaJfxCQk2xqVuhSTILLPmgcZ1xJPEB9P4hSYE5qaxCnf9wD
	GFq+ZFYLXSukncBLBmBk6Es9ZVrarVbsOh/3Nl/6O0LPVvBhPYLE1I2ldm8qPNHl
	v+eexhForNM8b2+xGpHdP1l2Y58pLXd0bTGIU8c4iZsmOtFanO/VRwHokvge2PnV
	FsTPaBFuY57qUeISuY4xpPL1pueWJImxtwbmD1LotIMd/ySIuP6TwFISMBKcQoLc
	tes6P52KD0EHrIgWWTC5MpGAxPEKtJ/6VDea0PKUPMqGPkwb1d0diRP3fvjvxaTP
	cazAg==
X-ME-Sender: <xms:7g1daXmi0Fq1rCoR6s_KfShU1q5Ju0cLvs3sZ5h9vTGCA16VeVsdyg>
    <xme:7g1daQ2D7aqCP5wmSZD2h1kZqVB1aBIL3CRvQJjIdRHA1-9qLV4clUp_oNgfzLUBa
    evHWVq7BX8wGeajJAHGxfx0Kp_Ucqrl3hmmHz6XeLvLInjV0IaH410>
X-ME-Received: <xmr:7g1dabRwI3X8S74qhSIslZ8thQH02K6wfyGst1hE3BTM-ZuIzZXodxiwc_wDOXLOPvj4GmsjZiJEndW099-_Gsh2Nucrbh5G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgifucevhhhithgv
    shhtvghruceorghnuggthhhisehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjedtffduhfeffffgheethedtgfdufeeuieeuffelheejvedvieelfffgfffhfedu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnug
    gthhhisehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghnuggthhhisehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7g1daav9It1aNktQWF57sk32kihmhoQOHyO7XDBpwusmdStRZxEOtQ>
    <xmx:7g1daYYhOKVT_b6mmLvNPb-F0GMfb0Qt8_RKVn2aZfmKKsFC-aSSMg>
    <xmx:7g1daXuVJICmmaewkrVDkGGpginf9Z6CiTS2PBoKl8q7ubylcx1HLg>
    <xmx:7g1daSHa2MCjWa3rDUNParMyJTm9O2V4fur5tw1mvZAt98SYVttabw>
    <xmx:7g1daXQk4IsCpTHtg5xtUPX_E1FUf6xCHf0fZ6Zm5UkjhPP5zWEq7mq->
Feedback-ID: i4e2e486a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 08:28:13 -0500 (EST)
From: Andrew Chitester <andchi@fastmail.com>
To: andchi@fastmail.com
Cc: git@vger.kernel.org
Subject: [GSoC PATCH v2 1/1] t1420: modernize the lost-found test
Date: Tue,  6 Jan 2026 08:26:58 -0500
Message-ID: <20260106132658.798706-1-andchi@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161536.45384-1-andchi@fastmail.com>
References: <20260104161536.45384-1-andchi@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test indirectly checks that the lost-found folder has 2 files in it
and then checks that the expected two files exist. Make this more
deliberate by removing the old test -f and compare the actual ls of the
lost-found directory with the expected files.

Signed-off-by: Andrew Chitester <andchi@fastmail.com>
---
 t/t1420-lost-found.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index 2fb2f44f02..926c6d63e3 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -28,9 +28,12 @@ test_expect_success 'lost and found something' '
 	test_tick &&
 	git reset --hard HEAD^ &&
 	git fsck --lost-found &&
-	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
-	test -f .git/lost-found/commit/$(cat lost-commit) &&
-	test -f .git/lost-found/other/$(cat lost-other)
+	ls .git/lost-found/*/* >actual &&
+	cat >expect <<-EOF &&
+	.git/lost-found/commit/$(cat lost-commit)
+	.git/lost-found/other/$(cat lost-other)
+	EOF
+	test_cmp expect actual
 '
 
 test_done
-- 
2.52.0

