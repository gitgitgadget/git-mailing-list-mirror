Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32723C8DE
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034709; cv=none; b=HvKix95Zz4pHTmeJfzJakk5kDtR9JSUv5k1z6yLG40MBscF1WBgMIxgrp+dQtGp+zfTs1rUfiTJGC1E2Vv/o6Bn6KtJXW96cqkNozLekYF30wRFKMpagvtNaFQosmPDSA6AA69qCEeMu9WnycRKwA6z0LXlaAX32vk1QwLYjplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034709; c=relaxed/simple;
	bh=0lo5lNbo9vRJRraAx0ccxDhd4XkalthHhUOkcmEbjas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsnc34904nojscnGw6qDorfg+9KBTgA9n05fm5heZVN49klRYrid7Rjz1Oyu22VdJfy4SsMi5Z58VO2MrB6IGEpLk3uVHfno6iHLbQQ112lG7V+W8nqPr7FOpDFmgCVdg6wQlDoHDp/hxmOPvD3HVGn399iWnZ7AsOPClg74Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c9UVtIiX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VBPbEvq4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c9UVtIiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VBPbEvq4"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 829941382C59;
	Mon,  3 Mar 2025 15:45:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Mon, 03 Mar 2025 15:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034707; x=
	1741121107; bh=Zf8yEbx/Mwzo30opGyjByNBWf5n5t/Jkyi9wGAbDG0A=; b=c
	9UVtIiX4ibogjL97LaVe7Wl5zt8v3kmXBRFwJsmXY1T0FtndyoVZ41QJ21ezt1xv
	AEL7nnxS+hvkRpc3F3yjuY+wumw7m7Ndfa7oJe1jTOprE3vVagltXWzr8RLUYl7v
	9qLw9plvoCWqgQTY+RXt8qcyX0Vy4jKRsWSnP05eEFjn0pRm2CNSxbSD8XM9xSPs
	QW5HsC6J7XvO/T+pyOakwYA/9vVwEIQy73EyTkRuYTEJAy6YmBdNg1mrqysgwgVU
	RRsboXGDFqsjuTHRYPNtTYiR5PqRr4tjQGeWINiMDBRcFzPtHYpT4g4eYHv5cuyB
	p5h1dxOyR5gx7d2KbVbKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034707; x=1741121107; bh=Z
	f8yEbx/Mwzo30opGyjByNBWf5n5t/Jkyi9wGAbDG0A=; b=VBPbEvq4BHtMnsLkF
	g0+0Yd1irrhbPEGm0zW/egjGN3teBOci/VD0VsoHxaeAjcm4XB0Ubznlp9Mj6J3V
	h86j4LmC6NgSsamXX9Lx/u2KiDryPOe+7A5YCBpUkHUe4mvUm5GgUlo31NNHXZlJ
	ktuiywJ6aJFhtI9YiGbrQslR7VTNOn6ocPkzXw1wz5dIcdqWL1CRNgHdHV32EKHr
	/rX10LyJumMo3IKGtDyb/Ysxw5TBeFsqjjmGX7q+u4tiZ/Wn18TyMY2ziONQFKF7
	WUHEveUfDnQKC1YX7xOo66Q8+Rgn79qNDqGbKERcdVfZF0E8WEYERAvZ1jL+M+TP
	CduEg==
X-ME-Sender: <xms:0xTGZ5_uudr47zSPaRB1_nCxkrju1SCfpgGiop0etifiEAIw2aES7g>
    <xme:0xTGZ9uPF1KbNDrUIMoxChb5jLGwkNndprso9u2X8bQTQ2tqm2ZxzB6NjhOXqcTca
    j8MugUwOM6k4V7uwg>
X-ME-Received: <xmr:0xTGZ3Bai57TyRx9d6MuaOnS5meamm8EhYjfiOXDwyDPim3fDJ7lAe41_Rx8aWTqyT6UGc4sc5Yw0tAW1Oe7cTtKPMw>
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
X-ME-Proxy: <xmx:0xTGZ9eNuXhHtYQYsG64kXV6q2tkYmD3dP3dibc_MPYlgOQDInGD2A>
    <xmx:0xTGZ-NS6IysKJTNhh0abeCIFaE2IEpCA5pnGBPhU9hdqB0sxmmN2A>
    <xmx:0xTGZ_nYjX2G1EX6_BQnMYUiIkqLCJ64Pd1lhyQgvksrG5uiuUY86w>
    <xmx:0xTGZ4upfkx9j-VBj-xZT3fhnydIQFmQcvY9W54ObK3A53Ods0x_vg>
    <xmx:0xTGZ7oEsTFcDd_kviAFNhkmaEaN6AXSkN1DdtFm92gwbOtWCDIz3slE>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:06 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 20/34] list-objects-filter-options.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:18 -0500
Message-ID: <20250303204443.360595-21-tmz@pobox.com>
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
 list-objects-filter-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 55fab8563d..7b2108b986 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -82,7 +82,7 @@ void list_objects_filter_init(struct list_objects_filter_options *filter_options
  *       "filter" SP <arg>
  *
  * The filter keyword will be used by many commands.
- * See Documentation/rev-list-options.txt for allowed values for <arg>.
+ * See Documentation/rev-list-options.adoc for allowed values for <arg>.
  *
  * Capture the given arg as the "filter_spec".  This can be forwarded to
  * subordinate commands when necessary (although it's better to pass it through
-- 
2.49.0.rc0

