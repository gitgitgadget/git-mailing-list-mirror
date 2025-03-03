Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5C23ED66
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034713; cv=none; b=F4N2s2bLMkUOQ2bN9I2ErfrjzFoZln1f2Zbc4edrfsYCZ+XvSMI4la20M8q1RZiApJU6HsN1QUUsSdX7E8h/LrdmeE965/5F8yhfom2KBTB7WCZRb4iemEjU7cS4kpUkl7zvAiEivvVO6Wl0C1PkLQr9kDqKzW1dPFRNtI+me54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034713; c=relaxed/simple;
	bh=y3pL75a3u+J/E5vs80akkYwn/h2MSRg+b2lxNKn87QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCRHeED3SeLPXL1OkNkv9vdTwyju1wilnOef+bzYXcz4Dm93xdVYqfykf4Ct/8EuvcqSpM5qoxrcG9hLS8ffjlf+iXtwQbDf6iG4KbeOg/1r0diwml5Ez3d8NaamTVAxX9J2S9OFoEqt1w2jXZNbGVF8xfjWW6bSB0eJsCi4Is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M+FGFTK5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rwtd3FhF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+FGFTK5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rwtd3FhF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A430F1382C58;
	Mon,  3 Mar 2025 15:45:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 15:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034711; x=
	1741121111; bh=PMPJPCwKXfkPr5VMOkNA0+HFaNZJ53BifqoWlHqGmMU=; b=M
	+FGFTK5WJ9Tw73WSgOA3Y9l/zLtEC7Dyp7PVVEl0YbftV34L7WevW6rMoEU6DiXl
	AuLa3+izJ4esUvcrGhRI9/+oYNFr3tjzlLoBn3sEN8zXFZsXud1Fr+lNAuMruznv
	zypaouLNA4F1BlwQcEgxaBn6cUHeoqzuZMdoJOVGg77fbJ3R3zTxB6dqdTek7Zsb
	Qx0y+V+7J1ZLUJd4FfdEu8skLsh8tJ3x9YoeUgpqKTM3Q2PydHu79E+91/b9cWz5
	tnGstJzYiwqLf4i/dbbfM3zMgQhxJcxBUg2bzG6XB8xrFe7fYmJ8kVxQjJNrUK61
	xXoTIHEvMWJUY/rQpPlWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034711; x=1741121111; bh=P
	MPJPCwKXfkPr5VMOkNA0+HFaNZJ53BifqoWlHqGmMU=; b=rwtd3FhFEtPJNWlki
	wCViMO/okfMpUIl745opOVEJc0Irj1fDVNTEppfCOv9TiznwqyqphmwR5n8c22u7
	Wpu0yUMOXg0pmN7Eq7GpDIXhEryCOATnUVnIuZRb/qegZW3Yfj7Om8J4qcq/K3bP
	wZiWdEMTElt+TYArDp6gwEY3PiA2UtNXh9bF8DAZsSTkbMl7FPmUuUnLx7CLwLwi
	mgvtMIqrLJr46t34HApAbe7yTWuqHn7iE43QtF29fR2W4mXaRtFrEArAICPAtcCQ
	jvZ5/MpEIQ3jnw02BdVpBnSPUJqEUnHde+JMg5NjJfwc5G+ghSptnpQQQsPw2Rrm
	u8Dew==
X-ME-Sender: <xms:1xTGZ4lap32MOqskO0zQkGXkwpH54AP_r14_2vm6tMetm51ajfaLpw>
    <xme:1xTGZ32-2me5Klh_dDcnbU8HEe74XK6ynbQIURQg8-j8Xv6YD6mkAmYEFDRaEdYmA
    vBvAFtOGDJEDnpwRw>
X-ME-Received: <xmr:1xTGZ2rB47fX554c55PLGpQL9YRYyWk_zDYHkn-vfnKbOXxbjp5ao71gzasRz7aNPonXKMjzROVEi4IRGj0AlT8va98>
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
X-ME-Proxy: <xmx:1xTGZ0kCWmpSCx3eslM4tqpg3GhoEdvlwhFjS_kozrinEODkKEuviw>
    <xmx:1xTGZ21T8MuQUC8wF-XABNE1sRX98PH9fi3QdDzOD3EQl4Valgnduw>
    <xmx:1xTGZ7sPqq99vcVtVsRdrEp1ZorNLU_r4gF8Oy_sSadcJ7GwVQLEuA>
    <xmx:1xTGZyVGjLLchskROvVYm4X7NSc8gfGtqWFGzQrPEg-k3B9Nc_uQPw>
    <xmx:1xTGZ7yRYJV7Qhyp1BJ8BL-hrSGAVe09HbthnjI95K0PuJ-7fop2W481>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:11 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 26/34] simple-ipc.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:24 -0500
Message-ID: <20250303204443.360595-27-tmz@pobox.com>
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
 simple-ipc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simple-ipc.h b/simple-ipc.h
index 3916eaf70d..701e005cb8 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -2,7 +2,7 @@
 #define GIT_SIMPLE_IPC_H
 
 /*
- * See Documentation/technical/api-simple-ipc.txt
+ * See Documentation/technical/api-simple-ipc.adoc
  */
 
 enum ipc_active_state {
-- 
2.49.0.rc0

