Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FF1F5407
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308006; cv=none; b=LeeM/Q1/ldlWudXrjpp4aKbOGR895YGWLMt7EVyBvCHZONSIbiSmMq9fOBGvQCZjpws1CedIw7cXDyZzZN8b3viNaI2prRSpkLA0pMmJBvw1uvD15ylSLdKBE8cvudjzRdmbPWEZ2gbDCDYc10Y02fYL2pz08+He61f3d8iL1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308006; c=relaxed/simple;
	bh=G7bll/iTqD6mOxHLRUiv3nmSOIv/sQaeQeVTDynXsu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVqSQ2DxzreVI+F2QW+VQqCc+iJxUThfsywhwi5WRMY/vF10QXUxv7SwPA9xPSujYhFHFNZhIS76gIYsbsTYNpiF5XNKIj5JtNI1gZDdGE5V8SOThS9TuO3+cvc4HlHUdcKstZP93n9NrgxRAoQl+ve/C+iYNXQvSbcoNZpMcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CM2QZQ31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odvISTyw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CM2QZQ31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odvISTyw"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DCA0114011B;
	Fri, 27 Dec 2024 09:00:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 27 Dec 2024 09:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308004;
	 x=1735394404; bh=7QylO4lrZ14ILdgrFzFd6wQLgQojwvND8WJqqGggpHI=; b=
	CM2QZQ318qhzVqKYwBvDOx5QrTWkFC0/DHVSjpmL85HFdSJ+5jdjVkfSTWe9XCpN
	7ckUN3SpSoc4xadBm8Cuykn741PTAPskhPFDZQCj+xbg5FY2727LnjW3hR4dIbRE
	Lz4I18ynI/gerR0PWhKvt1em+1JicDriBcVPQBHG7X4N54P76tOWexSHa8zV1wI9
	gqfw29NuiYjnn2LnOMBgVqeI4ioYnUfuuxTIcmxcQUtDQcMRYWh0NXPWyp/7ZX3y
	w6qCulUszsz0Y7xhMc2jKLgQQp5ANnRl5jU8z6686d0dTgNvmj8tZBfFQpca/RLx
	gv686gJz7qZ4rusNgz0D4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308004; x=
	1735394404; bh=7QylO4lrZ14ILdgrFzFd6wQLgQojwvND8WJqqGggpHI=; b=o
	dvISTywKxs6vxV340vOWRxrqADHrv8//U3VtlMkn9l7b4TUvppQ4A2cjb/GvdUOT
	Yr24ugEqs0o6YbPQKj5ZfCIDr227edXWEqv2C/V9+O5bJoiwQysOpGyeFCTN4pzl
	R3sBbAkLbfIZX6EUBKzU5jDmEEj8bxi0Qbk00nLdovpgYscgM9B57DIdZP0x/L5u
	aSk/VYpkuPtA7AVjcbvnMDN+d+xxvZyjGLv7PoRj4nDXKhRRso/fCXdSLFBSjRc8
	kuuess1jN5fljv/vSmRjmPHkUIBMgkMjJ8oLKN6NMHQSzLWgi0WcyAizWaFEiD7D
	Lh9IWmtB04gDEeuAQAgJw==
X-ME-Sender: <xms:5LJuZ1GSWOJ-228JjVtUBaYLd5RsDQVfqmfKUq5e7oRZSsRcaQYlfQ>
    <xme:5LJuZ6UuzVs7yDcWTYi4vDDu7Pl3y_zxhGeVRRSm0b0v-Kv4gJ-yb2zUeuwvhy-gf
    v5hyac7TlPpaKLYhg>
X-ME-Received: <xmr:5LJuZ3JywXus8KhcVZuMgH-oI3XzJRAYiq-xiWZqWFi6gwxknZHknx9mbt7gxs-CktXTR2ZqvuGOA2U_aTaJdgXK1q3MlGSoSTe5o-TiuqWPNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:5LJuZ7GSKyC8gnh9m9jEsCPOy6QmWncLSS0zvrvK-FUkH9CmzfQrjQ>
    <xmx:5LJuZ7U_yM3HCUv-b0Xz-2K9u6Man4QkmUdbTZZTWRH-kKHuo9_z7Q>
    <xmx:5LJuZ2NaQrl6nQh96RHWT4s17f6riaSHpHCK5T99XqqydKZGTIhn6Q>
    <xmx:5LJuZ63_Vh7IZ4Mwoxum-eQbGOGRh8-EXLO7P_lGoIx8As2A2MkRsw>
    <xmx:5LJuZ4iuVUNewvgdJEpvSkGmTl5N8bourJ1F7WntZwuN7g1UiVPPbp0e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98f02edd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:31 +0100
Subject: [PATCH v2 03/12] meson: fix generation of merge tools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-3-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Our buildsystems generate a list of diff and merge tools that ultimately
end up in our documentation. And while Meson does wire up the logic, it
tries to use the TOOL_MODE environment variable to set up the mode. This
is wrong though: the mode is set via an argument that we have fixed to
'diff' mode by accident.

Fix this such that merge tools are properly generated.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index b3c8b6c56339e10099f8c37a4d8198f402192520..c2512328ca9b76a5dd512453ddbb776faea7967f 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -318,12 +318,11 @@ foreach mode : [ 'diff', 'merge' ]
       shell,
       '@INPUT@',
       '..',
-      'diff',
+      mode,
       '@OUTPUT@'
     ],
     env: [
       'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
-      'TOOL_MODE=' + mode,
     ],
     input: 'generate-mergetool-list.sh',
     output: 'mergetools-' + mode + '.txt',

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

