Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14739BFF0
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001477; cv=none; b=RSb9102fXsCEfXCHkPqpzoMvgWR0YJQX0dXSczARf/U1c284rqPnJt4VOqmCdnGcMyFBi+TxxHCwDZ5skDiE6GKh1OaA1VmHYCt7UJqQ6BPI2MOu9yjQSJWchuS47WamHA/m6ucCi9mhaML2xVR2XLVJFcJfmZW1McDqqjT8dZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001477; c=relaxed/simple;
	bh=vVAKl9zk4G93a5SXnjoPR7vZtJqZNzs7LkwadYCqUMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBdfcyca3yMx5IrhSG7nWu3bABPp6mO7meobPjwsBe2OMz8oObbm88xiv4AvG2TB6JAYjrIUAVe1xnP4hTK9glO6ikVWGa4RjzLDmdqUKKs3ee/Rz4ZgWvoDBPM2IaCdIAUQLycMy7Af5hIu07AARyULuHA5g31ADh052XPOp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JcNiDNIi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2d8tkI1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JcNiDNIi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2d8tkI1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60C1D14001F2
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:57:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 19:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775001475;
	 x=1775087875; bh=vuTm9UqTQyAad2jpaXVwzzhVcqFjg1E/tyGQCtcqg7o=; b=
	JcNiDNIihtzL3pUry/85EImBn4NEx3q5EcoS/S0AtCnefagDrfv5wvqJallfaRYY
	y7Wrcv+AGBU/OKxN8JpuF4SyR0U65rv3jToQqik2Qf99Ytqd1fK0LWYSLCKyUvzv
	nK8aCr0AwUKwlqKQxzBLAD3NcLKqUrLcE6ZM0GkYuvEzfHysw8xBs6UVCeqfaDsM
	CvwaIKhgcagPttZ082A56UkvY4PslPMRNQzxeUP0cljluKX0W8Di3hKyCzC8jAJN
	LeeOnjuUHQoKUWiEBhGDCpolE+a76tRNZRslCLQVNIiISWY3vvJL51HXg48727Mf
	2To8TpMJM5rBUyYHYKPemQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775001475; x=
	1775087875; bh=vuTm9UqTQyAad2jpaXVwzzhVcqFjg1E/tyGQCtcqg7o=; b=h
	2d8tkI1k1aTZ2yOPKVvAlhl93QKrmnIMu6vpe/37BXrLirT1tlUrecT4fMGvXdv4
	Tu134HlqRqHcx9gyEmEdU5wM+cjRniHp+/5X4VLftHv16hku0MpFpgHWkE7uZZ3f
	JeQO2nbicubi7c65zymJ+W03GVPxFPMJ7OyKfHVHO8za+HkixMaFBGV5WoeANpIf
	0C3zWFX7XO6C3cp+U1s4P68lIm1nmCcWTqGX1Xp7RI2M6u1S61dvmwjOOrA+LmRj
	nxHgB07ar2VBPr4+4Y//beZSR5ZHEFWBsyRcacc8E1YTIiKAzdLgal3cjPM+gLpM
	WWHBaJVNKQ7tqwxbolR2A==
X-ME-Sender: <xms:g1_MaVeGDBLxTCYpcPhtrslC3yo2IjAbakFoZtPYl6836iKNxu9jew>
    <xme:g1_MaaJx2-D8q10qRxPw5X5KIXi2P_xc1UX_OMkPyfK7vdqBu_Nv9GEikryYzaxSA
    lizhmgsenynwquzmhLT7wPnYKTm7jmS-_Z_A0RbBxneD0Q34ulYLA>
X-ME-Received: <xmr:g1_MaUJZAZ8EgMgwkXSLZ1SQUrchMbF1ePMierhQsDjf7zNKxV17wjXO8_IdbW7ZbM2bl02bM1RAwV-0pigdzfV59LCwifk-Lhbd0rq8KI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:g1_MaUHOEdfA0RXZHVs6IvUWjXHtO4wjAyvEU359-MCM6I8u55R5iQ>
    <xmx:g1_MaRkt9LQtITZtb09DJdrNnBbIijw-m0ulQrftredEUms082H8-Q>
    <xmx:g1_MaZKWMm9RKQfBkrKANnQtNLh4VIPpm0tqBqZLg08emhTIM70GJw>
    <xmx:g1_MaaZRaEXPk8TvQ8oFEAPGQPNiNaxGtpEiqJ5pw1Ymu8_QUf5rdA>
    <xmx:g1_MafMviva5b1tDSKZRfdH1ownf5jHJ3wDIcpe4cWXlplEpaFj-XVtF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:57:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8da661af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:57:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 01:57:46 +0200
Subject: [PATCH 1/6] CodingGuidelines: document our style for flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-odb-cleanups-v1-1-89adba9ada68@pks.im>
References: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
In-Reply-To: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

We have recently iterated a bit on our style for flags. Document this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b8670751f5..4992e52093 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -668,6 +668,18 @@ For C programs:
    unsigned other_field:1;
    unsigned field_with_longer_name:1;
 
+ - When a function `F` accepts flags, those flags should be defined as `enum
+   F_flags`. Individual flag definitions should start with `F` and be in
+   all-uppercase letters. Flag values should be represented via bit shifts.
+   E.g.
+
+        enum frobnicate_flags {
+                FROBNICATE_FOO = (1 << 0),
+                FROBNICATE_BAR = (1 << 1),
+        };
+
+        int frobnicate(enum frobnicate_flags flags);
+
  - Array names should be named in the singular form if the individual items are
    subject of use. E.g.:
 

-- 
2.53.0.1185.g05d4b7b318.dirty

