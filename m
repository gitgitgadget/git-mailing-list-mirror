Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174613CFBC
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308499; cv=none; b=mShDsZwxC2R7uWT5TKJSs9ar6hcGIFx/wztZiPABAd9CE5MJO39qwskfYq8b63/yAzF/fuUsT5Lelokn3kzvXrhuxWf6BmKEJt6hD2hZqPdhDsUESAUYFaxbGg/2DfyjDUBuO0MWakkeshw79rJyS2YPO8yzNp+GDNjWjZZ+bOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308499; c=relaxed/simple;
	bh=2lJM8vuWbhHQKA72BI+rCmnPTU/nKSQGL406KbOeul8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMa/9M2Y+3wVPvgmHnF9i6Vw5EQVyrtzD7iRbisrWWp8rJ5LjZaN4Hy3iIGnSn+bXIQuRvZ8gjc5R1wY6+vWPoCQgYvm0wivk9NFUYUXBjFVX6P2A3nM9sx/w2yxToo+xtqv+iueVEqQWz3b5e4Q57AnWNvVl+YE+OaBDQ4nAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YtUyUBXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5TKdYo1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YtUyUBXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5TKdYo1"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id CAD59138EFB6;
	Thu, 22 Aug 2024 02:34:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308496; x=1724394896; bh=tC4C+l13sw
	Ggk+vR8ccpCoHTmJphLgzXXq5+iMfABr8=; b=YtUyUBXdwMsTSvgCjoisZE/T8w
	2hq3W9/P2YF/z9nHkhUNSNQiZ/an0nAMoULSZDMpaSpFsEMDY/YnC8EXshUFfBHQ
	n1K9FbojfG5+m0px3LTrYrK0JUNjtZUKcwEiTqXmdcVQT9fx+fSehWYJ1z5O6478
	wOi8VX7Hlm+WgbSHv1JZlRuj56Pmoao2FXyIRyNqG6r3UPmn2rNaPNem4314DtfU
	ojy9Cr3nzuhCoqBmM8Qf3jY088tswy1EKfYg4FqGhQYVh7tA4OIilhClpfI19qZQ
	W7ZcWQ4KQlcpCt00/Boziq0kl9W6JTIYsSoRK3YOw7LwKI9XLwVOe74v0eig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308496; x=1724394896; bh=tC4C+l13swGgk+vR8ccpCoHTmJph
	LgzXXq5+iMfABr8=; b=Z5TKdYo1YFatjpgr9gqyCugqo34bhzDBh1cjUrTx74+q
	+7rD9mIoctIHQxXLGraEsMcZyqeabt/ylBBkna8SAeLHKY6o3sMukzHlcvwF8xW1
	yXMTDHMZoT0T6Vs6rNLMDTUobecnOq43jtX5QL2buVKUgLfEuu+gNW76LIGT9Q/c
	6cqJitriaoMPfMTDagGwX2cKU2/i2fyZ76rBOriiC70acXFpxJuHd4x/N0eu8Cqz
	uEXe7zclZEvZ3N9aYLwJlrs+mhrVAY6vjnePB8twtYUB+zg/0IqdqEczqph1p58+
	a7uUED6HJ03GWXFB/f4BI6o7ga7cxZSIEFhvZmp4kA==
X-ME-Sender: <xms:ENzGZv44G_vNjDICLNZs_oO_cTVYydpqhUvDUGs9vMgN12AQ45QMeQ>
    <xme:ENzGZk6U6XWJgFRnypUxc_MhHVriPb6jXp0mDHoGBND1KuCKd8cqcfyE9EUysdwEI
    Ta9BwuO_82HrubkFg>
X-ME-Received: <xmr:ENzGZmeR-mLu1Kk0_3e1e08FK7CoqTMfs1MkesbUxMHSgL_NSBYUE7kvTu2Twz9L-Ayz3F4HdLEQKi9bdIsRxZWO0EIFtUOFneuNb_fHoXoUdpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffleeghfeufeetueetvdffkeeggffgteevjedvvdek
    iefgvdeiueduvdekveekteenucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:ENzGZgLfKeUj9uQbotrOTIGpsULbLaHAISTCDjU3XgSXy2fwZdoiPQ>
    <xmx:ENzGZjKES78eK2iF5HeRs3d3hcMCC3dOpIg3-DGqJLBm5L98TytExg>
    <xmx:ENzGZpzR6gYBFQFiLaHzKK7lXV0O_HYH1qVTS17KgGmIykIYqFujJQ>
    <xmx:ENzGZvL4uuC-DoGk1-E4W990Q8y780p564YE0ltBDpOOPLawBxnnqg>
    <xmx:ENzGZr1OqdHR1w9sR2l8e09E9EWAY8X7D31c9YqqJX-Nqbo40qKoNlCl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:34:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd1a8bb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:21 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:34:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 05/15] reftable/iter: drop double-checking logic
Message-ID: <cac08a934c58f9e31c2139251722fbff8fb84e1d.1724308389.git.ps@pks.im>
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

The filtering ref iterator can be used to only yield refs which are not
in a specific skip list. This iterator has an option to double-check the
results it returns, which causes us to seek the reference we are about
to yield via a separate table such that we detect whether the reference
that the first iterator has yielded actually exists.

The value of this is somewhat dubious, and I cannot think of any usecase
where this functionality should be required. Furthermore, this option is
never set in our codebase, which means that it is essentially untested.
And last but not least, the `struct reftable_table` that is used to
implement it is about to go away.

So while we could refactor the code to not use a `reftable_table`, it
very much feels like a wasted effort. Let's just drop this code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 20 --------------------
 reftable/iter.h   |  2 --
 reftable/reader.c |  2 --
 3 files changed, 24 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index fddea31e517..a7484aba60d 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -42,26 +42,6 @@ static int filtering_ref_iterator_next(void *iter_arg,
 			break;
 		}
 
-		if (fri->double_check) {
-			struct reftable_iterator it = { NULL };
-
-			reftable_table_init_ref_iter(&fri->tab, &it);
-
-			err = reftable_iterator_seek_ref(&it, ref->refname);
-			if (err == 0)
-				err = reftable_iterator_next_ref(&it, ref);
-
-			reftable_iterator_destroy(&it);
-
-			if (err < 0) {
-				break;
-			}
-
-			if (err > 0) {
-				continue;
-			}
-		}
-
 		if (ref->value_type == REFTABLE_REF_VAL2 &&
 		    (!memcmp(fri->oid.buf, ref->value.val2.target_value,
 			     fri->oid.len) ||
diff --git a/reftable/iter.h b/reftable/iter.h
index 537431baba0..b75d7ac2ac0 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -18,8 +18,6 @@ license that can be found in the LICENSE file or at
 
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
-	int double_check;
-	struct reftable_table tab;
 	struct strbuf oid;
 	struct reftable_iterator it;
 };
diff --git a/reftable/reader.c b/reftable/reader.c
index f7ae35da728..e3f58542297 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -735,8 +735,6 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	*filter = empty;
 
 	strbuf_add(&filter->oid, oid, oid_len);
-	reftable_table_from_reader(&filter->tab, r);
-	filter->double_check = 0;
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
-- 
2.46.0.164.g477ce5ccd6.dirty

