Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FC23FC5B
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034717; cv=none; b=DwdeWGr7Z0YDP1rHmIHpFrdTwLciMa5+lC7sCs3nxb3M+m9LRea6tYLjFOvWsISMQYzzt+6bK43gFoEiMa+g3ByZ3Nz5iJmB9HQ8QWcqLtVuqzNTBqkJlYpwX7gy5UZZu1q7ts0YdY5v0Y4Fc+sUToc+GYqU5ZDUY/FT0hTqD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034717; c=relaxed/simple;
	bh=uZVOJzKlN8cRI0kHGN+6qmYWDutAuU+e7zixhQLwAC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC3R7hDa4sFV0CCFI6bBTam3+YG4ddCrqhp32RdmQEdTCw0LIyMwACO6h1f7VuWbgai/hcLSUC4oo3tY7GKZySYHbVGfl6Aqyccah5JlHOqq29RRZiILATSGtcS4KOVcNxuP6wuiLbzlBq5bZtz6+pBkHwA4pLeHFrBy/mGW8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lNAB65D0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RowjcnMC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lNAB65D0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RowjcnMC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 382021382BB0;
	Mon,  3 Mar 2025 15:45:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 15:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034715; x=
	1741121115; bh=eRLdcFLbQnppuzKSfYJHvzzTnFXS+/BOGbTFvosSoDQ=; b=l
	NAB65D0jmZeakQ5TKo/AxemETkCGfVPHM4A9VRTd+SMNZEjopLf/JLhUx1lMZWXP
	ephwbLUKjnwr15BbNdxe91JilMYGGm9SCYLgTjAfPY2jxzpcSSeE8wUwxGw7uMXw
	itxuxinRwSZzCK3wGIQU5sXl0fvuichM2/ZIL4b3a++JksJdpeZaGndn7oCXy2C4
	jcbkDNk9Lzrxwtpbff/IRkRYnbHVDNZOOyqQ4z2lK0OaklxuOewkLZWo1T6ueZA4
	dCrZwYPf4Mx9Wcdj5lNYQGmFSMP8U04HL+FQ2n1cRt6qNF/k+oEqwiVE+D2c1O3Y
	CIXs5NvVr61IuJRSA15Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034715; x=1741121115; bh=e
	RLdcFLbQnppuzKSfYJHvzzTnFXS+/BOGbTFvosSoDQ=; b=RowjcnMCa4ur3dTT5
	ZS5uTVb7PC6JTmLxAtbG84Aqgfi3EKX2zANhmvjgZABY2KqRva+2UGl8cL+VYa35
	xNpKIAUGPNpPmang49erLYxfi/6OGMyhGy0vYSdaS1cJjNEiZle/rOJli9go8mQD
	pTOiFoFGgupbRI8LAhE2Doo6UU8u+t4XchvxzvWkkSAwhoMkvVqEXYVtYCtC1H0Z
	oU98pJ3wZfZHGMO5mFHQpT5BZQCOMq184v0B7UoYbRjev77fRyIQtKxbnd09Z7ke
	vqGMvvEGLc+qhNg6g93gOg8phN7Z6cyJGt5W9XTX7zAyrTlwCHkQHEarKFJTmvnT
	L+MBg==
X-ME-Sender: <xms:2xTGZ8Pm7SaE3dzdQir0H0wkWybyUw9H6_iPE4kA1_rpnVxb9R7ZXQ>
    <xme:2xTGZy-PWG6qEiYq8SczyZNkrDWo7lkUPl-HNVVHbYyI589S5mjCFrBrPLjbRa9jq
    rEmLu1-ARMBenZyxQ>
X-ME-Received: <xmr:2xTGZzSJDUV4wfzIQwqqhGrH860KaEanyPm-K-d72on6FtlxHp4hbZxVefUJDF8W2cQetbxRI-yxmSS5K3s7ELIntNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:2xTGZ0uP22hC0V6j28inO1Z5n4JcQDPg5vQe1JOCHrzGO2tLoXwk8w>
    <xmx:2xTGZ0cpoUfA6Qg3stbHSK1Mq955OecqFNfG_Ti6CfxuYTXdA9Q8Ag>
    <xmx:2xTGZ435DmuJYnLEwWXNH3IbwLbnAei7vWnOMZM7I1fktJurk4X1Aw>
    <xmx:2xTGZ4-ALtAAOJggRUNttHmYfkRtkxLCTZO0wpygha6RFA2KBAVQAQ>
    <xmx:2xTGZ84j9qP9tmijbOiaSfSsi5_BS_3q4xgEKm2hx9Yyg_owzsJO1ttT>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:14 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 31/34] trace2/tr2_sysenv.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:29 -0500
Message-ID: <20250303204443.360595-32-tmz@pobox.com>
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
 trace2/tr2_sysenv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 01379c5cad..4abc218514 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -7,7 +7,7 @@
 
 /*
  * Each entry represents a trace2 setting.
- * See Documentation/technical/api-trace2.txt
+ * See Documentation/technical/api-trace2.adoc
  */
 struct tr2_sysenv_entry {
 	const char *env_var_name;
-- 
2.49.0.rc0

