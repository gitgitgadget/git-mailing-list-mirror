Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9286205AD9
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255617; cv=none; b=TV/MazCi2gPVeOV1xhhm44+4AV4W8TFWTqYNRR3ck848jmCNbgFhK4CyCo9ML+yEgwnduJeOHam4GZYUvz7vVxjZhR1CzHfrFOLhdQa0ycCABnySMVenn3VOjRSM6C5LWnIKFs0mKTHzPWNAdfc5/iG1ggb4p+BpxQN/j8nMngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255617; c=relaxed/simple;
	bh=HZvcv8g22MyJyLW8/iaW5JpPKg0Yz8AzPTXiJ2sjCAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJztTRch74hN98tUMv3Hcqy5u4Xuc+gBFmMXx8rPf4DSSQAXsFIq81HuGLaZysBjEwd6RsH8UkXRJHeEx3dseiJ7Pw5c3vcHLLa+ba+yOsMev+kYUeJOwBqRCbG99AXMbR5JRrxL0mOBcEbWCqvUVvTLYo+F1LJnSpcuKP5pt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AAbMH4Ee; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l84ZjETc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AAbMH4Ee";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l84ZjETc"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B71AA1140245;
	Mon, 17 Mar 2025 19:53:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 17 Mar 2025 19:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742255614; x=
	1742342014; bh=mbf7zN4vf2oRhUH0GA2xiv9GiYfC390BuvYIsLLRznw=; b=A
	AbMH4EeXsn8mTxIkxIUP01cV60vT8X/xaUREghSlQ3aF9Z3oozjgphjqY7nphflw
	atASAT/XklagttstyUQwbopP75qJedAQcfyJvJNdepvTeNPmOQwJrc3jlQL04dtO
	43bT8wHdvqaRMOtMGcITtA8bmZTRX1V3bovaRLe/fvG4PKH81dmQmm0tzaDRqZHS
	RHEDpunWlmh81LFsNIDXizWYwRCqkcExqxcZYqRo0fa0mWaOx4rllxcIkMMwLuSh
	GnvAQYnBKQ63eaVILSGN5ibMdd91/7eB++AIuIT2PvH/ybUj0gXB7AIDX8tXroGs
	HQOgpOk/7BG5xYDHFsEfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1742255614; x=1742342014; bh=mbf7zN4vf2oRhUH0GA2xiv9GiYfC
	390BuvYIsLLRznw=; b=l84ZjETcWt6RRsN1P42QlYV8KZo6w9YU9PQzCTQCPU22
	NdmAKcbRrSITr5NcE4mw6WLZWxyBCxYLA0xktllo31dSbfTjbnVYdTCkzXUTx8TB
	SlkowMq43KrP76uIyGxXLShR9nrSHmGeAq0i0BGg4phY+JX380fWRohDHgpPchtH
	wy9RpnKbkZbb3BDv5Rr4p5ig3CaURD6tg4fl5yY0yZ5Ch40ljQZRfcPqF6K2qkxR
	XubBwgIH6dCHD2whp9vdSELiLTbsPngoHLPxADZgb8NaNfiemI9f0HZO+M62DSAV
	2pMWMNEgtwo9tqmSc0vFoP3FZEh1nFFV9XEdcIuQOQ==
X-ME-Sender: <xms:_rXYZ9EAb15uPsw_3bMQYX-4IOT3xchYWKBHPUlayajSusuNrgzNVw>
    <xme:_rXYZyU7oTajC9fvUniBROvLUgTZZ9ITeKWSsc0qA5pLsDArbRlqtqe1eERDeoC23
    rp_uKvVMNRckWQxDA>
X-ME-Received: <xmr:_rXYZ_LERbGJ8IFjisyAiAfUK6qxBPmL27TctT11ytteMI9UlTj350E7DHs4mk-8rrfEqFAFX8dRvQ2SgDVMkmSf45BP1i_M5dGEUH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_rXYZzGzodkIoDxpl7cj1dQ6lHydlUYY8z0ALw2qqNVnMjR5VrKdig>
    <xmx:_rXYZzUWR9zcUmMeb5n_-qWwBcl7WuasWh2kEPbw5GssDPlyDgPIUw>
    <xmx:_rXYZ-Ou-pdmzI_OMekr-X1MuHxE8X0NqEs0ayTlEm2wsimGjQtigw>
    <xmx:_rXYZy36vXQN33m4EFkoGslZc_Tcs9VgewiBcaLjkxX5wfmLycZQlg>
    <xmx:_rXYZwjVaGnQTkFgEQsEqkSXSRAuvLddZ-BteDj3ThSaY5QEsSEISQI2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:53:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 2/3] git-compat-util: add NOT_CONSTANT macro and use it in atfork_prepare()
Date: Mon, 17 Mar 2025 16:53:28 -0700
Message-ID: <20250317235329.809302-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-207-gc8924421c3
In-Reply-To: <20250317235329.809302-1-gitster@pobox.com>
References: <20250314210909.3776678-1-gitster@pobox.com>
 <20250317235329.809302-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our hope is that the number of code paths that falsely trigger
warnings with the -Wunreachable-code compilation option are small,
and they can be worked around case-by-case basis, like we just did
in the previous commit.  If we need such a workaround a bit more
often, however, we may benefit from a more generic and descriptive
facility that helps document the cases we need such workarounds.

    Side note: if we need the workaround all over the place, it
    simply means -Wunreachable-code is not a good tool for us to
    save engineering effort to catch mistakes.  We are still
    exploring if it helps us, so let's assume that it is not the
    case.

Introduce NOT_CONSTANT() macro, with which, the developer can tell
the compiler:

    Do not optimize this expression out, because, despite whatever
    you are told by the system headers, this expression should *not*
    be treated as a constant.

and use it as a replacement for the workaround we used that was
somewhat specific to the sigfillset case.  If the compiler already
knows that the call to sigfillset() cannot fail on a particular
platform it is compiling for and declares that the if() condition
would not hold, it is plausible that the next version of the
compiler may learn that sigfillset() that never fails would not
touch errno and decide that in this sequence:

	errno = 0;
	sigfillset(&all)
	if (errno)
		die_errno("sigfillset");

the if() statement will never trigger.  Marking that the value
returned by sigfillset() cannot be a constant would document our
intention better and would not break with such a new version of
compiler that is even more "clever".  With the marco, the above
sequence can be rewritten:

	if (NOT_CONSTANT(sigfillset(&all)))
		die_errno("sigfillset");

which looks almost like other innocuous annotations we have,
e.g. UNUSED.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                         |  1 +
 compiler-tricks/not-a-constant.c |  2 ++
 git-compat-util.h                |  9 +++++++++
 meson.build                      |  1 +
 run-command.c                    | 12 +++++-------
 5 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 compiler-tricks/not-a-constant.c

diff --git a/Makefile b/Makefile
index 97e8385b66..605e2d7f61 100644
--- a/Makefile
+++ b/Makefile
@@ -985,6 +985,7 @@ LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compat/zlib-uncompress2.o
+LIB_OBJS += compiler-tricks/not-a-constant.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
diff --git a/compiler-tricks/not-a-constant.c b/compiler-tricks/not-a-constant.c
new file mode 100644
index 0000000000..1da3ffc2f5
--- /dev/null
+++ b/compiler-tricks/not-a-constant.c
@@ -0,0 +1,2 @@
+#include <git-compat-util.h>
+int false_but_the_compiler_does_not_know_it_;
diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..f6a149827b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1593,4 +1593,13 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
+/*
+ * Prevent an overly clever compiler from optimizing an expression
+ * out, triggering a false positive when building with the
+ * -Wunreachable-code option. false_but_the_compiler_does_not_know_it_
+ * is defined in a compilation unit separate from where the macro is
+ * used, initialized to 0, and never modified.
+ */
+#define NOT_CONSTANT(expr) ((expr) || false_but_the_compiler_does_not_know_it_)
+extern int false_but_the_compiler_does_not_know_it_;
 #endif
diff --git a/meson.build b/meson.build
index 0064eb64f5..373524dad2 100644
--- a/meson.build
+++ b/meson.build
@@ -249,6 +249,7 @@ libgit_sources = [
   'compat/obstack.c',
   'compat/terminal.c',
   'compat/zlib-uncompress2.c',
+  'compiler-tricks/not-a-constant.c',
   'config.c',
   'connect.c',
   'connected.c',
diff --git a/run-command.c b/run-command.c
index d527c46175..b74fd08056 100644
--- a/run-command.c
+++ b/run-command.c
@@ -516,14 +516,12 @@ static void atfork_prepare(struct atfork_state *as)
 	sigset_t all;
 
 	/*
-	 * Do not use the return value of sigfillset(). It is transparently 0
-	 * on some platforms, meaning a clever compiler may complain that
-	 * the conditional body is dead code. Instead, check for error via
-	 * errno, which outsmarts the compiler.
+	 * POSIX says sigfillset() can fail, but an overly clever
+	 * compiler can see through the header files and decide
+	 * it cannot fail on a particular platform it is compiling for,
+	 * triggering -Wunreachable-code false positive.
 	 */
-	errno = 0;
-	sigfillset(&all);
-	if (errno)
+	if (NOT_CONSTANT(sigfillset(&all)))
 		die_errno("sigfillset");
 #ifdef NO_PTHREADS
 	if (sigprocmask(SIG_SETMASK, &all, &as->old))
-- 
2.49.0-207-gc8924421c3

