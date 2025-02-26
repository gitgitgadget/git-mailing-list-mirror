Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D4226D05
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558156; cv=none; b=KYk4aaxD3KROlPzuThukoEBC2c5kIvXkEeAzO1glPQdh28UAKk8hhhY1DiH1uQLOP1wPpaeiQkJ6kq5hdvcStVqfd5k4mnsYaDvBjK1xbBIt9jCov1OvCW5CR1t484ETDRtnPYW6hHJJgcxInyJPi8MilILVWRQQxjcL95UfaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558156; c=relaxed/simple;
	bh=Rl2na3Pqv7EXZard22xaHsugrA5cdjKwnWOAFq+Kmw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpeZo8QWiJ3GDUXZE/jzR/7dfmpAa+ScnzEgN/NDlQ0NyaTjrxh+Fx0/WkpxSdzW0/rKvoIsrUNEbYBrmBIUbO5pvqAV/xo8xQkCUKkUv4aqcn0QgutJHZERxOMImMKxG/6EMs4PcDkvAu1vZn9Aulbbt+KaAB5XMst+IsOa19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mrr7jXxa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di0Ccwca; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mrr7jXxa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di0Ccwca"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 57CA11380EFB;
	Wed, 26 Feb 2025 03:22:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 03:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558154;
	 x=1740644554; bh=C5xRuNfP18o+s0ktLiSCSqGklNYrugPf0hb97EzPRb0=; b=
	mrr7jXxaCnIfb+KsJEXtYeX7+ziTPva/HLdR6dw0Uqv36eSjqmplfjCASUXRVYMI
	VPHiEIk6aAFWztb0MIy6vIE9dCKpKTKn7Bm3k1YsWcMqZf794TR9ZS+S1yE139Nx
	y3lf2yKPAic3vXJsNfQwz2aEVXoOanJ5IkdVm4HRoOkNsKJIpijzxernF7z60SD7
	vnI6OMTFrPJuUUdkMzsHYuKgtj1XUYFRcz9drWe+JMXKyQCkuTikyHxHokQHATrM
	+TQaYaT6u1C/oOpdokile0MQOsD36qqGcg6t1jYL6tc2jHItO3K2YNm8xxQLDSOp
	MMwIfwHI56O15p5eNuiG+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558154; x=
	1740644554; bh=C5xRuNfP18o+s0ktLiSCSqGklNYrugPf0hb97EzPRb0=; b=D
	i0CcwcalIWP6RZcaTWhAK7CNck2Dw/9VCET+ifvh4TJKTfEE53cG9S+6d5UqU1GD
	tWhT95mQxlJlrp7SlV/2uDZolePU1AnCUW6DLc5g8fvRHNexTvcBcIO/tbrOtVK4
	cMzQXG/4xdDKSM/8zWP+xhm8vOD1ofHKhgNGwG0UScyePp6AgsAcsaQ53HV2WIIM
	GOEXugkT5UK9wyIgkPwI+r64x7+6OQVPrLX910jWClxdzcp9zyEoLoUHeL2Si/lB
	Ovc6euOWGTbrJRijooZoKorjzP5sEsnRhr0dHf9qHnvheeKAoIE4020w5PCfAqq+
	RlzG29YHdxR93akB018dQ==
X-ME-Sender: <xms:Ss--Z90G6uUd1xWjV3ZLdYdmxH7EJhcIXRSpWeRHwPuhLgIHRg08yQ>
    <xme:Ss--Z0GWgWiNoz9MjWPenb-zx_woH8Bb62JlP6a3TaGHLf33Per6x0bZEcisXrIst
    pMkKMbUOzhRTxCLXQ>
X-ME-Received: <xmr:Ss--Z963d8X0MxOGqz1Z_LOJ3hydxNvrjDCCU1XWCat9-UfjiIT19EDLRSmwHuHmJF7aG_FAyvgF99xhkW6j9POKJ3eZFmzVIN_FVVQ5Lzdef4db>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:Ss--Z60ptuyd3obWkm1FqDYjqUMb8IhTpLfbmQKcGVHUZhoNRSsKyA>
    <xmx:Ss--ZwHxwCC_ROiI9ygjwisAomRg8VRuuy6KfH2O8xGMlhF7q84ygg>
    <xmx:Ss--Z78fgNYxhnAY9idscQzMY5tmr_48sFfnxKjitdmuRA3RueDMjw>
    <xmx:Ss--Z9mvxMmY8IKnEinLc2eTfH1Q-1_3LRCDA8QyRiTIhwZq-ZcLlA>
    <xmx:Ss--Z8gA4bF5Ox1ttzy7iQiVj9f2sokCuiy6IK-4RBQPFFjV0_NAPlsI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba663d6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:23 +0100
Subject: [PATCH v3 13/13] gitlab-ci: restrict maximum number of link jobs
 on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-13-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The hosted Windows runners on GitLab.com only have 7.5GB of RAM. Given
that "link.exe" provided by Microsoft Visual Studio is multi-threaded by
itself already and thus quite memory hungry this can quickly lead to
memory starvation, out-of-memory situations and thus failed CI jobs.

Fix the issue by limiting the number of concurrent linker jobs. The same
issue hasn't been observed on GitHub Actions yet, probably because it
got more than twice the amount of RAM with 16GB.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4976e18a050..7e1cecc6a70 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -169,7 +169,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build -Dperl=disabled
+    - meson setup build -Dperl=disabled -Dbackend_max_links=1
     - meson compile -C build
   artifacts:
     paths:

-- 
2.48.1.741.g8a9f3a5cdc.dirty

