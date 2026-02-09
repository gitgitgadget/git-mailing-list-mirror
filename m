Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00F243387
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656196; cv=none; b=KwJOUpHRHniAgKQuqIMo7yMzAjtVhKxCyTthSc+rnipWKiE9eW9JTLfaZubg4eyuYQizZ0b/FWkjJRlIZImL1mScBOnZ5EqxYpaXEPYUVXuMlk0nMOKBgdrM8NAdeDyVhr7b8eScftp2Y0e0dzVyx1mb4eBE5FbXfW07tLYmZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656196; c=relaxed/simple;
	bh=B6N3Qc5HsK+Ik17R5AuCsADSAuwdvw65xmbCJ8lNPGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sn0zC9lbzh3/M3QHIxebF1ftZTbmt1GRZQb6cD5/RntGz2p4C4rtauvyXdBiBf+MyOtUI6bDO63OrFrYnGgP6hofFfc3jqMPIj06rTgF7gPy5OUvK+NE5mCm+B4ys27BkzBSTEZf2Otz2y2+NSew7Ebn3ENkbmKg3Exrz+tWJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TtIx+AY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aA3OA3fs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TtIx+AY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aA3OA3fs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B55E71D00014
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:56:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 11:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770656195;
	 x=1770742595; bh=XSTMVsTpkVzwYzWprlOX+lF0oJYPGV+r+X/zQL1BZYs=; b=
	TtIx+AY5roEnEyP9onvFvT5gvHnQPc1RzTqTBMl2ak/pOb7fyf914D5UIiaeNYrl
	WqkVen9EfIGVGxt6PMRN13d066x6eTBctZ3/80aqScLv2jUYVpHIGOO8R+Rvzx/s
	yshcMRQHfub2Ecezu9tRldnR+w+qWBdDNf3CUelfuEUwwKmEtGSRKLMARgmUZsUE
	loKdhpepUkHcwnlGBXo4/JB9iBVWRm1wYy4e9HsSPvg3kWSQzbUlWlZKgITIpEu+
	L2qc/lgJQZhy+vIRZvsq+o7NzuIsnuvh/62QXzxrrkUXZapesL1nFmFcpqG61OiJ
	UmGM8fggrgAd0CwpM+kPNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770656195; x=
	1770742595; bh=XSTMVsTpkVzwYzWprlOX+lF0oJYPGV+r+X/zQL1BZYs=; b=a
	A3OA3fsPVxaQ+c+b58MYHlXSqudfOxOT9/DEgcnUYErmhk9KaOEjFcjW9+C/6ExG
	6utOr3R3bl0Jrf3JZs7D4Su1YKrnBN+AzJvNWUXKD4TX0VVsutJ3mnwJvgWvz1ko
	niMm8VKdvQmL+RrLQrgzBe/RnF7dVDuVPHx5c8ADSrU4jTSIBe85S8U2Q/S8VJJB
	lrO1c0xIUU6+AEXyF3eSazztqQKFoqdPHvN7PI5qiDyKRbA4V3RdrZHzBZ+DfXws
	BeM5tvAQqSsu6pxt4QmmlOBmVKzcZQ1ydQPcTs2CthTJ9InNjBOJ/JWcLW6pKOSN
	sxfXXipqREnU2crSlfjzA==
X-ME-Sender: <xms:wxGKaZ5sTgRUUZNLHSGu-oFq3NeUgbkjVAxVtWw95R2IoXu3913tPw>
    <xme:wxGKad1HQhfYXzmWW9uD7beEHBlEfRrK1M9OjFTb5-kARaV6GZvS5rLmA5kpwwe4y
    10exPiWno5DX4bKPlIqjejVDvxZy6LTk_CktTG4cGhh_Mrp-JMZhA>
X-ME-Received: <xmr:wxGKaWGSp9VGEkBa1ArNZ8hzz8WitVLwWyGime8KD-OAaUmdZDW_SA2qOVhiRao8dHboLkiYKtH2KHOB3eY3e32Pgs5sqGeth1lrsvFpe5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:wxGKaXT6vf0ZwqfvKAdGMvaFesPKkItEQbvIYp09yort09G62kHBGg>
    <xmx:wxGKadDQ_NQYWMn9Bydcx0KErRUkMV6PPmMBi-02fBARdbjzyAITsg>
    <xmx:wxGKaX21qnS3Xxp0FSx1gZ1OFdqyoPRCyg6ycRHGpqDATbWDGy0oGg>
    <xmx:wxGKabWd-M-RWEfo-GFCegoXFY8baRVkrVmA9Tlkb-lZuOfOdyPoPQ>
    <xmx:wxGKaebOtUcfI_7N9kdL76dr2iM_-pvZ5ptffcDdiqQ_CI0AcjfQVL-H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 9 Feb 2026 11:56:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2add7ded (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 9 Feb 2026 16:56:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 17:56:14 +0100
Subject: [PATCH 4/5] gitlab-ci: use "run-test-slice-meson.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-meson-improvements-v1-4-38444dec4874@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

While our GitHub workflow already uses "ci/run-test-slice-meson.sh",
GitLab CI open-codes the parameters. Adapt the latter to also use the
same script so that we always use the same Meson options across both CI
systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b419a84e2c..04857b479d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -183,7 +183,8 @@ test:msvc-meson:
     - job: "build:msvc-meson"
       artifacts: true
   script:
-    - meson test -C build --no-rebuild --print-errorlogs --slice $Env:CI_NODE_INDEX/$Env:CI_NODE_TOTAL
+    - |
+      & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'ci/run-test-slice-meson.sh build $CI_NODE_INDEX $CI_NODE_TOTAL'
   parallel: 10
   artifacts:
     reports:

-- 
2.53.0.295.g64333814d3.dirty

