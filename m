Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DA23CEFC
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034715; cv=none; b=GlvbLL2Ehj56TknO0l2RPidlkgcL2m+PjzVa2L8kq9hLEXxGl56ysBO+ojOIxmPrFsXQ7JHgIfor6Pv2VspreHMb9zQwmqBe2JZx5VUOd2/Xz+au5UJrs8tb7vZmHtpYc5FptMPpqWMF0qHGwhiUZja6RZu08gYQBHlzucR/EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034715; c=relaxed/simple;
	bh=emF0tQzSBltJdhn63Mtpqu5te+NbTeesXDD15hXwMlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xq3zSSmXdt1G2o5Ufuz+LD3x5tKdeFPb9A/Y4VmupBgBxwNiY1XcM5qNzVhEuEeK6QZQ74wzA9xXYQx4DvDOJRtckNp/Yip/SSGzvY2obD63FV9jNG1ARCjZwDJBBcMzx98VsnPSBC0EwkrPPHKGxZlPFA12Zuqcs3/HZ91re/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PI6TuFw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w6TH/obb; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PI6TuFw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w6TH/obb"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A2571382C59;
	Mon,  3 Mar 2025 15:45:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034713; x=
	1741121113; bh=bkGvbYL6JeQWeSkQtV1WkIXfVotn65D9ey+KPOA0Mf8=; b=P
	I6TuFw4sA5RPLwARuTTN6q4fFUm8FUgHRE5sBG9ievITUhJcbmdFm4Fp/gvsxzWB
	jKDIpJY0ZlxTt7mNJ6Ni9dhvEZjxbM/tbiFa3qqH0G2VdhXVokmFrtMV2bNBAOuO
	jnI+RndLcpSi7JazWnI3b2gt7DCSTPSW1qTIkY1hII+95BUrYSJ6GFcD4o0GNL/l
	yE6MtTHYL7XKcn7TYvsk9xW1uYBCurocVga74jCt3EERpQfJ0+H3ZxQLNT5pGz3h
	Aa4IOSG+o3hnHfekMzAgKh5bbS1kBFmxPCwfRyrXyM53xcBIra2Afz+aEZfhxxZ0
	eYEnymY/V7bbCZgvRRBYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034713; x=1741121113; bh=b
	kGvbYL6JeQWeSkQtV1WkIXfVotn65D9ey+KPOA0Mf8=; b=w6TH/obbXY72d9QKy
	fszbLK50XYtfvTY1kXsBIGFrD4kPp66LUQsfWyYsGHlLxnaL7AUunXCBJNhDBJ4x
	/Hrg/wdW0VmAdkFj9Ij8FgBZ3hCfhQ+H62BE1acN3jiFRzExM6NJ2vxfH27WkLCF
	Yu6oUKP5qca0ZHV6k9tHx47fjZap+JTzMLBk2XrCxcie2UppriAodQmI4yM+w+NB
	u6iTudnFwIVBvdjjWohjELcHva3Jzf8p+7eF0FC9wV3MgW0XDBnyl3hqQdyiKdXq
	8PbTyoAOElUroiS8sXdn3ffHuKTlGJvfsx4TNfOUdfR/Z4gWcE9+F8qapdPJu1Lk
	hAv+Q==
X-ME-Sender: <xms:2BTGZ8psCJQgpxoqiZXo4Iu_VjTaO-bSa1qVc_fJyA6jogrlP_B8Mg>
    <xme:2BTGZyrqgVdDVPRdkjctN1qGr06Mt7Vpq5O8cuHWe-KJXVgrXj9kZH8u8rtgzqpIn
    Ghkwu34R-ieEUknuw>
X-ME-Received: <xmr:2BTGZxPIyjzywFhx2pS7RNZVyWI7QcWjC5xffnlP-EACeW0yHaxUKSm9OLGH6ncsV3JKc6OKK6Fv8PjS4wDsB1VsP44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2BTGZz6uf0K1P196JXd3ejzo8LMVagRx2cso1GUgw7ItFNX8emCElw>
    <xmx:2BTGZ76oVKgsEbGSICZ4bafK-CYpx8o0ufeetygSFk-iJsgV3U1rGw>
    <xmx:2BTGZzgptY_PTer1NNfqFAzYfE936duBKjwIBfx7q0sENiV0LJmlFQ>
    <xmx:2BTGZ15uaPX6PysmGI2TgjLcD4CBMMFvsCBbZ6G5mkGPPVdVjWf_pA>
    <xmx:2RTGZ9l9tK1gP2PcCJ0FcAfJ-NgGczPurC4BvrK5uKae53YuvHys3oH2>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:12 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 28/34] t6012: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:26 -0500
Message-ID: <20250303204443.360595-29-tmz@pobox.com>
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
 t/t6012-rev-list-simplify.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index de1e87f162..4cecb6224c 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -177,7 +177,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 #   \ /      /\        /
 #    `---X--'  `---Y--'
 #
-# This example is explained in Documentation/rev-list-options.txt
+# This example is explained in Documentation/rev-list-options.adoc
 
 test_expect_success 'setup rebuild repo' '
 	rm -rf .git * &&
-- 
2.49.0.rc0

