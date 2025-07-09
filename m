Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8A273D65
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047738; cv=none; b=FJnWa7MT2Ky6Obs7hQPzL792K+qW56/d+9Hgwknb64h1DB3/0Mf4JkMdQTLc+2SKA49l8kFvYAla8wwvT17nhCWEUVQDS0qA5VSKKvQIqZ4GbcOJidOP35qRMG3Q/GLzzvlWvnYug7oN/JnRjN83Oo65TkAI2U2bVTNi8ACXIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047738; c=relaxed/simple;
	bh=gQAlDC7DFQSYaA7Ath8bNTdwdEhHI44nGDsw37BU6bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEffMQk4xrq6g3/Zun8gjJj3mZySFzCaERN73eW0ooIm6uD51OOVif4/RuJgg9268mDQPQzUli90ha3HoZC+bH/WbHy+5gVR6gQ+JP7N+ZeQDbwXyWqVZNPrQt/7IHiattJ7Ltfvla2VeqEL5rFI1ohkBxrzZF0BVGmmO49RfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BgIkqk7w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0MiCZkG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BgIkqk7w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0MiCZkG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60928140007C
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 03:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047736;
	 x=1752134136; bh=Vm+TjkLNqfFxcYARtmzoCjArcLjcp6/+2Axv7ZNYD2E=; b=
	BgIkqk7wlbAx+GUvbYtvpQBc+Z5c+XApUJkw+VrLOAzuu4baiMc3dMIebXpvaojV
	cr0lzATa6MkH8cH9eowymL4p03bilYmHP6e8rIISTWyauVWwaxCCUnN6HM5McfuS
	ClDkJK9m/BwFanlDLgdkYSKNUhFos7q8vruPHbipGl/BGx0HdWcQWW90dUXuQIhK
	rvkTLoo5h+bgc4kgA4NJXQmzMioGYPVu/VvYzkDgRjbMB3dTFUEeTHPMUTJUGHy2
	GTx2tWqiLr3mBq4zvhbhdNRqRtxZpwdOiPUkkWI4I5MLI5b/GZdsnj3p3Q8gjo4u
	oSVhF+c2UdnqFT+ujX1jpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047736; x=
	1752134136; bh=Vm+TjkLNqfFxcYARtmzoCjArcLjcp6/+2Axv7ZNYD2E=; b=C
	0MiCZkGWWINO0fDkcQOW7S5zmFNICLBh7EwM/8mwkwHCBqqjJsgDKgushGsL4WF4
	IPGfrIqU/fL4mbFm+5KlswwHn+Zs1aOYVlmWaPJxIfNrjIb9vnZamHJe7OQ1T8ab
	GezyZoAmakdEm0ivNeyTejUi1BFUZ7vZshOPKJBQR4klamir5/pDXMv//QKoqncN
	NmruPAOraQErKGDOi2TA8W/VgzOvNMMFroc0OAq6J74rAomXyNewazHqbjfxiIVB
	GcC6jXSig+0mfcpv0gd8dHgvnfkQomX9xN/VbYIokvCBOZ9pouyBFcAR2BSO9NzN
	CGEXqoKE4695mYiQUzViw==
X-ME-Sender: <xms:eCBuaGOoWBi5YZ9x00rKydDHAheCDbDhyuL8RRKB60lobaFji_hYJg>
    <xme:eCBuaG8Pb5ZsnIbP15cAVs5rJnyc6shNbYCFdCpWBr_K9xTWYHtvWV2aT-SjXi-9h
    eMKV0XeNSQ6dEcP6Q>
X-ME-Received: <xmr:eCBuaGrN8Ln3Zu0cePTv5iqqOrmdAca7rCjXssqRXlm3P_0rBNnN6Bljl_K2ItiE7NYtlNh4JiAGkpi1gGVclaBi4k0e1xc2mUiEEdWhXDntpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:eCBuaI6n8W4VCis_C1OA382W63mzxbfarICOJnekajHwcIRvTwqpfw>
    <xmx:eCBuaGPYALbzC25sx1ljgPSH5gFwr_0ZcIcVAuXVZteLWbLonBaBPA>
    <xmx:eCBuaKMdCKXd-Ysdj8_IM7jvLBjbL4lmQgp_hjd3QdWtZCD_xuWWNw>
    <xmx:eCBuaO-v7BPXsZzDmxteydzmlvtbdpbvIVeixtcmkH4R2L_F__lF7Q>
    <xmx:eCBuaP3LLQ3m71rlD3t-f4TQm_TtCKBd26D2AUqZbOOSdr7RW0y92ozq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af940f0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:54 +0200
Subject: [PATCH 6/8] packfile: stop using linked MIDX list in
 `find_pack_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-6-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Refactor `find_pack_entry()` so that we stop using the linked list of
multi-pack indices. Note that there is no need to explicitly prepare
alternates, and neither do we have to use `get_multi_pack_index()`,
because `prepare_packed_git()` already takes care of populating all data
structures for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index e1ced050451..776a72678f5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2073,16 +2073,15 @@ static int fill_pack_entry(const struct object_id *oid,
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
-	struct multi_pack_index *m;
 
 	prepare_packed_git(r);
-	if (!r->objects->packed_git && !r->objects->multi_pack_index)
-		return 0;
 
-	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (fill_midx_entry(r, oid, e, m))
+	for (struct odb_source *source = r->objects->sources; source; source = source->next)
+		if (source->multi_pack_index && fill_midx_entry(r, oid, e, source->multi_pack_index))
 			return 1;
-	}
+
+	if (!r->objects->packed_git)
+		return 0;
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);

-- 
2.50.1.327.g047016eb4a.dirty

