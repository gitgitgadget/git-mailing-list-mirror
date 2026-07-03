Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669A3D45C1
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083544; cv=none; b=bVVjALVRp/RkFLLXHTzMVZ8+QnL/EtbR0t6BgjccRvdFUKCwMLCrQeR3WzfxVvGRfZseQdFaM0ZM5eh6dtpC9ai5wEgR6OUznRmMYEc9JG/BQN0L9tpR1D7vIn3hBZ8bPZy6L7oueohRaoh5iVd3rCLeuBQlh3j/CAp0grr9hHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083544; c=relaxed/simple;
	bh=zxbJAPk782A8FUnexh7aEHAX2oI46Heewi7Jil4pVPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBs2krQB9BAZ3dW8QY7j/EdaUp1eLz4AkPJoIIM+YuSa93uAUHpW2x/8kpO4nOge8AL1XasB1uZU8IhxDJFGSMc7OT3HiQLLIQ6rojktvp76qTIEvJP82GjM5fHS0S1HSmYtzYGsEknPai5WW6RRPS/cJqTZ4a5PaVUtZmbs3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JlZOv20m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ct224zBv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JlZOv20m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ct224zBv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E5E67A0109;
	Fri,  3 Jul 2026 08:59:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 03 Jul 2026 08:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083542;
	 x=1783169942; bh=9WWwree8b9Edj75KtA9684zw5/39EBAZP6EXUC7RKAU=; b=
	JlZOv20mz+rcCeZ03N2hlFX+mWJIW2x6VNUr4vXpliFgcVHEPEhCVRDdNPUFJRRk
	mEF78+tzKMU2Ukry7F0rSeDqmiQp7gjKurLdl/Qm/1AGOv7Ey1qv5mDZTQHi1Wex
	lpAHpcyMR9maLnXnceVMNc/XVVdzzlT34QYZFwsFkuDtwzk+kujmKIuQHr7yJHd1
	1jB7r67OlEmMVzm+KVa8X+1wmCscauSJPGiGkCSlfERi0a+ZlGNBTS2knsNEy/2N
	gjAzFMmL1uY/htC9f1lV5VPVahY/41uBPj8zzn3exs69tEGw7qErcbGKHW1Y2lUp
	7zpbKKN4cRzJXmbqHPMPzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083542; x=
	1783169942; bh=9WWwree8b9Edj75KtA9684zw5/39EBAZP6EXUC7RKAU=; b=c
	t224zBvEIofW8vPQMci3SrVbjMg+C5Lp5GMUNxhuMNkw8n3Sh3XzPbJwLzarU1SP
	uiCUTGnlvt5zHQyTAL/lAJFSGmkg0dvRXHgavBqw76Y0qL7ONXzVll8Z/8jG8tJ8
	aKArCkSduSXB+85Lpx/lwV2jIUnQ51rEDgkggPeRJyNezI62EiQ0YvdSSVT9qXB/
	6MfUFb+fMEvIlSPIateYcHgODKC69n4LmnrZ2hfvFk9aH2jSobnWMfgWL+/Zp3nn
	H7RbsJExEQOc5+yQHpYc8LmO9h8nYDWkk7QXWZUvMwCkJc01UvATDopHZTPCb/Bl
	rodNWrubcOX8NF+ejtD+A==
X-ME-Sender: <xms:FbJHajCwtGT4AyKJwDezgaj2UiEdg1HmhEiowDku7yzm-sLpOJftWA>
    <xme:FbJHagjlqKYtJQDJa4IG2CFIfiKQH8AJLHazLkUAMsMPJ-RS8Vvp4FZk5a70efYfr
    DZGL2Rabqz6uHqvpRSbaNjrYEYCp2zE8jXPPmZAbkpTzYL6vCvi>
X-ME-Received: <xmr:FbJHajnC-DTgSYnOTiUEC9L4lTCelJjsQZleK7NjsYPV3NJd2AHxyBT-bUDGfPOf5I0CKz6YTrewO5_5oArWFhgbb-yzLyhDBA0HFOAojQ>
X-ME-Proxy-Cause: dmFkZTEnwvHVL/02oA1h2uWNRZvjgjI9BD+dkxtOdLwJ8hgL6Y0qLSdb2NnWfTr6UNt0dl
    rwcoArYQ53f/0Y1FZHpBSRkzqgsnWJdFO56zP44BeEklSg+tOlFA8QUvWfYVi08L7JDXBX
    C0xy2B23fAAi9AWPhME0flDA5F0trsEpHLxNt21heC4fvk20kF/9jy081ZaZO/gfwY3ch9
    2xOOalj33Pq3zJIZLRyMR9G4D6StkfivX9t6bDBrNuxuuWSBUGXjxloUjOXAUCWNsmPY7p
    s+5SDmDTgvFsrgvtN+2U/UQp4QGAIPVCHjlaeXB5lhP/4PP+T0wy8yw7e67gBqEG1EgqTb
    WilBHTiKoAbWyt9OGovpc8IdAVH7/nBKxizEDyQvUmAL9/A8oxP1lQpf7Uz/g3+MMMdJnb
    lxCdKfMAXKe1r0HjIx6/42UuqRDUNS2MkkcuQs0ZPaJ5Bwh8F+3+x3PxwfHyYSt1IebXuV
    CM4ux+klIGP4CK3MP/dBZmRN13wEGh3Wx03tgEyXHL3bIBr+rzlt5HlTf6LPOH2r+szWO6
    XjTEv0nMhuke0t7n5LWN5BVW4oOOXpbscTLYglsUNEk9RYP+CMG+qk1UpIAb3Bg98n5r8Q
    6C3Z0Rhw9wUqwZphVVn/N5DjMKfsS7nWzdgo5PcuuEGDsF257HA76bFG1H1A
X-ME-Proxy: <xmx:FbJHakr2FWBVZkr0EZo6c3JMZaJbrhvNAtMOkQZ4aynW5reBq6FjEQ>
    <xmx:FbJHakGPGYowYCexRQuFcmt-_8X00Z85N_XmguUTlNeW7dw9T9c5vQ>
    <xmx:FbJHaoyyGIB99eQEIR7ofMdk5gITYUbLnwYK0Hc46FJ29ZeBZJnsgQ>
    <xmx:FbJHahrh6EPH_qD7ozdTZ8tJ63CVdGqREfwj3krP_3jNGLDn-zM7pA>
    <xmx:FrJHaj54RHLm9vKtTAbig_2vTQOazGn96ataKKVaFear5H5lrA0SxPmB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93eb446f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:46 +0200
Subject: [PATCH v3 03/12] reftable/basics: fix OOB read on binary search of
 empty range
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-3-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

`binsearch()` performs a binary search over a range of `sz` elements by
repeatedly calling the comparison function with indices into that range.
When the range is empty though, there is no valid index to call the
comparison function with. We still end up executing the comparison
function though with an index of 0, which of course will cause an
out-of-bounds read.

Return early when the range is empty.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                |  3 +++
 t/unit-tests/u-reftable-basics.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index e969927b61..f0442a46cf 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -152,6 +152,9 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
 	size_t lo = 0;
 	size_t hi = sz;
 
+	if (!sz)
+		return 0;
+
 	/* Invariants:
 	 *
 	 *  (hi == sz) || f(hi) == true
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index 73566ed0eb..c5d83b6714 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -60,6 +60,17 @@ void test_reftable_basics__binsearch(void)
 	}
 }
 
+static int unreachable_lesseq(size_t i UNUSED, void *args UNUSED)
+{
+	cl_fail("comparison function called for empty range");
+	return 0;
+}
+
+void test_reftable_basics__binsearch_empty(void)
+{
+	cl_assert_equal_i(binsearch(0, &unreachable_lesseq, NULL), 0);
+}
+
 void test_reftable_basics__names_length(void)
 {
 	const char *a[] = { "a", "b", NULL };

-- 
2.55.0.795.g602f6c329a.dirty

