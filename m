Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4481BB6B8
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086498; cv=none; b=Av5TBprlb06xZukrVpowPEzurD7NcICt4kEMFABOucZGi2wiKmqoXQJ0dBoJhv4V0Tu2id3blwWBsnBoEf4iwJfzDPTn11T16ggqX+HDTz+Cna2pDuSUBkHojcUy/4iRM7sklhTBpIDQDB5UhqdXWp4RvU5yHdoxMhGSfTUWyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086498; c=relaxed/simple;
	bh=2bmg5NkD1ixBASsbLLpKnmCcxrwiERIr44CDFLV9U80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZXi0nFifs9Z3p50HFpO4fBa7xyHucXZm/dSUSnwFP6uVBNPblPkdcpwH6SxFpJXVEVm4aRJV82kJZ2aoUZxQ1Zq6+OAgXfP4Cbvkc695Ew569UKPKLEr0BfdDnfoD/p6dK9Z9YktFH9IS2rYLYy/ENSc76d9n8eorma1+qANyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nT/MXn8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=scmXgsPP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nT/MXn8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="scmXgsPP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 61AAF11401EC;
	Fri, 13 Dec 2024 05:41:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Dec 2024 05:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086496;
	 x=1734172896; bh=yvMLNkt/JLszeH+3M5ZItNzbBp4Kbu1DLgpAavvqj3I=; b=
	nT/MXn8p+rsLMOGCPXAp4iVX0EiOFkTOMSW4ZZvPplB4OC0I8MdMSKbn8NCWIDxR
	1aVsJDFjPWxP3xtnprj6UKP+gcZaZX+TZBHITgJDdffYJPhg527o6NkmxBLeUJ0O
	sRjjqwhvkxK7RostTWOp9viz238o++tNTZmdqEmjhIU6fzeuzjutuSSpx4iyMiOq
	A0c4fipRCE4w3jE7JW/Lct+D0MFkLa0nG3I8zoiUcqmuf5gpEh3cXsPkDcrU32PA
	X6KGpmuKenpaxyjdc38PNhlbJFc0G/TTxX0VOXKVKt0lAFcdcRlikkUa+MnQCyE6
	EGrsGdQzNGPTuQ5Qk/nY7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086496; x=
	1734172896; bh=yvMLNkt/JLszeH+3M5ZItNzbBp4Kbu1DLgpAavvqj3I=; b=s
	cmXgsPP07gb1wiwOloTwZ2i6NBY6ilKPt37QUoNk7NgRQcuhu7cGgM0YfSjT736/
	0vqGLnEF3gWfDFPcWsQOpQXqzOweivkjrdDkzNtt+QixKfRT5KcGlfao+iDTr6ZH
	hCu/iyU+2YvhtUvkOWEiJnbWz8D6u2qqQkruzaSVYLf4hqbUa47vj/c/2VJ/8Tre
	rsJEiS9f27+NV0rFPq00aMLrxtQr5TkOQ1h5uSAVNKAIgiULY3azB/U8/tNWF5+F
	eyOwyLxbHyngtrM1MExU0gI10jaaqT4TX5/ledRyweNlfMWFf8ryu09r5NGSkdvc
	Z1O/RCrCVFb5nfiUpc8Cw==
X-ME-Sender: <xms:YA9cZx0KNzM58wXRbfdQXZCehzvEUlOjuxQMdxvUz8SkEtZIIqZbmA>
    <xme:YA9cZ4F4NwKCR2hdMNBZyhlmqUxzop2XM8bVM5AoovfTpb91mFM_m1knYagEElKBy
    -Vbhxf_HAnZ45gQaQ>
X-ME-Received: <xmr:YA9cZx6NLrTbru5Ae8j_Gt9tvbQMPyr3xfEi2AH8-buqs7KdP5rwUS6_Kfxs3p71YBN6Zz_4DGD8Y8Nqa0j4tadFIYrrEMzhmv96L-uzOBmYa2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:YA9cZ-11JusRVnwgmsAV3YxmBPCygxFqLlZ0oCaTVJGbfmTzzjl5Fw>
    <xmx:YA9cZ0HoEiaWWAIpXdoCR9CdS0JRbsknjANRefPkqMfkmkSm-DfsEQ>
    <xmx:YA9cZ__liS19_mm0u_1MdMatoKJoT9nyMwgwYjyov544GtDm4SFByA>
    <xmx:YA9cZxmZC-REuFokq4T1yX6XhWMUZgZi0hiExDuqEsuAjbgKJWgBGw>
    <xmx:YA9cZ4BsIwneTbIChh1WsFhKuV17HQlHps1XbityYqms_i24Fqd780dM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 37f3ec84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:17 +0100
Subject: [PATCH v2 2/8] Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-2-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The -DSUPPRESS_ANNOTATED_LEAKS preprocessor directive was used to enable
our `UNLEAK()` macro in the past, which marks memory as still-reachable
so that the leak sanitizer does not complain. Starting with 52c7dbd036
(git-compat-util: drop now-unused `UNLEAK()` macro, 2024-11-20) this
macro has been removed, and thus the preprocessor directive is not
required anymore, either.

Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile    | 1 -
 meson.build | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index 06f01149ecf399ae4bb1932188a007948d767283..2506f3b7e3377ab1a376338c86a727b2ae92a6e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1490,7 +1490,6 @@ ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
-BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
 BASIC_CFLAGS += -O0
 SANITIZE_LEAK = YesCompiledWithIt
 endif
diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..1af25af5cc1e718a4e50fb14274a36f811506219 100644
--- a/meson.build
+++ b/meson.build
@@ -712,7 +712,6 @@ else
   build_options_config.set('SANITIZE_ADDRESS', '')
 endif
 if get_option('b_sanitize').contains('leak')
-  libgit_c_args += '-DSUPPRESS_ANNOTATED_LEAKS'
   build_options_config.set('SANITIZE_LEAK', 'YesCompiledWithIt')
 else
   build_options_config.set('SANITIZE_LEAK', '')

-- 
2.47.1.668.gf74b3f243a.dirty

