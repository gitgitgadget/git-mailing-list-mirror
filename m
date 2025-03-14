Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3581624CB
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981809; cv=none; b=Yt+znWOY+bqb3qVyKQltARE5s3Ck7XsLiskLllGDEEy6jEk1SaWS1KZjdc9o1CNFKF2iABkU7Ab/hvJx/5Mq+Nxgf6OFgiVeMShy0mp31fBe8DbXXh1O7JMY63YsOybC3lJwlR4mfpLwaxnpMRg9GDYoR1Zl5mm9bPqTaabMj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981809; c=relaxed/simple;
	bh=GKkp1RWn/TwoKQko2oJ6GZ6OX3c1Qi9SDmTkNQVYW/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GehtXQzTyRdjn5K3Sn/PAkwyUG2OiCjrYBuUA3fb+hPfihTw9pqm/QEE1Ht4OuCkqv0ifNJCb58t1PF2fww1zyQqI221VpsE0Xi9rTSilr+ShOg3QaeJ+S2X02PpgL1ujMKIbbDRrlqHplkGaFTvz/E4LZzcT0BsY4mfksyzL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zjON0G8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6mjnJy9J; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zjON0G8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6mjnJy9J"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F89E2540170;
	Fri, 14 Mar 2025 15:50:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 14 Mar 2025 15:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741981805; x=1742068205; bh=DnasBZ1prU
	nIoV6t7drZysXp0pXkLaYYB+J1Blg2p08=; b=zjON0G8nJvcH4VukC9su2vJSCl
	XnwtDinAR4X2yJu6IZBV6yUFufMUVuqgBF7tSqEa0de+aB9iw51Hz+90b+whrvkp
	Lh2Pn1BSpCzJaqKJqTSO7WdMT9I9cPzDycvY9WopzLLgaIQkcHsgWK6QA4IhlsME
	ttyeFqYd5aBuUoUOPwOdJMGLTvV7y677SYEv6kre0zAC5dw+oS7xHpppMzkzD/f0
	TPCfIe/NAGiZ6yqxXW3ovTFKBMtzvTPHJbwmw5cfbhTzvxVHjQqCOX475SBp5Yfl
	AvEoRCCjWRxPOaFcan+J6zMXAqUf/Hmoy1st0LSYVfkluCbTKP4t6TUZsRZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741981805; x=1742068205; bh=DnasBZ1prUnIoV6t7drZysXp0pXkLaYYB+J
	1Blg2p08=; b=6mjnJy9JNc5tfIr7vjI7NbU3HH0AxlCkh+52vsvFCGhQOEgag8f
	bVjSzn/FlJMayqqrk8GbWhZV1T3RZHy/Nhuh7WTRxjEW8eDWzCac477YzThGS/fI
	Ps6U6p+Y6KUAdUqgjRx/AxeMARmjWI/UsJbH+I+cSajA7jZme8EPdsenOhwN+wzj
	vRWuy1XeQCug+WBBm1qU8BIWiXmiNkKSX4llg5EmqqAyVWhxV6O91jUu7pMhQH8Y
	68PWigzDg5usTGH2dn6dbZQzf527SyesFTIZxD4RJn+5+5KaB58LEsldC2tzvNc9
	DYFfgAcpkAzLQVC09ZZxBamdXPe1juBy7bg==
X-ME-Sender: <xms:bYjUZ_OCsa3RD8xeG62Ls1fBzfLwg_MHp-4c6_9GWCdUDO5haJyNsg>
    <xme:bYjUZ58vNSr1PT36JL4hDD_kOhUmhdyOrwvjTzarYabKX6TLBueZD6vzUIYFnRST3
    PbEaIV8_e_679owww>
X-ME-Received: <xmr:bYjUZ-R4YoGL1X0l_PH2Mhz1eVBmBgwCo6Vu9FRRu34cIQ0a36J1Dq8J-Z6AeVPVx8fzB_wnEX7uo4z95Lr1hXCgesASp-52me6r2so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepgfeijeejgfffheeiueelfeetlefgffek
    fefgudelvdduieehtdeuueehkedugfdtnecuffhomhgrihhnpehruhhnqdgtohhmmhgrnh
    gurdgtfidpmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bYjUZzu9nf4rpWMRyqbyF-m4IPVDrZr9VR8IvcKXtZmsdjSWS-vDjQ>
    <xmx:bYjUZ3dY1Pn9lqh0nB-LQ91iTsEN-Psp_GWA3HrtYn3SN62yWVWkJg>
    <xmx:bYjUZ_0wf2eWqCWGRIMz8LQvUF5tQvKGHtUS6MCrC4YDgP10R1qbXA>
    <xmx:bYjUZz-7BFnucNZRb_JhK3-oybtBu_zOcxjT5QYrwm0fU6LsJQ5W8g>
    <xmx:bYjUZ5vfVUgmtBVNGhnbF-1IUPq-CJu-EJ4qRk3_SKbRXSNT6NlypyFi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 15:50:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250314185325.GC578421@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2025 14:53:25 -0400")
References: <xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
	<xmqqfrjkao75.fsf@gitster.g>
	<20250310160440.GA26189@coredump.intra.peff.net>
	<xmqqsenk7mab.fsf@gitster.g>
	<20250314161010.GA8522@coredump.intra.peff.net>
	<20250314161347.GA9440@coredump.intra.peff.net>
	<xmqqv7sbh698.fsf@gitster.g> <xmqqr02zfr3r.fsf@gitster.g>
	<20250314185325.GC578421@coredump.intra.peff.net>
Date: Fri, 14 Mar 2025 12:50:03 -0700
Message-ID: <xmqq7c4rfl3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Your CAN_BE_TAKEN() approach is certainly less subtle, and can be
> applied in a more general way. If this is the only spot needed it may be
> overkill, but the readability improvement alone probably makes it
> worthwhile.
>
> Do you want to turn that into a patch?

Yes, but after I come up with a better name.  CAN_BE_TAKEN may be OK
for if/while but not good enough for switch() for example.  "Do not
opmimize out because, despite your beliefs, this expression is ..."
is what we want to convey.  

 Makefile          |  1 +
 git-compat-util.h |  9 +++++++++
 meson.build       |  1 +
 run-command.c     | 12 +++++-------
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git c/Makefile w/Makefile
index 97e8385b66..2158bf6916 100644
--- c/Makefile
+++ w/Makefile
@@ -1018,6 +1018,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
+LIB_OBJS += fbtcdnki.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
diff --git c/git-compat-util.h w/git-compat-util.h
index e283c46c6f..63a3ef6b70 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
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
diff --git c/meson.build w/meson.build
index f60f3f49e4..ce642dcf65 100644
--- c/meson.build
+++ w/meson.build
@@ -282,6 +282,7 @@ libgit_sources = [
   'ewah/ewah_io.c',
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
+  'fbtcdnki.c',
   'fetch-negotiator.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
diff --git c/run-command.c w/run-command.c
index d527c46175..535c73a059 100644
--- c/run-command.c
+++ w/run-command.c
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


