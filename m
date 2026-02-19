Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B12F3C0A
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482350; cv=none; b=lhi2pCmyJehSad6i0bSS2Yf9QIWvwIakwjUCcBx0UOBAly1triILO6iNMbptpYQ4jFSPO8SnWY9hNW+ntttomO+l53G2QOb3WqvxN43nxU8Vmaux3cB0c7+mONoyqJklvltV0KoHtOgZGLJNy9EJ5t3VfRVVibnwMQyarO0Pfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482350; c=relaxed/simple;
	bh=4eE5rTNTpzqK9o4QIWohj4fgrLEPjM7aW0mvOVOqZ5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdxotXqeUsaVrVmWWmTWkanlmDAjhUOTg+f6aBri8rLr1dd7CzhJPvExsleE37G7UxgolLCP1NCLD0N6ZLn4c82rxnoP3255zHu5fK5028QLWkDy8CpKZzn0vcp0KGJUC23i0GuSzCV+FdLNE1UpKCDBOBpTjA9w3lqz/WAsixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RSyGkmrO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3NQU9kK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RSyGkmrO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3NQU9kK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D8FBAEC0108;
	Thu, 19 Feb 2026 01:25:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 19 Feb 2026 01:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482348;
	 x=1771568748; bh=hVMUtf1XT4fbDxkK/kvNNqVWal5ubyudowX5MR2XKgg=; b=
	RSyGkmrO5uFlGU1q+3g2930w8uz6VKMTTYmFjizGkOAfhTrp0/GDn3l6n3sOE483
	fOSqKJOnHrnBqMvyEwzcc0X5ZQchIrX5rDNpS1bO9+2esQ4RA5CPi6P3eqFEkFuu
	oVwP4gvBGCHp0Z2+uyDm0zNUPo6rqdM6Z1RlVVLE2farMq/n1mf32pCDD6ChDNDd
	8hOtCKkIuzD5VusiJO5Bf+zNtCdjiyirw8yvIXVW7juccBj3g5EhCfBH7RDw79H9
	YsOk3PWiYxAupROoJN49i978jUFRWmoETcw/f1+7MpLd9pkORxf8g5z1mhrd5kB9
	p5MP94In7F4u1+AfoCRBhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482348; x=
	1771568748; bh=hVMUtf1XT4fbDxkK/kvNNqVWal5ubyudowX5MR2XKgg=; b=X
	3NQU9kK1JPWn0gQu5agiVSu+LjznMplAvJz/U1kFeGiYNk6jJ1UVpLOT84kSmiAw
	dPgdytIO0zXrIq+RjdTlKGWBLh0vPjQe6bUSmSsIpZKktqfZrTYaK11Nvo2S4BOT
	JMAMV7QpkKwlD5+Y1wSbKyb8O3VxlOO5zqcK6V8dJIUGZTuykrQZIrjxcjS3UjJe
	4Xe3SPvBxcDZfdSWPWpMhdbUm/+2hUh50SIq/iT4QgdVRHusQnjfJTuVMR/JG+le
	s7ErFu/W+AqSVL3TDL7Ouf280T8crGyCOlMWk3/FOYFfrE5HuS4B80IT7lMXiOKz
	pjtrAfIsM6+oix46Ef1CQ==
X-ME-Sender: <xms:7KyWaQ4oYtTydiS0CrEihUXY8Np1VA4mEIYVkggdAvNG0gRA___cVw>
    <xme:7KyWaYyI3MnxiShBx3pisfbveqazsBxlRUhjaNfKLBAcT4JR1I7YXgjP9aDNw79ut
    rRApS96QcGOw6CK9T5QkU9kXP_9WIiQA_V2-y3zbpC-11UFxYYG>
X-ME-Received: <xmr:7KyWaXx-tgHEPRO6vzCjGZ8ZwXmTTnnJi8uCKyDIpG74TQEP1vhj6UeudGLiJUYSk9IbPDeeHrw9C3sxjiaLk0o-YTFtc5DwQ0kVtubIHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7KyWaQxtSFjFwQBH8Dq5LmnD8vKcVJ7xm6SYLC43wGkr_fxKiAxo9A>
    <xmx:7KyWaRbz9MxyuBdoXT0oowI5Cqa7H638TfU4JKPCPJy5ynn-4fQZCw>
    <xmx:7KyWaRWe9YYmNPZ8vAuRShZID-HoA39jgyvc3-ALTSCr4OBSt51YiQ>
    <xmx:7KyWafh0MGpxY_vY0V8hEWrr0m14FBo8bQGKf7fS7ws4-bFc1hk5qg>
    <xmx:7KyWaUOBEc7Uxai49AZUcjwtI1q8opagxRgXPDTCDq9Re67v6VSyO9rn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a9b4386 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:32 +0100
Subject: [PATCH v2 6/7] gitlab-ci: use "run-test-slice-meson.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-6-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
2.53.0.414.gf7e9f6c205.dirty

