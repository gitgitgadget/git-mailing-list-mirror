Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BF36923D
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806099; cv=none; b=JlpEz5kTztCAFxivP6/7N+iQM+Cv4lZ8meTDiJsxH28ssszYWiYYGlup3TP0x49KL02VTRccigljK7kEEGxXeFKIGygT6v9y4DzrVHMlPGgVjp03acGDq4jrQSW8trbIPNYD27gS6FKSyBkd7x/VLtgX9fvdUweAgHTclq04vKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806099; c=relaxed/simple;
	bh=B6N3Qc5HsK+Ik17R5AuCsADSAuwdvw65xmbCJ8lNPGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHSF6iFIwYBiUqzh5PG9KZ8SQ6VVQhFDCZpYYsFOubGfmAa8giumdC4ktrl2MYjYuz2tO8+Jz4BqdBptI11ZU3XsPkxkH2O6N2WDIVZG+sL8wJFOvd4itP5pzyUnVOT0uQkJxOcEUNdoELW5u7FVm4jzo+Xg/VJ1jh+2GlkwhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jpX1ZUVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4uxtqVX; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jpX1ZUVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4uxtqVX"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38CCE7A00AB;
	Wed, 11 Feb 2026 05:34:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 11 Feb 2026 05:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806097;
	 x=1770892497; bh=XSTMVsTpkVzwYzWprlOX+lF0oJYPGV+r+X/zQL1BZYs=; b=
	jpX1ZUVKHKKs9vPVBfEPslZmt1Llbe1p7q3dXdNzh1pd8itezUhC4ppbiuKkExs0
	Wd0vttQP+F+6rJx2rFbTNz214RmYIpOP4ybNufg8bU17V/annBu88mFn5rEAdj0M
	jKxgvlTkb7Aa31K1CVLsMyJWJBOwFXsbd/TkuMfrYCO1mv5C6TOI47SZxCXiWFRc
	fWkeimHFeNR4GKjdmrcydSwJxu2WJfihQgHsdzoYap+aEVraXOikX0CLOhE3nnWY
	gONcfmV7IPCKhrWAmBjwEuaQ3T3W7xH2e34aNKp0DPTBb8jQ8m0ll+wWlDh8lOcX
	5AfOWigNg6+nJKqhdw2A6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806097; x=
	1770892497; bh=XSTMVsTpkVzwYzWprlOX+lF0oJYPGV+r+X/zQL1BZYs=; b=T
	4uxtqVXIEsbPnDQjD04LONY3UlEYYJ6kZGBNy0j2d2JffCeLyK+n7jqk/+RdA24c
	Fc3JGQL6eYMZaqeoq0nrgAi84/YrRFy16pu2o+NjORsMYhZaGNHWGSfvLuBXuiQj
	vI27Upmu48ZvOnexbFjEjElAwjRZSXdU+CcgyBL8SZFFI+Nj2Ett/xOo8hPAGq1K
	t/pph/Dl0qQ4zEd/Z2Fiimrv8xAnOdJj9nbE9Dw7x1GVdg71IdmLXWKmnQT/P7HT
	BVnEw3wqM2junnGs+2/qJW5UmnnKKBafz0622rJLQgPq88O/93Dn28hu5NaqhG3P
	8WJhTlvYxGxGrjOf17gvw==
X-ME-Sender: <xms:UVuMaa8F6OmnMuHK374PCQSNFyyMjERQG8atL8RuQy9rYDJ-ANadXg>
    <xme:UVuMaRtmaG8QXDjcrC06eNPneMAvaPN3UpkDYHzu152tJTpIVIoe0bd_tt2ZQYDTl
    Kh-GZ6gqqgyLnTlul16jzR6O10aZvfziLo6c1S2NSmczsyIKxDE>
X-ME-Received: <xmr:UVuMaVDJ_TODkvhqmOomwi-j5WbbaXpZpQP0MWb0E1wcmKchme3xUYHDLMyjYAAe9Ssfu9wjfqIPyNtJCjyVu5LDoS9JQWHVykSGFRkxaZkv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:UVuMaRWlzPR_aINMBK8cLxCj_NPwR0yAhXk62F2tRLDfVzCGfKXh-Q>
    <xmx:UVuMabBdECpK8FFVWKyV13IMqGozZ6RSL5j6FdLgs2lTflCfaZry7A>
    <xmx:UVuMac9R-ukY3XSSpZSZLpCJQzBsu6C2gDk_7wNjtl5LOrEahamHfg>
    <xmx:UVuMaaHi0_me9N5f-xI14gM3rvaBRzTo0gnvxBv96XuRAlC_wYadHQ>
    <xmx:UVuMaY8O6oCVObBxvDVtg4ipV4KOH_aNtMF47dQ8FxEXhbFCztDGAeOo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 768cb3fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:32 +0100
Subject: [PATCH 6/7] gitlab-ci: use "run-test-slice-meson.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-6-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
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

