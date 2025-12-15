Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E930C344
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784208; cv=none; b=BmyNMS80efG82oHGSwmnmxcwT69lFmYDo5ohCPby5klFcL0IvtBtLgF6nPrGC5d8dauK3G6fCvkn0+SX5ChigohwUJ80FhAfvNMIZFo5bnbW0224QdLsDa+PNvVDJpcRkNg9ieQtJawp9jR5WLULnvTjqv7eyGBEKj091AiZCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784208; c=relaxed/simple;
	bh=qugFFhp4y5HNn2p4SzUks31+GfPnH8Jl9s+Lp2/PRdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yd+OHm7VGkWFrJ0uAkb7+kb+u+vDzPrcDz8LILxmNKNBnmisREg7Vihk9k1P/AZYIipEY433CK5FNsHNGSpU1yfpKN57ISadtp5a9SH6bLho5JI3yOKKTINrcG4OJ/hT+ueS4PZXn9WgXPNU3C6Im6Kzs3CafKWadIhi/Gn1PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pv5R3Qss; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APodK2rI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pv5R3Qss";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APodK2rI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9A5114000B1
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 02:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784203;
	 x=1765870603; bh=Xlv7ldXcAJDsE1i5HFgsVfI5hbrAg/yp66udq1zvHsE=; b=
	Pv5R3Qssbk68bsJ63I/eyw27k9SJFpAETS+auPA6DMA25LdDG/1gLMtodRsNlGlg
	epJQrfVh1wMtErgCNbxaLoQX3F3Ma8+NxEvCUdne6cYYCNuwrGEdXvWAvBkOPEmw
	mPAFBcQnKYPEE+/yULE8WHKm/baHoLKY3afjKiBUh/pQJAUf6LE5UIDx79ZgihZj
	4pa1YNydexao6QS57L8OKkx1pWKjwOME2WoSeDj5ZS//QezG2acVZAmfpRmzU32R
	EzYWY8+DUcNd7Xa7nTag3hDLyDF5JWbHpyj8ytICxU1XDikmUBweLD2OtwK3gB0T
	3n37b3M7iALFz/9OaFpXDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784203; x=
	1765870603; bh=Xlv7ldXcAJDsE1i5HFgsVfI5hbrAg/yp66udq1zvHsE=; b=A
	PodK2rIgmv3rqz8rpHtkHfgi1bRCwEIz38pIXoQxrvpmk4W9eoAMr9NZ00xgoklK
	bnd5rHUAsM/kWEdMGcE9XZu+AJKLPjtq66QGgbLYLxdW65tHTVmIdHNrhl1xzyIH
	I0Z7dT+wLBoe5AdZa+3YwhmnDU2L6arZpLTyujy1/Sy0KyHgefeq11ezkH5SRTqj
	+v376qzq82PjaLk05KcDPnRgrVB2/gjgtfbCm9cWQBmLJ53+boP4f+Xd+3eHl1I5
	8938/ltPBP6cjq0fgLz8ET8TqozfM66KtgTYND/QtAx1ptcryewSdKigiQ/ybGLf
	4YcKEfDdZ3iB1jW8dJcJw==
X-ME-Sender: <xms:i7o_aWGumYefm9tWM57iqobGxLJLLnuotpf5X6DzxZ4czVhtk557nw>
    <xme:i7o_aeR5JlUT9tsO-d_5HXdqL2rJb4No8kIuntvX8z5-KMo_x1LvPM9GMiY_6RbQy
    NjUnLyQnIKBpOl8BL_zVthUKNvnfWXFC3DaJHxvV_asGSbFDQs>
X-ME-Received: <xmr:i7o_aVwpN2X8YboGVdVT5oYE6wN0olnfHYCWuaWPP850yOGNNf5heVZf67OrkAp-UnNdi8K_j0ahz2ibEG_9G_lqzKJBc_qEY7k8SdXF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:i7o_aVPF6vgve5KTGfKmcE4bEtND9TzuFGxtrTxN23D8nnCzOrkYag>
    <xmx:i7o_acOL52zo1vOMZAw2t51m2eUxB7mgwxmUiVwrXZIDoNB1QHGOSw>
    <xmx:i7o_afSglhkR-7s07jNBcWDOYK_OjaOiaIu7K5SuuGW7shabOyYtgg>
    <xmx:i7o_aWDJrEGzXSU-SU92C1IPRBIDgnPos9ya8wt4siXvb0syhzRnRQ>
    <xmx:i7o_aYUPt_TmcDc0iNPjKGlI6qhG_WfNzGbVsjbPIDCVbD5IJY6HkcvN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1001e2ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:25 +0100
Subject: [PATCH 06/10] packfile: only prepare owning store in
 `packfile_store_get_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-6-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When calling `packfile_store_get_packs()` we prepare not only the
provided packfile store, but also all those of all other sources part of
teh same object database. This was required when the store was still
sitting on the object database level. But now that it sits on the source
level it's not anymore.

Adapt the code so that we only prepare the MIDX of the provided store.
All callers only work in the context of a single store or call the
function in a loop over all sources, so this change shouldn't have any
practical effects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index a0225cb2cb..c46d53b75d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1092,10 +1092,8 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 {
 	packfile_store_prepare(store);
 
-	for (struct odb_source *source = store->source->odb->sources; source; source = source->next) {
-		struct multi_pack_index *m = source->midx;
-		if (!m)
-			continue;
+	if (store->source->midx) {
+		struct multi_pack_index *m = store->source->midx;
 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(m, i);
 	}

-- 
2.52.0.351.gbe84eed79e.dirty

