Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8B2222AC
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566103; cv=none; b=kEpVVex6m/4l7i+Hsuh5eHehOMLZ0JgwGZ5v0K2Rn/d2sZWeb9+hAnBoQOeS6qQXdNPlhaQGnk32R4c7qshsFuiZmuTAuRJj6U5Kfwh0teiATP0WUyBwiU+ycnMJFzi30KH5DQ2gWq1+IJl57BWkjZqtBZ9rEmtU1X9vw+z4aoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566103; c=relaxed/simple;
	bh=23+Vk+T31Bo9zkpDtj+AY7LFPfyehDzNWXBz44k3XjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmhyuItIGa4wyB5KCs02bMZenT6DomLHkPIw72qIzxQNKZ9mAf0F+7GbL5cNdsQJ+IFuu2ZKdsZ+Tvxct8lt4yh6j9Jy2ay+zKpkbhMzxnxC1zvS5vxmhgApRnCrlyQtoEyHTCro/cnovT7N765q43czdhL/EIMVN2OyKQXClg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FDvZ7+/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+4ALj7q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FDvZ7+/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+4ALj7q"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 55B8513801EB;
	Fri, 25 Apr 2025 03:28:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 25 Apr 2025 03:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566100;
	 x=1745652500; bh=6RP8VZ8y8ycAvjA/Nxsskt5SLCTtXCQ2HFMv+khAgyw=; b=
	FDvZ7+/TTUVfMfKJRwDbkLB+vanRouEyNaUunPLkKMXFiAbo7FFNxbNcJFB/5raG
	mnOqjP7jggY0nFWow5jXkFJnSqafZnUO96iZ9MFAFugfzKv5THuQIPY7/Pg3XrLD
	HJurcAlkmf1RN6s1PhEWV4MbJmNMQDR14n447P2hkQ3z1214wvWq6YLKu4fXVzE/
	AuGuc8vyB9GUceTtznvZhrmR+OLrOO4n8SVViFVl0L3EugO25TQZphgyJslasvgM
	cdANIaIV5w20ZihOf10jn6csloBKEauWJQqSsNMLmNeoI8mXkAg0aTSH2WGtRsr9
	Tpv+Xn754NPVwG2+gwPmHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566100; x=
	1745652500; bh=6RP8VZ8y8ycAvjA/Nxsskt5SLCTtXCQ2HFMv+khAgyw=; b=W
	+4ALj7qGIzOnyMzK0vVG8quyms3KrkPitVNKluwzseU0hV6NhDEPG8c/xMqHj/UV
	XR/y/X1DK6vOP4GyKVnftovOAbG/DfYI9JuOKZu7e8z924DmLcKKThKX75ij9bFv
	29yEnmU3DilsPlaYsm7pFnx4jWaQkIDjAc6Ooda6WgCSRHAcaRcMlh4oqLc7LngH
	HR34olmoZQLngqzUgk3d1YIv/Vywd4wcvHbPo2oVx50B/MiFdJvuw9T2Ycho5+Gf
	sPUDyXUnfsK20DZs+jr4h8qK76+3Van/1hYtn9uBVmj+6oQzBrvC4YI9ZqXUNmZH
	JhAZGGlsTQ0wuPVRDVp+Q==
X-ME-Sender: <xms:lDkLaM7vYDc5Zr3niepRD57OqZTrfLdRVX-X4I2rvZ27PyaeXemoXQ>
    <xme:lDkLaN5Kl6lekXG3xZbV2sJhMMzxRKIa_W6eXAnCh--X2tdvZW04YqX8dtAx8hou-
    Vvbg3ypDvrkJ_9s8A>
X-ME-Received: <xmr:lDkLaLestqLSOSnE0QIDywHnVLC-1j-OU6Mzn1G5F9_La1r4_qETUaVs8Z_7ZtD2WWXcVHVHcCJUIzly1lpF5Kzvh2kTSHbeqzk7eYd9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lDkLaBJgi5bLYBu945BAjAPMfW4v6_ef-YJIciqUuIz_Vgh7OVSnKQ>
    <xmx:lDkLaALYg7qUs8RFxJwOmv2idPPeuE_PbAYPZLGBbMe7eizVCU6RQw>
    <xmx:lDkLaCxh8zxBWw0JYirzPsrdk_iB6c6qEO34cZ73KEwYjG0-JNMRUw>
    <xmx:lDkLaEJ5G8yz_kjwd_Us-1gym7eTtuRAEgfJFSNMjAq612852_BY1A>
    <xmx:lDkLaAswpHBqnSrhdamme7XeHrrwST1Rk6wfQMghtcdEQcF5QifHsHWO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:28:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2e84413 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:28:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:28:13 +0200
Subject: [PATCH v4 1/5] t/perf: fix benchmarks with alternate repo formats
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-benchmarks-v4-1-6b89555052c3@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Many of our benchmarks operate on a user-defined repository that we copy
over before running the benchmarked logic. To keep unintentional side
effects caused by on-disk state at bay we skip copying some files. This
includes for example hooks, but also the repo's configuration.

It is quite sensible to not copy over the configuration, as it is quite
easy to inadvertently carry over configuration that may significantly
impact the performance measurements. But we cannot fully ignore the
configuration either, as it may contain information about the repository
format. This will cause failures when for example using a repository
with SHA256 object format or the reftable ref format.

Fix the issue by parsing the reference and object formats from the
source repository and passing them to git-init(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/perf-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 8ab6d9c4694..1a9a51ca3cc 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -98,6 +98,8 @@ test_perf_create_repo_from () {
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
+	refformat="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-format)"
+	objectformat="$("$MODERN_GIT" -C "$source" rev-parse --show-object-format)"
 	mkdir -p "$repo/.git"
 	(
 		cd "$source" &&
@@ -114,7 +116,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q &&
+		"$MODERN_GIT" init -q --ref-format="$refformat" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock

-- 
2.49.0.901.g37484f566f.dirty

