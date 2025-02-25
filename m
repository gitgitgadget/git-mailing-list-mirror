Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6231264A85
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473773; cv=none; b=m//V28/ecxvRTEWWMDd5EA3ezS+kqPKX4bZIPtz9ubw8wjUKTTn1u6D1QDXUKe5JyCjsow5LfetE3EogC3xjkLSrfG8TWB+9i6Ogt35tBjfkcEugkNTwuL3/DlYoNABVlgmor1+aKN0tNXp0cWWvAonLF8ZWk9mUH9wR7G/wK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473773; c=relaxed/simple;
	bh=txu1IjfbZPni2Fra5Gc3NMvE3WmrtIj8rxYQzMXzP8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiaRTcDf/SrbxOZbt2QjLBwbnER17/D8b99B0lQc/r2dY/jOJ4K7+hPVYNp+BNzp0jE8kJx00rLkQh+rVV0E+6XI71xLHiZVJRmD6+UJeOh3nayckS93ggeykZ7s2WTtEpcVBRip//MB40YQB5o8KMutUc+TXA9AS/yS5Sxv76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWTnXAnV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zxOiWcy9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWTnXAnV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zxOiWcy9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 93DF42540172;
	Tue, 25 Feb 2025 03:56:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Feb 2025 03:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473770;
	 x=1740560170; bh=i3iYXsudXN18OtJXYMxjz0oLv0rXxHPKTgBwEaDgrUs=; b=
	dWTnXAnVQHV/cmQEBaKPRlWvg1MUWnQ83lEX2BktgtphRKaAFHqO5/utV4yNPQjc
	RxX4cHcFCflEBpEQe5x7898RlR2AAJ9JUZw3OGDZa0ZE+bglfIQYNlZUDGuVyltC
	3WutZ+1NWbJTQrByviMownLGsFYBmS8XRbnObZNlGOcM7DtYJX2HhPtkor+0wbnA
	AaDum0nEWQpnm94w/x5i05RhdvNqEz1HHcD4Ud9/8a5EaSTwN1VCFj9DvSBDu9xP
	/1o29BbiL4yAmw4GhjvOXyNlvfGlV6mh+mgT73Sf/bIwsUuWO07k21ZNRmJzbuhU
	lHHwdwTZbL8Qw5k4VZXUZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473770; x=
	1740560170; bh=i3iYXsudXN18OtJXYMxjz0oLv0rXxHPKTgBwEaDgrUs=; b=z
	xOiWcy9bwMsPCU3OqjiKhmxYRk59oiflA1HIgqiS1r3QQJpu5dGcUgNVrZpTJeM6
	YRr3PTYG3t6WyTipMYq2kbxAFZBK679z7v9rQQgA44VKSp1hmucc9irx7a1cI4zi
	UEg0ycPz2nKgWhBzFQY93wqJUfakgbRrMPamGBgWXEP37WIa0j7Vd1DVAGNED9Ls
	DOP/PWHWNr3V+V/Cpqh8mmeOUDrzD3Cj01eoZ4vm7LYffqv8uJx+w+R06SfM56Yz
	ccTY86luK5YfoYTRn14eQ2ZssyPClc6UEsUxqrzrLCnpb6Pxo89ZbhSM50h7RXq7
	XWt+w7puqY2LFSt5ovGLQ==
X-ME-Sender: <xms:qoW9Z3bE8AsV9v8NmdnHWUq0MAi8EUWQnCZnaghWGLvhHwHOGGGt9A>
    <xme:qoW9Z2bGwx6K4cmiyunTsK3LQ3Tby6j6Sd84SVRWXJmNO9Pu-OyY5kFyYIqDf2MEZ
    ffrzbNIZNu2CnC0eA>
X-ME-Received: <xmr:qoW9Z591A08tWVYqzBhTrklf73cMpfYpzIzAVq5nF-UTgqvpinXdzn14FO0lmr5qB8kO5WVzBAJ9Yj2qtm03ik1Cg71N_mpMhO1p_IG1omT9bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qoW9Z9panVXrrkkVsOeo1IANgTwFmDOwS6VV26Ap2yzCPX-xezw-9g>
    <xmx:qoW9ZypP29xG1dSHAfCi91-OkVXS1Oqyr8TRpauTLrMZ1Zcr048xsA>
    <xmx:qoW9ZzQNH_qyKSDmEQta0ZPsz306MOWAciTAxism8z_EVe1REv_e2g>
    <xmx:qoW9Z6roohsTdEBwlCgAyorXkkEF25QSZ67-4XTQXmoT3_78bQ3lLw>
    <xmx:qoW9ZyK242-DJYU0mZEV-EXqGJBrNiwdPX4a2b9sKOSs2csSYTDXobmb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a2e0304 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:58 +0100
Subject: [PATCH v3 12/16] refs/iterator: implement seeking for reftable
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-12-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of reftable iterators. As the low-level reftable
iterators already support seeking this change is straight-forward. Two
notes though:

  - We do not support seeking on reflog iterators. It is unclear what
    seeking would even look like in this context, as you typically would
    want to seek to a specific entry in the reflog for a specific ref.
    There is not currently a usecase for this, but if there ever is we
    can implement seeking in the future.

  - We start to check whether `reftable_stack_init_ref_iterator()` is
    successful.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 06543f79c64..b0c09f34433 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -547,7 +547,7 @@ struct reftable_ref_iterator {
 	struct reftable_ref_record ref;
 	struct object_id oid;
 
-	const char *prefix;
+	char *prefix;
 	size_t prefix_len;
 	char **exclude_patterns;
 	size_t exclude_patterns_index;
@@ -718,6 +718,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				      const char *prefix)
+{
+	struct reftable_ref_iterator *iter =
+		(struct reftable_ref_iterator *)ref_iterator;
+
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	iter->prefix_len = prefix ? strlen(prefix) : 0;
+	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
+
+	return iter->err;
+}
+
 static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				      struct object_id *peeled)
 {
@@ -744,10 +758,12 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 			free(iter->exclude_patterns[i]);
 		free(iter->exclude_patterns);
 	}
+	free(iter->prefix);
 }
 
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
+	.seek = reftable_ref_iterator_seek,
 	.peel = reftable_ref_iterator_peel,
 	.release = reftable_ref_iterator_release,
 };
@@ -806,8 +822,6 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 	iter = xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
-	iter->prefix = prefix;
-	iter->prefix_len = prefix ? strlen(prefix) : 0;
 	iter->base.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
@@ -821,8 +835,11 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	if (ret)
 		goto done;
 
-	reftable_stack_init_ref_iterator(stack, &iter->iter);
-	ret = reftable_iterator_seek_ref(&iter->iter, prefix);
+	ret = reftable_stack_init_ref_iterator(stack, &iter->iter);
+	if (ret)
+		goto done;
+
+	ret = reftable_ref_iterator_seek(&iter->base, prefix);
 	if (ret)
 		goto done;
 
@@ -2015,6 +2032,13 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+					 const char *prefix UNUSED)
+{
+	BUG("reftable reflog iterator cannot be seeked");
+	return -1;
+}
+
 static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 					 struct object_id *peeled UNUSED)
 {
@@ -2033,6 +2057,7 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
+	.seek = reftable_reflog_iterator_seek,
 	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };

-- 
2.48.1.683.gf705b3209c.dirty

