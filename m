Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B45364A4
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530251; cv=none; b=o2rd0fRBPBqeJiJ0/Af5Mz0vYhMLaT84iT9EfGDeVbtdlIegtrarjz41GSF73N20HePOuln2YThtWhrSQAHmE3WvQHPMGYu2EoWI/t0xCxvz4Larb1o34lxdmYJoFk4HndPhHxkey91ycM+m0SFDF9tJkxrVU87npVDPnYIAoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530251; c=relaxed/simple;
	bh=UpAlBSqIAJIpMu8J2u5EahvDWzpl9hnzUvCAQFFGDKo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz71tCR4mhJ2bHzPHno9PAvTOtWRZjR+3ysfIcsm4nr0KO9SvaDeXjRb3AjpemADl0cOERFcbHNoWqagaP2406pmSiVp8AL3D9T9F4VYJ6FhAWXCS1df8kfGcwgbF0K5ORVaVL8zhKObvGTMA2u72TczEsxlzzCdL8mOEkez15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nH39ujT/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FqZSkaVW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nH39ujT/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FqZSkaVW"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id E4883138FD46
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 02:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530248; x=1723616648; bh=ISM+OyIsFj
	cXsFWN8SP+YOmX15fIP+fBmMlyP2t1JY4=; b=nH39ujT/ojxgSL5lSjiHYJ1SUk
	BMKRbbkKqmn/vquGXiJRXxzqrrETrefm7SBOvIxvS6mpbl0+jRK5Qs41OjfazRXR
	4yzXo8fAHiCg7SeviVfuhEQ4KANxS1Cf7kzHsWNfdPRWulnaoQAezlUZMwoVHx1D
	E2jOcnoaU1HXgLdhWCjRmRqC/6EP9vS24oYCXU6LI36cwczo1Rt7IskPctmg+gEi
	t5LSsjhYsZmb9DVPSTyj0AMPvsvxA6ZWmDZz7BKcyteJ+FR2IbG2cyJfUv+NQzzd
	o6pb/9j/xnv82BKqZSaol/Jgd4o8Xj2QOFM7eO24c3zQiuHMUubee78pN0Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530248; x=1723616648; bh=ISM+OyIsFjcXsFWN8SP+YOmX15fI
	P+fBmMlyP2t1JY4=; b=FqZSkaVWq3tLHX/v/g+zpF2bk5ch5naTDmTeFFX1remh
	knzqoeUGvhnR0VMgKhEOfhKCla46o15uBCtP/SSj5JyxVWIkgZLfJq4uHuWDYkKC
	wSIBXu7fLiBITWYhcPBKuo6ZDr2L227MCMXUMquITwZof2vwi+qzpY3pXHu5R/kx
	igLZIqC15pjk/72+OZtwAdcXAEXOE8KTc6Eu9CdJmQjVH/NzvIHzB+G7RyoySq8v
	UkD362/Tgqnt3ZcPXA55DPgELEf2ZUc6sGgplNFYPjBX5u9s/3pPm4pASvXB51ol
	V+OwjbjqyIFojmYOz+pp5n4D52Ir7IvKCc8ndY2qVw==
X-ME-Sender: <xms:CPy6Zlu_J6sZH5Dyps9hlqOWW1QGa68UY8n25sJLmx70Y9JAy2ewlw>
    <xme:CPy6ZudXsi_I-U9kWjE1lPV10t6TJh-IXMpGVqZHGSJddXPVic-SyFQloIcKnbuVN
    TAoHabF6G2HckFyow>
X-ME-Received: <xmr:CPy6ZoxPPdwtWYV3Djpv0H6NsD8u6Y2z1-DSSTibFKNOAX9e4jUXg9kpWxpb_UrsLdXoHkSZglAkv0rhgvRmii_4DJKeJIr7bQhBwMafWMA19g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CPy6ZsMSht1OPE9GETgMNBLcFlVzC1-dBUa9eh0EOIt8Nz315GRqRw>
    <xmx:CPy6Zl_z-Gg9rqRmM_M8kPa5844l2xE4yp2DfnuuS11PpsJCLAM6gg>
    <xmx:CPy6ZsWVIZubRvwdx0MaleQpgX0VpRvi7ctr4Hklxl25Ls9YRg9oDA>
    <xmx:CPy6ZmdUFZQ9LDkKT8cDqitbAuoyNUoEMUKmPy497tDKpMH02kJZqg>
    <xmx:CPy6ZnmTdcJBXZ56yRCdZMb2kyZtkC4JZ--hzU3vN23DhnZN-XN_a7fU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16d378b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:23:52 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/10] reftable/merged: rename `reftable_new_merged_table()`
Message-ID: <511416fb73f2ab42dac08966ca6e82ced0f91e50.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

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
index 8d78b3da71..25d414ec41 100644
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
index 4deb0ad22e..72762483b9 100644
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
index 2071e428a8..64c7fdf8c4 100644
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
index b6263ee8b5..210603e8c7 100644
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
2.46.0.46.g406f326d27.dirty

