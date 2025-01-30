Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9227322B
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254273; cv=none; b=Npw0kwgum8L9dA4Z1AN8GCciXXPVzxMasW26Scn8KobyoJztahKc7qY063VQBoN3hxvEA50BNI1GS/aPRl0q1GBlHMPLCG1G8jKBvYiDQ9JXpdsbbsobYMOleKCbO59h7Abqvq+1o9NBQBnP8wRTe9equrN+Z8peO9bey4p1Ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254273; c=relaxed/simple;
	bh=buvSfmVe2py6cCTe+k7N1zLt8EUwpk7wxw1pBnk3k20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFSgHVruBEmhalyJna9aNaQw8VbDMKPRtkT3P2Ddx2n0BQcLztbeBlYlD4aV7Lc96vh78/JSBqG9Fq00nUyKxLIQncPLKY9gn6Cl2c67uyJiAbUoZrzyXoHpKyr/5TRmwTJmA/AYK5aRFvLXE54QI+MRc332aWHJt7VnAJWwhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QBBMh4Jg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFZq6t34; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QBBMh4Jg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFZq6t34"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C89A71140088
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jan 2025 11:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738254270;
	 x=1738340670; bh=6mfrHfmFhWvZdNjFDNsiPM4nxLero6jl5+qofJ3QkqI=; b=
	QBBMh4Jg9CvN/ciGl8F6qd3z1Fqt8iBKoKsdc/iudpRt6veuDrqqydeVWFhzdZZS
	4HbovQV//jLNPBoty4W/NzfFxEXQt1+Zl2ri6kUnpM37gyYdLEz5teXHp1XNErjV
	kTNa9PmQ9tArR5E4VANrYOl/mCozT2ZBESSGGEl4680otCmenkg1U4PTw4FJGYTm
	rzd0B5SBXD5YXA4wcUV/lMOpJ19R0CqN84tG7FwF5HG+JvDI68mr1xeczQT4iweO
	dNF5/GPE8fQPGyrRUtmt2k79ncCi5R13c+eKMoYhSwWEmFzuMskxzbK3qesFrlVe
	wcdUyrBmcQvczkCJofFxpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738254270; x=
	1738340670; bh=6mfrHfmFhWvZdNjFDNsiPM4nxLero6jl5+qofJ3QkqI=; b=S
	FZq6t343pzCeD/0KwJGKU+a4e7Wg9J64Eeg95+dmNQf+F9vQ+yRZzmJLHTnNZ8wY
	bvbEEI1K0jzYL5uoK1G2Y+1wND5ujMg4h8cp4/yUccWEuNirZd6rzIsx6FtEhRF5
	iP2Cy9AgkqXIM2AwjXr1CJVTfOzqp9buMjV9Xmffmb/6zBveduVzGwA3Gk9UglAp
	zbXZ09xJdCVw1JJm/l3rfR083oGLy53shmiPd8u2gM6c8ZLJ6lQ8KmX3TEfF/zHJ
	/4SOnjQVkHnsQRvep2FJa7b01y3E4RATVOdHsfHX2yz9AZa8BYbdnbxs6djfMn8w
	kIDHVEh6DeIf2o7RTRnPA==
X-ME-Sender: <xms:vqebZx--ARY0zQsN9oUu0bqWz-m_P3ZxGVUVz5NFkgzs1Qfc5yoNCw>
    <xme:vqebZ1vpF17dvclJD3RcrFq42izhVFpjMZ-Pyz9chRjSdZpwSHUibTEyBqy-pvM23
    VaZCW4Oj30eS5sl3w>
X-ME-Received: <xmr:vqebZ_B1Go0-odiC7yXNHyYb9e_6Fyh84absbAyBSNSLUKj_8lePr7AE0hRBuuE6JKdmJPJYY1G4s5Q4h3y57E2QViHcZW9h1RO9xBPkp3Id>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vqebZ1dDXfjN1KJsy-b6KwgGCTNK4vXVJGh_H-xvPLe2IYJvc3B9Dg>
    <xmx:vqebZ2OarUxttnSfHKztei1U_GpkJ94nEkWCkxiTFjrONYy2UiNLuA>
    <xmx:vqebZ3lKykzimTONa0WICvfbV5wWP7tVNc9hw1UlrH3OCuIMChK1pw>
    <xmx:vqebZwv9M3mIaUreTPDCmpQ6LXPC22iE0RYImhgmeeTtVnl-vfBxGw>
    <xmx:vqebZ43CwtDc6GbpjbHsGZJCfahNhNNYmsFphOC6WHTOdg0x9scDHZ4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22e9b06a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 30 Jan 2025 16:24:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 17:24:17 +0100
Subject: [PATCH 1/3] t0001: remove duplicate test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-reinit-default-ref-format-v1-1-d2769ca01207@pks.im>
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The test in question is an exact copy of the testcase preceding it.
Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 72a0c2e7d4..213d5984b1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -861,15 +861,6 @@ test_expect_success 're-init with includeIf.onbranch condition' '
 	test_cmp expect actual
 '
 
-test_expect_success 're-init with includeIf.onbranch condition' '
-	test_when_finished "rm -rf repo" &&
-	git init repo &&
-	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 're-init skips non-matching includeIf.onbranch' '
 	test_when_finished "rm -rf repo config" &&
 	cat >config <<-EOF &&

-- 
2.48.1.468.gbf5f394be8.dirty

