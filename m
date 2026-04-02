Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9EA3890F6
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115099; cv=none; b=WSan1nyD3zSXAkJHr/MJ0VqIx/nRnmb8QNz54hxDL9wyIpzZt5wWBrM4yklw0B6j3wIpVo/PvY3z6Lie9R1VD7AjjzrnbvKBJQHPn0kCBe7T5I46NphQClqLEl6a60xZbxHR5BQTG/c9Ig16lASX9h/MeKlg9JNBisUyHVoP25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115099; c=relaxed/simple;
	bh=rSOKjtlZZKCMhWxZWgKBC2pvN9Amie/qqUxR/2CUngs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7fLcVPnqdgXS4AFt47andK3QAQqMZWMwxyQnadvSTnzCkAXVtitbWNAYbfrhVERlGQtbmUjFgg1lSOynhm/NU0E7SL0IEjeuowkCZrAxoF/yTI7wep/WLT36AwQNkflmH5/ajoLMH+PZKEkimC4xc52eJqkCjG+x5b9hls6n/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gIRukQ+3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOJaOMak; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gIRukQ+3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOJaOMak"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EC4D71D000BB;
	Thu,  2 Apr 2026 03:31:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 03:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775115097;
	 x=1775201497; bh=IKKiaEDpDlODJS0eghORFjvxoZ17js0VhFjvN/Abh9c=; b=
	gIRukQ+3YBcKGFAEHS1kLDYVWuOceW0v8WjMgPCfscPwYWuYohiqyqFX6YfDCz1g
	XQ4G9nhQxZG/k/mcegiiKUf7fnrSX7xIJ7hGqdJFDgquUTjtqpGnOWgQfFz3ebMe
	2WFUF2sI1TQAqLS5ufLSv891Gd0CQJsVyF43iXqDsGio4kZJloQpbitvIHFR24H0
	GPWzDu480hpmFcZxnNN7wfhpJnLCcTV8xD2L2yH6RSAxumUXBR+Vo1cxRDubw5ro
	90SBc4LNxR1EkGpCP+WQWXNlQkPT2UUZLrlgcK8LhaBkKY2NhRzjLmOm+QiL4V89
	p81hn2O9ZciIAoxABYm9pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775115097; x=
	1775201497; bh=IKKiaEDpDlODJS0eghORFjvxoZ17js0VhFjvN/Abh9c=; b=A
	OJaOMakZ21fsw/4ZATzFMfYMJeUuFHDTtHmEbTAEGP7ondf6wiXf91PHO1G0Jgub
	WVJU5nhDeDmpvF+U0aJcjDj23ZH3W6iYCPHRFVPhz2tI8Y+w3NyA8NsrG7rcW8nV
	SSM6b/GkHSF2sJivNFX4yJ5p0P+5xxUXWNEONX/nFboykOjkILYo5O4ILQNZHogB
	BqFlxiW0duDdDb88GqCSwu5gtISLyUez1AY/7owU8/vlazgXKZ4w9K+pcs8q+Brc
	HAvJacBKdrXJKg+K1Zolr+CKBqWJYcV9Nby5IYOc82YnezjVXfeY6pbrHYxLsRi6
	B+BROlEDnbPI2Bissfu/g==
X-ME-Sender: <xms:WRvOaS_qBJcgLckikypY8iQ4Tb3Sv1Z-NHx_maHYi5T9BhDvdK-9WA>
    <xme:WRvOaZuwAMDtEcqjHCKaEisS0jIRqpUwAJKjCMihIvxX4khqRSp5QLTdyWolTA6ol
    LMb9NsmijaZA8I2iQZy9f-9bA8wRs6Jib5T7xHpLcMJ9zIDE-JS>
X-ME-Received: <xmr:WRvOadCBxAVxonc_CqF-IBlRcSnBPwXktjsU2tHkGpqxpALnD3dFIHKiYrYr3ZOuzqNVxiXNXP1tD2t137UkqDh1_0Wjk9-hcOJQeocNGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WRvOaZUzLOYv_g4-f1fx8_vpQ3ie1l0p0FDMAfy5cbmt3XD9d94eBg>
    <xmx:WRvOaTAKxyeFStIF5o0r7dE5kAjF3Sa_p0kVQ7972dmfMwYITC6tdA>
    <xmx:WRvOaU_EvBVm09dnAa9TfFFNwSxBkVjoyCWCKQtJztx7SnwB0faYAA>
    <xmx:WRvOaSGjfdz0SsMaHX_tZtOioPwMRrrIZjagGsjIyVz-AbLNCn9swg>
    <xmx:WRvOafQPXVivnbrck3Phixe40GYWOU60UOHZciPIxgaf6OWYwKlj1e1S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:31:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa92c7ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:31:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 09:31:17 +0200
Subject: [PATCH v2 4/5] reftable/system: add abstraction to retrieve time
 in milliseconds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-pks-reftable-portability-fixes-v2-4-bc110cee0ae0@pks.im>
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.15.1

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
index fa87b46c37..1fba96ddb3 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -365,45 +365,26 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
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
index 4d7e366b55..cd76e56be8 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -4,6 +4,7 @@
 #include "basics.h"
 #include "reftable-error.h"
 #include "../lockfile.h"
+#include "../trace.h"
 #include "../tempfile.h"
 #include "../write-or-die.h"
 
@@ -137,3 +138,8 @@ int reftable_fsync(int fd)
 {
 	return fsync_component(FSYNC_COMPONENT_REFERENCE, fd);
 }
+
+uint64_t reftable_time_ms(void)
+{
+	return getnanotime() / 1000000;
+}
diff --git a/reftable/system.h b/reftable/system.h
index a7eb6acd4a..071bfa3d58 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -111,4 +111,7 @@ int flock_release(struct reftable_flock *l);
  */
 int flock_commit(struct reftable_flock *l);
 
+/* Report the time in milliseconds. */
+uint64_t reftable_time_ms(void);
+
 #endif

-- 
2.53.0.1323.g189a785ab5.dirty

