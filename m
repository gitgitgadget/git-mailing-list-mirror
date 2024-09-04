Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55D19750B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439986; cv=none; b=f0mQ2Bwv7odI0ym5fnA7BrrtYhAuxffStYZ/DjoWJBTaGrKDOfIXboSQ8Ygbf+DZAzUdPyjuzl9PLO/o3yM2FiFtwZGLX6s6Smn0sHiHb80xmXzBVcCMoJdPJzxfbRdVLJ1Xo6+m3lCAxJ/OXbhUEyuwcE8gCdBnL23D39UxBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439986; c=relaxed/simple;
	bh=EJDmh61Sr6V+Q+nrp+xdWabQIwVGPt49fohkXo6Wbks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqQsA78J8r5F+g6T2jWw7lpqgqFrQE1vk09nr2SQDjhETMckSmfv7Z9CVnmGF+TnO43y9mpcI/pU/INKmE0sJSM3yx5MvgsV6852p76gBLFPRSmOZR4ggKcVxORJgYekb6yNRKYSzGVGn8Ngd49soBh+RvXbReZfKRUfZqhFkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OG4SUyop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVhOv+2g; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OG4SUyop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVhOv+2g"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72D1E11401AB;
	Wed,  4 Sep 2024 04:53:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Sep 2024 04:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725439983; x=1725526383; bh=rvUP/6fPYA
	MXChw9BRkcF3YWKAY3ugQCCYsWfrhQVQY=; b=OG4SUyopczsA2AFXdKOuiWTMPs
	D1YbgN+yRQvQLyXoNzDwZoyfy4bjVTDqdODto7sbx27b4rV0vUkbiGNshw42nnuh
	HC/QLmzWZeVnLZGuCGBHveHFZUEdCy4925u0I+zzIdbuuqZcUwSdpTIrc+dZdSkq
	uEbQrkjIVKc7q1QxyKRjbjqYfhKUYgIBTOUXHjd9xXeH2owv9mUPGwdK0B5EOYI9
	g4J5D/JEy9ju9qCk/Q8Ky+mhonksHb1uDdy01v5hs+jzl2i70aX3lK6PUb7pGy1o
	HZv9vzSKIblPRKwfa3NmS5KxIkM9ozBzCRPteoEXKiEXnuuVBzb8Oys9tsXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725439983; x=1725526383; bh=rvUP/6fPYAMXChw9BRkcF3YWKAY3
	ugQCCYsWfrhQVQY=; b=AVhOv+2gkyzEnINuaMKE6/8xqzRl3zVWjNMJzeHpel3Z
	dRawHEJwS1+rwpJ/0Dfhz/6a2hW62cFSt0BNTMEkkzSTsjGMZ5YlRtEBXQep5hZg
	7VtyjXYKhMDCw/Pnn5KxTy0Z1O01cNudrN6dXX6U15nEHUxnkw7UI+3mF0q4zTO5
	bFHXbH3rg6idOKrQByYLdP/BksJqzSHutuYQBbKT2KTj2jWH3FkxFJksHXzc6wFl
	YXIh2mLMNO9AV975kJCI8tJ3Y12g95HhPC70BqTSMpm5arlt39Q2i9AXkQ5ZuqvR
	g9FE4FlRPOOwqrhLOc+kLGvaC89PaobyKhHMjUi38g==
X-ME-Sender: <xms:7x_YZq4DT28vUayx_80MUWOtf_JYaAdp2g8UqM-_N0f9h47FKXbDxA>
    <xme:7x_YZj4BUfKbscvtmFDDk3hTMQW6mUwIkiuTFmGS1LEY-wyK7k0be0ZWEdm_TRoyA
    9eSdiFPsqXyAIJrDA>
X-ME-Received: <xmr:7x_YZpeTI9SHVwyEB4RCQtKsS3F1IgN1LKdIUuCXKYAUG0XLLjeUl9U6ly-GB1zdG9IC9NRhoDFwF6OA7Spqij5_TD-BhuBpawEedhxdXEYa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7x_YZnLt1o-_nmvOvu3wTBYEqlk60nFua6lz07_umyvjL8deuqRqDA>
    <xmx:7x_YZuJJM1WZHnpWL3QF1TlfKBhB5djzOWI5t2cJ7qNFE3NKgM_aBw>
    <xmx:7x_YZowddvTyFYHLu-vwFloRTCMYy0SaTAWxn_CS710aiPnRen4UZw>
    <xmx:7x_YZiLug0xpBhpRheMCKrWrKJb2FN3nze4rJAM-UGx2DCj2fNXOpw>
    <xmx:7x_YZq0oeP60maRGrEMApbaSzKonKiTyMMDqxjsdcUf7HDzehzuYQuPi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 04:53:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44d84265 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 08:52:53 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:53:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] wrapper: introduce `log2u()`
Message-ID: <df8c5dffffed0edd9068406fcf39ac6608bc930f.1725439407.git.ps@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <cover.1725439407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725439407.git.ps@pks.im>

We have an implementation of a function that computes the log2 for an
integer. While we could instead use log2(3P), that involves floating
point numbers and is thus needlessly complex and inefficient.

We're about to add a second caller that wants to compute log2 for a
`size_t`. Let's thus move the function into "wrapper.h" such that it
becomes generally available.

While at it, tweak the implementation a bit:

  - The parameter is converted from `int` to `uintmax_t`. This
    conversion is safe to do in "bisect.c" because we already check that
    the argument is positive.

  - The return value is an `unsigned`. It cannot ever be negative, so it
    is pointless for it to be a signed integer.

  - Loop until `!n` instead of requiring that `n > 1` and then subtract
    1 from the result and add a special case for `!sz`. This helps
    compilers to generate more efficient code.

Compilers recognize the pattern of this function and optimize
accordingly. On GCC 14.2 x86_64:

    log2u(unsigned long):
            test    rdi, rdi
            je      .L3
            bsr     rax, rdi
            ret
    .L3:
            mov     eax, -1
            ret

Clang 18.1 does not yet recognize the pattern, but starts to do so on
Clang trunk x86_64. The code isn't quite as efficient as the one
generated by GCC, but still manages to optimize away the loop:

    log2u(unsigned long):
            test    rdi, rdi
            je      .LBB0_1
            shr     rdi
            bsr     rcx, rdi
            mov     eax, 127
            cmovne  rax, rcx
            xor     eax, -64
            add     eax, 65
            ret
    .LBB0_1:
            mov     eax, -1
            ret

The pattern is also recognized on other platforms like ARM64 GCC 14.2.0,
where we end up using `clz`:

    log2u(unsigned long):
            clz     x2, x0
            cmp     x0, 0
            mov     w1, 63
            sub     w0, w1, w2
            csinv   w0, w0, wzr, ne
            ret

Note that we have a similar function `fastlog2()` in the reftable code.
As that codebase is separate from the Git codebase we do not adapt it to
use the new function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c  | 12 +-----------
 wrapper.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4406fc44cf9..4713226fad4 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1130,16 +1130,6 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	return res;
 }
 
-static inline int log2i(int n)
-{
-	int log2 = 0;
-
-	for (; n > 1; n >>= 1)
-		log2++;
-
-	return log2;
-}
-
 static inline int exp2i(int n)
 {
 	return 1 << n;
@@ -1162,7 +1152,7 @@ int estimate_bisect_steps(int all)
 	if (all < 3)
 		return 0;
 
-	n = log2i(all);
+	n = log2u(all);
 	e = exp2i(n);
 	x = all - e;
 
diff --git a/wrapper.h b/wrapper.h
index 1b2b047ea06..a6b3e1f09ec 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -140,4 +140,22 @@ int csprng_bytes(void *buf, size_t len);
  */
 uint32_t git_rand(void);
 
+/* Provide log2 of the given `size_t`. */
+static inline unsigned log2u(uintmax_t sz)
+{
+	unsigned l = 0;
+
+	/*
+	 * Technically this isn't required, but it helps the compiler optimize
+	 * this to a `bsr` instruction.
+	 */
+	if (!sz)
+		return 0;
+
+	for (; sz; sz >>= 1)
+		l++;
+
+	return l - 1;
+}
+
 #endif /* WRAPPER_H */
-- 
2.46.0.519.g2e7b89e038.dirty

