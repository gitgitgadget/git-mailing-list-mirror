Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CD1FC7E5
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569836; cv=none; b=ueGTBpRxdeB3r9R2LTR+kWZXj02FPFH6DelpfreNJ2cXakjF2sIszers36Xkkatry37ArmrRepkyopgAqLwa34BCqwfPiRlN926do2FnlXdZHi+9qg3pZx3RvBKSUoJya6elQedSMCPMmAFsxXtubBr4+q9LAdtYTZfQ2F12EYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569836; c=relaxed/simple;
	bh=uDeRXVgNt5dpflN7MtIbmpYKLe7JTnQIhSsm5QgkVIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/6JNheW7YqCCZeME2a39sw1IdqoV+u8CkRUeGyuWdOJURy4HUIqIad/J16zS61WBu0ClyG0OYJbYBObrTOcHWnugzlEAjRGF5Sk4YNGj6XfgMogiCrDCCDyQ3pJYM7MNCwY/Gf2UacSBAT6iIYz705EVOdLg/Azvky9dThtw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iPBnG+yi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6tHS6v6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iPBnG+yi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6tHS6v6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B3221380848;
	Mon,  3 Feb 2025 03:03:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 03:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569834;
	 x=1738656234; bh=/O89Vq2/x7VLYgS9SHGX1l65KJEEkieLMQ/1qYKciQk=; b=
	iPBnG+yizT2yHpX5azsHTWXhk/x9vDR+L+/WQ4ebkuZGNExAsBaEROHLVjwMURWH
	7hIZSTEC9iPibCFwWx8Z+zTa8lVwGTxE1Ku/BwedDjxgiZH6Ws0czM9YCcglqur0
	BDYC3eEbz2WrAkz5wbntowADC8HC8ZB0tVaB6XeOxkcRGkMSfp4Rtnbmj5evnrOh
	9Tm1IeGlXtz2FiWW7gy43KuvemcZbuCf27vAucArEVqrYuylucK1O4m0EIgc7SrQ
	33r5hUk6gQVT0732iAvlyJSvRyMy1A9j3rwTMKwiy0CHuuLXkXX/P6sHevCvrSr0
	YXLLeIvY4yjx0W/c1zt2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569834; x=
	1738656234; bh=/O89Vq2/x7VLYgS9SHGX1l65KJEEkieLMQ/1qYKciQk=; b=b
	6tHS6v6M4n1R4n3sqzHJrsQg5lM1HUxty6+6bssumTH4S+oR2ZVamqXsZCT7nedE
	iNXOyiJo+VAQwFOGtei+jTfrTpebx+Tqns4nua3c/ikPMThMdSYoQHcQl7+YeP8c
	3vJAjcZCOl50tNgH7fZCzVgqApdHUDhhjPkfdwyGwb+8LlhF1+5Q0kfsQ4kaVPsR
	GHo2lgk+iy/G4eU2cLxZTP5LM7QrZjd+sZ0KGkgDZiwzvO5ma6/ovmpGgUK20ls0
	E03SaVhPV+fqmI6aLEnUzOZDGMP3gbq0fSBWlI8Q2qlnu7A+6/AWt7x+BrUo3I8f
	7AOi9GDpW76f7cVa37FRg==
X-ME-Sender: <xms:anigZ-87BbNiVqI7o9RrSIMK6hgphyqhGbIuk61keq_M-0zJ0teYqw>
    <xme:anigZ-taXbfd_iHrr-3D_5JlImwt8GWxbupeE7DbfcMDzcms8r6mlUrOZPxY0hDzJ
    P3PCYt8kOxBFcbDyw>
X-ME-Received: <xmr:anigZ0Awc4RWRQMmCrC17EOrUtbPGKzfhZN5hqwQ_J2L5VDkmXGnxb2zsp-H12iz6jo7YX5TDUT0RmzvZIzK7KivAh5E8xhlcAUbfWQLL9mPWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:anigZ2d3SCLyV4yd8CoRdKd7u4iIIg3B44652p9PYwsupOTqzOS1bA>
    <xmx:anigZzMlWVWvT-OvG6MdaoHLIJQR3ESxSQRged6J6i9s__zTnxV7NQ>
    <xmx:anigZwlFS3SxuRaOKYLJCT9aULlton62uk2hpN6bklFKhrcazzU0Jg>
    <xmx:anigZ1sM_Ah5sOSM-r10CtitZfpEVSiSi5aviybFq1Yl86LGtl7M_Q>
    <xmx:anigZ4qrQld0V6jHyZ53p_Tqg4eqqlM4Uxr544spsEC4xNXZXQIL6F-3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ff54d54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:42 +0100
Subject: [PATCH v3 11/18] reftable/system: introduce `reftable_rand()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-11-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.48.1.502.g6dc24dfdaf.dirty

