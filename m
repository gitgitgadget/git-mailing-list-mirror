Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0211DD0EF
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162225; cv=none; b=S7UfYYdBf5UvrO2tDhu6fHd2pYLE8kYIPKSyOSGtINLpz6ctvDfmD4Gdj8l/0DnoVd6f0V7tFSm17NndCvEwJjBDLc+VoyInl5wr4WDADeem1u0ASxIJhcfug2ZtwatUmVRtHzW/3TdB4v5d8W+5ZxGkr0+UaPXH6rpxgnWl1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162225; c=relaxed/simple;
	bh=9U5pSa1Ya/qFA16RVITh0ufhTFoyrRiuuHsuhrHW4xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOdClze9urKlFUBEpvggButyWunLtTIYdfPMuxSl4dSU4kZb8A63KuK5DpC6fWYXVFWqsqZ5Z/sPXJL/cvCgFkHfkUcsngEFLkEZ2Po7RBiR/AvdpcLanugdn7/v7xOV2Dyy8+4qoJneFk0yQco+RLyaq+/mBzLhVRe2c1Yc2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aCDJX1Is; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeUXCFwz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aCDJX1Is";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeUXCFwz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74E1A114040C;
	Mon,  6 Jan 2025 06:17:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jan 2025 06:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162220;
	 x=1736248620; bh=NHmCDjoh5XWaGXJRxFyoi47O19R/mtulCqgmb/hGRHg=; b=
	aCDJX1IsdKe+njtgeD5HXsWIKXWrXNpqdWrQE9XldZuavJu7reuswijnBxJUqqj5
	qDsZTI4h1oHOHB+s9AoAOxv5g1EQQ2auSZ2/+xclS+E3bNR82VKpVVNPkjpvoA3j
	E90q68k0YyHGVV5+hN191lXckzeJbGm6zRmJfanTgzCPpGCbdo7Ygkfny/R25Xei
	+1ymX3s2VIb9CJFwHPR0lPVzNvALnKAv5y0ozgXaGlUNEFGhT9uuu6OhEYysIyot
	547Ja/Rg6+1ziYv7OwqTlvdACrBIqj7IV+PJVdCXtEGG3iLMbN6IHiIBYqmpedi7
	NPnlvpjbfsQwTemKeOdxaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162220; x=
	1736248620; bh=NHmCDjoh5XWaGXJRxFyoi47O19R/mtulCqgmb/hGRHg=; b=W
	eUXCFwzvpfBB0Ih9JGgDGxlGBkzoV00i8w0J3K6IJiUso5R3yO5XcNLW42sb+Zrl
	qF0UNXHGnKbLHuPSGy1vK0EK4mzhlZTC3xmBQlcj+BfJesunqWLM8c0Wg3wbditb
	c0kgTLTv6tmRoSzNb/E7JssPCQ8cdy5WNhOwXHpnP1eVgVYkD9EES2Ti4zzFQNHH
	oesFGm8T6jrjOUhKYZgrG2SYCI7Ur4e4B/XqG9AcwhcOfVKOWdSZuCUlUDGXsfjF
	QhJ7YEbVS33IDDKvqNnt+ti6g4VuDhkchbKP+vsxJ77dwwN2KC3Zjcu3OKPgvCZ4
	IBRcz8G8NHl+O7miwgrWA==
X-ME-Sender: <xms:rLt7Z9BmRMCO6ObYTNpYt88rQffwAEhw-RqaHINUe66eoJezhuhb0Q>
    <xme:rLt7Z7jCNME0OZ8WTEHt2eEPVY1HZTelVC03li5dXqtpVQlfqiZGoXKXRY78Xq810
    p9rv5SOARv6zKEYtw>
X-ME-Received: <xmr:rLt7Z4mQaLNCDnZsSBfwa_T12xLARtnCpm1X9juhpJxvsE6Q-bpVvcfC0ItNTKBvE1TwJp3_2VIm-BqijBXXHr8ZHlNcnOgszyjSOROhYq6H3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rLt7Z3wMkKbyy2mFb9tfWVxsjC9AqDxT6A_tY9O_-gqEKtt9DMcOBw>
    <xmx:rLt7ZyR9IJ1nhKbCaZ81oMNhDDjGWYnQo8iQxKPtU6btr0svtNqtWQ>
    <xmx:rLt7Z6Y8Wi1wGASchp7x1IxGwZgPz0C-ISDRTiIi6JPGtZvw0aK4Tw>
    <xmx:rLt7ZzSIjrHh2gXVkBjsnTEDSY_V4ymJTcmcekM2sA8wlq4kPFiE6A>
    <xmx:rLt7ZwdR86cO7HiqVUZn8HZGH_7yCBySczg_XktCqKa3mecsQ7SaCeel>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cecd8c2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:57 +0100
Subject: [PATCH v2 08/10] ci: stop special-casing for Ubuntu 16.04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-8-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

With c85bcb5de1 (gitlab-ci: switch from Ubuntu 16.04 to 20.04,
2024-10-31) we have adapted the last CI job to stop using Ubuntu 16.04
in favor of Ubuntu 20.04. Remove the special-casing we still have in our
CI scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2293849ada3b45873f80e4392ab93c65657d0f13..77a4aabdb8fb416c1733f02d02145b6bc0849998 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -347,14 +347,7 @@ ubuntu-*)
 	fi
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
-	case "$distro" in
-	ubuntu-16.04)
-		# Apache is too old for HTTP/2.
-		;;
-	*)
-		export GIT_TEST_HTTPD=true
-		;;
-	esac
+	export GIT_TEST_HTTPD=true
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

