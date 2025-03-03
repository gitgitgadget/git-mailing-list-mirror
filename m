Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221E23F271
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034714; cv=none; b=nQpseVSYU0tGQ+UU2++pYp7ohLQscLm1Ns60yp1zOAGs2JaMNfRfvV0lsmw/xjcIG26sxkd5y9pT6elmrVAjXKs5JuKciyTsSVJGDaRc8/u6oSLCj6RIgUbIDGhzsx0HLeAI/9egNApgglYu8p9KMhlI1nxkVLnZ911Lz9CKuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034714; c=relaxed/simple;
	bh=RArcbJxlAuzc4bSKwHr2DKXlfxcTZgVVFxUoWw+n8rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jd4fR+dY3PijhtGU7riL/L00LCufvo2zEG/tkeNdd+/Uy/+EhR5AWZyn6tgWAQhMk8PBPfEJAJBYCHs/0n5H8HH9ZilS9+mpxSCig9oW7ziUWlRSIaDdaW4jckcx9DYSPdoyRERf0mj3wZdynZMvRYRnJUpvmijlJ2o/OcsbUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OXXI0BaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tgcwaV44; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OXXI0BaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tgcwaV44"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 602811140143;
	Mon,  3 Mar 2025 15:45:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034712; x=
	1741121112; bh=kq2LCBwJWlC/iaBfcuXL11ocy+XooHCTVPleuDHhxyo=; b=O
	XXI0BaOOWG/8zF37e9XSboxkKdPr2y9ty0l72fxIjSZM+Md1WUku79GJYfBznU8D
	JgaGVCRVfBycEF3lM8prExBDEHWmZ3cDlAHXm9ZokyR0qz6d4thQfcZxzdewhebd
	R+ERIrHikwQe4YQ9dpfaU3ZpGjw80/cAiZsuKkpbSetJzs7KN87eGb5brZGxdIDg
	l/jSMi0JySs1afXawEHurA5iKLq+simDijyI1P2PVGCjjhgUW0TOlpXcUrDtvyyk
	mmB9oIWWFKwzx3ljDrCofuwXUpb/wXtz1zomXaz/pC6xEgK5OdJOSCjj8+BR/YqT
	qg0c51ne9KUpthCXMfs9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034712; x=1741121112; bh=k
	q2LCBwJWlC/iaBfcuXL11ocy+XooHCTVPleuDHhxyo=; b=tgcwaV449sY8HxnRA
	AHpRZDM2lO7IWQdNpc5gVYNtpeyuMrIqTr945k/EMdumInotMAtUoEG3lAJLN8/w
	GW5lJ9J+5DdX7/Cst8YGI/wcP5xAyHsP5UgskV9q4G0P/pqscnYTowmZ9TvYZDKD
	uXdqwYlR0jjTtNKqhlXKP65LV4VXyOs1tEU5dRoFAq6ANB0zbjAwM7m8KFKUHy4p
	bRnP6yET8rk76Ho0yQ0UcbY3xmcNgV9T6f34T8FyajVo0Ek91BIeMpH7ji5RAGq0
	zF3Tr5HfRkU44CZ1hV1X49KyVPqZ9BP1lK5+L5c3sR+bcqv8UxN5Y9Vt/RoISJfB
	YGp8A==
X-ME-Sender: <xms:2BTGZxcqRhx84GonPOPecypKY9-8PZ5SpfSEHQaas6lm_qbA6ZFtEQ>
    <xme:2BTGZ_Ox2hpNIYx1gQv8lFElyWQaVidoNOPQmH3XlukJH4_uWjpAKo7MYpG408qSN
    e9QKH1RrBxf3PTHdw>
X-ME-Received: <xmr:2BTGZ6huYqg7u_HV7ckp92QsUTZlgtEUZy6CUjAMMHIWEHGfa2iDmSoGKf5oQNn6qlBtYS7cWZcMDsK266zBNRMEoAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:2BTGZ695FxltwBCHVqeHJxCk_yzK9zlzVjTH7bOh_R0GxXS_kyCXvQ>
    <xmx:2BTGZ9vN6fG5d-HlXajaKdCrVhMI_uTA4rcUlgkS2lGdeo7IyoW-8A>
    <xmx:2BTGZ5EESkDWw5LYRz03fuQuC5Y1k8BN0N2Qk1aEWuMSXEtHqxvWFQ>
    <xmx:2BTGZ0PJ50UKy_Bri5lU5Mjzd8976gRNdKtJ8qDpGLAuRy7doOquQA>
    <xmx:2BTGZ1IL_t-BAGSkQEbMwf5Z6gnZSIv8-BM4KqQ6ayEU7QiIsho_Ppbk>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:11 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 27/34] t/helper/test-rot13-filter.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:25 -0500
Message-ID: <20250303204443.360595-28-tmz@pobox.com>
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
 t/helper/test-rot13-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index ff407b575c..722b1cbe77 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -1,6 +1,6 @@
 /*
  * Example implementation for the Git filter protocol version 2
- * See Documentation/gitattributes.txt, section "Filter Protocol"
+ * See Documentation/gitattributes.adoc, section "Filter Protocol"
  *
  * Usage: test-tool rot13-filter [--always-delay] --log=<path> <capabilities>
  *
-- 
2.49.0.rc0

