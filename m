Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA531BD9F3
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110011; cv=none; b=IQyGSAyiUavT/TPkrU2tu+Fy010wJCHK53DaZbN5lBg5j+FuLQMFZoiKsnaDzFtPXb7G+hnq7r3lhNkF3V7kD6U86TnctIdCpA4NKwhtODYZeejf/FLmf5XndbukTj41fpzaQpiyoIiQePYx6G3Uph6cc+ifcqCz6wwn4my4000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110011; c=relaxed/simple;
	bh=tnninM/wYIM5SG433jbZLjYTgcQ2NgpM27ykCYtmOsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsAgl4T36NQyUgpKsOPLafZ9HmLpB3hk7ArYnxWyOezbm9EhKK/OyAf6ShDMPbla91AHqsPQGmdiRzUMu1T74pgOA0nyueb0GktI5L8NUWkNMh+ra4KIzMD60LrxMHnjF9mXkJo3GlX3nTZ8hviX6IpC0xLt2uep54MBj7RTH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RNl/Vt98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4sf3jyDA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RNl/Vt98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4sf3jyDA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CDE711401D1;
	Wed, 20 Nov 2024 08:40:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 08:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110009;
	 x=1732196409; bh=861xTxjR6+jW9mEVPkTxnKYjpLVwDqqNGlw6FNzEbks=; b=
	RNl/Vt98SYnczRxmuvckt8rk20uZ3XRLzK9Dsnsm3IH3Q7sqkEQmsdYBmzea4mUP
	GQgOicXxCr+GQV7AQr7DecQB4BhvqG4SsVO+7IRcnaNmLT5eD22vpNOcHzqk+tzw
	CKNuYMrwOAujR5mKCkuUT6aa1yzFOan5WbQwj4FlvF//3a6/kxIvbAavdkBV0sZI
	N0+S2/yRb+kStISWg7nKdLa8mShyw6f/LheCmuFso/biFCpVwfzVNdXtReD8hH46
	irSfMCZM18sjlIUxXCcrJa1/kYX15xSAyMhTy9KTsSiR92ee/iFzuvXxni03ElCu
	MhS57RhGbTGKBWpTMqY01A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110009; x=
	1732196409; bh=861xTxjR6+jW9mEVPkTxnKYjpLVwDqqNGlw6FNzEbks=; b=4
	sf3jyDAhj+jCbt6D26njkDcnG8WHSj71cwgIIymjl/jrgyzsjtCZoLmpuf/kHwjs
	97Ax5xA5bm/EENonA+3EzLIv/79YOA8BNgOyuv1aQ0SrtnDHoxwKubMOBPVIkG74
	+xaFVGs1ajmQRn+r/eBBM1wZEa7oR3J615v/kB6+fbegr2tF/SVTcLS1dgmu8UJJ
	R9TlnphixeepIa1Eyr51NKP3YFXaUQwAocpH678TG6mnHz1kyNtOXlpQMT/80RdT
	nMv3YznqrQdmXxaJExWr3D+P5F2+nojGvM3eyFzwmv97P8Wc7lssMNGrp0XRzeeo
	JvEKhGVH+FTOCkINz5kvw==
X-ME-Sender: <xms:ueY9Z-HI1acs-kWctpsdktcfEVI12M3RHjQLLF24xtsYbyYCJUVirg>
    <xme:ueY9Z_XJ4h0c5zvPN69cDWSTrpJfW2yXmzTJ7oiMXEFb1LM8E-xeokD1iSGyrBlrN
    GzenErbiN9mR7BeHA>
X-ME-Received: <xmr:ueY9Z4JzPhaLLdfGvILO3I06RBFWGyIm3Dvk2738tOAi-owt0iA2tg-1xR9XGDaALqhEIiZ5GQuRW5KSmOrHrWCxnEOaXzEFGqAGdUryUYxBjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehrjhhushhtohes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:ueY9Z4FmGRHAnXpMVuy0Fy3See3rpabike5845z6WiP-Y45CXOo5IQ>
    <xmx:ueY9Z0VPGLOAKdAAYcAoHGeh5yoj7Ec-LBIS8RP8pSzxt739BhgNMA>
    <xmx:ueY9Z7NaFIPlPFgeRkY6s_ACtncvYdxzOrn4oOgvPk4B3PazG37aoA>
    <xmx:ueY9Z70ByWKouANEjGfmCz9x48yDG20ke6QUZb-oaz5zroVUSdWvPw>
    <xmx:ueY9Z-ff9IY0zAe2iFuEaEUuaAETxWjkYqX3Xhn2q-bYs0pCHGsoFjF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2ca1fc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:51 +0100
Subject: [PATCH v3 22/27] git-compat-util: drop now-unused `UNLEAK()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-22-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
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
2.47.0.274.g962d0b743d.dirty

