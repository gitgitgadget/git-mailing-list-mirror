Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F311F37B0
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052908; cv=none; b=k+gdlTRa+4nJX0YvaHdcrT99SJgYn0Olf+s5UiBvNkQj9Snn1W8drz8m8b/Hlulp1HCi0EgpjJTCSKjXJUoMENDGO6SlLj91prS4yyfH0L604ALnceEZKwhbeBo208C2yhveDlZWCPeExlyeO75VEpn7MTKLMDUkNLACiQv3nYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052908; c=relaxed/simple;
	bh=+1ZfmkbfY7oQbi3mh98Cov4Tt5PalQNH5hpbNUu+aZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNENNJUW97df/gCBNTwb9LBGV9thRlKfAF5152N+kJbYDJ2CLoO+cd2ixNAragraNsv7kN/gSa/z7vz5K8bYfdRCZpMN3C53h7hRJnkYHYqBv0vh9u9XnMXwLu585RKJD8vAcXf083d73lRto6hNkaD6qSP+rYMxPgZ3ezFnyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PIA778VN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uwm7pf2X; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PIA778VN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uwm7pf2X"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1918911401D3;
	Tue, 28 Jan 2025 03:28:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 28 Jan 2025 03:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052905;
	 x=1738139305; bh=wRD3Ek5awySUciyux3HbTKfEqgbwtD0r0n4BcJTAH80=; b=
	PIA778VNUVseR93bUREsSJyqfXvqljUmokmyT30jKT7tPXQPwCe3e+Ffxjve40Qf
	UpWJWf05h9b6I8pdq1MKLZ69jibY3jrksMpfEF93tYk5iJBsbkuAYHeV+wlPnbiF
	09pQmxgc6DaVzgl3gxWBFSPi70G8JlZu/JAYdJLZiRMRz0PdCd/7AcPJbjkTbB1K
	uP84xnhOyxPVXR7iUgEhb+/cHJ4dfAdcIkrkg0cKH1gH9jnoUFGsG841GALPjkRy
	7EAM6g4QKFe8rb4vEL/iDlzey8ezyabzNf4qyWIo5JyWFtwirH1M0FdXqZoWDGLW
	XlbTlEgYvGfGzdEuN7wKyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052905; x=
	1738139305; bh=wRD3Ek5awySUciyux3HbTKfEqgbwtD0r0n4BcJTAH80=; b=U
	wm7pf2XE4SWNqB9PIrwPpVxxBUVGJrOpdknKOI2F0DmNFvLJ5XRtQj6P2FKlzV7G
	89Ho/dnso3s7PYDKIm8skI6GoRNHtVhFOgRngj0On/kS1PT+7PYry6en/itnS8sf
	2975hKdVR+3rwFSpt5JQ/r3EyXao31uIkCjqbS5csQhp/zd/gcFdVzQ2CTDPIRgI
	vl4ovuSlomQQMTp1TgBWYmAfHxXejy98MXL67UHNHlGUi44rLtX7tyKxeMVauER2
	67lCyHoIy5BwKZLHWao5gTK2uq/pLhBDHrx+ATSL0xeu1AQccF984OlYK3qVFETP
	ZceQ1X33Bech5q2H0pBDw==
X-ME-Sender: <xms:KZWYZ4BM6nXpWjVkpkRmvsdLmy7tEw8O8JjQEaJ6DVHrDqK6yLlsqg>
    <xme:KZWYZ6iuc4N65pG_FbWVw8TDXIRuxIWC2wHDUtVNV3qcrGLNPGWvloofK28-fJFsA
    5H2xGZQN_CveERLHg>
X-ME-Received: <xmr:KZWYZ7mlbJG3Ez8eO6ufD-aNDySqvh6r02iLflibFJD3_WADxPh9Wrq88LX5p8j-pcTWFIQfciZNA34H2eD4bgHR0m4Qknf1lw5JxrZKVHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KZWYZ-wxlgGL0IVvwXKUpKSsIyj9q3qWyyBLwH4IVCaxrk5rIOcoXg>
    <xmx:KZWYZ9QNoYfzw_FNnO26kcemXRsN7FFkuZvEGG9Jlhzp__2v8erQug>
    <xmx:KZWYZ5b3VYrtZ12kBMph6KDlSSMkd8kC4Wtyv7BFzw0C0LzlycrDHA>
    <xmx:KZWYZ2TA8OfoUBZzNbAQvEzFOqT4MnG-zi8lIPOWf8fs884xzRr6Mg>
    <xmx:KZWYZ7N37KxbZH595WYqy0u7FzXNu0jT0fMfmw8MPH7W3_0mZLGOrb3a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4726398 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:12 +0100
Subject: [PATCH v2 11/20] reftable/system: introduce `reftable_rand()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-11-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
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
index 5f155b344b..82bdf5169f 100644
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
2.48.1.362.g079036d154.dirty

