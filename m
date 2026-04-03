Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F126371893
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196184; cv=none; b=dCzTtn2mDx7RdQMPwPJtO7fl2d801Erjx9apGsSHskm5GSmpGQgNCHn2zsohNHma2C/5bAnYMnJOkasnT0YZctGlkCm4svczfidDkg4/ekdm6Z4+UO2ullTrsQ2SpSV3KPzwaG5Fv3ffiX4JryaLvIIV5CS8FK8iPD9YlCm826M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196184; c=relaxed/simple;
	bh=kakLtQjJqSYe9Xwemz3+cNz2zjHPLSdyHnG/UB+/ERQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAzC4wGFkT1n0/+U/7idoRSRHo0YXSuqSfPUjkqxAveuJMrH3aiLRYzpHx5HXDhgZ14ri87fNclCwLYQgiaLSh50peOa6L/p2Fc4v8quNinN3z39LK7+RFJ2z7iQsmIMTj3pjmZjjesczQGx6+spst6KdlxxppHDgHVjYnvSYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gfeAOmoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGz1jFGX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gfeAOmoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGz1jFGX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 468667A0105
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 02:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196175;
	 x=1775282575; bh=PFI+uSii3gyZS5HCAAbkaFdFoplI32e3nuQbmVgMaHk=; b=
	gfeAOmoGrHjY+TNVw6Q27J1LZVLivADTG7GAP1oBxwnyyecKxxecjr6oG/6uVzRn
	nh7Gz6h8/Spd02awuuZxM3Lx3Oqd73ckAyDrchjYKTj5GXujRPq5UjN7ChJ/AFh3
	pdlUhpW/QAr1KDDxpdCa+phfziSloadfVNl07jHwMw5+kHR20AAYw2PdCeZWFpRj
	+OrbHDOejHwanQfYEi+KHdzizh/wxBDBnT2mdE3lzrbue7/sZ2yR3fjjsbV42e5W
	ANKQrzmVQYGPOaIJtr08R+XSbcKm3I0ktYOwLDTGRDHjeFnAtlvP4D3x/scjtjN3
	hDUHMCKkZ0FJuteRR++7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196175; x=
	1775282575; bh=PFI+uSii3gyZS5HCAAbkaFdFoplI32e3nuQbmVgMaHk=; b=c
	Gz1jFGXp7Ps9P/7oRQY1zmpUqQMbQhzzCUCvpo28PDHLcAFpyobtzHs4zBQ2I06G
	Y1fDQCprOR/6QIpix9sLotnrVJq4QAImiL9VdiKGbWMhOwZzp8Od7rgQ7IJl4vuL
	iR9h9/A30twEHAnG9mHqdZSc1bZuXX3q9mTJ4AmNyGUxahkPwuA4GWlLKFy5Foaa
	mXMQFVkexxWpw/VtXISRDv++mZPK+Y45MY7+23+lEkx8g2m30svbQc9d55/VyUCQ
	ONoGMQbmMeq6oJ8K36X+8xnQuhKOS3pv2fFaSAKt+dLrviAOAeB9RRi1dzoUDhgn
	qxj5ioT+Ed2cBa9d9knYg==
X-ME-Sender: <xms:D1jPaVFO_jar-msDgyLi5EWyCxtvRFZ0e6smu7-SGO7UzOuA6FzJ9A>
    <xme:D1jPaRQz8PtNRW9SZp2Oy9RZRwgJueDJnifY9Y2FWGbgrhp5lD1lwxOoggqR_1XD6
    qHpIalCgTqywu9WrbWuG-KXhJCAfZMP7aZY7o81etegZYt7QoaV6w>
X-ME-Received: <xmr:D1jPacwivP3XCSQJNg8KIhzhcSfaeV4sDudcKmFVlmMipl7AVCsPawZLevlBRYd7TYewqmZMdHLdcbbgcFiIwzzfYQk7B_kXkVsC7lnVefI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:D1jPaQOa43T2c7MLtfyX0Ka55wcXXEHxmWMQwrtNSnHj9omtoQ7iHA>
    <xmx:D1jPabM6MHe17-4fwoasgIS4_k2NPbygC6UbPICMk2IRLp467Cuk4g>
    <xmx:D1jPaSS99CwHntZxTUkBKp-q6ZRXV2tvgT6CANl1gDnMR_q0LKjE8w>
    <xmx:D1jPadDpUaqiKHgH3VAZHDdboD6XLJnJF4069pgG0wqzyitXuXjIFQ>
    <xmx:D1jPaTVwTsBkUeOrPtckquHN7XzEOYYc0j8qQ_m3jsbg15zkNbVMVW2T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c33b2ff9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:02:01 +0200
Subject: [PATCH 14/16] odb/source-inmemory: implement `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-14-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `freshen_object()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index bd89a7ef14..c5249d04bc 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -287,6 +287,15 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_inmemory_freshen_object(struct odb_source *source,
+					      const struct object_id *oid)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	if (find_cached_object(inmemory, oid))
+		return 1;
+	return 0;
+}
+
 static int inmemory_object_free(const struct object_id *oid UNUSED,
 				void *node_data,
 				void *cb_data UNUSED)
@@ -329,6 +338,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.count_objects = odb_source_inmemory_count_objects;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
+	source->base.freshen_object = odb_source_inmemory_freshen_object;
 
 	return source;
 }

-- 
2.53.0.1323.g189a785ab5.dirty

