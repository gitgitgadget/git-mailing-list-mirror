Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44192241103
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034718; cv=none; b=ouwWGJ/NBPKt3v9byK/4EA5Xt/tncdcWZpAsXs+9Bh+9x1pgnljONkhQdd0hBKdTXqOdzMMaRM6Xql7ggCiWRIwMmU66026Dyd83SVsFSXo66AGX8evfsfvmC5+3Z0V1t5lQRn8sVeQOSWP74f0RbrcHxfDb5NGPGLNlQRK0mZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034718; c=relaxed/simple;
	bh=fGle4w2wOwgwyz5WLV96YakDMGDD0JtYX05Xhk8aypg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omk0gq+MUZe6UdlNiPoM3CCtOrwG+oB3UbOgJ4VoR3ApiSoVQWDpPjpQkTmxXqM40DoGvWNl6t736gJv6hCzjrtpskQv+N5/tCUqABItXWujNb9y2OfexrpmWY2UEVmoHQq1+S7rdcrooXg78FL3J+ghC8ov1SDvYK2LCL0rq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bu84YxHJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atf1uK4o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bu84YxHJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atf1uK4o"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FB8B1382C57;
	Mon,  3 Mar 2025 15:45:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034716; x=
	1741121116; bh=tfUaBkNG7yADb1TLi5swt03LuXBxU4jhUmxoqCURRq0=; b=b
	u84YxHJSnq8YLxEqZ35M2ktrZvjbbHWn2SPNg4nfBVJBYC7JIatC8EngPaPGNaQD
	bpsm+gP5TZ765mPtFofRKOMsKHBQQlWszA4gOfWa7+qbERXCnmtI1q61e12Sr9SE
	LGDx+MsQjjbrCKgq6B5fdqKTbgvTi0mKGNSq8mRjQwxJhvsCMToh+XjMSGpJPY8W
	DuwVtqhjvR3GDIkJBC2/qSyedhBPsWc3CaxYssH26bnRDSgm3YxIdAKnkzf/ubSz
	eNzgT5ok8bVpk/R5lF1X+e6Wt+h1w/cBSja5h1IfvPSfGUqiiWz8L6OZV5lIHcCq
	qxBdOeaIFpWIRuGuMqzaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034716; x=1741121116; bh=t
	fUaBkNG7yADb1TLi5swt03LuXBxU4jhUmxoqCURRq0=; b=atf1uK4osmZhZqBQm
	ImJodbKk3c6ib2ujollKI+ELyH88N4i3mAIZ0ZeZWscn90HBQ9NxoP/tRdPR+mlZ
	I1cYSmMN6iADIdZ86MzfpBRpGoXoRGTQzav/24N3xszWBuL+cYi6En7wUlCrRBRU
	QDkvHkIrxaO9uYq2fTki1+r6NZXV5he8o7dBW8Qc6ko41wBLBxtEciT20vfN47VX
	V4luBlNy2bK0uQQaTjh1VS34x56naI/dbyRHQRbjfohCVcm0uD9NAk9AeEF647rc
	o4AThEd5POPNYTPhQiS8vnvZXk5Lpwn+u//myTVN9a30MRZ7l1zHWsV2Ecug0G01
	zQ04w==
X-ME-Sender: <xms:3BTGZ1lvl9fVMgmcvxO9onXRvzcVlHZ_NqxQ9ryeYvbVMUuEBzxn-w>
    <xme:3BTGZw17hvXw7UGtnVDp_hSw_dbOa1BM0SP2375ERK_4M5RyUKZAUBEs9YJeIVq_q
    M8dKUaso6LHUBgN1Q>
X-ME-Received: <xmr:3BTGZ7pqLAr5W7s2jXmJ7PCKh8XC-Rz13kS18GPLnMhSUIbXASJv6qXJ7EJqIhrxm4AJpS5DhshvfgZTbpc55OJ065w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejhefhhf
    eltedtvefgtdfggeeuledvveeuhfejgfduudefjeefieetudejiedtfeenucffohhmrghi
    nheprgguohgtrdhinhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:3BTGZ1n5JzF9gwM6u0oSYu-WP_S3e2ccU2mOl_z0YO9qVoKoi_Px1Q>
    <xmx:3BTGZz3lWiAWr4ikoOCKnPJqb14LbZpEJjFsiRzZFsttwa2gS5sceA>
    <xmx:3BTGZ0sFyysVH0AUfs9hJ9q5RzkhWUhiuuO4mnQQdwBL1XuLjGblAg>
    <xmx:3BTGZ3U09Gk5jPEJ6db0xFkxAkPVjC3hGdtvhHFGsDcb0w1zvzxrrw>
    <xmx:3BTGZ0yp9PtKGvM4dLE0ofHdY-3m2GdtPWGEvAbtqHudIQYVHx6kcNBJ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:15 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 33/34] unpack-trees.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:31 -0500
Message-ID: <20250303204443.360595-34-tmz@pobox.com>
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
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 334cb84f65..cf5b73c84b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2904,7 +2904,7 @@ int threeway_merge(const struct cache_entry * const *stages,
  * The rule is to "carry forward" what is in the index without losing
  * information across a "fast-forward", favoring a successful merge
  * over a merge failure when it makes sense.  For details of the
- * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
+ * "carry forward" rule, please see <Documentation/git-read-tree.adoc>.
  *
  */
 int twoway_merge(const struct cache_entry * const *src,
-- 
2.49.0.rc0

