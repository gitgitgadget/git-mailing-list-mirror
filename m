Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDF225A25
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828349; cv=none; b=ui6PhYPzpvj9WOkw0X5V/8QoXAZ3b8qQOwQzD08b+y3XxGXnqDYqF4LsBWRZxngRYpEx28PGjswLmfUZ42Zy2a0oaj6hpwsb9reSwj2Mp2U35gy2AyY2Mps2KR02tMuZGYWn1NH3FicnrMtaL8CJAGrOJLHj4jOpPZZy9cn/9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828349; c=relaxed/simple;
	bh=Lxpgj1O4BqZGL/ZxQOEef5rHjZudctr5TxTybCrqB/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNHV/MUPwxT6rE51p3hK70N5sGVCZ1ROkHkBK7bA6coBKwCT65gBonp+eCS6dD8i7ycW7MG2RX57C2AGPPboIl8aRx0mYSAaOCV69OfYURlThoo+MxuS6Vqwp//d/TZqcatcqk7xjE4SJAtO+JO6PkQkAH53l5t3p0gqjDoxqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OZWWtp80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yTooYDM9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OZWWtp80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yTooYDM9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 847C1114016A;
	Thu,  6 Feb 2025 02:52:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Feb 2025 02:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828347;
	 x=1738914747; bh=twqLDGPZSXwut8sVG8SfsH2zYlOtFP/hSAcnJDe3mO8=; b=
	OZWWtp80V5lOA9b4NJbbRe+70JyWkLpQN1Q/naFRXvYAjZ+9TmT1KYVkQHu24soa
	ZtZXLeUc/JCiH+1XRUencBrFfBpzkKbGPZunP4NGDEt/pdNwjmaTIo1L0na8NCrI
	S8TnNeMeFIMrJOF+f0JOL82G5IXgtCjfAfzxNDiKmb5a+ll7BS/Y2uKKM9MtPd9t
	bBDyBIvFFQ7w0YE5jkYViBJJ3z6ymvk30xkqjBWSlnPn5ZutX60q7SvActG3dsgb
	S4byuoH9lO8F9SZn3O8eFSb712ym9qMDMIrzkA42wLXho70N4Mv/JHWusxR33kNU
	HqoH2mupLCkaoBNw7w5qWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828347; x=
	1738914747; bh=twqLDGPZSXwut8sVG8SfsH2zYlOtFP/hSAcnJDe3mO8=; b=y
	TooYDM9bo/a7eYwWhQT2idfxHPGNHsxPEyK5z47zyiv5uhzfQiY3gDN2/5HHnD+6
	85nUnkm2Q3+p6+qaEbDumTTw1F7Jkmgy00bo0GAiNOXvpFeQjL/oIM31vLY+k64j
	o6Mgc5MPv5ipEa9nFc8e87ANoB9MmVA+mwAOGQHgRmTeAVWgJ3D0PgHkjd8J6YY/
	Q6x9JV3sqyoAkkHAzcExOzRuKlteLJUzALFZ7W6OKJRMmJtM5CzpygVYfnUgse4c
	sInXo16Q9strmYLLhXuV72Pyo6JDpKA3N3fGThnEe9ywBdkRtodssMPnLOKIHe4i
	8qwJRNO6QJj+/Rd7AUBnA==
X-ME-Sender: <xms:O2qkZ3G-Du9u6GZIoW8o7zl9JePg1dbOjv9eisLxhW50YDrBiiuy7w>
    <xme:O2qkZ0W4gt6Mk3FmN9GMp5qsFl2qZvYDC13CLFcsMooZSNNuLGblR242qEY0zPhv8
    ef4XkqRwi-_7Uejvg>
X-ME-Received: <xmr:O2qkZ5LLMtzrOvdB9OBb-k-0ysC6mcY3TjFhTu3Wkt-1NtXehOlXe8yJdjeXKr7JKNQIo5L3JXQnivL0PKDO32Mi-b5q1hZ5nDf0NlOiPoam>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:O2qkZ1FFAfCfCP-D7ye-SBEibwhy2SEE8g0tmOaqt9OGj-awMSTDkA>
    <xmx:O2qkZ9UNwbVfL7UAKoyBwRmAFlwgsHGLjkkGyd-lb7bOVml_r9pB1A>
    <xmx:O2qkZwPe4syukt-I-xARt77842uSihzXXQc292aFNilj_s0B95-Xeg>
    <xmx:O2qkZ83KcMcjeCweSorObt3RHYoXdNPQSq9tsYAXVBijAp-5FDMcgA>
    <xmx:O2qkZ7eF39PtG2sgqZI87mSsKm3IPOyJ4B0b2EMnedavDFY7aOcTYueK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0f36f48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:13 +0100
Subject: [PATCH v4 11/18] reftable/system: introduce `reftable_rand()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-11-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
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

