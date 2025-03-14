Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B759202C39
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986560; cv=none; b=IfnxEtGQ6QJsNTtwvQ387CXYqD/Re6PQ1F/aPuJDxHNWA85seqaPm/SHwvemFV9ktG7tXdoQZZ/vNuf9AX4019MTUSKCpU3DvgrYZ+JAdfjj0eUBR3WiEXHrnSL3gpksKTgr5b4+58SXrNa7fR1VQFgsz7OZkffhcYb+3jCk43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986560; c=relaxed/simple;
	bh=m3bt8EwoOYNLBxaUEBbI53FuIXv36GvMXcZBtPKU0mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5urKJE7vJsw0lycWy3dmwDZh2E7mP/Z8aepBLs5xNIvUt2GgCA5vbALa9BykQFA5o5bgvdJi9/PnGVL4rILRY62nBuZEZSqI2tSxzBKc58thyvfAeApZ/pmbF4OKH9PYK/XtVSAsn8frVqDL4+HNdxiyD+YdBiki/R78bhedFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/czdc6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iB98U3pB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/czdc6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iB98U3pB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89A842540140;
	Fri, 14 Mar 2025 17:09:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 17:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741986556; x=
	1742072956; bh=7biQr3vXGAavSEQgtZlHjK1hE/zzs+idruxEFKnFmyU=; b=k
	/czdc6Uk2JBuNNBXdX4ggANBFDXI9xGRbnUnpmO3WTocQ7UJc11ZsY4suGh1Uf18
	TXeXgT1ayc/nylR6vMvUASeki3iL5IWRmH1HKV813+PxGYsCAVuMSOOtltPDnxF4
	/ZUn5wEyy8FCeOGyNfNc8u1HXDBIF0gzy2+0UHhtxVwXPpTF9ziAEp77AhVAe8k+
	nXc7lG+3YWq+HVNJ+yvsmLx9y6+dCzghD467cJTtiWf8LXzYoKuvQ2XWVE/Er2i2
	TDMZcOMJTr5fckU05zd5tXndOOREsDoLwu/0tFuBYcqH8EGA+OEQjSF0Efo+QMsd
	eiTC7ICs8/KeF2G43SgYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741986556; x=1742072956; bh=7
	biQr3vXGAavSEQgtZlHjK1hE/zzs+idruxEFKnFmyU=; b=iB98U3pBhUCGyMrFO
	bgzEscfSLL1+WztxVc6LLs9UWq8N+1km097uPBQMlyzyIsSBZZVE4CHFEmMXodQO
	kYSzeGI9fPgzFwz/6sQ0zgDkta6ENk2506KXSz/gnrZ9XgaklsuKVCQnDTtjBrDi
	ZIilP04iNj1+rMTCAzwcBk43SlP4SUfDMQ8QaZsiWUB5AnfA+51tYSwl7wyBiVYr
	Kqu3GqhoWd43F+P7KL2GpzIltXNfNHwzWw1cPncs6VOP3r68Ns0Q6abzAX5osGw9
	i1+TVlc3WwVzTOuZVy7fWbOEpDKd0BeQtZddTN96A21HcrCS4GErVlIh30xvD3OT
	uKwlA==
X-ME-Sender: <xms:_JrUZ0TxCRI_aLb51uMQq5EWdnd9rIrDlb7UmsxbvZUM7vfJW96PrA>
    <xme:_JrUZxzupEdIKGZqNSsjum6wBPQCrLErN9O94RdkoSfxYg47mBp4sqBBvHX4sHghD
    hLqz9NOXYbeh9pRSw>
X-ME-Received: <xmr:_JrUZx3iVnCjIhtB7IHsSPiYKqouh1ikGl7fFcbTRFp-ckRVYxNdgBDboktMzmRbwmNHt43TMM55pP3bfGppZt-wpvJidtySvSyZ86s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:_JrUZ4DAw8EGD7RG-npyUXMn6AzUztxYznbnGpjjWNRKGGwfOvHZqA>
    <xmx:_JrUZ9i6jxEgyZfWoZJOdvZ0CBuienXKLPQhqqjpQXyOgsY8vnVjtw>
    <xmx:_JrUZ0o6F6wNQq_OzMss3dj2SdycHyFuMJ1KUaw7Y1p7dGftm2QXIA>
    <xmx:_JrUZwjfF3_OA0zZ8hdmwY2a-ADo2T9S-zna-jJCI3DmNyv_WiSMpQ>
    <xmx:_JrUZ9dGs76US6ciy-N42z_P1DUmg9o3B6gud8cfUUKDYGkO2ksimYC7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 17:09:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/3] git-compat-util: add NOT_A_CONST macro and use it in atfork_prepare()
Date: Fri, 14 Mar 2025 14:09:09 -0700
Message-ID: <20250314210909.3776678-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-188-g35fcca2323
In-Reply-To: <20250314210909.3776678-1-gitster@pobox.com>
References: <20250307225444.GA42758@coredump.intra.peff.net>
 <20250314210909.3776678-1-gitster@pobox.com>
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

Introduce NOT_A_CONST() macro, with which, the developer can tell
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

	if (NOT_A_CONST(sigfillset(&all)))
		die_errno("sigfillset");

which looks almost like other innocuous annotations we have,
e.g. UNUSED.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile          |  1 +
 git-compat-util.h |  9 +++++++++
 meson.build       |  1 +
 run-command.c     | 12 +++++-------
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 97e8385b66..2158bf6916 100644
--- a/Makefile
+++ b/Makefile
@@ -1018,6 +1018,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
+LIB_OBJS += fbtcdnki.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..63a3ef6b70 100644
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
+#define NOT_A_CONST(expr) ((expr) || false_but_the_compiler_does_not_know_it_)
+extern int false_but_the_compiler_does_not_know_it_;
 #endif
diff --git a/meson.build b/meson.build
index f60f3f49e4..ce642dcf65 100644
--- a/meson.build
+++ b/meson.build
@@ -282,6 +282,7 @@ libgit_sources = [
   'ewah/ewah_io.c',
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
+  'fbtcdnki.c',
   'fetch-negotiator.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
diff --git a/run-command.c b/run-command.c
index d527c46175..535c73a059 100644
--- a/run-command.c
+++ b/run-command.c
@@ -516,14 +516,12 @@ static void atfork_prepare(struct atfork_state *as)
 	sigset_t all;
 
 	/*
-	 * Do not use the return value of sigfillset(). It is transparently 0
-	 * on some platforms, meaning a clever compiler may complain that
-	 * the conditional body is dead code. Instead, check for error via
-	 * errno, which outsmarts the compiler.
+	 * POSIX says sitfillset() can fail, but an overly clever
+	 * compiler can see through the header files and decide
+	 * it cannot fail on a particular platform it is compiling for,
+	 * triggering -Wunreachable-code false positive.
 	 */
-	errno = 0;
-	sigfillset(&all);
-	if (errno)
+	if (NOT_A_CONST(sigfillset(&all)))
 		die_errno("sigfillset");
 #ifdef NO_PTHREADS
 	if (sigprocmask(SIG_SETMASK, &all, &as->old))
-- 
2.49.0-188-g35fcca2323

