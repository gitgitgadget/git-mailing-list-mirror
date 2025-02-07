Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0CA1E00BE
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929138; cv=none; b=uXS0CPy/9IsSFwJ+aSabqnYJ6E6mAy5gtKiKjpz5Oq514DEXvMe6JBHoOuzr3HhpwVWJln71da1f7jnklThRTHi75WeVieKl+TAU2M+TlcbOfDyyJbFEmAbubTM4p5tESwZnV8K22jCNuOnhAtYonFJ4jnYBSODiReqsbnLIYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929138; c=relaxed/simple;
	bh=Lxpgj1O4BqZGL/ZxQOEef5rHjZudctr5TxTybCrqB/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwt+NJZccNth5ct1CF2EPFKTgk6XR76QdXOV9VoZWowukPHduINQyLE5cB+Wr+dMxc2FogtRy/4E+8INUPOyN8080N8LlhSBAt7n24tiLLt351fKl1yfXGXVgYV0Q9c/KF1RnYWY5dGzQS1MGCWPCTFjhbheQC67cJl4f4kuSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fpvuwa5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLLuVqjF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fpvuwa5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLLuVqjF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 86D0E13801B6;
	Fri,  7 Feb 2025 06:52:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929135;
	 x=1739015535; bh=twqLDGPZSXwut8sVG8SfsH2zYlOtFP/hSAcnJDe3mO8=; b=
	Fpvuwa5MtYHAfj01C3kMnrFlxEk/RSMm6EmJh/v3JMKwYqWVONzo9esmj3gBMQn7
	qxsLb7EGycMcOuiNzsu68QaCPzlhgufuS+Ix+h3yk5foeBh/Y+h3rmvIZVmAenRf
	q9Dwrkqwde5J+g4DxIKyk6LP6bs8qovLhttk19F5eucnJBCwVYWOB+XEE2p0Qk9Z
	6/fd0ii4cXBd9OIIKJm4poSH5l7M70tyTnw/3sNVF6aHdc2UCIAuh2v84UMJt+q7
	zhfKTSls+qm07tll9FKrsZ/Vttau9pe4gUYC0ExH+Xl0H+EsjPFgxEENXYC4bmtF
	QIUg+Zb7oyE4AtdrmEIQ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929135; x=
	1739015535; bh=twqLDGPZSXwut8sVG8SfsH2zYlOtFP/hSAcnJDe3mO8=; b=b
	LLuVqjFlMKxWdSC6XQX5XcgKp7Tq/ZmtjpZOr+urXJleJ0kdQMoIm33ssGCOfUse
	LaJQPdX1Mi0uEIONFujLYGiDEX+d+OsrXvPphR+Vm868+0SKXwNDcrbOBjEgI8EQ
	IZLqLsRHtAnyVl3tJ1zr9MwCTcHRajwdCEIifsYUH8lid1V2CNcZoPW8vLJumkox
	Kp4hWxmre1OnZv8DuWPPCr4TxW4UjvFGvItL7PP1Ei1AReuxWItaF8+b8VhqrBkv
	zkyusVccPuOHZ5sXjVQRj3yKCy1TfHycjIZTohsP8xT0W+dl3PAleukfinTE78WY
	JBw0jHOU86WgO76c9p21Q==
X-ME-Sender: <xms:7_OlZ6R-piKOV25S8F6UZKoX6C_rR2aVsn95Aw8oqR7rnHXOkw7Y0Q>
    <xme:7_OlZ_xf0ZXOXkvBoCTH7AFjT9ZW9Ff_sDJQsMRxlWFTuPRtCjyTCT2svDQtAnt0e
    70UOwn9IiGFARayVw>
X-ME-Received: <xmr:7_OlZ32eEuIVfrCOtquhrj1IFeNT7rFkx4ffBSsvAug4aScY9tosWiT0zUq-SvaT3P1Rob79XmjQhkVFiQ-pUugb0HxDTWgcLdX_NNLl-jXUvbIR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvthhh
    ohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjiehtse
    hkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7_OlZ2A1ccIpb1UiKXvoPzp2iseHTpUawSNSTVDcpX-C3FVjFmVMLw>
    <xmx:7_OlZzi-6zAGb1OfdLfzttNEIheIlpew2QQeEvvoUgcvgn_nyUvneg>
    <xmx:7_OlZyrqzA0CGFLVPrQZn1oEZYN5nGks3WQ5vweU1JDMh3Wgc4vElg>
    <xmx:7_OlZ2gB97cF326m4HmUE8JxA4ihIYy9xpiwxDiu0VPjdSABMuPttA>
    <xmx:7_OlZ5aooNm0hIz-kAiWYje6oQmR4oJgUNEDrTYZ8h-yggOhscCGeU6X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b51d7c20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:06 +0100
Subject: [PATCH v5 11/18] reftable/system: introduce `reftable_rand()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-11-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Introduce a new system-level `reftable_rand()` function that generates a
single unsigned integer for us. The implementation of this function is
to be provided by the calling codebase, which allows us to more easily
hook into pre-seeded random number generators.

Adapt the two callsites where we generated random data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 4 ++--
 reftable/system.c | 5 +++++
 reftable/system.h | 6 ++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 46abf51ec5..e22577ec77 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -523,7 +523,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 		fd = -1;
 
-		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) / UINT32_MAX + 1;
+		delay = delay + (delay * reftable_rand()) / UINT32_MAX + 1;
 		sleep_millisec(delay);
 	}
 
@@ -688,7 +688,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
+	uint32_t rnd = reftable_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
diff --git a/reftable/system.c b/reftable/system.c
index adf8e4d30b..e25ccc0da3 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -4,6 +4,11 @@
 #include "../lockfile.h"
 #include "../tempfile.h"
 
+uint32_t reftable_rand(void)
+{
+	return git_rand(CSPRNG_BYTES_INSECURE);
+}
+
 int tmpfile_from_pattern(struct reftable_tmpfile *out, const char *pattern)
 {
 	struct tempfile *tempfile;
diff --git a/reftable/system.h b/reftable/system.h
index 7d5f803eeb..3bd4a4e322 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,6 +13,12 @@ license that can be found in the LICENSE file or at
 
 #include "git-compat-util.h"
 
+/*
+ * Return a random 32 bit integer. This function is expected to return
+ * pre-seeded data.
+ */
+uint32_t reftable_rand(void);
+
 /*
  * An implementation-specific temporary file. By making this specific to the
  * implementation it becomes possible to tie temporary files into any kind of

-- 
2.48.1.538.gc4cfc42d60.dirty

