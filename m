Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2511FCD1F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728217; cv=none; b=Va/WhQ9XS2aURlmcf8t6dNMkEdcSoP2de1oS5aanIR4AIuhRwt6/zc5VSQBfwckKD9qUcN+BeJopflF76jdFuKYvrMF5f605C6oP+HjadD8WbJknpmUYIT1vFTGJlXhXfVomVsPSRUcGtUjhqHIJUj9+x7jypD/VgisxUy6Pw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728217; c=relaxed/simple;
	bh=fSCmSPaagdSNWQA7WE275UqmRJg4/G1TwUAG9PTBpcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fg54YVdboZYljNHuuarzcx6USdC+GXfnMtXbobgfGI7rA+Gm+uohEpcAN9Wop921UAzYzSRMl/kojWdKQOOygZuZvQFwVtLnHv5LJh3kqH4c+7S/HmfUXcfgyitOKoTVvpMnOqtVc3zs5rf4RZdIj8BEKX+7/m8LaTjoNajK+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NaxDIP5N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MR9Oputd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NaxDIP5N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MR9Oputd"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E06E1D0019A;
	Thu, 17 Jul 2025 00:56:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 00:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728215;
	 x=1752814615; bh=cSR77K8B7S3aZrpc9hsPXpxayUIrovgMyUoHQYGLcSY=; b=
	NaxDIP5N73vulc0hqFdqON5UXnUUWgFf2NT6b1W4BoTYb7DK+o8bShS6z1+5hnrm
	ZIUjLvEyXMroLA5VYft8C3lzF8MA52n+mFRmMAwef1jQ3mDC/vjG8DHAzqjIzo+i
	WqOdCppTp73KxysFKWn4oZuEhprXM7XmCMLFFaOZC++jYVkSjp4QuVy1LfkjvXq6
	df17NQvEV0UHS+IBCgO6lvzGkU9j8yntlfWpHa8uNVFN4MVWI5Ok5NtzMYt8skq5
	XLhoFhEBqTxRjbhkEbSNWUYXRyPWjK/3Yj1UrCa0NRJNgUsb0rP6w6iWOdoZK2UW
	/ILOXE8qFqWz+JG2CXBkSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728215; x=
	1752814615; bh=cSR77K8B7S3aZrpc9hsPXpxayUIrovgMyUoHQYGLcSY=; b=M
	R9OputdE/taBhW3bhC1hqKIkUm7rIUen2BKo6H0j5vSoSsDcPp+4KSlZXY/BU996
	rxKUXCzPBl2/E08k5ZSpJqqqaFEE2oEwQcNzm1ek+ss0SfKPQWqmPBr04AYwj0EU
	nq82mC57Ea0brGrNYn5JkU4tmPC7KgZeLfomKDuQKGb2y5p5DdEreJJk9Jk2y0kj
	jXJ1aljcazYRzzGFjVDwZbSc/JF73HVn8keBnhm7ZhxTJPZ/KgXku8PVgCbRGL92
	gL0TNPtd4OEPinIzBsJLgxAW2C4dkQTMAYaUcyCexuZsm3ZobAkIr4qIp624UCMU
	+0rZ4eN89jEuiAnv+Q52A==
X-ME-Sender: <xms:loJ4aCiVfODjb3-eHlM-NBii_-3bxCRHO0jNLSDP5pOoVoIV2K0O7g>
    <xme:loJ4aOgEAFeOeFm12a3ooprFfHCrmxr-bkLy34GMnM4mNxPymQ59AyTjaukQHTSVL
    sRUdjZXwpb8mlONtQ>
X-ME-Received: <xmr:loJ4aAix60og9lTyLtOZOtHvVforoTEQCt83e8Mb2kb3mYj_-wNmr6KdkhLu5x7241_MP8HajRIz4hKdL_qV-8o_zigrqLnPpqOYcYN8PlZ->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:loJ4aGJN3f9r62wDsTegUSsOpjNnOmzZFg2687shZk23VBCQq2A3lg>
    <xmx:loJ4aHFYFBuFr-k8s7HQ4cnMxj3nX-93OKgGiE6Zy3mgg3epJHrt7Q>
    <xmx:loJ4aCR2hKuTa2-jMwP3D-YagorypEzbRSros4fNeePLFrhNEGIriw>
    <xmx:loJ4aLfmKyL9xpXVtOVXWQ6xEVG6grLKD2w46gc19xjwOb_Q-Xy1Tg>
    <xmx:l4J4aJfwIAR-YewmghvYuhXsGroXTbMoIAC8L40-1Ia8ijoefgBswagQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f0d8bbb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:32 +0200
Subject: [PATCH v2 06/16] object-file: get rid of `the_repository` in
 `loose_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-6-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

While `loose_object_info()` already accepts a repository as parameter we
still have one callsite in there where we use `the_repository` to figure
out the hash algorithm. Use the passed-in repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 3453989b7e3..800eeae85af 100644
--- a/object-file.c
+++ b/object-file.c
@@ -421,7 +421,7 @@ int loose_object_info(struct repository *r,
 	enum object_type type_scratch;
 
 	if (oi->delta_base_oid)
-		oidclr(oi->delta_base_oid, the_repository->hash_algo);
+		oidclr(oi->delta_base_oid, r->hash_algo);
 
 	/*
 	 * If we don't care about type or size, then we don't

-- 
2.50.1.465.gcb3da1c9e6.dirty

