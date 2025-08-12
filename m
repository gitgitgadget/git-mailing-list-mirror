Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27D2D978A
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992476; cv=none; b=fmF94lc+jpAJurWgowZc6OaGsTVfaHGiFa7XsyTqoJTyUUbfxyaW4BMzi1wntot0AOWYKmLPG38R4+nT3cshCak5Dx+UqJNB63EX3/tmF7jPncTyUs4d30geOkKolLHVf7ngGRKEQBrVOEWuO0YsZcPmsuuVPaKblmSoVCKMpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992476; c=relaxed/simple;
	bh=dx0l58wW5npGXm2XvbgrbPPuVN5WHM27SE5B99iQ1dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAyTZ3nwslEYxisYI9rShgfMceMPByF8Q13j/lQlNQHvGb8ltdsGhB2/MAs62XRhktIhOGgzZ5Ft9+gTEp2w19WOWHCEZM/ANV6FNUCOxi6JKYadCE9ZWgfkbaUYuT2bhSOrF9OgmAsLqq+e2seg0FKVHmzLBOgFRIcfJj4C2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XnISiR/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxsHZcmO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XnISiR/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxsHZcmO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C503F1400111;
	Tue, 12 Aug 2025 05:54:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 05:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992473;
	 x=1755078873; bh=DlQk5U808mvEq9DlssG1NdjPdTPf/DC7oS51ulF8Ots=; b=
	XnISiR/1+Rp61bX5CijWC45perwNw1XNa9IgmuthGkQXTxy7tMamj4mQIJzcXzEW
	NohHKs7vVQK4b0V72Ef/By1oXrwdHI+voWXoutTbUDB8SabaDyxG0XzcRi7MTnIX
	uT/1Q3awb+9HbnhbJHbwaeBDsLxj3vj/v1dTPkaADanyH/hinhg028Ta6ej1y7+K
	7cuDKwURx6VdrwDvoxoRJCXf3hBNeUhXatobSCF8lk4x9vf0vWr2W8rvxF3hdDDo
	aJkVAwefwnKU294IhppjHsQkJLkJGCoVap91WOppYuKG2W//oqzXWHMqQkJ2ZVPE
	8cFJOLHe8j9RgdqHsxhYqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992473; x=
	1755078873; bh=DlQk5U808mvEq9DlssG1NdjPdTPf/DC7oS51ulF8Ots=; b=l
	xsHZcmORjwIUfM42G9PqjH9FZmJoxwepnfEchoMS/Us8Nvm/kjFh89bxzLNxYGLn
	PteW0I2Ed9WyGEa3VlQoW42dI84od72pnOcIaAgBDwmiUNOGUJstsBHnamOpsl42
	k60Z10BV06YKS9ly08dpiu2RxtwJ028j9eQ6wNetTyeSpuuCTjMzOukeWmLUHLuk
	mXII/ZVzJIkNZt8w+i5eRVAZqy64Ap3r4vsZAQXwy9vZswnBKg4XUAFhVS5kqqe1
	6gARBiem7alURs+zuzNh46YCP6rEGwE2duzE8zgj7IBulKY7IFH0AD84lpliZBpz
	XIp4SbrA4QQdW6yWc9luA==
X-ME-Sender: <xms:WQ-baCe39Bs4c_Aif3i0BASvHrefXwIkzKX9OD6-IKbZ9SnOStYLTA>
    <xme:WQ-baHuYxRDV9ocgWom8MLbb2yOC8nA6ugI6ytLQx7_Nxkvp51SARMfwyiGexHygi
    Q2HS51ery37jrPhcQ>
X-ME-Received: <xmr:WQ-baJ-YJWzhEHpRLL_aWIo8VNmRhIhU65XmxUZMZDYXbNebxm34VY1jlOtKRknLBpm33Oi8tYEZa2YPhmmMEfXyl3K4n4101lH7LGkv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WQ-baK2SypwxRE27FKQI_MEX8LiTg52iJfJF9XzhLkfy04HRJ3fxhQ>
    <xmx:WQ-baGA7gANh9WlCflkigC0FRAcB-_8GfzYQYVujXA6vKO4GS80O_Q>
    <xmx:WQ-baOfPqgUQmvU5voCn3wZM4DbfzVcs3xTtMgbWCdplFpburuQ0Wg>
    <xmx:WQ-baL5Q6dKcgBnh9po8ujN1S0fgoAclM8jMhg2TC4aw9ULy57e2aQ>
    <xmx:WQ-baLLDxG-Z4hl0nz7BCIT-mDxHig5EkC67_7vqBMCZzvIbw_09WksH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 322e39ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:15 +0200
Subject: [PATCH v3 1/8] reftable/writer: fix type used for number of
 records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-1-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

Both `reftable_writer_add_refs()` and `reftable_writer_add_logs()`
accept an array of records that should be added to the new table.
Callers of this function are expected to also pass the number of such
records to the function to tell it how many such records it is supposed
to write.

But while all callers pass in a `size_t`, which is a sensible choice,
the function in fact accepts an `int` as argument, which is less so. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h |  4 ++--
 reftable/writer.c          | 17 +++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 0fbeff17f4..1e7003cd69 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -156,7 +156,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
   the records before adding them, reordering the records array passed in.
 */
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n);
+			     struct reftable_ref_record *refs, size_t n);
 
 /*
   adds reftable_log_records. Log records are keyed by (refname, decreasing
@@ -171,7 +171,7 @@ int reftable_writer_add_log(struct reftable_writer *w,
   the records before adding them, reordering records array passed in.
 */
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n);
+			     struct reftable_log_record *logs, size_t n);
 
 /* reftable_writer_close finalizes the reftable. The writer is retained so
  * statistics can be inspected. */
diff --git a/reftable/writer.c b/reftable/writer.c
index 3b4ebdd6dc..5bad130c7e 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -395,14 +395,15 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 }
 
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n)
+			     struct reftable_ref_record *refs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(refs, n, reftable_ref_record_compare_name);
-	for (i = 0; err == 0 && i < n; i++) {
+
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
-	}
+
 	return err;
 }
 
@@ -486,15 +487,15 @@ int reftable_writer_add_log(struct reftable_writer *w,
 }
 
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n)
+			     struct reftable_log_record *logs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(logs, n, reftable_log_record_compare_key);
 
-	for (i = 0; err == 0 && i < n; i++) {
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);
-	}
+
 	return err;
 }
 

-- 
2.51.0.rc1.163.g2494970778.dirty

