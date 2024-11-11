Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693D1990D3
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321549; cv=none; b=Tp48FbJiCm2xR6yNxi5H7ot9l1k5pOJ7sOTzUIdqIHo+EDVJTNLWYGkKjj31tdMdrB4qaaiiSy/COJpSaIGeP6iWWMglIDMgsPnNpR7P9cYqCntJART1omZvvUuO02CLLuHrM3YLUo0p9e+784qJ24HrDWzBF0AYJZFnGKQf8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321549; c=relaxed/simple;
	bh=A1NUT2DrJN6xIPiut7OTSz+pqC59KH79tBWhdDxcShA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIMwxgLMwGqZB9k7PbiZHy7StcZ3S8xFsictnUwzb1yWCfahW02fWiCHWtO9YBxFFCwy136VQhV9xvoGDhu/7t2+6i+dUyQDhuVHGM9c1vpa2QtCm/ntbMPe1qHtQNb5j+oBKqQsyxfKUAm7nY6dHWSo9BAnfS76B4IyP50ByGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1ImK2nwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSZLx2Ko; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1ImK2nwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSZLx2Ko"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C0F2F13801F5;
	Mon, 11 Nov 2024 05:39:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 05:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321546;
	 x=1731407946; bh=A8NYADg1d5aPVu9Jn0HdIR0fs3w3ElKKl/npKHhjlvI=; b=
	1ImK2nwzcLDUs61kPZLbMFzxPAkTfyiKBTl+VNMtcjAp/oU8O9z1GRYZEZydU9E9
	ZfJZd20Oq+/N8+UA721kFtr0ZRHVtIyi2PCUt+TQ7mwiBbwZvxGrlbpFJswVtNXK
	1XH/iWZ6r+Q+w+vnMggC+fT8CLIhFPgj7+pztZaALdh9ec4GC8Ayp/Og2mbuuvli
	i7Y/l0ZeYZkr+OBIHhEO2SgS/XYphaJf3AtPSc4+QDej+6Joc82g1yLoe4hPfHAP
	TNH+CpcXNeBVQU9VNIjyL1Kcvom4cEyxNvNIweQpJWOg38Z7m7siqU0UPxrXUpE2
	8HqK6fb4giVURwzrWH26KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321546; x=
	1731407946; bh=A8NYADg1d5aPVu9Jn0HdIR0fs3w3ElKKl/npKHhjlvI=; b=Z
	SZLx2Ko1jmQcLTma58wqQORekbGYMWofuena3AhbaW4nc5MStwDtor5spfWp1XVK
	bJauI1xr0TznO36bnn77Ku9VXBF2tjDbBK9FYauoSEvOYHFDjXAwKFgeuebRBswQ
	wiojpo+usB4bWKZ3o4UZggwq7O5uaK5QL4P5QoZT9u1kbB/MhBKc4hYPvdJJHK4W
	HLZ1oZZOmAU5ode70CB0JzbqhKWM6Kbejr1Ptp554mKprRwELRLI6mC645zHa+LU
	oiBPy2vRvVKBCDBzcGIvw8pJic+fnMlmKrsEJ9afJjSa1c0a6t0xnMgQR7Nc5Stn
	K6ZA2qA/rDk+IqgHhFf6A==
X-ME-Sender: <xms:yt4xZ39aqzp9s4J-TeqjZnIIgbljIZbIhABQEwVxD4QkJtf_YAG6zw>
    <xme:yt4xZzu-TcV_BzZJyjfN98xHbe0kmfRxgvtrX-VBijq0bT5Hpj7-mjJOzGN37bRjV
    fplT3XLaDcFbXGmlQ>
X-ME-Received: <xmr:yt4xZ1BZx1o4hcM1qz3DE0GBEkiF7uFho0A5eptWzpZa0Y1vJBhnv5L2exdlWwOO2QBvTTN1e3K2oThsG5XRZ7SGaWuf_f0VUrh3EVYr79k6E7PV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yt4xZzdTwrvlCZdnQArI-s7TrmZGDZvvUf8gkJ8f19vFK5e_RmoHew>
    <xmx:yt4xZ8OceC3nGINeXyD4GoFUX-k_-HEQHMIkxImsusN7T6CKhVDfoA>
    <xmx:yt4xZ1mN3NdZ2m4XBau2KtFXi1B-OZKKg7kmL6zkbQ4fSJjSn2HjtQ>
    <xmx:yt4xZ2u2j_5nBIjYnbjJ7AQXJl379Y2So11612CjqRcYs8f_krXyiw>
    <xmx:yt4xZ1Zf40fSsWZ1BcTx_0ElweoqhEVNKy_yk2vxU40CHXZFDra_g-Dd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be14ac7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:51 +0100
Subject: [PATCH v2 22/27] git-compat-util: drop now-unused `UNLEAK()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-22-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

The `UNLEAK()` macro has been introduced with 0e5bba53af (add UNLEAK
annotation for reducing leak false positives, 2017-09-08) to help us
reduce the amount of reported memory leaks in cases we don't care about,
e.g. when exiting immediately afterwards. We have since removed all of
its users in favor of freeing the memory and thus don't need the macro
anymore.

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 20 --------------------
 usage.c           | 15 ---------------
 2 files changed, 35 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd5639b58a4ec4d2a6269fb649348fb4e7..a06d4f3809e5664863d4d0f312c88b3e1364ee74 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1527,26 +1527,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-/*
- * You can mark a stack variable with UNLEAK(var) to avoid it being
- * reported as a leak by tools like LSAN or valgrind. The argument
- * should generally be the variable itself (not its address and not what
- * it points to). It's safe to use this on pointers which may already
- * have been freed, or on pointers which may still be in use.
- *
- * Use this _only_ for a variable that leaks by going out of scope at
- * program exit (so only from cmd_* functions or their direct helpers).
- * Normal functions, especially those which may be called multiple
- * times, should actually free their memory. This is only meant as
- * an annotation, and does nothing in non-leak-checking builds.
- */
-#ifdef SUPPRESS_ANNOTATED_LEAKS
-void unleak_memory(const void *ptr, size_t len);
-#define UNLEAK(var) unleak_memory(&(var), sizeof(var))
-#else
-#define UNLEAK(var) do {} while (0)
-#endif
-
 #define z_const
 #include <zlib.h>
 
diff --git a/usage.c b/usage.c
index 7a2f7805f57737fa3d9e653ff6c9345719dc79b8..29a9725784a42ed11363b4c41c7a105c0b13f64a 100644
--- a/usage.c
+++ b/usage.c
@@ -350,18 +350,3 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	trace2_cmd_error_va(fmt, ap);
 	va_end(ap);
 }
-
-#ifdef SUPPRESS_ANNOTATED_LEAKS
-void unleak_memory(const void *ptr, size_t len)
-{
-	static struct suppressed_leak_root {
-		struct suppressed_leak_root *next;
-		char data[FLEX_ARRAY];
-	} *suppressed_leaks;
-	struct suppressed_leak_root *root;
-
-	FLEX_ALLOC_MEM(root, data, ptr, len);
-	root->next = suppressed_leaks;
-	suppressed_leaks = root;
-}
-#endif

-- 
2.47.0.229.g8f8d6eee53.dirty

