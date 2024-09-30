Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886617C9B9
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683728; cv=none; b=pxUWaCPVEJf9MCIhVqtrRatzioxkIoRs5sAM9EOfX5iiVkeBc7tBSuLkf1vNRxbSmeV5UKmSDUInwCfqvBmUsjou6qZWlcVmyDt7AM484P0lChLS6tVtrPZWUgwnzbBocPzSCyLJsegk9O8r0tVnQ4Ax/0o/v0scUZh4phg3sdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683728; c=relaxed/simple;
	bh=mkCECsnu3K/tPW4TR9tcuYY207jZvtvsijZnyd8kTXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAdgf/eQHOk/kFAh58DcqwusIiwuQjnj3Pqsv5Ye5TGy4WAShOK5b8jzvT7KljkfW9Qz2fGrUAfuJix9oWzY/t7v+7wey05uMNDlghHLPkSzHFVgfskD2NRpcArUCiNBhGDSp95bjjeL8/E8+bs4LmYBaT/vauJC9vPHs0NghI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BplJJJ5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nl5x1kOT; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BplJJJ5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nl5x1kOT"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87094114020B;
	Mon, 30 Sep 2024 04:08:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Sep 2024 04:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683725; x=1727770125; bh=/ujXvHlr/k
	6b/aTUS9mRkTfdwEG7twDey2ExOfonoTg=; b=BplJJJ5Wd5lynwc6gjIjUDH0RW
	VajM0QVKg6sPJGGJvhq3e76Jj3JATIEvOWJmrIxhxCmwou1YIEgGaYVrtLiV01AP
	H8xXLzhlazSeWzwKsLp5acnQHDELVbNYljcqmE9ikdq4JFL+YAUPLGkIROqdE9V0
	AjpofhIiDUEAR7oDTHaFDEl187YO/R8hX3IjWceOVTVDTZpWiZFh3Rc00rqamI67
	6SCg7yl8VXn938veJijJ7HOdkHFiHBlsi6WaWCvNNOlEq44ZaSYhlaRVaRg130v5
	sN9hB0hFILfhtSEkyCa1E1uMAONgMia6Jd6sZsoR/Ub3Ch0valz/SgWyljiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683725; x=1727770125; bh=/ujXvHlr/k6b/aTUS9mRkTfdwEG7
	twDey2ExOfonoTg=; b=nl5x1kOToyqd3OTBHIG8R7QyDp8dDj6Xe+/mM6MFZsJb
	ooQB+sD0GtilEMlJeFClUzcPyUezqwFUTnVvdF6fbnXLOcVtMJbZE6IL9Avgcu2S
	bwWb6SwOQIsUqxQGbSGIUiqbBWpwXGfLkpCo5/Id30QER1UXJUVTtfYC+UmDJFr2
	gzrbnqdvJ5jAWdd8pEcnyoMeNvL3ydLgmOqjQv3ruRIBF+7EtlrShl63pAMZeuCx
	5uZTJ0RTxZqYkjL6idBLGUgbuVsiKSKmx+Fw9hGtQS7PJrp5Fy8RXrwEPzXCvZsD
	A9wOiGBf2WHz/S7ahRkzeT0REBd7tFgbQNAQS9zHig==
X-ME-Sender: <xms:jVz6ZmIg2VDeyc6UG6upEz4CaFSzHQMbRPKip2O4ul6w_0X6b2DvzQ>
    <xme:jVz6ZuLx2J1xQM3f__bYlNYUZSc5lPy6ZrCWbfm388Fq6if5YTJE_Tm5pspyso6r9
    WFhMu-N2DzKRMaHMg>
X-ME-Received: <xmr:jVz6ZmthaA6YAuhjjxkt7RsZT5JpELhDvY-jb7wNp0UIhPA_RRv-UJgUSgf-TFuN91cOvmSEBzAGmFIEong3XCNdy-bEd3_3eE97YmH_IawBt4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    lhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:jVz6ZrYIf8fR3IRoQ-Qys43YMW6BeEygEO-ntaOmyAMwvzwUCa9OYQ>
    <xmx:jVz6Ztb99SplvUYnyzcmMNj6U8sg2-nsq7O-supo1VNzNBkAe8e5Kw>
    <xmx:jVz6ZnD0-WLs9EGle50N4c_nOK4mwLJGVQU7XbRkpxv9ukTcc0NDXA>
    <xmx:jVz6ZjZF55_rGy5SOqfBh_rgEs8enyFjsn-KqX5GA8NGxa40D1kP2A>
    <xmx:jVz6ZsUEjCCpHmL_AWv3HnhogIIXHUQsYb4MbelA-T2q1kr2Eg1e7hA->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bde29dbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:59 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 11/22] reftable/reader: handle allocation failures for
 unindexed reader
Message-ID: <b2bd142021a7c390250811d5dd980b8b1757a96b.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures when creating unindexed readers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 6494ce2e32..485ee085da 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -734,19 +734,30 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	REFTABLE_ALLOC_ARRAY(ti, 1);
 	table_iter_init(ti, r);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
-	if (err < 0) {
-		reftable_free(ti);
-		return err;
-	}
+	if (err < 0)
+		goto out;
 
-	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
+	filter = reftable_malloc(sizeof(*filter));
+	if (!filter) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 	*filter = empty;
 
 	strbuf_add(&filter->oid, oid, oid_len);
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
-	return 0;
+
+	err = 0;
+
+out:
+	if (err < 0) {
+		if (ti)
+			table_iter_close(ti);
+		reftable_free(ti);
+	}
+	return err;
 }
 
 int reftable_reader_refs_for(struct reftable_reader *r,
-- 
2.46.2.852.g229c0bf0e5.dirty

