Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1B2F691F
	for <git@vger.kernel.org>; Thu, 28 May 2026 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951682; cv=none; b=ksu0z6wePv3yxOIF4VlDXQIEKjE22hFdJ7qexQaMjSm2wqeWc8lWnAytCQqKaj108CUP27HD/PyIH7A+NKFyPWl+Yo154XtR7rE6ZqFU7QVum+BiIMskTZvmlB7MNTBxO4FvUilHno7SaP6x5W7SpZvdY+GHzj5A6PmgXZoVhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951682; c=relaxed/simple;
	bh=U0YiJZBNuHWPKOQm0yaxHkGuZfhlmAP8mLK9HfS8Cbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRFdwso5XGuRFh8EufqPQh7766RW/juSghdxuHx4pChRNXYUJfgFQ2DyJf5pweYjnHEia0gyuuUBOauInYKj7KiqqMHNxZmKq74/vKRmYyO9AOf6pY+fvVIhszilNK0m/oJzugyPERrISg13TPHl11wTronRIwY6G1oz7EAJkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RwvRrHSV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hzg2BnYQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RwvRrHSV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hzg2BnYQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A73BC7A00F7;
	Thu, 28 May 2026 03:01:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 03:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779951680; x=
	1780038080; bh=dQsLOhqmS7Al1Z8+kBXKEVDcfYyM7xjH3Gmu34qf39w=; b=R
	wvRrHSVuU8DazyMQx4hcjr2hYFmFqvwifILs57WSMKJ2BFa/0g8wWVmhB2zAVXhl
	btUc2O0KbB11I++lfnwJ/FSGsWNOrtF6CsfCM5/h8Cu025rGNMWVOKZwnKXazguN
	a8qhngZBD1UHf1CILlbt5QBRruAH3xQH6+gjfCoO4/aabxxNlIrPuYGTqUBs4ajj
	vrncBP6la3MzTrOtEh6xFQfNWZGq021fKWaNafXDdJXguryJg2VOpxtCO7YNEBfs
	sIt3R9V9rynJY45Iao1sQLyCjOPfexskrnC43Rsn7M6pyjUlSOJburKQgfVaaivV
	W+SzgXee0HaLN51+T0I5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779951680; x=1780038080; bh=d
	QsLOhqmS7Al1Z8+kBXKEVDcfYyM7xjH3Gmu34qf39w=; b=Hzg2BnYQLygHrTftJ
	bKYgnF4xkJr4m1LJUQam9CxGyet7JioRX6rZwCk/2/1sPCemU418PnBgcpYdOWmb
	a+aARS4b8+K+KjZ0c3BeaXQ1DQLG6UfrR8PjN+rVGa8/7SWpkuX7P/P/Tp/C2t85
	iPFuKtH7CfEUH9zRP5uTO7gb+wsnY6ncJMXN6Tq1k8k22qQB+68yKbmlGxz/bdzT
	o3RSN//qpzqOWmoCLsq/6ySckna23LhZSE9f1q5NSJLlh6OD60ZMdKbmsKx3GGjG
	K5YokOn3Jpwh8grKyN32fLSWuomi+f8Rc5x2vPTBPBSj+FD5+11sBQBLOlmeqsaR
	Wv4oQ==
X-ME-Sender: <xms:QOgXapiZXKf0HyDSNAHnQgKOR2r-EviC7VJlztEaQ5onNW-4LrUWbMs>
    <xme:QOgXalC2uj-qrRSQZPfvcNiedd2gPapB3S7yGctzms7XL7Jd8m2LyvFdFz1NpE26E
    swDPmKjU0YtWk3bJBiSDEn63thiAUO32qGCSl3lYVwVZYBTSIF-Ag>
X-ME-Received: <xmr:QOgXauGN9cELP8AfaOskZL7goARmvgMGI7cqItmWZvJWDfYMkwX15RRvYoOA5fkWCNjo6v6RdQWewl8dgenI9TmW9K-h4Doota8QfsI>
X-ME-Proxy-Cause: dmFkZTGuaHoLwlFnskTlmPXmRuekRxXzGQY8UmG87rsCSbCkfQLCitOmNrGJs/ys8S78ml
    RUQaBu8bYIzDoA/uBcIq8XSLZ37rik/bd8pvrmIuvTxQIjF/c575mCenO8C6SDtj0+4nFA
    f7hEyH10JLqb8eN0PEwflbzHnLqnzSrcE+GsXUZduKrlxviFCYmB0Y6YzJoVrmtJjoKPko
    4aQAyAtqxkdDJqmpcSdeZfRwlPMeRNLhqGvleg1Np5fzKlplaeRKlAtEh/eLfdrJnl5Bs+
    9vSOPn2r0NU4utWTRnB/qfaoZhHAKkkpThKJO9fH4Uq2CfNrBeT9rXucsQgg2WN/UGECmg
    WWp+5/hE6MRjhCIR+8pDaALzh+l0ZYSD5O17JHujVaQGJnPi54+VVsCpSyKQstYg6kx81n
    f7bZwYQF82pokvmWylVzRP5IntZNt9Qi8s2ke96DCslcCsr0LAFIsj+WNog3aJAa5ZHNGo
    Ql2xtlUT7JCfOs79fi1Erl7Sm8Q26iyTxJpg0x9D6kCDdHy65giIVp5tGXnnvVQYjf8SBL
    xj3HzZPQXx6/afq68Sr86vXGg4ZonLZgfnmDMCaE+JB0HPzbrUR7dzTO5+KQObfXjonYHq
    iPxZaUBGBeTg+G7blPDpfKn7Mv/1rnyHC+yPnTesoNzF9zVu0zlz2lIaOGcQ
X-ME-Proxy: <xmx:QOgXatKckfWlLfKpuuAjzXStYY3UVBWYD78fuosfzRt7CbHkM3wu4Q>
    <xmx:QOgXaimnvbwpIj07TXg5pPgsMcuHtDCofgckWMjsyE58wwvMpHhaDg>
    <xmx:QOgXalRQUbczSmSUYgcb72OYd3ac4tcECzCyDznuD6YqEQVyankDCA>
    <xmx:QOgXakK_JYlAdefn6oi4G9R1VDgxFiL8VyNubnNUKA0hOWg8ySZkbg>
    <xmx:QOgXap58ZadaU_x3_Jvb-Wqvul3XuVw6k5Scii82pilLlhHQt-Uy0tev>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 03:01:18 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 2/2] commit: remove deprecated functions
Date: Thu, 28 May 2026 09:00:11 +0200
Message-ID: <V2_commit.h_remove_deprecated.734@msgid.xyz>
X-Mailer: git-send-email 2.54.0.16.g8f27b399cbe
In-Reply-To: <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz> <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These functions were deprecated in a series of commits merged in
52882024 (Merge branch 'ps/commit-list-functions-renamed', 2026-02-13).

The compatibility was for in-flight topics at the time.

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: add ack

 commit.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/commit.h b/commit.h
index 58150045afa..5352056f87a 100644
--- a/commit.h
+++ b/commit.h
@@ -203,25 +203,6 @@ struct commit_list *commit_list_reverse(struct commit_list *list);
 
 void commit_list_free(struct commit_list *list);
 
-/*
- * Deprecated compatibility functions for `struct commit_list`, to be removed
- * once Git 2.53 is released.
- */
-static inline struct commit_list *copy_commit_list(struct commit_list *l)
-{
-	return commit_list_copy(l);
-}
-
-static inline struct commit_list *reverse_commit_list(struct commit_list *l)
-{
-	return commit_list_reverse(l);
-}
-
-static inline void free_commit_list(struct commit_list *l)
-{
-	commit_list_free(l);
-}
-
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 const char *repo_logmsg_reencode(struct repository *r,
-- 
2.54.0.16.g8f27b399cbe

