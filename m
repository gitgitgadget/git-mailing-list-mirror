Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA0297A41
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076601; cv=none; b=niiCbL/qqvJzJlL04Mkx9AfIwzOUNYmN3YtE9ekiXyDbDadMBIOnCx8pMBx/RvGDDag+fLyccr3z7amavMkaUwVQOHT3tWjGhFdKG9BqgqOLndzTiKmjXNhpdcqRZipV6a4Hau228L/wGhUoCL78L8uTNM1U7APSm6dtCtnUaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076601; c=relaxed/simple;
	bh=07Qv3e4wKlqqZ0IpQQDF2McfpTDs4jZAkiLdV45X/Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy6iDdIoeKR74KwbrDvysP0H8UjkMWKREdFl4/Gzq0yW4G2CzOrie3zh0egyqozZmGcQis9BbCwId0jatyyQOaTDr10c/q5nfvdtkvSl2aD3JNng8M+jvXgxoBo52mxDrnxLVHz9gzc80YF5DIGUPUspitj1RAsEK4yQkmKSiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JeE3750r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFX3lgYl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JeE3750r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFX3lgYl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B2D5E13800A4;
	Mon, 12 May 2025 15:03:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 15:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076598; x=
	1747162998; bh=hQgXIAMmj5OeGLDU/zU0p+oFRkTz01qTckQCbPPouPI=; b=J
	eE3750rhhIhI9/GAfEpIYCgp/D+5hcOM3wnrItkY+e69KMCah0VYY91dmTOqaLrd
	uWW6EnGnAKAg94p7vD/b4RIzM+qshdgBuIbpVRcrkRbTFJNutRYCoYcooHbT9cxh
	Mv9wcohWVdNudxazQRWz2e2Fx07CBGcyQsDIRbi0E/OIuzNVU7xP5ZCMC3IHUphd
	FSpjQF884aozn7W6MZOBUjFLf0Wwm8GTx0FWp3oUhObElE7SX6giorhyRKG96q0b
	7j6V1ZQ6eCougug5hmJWTF00p0dQo5zG2eYclC4hXCFFDdLUDhgtdry1HeVgQfTJ
	PK/2p3FQg0Z2VepapwEsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747076598; x=1747162998; bh=h
	QgXIAMmj5OeGLDU/zU0p+oFRkTz01qTckQCbPPouPI=; b=lFX3lgYl4nqp4ObKv
	EwsEDBHkw+jh6bwmaDRFNoPFC4Bzd0GwEMJhQLsB2cZbfQMw+zcF0W91A14LD9PA
	NsTPa5RWfh96ACLnAMzqrwqAaoB47eoJaXSfmL7rVKbWKdND25xiEkZPtPXtehTL
	YcMJTo90vwBt2akOt2abqgt25wq6LmR1sFsnX9WFjubMzeoeCmi47ZSVlY1UfJ57
	tEOQWDVguJmf7pJwm3bK8v1uFM5HfHWM54pObzKwxXhBUCZmtcRNJHgVJH8xEbPh
	nydqxmRp2CItwbSbF+Ez1nhnFID8hqxwL6Utq57/dPhrnA7hifkfnqLUd58DPfB1
	9SPXw==
X-ME-Sender: <xms:9kUiaKFMR-GcsnaKauFpovwkJQnOUJqksNPmzw6AFwbRixGtW-nmGQ>
    <xme:9kUiaLViloR26opK_fRCOjfYPL8PyN6g-hN_45l8_5cSn_VIOUNkJlZd1xoHtrpU2
    pRWT6Q106XI3Fig8w>
X-ME-Received: <xmr:9kUiaEL98nzigUUOfNyFgEJJCy8c8T8nQdFJX1ZvAbFmRCWkRI5Rh6mhS-Adb55QgSpWrUu9grzKFDxAJGc3dZMAcLTR-7Y-a5_y-dc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9kUiaEGNunzg8kE3co-z8ud0iwxql4P1kQFk3adwI0GSqgSAvAGnIQ>
    <xmx:9kUiaAVPhojvy4IOj4VLHM3IdztTnq-qcjkQndj6ksA8DTi9_p5fJw>
    <xmx:9kUiaHO_sHvZ2JIqs0QQim-7zyDv7yzPSU6LTBNqZeFraGII3VGCSw>
    <xmx:9kUiaH1n5CC9FfkhX6I4-E3hD7kQsdwocjxen6nPxT5N_4DGjOGuEQ>
    <xmx:9kUiaLBiX9tLB_I43FOi8GNVJXGw1PqSpKftmJdqEMz6XbTtn19X-VjK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 3/6] tests: prepare for a world without whatchanged
Date: Mon, 12 May 2025 12:03:08 -0700
Message-ID: <20250512190311.1451556-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-674-gc1e4f99c0b
In-Reply-To: <20250512190311.1451556-1-gitster@pobox.com>
References: <20250503005814.3030099-1-gitster@pobox.com>
 <20250512190311.1451556-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some tests on fast-import run "git whatchanged" without even
checking the output from the command.  It is tempting to remove the
calls altogether since they are not doing anything useful, but they
presumably were added there while the tests were developed to manually
sanity check which paths were touched.

Replace these calls with "git log --raw", which is a rough
equivalent in the more modern Git.

This does not remove "git whatchanged", but we no longer have to
worry about adjusting these places when we eventually do.

Helped-by: Elijah Newren <newren@gmail.com>
[en: log message]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9300-fast-import.sh       | 12 ++++++------
 t/t9301-fast-import-notes.sh |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b258dbf1df..4dc3d645bf 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -120,7 +120,7 @@ test_expect_success 'A: create pack from stdin' '
 
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
-	git whatchanged main
+	git log --raw main
 '
 
 test_expect_success 'A: verify pack' '
@@ -279,7 +279,7 @@ test_expect_success 'A: verify marks import does not crash' '
 	INPUT_END
 
 	git fast-import --import-marks=marks.out <input &&
-	git whatchanged verify--import-marks
+	git log --raw verify--import-marks
 '
 
 test_expect_success 'A: verify pack' '
@@ -652,7 +652,7 @@ test_expect_success 'C: incremental import create pack from stdin' '
 	INPUT_END
 
 	git fast-import <input &&
-	git whatchanged branch
+	git log --raw branch
 '
 
 test_expect_success 'C: verify pack' '
@@ -715,7 +715,7 @@ test_expect_success 'D: inline data in commit' '
 	INPUT_END
 
 	git fast-import <input &&
-	git whatchanged branch
+	git log --raw branch
 '
 
 test_expect_success 'D: verify pack' '
@@ -882,7 +882,7 @@ test_expect_success 'H: deletall, add 1' '
 
 	INPUT_END
 	git fast-import <input &&
-	git whatchanged H
+	git log --raw H
 '
 
 test_expect_success 'H: verify pack' '
@@ -2066,7 +2066,7 @@ test_expect_success 'Q: commit notes' '
 	INPUT_END
 
 	git fast-import <input &&
-	git whatchanged notes-test
+	git log --raw notes-test
 '
 
 test_expect_success 'Q: verify pack' '
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 1ae4d7c0d3..e62173cf1f 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -76,7 +76,7 @@ INPUT_END
 test_expect_success 'set up main branch' '
 
 	git fast-import <input &&
-	git whatchanged main
+	git log --raw main
 '
 
 commit4=$(git rev-parse refs/heads/main)
-- 
2.49.0-674-gc1e4f99c0b

