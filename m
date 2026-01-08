Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F9328B47
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913180; cv=none; b=NUHJW5c2cdAP4VNDSpry0gOwL3eXUnhPpp3cz1kkFbQU04+xajES0ZBpLe5wjt2yx27TiHCgG+4jwanx5Awqgt03Y8pnQNP8qYFSHCpw1x3UVj29rx72BCXzINBGO0NHS+IiLIg5ClDCcpR9SqqIyCxerUDEx/EB1FLr0gbQ670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913180; c=relaxed/simple;
	bh=/Y9zrJttk33CDvFbEJCFRgFP6yt9VLez7IBhp7c4K6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOfzmw/BDz8TbGR3Szqpvf+rDUqS7nPvoyIMNG+mWLcgVeI6i5zBY4vOCBxor+tJa7K2DXaJFyJwUpc1tZO0ps9y/fGl7Av/iPrTrlWjJg5hSDt3dv5DcFDMONOUrCGY22u+12bgQ6R47bR2/YFBvQQ3Sc714ZRQnR4P7duqfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kjtsanaktsidis.id.au; spf=pass smtp.mailfrom=kjtsanaktsidis.id.au; dkim=pass (2048-bit key) header.d=kjtsanaktsidis.id.au header.i=@kjtsanaktsidis.id.au header.b=UJTFJKM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjDFtwjS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kjtsanaktsidis.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kjtsanaktsidis.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kjtsanaktsidis.id.au header.i=@kjtsanaktsidis.id.au header.b="UJTFJKM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjDFtwjS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 11EBBEC018A;
	Thu,  8 Jan 2026 17:59:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 08 Jan 2026 17:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	kjtsanaktsidis.id.au; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm3; t=
	1767913177; x=1767999577; bh=UYuHG3GPrlY845TBiyccQV48ep5BYe9Xx+D
	Q15M8YL8=; b=UJTFJKM98MDQcZaZrXC7ojOlrd+jkbV8NYMhmGb/1eVUgo41I6M
	F37MkH8xifTa5neLwcdJgnDnLq1fsFogE7Ov5kuhc1J0yQKXT1iGKg2F8Bm+z35p
	8PEK9G0hOc7x/Ury/0OUimccpJOOabG4aRARlcoLWQcACFzu0D6iel9vOufk9ns4
	zHuKOhSXfcOpPDbqq2fjnYlE9IspSUq/knJuAvGHY1wXMIHQomeOSsbw0VhK6m7R
	tN91/yO6V/i5jvcGCtfOOenTbaIXbXLpOcM6UqKIopBy058ljYuWqXb8jnc1N9J1
	DUsjqRq9qksCbNMt3bM4Qwc9Z3ZrO398cow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767913177; x=1767999577; bh=UYuHG3GPrlY845TBiyccQV48ep5BYe9Xx+D
	Q15M8YL8=; b=mjDFtwjSAHFpsOrIpvzfjYLcto/GFGVcqGfvAw4TWtuoHxJn2Ym
	8eYJT46VoJ8ZnDEjJjxLxZC1gM9V14nrMlUHjaBCY1988RCN9xipLE9Lx0SBjH6S
	48B5xc6a6Ya3lmGjQdjOIp0U5T0Zs3H7rmYBdjRB3jIQ8TdTu6qji0SnuSfPhqA4
	0QGBTZ+Xmx93zPGFMhWnWqDV5UGpDBGVLSAHRWu0h1gQSpjwiMqot595Q0RFTZQt
	lNb5o1QYVbXUdA+s+CBcbskc6wew2TyhQablHja72jo46FWJWOzf6Cx2Hs83wM03
	kUp81dtkGMqPHA21WBkgQ0V6BmiG5PduvfQ==
X-ME-Sender: <xms:2DZgaV2lemErs0ay2kJ9-VUsBTtrnojKhkNwJPgJKVpXe1J7amxkrQ>
    <xme:2DZgaZ4EpqI_2BrkBtpac--CYku1QLYaJaHguAhpO0Of3mcLmEzifs3Oamgehwdkl
    99TXAlDhMTmat8S8TMOiCyst65R_vrfjRIH3sO71l5eZGNnQCFIkL8>
X-ME-Received: <xmr:2DZgaQUhv1sy-Sp_yEluhrNnde9rpMR6pPChPD4ftfsEYrzsm7Uv3immfHoB3LWqWatdm9ngB4kMbq6LRc-AXul9gVKnO9K-7KPRNaomUyVifjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefmlfcuvfhsrghnrghkthhsihguihhsuceokhhjsehkjhhtshgrnhgr
    khhtshhiughishdrihgurdgruheqnecuggftrfgrthhtvghrnhepieevtefgudeigfeuke
    efjeehueekvdellefgjeegjeeikedtjedvfeekieevkedvnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhjsehkjhhtshgrnhgrkhhtshhiug
    hishdrihgurdgruhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkjh
    htshgrnhgrkhhtshhiughishesghhrohhqrdgtohhmpdhrtghpthhtohepkhhjsehkjhht
    shgrnhgrkhhtshhiughishdrihgurdgruhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:2DZgaQDbPd1tJXoEXig4fpWPfoTkbuJywu7r79QEYn0KQ1wEPSVTyg>
    <xmx:2DZgaX5SAzJyTxiMb2XeQbaIh1cftS4ut5Ds3yaO7mFTexqIUDp19A>
    <xmx:2DZgaTw63LKnsCaqBdRcQKzhmLSO1Row8GVEbiOqAdhqAmXxCWRk9g>
    <xmx:2DZgaWxGeV6tKy4YYl5h3UBJ1JBuhp0FAem3bs6X-mHoYYiyNwJeQQ>
    <xmx:2TZgaZt_k8uNU3skBJeAVJ8aHUg95So5eSu7foBvGxi2o4Ut19_8St0w>
Feedback-ID: ibd1946f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 17:59:35 -0500 (EST)
From: KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
To: git@vger.kernel.org
Cc: KJ Tsanaktsidis <kjtsanaktsidis@groq.com>,
	KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http-backend: write newlines to stderr when responding with errors
Date: Thu,  8 Jan 2026 22:59:21 +0000
Message-ID: <20260108225926.3587282-1-kj@kjtsanaktsidis.id.au>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KJ Tsanaktsidis <kjtsanaktsidis@groq.com>

The not_found and forbidden methods currently do not write a newline to
stderr after the error message. This means that if git-http-backend is
invoked through something like fcgiwrap, and the stderr of that fcgiwrap
process is sent to a logging daemon (e.g. journald), the error messages
of several git-http-backend invocations will just get strung together,
e.g.

> Not a git repository: '/var/lib/git/foo.git'Not a git repository: '/var/lib/git/foo.git'Not a git repository: '/var/lib/git/foo.git'

I think it's git-http-backend's responsibility to format these messages
properly, rather than it being fcgiwrap's job to notice that the script
didn't terminate stderr with a newline and do so itself.

Signed-off-by: KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
---
 http-backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 52f0483dd3..bda8bb91e1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -143,8 +143,10 @@ static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
 	end_headers(hdr);
 
 	va_start(params, err);
-	if (err && *err)
+	if (err && *err) {
 		vfprintf(stderr, err, params);
+		fprintf(stderr, "\n");
+	}
 	va_end(params);
 	exit(0);
 }
@@ -159,8 +161,10 @@ static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
 	end_headers(hdr);
 
 	va_start(params, err);
-	if (err && *err)
+	if (err && *err) {
 		vfprintf(stderr, err, params);
+		fprintf(stderr, "\n");
+	}
 	va_end(params);
 	exit(0);
 }
-- 
2.51.2

