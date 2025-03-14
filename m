Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6911FDA9C
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991408; cv=none; b=rURayiheOu96sz0f0+51IsjtJgn06D9MB27vLEm399K1nNAe1/sQWnmUTNwYOKXR4+IzRf32kyh8iz6h9zPIhnrm1laqzW6DH9Xh3dCYU9Ax9WKiCpgDDIBztYpkdJeYzELpam6NblJPKCWZ/O8EC3vm3gDZdmTXK9D++DgbSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991408; c=relaxed/simple;
	bh=fLxXhHyvszlulcQbNWxIcHQ1zyGvDt9NH2jjQh/KQCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVH0AyeP5x3GwqRnPIYlCCE68ZeV+io8g1MjlOEi+R03kKKcI/cDMKGVtPhbSaPw3fAH9SjvRpOltuip9GU6Kk87xEYyxenR7/ySNfqCZ2Zou36UMdmlFGRwc/XJ6MN72GLeDDPXhPZCqplSX5GtQnwMWwo6UEKc7PnFAJ0DvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S+8VAjKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0vDxOpq8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S+8VAjKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0vDxOpq8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 258001140237;
	Fri, 14 Mar 2025 18:29:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 14 Mar 2025 18:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741991397; x=1742077797; bh=tGnDoA6UTT
	y1StFhP9QmW5v9SHzLO0zDVMgj+kz2+JI=; b=S+8VAjKhpeNbEM6MGLxL9AX8AJ
	9f/5vgsPg30ylF8JGcA6A5+1eH/ZMA3JyFWevHlHq9cT1sia2X1mkYRbqvHsx4Sr
	93qbbFl/Lb0mGHMVXy+lgaKSGNzlfbt9OGwjHU1ZKisoQtdPTJI/neMDA/0/ThcW
	b1ljWMP1Ndji8nH3JzCpYraK3Ts83KSzH6rYzG3I8NNy3bepn5oznsdEJdqXIPIs
	K00uhHLLBLSN8zxYy42f3nrjjOC3LgVmcIQ8Sygve6OJYAz+9ySix6b8dmUeSA/D
	irFmshq/IHFrEeAv9oM68DUxI+McNWvvvYWgHVqMH5Uv/8rHqmxSuePdvkYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741991397; x=1742077797; bh=tGnDoA6UTTy1StFhP9QmW5v9SHzLO0zDVMg
	j+kz2+JI=; b=0vDxOpq8EBtRhFCwn2/5BrS33xxqR4yFIYwPCfa+ntyx/JkGNGa
	iEnTaAB7YEGFqr1p3jiEYoRKeG6MprzcWwODh44d+ULEw+sTuzsBdOrFtdV0bqQZ
	cvWXwhQlK4O7QqLWfuQlLKBTmqgPzKaIR/Z5y7Bryk1K/VtXbZB+WseG28PNdQGC
	sQrRGG25e9mo+VOcI3YPelAVlE/jri/jKJCO44quPPqmXm611LoxUsB8GkyhcDN6
	sbaly7e3wMVb7m2SC7gXHHX3hFgbLH/0F1ApcBtalKz0Iiv8saG8Z18xa1CXB8Dy
	iobApkGQcEsqupLXU+iZ8xIKFwl540kytrw==
X-ME-Sender: <xms:463UZ1nTJcEHNKA1mt6jUD7wGPOt6cDJeT5Bg63oykC7Ao-DkB6ZoQ>
    <xme:463UZw0P_4S5yT5eKvLug8KBpyLIk01YUn0K3G-ifB2GD8c2CO__TYJ5AWskTfKeM
    5If3w9EWyurimhvNg>
X-ME-Received: <xmr:463UZ7pue-UadJH8II2GUSyl0fHhrc-ToXLVpmQ6gmAcmw_Li3JRR1arhakH5tGyGHnq6wZGA6kKWJAxyAMB9HbNR3zUrdhSFtZrZMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:5K3UZ1mtZD9yVOaUa2tmIfQmcCykIWn-1kK2pasW4UwlwSRbOLz8JA>
    <xmx:5K3UZz2J66mSlAZdO3EERTqgKdzxaqwChJREbCKYtnN-XzH1B0xHWg>
    <xmx:5K3UZ0vZuOH0MjVTba0H4YHgOzVFMYh71Hoo1CD6RPX9nl43E7-kbw>
    <xmx:5K3UZ3V4r_wr8ZzwiH9-I8mbGkL3PmkqFAO1s80HwOVaU_kfX7Nvpg>
    <xmx:5a3UZ-TASfdzUhWGiOOzsMKLs1IXSwBn6EXZntd74kGQnECywXyEoNIu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 18:29:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/3] git-compat-util: add NOT_A_CONST macro and use
 it in atfork_prepare()
In-Reply-To: <20250314210909.3776678-4-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 14 Mar 2025 14:09:09 -0700")
References: <20250307225444.GA42758@coredump.intra.peff.net>
	<20250314210909.3776678-1-gitster@pobox.com>
	<20250314210909.3776678-4-gitster@pobox.com>
Date: Fri, 14 Mar 2025 15:29:54 -0700
Message-ID: <xmqqecyzdz4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sorry, one new file was left out of the patch.  Here is a quick fix
(I am not rerolling the earlier 2 steps).

---- >8 ----
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
 fbtcdnki.c        |  2 ++
 git-compat-util.h |  9 +++++++++
 meson.build       |  1 +
 run-command.c     | 12 +++++-------
 5 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 fbtcdnki.c

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
diff --git a/fbtcdnki.c b/fbtcdnki.c
new file mode 100644
index 0000000000..1da3ffc2f5
--- /dev/null
+++ b/fbtcdnki.c
@@ -0,0 +1,2 @@
+#include <git-compat-util.h>
+int false_but_the_compiler_does_not_know_it_;
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

