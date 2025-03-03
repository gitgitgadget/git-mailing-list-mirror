Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95668236A68
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034700; cv=none; b=PV0W5aVh9O2Bs9rcv8xuW40t/3TE23Osp1F1Oj1ooA4hTF/FGyfWB4xT/9WRtGt3MNR2NMUDIjNpNO1DT6lvySIfsZZaJyl+KhOIJKE/x91d8OJFyJgEKvy/tAbhvwIaRedq1IRjOixp0dyeC44Kaq0n6r2PL7YnvARw6x5N4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034700; c=relaxed/simple;
	bh=lydPNX/2rHM5Sz0V1D1hy2fKHzU5+V1KkGQqcm8eMWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA+XKinPj7MJczk5tzqgsps5/Y6ejQOsttU35786f5ERo9tP8re2XgWIC3thT9GtfQknbBw4gwXW4OETk55eDm7b2nRVTmGd4YQEh03O3dQdv3o8bEyU5aNPWjl+QIlL3ZFwlaYifbLfPTB6msOPmBhe8X5DsBTbUWZMs0+wqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SnVlxhtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owkcHrAB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SnVlxhtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owkcHrAB"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E10051382C5E;
	Mon,  3 Mar 2025 15:44:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034697; x=
	1741121097; bh=y/cCmPjMejPf2Qu00K2YlMT9+p8hmiExtMLxV/EjeHk=; b=S
	nVlxhtLlQ8Q0+gPZCfzwIF3sfbeHdkr9dMFqsd2o5dZLxzs/G+TAYArIxbURC3Iq
	NP4sWGDB2WF7sx/VZ1iGyNJCQAZsUNUXQBo4U55BeL/EMHZSwopy47h95jyWNJ4Q
	hWAsi3J4OS9Cif9p/q/bljW7+jLmZ19gxSOQmpxMiBIx01sPwSWIdrYw3DyLG/QN
	xh5SkggMYQdDz1VCfiKTWzokJAJoZ6B4uz0oSINxsZrubQnGRByK4ERx94QrFWGR
	QUKgGHkYBKR7GPXhdGZRrfs/nbu5jsmHNEX4mB+q/sbkD2jiQequInwhOMadcSsF
	qTaOPaE0FOB3leIgI7KvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034697; x=1741121097; bh=y
	/cCmPjMejPf2Qu00K2YlMT9+p8hmiExtMLxV/EjeHk=; b=owkcHrAB81JD5JzCn
	ScZQ22SrbpkVHKs9uhUz8kKTkgSZW1+qMv/Gh0mqiT/LMvG1b4BfohRL/uZpTpC+
	135Z9Bhxxoe0m9BbMxv5WZb/MfBMprR4lGUDvDy/6E4tVMhwVaCSrnCqIE94pAEf
	voNbj+aM/rfvk0F4yivOCt3JtrDc6k49m0HdwiM03iocOqzWUhPFN3oEl95NWo8A
	u0+dzBAj8bIp0046bvC9C2dGfadW0uWj/ujmuAXRFujC74OBWKddmePFf8e8GfdI
	YMzCPsji6otRmNBqKwqcH5KdgKMjhRVYHUfMZB6YTabTaV/x0W9gCh7BCLZibHLV
	fLyvg==
X-ME-Sender: <xms:yRTGZ4VbqYMivk-7I19K1zlNtNSRMaWcZ6zaq7o8q4IqIwuF25ks4g>
    <xme:yRTGZ8mR5zM3p1nXrDG-tIt61kHeWdlAIwjl5PXpTlB_IMj24G48Q2EUM-TpTKkyE
    XpvSZNphqG4aohAAQ>
X-ME-Received: <xmr:yRTGZ8YAQNFscrXEm-Jm-tEGhpIBQAq6tbSFpxK-72xzUbQQy_FxgGvG95dey4qEb3CsYtOsPVCdfpW9Cs5hreOEBoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:yRTGZ3WkXUgZfuvjT1pzq2GT7EYgjtxHZN-_9kIrkTxroUjUCv80xw>
    <xmx:yRTGZynovz_-WQomKM88Eyo_gIEN49-7mD5WyKBxahATnsDb0CDuRQ>
    <xmx:yRTGZ8dL_aPCPd56avYV1-t3-42dmHTvFlSI7AGiU_aMcYraWylAUQ>
    <xmx:yRTGZ0Gf_0QkFt2MJWI8Fh_xq_7BDDWQ0bnXbOWXeD01SNkgjg0H9Q>
    <xmx:yRTGZ0jDIuiwXHP_ibrPT1WR1oUQu-ETd5fcCSYNRXaGzjWLS7SXk4Tv>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:57 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 06/34] CodingGuidelines: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:04 -0500
Message-ID: <20250303204443.360595-7-tmz@pobox.com>
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
 Documentation/CodingGuidelines | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ba047ed224..a0e7041c54 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -44,7 +44,7 @@ code are expected to match the style the surrounding code already
 uses (even if it doesn't match the overall style of existing code).
 
 But if you must have a list of rules, here are some language
-specific ones. Note that Documentation/ToolsForGit.txt document
+specific ones. Note that Documentation/ToolsForGit.adoc document
 has a collection of tips to help you use some external tools
 to conform to these guidelines.
 
@@ -755,7 +755,7 @@ Externally Visible Names
 Writing Documentation:
 
  Most (if not all) of the documentation pages are written in the
- AsciiDoc format in *.txt files (e.g. Documentation/git.txt), and
+ AsciiDoc format in *.adoc files (e.g. Documentation/git.adoc), and
  processed into HTML and manpages (e.g. git.html and git.1 in the
  same directory).
 
-- 
2.49.0.rc0

