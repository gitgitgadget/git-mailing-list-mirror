Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06F23C384
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034707; cv=none; b=KrpbxP7I04eWwf/r9JJp/WSWF663YcX8kMNxqv4a7DXmq6cIQa0WOYOeM1l4jzf76fa93CtbnA8sY8P8vN7VRkMIoFxPhr5cfuyFRsp+rx7XKZFbBdzdyhCjCAgNV41fBUNmJ5lxQPhX8n4PbSJ+5vUvn1UPxrpkU0YJ/R82neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034707; c=relaxed/simple;
	bh=IB3qsLxJ6zWrx26KoBNupTCZehhro+Li/n1cKfQaxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8hB8WJaaxguCnCvGovTI8RuB1AJE+hBLpas1kKGIZdLWPKU2C4RzLWC1ePhNW+Ipo02jszdnThNFoBDgRv8ivzD0Ufm8onKJI7FI9gZ8uBaLYyX4umSYRmOyULcowrr1wVumidFCnCvIRZ5CHTstBzVFX1bWOfE2MF+tE+GCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vfDf8i05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUpIb5Ua; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vfDf8i05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUpIb5Ua"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DF5931382C58;
	Mon,  3 Mar 2025 15:45:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 15:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034704; x=
	1741121104; bh=rxLnA7uQ++VHwA7IDERfcDNPPMKfm+9z4a3xHWlns8g=; b=v
	fDf8i058dBqgIe0knfHFteLETZnqPPW6TWBSkca3FV4Py6zTKnnFlQ8kPcFAvgQq
	4WVpsSr8Y47A9a0YdxZhbfb0rS/He+75lJyTdCkal2tOnJT19O0wb1pTlDhB/xEk
	HYomgQk5G+age03U41VOjboKOEMcM0MlwhItqEyI3xIONHR6363UpMdt78vpjUIz
	G1t4ZJ31V4TEwMIaJ1DvJshcQVVo0a1ieeOaEnpgLQd4cfnQdJR8ZpJg2a9Tyyrm
	U4VVis1IWTdAi0J/knVSxqfhSQUAVl/1r7FQ9hqRdgZHw3KPpMDqiKEl18PsIWV2
	sYwTv05wnzSbBP8mUBEKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034704; x=1741121104; bh=r
	xLnA7uQ++VHwA7IDERfcDNPPMKfm+9z4a3xHWlns8g=; b=iUpIb5Ua1BPCXViiN
	FwGV2VNHU7h7cP7dxbxMth1J8RYCUWhmBL/x8U3pqaZTIeM49FiuMfrKYh1m231a
	lgZvbuKJrRF/Wx7Ld16pS1GAaKnNgLzOENhyAoYhkyiRdtKMV8S7PEbGIl3mOWe5
	7xe4S5vzFejISbdnixlHJ3H4d2onTzsA94eg1buWRCxcJO/uprrBZ5tUF7juLSb+
	jN0ITFbVqWASofXTb5CdzZAIbJdppUWHNq7cdZXEIeRPQGDKeS7I2DHKdLlhO5D3
	PeIhAkSANjUab1rggK8rDYggacN956i+9Hag+BbTFiGvXL7z8gJaW6eIRBKfsFor
	9vxHQ==
X-ME-Sender: <xms:0BTGZ91kha71Uqonytnjyn4Lca2JfHdiGxj5ci9t0KgCKilhp7XSYw>
    <xme:0BTGZ0GcHBGhQOvM8dVh4nqrhEsokZAJ3xfyUSdPw5swkhxSRXUfgZ23izsH07epQ
    ct0mbOw_ZCPjd7q4w>
X-ME-Received: <xmr:0BTGZ95F3V6vWTJ-Q3fQYB3Vz6JfN6tEo-bUszRxIecsDsKJLDj7ZO-sbeqUeswH_2yyCKtxb6OJkM-GKN_UL6nKCPk>
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
X-ME-Proxy: <xmx:0BTGZ62fh2KhzK7XLDgfr4kaiKvyZA_sa8vtUeYyIq3XrBB1v993Rg>
    <xmx:0BTGZwEv9EJS5MSpjwp18z9hcvm1S6qcJKWkUuK1_1Cr4Up-X871dQ>
    <xmx:0BTGZ7-FBZjehlPqOvhevv2JMxC_zc2e1UzS96RmPWVoPfgAq2Pq3A>
    <xmx:0BTGZ9kdNRF3JukMJKxV9hyi8TFZ9rEY-19mJkTvqOlvR6oMAJbVyg>
    <xmx:0BTGZ0BEC-KH03vYPtNzC4vdDE-OQQHF5SXNw9O043CMNx7jYVfADkEO>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:04 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 16/34] contrib/long-running-filter: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:14 -0500
Message-ID: <20250303204443.360595-17-tmz@pobox.com>
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
 contrib/long-running-filter/example.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
index a677569ddd..4b83e4c5e8 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 #
 # Example implementation for the Git filter protocol version 2
-# See Documentation/gitattributes.txt, section "Filter Protocol"
+# See Documentation/gitattributes.adoc, section "Filter Protocol"
 #
 # Please note, this pass-thru filter is a minimal skeleton. No proper
 # error handling was implemented.
-- 
2.49.0.rc0

