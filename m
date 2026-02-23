Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460A364E9E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847992; cv=none; b=OtgHn+cww9UzwDGZaFMcoCEuSd8m/J4+eUCBCFJHZr6rsFRAgWoTx/76CqzCZ8CiGDoQkwDX9QktjF3A74mo11h0QYRRCcWv6rCdM90lB3zwIJQes/PkmRm/xs31sEQdjcVkQi2WPk92b9LfNDW19UZLx6fm6LCToDIp8OVrQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847992; c=relaxed/simple;
	bh=QdukPmxQoUJOXvd6fNmxZZt1whFgAWBrKBNCdJjccFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfEcbYMaABC7x/TbGCDocAyRQoGa7JntN7igIoFLAsKl+DLS9ijUJOZwBcnJ1fOm1YVgW9eVxkPZwQNI9y1AgnK0pt0Z441IglTuqL+ZDpUqabGqID8UpSznqD7/E+SFjMEy5snTNpWweflMpU//h28xtXLcsW79/2dZWrBQnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FiD6L3Wa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ag2zd7DD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FiD6L3Wa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ag2zd7DD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D4C4EC05B7;
	Mon, 23 Feb 2026 06:59:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 06:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771847990;
	 x=1771934390; bh=yp+AMX6I8vTU0+yIk9ttF0OkYcVFo95UhBnZXEoRaBw=; b=
	FiD6L3WajIMdtmaQVogPbqwuoXwa6bzEHn58tUqVHHBx6yxLX//jQdjAfuYPBI4c
	LzKFXbQAnPdtuPBIzV78dadTgylM1l8YPsYwb4ZVxQsryXDjgS2L9xt8/azfyZRi
	45YeKQEH4g7hlyTjPk/NYQDLr1i1FQdcrTr3mFuGBkjzebzqQnUSxabXQN4+4WXQ
	W15xiUsS7w3tc8aMMie6vo6yXAVvUR2RwbZ2C+bzD5NLNSLc8TeabqUZMmN2OF3v
	no8rY428rfBPWMFschAMrgM8MaG1bAcvzSWSRW0BJlK3IaHyKzCXb/3IdPYwByb+
	j9+smSkk1yIkQRkBqd7KsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771847990; x=
	1771934390; bh=yp+AMX6I8vTU0+yIk9ttF0OkYcVFo95UhBnZXEoRaBw=; b=A
	g2zd7DDNUjr1uk2ZUXph2FTWfx/V7UfDqWL7me8rWu7kJzivfEvkSLbVRczvkWWH
	19I6T7qJfOMCCsMDvdaAafX5Nuq1wD+9iBuRDXVkJh2Dn3Vpy0zktIsXHIxsqGzB
	wba+N7P8w4+WYfTW7Og4eMaXDOhJLe2Gg+I7mYOEVj0vhjxHmuodV4G+ZolEJPzF
	d5EZ/REsrJpxHWrmF8N4dKGyMVqxAAXJ+9KE+cYXO2YS6RfVQVCkEeQ7rk0vSD6B
	HHGChZfgAosqkXdkC2/6rjlRB2pdtsQqEf8zLp2Ypt5DYWiIyJA4Qg11RpxJQUl0
	8PE4uGlazFVtl25aPPPzA==
X-ME-Sender: <xms:NkGcaV9eMOFS7SNDiXTXzPwbudWPx6wowfQj1hIYmZGik-BnyfDU3A>
    <xme:NkGcaRKAx2kOGAUSpRy5LR8fwqlqfzzAnQe0C_ZT5Yq1QW53BRZOIb2arj9ljMBGN
    gODSbxz1bXW49NIGroxrykcs8gNakr9Ympg4JkV4XYg2q2fMy7v>
X-ME-Received: <xmr:NkGcaQa8Fyj_6HDymqSvHG_UeqtJm35wEmJFaLTb7UbRriZRFM2rFNfGtFsAXXaECSJfY5Sg0qY58UHWD9MIauZv4cU0jjrYP3DX-0iM0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:NkGcaTL2WtdZyjTKpL7yHvt439jKAlXzMuk9YyBQDIeqlvKP4CROhA>
    <xmx:NkGcaeA6ZSdVs__Z2LoTTYWzBaE91ftaVLt7HMAuS7Zyc9PUorFoFg>
    <xmx:NkGcaYrSEEpwDhJwBXh4NUHIsJGxAUAd7RXOaE1HJZpYm49GPdh4WQ>
    <xmx:NkGcaZiqXNdbegAhq0sx_EZr2yovO251JU6YU9IKY1goSLRBGkcOqw>
    <xmx:NkGcadhGTqdBhzdiq7F_uE2qN_ROQh8CC_XfIJs9-dFTkHcg50NBrIA8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:59:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e772679a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:37 +0100
Subject: [PATCH v2 03/17] refs: move `do_for_each_ref_flags` further up
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-3-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Move the `do_for_each_ref_flags` enum further up. This prepares for
subsequent changes, where the flags will be used by more functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 74 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/refs.h b/refs.h
index 718212a5d7..6fd7a706b5 100644
--- a/refs.h
+++ b/refs.h
@@ -402,6 +402,43 @@ int reference_get_peeled_oid(struct repository *repo,
  */
 typedef int each_ref_fn(const struct reference *ref, void *cb_data);
 
+/*
+ * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
+ * which feeds it).
+ */
+enum do_for_each_ref_flags {
+	/*
+	 * Include broken references in a do_for_each_ref*() iteration, which
+	 * would normally be omitted. This includes both refs that point to
+	 * missing objects (a true repository corruption), ones with illegal
+	 * names (which we prefer not to expose to callers), as well as
+	 * dangling symbolic refs (i.e., those that point to a non-existent
+	 * ref; this is not a corruption, but as they have no valid oid, we
+	 * omit them from normal iteration results).
+	 */
+	DO_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
+
+	/*
+	 * Only include per-worktree refs in a do_for_each_ref*() iteration.
+	 * Normally this will be used with a files ref_store, since that's
+	 * where all reference backends will presumably store their
+	 * per-worktree refs.
+	 */
+	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
+
+	/*
+	 * Omit dangling symrefs from output; this only has an effect with
+	 * INCLUDE_BROKEN, since they are otherwise not included at all.
+	 */
+	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+
+	/*
+	 * Include root refs i.e. HEAD and pseudorefs along with the regular
+	 * refs.
+	 */
+	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
+};
+
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
@@ -1326,43 +1363,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
  */
 struct ref_iterator;
 
-/*
- * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
- * which feeds it).
- */
-enum do_for_each_ref_flags {
-	/*
-	 * Include broken references in a do_for_each_ref*() iteration, which
-	 * would normally be omitted. This includes both refs that point to
-	 * missing objects (a true repository corruption), ones with illegal
-	 * names (which we prefer not to expose to callers), as well as
-	 * dangling symbolic refs (i.e., those that point to a non-existent
-	 * ref; this is not a corruption, but as they have no valid oid, we
-	 * omit them from normal iteration results).
-	 */
-	DO_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
-
-	/*
-	 * Only include per-worktree refs in a do_for_each_ref*() iteration.
-	 * Normally this will be used with a files ref_store, since that's
-	 * where all reference backends will presumably store their
-	 * per-worktree refs.
-	 */
-	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
-
-	/*
-	 * Omit dangling symrefs from output; this only has an effect with
-	 * INCLUDE_BROKEN, since they are otherwise not included at all.
-	 */
-	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
-
-	/*
-	 * Include root refs i.e. HEAD and pseudorefs along with the regular
-	 * refs.
-	 */
-	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
-};
-
 /*
  * Return an iterator that goes over each reference in `refs` for
  * which the refname begins with prefix. If trim is non-zero, then

-- 
2.53.0.536.g309c995771.dirty

