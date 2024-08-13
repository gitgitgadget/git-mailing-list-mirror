Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB01C68C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530249; cv=none; b=h19+VFqx9QD1z2LzkByGi46f1sElZtnKXUH7txwV07ppIDFBTT34PfZpd99vLeUMgA2kBxpgsSfrur10NVirjX2oCFMpy6Ge2fzKgFE/iTklgWVXU+/rN7aZr0/d0UEmUVLwNnfFtsVzGL5lKPtlO+6EfXomaQFuuUOfgcZASxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530249; c=relaxed/simple;
	bh=ZiCLUi/BUqvxOdjN//zYawYCHFEi7nYpsw6HleDgafs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQLOcpM59VbIwHazPnpfKnaw4+PHZrpDMsQubtqes3wD487sMyldfDDCc9zQrB/59erVrK9o5qSYuj9v1W5Eq0ED4UWFDy50dzcgG7hOTQbetNEf+pFEi5cvA0T68pLKh4hOSHih626noFFijr3PATyLPslHOLzVWp9WEdnJV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=laFpgeCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvQsoGv3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="laFpgeCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvQsoGv3"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 15FEC138FD41
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 02:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530246; x=1723616646; bh=M5mbTth+1a
	44lg4toqj2ICmCYVSy1NhOJWo3fQUJ4NU=; b=laFpgeCikOuhXayGO6r6h2RbLA
	IT9tzmKFx8xj015PjYvdpdR0dGJzV5P5271JZ95qRuWh7kzO9a11bHaQtIs93jaI
	GIfy6dPXQJYn3x/er9ijJbjMPYrUCOErfWOq+KDDckSGMrPBl9tj1ANcoX7kuCAM
	BGSE32Ys4EdssCGvkc7Ad0UcWig3HamDYoM7S9/1h3IC9O7JDapj1jCMCw/JinXe
	/G+/ao27GrwRTWwXhF+3Jj+Xe2RKPOV0bPOvpNVNlrTtWKOjwtubaDNcygGaMS2w
	DATPDFWYd6ApZ3haW0q9aLEzW9jwqO1w0fQoaoF7b0lqQrusfPFwrrfaXpIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530246; x=1723616646; bh=M5mbTth+1a44lg4toqj2ICmCYVSy
	1NhOJWo3fQUJ4NU=; b=PvQsoGv3BZ8jiPu6+qVKyvfYfD0RJeNdUeYmYa13U2P5
	sOtAfRRnW4Cy+Oj2TuhJD4ZsI6aQWwz0FOYQRzmWPLKUYz9VWhnTc3QNaDv0TZVq
	+0uPJGWbGppltNtqCtZgfHZDehw2FdUW9rvPtvF/52PWHpyIp0owcT6hdZ/mQUH4
	d11XOc5gzezXlAkVrk1k2D/OYdhIQ/r6STjSSnTiUPG5LjHAZuUdRPGjgtjn2RIa
	TE8UCUwFoALwM0gPYOl0ObrkGbmrEY7AndHE2y0lk37ZAa948P2Z/JOKuVLq2VWv
	V7B4x44ICBaz22No2TGoSv6Cuhb/FwW4dmvvsFyfvA==
X-ME-Sender: <xms:Bfy6Zlf9XP1GmkUi0iAZtmaxzhKvnr3oqpFB3OuhoKH3cXAcYLOdWg>
    <xme:Bfy6ZjMkXrIFHne5ftbeEP8veD3vz9ECcdqB3KRrKlKTBnk-Kjlf1ZKAy9h_FvOMD
    UVDunALLNWVR8JkUg>
X-ME-Received: <xmr:Bfy6ZuiT_xbGGp2QLJsK2gLlCbFOuYyLg5cbMZwKyX1ELRCt0V-louX_AxWNzk3HDaudZf9wIGgvR4um9DzYIPAGJdT4DKbQ5-3Mq8kUVEMcxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Bfy6Zu_VdziT1so2R98CM8KjXiPkJ4ksUSSKQMGEm6I42OYo4kAAfQ>
    <xmx:Bfy6ZhuV0mu3FbyZSLhJUhPXYUj7Phwiv_S1ulUpONL8pqdgUNJRbg>
    <xmx:Bfy6ZtFaanodI1-fF2nSFDbM_D_ti4gkOElk21YR_kYGnc4TDxzFFg>
    <xmx:Bfy6ZoMCKhYpKGQfbLzpHhe_qkYOgxv7S5mdqgvdyj7n4aUnlR5lsw>
    <xmx:Bvy6ZiUQNC3mqRYJLIDDxyTQxbRUiO_Lc7S5j4f0THaxr5NDB2kXVSwf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ac530c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:23:49 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/10] reftable/merged: expose functions to initialize
 iterators
Message-ID: <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>
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

We do not expose any functions via our public headers that would allow a
caller to initialize a reftable iterator from a merged table. Instead,
they are expected to go via the generic `reftable_table` interface,
which is somewhat roundabout.

Implement two new functions to initialize iterators for ref and log
records to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c          | 12 ++++++++++++
 reftable/reftable-merged.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index 6adce44f4b..8d78b3da71 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -254,6 +254,18 @@ void merged_table_init_iter(struct reftable_merged_table *mt,
 	iterator_from_merged_iter(it, mi);
 }
 
+void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it)
+{
+	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
+}
+
+void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it)
+{
+	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
+}
+
 uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
 {
 	return mt->hash_id;
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 14d5fc9f05..4deb0ad22e 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -36,6 +36,14 @@ int reftable_new_merged_table(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
 
+/* Initialize a merged table iterator for reading refs. */
+void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it);
+
+/* Initialize a merged table iterator for reading logs. */
+void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it);
+
 /* returns the max update_index covered by this merged table. */
 uint64_t
 reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
-- 
2.46.0.46.g406f326d27.dirty

