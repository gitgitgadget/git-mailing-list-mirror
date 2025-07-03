Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3372D878C
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535039; cv=none; b=skCEi+OVYYfS5cqPe4DiyKSRHbOwMStZe/PNd9YjL5C9d2zhph51b90BBqBy/9OXfaJv+WJlNQvt5xfK2nyZL0RdPid1QyvqQJnz1s0FoLJqdOMDfmuJS/9wCMNYHMh/UO28CRBBAa682dyWciqwmkLwMsjs3n9WO1/N/pXHvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535039; c=relaxed/simple;
	bh=qDyyxbEQ8V//wNZZZUXobsRua6tPb/pUGPayDrnSPa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNDpQ0+hFXfR0j/ma/i/OVlXyX9pujqOiMm6M6zqu0JBF0Ap/kj0xbxpqKTDb7Q5AlDETKyTRpbZKLSE2PnO5N52rQJjjXrFWvGdWcXiGe4witQOF1QGdnZcozk2tqh3UFLrN0nFRRG7qqC1aqCfKt1JnZAZgXjDYTrZInSx7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ErgMMy92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYmKXQcu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ErgMMy92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYmKXQcu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 58A781D002A3;
	Thu,  3 Jul 2025 05:30:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 05:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535037;
	 x=1751621437; bh=NmYDe1j6sYSmozjtf3fU8/pBLQaz3WFRnHyy8C1eKFA=; b=
	ErgMMy92cIBoP5CCfEGv80/PfTnZpToGSZnuYJ/72RcG4RsRjOaQc8w4fx3uLrnb
	0SyPbMyKulGM8p89C8hMBb+2T2emwoGHVhRloVl/XG8fOyRnVmfwjFf64pEZ7kZ6
	IIRLfa/Tvrj3VHTBTqj2NT+GAr6n5cDl/LnBtLO1e3kLu0kXCimBrsDNS9gpIj0O
	oV8zZeWslkHbX7ABdHiVyyG+iX9p4svVyZfxV4nDtWG8NFY5HrL+uvc0SvrygHa4
	tDeLjT6Rwq3yLF5TEbYAfJzRkOdwhlU/NOIqZe5X0eM2A2gvnJPSQYHrl2WArA+o
	gUPfunepgDO5hqX/XUC5MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535037; x=
	1751621437; bh=NmYDe1j6sYSmozjtf3fU8/pBLQaz3WFRnHyy8C1eKFA=; b=M
	YmKXQcu4auEL0RfWZedS1L7foCEvcHpNtY4rrOvXOTs5aU8TsmXxU7A9Iiha1Egk
	Kn58Lfmd7OOzu8KEzCy/9R5LMWkVWHs9jCZpuyGuEZsMW96oDsITiUYjwAvSSk6S
	LvkZqhfYRfygKkOHkDPmwPUkelhhyEh7efscmaH3B5u50ebPca5YD94v5vb5SVBj
	d7kyo97iHaK2DVOd43kDredKnGJUl0xEeJXaHqA7ceJwHVJ2xTX3CI+6QWnjgxWA
	tX57rDaIn8GQs/IreM1+1HvvmEJKMnmLPRJGBolWF8rBEphiGS0accIuKH0Z5ChY
	R+AYwKyoKPpMS0r4iN1lg==
X-ME-Sender: <xms:vU1maGccuCORMsJeCTrA5fMzPSd7LOO9nV3LOdUjBYm_0TNk6iN2sg>
    <xme:vU1maAO-0mfzgwCG_2gmtIxRdNlO36IocTNNali7NgRpwvtCM_ibDgowgHh-dAKzt
    1FH9BsSkjXXDnDbmw>
X-ME-Received: <xmr:vU1maHjxlUc9zgb-ZCLdnyVlxgHqzus_6z-TJekDCq0P73L823d1wAMSs5L2kBdF6fgJQZ35JxCUDqwMVT4w5rob_TD-61XRtXD6A_7uyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleevjeffvddtheeuvddutdfhkedvtdefueejffehjeegudehieekvddtieejuedtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrthhrihigrdhnrhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:vU1maD8MTSHUlK7Dk1rDfPzIs6zJT7WVaDULq2DWbby6Llbq8xoaLQ>
    <xmx:vU1maCuVJo-XvjVsNc_Y-dHzq3tFAAuH_gAUUWJrZhmbXQUrelmbhw>
    <xmx:vU1maKHB_OvzIKLJkmQilo7JQXIzDjkpd4-K-qEkSFMdmyzjIWzP3w>
    <xmx:vU1maBOpniHPDvjLUshHD4wic7arp7fhUhRNB8JDluIJbKyd0mjL5w>
    <xmx:vU1maK5D4GBQwQM9kyrNg_9fALrYVfTjX5VVX-DUVGaOBG2pBUUeq_Bu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bf9982d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:50 +0200
Subject: [PATCH 8/8] ci: use Meson's new `--slice` option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

As executing our test suite is notoriously slow on Windows we use matrix
jobs in our CI systems to slice up tests and run them via multiple jobs.
On Meson this is done with a comparatively complex PowerShell invocation
as Meson didn't yet have a native way to slice tests like this.

I have upstreamed a new `--slice` option [1] that addresses this use
case though, which has been merged and released with Meson 1.8. Both
GitLab and GitHub CI have Meson 1.8.2 available by now, so let's update
the jobs to use that new option.

[1]: https://github.com/mesonbuild/meson/pull/14092

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7dbf9f7f123..f0f653bd853 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -298,7 +298,7 @@ jobs:
         path: build
     - name: Test
       shell: pwsh
-      run: meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % 10 } | Where-Object Name -EQ ${{ matrix.nr }} | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
+      run: meson test -C build --no-rebuild --print-errorlogs --slice ${{ matrix.nr }}/10
 
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bb6d5b976cd..af10ebb59a3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -178,7 +178,7 @@ test:msvc-meson:
     - job: "build:msvc-meson"
       artifacts: true
   script:
-    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group; if (!$?) { exit $LASTEXITCODE } }
+    - meson test -C build --no-rebuild --print-errorlogs --slice $Env:CI_NODE_INDEX/$Env:CI_NODE_TOTAL
   parallel: 10
 
 test:fuzz-smoke-tests:

-- 
2.50.0.195.g74e6fc65d0.dirty

