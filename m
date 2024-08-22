Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826441D12EA
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308496; cv=none; b=TNsSBzdP8JpZbQtLIqMaM9CElIaC2x4ayENez6TJ9BA9e826GuwlWLMUcHGajVMn7Hu2B07szFfXWpUEoiJV+3cHEC1txbWFbvssHAHdaueJ0XtipcYCr/xAnz9dCXzGhkzfW0eGCwKe0Kwv1mch2ISHgafeiRVTon3fQidEfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308496; c=relaxed/simple;
	bh=UxRpOy6Mq6ysAvZR8f2w2uh+lQi7AnOO7nOuCfzK+y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTv63zZsD/q3jv8Yp7VHLI2PXre7kBZH0UnB9aKB81KbNlWzeWzVt9y7J4cQTXLWIU7+6NBczu22u+PM8Ysb9yeo78GupgmZrEOtS/ZLKXW1CgO+ag0Z6+BOA7o4hG20XNdx7iTlnO6gPzCynzARHevRPseSp4i8kc5UCUWn720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NXLhcICA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tMswq3Tm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NXLhcICA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tMswq3Tm"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8BA19138EFB6;
	Thu, 22 Aug 2024 02:34:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308493; x=1724394893; bh=ur3hq+hIxF
	NYpjL2vYA9Vxe4vvq7J2BF6v13qi6lO/E=; b=NXLhcICANmGH59V8E1MuvdVtRK
	uezjCRYDLf7iaTKCR+NFJKUKIXFpcS7nV22SMl9ocP6uV1JXr8uxLrz9Hvm99IgD
	KxNm3BJfb4jDMOKWCvwkRT23lrcaAjDoWqpuBaAwznHQSaa+/EE6PNZk9lH6e8qK
	utABeDHUrCwA2TdZj7/Kv+hTbr0rY4aJy+CIeFTPPKlq7ZSTe2ThQY6MVX8mgmvj
	0QaQX/kSZR5Q8x2apKHO4gjSCztvSVFFSCdvSK+d83zyJ6oyc2mIYajbc9HQcSbS
	Tk5IzYsTR8Ke2bZsXNcIgegJ170juF8pAgieWR19t116hAJjoYJ/pg/rbG0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308493; x=1724394893; bh=ur3hq+hIxFNYpjL2vYA9Vxe4vvq7
	J2BF6v13qi6lO/E=; b=tMswq3TmeNdYVEyUx0jDVqel3YUCD5kExAFhLBFj+PxY
	T6S9LeYS5Wd6Wqmmfrry78a8Dss1G4JMnfOW66cby7/A3TLGCjPds36usztJjnY8
	F7hqKe5sbmfWLASvTvWf4DVLkU1ff9aCuBbY8HB+Tv1TXlNIGAdReWyjVCffll5V
	ZTZwAlgyLOcxOxOwfQiHYmD/jPo6PHMqDjJM0BgP0Wc9WlFTKgOd2BqnbD7q0mma
	yKIWID8mYOe1IVDnw8n3wgJsKQeLge5QN2zFSnEWexTHAtmy2Wt/YA97L/oeXF1a
	m5+Vk/zubYv3UkHQgzW0F7SgulQuHdiOXEdxtZYkfw==
X-ME-Sender: <xms:DdzGZk7TmqwoZ1HDCL8X2soRtz_YFHCPj2Or2EfF9G2b7xhAla2MUg>
    <xme:DdzGZl4ook9smyaMbcYUA-dS_yfngSCPaKgrTVmE7DXePAk1POU2gsoC82u5FVUWP
    XGLJ9FbQRKF86ki4A>
X-ME-Received: <xmr:DdzGZjf8V0pvL_89aC3lGSkaYz8i9q6mTWGmaybY0F_U2oHm38TcSbZoALeB8jZTPdtCU2SS3qWmoIDPCH6QL8Q0ho8xWPyxXk4FtKBLR1qIOeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DdzGZpI5py2ISQf-r1rTbUd2Qll7gSkvNvkjDpYrdU-RsuS3K1wh7w>
    <xmx:DdzGZoJzyJi5Zs1szN0FJCOI_eVnPvhZxZVg4TSoVRoKMj6KJRxQEg>
    <xmx:DdzGZqyW3t1IpO3K9CSMmNpF5hOO6xcFbDuaoyS_PuzC9o3xuEmSFQ>
    <xmx:DdzGZsJAUvTL1Vi_2I--1ssZG0rf8tdalY9nkvE9TeWf6rKhH_PWAQ>
    <xmx:DdzGZs2lylmI960cir-VH4NrJx4AGUF4042RJa6UGSag7viAmdiHCdHs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:34:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54ac6c20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:18 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:34:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 04/15] reftable/stack: open-code reading refs
Message-ID: <6ba3fcee4115fbf4e46a6a2a31f0b3c01b0903dd.1724308389.git.ps@pks.im>
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

To read a reference for the reftable stack, we first create a generic
`reftable_table` from the merged table and then read the reference via a
convenience function. We are about to remove these generic interfaces,
so let's instead open-code the logic to prepare for this removal.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7f4e267ea98..d08ec009590 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1468,9 +1468,28 @@ reftable_stack_compaction_stats(struct reftable_stack *st)
 int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
 			    struct reftable_ref_record *ref)
 {
-	struct reftable_table tab = { NULL };
-	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
-	return reftable_table_read_ref(&tab, refname, ref);
+	struct reftable_iterator it = { 0 };
+	int ret;
+
+	reftable_merged_table_init_ref_iterator(st->merged, &it);
+	ret = reftable_iterator_seek_ref(&it, refname);
+	if (ret)
+		goto out;
+
+	ret = reftable_iterator_next_ref(&it, ref);
+	if (ret)
+		goto out;
+
+	if (strcmp(ref->refname, refname) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		reftable_ref_record_release(ref);
+		ret = 1;
+		goto out;
+	}
+
+out:
+	reftable_iterator_destroy(&it);
+	return ret;
 }
 
 int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
-- 
2.46.0.164.g477ce5ccd6.dirty

