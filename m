Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228802E92D6
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992494; cv=none; b=M/iA17A9jmsToZV7UyfG06mfWeZYeKLLrysJ4Rl6TiTWMmRimWzQBEkjKCM/LVLZbks+o5cjmI0GLuAhGwCnPZ5Kf62M3ZAHOcINTPVm8w98b9ou6ASed35M6jn68K+Q+Xr25hW8WcbLk/Ofo2TtOcQRLj6fx+KtN9aouO+FLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992494; c=relaxed/simple;
	bh=Z/3n266dE3OnBgm5KKdgAsQ+EdLUfiGCu8ce+Y4oEF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpZExhxHJNbxQHYx3VvRA26yM96HPmtBseJrhspN7iV009BJLx7a9BkHKfFIuEqiNmE5ktmavmbXqEL0iX6KygGrh6xjn8AB+xM4s6rugHZNs0B855ApIX43R2kaGigb0r10sR4o39xnG99nM2BbH9tAPx2ye1rISdbkukr/ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PfUNEvzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fe1OECyF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PfUNEvzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fe1OECyF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48B1514001E6;
	Tue, 12 Aug 2025 05:54:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Aug 2025 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992492;
	 x=1755078892; bh=fW2Ou12DIYvoP0C8aly8FLKX6skAjRs2Xk7z+/2ttu0=; b=
	PfUNEvzYDvNb39BAkzzH0uVm09566xHoV6KrU8TqB85rViKXOXtFurNSkvzd5C1v
	q2/CUpzBdsOE7XMPy/NWLUsocSNmbze6CmB+x4P88wmnftJrNQFyYlS0Lh5dTn/s
	YqihShNTyDra3ViHqKVAN1SCRghC8S3Qd5k/bFc9IMTDCfN1seA1EFEYc4RWyKAx
	lFsZ6dIADbxogEGMt+hjMp9tTU8g/CSM+TROZG1JVc88GvSLU6+agn8LNB/3Ia1T
	AS+kbjMSGw+39DkYEmWqFPXPjqPoSbZzgDTKjo2NmR/E/UixY32hyrTv+WIk3QsY
	akQu/c3PKg24btPLQcdsiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992492; x=
	1755078892; bh=fW2Ou12DIYvoP0C8aly8FLKX6skAjRs2Xk7z+/2ttu0=; b=f
	e1OECyFFTEoElGlHT3c1JXHDcYf4fGRj9TwgvmWDDVe17QCd1HTvW25ASPv6ECzh
	k58JpgIWyo1pKCgtTeIcsqMi1FM2VFQSbfa47Zz/LB4bK5ZLDoukOqJ2/XRzP0yv
	ab2B0dJXpa7qK9KXymbEaLpWGyOkDk113PGU/2J8mPBRzNBlfU1zOD3FawBUcMYQ
	doHB6QOHRA8UkKWXz1WGyYQuz+3+N15OCEP3Y5Hz3EpkZapo1XVraKzef7Mr/Ihl
	lGH2Yrxmd+y6SzIogQHk4wxN/I6DQfLxksBpEsljS84M5h73trXpTF5u4c+YTbGh
	gi01lTDI2TQjh95yeAqHA==
X-ME-Sender: <xms:bA-baFwfiUflaap-3odyLCjzmr9_Sgg9MvRTVtSuhG9ExNMaRH35pA>
    <xme:bA-baAyVcfucMG_viixy8Q9-p2Vn914nLbIEuYi3msK7G5VVC9w6PfD4wfHbY1tQe
    BvhJqxPFqfldLu-Zg>
X-ME-Received: <xmr:bA-baFxo9m-kILtOP7gVUTn9UolxBuXpeinfD33muOM6Quw_G4s0Zm7m5ZlALCUn3_X2VRl3tVrgtINEmIXIPl6VA85wxqONByq7OjT3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bA-baCbUkj_FnAdyQd91S88ceBwsYx65o1a7XF_IMhKCDhAdGwc29g>
    <xmx:bA-baOXRIoehM4jA0alralYjavOuX2Wb3MShHS6nq4G9vBnp9xfb6w>
    <xmx:bA-baIhkvD1TzfhJgT0X7rfFQSCzRE5QvhKTtu2knMAHKDmcqREtEg>
    <xmx:bA-baEs_WiA2yqBuadU_3jrN1D1ybW2GQA32kRd3bE59B0pWQZ1j1Q>
    <xmx:bA-baBsJ69W4cTw95o1GparKpUlqXzF1eVbVIowV0TOhiH2QotNhMaqH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 916ee8ac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:21 +0200
Subject: [PATCH v3 7/8] reftable: don't second-guess errors from flock
 interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-7-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

The `flock` interface is implemented as part of "reftable/system.c" and
thus needs to be implemented by the integrator between the reftable
library and its parent code base. As such, we cannot rely on any
specific implementation thereof.

Regardless of that, users of the `flock` subsystem rely on `errno` being
set to specific values. This is fragile and not documented anywhere and
doesn't really make for a good interface.

Refactor the code so that the implementations themselves are expected to
return reftable-specific error codes. Our implementation of the `flock`
subsystem already knows to do this for all error paths except one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 37 ++++++++-----------------------------
 reftable/system.c |  2 +-
 reftable/system.h |  4 +++-
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index af0f94d882..f91ce50bcd 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -698,14 +698,9 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 
 	err = flock_acquire(&add->tables_list_lock, st->list_file,
 			    st->opts.lock_timeout_ms);
-	if (err < 0) {
-		if (errno == EEXIST) {
-			err = REFTABLE_LOCK_ERROR;
-		} else {
-			err = REFTABLE_IO_ERROR;
-		}
+	if (err < 0)
 		goto done;
-	}
+
 	if (st->opts.default_permissions) {
 		if (chmod(add->tables_list_lock.path,
 			  st->opts.default_permissions) < 0) {
@@ -1212,13 +1207,8 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * which are part of the user-specified range.
 	 */
 	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
-	if (err < 0) {
-		if (errno == EEXIST)
-			err = REFTABLE_LOCK_ERROR;
-		else
-			err = REFTABLE_IO_ERROR;
+	if (err < 0)
 		goto done;
-	}
 
 	/*
 	 * Check whether the stack is up-to-date. We unfortunately cannot
@@ -1272,7 +1262,7 @@ static int stack_compact_range(struct reftable_stack *st,
 			 * tables, otherwise there would be nothing to compact.
 			 * In that case, we return a lock error to our caller.
 			 */
-			if (errno == EEXIST && last - (i - 1) >= 2 &&
+			if (err == REFTABLE_LOCK_ERROR && last - (i - 1) >= 2 &&
 			    flags & STACK_COMPACT_RANGE_BEST_EFFORT) {
 				err = 0;
 				/*
@@ -1284,13 +1274,9 @@ static int stack_compact_range(struct reftable_stack *st,
 				 */
 				first = (i - 1) + 1;
 				break;
-			} else if (errno == EEXIST) {
-				err = REFTABLE_LOCK_ERROR;
-				goto done;
-			} else {
-				err = REFTABLE_IO_ERROR;
-				goto done;
 			}
+
+			goto done;
 		}
 
 		/*
@@ -1299,10 +1285,8 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * of tables.
 		 */
 		err = flock_close(&table_locks[nlocks++]);
-		if (err < 0) {
-			err = REFTABLE_IO_ERROR;
+		if (err < 0)
 			goto done;
-		}
 	}
 
 	/*
@@ -1334,13 +1318,8 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * the new table.
 	 */
 	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
-	if (err < 0) {
-		if (errno == EEXIST)
-			err = REFTABLE_LOCK_ERROR;
-		else
-			err = REFTABLE_IO_ERROR;
+	if (err < 0)
 		goto done;
-	}
 
 	if (st->opts.default_permissions) {
 		if (chmod(tables_list_lock.path,
diff --git a/reftable/system.c b/reftable/system.c
index 1ee268b125..725a25844e 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -72,7 +72,7 @@ int flock_acquire(struct reftable_flock *l, const char *target_path,
 		reftable_free(lockfile);
 		if (errno == EEXIST)
 			return REFTABLE_LOCK_ERROR;
-		return -1;
+		return REFTABLE_IO_ERROR;
 	}
 
 	l->fd = get_lock_file_fd(lockfile);
diff --git a/reftable/system.h b/reftable/system.h
index beb9d2431f..c54ed4cad6 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -81,7 +81,9 @@ struct reftable_flock {
  * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
  * we block indefinitely.
  *
- * Retrun 0 on success, a reftable error code on error.
+ * Retrun 0 on success, a reftable error code on error. Specifically,
+ * `REFTABLE_LOCK_ERROR` should be returned in case the target path is already
+ * locked.
  */
 int flock_acquire(struct reftable_flock *l, const char *target_path,
 		  long timeout_ms);

-- 
2.51.0.rc1.163.g2494970778.dirty

