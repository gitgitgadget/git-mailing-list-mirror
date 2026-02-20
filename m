Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5003358AE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575881; cv=none; b=k6p7IvPV8xn9Mb6xUt9IVCKEELNZvrrN/gwT43ip3Mm1IX9HR8eGOlqzZIqSpXd/j8oxDheB/sdVpvSAqcz8OcT9HbHjBI13gw8bnL+0bWOyMb0DhJ0IgtEfMG0JK7moyifiUpH2zC4RHmFKOdyZIAs6PXW9tYQxlLUJvoM9Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575881; c=relaxed/simple;
	bh=S7LB8aArhMvAgA696LLRA6KF8XyO7kz6hDpSy7uLy60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnirFR1SYQzOzITFakWizAIWYB3uMHzeF4VcHTInj5V0amGUUUmr2nKSRBIb2UlyNub8sL5tnsZUy37vH/nUGlzeCBHCLafF5tLthVEDzVIIuE9y18d3vdfG9oOqssyC6u/0TV/v+3XrXZCEhdv70fFJbv2xMKkdV4ctA/Q4cXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZrEhWuxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETRsjYpG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZrEhWuxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETRsjYpG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAE127A010C;
	Fri, 20 Feb 2026 03:24:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 03:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575878;
	 x=1771662278; bh=e5EdFZGwY9wv8k5nrGxagocCfZewTJcCBaemCqbiNYo=; b=
	ZrEhWuxf8vvhXbHy2UkJWQjqxcqXnT6WELWOCxwMgx8hhN9NPXXDCiF6qKTB6FPJ
	zQhLfNrXuyo3EGvBW/Wk5SwOb0FybX59+8d8uHbGWXLtVDKisy/B+EdeNK23873J
	KKx9r3Ph6x8K65frdQ62Xb/CoS7fmLypqt0upb8ikfC4A37+JMXKQImVDS7aCjRv
	RLr8dxZ4V0lqTvYGsvPVwf07ENAs6yN6dhYuQLedwol6YcYIn+CTjQoOGY0ojX5g
	7R5nN622gpEi2hqbhal7woM/6XHfDBH7hYt5o9KE1A3LfehvsQs3nXOASE7KVuov
	vK6mQBvASdR/Cl88Y/ny+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575878; x=
	1771662278; bh=e5EdFZGwY9wv8k5nrGxagocCfZewTJcCBaemCqbiNYo=; b=E
	TRsjYpGudL6v9X54aM/s3HD18ay5rwGJJWjUBSj2Mtvlnfz5JjuL90Gx8I0CmV97
	vvqKPe4ahdmtGrtCAjQrnHvq3U6Ja08Vz+9Mc/kOJq3qs6Qs1cQdRMSJ234KDm6f
	XkkPWZ+wmLC4ru4R+QKjPYriL8we2N/wk6hRPxHZrTBRXSViHjxQZCLG8kksGbcZ
	8shHhKBOVqlc1ebS1P+9P7mI2Gsz6S5pK2bey97y8jMe6MMfYe67iYy7qSM8wPu2
	6824PosUxMdU9NugCDAqGDZComSm78pvrRaP2Ff8D71Et+gMNinobpU4UgOAMpG7
	86v5RRjBQAqnbjyOxKGOA==
X-ME-Sender: <xms:RhqYaVYetAMu16tCiox3nD3kpadsBwvPcQfxoQmwDjKTwSb3zY6hgw>
    <xme:RhqYaSbOzcppsbX_jQHRZxBTUufoqai6PNhSxtop_5BKbPTzypZjPnPViU43WLHfd
    g3j9bWSmPJOr0cmLtVYvjpfCZeF6JVzLnOTifMXqWbv7uLjvwXQcg>
X-ME-Received: <xmr:RhqYaVngJ3Q6HOpp1EBieCCFASMjN_Yv7C-hCFGSyfjJ57isBAaWJRJzETOm6BT0dyu9BBYJSlXu3-ilUZANlhSz7dXxZblv2a84YmNZXv_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RhqYaezEcHBS4qumJdBJKY196zksPyhNDYJ1vGoSsFBNSUFoRMAoXw>
    <xmx:RhqYaTNeRkyTOOg35rSFRKTeln78oGNrJyWiUNcwXnfAqTllLFo_RQ>
    <xmx:RhqYaSTZM2GO-vCM64BwRgxRdtXTBvjSb_NKVt6lihgbUkiVV57IHQ>
    <xmx:RhqYaRZ_7jiXCUtfmPVG6TnQO-q6BHDYrE2w9-4bYdumFO-vjQffBw>
    <xmx:RhqYaVpN2AUnGdALr58CsGxevSrVuhjioJNDMi4J2pFpvip_1Me4ZkFf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 591e2dae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:09 +0100
Subject: [PATCH 05/17] refs: remove unused
 `refs_for_each_include_root_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-5-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Remove the unused `refs_for_each_include_root_ref()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 7 -------
 refs.h | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/refs.c b/refs.c
index e9ac0a7101..a45cc61211 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,13 +1932,6 @@ int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int refs_for_each_include_root_refs(struct ref_store *refs, refs_for_each_cb fn,
-				    void *cb_data)
-{
-	return do_for_each_ref(refs, "", NULL, fn, 0,
-			       REFS_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
-}
-
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index e37574009b..5190e98b2c 100644
--- a/refs.h
+++ b/refs.h
@@ -509,12 +509,6 @@ int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_d
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    refs_for_each_cb fn, void *cb_data);
 
-/*
- * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
- */
-int refs_for_each_include_root_refs(struct ref_store *refs, refs_for_each_cb fn,
-				    void *cb_data);
-
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.

-- 
2.53.0.414.gf7e9f6c205.dirty

