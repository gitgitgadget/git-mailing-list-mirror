Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB9202F67
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728236; cv=none; b=MXr2gF4MLp+1hr7GPtDqC8e1X+fPQFLtyeVh63cdZHGs6azk2UBcxANMT8677jcV/bv7104jdQtnbLXRrbjiOl4FTZN0tXkfklwVZjnt2woj2DIZ6bN0WXUWSCOiRDwllzxSYrGOn7ixgmJx+ilhQkqzzbHf5P/OdziPESvHVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728236; c=relaxed/simple;
	bh=OzyilNTKRj4tWykMP1g1l6im4i33HAcmT9Bo5/W6D2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCoqVy3T3iNg/m64Ao9TnXd6nOGsI6tnZWTQyvAzV0PEewM7wVWEUbdJk63e5laAqKDd+3hioAbJ0j8scGZuM58LLuaF0aWShFYvUS82YfQ5s/5NvmHd3b85weX2SqEZkfaq9F6x7RId/cyva007nCTphucuE8Nj6KMcqHX1Hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gZoe1a4M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1htrkV+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gZoe1a4M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1htrkV+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EA8B1D00192;
	Thu, 17 Jul 2025 00:57:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 00:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728234;
	 x=1752814634; bh=LZsr3xQK0Qd+mpPJUj3bLk4qXorbMvdk9SKdpDwek8M=; b=
	gZoe1a4M29mkeFyD/xofWleflqyiZiriRiBjQTB8W5CGLFISUA3UhakT2wojINWA
	FD/DBWI9RD0h+vHrrDgQqTMi4kQa6NaspOOlg/DaRmtsB+9mh7+JmEQkDf/IA+om
	W6tjTMTxCa+b8NOlhG2jbeaVJ7XT1Kn4iEEWC7c0XU/XyHzSwROJd8q0kPwPGCyS
	IuRtPUmQIVpvL5YUjlRTZNFuiLobT2AzxPdz4yRI0R6ipi6uQyzUHIICC5Cb+IgG
	65CYUj7SGaK3fi8j10hzvz6uxkzp4WBcWjRtnFHs0anzi2k74dV2a1KxZoP2kO6V
	m7Y8ILiw+rTxexIT5M+hbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728234; x=
	1752814634; bh=LZsr3xQK0Qd+mpPJUj3bLk4qXorbMvdk9SKdpDwek8M=; b=a
	1htrkV+5LuUicKnVjtyxBituQbONjFH4GHuXunblzdaXUPOweZPl0fNKytQjLESW
	J4SDTtZRz7PiNAcLcm8cWbok9k3Z4eiBVD4Y1gYlWRhXkhwJ79sYVY0l20ocVu+Y
	gb399IWNpKfsZn6PBeizDvjhFoZCz2MFN6fPZaJhs/mN9cE7BteoXR5tATklpIcR
	45tJ3GzWtFmfKwxAkfm3lbZoOVkFMmbQpYbRHrMZ7D4uGbGcRyJkoth1m+FW7uw4
	0B4gUTQE6RPvTkGdVkB/P6W+GX+KbzmSVqI8Na0bzA+F2j+IdsZx8fhkuss4abCM
	ODmemxx++vy16SZ+1tVrg==
X-ME-Sender: <xms:qoJ4aORt-D5TOLDut9oXSNX9C71LSLGJOvkSP046jtIPnU711ItIwQ>
    <xme:qoJ4aPQ0xKsWexmfwdj9Xy3fLQ_rkbA-PACqclsqzWq5gA6yHYEKFvKtWvZLQ-7Eo
    OZO1_DOLGKMTOkBXg>
X-ME-Received: <xmr:qoJ4aCTurlh0M1oVS5EjBjzO-_Gp6jJd3e92ErOP_RFQ7hufjxYKznN3Mp-j-aEwd9iHih71Y7GJG2aylRBcrDMrcb76XOFDfxc6awt824dx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qoJ4aE56teLZKzFIp_JT4_TIaaS1KrF45E8G1tXqqV4lTaf0Qfw0eQ>
    <xmx:qoJ4aO2AC_udjvpdqVZQwjH6AnFDOX0GNyfc_WfeEcAnXurZegYZVA>
    <xmx:qoJ4aPAacPBvmJEKgSmpXUEphsKh1DfeJ4QvRMXggfXpfe393jFpCA>
    <xmx:qoJ4aJNZoAQzUcKYiCxPnmUkxIG3twvF4byrFxHxJdbQBv7gZyglng>
    <xmx:qoJ4aMP4b93OyCLo9xtmM7EjNlAgTQdUOp7BH-mJRRcKK4AcKknki8gz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:57:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e6aaff7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:57:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:38 +0200
Subject: [PATCH v2 12/16] object-file: remove declaration for
 `for_each_file_in_obj_subdir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-12-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The function `for_each_file_in_obj_subdir()` is declared in our headers,
but it is not used anywhere else than in the corresponding code file
itself. Drop the declaration and mark the function as file-local.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 14 +++++++-------
 object-file.h |  7 -------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5a936f17148..bd93f17dcfe 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1318,13 +1318,13 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				const struct git_hash_algo *algop,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data)
+static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				       struct strbuf *path,
+				       const struct git_hash_algo *algop,
+				       each_loose_object_fn obj_cb,
+				       each_loose_cruft_fn cruft_cb,
+				       each_loose_subdir_fn subdir_cb,
+				       void *data)
 {
 	size_t origlen, baselen;
 	DIR *dir;
diff --git a/object-file.h b/object-file.h
index eca323f9736..d52b335e85b 100644
--- a/object-file.h
+++ b/object-file.h
@@ -86,13 +86,6 @@ typedef int each_loose_cruft_fn(const char *basename,
 typedef int each_loose_subdir_fn(unsigned int nr,
 				 const char *path,
 				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				const struct git_hash_algo *algo,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
 int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,

-- 
2.50.1.465.gcb3da1c9e6.dirty

