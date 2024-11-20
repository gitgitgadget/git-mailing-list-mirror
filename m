Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7851B5328
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110001; cv=none; b=aMyZpqTUIK2EjwAl/squoIpBndUcB0fvjNvTIAJt5QMK0kriC+HY4NIYptS1Pv5+/Zya3pWzolIInZlcopsxRy/6jJwxAUr9jK7lpZBs+XXcFin7drIw5jLZY6Tgw2U5Sj9hS5xzjVzv0xQoGyKh31OsWM5Qf7/ZKpWY/yNam8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110001; c=relaxed/simple;
	bh=7cuPGY9h/BiOQg9GV9i2roIBUx86uDHtYkuocsUCmbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHxWQbs0zdx6Q3boxN+GAhsKm01IXERKFF6lA4Wk05LzXesyT7KVqj/R6VrhsNQCHMbQHpvNACtoIyg0R5CBdTgZN+9FpE/fJoAnGMRtRTy5hXJ/1wQMq6zurzQb5t9mo1x+xvxQok7rmXxPP/yR//kI000D5Uu4v/s+t7igv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ph+R9cNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hbq9fox0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ph+R9cNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hbq9fox0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 77DB113806EB;
	Wed, 20 Nov 2024 08:39:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 20 Nov 2024 08:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109999;
	 x=1732196399; bh=tAVP+Y7h3hvg2arFrI1XMB8ZIFfMC0fHSDxBnct8Bz4=; b=
	ph+R9cNBwYrbOnzHAMM8Iz8wbsepA649EORgawPH0hYGAkL5owj36gL+5iH+Mkj4
	smpvwC0oGKS2SQZHqxVeBUbv/b0HdUJF6vWPsEI+ujPDVPazvQ6nA9n/XnxeNQ3O
	QpZhYUhV3qqi+aqQBaTAwfKlkb+f4FW3yTfbTVj5kY93Eq3XrMhqpro9YRoYAZ5t
	gG5zLRtR/KGSGEZEF9mMBD0CtV3wTReO1pKp4QdJKLvt2Ju8ObgepatI6oLDFDU6
	rHTNvqOsYcRT4H6c5r0QM8LVay2DFttaFjyRr++VoYhQJp05LxgKyWTOWulA2BgT
	Iywzsce4JY0YGLbKNdggkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109999; x=
	1732196399; bh=tAVP+Y7h3hvg2arFrI1XMB8ZIFfMC0fHSDxBnct8Bz4=; b=H
	bq9fox0UyjOjx2eFXNsS4Pdh6rTiGFQOzoia/SRYPZ/aXQxhDsSGNTXBSLl7yb7b
	eNSQYgiga+Jdub6irhZ96aX9cIMfN4sPi2uMHpGvYqELEYRMI+pBFFUlb8XjwASl
	8xWjv1fh1AbIvLIyqzLiLPzOIBjKWVLuJ2kRNkH1Cf5XAVQhfbxKi9APPEBSCCGM
	SnVh5RfPtOJNhNdh3FAUliIuyc2dR0VtLLN9xOGBgNcIz5Gdcd8qr21H2rHBJuPc
	n0YlwZkTV+tEWURkTcDLOmZQu2dexZiJ9RDnvGpnpRkKxPEBHNkcjGlgP23iYAui
	2FqWi9sxmkWvO66NXGGgg==
X-ME-Sender: <xms:r-Y9Z5SxTF6mWw0swkYDPGqnia52IOLUtMv2iC8AL6FB8RsDy8L4QQ>
    <xme:r-Y9ZyywmGJzaSCFB5h8h89W4d_VMd3wxONhn9jZz4DR9rDVQeS6rmzbPT9sX2W0l
    34VCpA4jAIc4xRljQ>
X-ME-Received: <xmr:r-Y9Z-3iOrFNkTvBdU3vN7meAXdYs2JhrtUAhJtrJ3qcmLdhQoWAyz0UIzlnp-KKFoE9IL4nOWyGyGvfVLd6WujjLvhyU9ZmJNhYs3sifacJ8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:r-Y9ZxD5Uls3FnZz8VwuvV4k-nArJAR_2HdwWgcweMMhFiMcO4pTVA>
    <xmx:r-Y9ZygwHCWYvsZQ3ehT-ba-WRGjPi0EtgJ4B5K3jlpu4wr9dK2W5g>
    <xmx:r-Y9Z1oNC7ZiGPVGQRvpsLjMKLKM9cLRzWTLwuj5zhQujnIU7Qq3dQ>
    <xmx:r-Y9Z9gcST7cTbltmyUKRphHKH0yJ_X0drBOWgmPXsc2WjASJgoWug>
    <xmx:r-Y9Z6dugBhlYAQkt9J718BM92SKDhcD0HIM51lfCRjEIEaIf-KWMCz1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2238e9a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:41 +0100
Subject: [PATCH v3 12/27] split-index: fix memory leak in
 `move_cache_to_base_index()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-12-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

In `move_cache_to_base_index()` we move the index cache of the main
index into the split index, which is used when writing a shared index.
But we don't release the old split index base in case we already had a
split index before this operation, which can thus leak memory.

Plug the leak by releasing the previous base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 split-index.c          | 6 +++++-
 t/t1700-split-index.sh | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/split-index.c b/split-index.c
index 120c8190b187bc8c6c73630f06f5dd4dc994df30..cfbc773e6cd3b11ea5f47ab92310a56c30f6971c 100644
--- a/split-index.c
+++ b/split-index.c
@@ -97,7 +97,11 @@ void move_cache_to_base_index(struct index_state *istate)
 		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
 	}
 
-	ALLOC_ARRAY(si->base, 1);
+	if (si->base)
+		release_index(si->base);
+	else
+		ALLOC_ARRAY(si->base, 1);
+
 	index_state_init(si->base, istate->repo);
 	si->base->version = istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ac4a5b2734c0784c2cb8878112a5ead9593860de..2625ac44889a5c9219e9575a9bbc5265d3c419d5 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -5,6 +5,7 @@ test_description='split index mode tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need total control of index splitting here

-- 
2.47.0.274.g962d0b743d.dirty

