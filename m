Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158235B621
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697816; cv=none; b=t4XEA9hqZ1Kqpa0mm8GLYslGk4uGNMnqqjc+Vq7uTXCuK21N1CXbuyuwC86EjAve1Y0kOb+/38EzMMEMcfjQooZC9hLLK6zdHJcJb4qrRwAwjMOZ8NV3yofTuAmEtxZUNHeyTgXpd6U1O0liFN39A3sy+RgmEXLhiJhmAQg2UXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697816; c=relaxed/simple;
	bh=nynrllJwluzPt7euNGljCriEqrpNxOga68asm5hR+pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmdxtXFpVyuO+VfF+Agj5TEozpLlNldrrCIsDZVMj302yf3DfPL84xT7162rYIpSsiMzzqvM9A7lZMwv4FMF8UpWg5Zq20LJ64ajg6R2zMwa8qYkBnMgZDgfoZmXbBnErVC5HnAQm4RxyfYXSCoQQ+bd+1YQwYaTnVIRAeuH6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VtRGq8tf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAu0gji0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VtRGq8tf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAu0gji0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40D617A0047;
	Mon, 16 Mar 2026 17:50:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 17:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1773697814; x=
	1773784214; bh=QtfSActhkARjY/0nmuFMrtMI64tcgz2tgqW5v+YWpfs=; b=V
	tRGq8tfUj1/vKQ/vMLLIIh+WN3jMFha118QRji9fD/DSdcZHdJSBvRQk1pIeVitF
	u6iXQrj6xq3g0Y6YUhgfXJgLL1IfJQjb4mZn53B7s+qt9YnydmCZ4ockiIpnLw2w
	Is89olBY3EHOHFPR5I6I8lIDIWeDXX4W6Bk1dD0rV1NAz0YTmBcKayb3qk6NmcjZ
	8RY7Ozyku1we+EoHec6IFWBRDgLXxrPqAlonom7CeAjv3DYUVUcS1jNgd7YqybpY
	ZlwCNpL8+yJpBCgPf6L+4qmaH427xqF3+o/2omnb5wUoiX3lX+B8tcu9yaAqcWiv
	qIXbLquJMmxStI6CU683Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773697814; x=1773784214; bh=Q
	tfSActhkARjY/0nmuFMrtMI64tcgz2tgqW5v+YWpfs=; b=LAu0gji0CJQoV1Izm
	cojDt5ZKGh1b5+3XnPeSStlVnI6P92Sty2Zvin/orknny9yPZWp1sMUhkSD8nts6
	qtsssxJKvqiOIIRZe9bPFlCDdEvISQB4MYvjuCeNGiZ1D+VIwkpB6tA6MgSj28Wn
	vdwsn9zA14Juj3fpcFdJ6T2gwbVpJNBJPmpODtzJmogre2i3bT2WFMU5jka5YLjX
	MNFTIuMDaF9mnBA90QclEPPbX3yM+J6hBCjcEZGZkbwDsYGtf08WWix8227t5Dgk
	YQirIEki7X6SiA7WI180/PyVQo8mhpYM54lTJSMJd378taDNtVITVH+o6UoucEi1
	H6rKw==
X-ME-Sender: <xms:FXu4aQNG1EJH0zejvi1DbvEiNwiwNPcVRj0X-DYsTfl4CJsmOeRhxZs>
    <xme:FXu4aeZ43gEPUASKq-HxqR4WSHD9Lx7n7DtJUILVuFAwiw2SIak_yTWuOUyYW6L1q
    b6KKneaGEMZi-HvhYbRyANJ7vXOTP-fwukvlmpZe4VTZNLXPPx3bQ>
X-ME-Received: <xmr:FXu4aUom3sgIk-0agcINlhMWMIoWKgU1lnxGSykWUkyeocU3PvIYs4z6I_x8CJd8N3OhkrG0RVXiC7gKfWiKieSnT67vwnenzkDF4PvB7Bde27WztUosd1Ai0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfh
    hrvggvrdhfrh
X-ME-Proxy: <xmx:Fnu4aSZN_30TSOcB1uGwzhOWLhMXmriQatfqO-rp-A62A309LNFLjw>
    <xmx:Fnu4acR4bYKWfOQK3OElM4g0lafLAw7vVYoUmLhB3FIueX_qJrsxFw>
    <xmx:Fnu4aZ4EXjrhUMCRDQKvbwB68nGN7O7G_eZF6bXv9cBy3zRqwJKakw>
    <xmx:Fnu4aRz1qAWc5Z9wOy1va04jpgpMaA-nRNZUFCCyiS9qwgPzo5kfRw>
    <xmx:Fnu4aeDkDcN6hQA4eZv1z9h3iAjIRkgGk92USxyi_65SHykyuv8uHmLz>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:50:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 4/4] interpret-trailers: use placeholder instead of *
Date: Mon, 16 Mar 2026 22:48:27 +0100
Message-ID: <doc_interpret-tr_source_transl.50e@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz> <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Use `<key-alias>` instead of `*` in order to be consistent with
the documentation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 41b0750e5af..4b617c3ecb0 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -211,7 +211,7 @@ int cmd_interpret_trailers(int argc,
 			     N_("action if trailer is missing"), option_parse_if_missing),
 
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
-		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.* configuration variables")),
+		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.<key-alias> configuration variables")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("reformat multiline trailer values as single-line values")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
-- 
2.53.0.32.gf6228eaf9cc

