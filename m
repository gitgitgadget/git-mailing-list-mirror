Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0C17BA6
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520108; cv=none; b=X4inCqs345QgPAMxsp9hb7iFkUOAYIvM0fUFNt3l2MJJgLZj+hkbkE09sDQ7Gl+CamyPRYsKVfsdONbcsReb0kgnvCW5vgevcdLPdG7HX7wtTo4gJAYi+/tRO6knlsLWmJDWHSiVU81o8o8Z68lwP7ANQvPCNdG0lKeKnndeLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520108; c=relaxed/simple;
	bh=sgPewn2hbR4sPfRz0HNfoFfASaOInSbWqc9ulHJ7EEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/EjO9jD7583qYv4rlxgGY9XhsiYfI3Wu4YC8zyOMqY+Yx2saj5JTkHiwRjHShWqgmo14ZE32NIg8yNebRMy3txXuOxYWi1+BRmNK0YQquxtr+S2DxbGDRkCmDeMexaJ0QWzvna1WttZnZD0CxO5RAjBubQsgtpVNfbz5cRibxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EfZ9FHR8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JmcNqgH1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EfZ9FHR8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmcNqgH1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A17F254015D;
	Mon, 25 Nov 2024 02:35:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 02:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520105;
	 x=1732606505; bh=n/SBcfLCs8fQAOusGkO10aLtmIQXkEik7IBLkA2zHao=; b=
	EfZ9FHR8tdO1bGePEcz3iXZlAEhwsTLtKcyS5DN7Oq3sD3n95hBle4ZcZtJ8PdHL
	DIxMgRR5tAV+VFy3xzyKkVruOORhCHKZiPkvfx0JenFJOCK1d/EkdCnEaSempa/G
	WnjAh6JxfsdKxGpam6hs3skx3Dwap+cX0akZNo67+WlsSVfTO3Qp8DwCRl0GnBrC
	WmgNMS2DJm/9iNFEokvCPFFB5064ZrYcdHSZHjExyz6J2p+1vCwiPu7oP+fPhkDz
	bxCg2PFuxCvPSjDyK61yXWqWDO7sPBHITP9lGV2o4W5J1lXZtUbcB0cV/ecNQzoh
	uaPFyeAklMHvDV2MAUlLhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520105; x=
	1732606505; bh=n/SBcfLCs8fQAOusGkO10aLtmIQXkEik7IBLkA2zHao=; b=J
	mcNqgH1p14VGzN4xPHGnsO99Gn27jDRyzRSVI5l+c9+jHtXVddfcoT1O1pBykHu5
	SEGaKXE8CBAFtlTUAhUWGlX1lM4eSWlkPM64v8lRjHLubuCmuUYVlulVaK4UjpW3
	QPg4TqWUo7TgYQ8rLYDYPZLfoQNF+m2fQ+VFleDRoS1uKBuyv9RcC27SBVV0ijMZ
	9W3OFZ6s4yHWXVt3T0Ghte4efSBLlOBAv3V/3xK43RyhhvlLjKv1bbFyOzpHkUJ8
	Xb1dGiYI4LgDoA9OGhxBEG1D4y1F7dDkIX0I2VemyHyyZSPnYUedEtA2vzJ8fu/i
	qwcFmHylKNRmFteR2pB5g==
X-ME-Sender: <xms:qChEZ4UX9cuxaHmzDE-y2loCMfZy90pHQnDl6nkN8t6XYMOAoFohCQ>
    <xme:qChEZ8mdDlcFMOjZUaE1uA7XqTEm9JpLBhq8q4zD4nnlYNwFlneXy7Bla_9fWsXqL
    szMKy7lL6GVHynTxw>
X-ME-Received: <xmr:qChEZ8YcqO3nxWHoPb38NQXf1TYDWy2f3u2_gyW4EdDtpYjZ9kn9ei-YzGrcwAAvJyTZm0Z0xGUVTh133xQCw5nDesA94eIY6AJu5JMWT8Uq0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuh
    igfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:qChEZ3WQ2bmhWr0ciCuXuix1gLADCaGu3YRsXFNoeBCAXmlG-ne0OQ>
    <xmx:qShEZylki3f9AG648JO_e5QxHgQs8hdKpggvwrYHTUocNxtmOr8Nfw>
    <xmx:qShEZ8cXCYcQszClPQ7zSkiNDKrFK-7G7ULEHQ8VDAaEv1E_o6lqzA>
    <xmx:qShEZ0F7TZpDRwdpSctiDv0V3hz6Q38DwnJx_vDM8-SCL-fid9eZLg>
    <xmx:qShEZ3xt5anzLqp76DF7B2IK69EcNc2mULI5SVsWnT-kdw0JdD5tBrhY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:35:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 734eff5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:34:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:34:42 +0100
Subject: [PATCH 1/2] refs: adapt `initial_transaction` flag to be unsigned
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-refs-migration-optimization-followup-v1-1-0e1b4a2af384@pks.im>
References: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
In-Reply-To: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The `initial_transaction` flag is tracked as a signed integer, but we
typically pass around flags via unsigned integers. Adapt the type
accordingly.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 2 +-
 refs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 65eea3eb7734d03f09a22e8edfe5074d532398ff..ee870817466b7d6d6a6619ce0baffe17f3d5a39f 100644
--- a/refs.c
+++ b/refs.c
@@ -2325,7 +2325,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const char *refname,
 				  const struct string_list *extras,
 				  const struct string_list *skip,
-				  int initial_transaction,
+				  unsigned int initial_transaction,
 				  struct strbuf *err)
 {
 	const char *slash;
diff --git a/refs.h b/refs.h
index 980bd20cf24e15144aeff991eeba8b27a936d386..95baf194ba9493f4e8f1f70924f0eb713e5bbd49 100644
--- a/refs.h
+++ b/refs.h
@@ -110,7 +110,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const char *refname,
 				  const struct string_list *extras,
 				  const struct string_list *skip,
-				  int initial_transaction,
+				  unsigned int initial_transaction,
 				  struct strbuf *err);
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);

-- 
2.47.0.274.g962d0b743d.dirty

