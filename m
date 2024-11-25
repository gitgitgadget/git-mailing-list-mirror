Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9F156962
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520326; cv=none; b=gChDl8pxyxUkIGgiLy0e932aGYIUbUbObj4UgNPIK59zXwH8K/si/kZY7AR/g9d0lwumMzAKNd3EqVASil0743/fkJWKvmjlSHNzuPUm0wQOcBwUVcWlfG14GDRWLUzU1k9Ljl6Q4zdYHsCXXYBhnulYIUmtEgzAY9QjRIkAxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520326; c=relaxed/simple;
	bh=2Rm9xcvrSTgwGXx8aCNJwTScZvlM08EuxhXBA5XDbkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gx+9oYCXysVA/SaDdMUcYWFMXg3qNN6rGzHJP+/v9wtxGyKOPdBSQ2aRjE76HuOczHyMk198EIMEP61jES/gxbe9oEvs2WGbabcCvO+hgvBrjYnOX23f8ONEhTE16cEIQ9n3UWUqQFyPEU+EYuFnhYDmI6u/n/uk5wOnkoz5+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NRg4EXd6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4aaB+exU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NRg4EXd6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4aaB+exU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B21FE254014F;
	Mon, 25 Nov 2024 02:38:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 02:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520323;
	 x=1732606723; bh=ivSZWOWOqQv1UUtMjhF6dBS6AMIjSLXOF5mg/ipOg2k=; b=
	NRg4EXd6iv8BBEJvZM5FiOoim7OEQV0SoqRgkEV3JBnR17OHrbZNrVrCCfGDy0F+
	AbHxiyXIq2yvl9syiyyJq04pKVIFI0ML4Z3GVA5L2+0i8VyK4kN0r+6UwbvWlv8S
	wFAMdZ8yLI44MjuucdpdBuQaQst298tNZmMVgeFC7a5PUKQuu1j3C27HL7XO9lgx
	LHJO84vTzcemkEeJ7/eFdpxNHpdp4U6mUxmZHUPeg8GodUm8/qMGsUtVWPDaftsZ
	UsFJT4d++PdNwMz0N8QJ/ZFz+H7uISZA1O7xOCK71ND1/XgRQ0b1Gbg8Tdd+eCwy
	BWb3X2POYtpYBL8w8AFtZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520323; x=
	1732606723; bh=ivSZWOWOqQv1UUtMjhF6dBS6AMIjSLXOF5mg/ipOg2k=; b=4
	aaB+exU02hJC9v/xFEY5vP9E9Iiv09UHSB7WJ/jZO78VxXnJh9TbmuLIrU5Piyky
	dhpMVeZlB7e0V/MNsEfEXPObrnpFSwmUDetZP0oj6bJtmowcgi0L0YHFF/US9RFg
	U/eyEJqE3gz6UuXzy60BJ6WqD5rlNQcgD/nywFbD2dqXFpas4RAT68HfJtM2Ie36
	DVElNT0CF/aYHrKXucyEwRHJS0csK2+eswyKEEfrvQeT8YJlZ7OBF+wJkxBdTt5Z
	J81wBHNTCbGwmzE1X7/YObRZ4UN4NcgypHRpGbH8UYjQCAgywsy0uwCNcNhkkIfp
	SNhLP55BpwhExX0pn+KAA==
X-ME-Sender: <xms:gylEZzHMiFiZ32lom_tWmkb6t2oKDOhtnD5jSI7hx39sGE2sfioyVw>
    <xme:gylEZwUT1ZyDek2b5qwOL6hkXBQSa11ll87DPbBPao69bhr5-jcmYBq3QDsLIFUtr
    6uydUWtFXoN-c2h9A>
X-ME-Received: <xmr:gylEZ1LvywthYjHLhkDPIAJBR3pL92jTnOyxGrz589iaAiQ_sqmSjSfKy7GQAX07Hv-STqvQ7PIwAhJq-6_nRZE5lhLbfXaXASKQPH92yJkUoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gylEZxH-Uz-WwvGlKiUXz1_letWk-Atmn60mfLW92XCPh9nF1xDZpg>
    <xmx:gylEZ5U39p62GAOtiTm59NStva_SkX4hZXBLVsKIKlcTdD8B5W5kCA>
    <xmx:gylEZ8MkCNk5rbjsHzLIXoAW_P55bL_QSXoyjGfatd_URuOwxnJiCQ>
    <xmx:gylEZ41q4Cl-WW7uAZ_2KdR2OzliO46jCyDyusZQ28wevrQQ01jagQ>
    <xmx:gylEZ8Q_uVtR3PBQ3f2qP6bWk-uUB2u2MzWW07RJXVXuUaUd62w15Wp6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc2b93ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:25 +0100
Subject: [PATCH v3 3/9] reftable/stack: add accessor for the hash ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-3-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Add an accessor function that allows callers to access the hash ID of a
reftable stack. This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-stack.h | 3 +++
 reftable/stack.c          | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 54787f2ef530406a7970db058c3a0cf456897978..ae14270ea74108cd4c314ec38e7d5c9a4e731481 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -149,4 +149,7 @@ struct reftable_compaction_stats {
 struct reftable_compaction_stats *
 reftable_stack_compaction_stats(struct reftable_stack *st);
 
+/* Return the hash of the stack. */
+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st);
+
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index 1fffd75630266c0d3d1e4a2d037b5cf90455529d..d97b64a40d4ad05cfd9e6f33e8ba1e713281ef6d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1791,3 +1791,8 @@ int reftable_stack_clean(struct reftable_stack *st)
 	reftable_addition_destroy(add);
 	return err;
 }
+
+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st)
+{
+	return reftable_merged_table_hash_id(st->merged);
+}

-- 
2.47.0.274.g962d0b743d.dirty

