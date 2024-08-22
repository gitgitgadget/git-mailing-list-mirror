Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183DE13AD09
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308486; cv=none; b=B+09UN8k+1WLyn6UkRoqKi5GDprJmu0BRXuond27eOXaLj5NfzpZkb59OV21RH/aO9J4yUA+v8YI7aTr/FJsNJJLQMDPdP6kSym34chlYf+qt5QE740fJ4YSgdyZ2uDJ8urRi+nSA8GbL3h70IfYadD7xxataXMSApaCU5cGBH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308486; c=relaxed/simple;
	bh=k8K5egnsrHCHtiTVqRX2DyBDZZDvrdp66KZWFbxUzxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH0LxlnD2Jmw4ZlB0M/+KD2MBPkfe6ICyfQ8eiOs3NInviPMf8MmzzJEiLHCwsnw5OgXmur3xQQ0ke8AijpwvbDKw0qKAG+Xa302m4JdVMCM7MgkE5FrBa0fu4cxWFpucZrkqn/Gsbx4tesAZmDAVuh3Gvfg5JAnfbJ+lIHD9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f76wijhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwrvwK79; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f76wijhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwrvwK79"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 246321151AF6;
	Thu, 22 Aug 2024 02:34:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 02:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308484; x=1724394884; bh=La6XQSuAU7
	J2ndW6r0VbWV/h8+/xIZa76tPG36Md55I=; b=f76wijhx/lwSsumZJnKgojEz7T
	fJAR4M32Tc/jA4MjasdOvIAEfqgWo8WlY5SZJTg/CieT/tK64h/gQR6UxREXTzLn
	b9JKkWf+86HBSKuqFmmyScfNDnUnoFaDaZYhcrXH2u6zzXd9Yn/jFfQ/SnWGi7L8
	c1/XfvdGiV4hn1f1Os0E+eaVOdp/VJqk9tBbs9G+8A+sVk9USe/6lCXaUv3pdBk4
	/TJWs1+cwp3w+iGUihO6di7ifx2U5FjLq2TuK8y7X8wgqoq+Kwe/TbvS81OcBD67
	2LEWg3HM7Bdk8NJEJ2T0VSIUXGSiImVVq1PrLdStjma+d2COQjtFPdbnM/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308484; x=1724394884; bh=La6XQSuAU7J2ndW6r0VbWV/h8+/x
	IZa76tPG36Md55I=; b=nwrvwK79xM8ThFEBB5X2IVqwgOUCHk490gflfbHcDgSq
	Id0IcnScn5rtn2148nIEWsa515+t3ECD2eStOtSumVGZGSa/jZCsoKkr39UWuCKt
	RKCGvJPY+UUPRLbUujX3q1XLxgcFPxXjBakeYVFY1D1B/73aDIxMaLrIhfa1YZS7
	+PFlGvpo9t28C7ebP0PFtqzw0bQe241swbkdnWpH0igeQL9ZgcZkm78qlvNw2F08
	6Nuc2/MtuMWkrJ0sGHRJ103v0XgI7AOgpF0rDxxAFIIPd99Ig9aT/aTGQ5CjnmyY
	wSls+LIKEYpLEnbHJuv7UJljcc/C0f5p/lxK+lWpuw==
X-ME-Sender: <xms:BNzGZhpc0ERDAEe2FezcZnTMD7RfHxYxP5T1h1C06cHIk23tqJBLWg>
    <xme:BNzGZjqvZDvHt-wDs8A7seW7VLIZZ0XgU6_Zm8-OBi1-YrdBLSR_ap5QlyIpiyldj
    p1T7nSgYjcpWuQnmw>
X-ME-Received: <xmr:BNzGZuMPJYztv9OgOra5ROuSihcGWsxvy2TIPmeAAQ41rv2_sSHjRSjRw6OSWMoz4immVgrpUBmY1VxO_5wNaopUYecDCo0lfjnefDINDwp3rSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BNzGZs4hNbz5ZmTOUtOcOyehwxgyZTuTu5IPD4EdDWIphGTOR3j-Ng>
    <xmx:BNzGZg49KukM9TIwlq8mxU4ruHwTe6dJSPJx3-nFQFicpQau6PKHZQ>
    <xmx:BNzGZkgvpScq_Qs7yj55cFH3A1k5jif7TFnPSoMydbISNDwfXplG-g>
    <xmx:BNzGZi5jzcLsp5-ZHE-lqPityJGWU_By7QkNnTJuWe4FfeHVwCW7FA>
    <xmx:BNzGZuk1uSeM2nkPE-NikpH0hFG4-zFEk1Uws9UIjo5VSn5b2XbYBhvz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:34:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acbff932 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:09 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:34:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 02/15] reftable/merged: rename
 `reftable_new_merged_table()`
Message-ID: <bc6f1cd8c1b3b6f0e6f2c60eed15c6626fa8ff0f.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

Rename `reftable_new_merged_table()` to `reftable_merged_table_new()`
such that the name matches our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                | 2 +-
 reftable/reftable-merged.h       | 9 +++++----
 reftable/stack.c                 | 4 ++--
 t/unit-tests/t-reftable-merged.c | 8 ++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 8d78b3da719..25d414ec415 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -192,7 +192,7 @@ static void iterator_from_merged_iter(struct reftable_iterator *it,
 	it->ops = &merged_iter_vtable;
 }
 
-int reftable_new_merged_table(struct reftable_merged_table **dest,
+int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id)
 {
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 4deb0ad22e1..72762483b9e 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -29,10 +29,11 @@ struct reftable_merged_table;
 /* A generic reftable; see below. */
 struct reftable_table;
 
-/* reftable_new_merged_table creates a new merged table. It takes ownership of
-   the stack array.
-*/
-int reftable_new_merged_table(struct reftable_merged_table **dest,
+/*
+ * reftable_merged_table_new creates a new merged table. It takes ownership of
+ * the stack array.
+ */
+int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 2071e428a80..64c7fdf8c49 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -272,7 +272,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	}
 
 	/* success! */
-	err = reftable_new_merged_table(&new_merged, new_tables,
+	err = reftable_merged_table_new(&new_merged, new_tables,
 					new_readers_len, st->opts.hash_id);
 	if (err < 0)
 		goto done;
@@ -924,7 +924,7 @@ static int stack_write_compact(struct reftable_stack *st,
 	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
 				   st->readers[last]->max_update_index);
 
-	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
+	err = reftable_merged_table_new(&mt, subtabs, subtabs_len,
 					st->opts.hash_id);
 	if (err < 0) {
 		reftable_free(subtabs);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index b6263ee8b5a..210603e8c78 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -111,7 +111,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
-	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
 	check(!err);
 	return mt;
 }
@@ -289,7 +289,7 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
-	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
 	check(!err);
 	return mt;
 }
@@ -441,9 +441,9 @@ static void t_default_write_opts(void)
 	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
 	reftable_table_from_reader(&tab[0], rd);
-	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
 	reftable_reader_free(rd);
-- 
2.46.0.164.g477ce5ccd6.dirty

