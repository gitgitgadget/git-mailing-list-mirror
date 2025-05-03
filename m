Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAB3B1AB
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233904; cv=none; b=EDB+D0UIji3rbqCGBtfC05Xhqtb0+xhs01Il75yWRrONZcc4wSfc2xcDtpfMy4gLJ8ko6w1Wtm4QnXWuoZbIIq5AbEp11z5CJg37ZIOlyZEixwnJzcbuV7lGCQqw47mB+zaDX1Z4otCIjaJbvZeUdewQ/Dn7kR67dijbaFfx6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233904; c=relaxed/simple;
	bh=6teCv13Pt5L1RPIKf1uDy5z8maRh2ffUlLCPmqBUDMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epk3cld9YJ3xFOnVeDalogid3I5Tag/L+urFx9vUTp7LnlDnzwR9ZIMVZzz3Y46SjnmNR9pclfi3rf7JI1edLUw3s+6YgvnSZX12M/hZQl7vogOgXITxwpdBySEQ7874keNhY7EBDh7NQaSZbTEMhefqpdZbu9gXh8zrtgt7zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JgNZf2Ti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNKGdMk0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JgNZf2Ti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNKGdMk0"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98BAB11401ED;
	Fri,  2 May 2025 20:58:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 20:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233901; x=
	1746320301; bh=vpYc0QLW9xEHjoy1EFX59sxxeKkqsxLwktih948Xs/s=; b=J
	gNZf2TizDSmQXTIBK640sUDsBBE/oEBIxPT2OrAMh10vnFAIRZBBa9vNxDaA41/N
	qr+CpWP9HFzWe+xpXu6J/1N+JnXLgLORYA6W1kcgJMAslztQw7Qpoh55nuev2WTh
	uLSMq3ainFybtHjPCTrQf1m2oks4+JcXAST+tpgpQ0YO3q4f2Q/6pEdSbk3DDqZA
	QALNnb6c4Li8xGV8l/cBGDHB/ESpQlm+dskFrHveX2/EiW2ENte2QejKZjrZ87As
	WgQuZxQiIzYkDJxkcho9gQlBhofVsKEhhzVgn9M7EG93bF4kLE9IPSQaXNBv8KEc
	r51GIH9iDiJPJ5cuq7c5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233901; x=1746320301; bh=vpYc0QLW9xEHjoy1EFX59sxxeKkq
	sxLwktih948Xs/s=; b=JNKGdMk0LlO/MuArurhSy7ZNtO+TlrLhQdqzuWvzpe54
	mx6PHXDKjMionxEC5d99vKvgq+nB10mY3Ty+RSy8Ex+Ol9Ww/G+Th5fHEAy8M9A9
	NB1uzPpBoPjIBI0QNCex70AP0BtlSyhTRgCrR1Z96LKhhIEQWkSl5sgAs+2jt729
	fbwsKdN7l83x/HV2P83D91OuQuG9H4szB3Gb43V3Gjzz9WZshueF4qFCHMl6gI+E
	CUjceZvJ39PniwVWqi4tIRqwkXbF80DE9IuO04Jm+tbvbRHAD7fszUNPTMUKsYft
	ReziaBdSAe2wpxNftt60AuPhzZD2LrGH16BCP5VU8Q==
X-ME-Sender: <xms:LWoVaKNqXlxB1uQqFTtPUkv8SfcD6bN5kFmADGTBTzNPDxxV6BJ_mw>
    <xme:LWoVaI_1OxjKC_1kkpTTr-0qVQGizIsaXm53Uci0KAbUf0S6Z_4paRXMPHvwPnT0h
    BPCIlGqbxbXBVlboA>
X-ME-Received: <xmr:LWoVaBRgWonwKAsOQzRxpIlvXsngG1D3haYLpsHhUzuhtQcVuUPl3LkHDuSoT0YxSpos8S4NDh_DL_PdTkqoqG7kS2R9iAQTXK8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LWoVaKtMIN0VSCA9bu5ZUJCFeHlesYH5FbRSUkf6l-82_31uaYnsJg>
    <xmx:LWoVaCcLil9MLc_qFQwwRhs7MdQNt_HjcXDetP2XU9KK-9cCFLyEXw>
    <xmx:LWoVaO1lpk7Tv_Wb40Lsjyot1vqmxE09SmMqMeNOxSdk74nW3IACdQ>
    <xmx:LWoVaG_lhetW1-rqUM5xZED3JxNavvlwWCrtyhFQ0LkWhPCMNEyWkQ>
    <xmx:LWoVaGOSxM6i4RZtCjLAp97Zwm5BiHxhoZ80WrjTqxLEmOkJLb0mjD3v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 3/6] tests: prepare for a world without whatchanged
Date: Fri,  2 May 2025 17:58:11 -0700
Message-ID: <20250503005814.3030099-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503005814.3030099-1-gitster@pobox.com>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
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
presumably were placed while the tests were developped to manually
sanity check which paths were touched.

Replace these calls with "git log --raw", which is a rough
equivalent in the more modern Git.

This does not remove "git whatchanged", but we no longer have to
worry about adjusting these places when we eventually do.

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
2.49.0-601-ga5925c3955

