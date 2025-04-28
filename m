Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1816FC1D
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825458; cv=none; b=dAa2nyW6vFZz8s2G32GiCslCMsvFxwQFEB5Lk+aiOMeJrN23H9AdWK+sjxsPSYLPhXUawxHVYip/1Xk2dU5C8iZEEeHcH2akNO0lkTR/tO10REYHwJCUjsuG6JL2AJr+9RrgeuGh7/TT8PWpm8jKM+dCFlQ4RTbzsAUHLDY3ATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825458; c=relaxed/simple;
	bh=7WOclngVCf1XtHgZxakTfv2WznelzrQrl49OcLZXUJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNMDcJ454YZ9o6KCVKa7l7qYXRqnIFHbinb7H3NndyUHVbXlvbt1zsA6u9pf19Q2S5QLv1IAC8ezO/Ol7GBKceLYlLgpbREW34Ac/zfk7yNNkHBWb5NswP24nWEsP5k/S1zuEFJSA0FSNJa1V0T3UnYvjn+Dr9oseOjfsQTFUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzhGRCWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvMVK0QQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzhGRCWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvMVK0QQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BB3641380142;
	Mon, 28 Apr 2025 03:30:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Apr 2025 03:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745825455;
	 x=1745911855; bh=hB9iXcvrczq4Y9m9tQIabJpcQVCoyqn8GJl0xWcMbVg=; b=
	NzhGRCWuuYmA1zSzxiOv1SURJLnYaPI8dXkSnaO3FfOOpi4ExG71iGLveJx671Ex
	ztvzjVQErMVLxJzPfxEpkYS5Gf1Av/PYRMLrWnvPasyQRSQQ8wzS/NXFHphNYmY3
	2J0h0n4poP5tsjgn0NqytlwEzsHjfWu76vyjknt8fjPvrQnEZvPSlkmB0dyxd61m
	mWp8adNeB8ETGK1LYWsJIYNgdOIxYU3wNgLUiIP1qK30q4x3doBPbnDsUoM9IFIm
	tMRKGnrmA7J6QrUdDmBMeC9/sYWkt0orsJ4wHG3cUUHgOTIAWgaOEyck5SjUF7pH
	Rz/HTVeyHBI+S7Uj6pLxsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745825455; x=
	1745911855; bh=hB9iXcvrczq4Y9m9tQIabJpcQVCoyqn8GJl0xWcMbVg=; b=g
	vMVK0QQuziwgAx4j5527Lg6s/CvCnBIFP8puNVBs6jLAvPRbhb7UGOU4IbJZtsHM
	1sa9niVCxej+cLXqc2dz0uIpnHf2aoawk7xLSUib00fpqu+UsLvPcWa2OZ5EB0d2
	NqwmHkmYE2fBLO3pUsRk1PTKJhmNgZ/RiEQ+JKBvET4InwWg8Cbk4aAt+33zweiv
	567tfMf+38JOYCRsJ+RmZ16C4FGgKlTYv0kB+oEooq68nZP/mU8XO4btyXWuLeER
	k4rtDqURgO9uimh+kw8CYIwMn8K/wAzia37TV7RWC7VB7IGUUXBXgj7oXtv2wAbT
	xZe+0WCZ8YCtOSBDPUOdQ==
X-ME-Sender: <xms:ry4PaAMmot2170jKJN0NOrRpxg1puw2g3f14jcMK0Qv00gPXCggg_g>
    <xme:ry4PaG_96vg_qao5mqNYf2YmsmUqcQqVg9q_4jpujTxd4Vt06JrW4IMv3ESmDa_mY
    Ur8l5dZngEo6x6lyQ>
X-ME-Received: <xmr:ry4PaHT6c_cvZh_ZDFHjuFBnfFapta4JAAle0wS_eUco6umOzf-X6mTYptC5tRuieHxjBBKKokPFMEuxeMb2Bb4wQGogpmv52RqOi5DIL9IW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfh
    grmhhilhihrdhorhhg
X-ME-Proxy: <xmx:ry4PaItHOU8uqTJhpzfzWoOIgIAr4Eh3kGFAMueTKfFItfeQmwPcfA>
    <xmx:ry4PaIccEuyrU-Aw13JT0mdl6dWAT7XUqaB5tmFyaCgduZMPeqqfNQ>
    <xmx:ry4PaM0LsqjTW7QuysMOow2zw7ZBn_QIuyVhJ_OHRlbYyQI5F1GO4w>
    <xmx:ry4PaM_FAuQPL92hdjQN5sZbvd9IwwK7TYtbe8xLXQ5rqUR94BQqUw>
    <xmx:ry4PaCh8KetZyBXzuJqS2VSkiLwzsWkOGFsa4fSl3fNp-w0rW0aLt-5B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:30:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8fccc8ca (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:30:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Apr 2025 09:30:46 +0200
Subject: [PATCH v5 1/5] t/perf: fix benchmarks with alternate repo formats
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pks-meson-benchmarks-v5-1-5010dd014d1d@pks.im>
References: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
In-Reply-To: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
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
2.49.0.967.g6a0df3ecc3.dirty

