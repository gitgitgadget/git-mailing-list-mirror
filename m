Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB021A455
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034707; cv=none; b=oKMQAM91wvBPvd/01pmEz44GmwvcSmPQqw7tMANu4WdEej477f1kxFAT15aFCSDAAmvzb5Pq/vAWK/v5DButPkc2sJzM/tUsLVsN1fNAJxfPvVLSvVMf0O1WxlLE9/pcoskbP8waEjd4SUOpRCqk6QTD6wJMbmQew2xcRSIoMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034707; c=relaxed/simple;
	bh=9OECUqt38wxplEBWBGDDYEgCknOIH3ur+HF052hPWps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHMbLSC8S1PzG6d/ForsG4VTJ0VE1CA8bnybrse64v+Wgbibzz21n/mHe/zov3zl9pkaPby/JpZQxgEOlfHdBMemTex6Z3u7v7qchSmb/Z/RNlG1SJMLGV3L2OCwnoX7w5STavNr6eswuGIn7teOXHwqCaFxAIr273h6Ytl8OGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rk4vqitW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwQ7lhTj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rk4vqitW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwQ7lhTj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 89BD41382C57;
	Mon,  3 Mar 2025 15:45:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034705; x=
	1741121105; bh=c2PhsfayylElds0PfHrjO410mSjGGj18ldijpk2TuMU=; b=R
	k4vqitWbo8QUcO17QN2vU4emTGn2IfYFoByzQJ0DucCEaMzyQ7OT61bJVgCurN3G
	HTqgenF2HTDLXuMEMpYRbjxd8mAL9QOQJO4xc8fsCHVE6+DwFMFIaOdzn4458jPt
	oEZkEQ4BXDy5QEG6rlaajtpOYPajueQhWXOIsDTq0p7f14TRFo6U1ANbbsjYp0YU
	BGb7FPSm16RWT7tGmMQsJikx2WzpG5K8nJENOScFHJcT6GXIRPCF1tKktmdZt5lR
	YGkW9TOQhp0a7BcW/SLq4mbMDAQQtkyjX0zeZbL3/7nhzdyCMyv4JxOUntbw+Jgq
	k2eaLN6FpZ2leuUeuvKxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034705; x=1741121105; bh=c
	2PhsfayylElds0PfHrjO410mSjGGj18ldijpk2TuMU=; b=XwQ7lhTjGDG+krc9E
	XLRJF2e7C2mJUqBBOUiLpeutCxK+D/1WulkqForFormtedkqmW944VQeY8L/wRKC
	+9tKB/HS6irTPufIK3m4rJuZUlViv6RH186c99p5jc7VTBvyXCQnuoztogN//Aht
	YC9rCtAQpu0jNssr8rOUOyHUyZcGgQbLD/AgEHzNaUOMUhIKSVD36egXzOYmnEuq
	267Y2GQU6/862vlGPDdHD8+5AstYI9vr4ccDHSvRuTHAmmSxfMdTkmEs4FS5Tmyh
	8xWztSNriLUyUbiACHVFIdp39gBygb4Uv0WuhgekymJ7JRc6+WFxoFJAuCZmpC72
	7sasw==
X-ME-Sender: <xms:0RTGZ5Ps_EfZBKW3YqRyF2dQecyBs7buT84BcTT_DM5-P3OM1swoxA>
    <xme:0RTGZ7_otryjWcvP6X6IRMW1fSMoz0zgSslGWp5HJ8jvXTswLF50uCilfvGzv7m27
    MiyBfc2dQF-ZTEI5w>
X-ME-Received: <xmr:0RTGZ4QLcdgnUZzrqg6coWo38-nowNfgoLqQBbPfa4Jt2TND4GU9OEdhJtPptiSx4lQtIYX0JHHD-58Tor2naRIKkFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:0RTGZ1vrDRP080uuxA7s6tafZAnYWIdFV4vHHjYLeHIRbc8-PNkApw>
    <xmx:0RTGZxe8iLxRhDs1s1wBUVz6-1SUitr1P3X34jcEFpx4XGQU-j4MkQ>
    <xmx:0RTGZx1cT_c1mNKvkLak0eDYYyTSyJGoltRRRu1F-A8FjXKxtZXcRw>
    <xmx:0RTGZ9_X5Rw2JDyCCHHvNMtPLNKOfEskDWhFSXPvOS4jbaDOk5y-dg>
    <xmx:0RTGZ15ISmTDGWAY-kgBnfXmIu8TU152gMBpE7EsvAO-AsMyJmNGbmdA>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:04 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 17/34] diff.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:15 -0500
Message-ID: <20250303204443.360595-18-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 diff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 0a566f5531..ff0348e4a9 100644
--- a/diff.h
+++ b/diff.h
@@ -333,7 +333,7 @@ struct diff_options {
 	int xdl_opts;
 	int ignore_driver_algorithm;
 
-	/* see Documentation/diff-options.txt */
+	/* see Documentation/diff-options.adoc */
 	char **anchors;
 	size_t anchors_nr, anchors_alloc;
 
-- 
2.49.0.rc0

