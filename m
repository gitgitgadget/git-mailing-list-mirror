Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD72F1FD0
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078092; cv=none; b=ULinpbdJecmwUl+8KCf5woPRMutG8RrvmNKs/3q1AABjSsA0lkVaxLf7b0ve1U3wSm3WjFyYVPVW2nZULgJNuinIyKFMjcSXfuYR0ep39hdILpELS7OGBxrGy4gcACeb2LOOdLGxNm4T3CgrZ4zynENPS+lK28D2fdpPBZTQ9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078092; c=relaxed/simple;
	bh=c8avq/yRaMJ09/4jqpB5Z03gPB23H7+Js1mzPbOAikE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDFXJiruFqlJ3CKfdAt/rT/AEAlfobX50g9hU+A/nHw3QfUq9jlr76VU9x+BTaG1HVFa7fccbxSMp3JSb4DvnlbMZEb0RgtzmpQilkXd21pxmfe6/k4XHi9xJ7s8DEvFgXDtT33Cg0eWaQShHGfQwaOXcCdR/SU8jVmd40WObVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BM504wNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQkOwA61; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BM504wNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQkOwA61"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 11DF67A0220;
	Wed,  1 Apr 2026 17:14:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Apr 2026 17:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1775078089; x=1775164489; bh=2jHyeHAEzgcLOmbkEORjc
	nFrt8OxynmwuGYmA3D3c9g=; b=BM504wNRAbStGo8Yz9WPTc5GAYN0vPQETBRct
	zgs1Maq0TWfJTcSwCAe7LHtpuGgPUDJe3wvBptjhMmu7iy8ZdLQD2+zvm8Ff1MBO
	Kkce63QZ/3fatuQON3XerlMGh4Gm+GdMgmZD+d65GC1VMDUIBFubyCBZdEnf3MFy
	eMqxsaG5W7RF+fOKog46avfGYvmIiTvsomhE4mWhomO6y05DlJ2yMr6Su/ij2XsU
	mY2Q5F29sA1Bz9luAcdtulsg4cEG6ppXhEuYSn28RTliAPseWybSBIN1tZbwyRua
	4A6xp12a9qlG2bjs5gTxCNxhThsV0YYq1HRykC/efC8H7ZyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775078089; x=1775164489; bh=2jHyeHAEzgcLOmbkEORjcnFrt8OxynmwuGY
	mA3D3c9g=; b=IQkOwA61B6YnDFib1AUqwU7zYaWq1QEclX/pEO5qCMdLlt4q49A
	V+ERv1vWT8iMb1T76L3Esu93RPhurJXlFvP/wcN/qKQes+Eop0MBZ91jLqHGUcZD
	5/jJ0SY87NxcMX3CsAQALm6VujDAruClJrlQ9xU93bW6mV2UWDCYZdv81vgmnXuZ
	w6hyn7v0KPeSWPX1HrdKLYRME84bk3DVmtXYI8VpZ2EZcrxoGKJ9a8EyIVtTcFrv
	4BRV3Upj/JCTpa6ZIWTwQcBgrhlp/3JCjd0mS7jEghVwcfHUmcaBikKBXlTD5iZE
	xs4MYgInNxzq1A9l7yJjaMWLZqCXKeRaQ0g==
X-ME-Sender: <xms:yYrNaQfv1jdCOBMh0tlsCGE9KiFVzrxMKfhymLeX1zf6-QXaM8uxPg>
    <xme:yYrNaYOvSyaRDClYyEu5M5sD8tqz1vemSnWZB6NUehLh5cBAMxcpDowBLrT3BdfWF
    UiBc9TKtcLnh4AAquEzmxPyQK4lW-ZxLTLB8wEdv0FRHiL8mUIkJQ>
X-ME-Received: <xmr:yYrNafJi9ujg-SyReJ8Gm26SLeBj1IeHC_ScxpGUX10650d6QWOS27Z420PCLafkKBHXYdzbSTYenIcJ-KTUobd9qwiZyZXHK5LvagDMoGo6KpVuIWvqdYYJAo_u8oXpEMhKE9wthICTfc2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhm
    qeenucggtffrrghtthgvrhhnpeefgfehkeelkefhtddtfeetkeefudfggeefgeetheefke
    ekudeitefhleetkeefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yYrNaRHWv8hR_V9jQkv97P79wvV7-XwTzqqG08UL4Rwz0-S8EfyQww>
    <xmx:yYrNafToc9MSiDYXGeN7HmMk6a2VPnC5OiKgMn2mWCeUEmQmGOp3kQ>
    <xmx:yYrNaVFTLSIKzC--8vaKlZORH53IW1zuQq-j4ajPy9D9R6x2NjA7gw>
    <xmx:yYrNaT_yZy4PdZiqyl4KMz7hGaYYY9-Qcvm6331WQMk9SGK3R55xqw>
    <xmx:yYrNab0My2P-w46JnyUrmTjgba7o92GgBxTeXoZhl1v-OHMtGhwlgpsd>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 17:14:49 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] RelNotes: minor typo fixes in 2.54.0 draft
Date: Wed,  1 Apr 2026 17:14:36 -0400
Message-ID: <20260401211436.489478-1-tmz@pobox.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/RelNotes/2.54.0.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
index 85b15284f3..4ce30d9d5b 100644
--- a/Documentation/RelNotes/2.54.0.adoc
+++ b/Documentation/RelNotes/2.54.0.adoc
@@ -122,7 +122,7 @@ Performance, Internal Implementation, Development Support etc.
 
  * Improve set-up time of a perf test.
 
- * ISO C23 redefines strchr and friends that tradiotionally took
+ * ISO C23 redefines strchr and friends that traditionally took
    a const pointer and returned a non-const pointer derived from it to
    preserve constness (i.e., if you ask for a substring in a const
    string, you get a const pointer to the substring).  Update code
@@ -221,7 +221,7 @@ Performance, Internal Implementation, Development Support etc.
    many source files inside subdirectories unaffected, which has been
    corrected.
 
- * The run_command() API lost its implicit dependencyon the singleton
+ * The run_command() API lost its implicit dependency on the singleton
    `the_repository` instance.
 
  * The unit test helper function was taught to use backslash +
-- 
2.53.0

