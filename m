Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415EA2D29D7
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066358; cv=none; b=TMMRWsfO46Rt1G55t/VWON4gq9nX6LvhRzeBIJGsztYe8vsRHs1ug2FfsfAYWYL5/BrcAZYTRnVUt//evEHDXcLls8EcWhPgQY35CwXMBINeWk/P3BY0cGNPaXxqr4UtDN1/l0Fv+JBZ2CzX9sqaHYYKguuYB1hiAzFDQfgXqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066358; c=relaxed/simple;
	bh=lVGN48HLJcezHshjEpXqQkvdCS40G0ayuyjzP5emQ5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTaHNmwxhFb0i5xYx51bzHiZsWXvQdNrprB3GHJWuGu3HM8KJCYMVlAQsmZ5xlItmtdWKG4H3kDIq0MkbBbf7wnmwPPn4vzf02Qn1q5hMAe9g237/xxK1UM+drJ+l0nXNg+8/5Tm8BMOND0nouLAycwSuR+P6OJ+63/QoZjy9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lylWYsY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MP6+yioS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lylWYsY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MP6+yioS"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6342F7A0116;
	Wed, 13 Aug 2025 02:25:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 13 Aug 2025 02:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066356;
	 x=1755152756; bh=yUNybHW16jZijYuT8hmJS2Z78Wtwsmq3+oCn6GK+coc=; b=
	lylWYsY65piCxHO9z3JcIHHVddhn83zRtVvCpNQ18gqRWI89BhDYkebHFQBe3NWV
	bRu9PsBX2PNGz0RRfASdbH0+j2PwRsD4w7kUOGWLlx52bdaW4anKipnFNVjlI8ZB
	htaOPVI6pAifvkjeRVLx6TM19O2gjd2HFOx+dzS48wMcqd7iWrH8+m8JPJnblzST
	iZ5tMCd2pI0nWrZsPQkCZ0zO6Ikx2OfRZfunkcGEiuNDu2T65QoWsCbxBAPbDf/C
	AtUmr9adJlig54jLHkJiVF0D4iDyIatqYsw+FIsWcmIVA1A1bmgru1Bd5yjBl7y0
	DK3dD02fyDHcoLO/psQa0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066356; x=
	1755152756; bh=yUNybHW16jZijYuT8hmJS2Z78Wtwsmq3+oCn6GK+coc=; b=M
	P6+yioS7bw3CzXh9DqdwB/4pXA2qDYK5iyRvOPkqDo01Y96Rw9nUoeSSG9qkwOiv
	3kr0lx5t4W0DdCEMj1uoTKxj2rSiDp5e4brKp4n2JDMnBwytpoKBvtrfGxB/PgA6
	2ok1ZLxuJHaiYYAoNhiuCsB6v3tiQsKxlKaTL7qgl8H8hVjyIioRAmKYjQJ3rnQV
	jrCS2jMTK9WLNsyE7Y0eYtjcB6N52ZYS2BaZjHm1Nq6cWSAVPXgxr4QuL8W53ude
	5TimwZbaNZI7Zrs3FrjrCOBDUdS617RS0I4wK9DhylE7YEDDlpkdbpiGvGxaQeLa
	Mqrtvjsfj+C8glLGKyFNg==
X-ME-Sender: <xms:9C-caJblmfXBvimnGPZNVmWm95ZSIseHhqGx5I5aEzliU9F_UoEZBQ>
    <xme:9C-caL4XJjSWX0xD5EjvtkANVYOjc5DPJYx4NVxlqcG1OOYT1wBiAf8AB1WuWY7Av
    f43ylpW2KBNoWXJwg>
X-ME-Received: <xmr:9C-caCb6VZppHSAE8zH4djJziG89lSJbK0WzE-WYLBQnK8D1HakklS2UmgHIZOoXnmrFS70SRrSYejwJVYLaQHfvpTsgwVAIBJhXwLZMs-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:9C-caChjd7lGWDa4-30k0E2QHGCSCQCOsFwKY2bweBds-T4cSZhA8w>
    <xmx:9C-caL-Bx1cMWVbe4YV0gG0-5JVmmwYEAXzDhZFfO7B3yk5sGxJSqg>
    <xmx:9C-caFog0TJTOReyRqpTv5LZiioezxbIhSnCJyuWmep0u9Hq9xAhLQ>
    <xmx:9C-caLXjhFyOr2eIBBkSNCZlcIg5dtbGoGJieRlV79p9z7Pz8mfWFg>
    <xmx:9C-caP1WHpoUZf4C0Zgs3X6TnEm0kGJPUbZ-QpvbyXXmz8oPLxpW0wOL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cd9f500 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:31 +0200
Subject: [PATCH v4 7/8] reftable: don't second-guess errors from flock
 interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-7-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
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
index beb9d2431f..0c623617f0 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -81,7 +81,9 @@ struct reftable_flock {
  * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
  * we block indefinitely.
  *
- * Retrun 0 on success, a reftable error code on error.
+ * Return 0 on success, a reftable error code on error. Specifically,
+ * `REFTABLE_LOCK_ERROR` should be returned in case the target path is already
+ * locked.
  */
 int flock_acquire(struct reftable_flock *l, const char *target_path,
 		  long timeout_ms);

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

