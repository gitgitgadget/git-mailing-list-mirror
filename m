Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B81ACED9
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613478; cv=none; b=E58GAVom8qz25sPy+6SybTBTFfaYLpUOQ5/+eDCF5cjmRsZ2QLSlrXlPs3CsB/Mp6SQIKK/GyztuETaFUWCZUrDSIVgLz8+j11UaJWaS5FycN8+n0Z8zTFP3S0abfsiELLzlyss0HcxB9FxY7Sy/0EmuZ5Hc5L4qHPGqBIJDAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613478; c=relaxed/simple;
	bh=egd9m/43Eujd06A4VKF4f3+k1eoHSZLQYXtYfYwlgcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=DDMIAYYlPG9+nXTncQ7Mmt2VmeGRID64fwVgwjiM1dVn150PgeA/91TvAkH2UQ/jGh3hcW9wk98GCZGgG10jaAyOx5RcRhCMn7ipvSa0idkavKxquI3hr1RKgnuEx13tjhMmD/pFNa+GkqfF6tUwl7jcJ2wwq8PGm+MrQ519i1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dlKfK2Yg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qr5vfkNE; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dlKfK2Yg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qr5vfkNE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D00E925400CB
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 02:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744613475;
	 x=1744699875; bh=eIZFbJiiK8xbvPYebv/ZfLvD6Z/ZGqNC1BgOq9SbTNQ=; b=
	dlKfK2YgmewSRiQMp6lYcyU/4oWvAe9TAIg5Zxvq9R6HjYjhd64HUp/hcEjGW44H
	yuTEYZZvCqN6E0L2lZmbws8W91Qxjc/tsEh7zssKElzu2vJkmsFpLs7z+DxIG7lQ
	bPEVFD93PdNM0IFSyXwjpvYGHPCRenLrFGyRJW57CcVeqRU7wvhkr6OcR/7Kb+bG
	1YbAak1asWiY52hHqIJ6McbLLGzuHnK8IlzbQhCM+FG4O9ZxyHKb9qb1C+Syv2Nb
	HVczwEuLXGSAlQh6UR/YPbOMYfIB2pP24G+Ft5svupZA9nfXiTAqXYIpCtEOZnD9
	XfsQuquy5RAigxC2bum0sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744613475; x=1744699875; bh=e
	IZFbJiiK8xbvPYebv/ZfLvD6Z/ZGqNC1BgOq9SbTNQ=; b=qr5vfkNEqj7f+qgKu
	2q11sO+oFwpwg7zMiXWiaBvm3u5ph69ZjONMLZLK+41N+Y5WJr5Jl5/B72KQUui4
	MQgRJbHYBGX7gHLiJVPb8IECpGb6lPnvslsm3gs4RA9tsTvCLjVzEHRa3BRp6uFG
	60S1lFfYUybkIZp5qrgx+MT+7Gs/5I0yXDbcJj1mnnZ64BPO10RKkIMaASSxH0u6
	wCp2nz9Q8fm7D+qyHiGUkq5PykH4qMXVVuHIImI2aZV8tduX+utCXEUYbFPsLGN9
	c3Anse9/+qSic7Sfjc+9YRkvsDhiZmTiBGiAn6yCakBjz4c+P2V/QNEm6zz5mesb
	rB+dw==
X-ME-Sender: <xms:Y7D8Z_TE24gjJrduNFZMR7y8g3ZjgnVjhmzcrxrLdgpn0Dynr-CGGw>
    <xme:Y7D8ZwwwbCkYda6T14f5UKwpSlrlej7knKGytkXZxX4wJ67rxJrC6CgNdms_EpoEX
    nb4CxmTa7IxHdzphg>
X-ME-Received: <xmr:Y7D8Z02Vq4ASSSyHFBKBqWtaM7lCH7rPIxN5nXhNqC_9JixZ2wKzLDbg0m1NSCKtZmjg2LL_zuyiPjb-sUgpsKR-KAJmMO7v3qhlepTV5FXb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduue
    eljeelhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y7D8Z_ArEZ-0FleAeN_FWvCXvK6TagK_duNAYaRDje9qZO-dyZE4hw>
    <xmx:Y7D8Z4gZTQXSV_Wq0xTK5YWksLdvVbBH0GKrZsF1ZE9RKqxc0AF4Kg>
    <xmx:Y7D8ZzqrCoGJ2I-EsL4SKw8y23fvNiow-5_M5FIqFmEbeEUsRcyCuw>
    <xmx:Y7D8ZziVdh-1bgJHgLzBbZhQ1yLMd6mPMv1HEl_sL5tjgGt4Xsg3XQ>
    <xmx:Y7D8Z7MoiYt3Tz3HL6qoFE1Sy7q9IGxShVfCzEk-1YBJpW_yVkWwhgtB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b1f7f4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Apr 2025 06:51:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 14 Apr 2025 08:51:11 +0200
Subject: [PATCH v2 1/5] t/perf: fix benchmarks with alternate repo formats
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-pks-meson-benchmarks-v2-1-04377080a167@pks.im>
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
To: git@vger.kernel.org
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
2.49.0.805.g082f7c87e0.dirty

