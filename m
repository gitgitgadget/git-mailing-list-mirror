Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E26374E55
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196190; cv=none; b=bC60VxUGs10FG9PI0zeg4VoIPhy5BMBx/cZhD7IuQxIyhdvrE+Vf3sfU4xhS6kIBXkBWk61QdrHpyPIUHPwsd4lRfFrMWPwdmfsNufmnWehTsAd0OhjjPbqSRZN7ZH3deKfTQf33c8iXZVqgV3JAbGrrs0pSYdM6Bfzwgpo3PRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196190; c=relaxed/simple;
	bh=ZcVpcO2W0ZeSDyC1hSy/enotgQJ87NG27b1gwYrkFfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeRPxv0lvSGVVeZGaLKCEK21UfTgOlLAYYNbNFPCqpZQlnRLerMnt8zM+l1DXWJ9QE3FPUTobmS9gpQVMOtTn0k5wFZkikxOWvVO2kKgngGBry5vJv8Nvxv/QY+v1u4knDfZFMS3Ooo8G2t/6DIrOfrKnHOJ5ZPdm0jCbsd6k10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fQTRYjn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IufnisF9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fQTRYjn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IufnisF9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31C1A7A012E
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:03:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Apr 2026 02:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196181;
	 x=1775282581; bh=8SB3gxND8y18sPPJeBQZvgjjyNNRtiNrQ3tWypCvzKA=; b=
	fQTRYjn+pzdeXp9nhTFdb7tvgFNJwf/nEnnDkXv1ssiRe0UjzLmyiw+9/AT+puGo
	iLh0+yE+isTcYQ2YfkpSkvMr2KS1eql3HaDMGeip8iN4Ha1tcbDe1nn9U2PI8cZC
	QkKyCqgXEpXYNa0vp+GBt+4ABgcxpaeo7EgIgRAzb28keRbsv1g5RyOv08KSSycm
	dxQf4luuz2GA2vCcWnevP8jx/0N0LlywrdzvUhIQ4B8daVdapU0Tk9dkd8as88U8
	V3UwD5nsy6f3Tmuoyug3tW5H+lud2tHM2+1POphKz0aUuqvnebiSGPGKt3c2GQKM
	nDU8LA8MzhxsWwkRaS2Ypw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196181; x=
	1775282581; bh=8SB3gxND8y18sPPJeBQZvgjjyNNRtiNrQ3tWypCvzKA=; b=I
	ufnisF9+e4h41SugwxNWjcH15SZhQGsx51G3ed8Nyg3jmGi/drOpSutxr3I80eIX
	UwzoT6nZ7gJZx/PC8ojAaW9SkJjqBgvl+FTTTzV5kuy3WCPwU+31TlbuMRifjft6
	TZtaTDp8ZSgYOAuSWH6HJR9KXridzQKzJIrTwoP+WmMGQ4rEkb6Ikdvd0UeboIQe
	lNhPl8yZfNKpqjJgfUKZmyjzc5tBf13Ihpf7T8UoYeWvGB1hL0iidbzTIgNbBWbC
	0duYP2xAExn9hioEtcWgnn9VtHspmrN7zO2vdZXlF3yr8HU+MKXdtGX4IBC1LOYo
	w3kVObcsx5qoaaEiOwgjg==
X-ME-Sender: <xms:FFjPafWlupjS2lpcSITVXOpCK07oipbnZwEI9gYqOtK-sCpOD9Aigg>
    <xme:FFjPaejbDtNcg4LCPdVSIsdrvOrKDiglRxQIzmRPmsP1nm64Lwicg8Oo1ZEIEpjuo
    pI7UeuzAoqtekcvA4llAmZJAVDXmD9THCDCBOL99tCb3Dw_JK7w9Q>
X-ME-Received: <xmr:FFjPaRB96Jwpj_Ek8qHiJnvW7jIlHmCc-22hb5hcQDVBIF5z2BkI_mx2T_ukhE1Jzao82iVzAH59WT1Z_uGCjVX9o6zBvjRRVi9UTgh9roA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:FFjPafcgj0LP7yGJggscKDRNNluHeilIx7A3LdUaZqJN6TJWk8omww>
    <xmx:FFjPaZfoZyUkpX_Rv1jpJxDONvcCwm8cmYUdVVv7nc69u1NIPAhTIg>
    <xmx:FFjPaTifFGfpI6hVscChfxsVFR_Yj0B1dnHitEwCcfCR6i3v2t-5vg>
    <xmx:FFjPaVQkc9EkuLjSBui-q9CRT56lsOY9Qlydc9nseGxvAY_VRGw2ww>
    <xmx:FVjPaSmcefZqbbdXNfLRac5IzUoV-GsVafLTu1mfwepaBVlBc4FNQqMc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:03:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e22604d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:03:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:02:03 +0200
Subject: [PATCH 16/16] odb: generic inmemory source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-16-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Make the in-memory source generic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 8 ++++----
 odb.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index 34228c0cd5..70c59fef91 100644
--- a/odb.c
+++ b/odb.c
@@ -560,7 +560,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	if (is_null_oid(real))
 		return -1;
 
-	if (!odb_source_read_object_info(&odb->inmemory_objects->base, oid, oi, flags))
+	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags))
 		return 0;
 
 	odb_prepare_alternates(odb);
@@ -737,7 +737,7 @@ int odb_pretend_object(struct object_database *odb,
 	if (odb_has_object(odb, oid, 0))
 		return 0;
 
-	return odb_source_write_object(&odb->inmemory_objects->base,
+	return odb_source_write_object(odb->inmemory_objects,
 				       buf, len, type, oid, NULL, 0);
 }
 
@@ -1020,7 +1020,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
 	o->alternate_db = xstrdup_or_null(secondary_sources);
-	o->inmemory_objects = odb_source_inmemory_new(o);
+	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
 	free(to_free);
 
@@ -1045,7 +1045,7 @@ static void odb_free_sources(struct object_database *o)
 		o->sources = next;
 	}
 
-	odb_source_free(&o->inmemory_objects->base);
+	odb_source_free(o->inmemory_objects);
 	o->inmemory_objects = NULL;
 
 	kh_destroy_odb_path_map(o->source_by_path);
diff --git a/odb.h b/odb.h
index 3d20270a05..e3211ad8d4 100644
--- a/odb.h
+++ b/odb.h
@@ -99,7 +99,7 @@ struct object_database {
 	 * to write them into the object store (e.g. a browse-only
 	 * application).
 	 */
-	struct odb_source_inmemory *inmemory_objects;
+	struct odb_source *inmemory_objects;
 
 	/*
 	 * A fast, rough count of the number of objects in the repository.

-- 
2.53.0.1323.g189a785ab5.dirty

