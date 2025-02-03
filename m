Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71591FC7C3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569835; cv=none; b=HDrGjpoy7Qf3VWFKGgVc+1NQn3hjR94KCmt6jp6u6BrG8rfadoI05nxaf0dgVInNyalR9uTTNqNoAlDCaJWMhTce6UN4leeLN578C03eaN2AoMhGxHjzL2JyXg1zkJisFC4QIcnzfiTAP3z4aRF3k4dnuuhKLVRGvvFRmI8OKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569835; c=relaxed/simple;
	bh=C5vHJjj+op34gi/im0T0Tm00/SZPM7Ce3L9QuGIxsBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sq6Y6H+2baxG769LARSMPIxFLDmixjheuVFrbgstOXv32P1S3SESPplCmCDpgSniEHTpwXsCs3Jrug9KudkkEuih21t2gFjjaeeDe5LcDRsdH/dgWajh/K4Qw98/gqt//xDrkid9/rB64M6TM6HaVTBStuvwMynu0f90e8flF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnR/IG6s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0mrq04x; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnR/IG6s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0mrq04x"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E083F11400DB;
	Mon,  3 Feb 2025 03:03:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Feb 2025 03:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569832;
	 x=1738656232; bh=VuQlX/RzzjeSLcMrswRwibHnyo1CiUnzr0928zt0lY8=; b=
	AnR/IG6sEnKfKqIAjV9IcGFZlYRp26wwMPUiOMrMmC4AWGluXoPSm/A62u4pJD+Y
	zK+DjVw8ZwV3GLcuPfCTRdVrnSy39wuURS3mpfHqSm/GM3aivhXhNj/BHicrU0fM
	0wJxO5i3KnnNj/qSu/vvK3/vao0ft/0tVSJPIBSgO6XplqG2Q0imRxv6nK1foEhV
	5TimZ21/bBcBlMM9tvJ/hJ+uiRO/pqjHGCIw2BO6BO9Jd7Ugj89vCTo+9OSpkpVv
	9R3Nuw+hTDmR5RgWSY8t02NtNu6OP3rkBn56X2M66BJSgAV2BPmFtwOc/HYFhXdL
	qevTNwpCjlZl83sx8OsmxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569832; x=
	1738656232; bh=VuQlX/RzzjeSLcMrswRwibHnyo1CiUnzr0928zt0lY8=; b=f
	0mrq04xKARVeWgwFZDoKBRba+s6QPker4Lcnq6rpqc4veT8M0qSL5CCtdgS9S2og
	D1RTQ4dKc2IobsLmtGK449bNpquO0Dgh3wTtHtjxkw3Ho6NQ9a/KhrHaKfYjTO7u
	l1n49qSJf/+jbtMYfeCaVKLgXRzn6MJ5td3OSyQoEzTHt+zwayyCeguEZzJin+xQ
	DUytb8ETGolipcnZ0SstT1TFa6e8dcCgygZ7zlZkZ8/bMG+duuBBeOl+V/T+qybK
	OHvRGZ5jSHBCHA02A5T35VwewMSqx53Fqz7xDsnI3f55ljVq3btW7J6ZmQ+2QHw2
	qlsKUtY9YOUEeKezDA3VQ==
X-ME-Sender: <xms:aHigZ28kRGlNuCKwLyysNrLNo2Sx5Af3oIURX8wsrqSYSosST8zrCQ>
    <xme:aHigZ2tZCSuaUmJRRB8fxXd_Y_kUtd_rxC-So62WaHZuMrRI6ektQH-5rJMvt7BN3
    dc1lscAjSv3k-kuQw>
X-ME-Received: <xmr:aHigZ8CMVelszZDBxIYbOpwK55Dzd91XN02-ktVOmjxuUIWKYLr3ZVJlQcZr9eIM4WJfpY4254Ca_q-7PXIGkQUbJ04DpqpA2NCgmNxEW6rbiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aHigZ-fZxLv8LltNUK7ayz--409IXci6tIuPYT-UuHbQpKFE-Mj1lg>
    <xmx:aHigZ7MVzj3qC_fZctjYPrXkbUhhED46PmMaWh2MPjNn4SALN36kwg>
    <xmx:aHigZ4mrKDRMWYF2rDIagZFDJZXaFrFf-aJkNds9Cb-zqn0XxDM3fw>
    <xmx:aHigZ9uwVyLJm_-YPmptgwDJYQR0f0G-WGTt3h5z7xxWyg-E9L09gw>
    <xmx:aHigZwpgvs0PY54yj9YkjJKRwZY251aUcGQ4b67yMFeEUQaFb1B9RcvI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ba304c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:41 +0100
Subject: [PATCH v3 10/18] reftable/reader: stop using `ARRAY_SIZE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-10-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have a single user of the `ARRAY_SIZE()` macro in the reftable
reader. Drop its use to reduce our dependence on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index bf07a0a586..c3a3674665 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -849,7 +849,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
 
-	for (i = 0; i < ARRAY_SIZE(sections); i++) {
+	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
 		err = table_iter_seek_start(&ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;

-- 
2.48.1.502.g6dc24dfdaf.dirty

