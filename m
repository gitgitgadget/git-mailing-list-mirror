Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B216236449
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870525; cv=none; b=F0HU3FQNxxhkwle5XB3JG6i+fQclHwvXJywGNXGEkMun8AKtbyXCS/GHBm4VKA6Glj7R7ak0Wuz938zIP6cnNDNJKxQdiwYLkrQFqPHTwwUVMGBdhF3vptY+jOrV/pDb7/6mW2X4+JAehkcHckGH40eNBQgzs6QtNhPrfVMeSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870525; c=relaxed/simple;
	bh=FEz2WTd0LIU7aYBWQUz9uyBzLStPGTJXtNMbstYE0Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZR4qYn4nX688HBrYjvHQEL/Ll2iNen7KwJxXuvHusr9qpUo0oZzROj9+QbvrIWt5Qkcr9MaxW7lRX19YrR5yyadtFRokBfitm6VZHh5ZMBjLgblIUeBkg+GD2wS0LhOQ3ZN1RKhrOq79Yq3MFI3XpRgk1qNCZz07sIj51Gtoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OIMSm386; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oA+rquod; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OIMSm386";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oA+rquod"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1684D1140270;
	Tue, 18 Feb 2025 04:22:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 04:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870523;
	 x=1739956923; bh=GJ7NFyNMyMRu8vc2LaHKi5ZFhZOY2XIpUWZnpKgAa1c=; b=
	OIMSm386f0raoKASKGIzIY8y2TBRMr5G03ba+ur7QYW0B33B4koD4Fuj0k1wEwTT
	CsHcg8an6z5Y7e2DwNCvXXfTb6SB5qSwwIeX7Xrdz2gARbFv3CYQqodWUufjBJy1
	lXxXdFQCo2i/rWZDED1ZbctbXcTZwtuj2YAf20w+17O48dv5OlTVwSTmMGIw2kH+
	Qc+Ux7qVc1yrGd5PEypskIYomj8ECnyDBQbgHsSi9Kla317Okm4qRfVAKkiREUD6
	fwAjkl1d2P8f3gVjmz2VxF+DEJ/vJBmPWn2qqpb02lWogL9xqr1g9wAGjISqYsUL
	uyHY5O7tmfRzTIHcG2uC0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870523; x=
	1739956923; bh=GJ7NFyNMyMRu8vc2LaHKi5ZFhZOY2XIpUWZnpKgAa1c=; b=o
	A+rquodEeqPiZsYeJDlCZqACzhKfKeaGDeV06xvYLfp0Jko3FzjxpUECThCXZI9w
	/PZZCUTBSkL4TZAVNGCQlGThiMuDFuyJgOUGr3t1frOsBXNe0tFnmSJYaVPEK0y3
	az9FGz9suGoYId/DK7KXfwsf1kbflV/Do93UVbtz1TfyjNCR2WIl1eVINbMfrQUZ
	Fkdhr7qabv6MjRW6EC3WiERSaLKvc+Cl8xbl5fx8uJVBB87/lFENGX4xbGnOZLTz
	EltiprcH94u8ETap8W/ybS6YQXP5PH0Vcfd1GLCm5B278D248LALNq9f714npwHm
	5k+xEn4sDNG//v3lLMPSA==
X-ME-Sender: <xms:OlG0ZyYtATEH7IZuOv9wGXWQxDPe2KiqE1K8AqILoq801t3SbE9hlA>
    <xme:OlG0Z1Z5DscQ0SycU3LaZqsw44hL6einOY7cWD68fCtHa1w3aTaPLjfW9vqdJDBJc
    a4bSXZbbbXFcSkyAg>
X-ME-Received: <xmr:OlG0Z89F1Si_Rhf0HXZEBBXKrz7NK2kzUnSCUPvNOU9zGOaq7z2PWlzZ29HxQIC8bbZmlXlKR91CE3hZHmxk7qio14StJ68MxQrYhwqcpTJQwNMB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvth
    hhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:OlG0Z0ofPiEL406-fWM-Trsk8r6_8ux_43YU42fYjC2ktN07FZe58A>
    <xmx:OlG0Z9qSCzjdRQc3qPhflAS4MwQRb_2zwkcMNwiPFpxndS9rqJL4GA>
    <xmx:OlG0ZyT_uzBQreKPY2EuNxx1vkAS6TxyxeqU1kgSKZBevT9i6h9eIA>
    <xmx:OlG0Z9qLE4eTlpONn7VijfoCHKaizo0_bDJx9eaOGq5xLxLKNlwVTA>
    <xmx:O1G0Z-cnTNSA2JvhF6dCl3UjMzu5GZJvSVdCnQmu10rdOawanQMZ1ZKg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f9ab80e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:46 +0100
Subject: [PATCH v6 10/18] reftable/reader: stop using `ARRAY_SIZE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-10-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We have a single user of the `ARRAY_SIZE()` macro in the reftable
reader. Drop its use to reduce our dependence on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index bf07a0a586f..c3a36746652 100644
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
2.48.1.666.gff9fcf71b7.dirty

