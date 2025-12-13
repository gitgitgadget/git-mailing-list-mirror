Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8136256D
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585098; cv=none; b=aPqNzbiDq5rC27LOLMTKpQTW/JWAbgP6lrRERnA5G4EsULS5+HVy1c04caHi7hFKMEoqzEw0wVU4SS2gMKyNmHPoKGxe0JmuiiyULzaTAnYDfalA2ys2tN+RMMTj7dwGLtNlmdS9V1WcNX++bb1H2zCT3C44E7a+FfwDTzz+Lvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585098; c=relaxed/simple;
	bh=9O9oIQHOpFaBYQi5R3sXlWqCHQVfP+30d/vBtDFjWWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QnNh4RpOxi2uBNAQCbuq2SBgWOBofvkWjTmOAwTxQLBExM6IH4rLuglFljld8HWJ4zo2t+4XvQI69SiSt4qGNnJKXOEDBZCF9LXDHnPDzUcRQ9m2w8Rgk/PxIFRGWnIBWoJHs1u9P2nU7HUQMNgvvYfjc1xxiirrPjsqSK7q/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyfnjKdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7mD9UGf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyfnjKdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7mD9UGf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F807EC001A;
	Fri, 12 Dec 2025 19:18:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 12 Dec 2025 19:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765585094; x=1765671494; bh=5F8mMwFoM6
	USXrhjZ7MJaE0yjYhJl3c6tr+ojL2CBWE=; b=UyfnjKdy6rLg2zd791nU89zDgF
	8bPChp+lwjqTf19us9Y2kiPRF2/U3J6UbJwapcR1aglUYSwQPD+9Ygv59L1NYVA3
	C4J6pUUbHo/FIo1K6c+kgt2Ycyn0aJJUsQAXWYA0Fa+k9yr2OncV2aSQfdM8+VRO
	p1EguM/4oMAmEmExiLDRTzd55eYAcqSu3IaDWFfJDhnEWntalvzRB+gXoavIxn3a
	YpkKDX/DsyTYyLOKxarcfW4j3cl7/9YSJfCpTxkxcNl0E3Lcsl3lI2BE2WtTF8Hl
	0nQMsHEF1VOEOw/hnWARSXDwEiCTsCLdt4rASINFCh46ox3CxZrf0leHR9ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765585094; x=1765671494; bh=5F8mMwFoM6USXrhjZ7MJaE0yjYhJl3c6tr+
	ojL2CBWE=; b=I7mD9UGfy5jxzo0gvrrxq5R80zsjHHxL6uGlqhigq8//eTbawiK
	jo6ZBPvQYFjiif3K5Wh5oQFDB5niEXHrFGDFVhakB9KtzxveCWlcfQ8fUlD4asiX
	cQluzQnxxq0tbIdj57S+MRgkKN+xCWkIIzd4fUaHLVQ5FlFYmPDwCquSI9S/m4wP
	dgG/he1U9kO32bNNXIUO8bMFfkuXJrgcFejJftbH8e3DSUJBTuiGqC+0P+DTmi8n
	FMY+HOp8VaUWRzoQdwPr1Py1j9yvosTqYji1vKEmJG+TbQlxQ0k1v5gAz4+G8wd4
	5ajqOiSBKP+B5KFycxwxdL8065G2Dc8Ru1A==
X-ME-Sender: <xms:xbA8aaWMT7-1ypsbqer_Ro6bejk0dG3ygE_qCONPdBBzcn33SFnm1A>
    <xme:xbA8adnghQ5PRcsw3pqHTmkufkB0Ogo2IlEcMtxE9hPc24GAJLgback4D0WKOfjLC
    tUK9TlwW6ryZUs9IOMqsqVN9j_YmOCSJgZvBCiJ_BDlQx1rMD_dbw>
X-ME-Received: <xmr:xbA8aTbA-VqInRCi5u0UULIy8ruAXWd122aRkc5_ybJhdl6P21jflnL_3U0qUjvAPJXz59dFRF2uB7c86AE1SgWRKX3mtnw7lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xbA8aQNp7_2SeM4HzDWTCFfA4oXaxpzJ-nr0MdiCSyiXH5aT4LJxtw>
    <xmx:xbA8aQaeTU33-FbYvJnYF97OjueXNBI4wOHJ_hCqTNToMAhbcANmWA>
    <xmx:xbA8aW36I9YMuKl869A0E4Uc2Eshhq1I7piPh5z83XUvLAfW_6xHQw>
    <xmx:xbA8aeehtmpYWgk2Ge78NVdG63Cx1StNry90cAIiPwFjyDBz-6cC_w>
    <xmx:xrA8ab2gQKxAcFn0uHcF_uq7JQIXnp5QVUr9Vm_KBJ2zfcuwQOj8kHYC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 19:18:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Add MEMZERO_ARRAY() macro and use it in coccinelle
In-Reply-To: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com> (Toon
	Claes's message of "Wed, 10 Dec 2025 14:13:00 +0100")
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
Date: Sat, 13 Dec 2025 09:18:11 +0900
Message-ID: <xmqq5xabb5fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> In the first patch I'm addressing the outcome of the discussion on the
> patch, and in the second patch I'm fixing an edge-case I've encountered
> while using coccinelle.


Without the attached, the failure at CI is impossible to diagnose.
A test that emits "you got some error messages", without showing
what they are, is useless.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/Makefile w/Makefile
index 0bd502dc01..52e413f59a 100644
--- i/Makefile
+++ w/Makefile
@@ -3534,7 +3534,7 @@ else
 COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = $(COCCICHECK_PATCHES_INTREE)
 endif
 coccicheck: $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES)
-	! grep -q ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
+	! grep ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test


And FYI, with this series merged in, I get the following from
'seen'.  I did not check if they contain any false positives (in
which case the new coccinelle rules for this rewrite may have to be
marked as "pending", not for real checking), or they are real
improvements we should adopt.

Thanks.


diff -u -p a/diffcore-delta.c b/diffcore-delta.c
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -56,7 +56,7 @@ static struct spanhash_top *spanhash_reh
 			     st_mult(sizeof(struct spanhash), sz)));
 	new_spanhash->alloc_log2 = orig->alloc_log2 + 1;
 	new_spanhash->free = INITIAL_FREE(new_spanhash->alloc_log2);
-	memset(new_spanhash->data, 0, sizeof(struct spanhash) * sz);
+	MEMZERO_ARRAY(new_spanhash->data, sz);
 	for (i = 0; i < osz; i++) {
 		struct spanhash *o = &(orig->data[i]);
 		int bucket;
@@ -135,7 +135,7 @@ static struct spanhash_top *hash_chars(s
 			      st_mult(sizeof(struct spanhash), (size_t)1 << i)));
 	hash->alloc_log2 = i;
 	hash->free = INITIAL_FREE(i);
-	memset(hash->data, 0, sizeof(struct spanhash) * ((size_t)1 << i));
+	MEMZERO_ARRAY(hash->data, ((size_t)1 << i));
 
 	n = 0;
 	accum1 = accum2 = 0;
diff -u -p a/linear-assignment.c b/linear-assignment.c
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -20,8 +20,8 @@ void compute_assignment(int column_count
 	int i, j, phase;
 
 	if (column_count < 2) {
-		memset(column2row, 0, sizeof(int) * column_count);
-		memset(row2column, 0, sizeof(int) * row_count);
+		MEMZERO_ARRAY(column2row, column_count);
+		MEMZERO_ARRAY(row2column, row_count);
 		return;
 	}
 
diff -u -p a/shallow.c b/shallow.c
--- a/shallow.c
+++ b/shallow.c
@@ -745,7 +745,7 @@ void assign_shallow_commits_to_refs(stru
 
 	if (used) {
 		int bitmap_size = DIV_ROUND_UP(pi.nr_bits, 32) * sizeof(uint32_t);
-		memset(used, 0, sizeof(*used) * info->shallow->nr);
+		MEMZERO_ARRAY(used, info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
 			const struct commit *c = lookup_commit(the_repository,
 							       &oid[shallow[i]]);
@@ -810,7 +810,7 @@ static void post_assign_shallow(struct s
 
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
 	if (ref_status)
-		memset(ref_status, 0, sizeof(*ref_status) * info->ref->nr);
+		MEMZERO_ARRAY(ref_status, info->ref->nr);
 
 	/* Remove unreachable shallow commits from "theirs" */
 	for (i = dst = 0; i < info->nr_theirs; i++) {
