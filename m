Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3C3D47BD
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956428; cv=none; b=cZICaQslO4DTE3eZ9kIKR4n51gGQvPaDytAEbC6XoNuWNLpK9qb7qmDPSzdI2NzQJdnUgLfwsu+IATn5L9IVq07Ma9EB+MKyne1JMDpw3Yz5i6D5TutWmdnrjGkQsqJy/J6LEtMeg1SggTMw11Daex+6XWyyFXnlnxhgIyqLonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956428; c=relaxed/simple;
	bh=iw5dh4KFjiaXqKUvKi7bjHwaBfOi0XN5/I45VVu1LOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTfV+2TOj7K1KDsBKJwBHO8WxTVrRK/w+ZZXI/GEptwlI90wKKuGgmdT7yq0mcwxb0XeqNoC7Rc6TqORLmkH3ayyDpse+74S8TU2SqdFonnPAT8rB/RmxmuASabLAzgAjmHKnKTBAUaLuGksiWuMf/muPw6sej4Uv6aKfyKF/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ThDA/5AT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k31hSYPJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ThDA/5AT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k31hSYPJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B377F1400213
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 07:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774956425;
	 x=1775042825; bh=lK3OoGl6X+OwctGXpDrgfv0IKqKJI1f5n2Dv1NUOKlU=; b=
	ThDA/5ATGhnqVcBSUNo4ZrcQxYCPyMyEqZqiODbsFa7zXxs2k+nai7ErFV9fJXai
	Fb7evVq5QDX+8WRf1NQJakifuwUx4Ru/q9TqiaExCZNWKpxzonCmvTn7ZbpOgPVQ
	gqvZYjhh7LwYo8403BwrE0rTw5JEx7I4fcg+1fvT6M4gB8npjoL6K+AFuTa8epM3
	4hdPaPbkChWCsUVqRehQMl0bpELBBuYj/CflmmzCvxaGy5mzWJLeuYsy/Y2GXxrF
	CigWjsi24K8jnW96gpKNe5yfK54Yq/OrMG08k3PoufrpCQQgAQ3rrqHnsP5xsMz4
	xMdZdCDdgKvh8OQVt/p5cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774956425; x=
	1775042825; bh=lK3OoGl6X+OwctGXpDrgfv0IKqKJI1f5n2Dv1NUOKlU=; b=k
	31hSYPJKdACVNb31clbbr5VWTpMjEtG4kLbsq9Usp9h9vUHvKEkCdRrH+rVuDjwd
	IO63kgwkgtB3lq51WxatYsnKJuaNPwcOs9uTSPywkhad6AG+/73I4YIY/l53ujM8
	5Zg0e0oNHC4/fOQiFg3twlnnueJ9KbZeh6RiB4dDNktPbKKSlbYMWlM6PAA2llaZ
	dX6cFPewUUVmHr3dNTMZLp6WRLDzXsSqB71z3Edxx/9LTya6+p/+4xT5iMsxXWYA
	0ezFn0yho0vBXyAwpLG+rlKL5rL0+m1PjnIP5uZ5gsmyBHZVxX8v2qieL6AAvS96
	aFxPfqHpY+Bii0LXH2hiw==
X-ME-Sender: <xms:ia_LaeuSGkl-qtrcj9qv5UJq5QjA7DJlNUeDwVKaL882AXFJl66LFA>
    <xme:ia_LaabEk-G0YinCLKQsYwCFZDhwuvrYWlTVot85wYEiDUjEHB23eLPTxT_afxc55
    EvZZetV47MpRwOQJF6PMxV0HRECxpP_gWTZYNQahAD1Pz5hrKh_rA>
X-ME-Received: <xmr:ia_LafZJwoesnw5KZgOjW2at1ktq2qwF60gRZ8dbGdUwkS_EMXK4klk_RbFfRinKqyfSy2DF4YHo3MBVGA6h7pEygjpFHPL9qSHilSEoBEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekud
    ehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ia_LaeUCake_EC0JTZKYIxXpjJAgZObMwLKjbE0bQLuLixWfWB1Mvw>
    <xmx:ia_Lae3u_Yie60440qFiaPD8d4dH4kGr1C9o9iTTc2DJOPbAXWqg5Q>
    <xmx:ia_LadaV7gJKgMbW5rnRloh2feRDe1UqNIrI3fbSkVnR_HrUIx2dTg>
    <xmx:ia_LaZoZe15WJnkdVr0nS_9JPe08Br_ZtLkv3P3CeAFr84kBnxLm9w>
    <xmx:ia_LaZfVqIfcfWsHppE6MTBamgMqShKLCUicg9oDGZ3WjMgkUfVTY8-D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f5c1cef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:27:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Mar 2026 13:26:50 +0200
Subject: [PATCH 4/6] reftable/system: add abstraction to retrieve time in
 milliseconds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-pks-reftable-portability-fixes-v1-4-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

We directly call gettimeofday(3p), which may not be available on some
platforms. Provide the infrastructure to let projects easily use their
own implementations of this function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 27 ++++-----------------------
 reftable/system.c |  6 ++++++
 reftable/system.h |  3 +++
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f9ae832e3a..2d2c9b1f84 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -372,45 +372,26 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	return err;
 }
 
-/* return negative if a before b. */
-static int tv_cmp(struct timeval *a, struct timeval *b)
-{
-	time_t diff = a->tv_sec - b->tv_sec;
-	int udiff = a->tv_usec - b->tv_usec;
-
-	if (diff != 0)
-		return diff;
-
-	return udiff;
-}
-
 static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 					     int reuse_open)
 {
 	char **names = NULL, **names_after = NULL;
-	struct timeval deadline;
+	uint64_t deadline;
 	int64_t delay = 0;
 	int tries = 0, err;
 	int fd = -1;
 
-	err = gettimeofday(&deadline, NULL);
-	if (err < 0)
-		goto out;
-	deadline.tv_sec += 3;
+	deadline = reftable_time_ms() + 3000;
 
 	while (1) {
-		struct timeval now;
-
-		err = gettimeofday(&now, NULL);
-		if (err < 0)
-			goto out;
+		uint64_t now = reftable_time_ms();
 
 		/*
 		 * Only look at deadlines after the first few times. This
 		 * simplifies debugging in GDB.
 		 */
 		tries++;
-		if (tries > 3 && tv_cmp(&now, &deadline) >= 0)
+		if (tries > 3 && now >= deadline)
 			goto out;
 
 		fd = open(st->list_file, O_RDONLY);
diff --git a/reftable/system.c b/reftable/system.c
index 725a25844e..7aecd3859d 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -4,6 +4,7 @@
 #include "basics.h"
 #include "reftable-error.h"
 #include "../lockfile.h"
+#include "../trace.h"
 #include "../tempfile.h"
 
 uint32_t reftable_rand(void)
@@ -131,3 +132,8 @@ int flock_commit(struct reftable_flock *l)
 
 	return 0;
 }
+
+uint64_t reftable_time_ms(void)
+{
+	return getnanotime() / 1000000;
+}
diff --git a/reftable/system.h b/reftable/system.h
index b15768dbdb..6e00cd32a3 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -110,4 +110,7 @@ int flock_release(struct reftable_flock *l);
  */
 int flock_commit(struct reftable_flock *l);
 
+/* Report the time in milliseconds. */
+uint64_t reftable_time_ms(void);
+
 #endif

-- 
2.53.0.1185.g05d4b7b318.dirty

