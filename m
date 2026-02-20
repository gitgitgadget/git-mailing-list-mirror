Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054C3358BE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575872; cv=none; b=EGtsMbhaGGJuvQOxTjXpA++QS3xmmuJ1xo1rSAfFQMdG75G8O4y2vBHKciXFyphcZWqAfezc2BvaOEQa5x9xuTPm1rIQic8vlkl0+geJeUKgOvnhpd32l5aqPWBfd8h5jlz/e0LKkmzsMcaGWaWas77HME+bByXn6m0bizTMwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575872; c=relaxed/simple;
	bh=fDKJriEPiD9rCwYansJS7DeWlP4srtzIvutpWK7KIFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3A4vh0euI6DpsqG7P5VuxlB/HUv8lJv2/4vgmX2ZZzLssxTqVoB7YQdSGJKazHxQeSf+JU3Y+lccHFMh6/s1lBPLlmzb7AqBzxusdxgxD1DeX+cCXV09Zyzne7ymF/yJofN78uI5ikipUX0sTf30NQloYjbAKn+67S52IQLbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rd8czHMN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9A6y7Pc; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rd8czHMN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9A6y7Pc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D3D2B7A0011;
	Fri, 20 Feb 2026 03:24:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 03:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575869;
	 x=1771662269; bh=g+zbIumlEk5WTKzU+BvczYKdZCro8V4IwQRC7j8MFJo=; b=
	Rd8czHMNBd68j4D4dEtMJiKhyQX7oTGRRB1xlkQoRGFAUnBBUcZdRxnTxe5e0PVX
	dE08QWkufRTg8h7RqyBcH6KDZerjYi2d0xD4QGi8R4oACTv4431nYYoPv5pTyrfI
	XB3GDtpr6iN9+6hkbS47OW0uPkJ9zx8M77ODFuTOJYID8p3PmVcrhxUoiZJasl8B
	MhNn0/tDIOfYyzB0umnYnoAE4tyJCnCecrcH6VjH6XLBg1ztu9qyc6qN4oCe48bN
	DATsnKwnpjrS+GPkv3TOse0H2ZPgtOoSfaBU7r8wsnFIEi8DP/dDjd8pFO1F0MzM
	cBTkOi6qSI+oy/X6jWiuEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575869; x=
	1771662269; bh=g+zbIumlEk5WTKzU+BvczYKdZCro8V4IwQRC7j8MFJo=; b=c
	9A6y7PcGxtPRwp1yz1ePLF3ah9mUxPw446hjRgITu6LRIrIgwsGFxhxL8lUFi377
	YQpYrzR7GZ19Cc7/JsuDJ3xvSxZBzYvW7KDvk7iMNNNws+GRJoh7yw9bK3ENcfgX
	qzjpJeHuUoOJvGNCGt+/8aH0a7YS/xEDmk1e+lsXZMr70LlPZFD0Cb2DF4tBO7u6
	yyhn+HaVpCajTVw0qBvQZhtZXGv8LpJQG7aVSIHvP7JASdCHq9xwbn0xxLMh6V3n
	cwqNEJg/Jljxxwh0KyQoSOrAI1pulxbo/Wkpbg8fIn2QlvjbiEkFH5Sj3TSVmPaC
	fm5SHVgqR4D2SrOT5bnaw==
X-ME-Sender: <xms:PRqYae2miVmcLud_qQgvMsBbOce0wnw2ToQtLt0jipThe5QbSVwjzA>
    <xme:PRqYaXGgpAyCZX33kB00GUY4g9pEkk62mSJU1nDHVeBxYuZLFWqBWB0XOoqU8BXyH
    bEO3BP8k4oKU_jaY0rP6McSmcWCxu2YMPiVdWmnL_m55f2xvpCXoQ>
X-ME-Received: <xmr:PRqYaUjMsmQ6MKxwR1ha0rcNl99A1uqV4Y4OW3aA5ggQIBv4SrmB1rKZm9idytmZm_wwTkkDJVjHTCZL8OmLkbGpIn3njbNq_Lfg6MQzFB2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PRqYaa_z423zeXC2s_wBcSE4hVl-0LlJTUr3RMvm6uu6mzYkw7Hdfg>
    <xmx:PRqYaTp5GOjY1JdeLba7ctjah6kWnrkqAYbCeS949wO2L-SWnUVPIQ>
    <xmx:PRqYaR-lZXoUTkmW6CSBUarkUv3utVmvuOUb-LQz7Hw8YVgtujXq0A>
    <xmx:PRqYafXayWVmWTagjvaQwmF-FkLeqN4RkhCXhK18qXl2KdDJz0b0bw>
    <xmx:PRqYabmIhLzU0SDZQ9YWJKBVQd-pJV6L7kwWTee6lxibsPXrha1ybKxP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3af7fcc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:06 +0100
Subject: [PATCH 02/17] refs: move `do_for_each_ref_flags` further up
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-2-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Move the `do_for_each_ref_flags` enum further up. This prepares for
subsequent changes, where the flags will be used by more functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 74 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/refs.h b/refs.h
index 62e8ef61e7..40974c017b 100644
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
@@ -1332,43 +1369,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
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
2.53.0.414.gf7e9f6c205.dirty

