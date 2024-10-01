Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E21A00D7
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775744; cv=none; b=lNc60jTGo3STS1RqcYIV2VW3nwZuxmfQpZcn8+niUe24cUbGN76mZELJgFK/RXGLWY4qTFjtHwFx0VKPacIyPIEJ7QTQecAi8TSWssNik3krslvxT8m3uITtGbU8ooDXf//fw8mrDDQitTwf9YdPZo0a9wRK08/Y3lo1c8TnYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775744; c=relaxed/simple;
	bh=xofDXl8q4K22VJ53veiXYSPxdRfBrc039/G542444dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffyrshcuq92+7lzLV9mX3dddfD1xAxWrJDgkfo551AvESv+jFDh/CRrwc1zqgv/Gjl5vrAK3BHbfw/6ZDd9Qr4Cyrh0P1vEc/NFFckfwPDOuMG6cxQXiA9puEzdjHhuX+OzvpnI3MUg7Zadw6Mi+Xy8HpPWHtZDa5CQ3V/OHYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DwVGV6A0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLJYIpId; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DwVGV6A0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLJYIpId"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 139F71140DE8;
	Tue,  1 Oct 2024 05:42:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 05:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775742; x=1727862142; bh=oDRrIWmC22
	bLluO2AcwVBGHLbXpBHEkqKVOnaBep/VA=; b=DwVGV6A0r9J9WuxtBT6brJXCmh
	aqm+nZQVPiY5qV6vYFxjBogUlhfPMbmyUgeNrTpcYhq5tqetSN36zcYl8xg1CZhF
	65MKJkzuE4DZbYLgsbiGhEEUwxA8fLUtDvCNTG4x1oM2uL+DKaE4rIlixzSVTWXA
	K2NRf2vx5RFNGlS4ANsVn5NGzs90r0vtDui+RIllszXq7E4gpyRIk++qTOSfuVFa
	8DMkXgA5PcxwBE2slksrTyOKf7HxS9aklFL+TLIRD0W7ALMr0z17lRSxLMA/erI7
	wgsnIb1J1hUCL22XTj19OVOtDrCW7ccCxMl9T+g2M5Z/ToCi2OrHmS7vKK0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775742; x=1727862142; bh=oDRrIWmC22bLluO2AcwVBGHLbXpB
	HEkqKVOnaBep/VA=; b=eLJYIpIdyp+vjCwd8EqjmdatsSBPe6KZ/CRiSZtcwejs
	IgfEJXCUL7WSWDyCTKbLEa8spfPNzsItCvx/FQape21kl+1hH+cIR6k8KDc2lTry
	102HbnOOb3v3n0D8GKRUuB9duXWyDnrarKmtF8N2P839frS/O36aDClYbuwbu+sM
	BoKcA7d4CGtoNhkMBLFGbx9zp9yBmfEPTT8XY/lZTr7+w+/AriAEtTJ+7m3mO5L0
	DbvDakUo+LDg0cYka0wotC1a4jGWNB+m8hPlZ2nVK8AyC/rqeuFtENORC+eX4sNT
	YrMh3Q4Eo3aTt0UGUzBfHNJGumpSCBawfI7yA9wxjA==
X-ME-Sender: <xms:_cP7ZmZrPW4HDoG8Hr2k4zjHwQpH-gEt-N0VShsMoNpsKUB8o5EXQA>
    <xme:_cP7ZpZ6otx67pCtXZK9zziHFSPJJlY3SiX9KoRwrRLszh4mZM_Mz2hN3Nk0HkX_J
    -suYyZoyQc6doGK7Q>
X-ME-Received: <xmr:_cP7Zg9O-fgNrAS-YZ-qSQ8MQ8Rd6e5p7sYWDyVzg7LqPazqm2z_fuKQ63ALQ5O8-zLs6QGp0i3K6_y_aQxjlZX-o5YuqEysHiMhVEO08yoWTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:_cP7Zooi_zoV8BdpZgRqF_GYnbfXrDuTN6fwgoKuDEintHW36j984A>
    <xmx:_cP7Zhp1JRcObMNGEIvGS3NRE2zw5nWHWfUmH8I617rVpcRx0yu7ug>
    <xmx:_cP7ZmTUBoNWpPDrzTDhubQeYEN5C3LQZrSW_nIe-aB2EXZe1Q1hew>
    <xmx:_cP7ZhrYh-NfDnMAy_rcGv4IJeursUReoBasx4fgoCnI41h19ObDJQ>
    <xmx:_sP7ZimQbmqxlqsFyAqSOOq88DHUlYvIh8cPsdXK5lyXUTAKgvOOM5Ii>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4da496b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:33 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 11/25] reftable/reader: handle allocation failures for
 unindexed reader
Message-ID: <7b592a6c6b8b08a7e8089364abfc6d2d6f6e83e4.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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
2.47.0.rc0.dirty

