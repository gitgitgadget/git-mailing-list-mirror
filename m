Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7172FB09A
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938653; cv=none; b=MKtgr6mV/jU/ZdGr8fAfq/Kt+Mc9cNYealKWXgXv06NG/Q/5mYMXcw9Obq5uKZm+QatKLtmQ0d/uN5rBt6r98KrLrN9A5IhWNFZedVp0qYXPAPNIaVs5E/CEnFNt3y7Wc7FQDGeHSXA6J5y617LcWT/8b8qtTiLa+jgH2oznaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938653; c=relaxed/simple;
	bh=0q83IBBP9EOiS06IiTbeJLK/RsGll9h3CCmFipeV6o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmQNgB5EOUHRvWp509SpkJS5oKZQcD0rEm8Q+DAgLsELCbupSFYXyo/bmg5irNOLaBJiv2sMxrnJiG24eEvoaa1Vk7rCscxj+klr3Jxr8Ieh8kBbfRxEmt24Yn0F2kHq93jkRY4bXLMm4zbR47ga1/EkxX9dE9Cfdddnpr91VH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BMK0eYYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VB7HFq+E; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BMK0eYYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VB7HFq+E"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A1897A05D8;
	Wed,  8 Oct 2025 11:50:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 11:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938650;
	 x=1760025050; bh=O97aGnnjHGEJBsppce1yK8nljxlpx6P6xJ/R/X2e9wE=; b=
	BMK0eYYf+PtIA1tln2syDRaSVM+zDnCQx4I7LZz31cy7T56gVpjcWDapOToRNHw+
	1wgxFQKc4sXwrU74DGsijWIWCAsVhOSzJP1iyXVVd95ROHbNq+MEVEHivUQLmpU6
	OzXB2m+dCz9ltkL6DmpuNB0floUzMZawCeGHUarHcVvT31/OaDT/rABLPxBdXDG5
	tsLGCPwXJglev3EGPs4KvPFTUdwc/BSX86hEDbbUliOUsYY3pr04A4FiAOO/IBVy
	xa9jl0a/cHFFdGSkNric5GAhSoXhVRbzEGL1W/JoEXW5vhf5nIjegubf31rD7jqs
	WwXk1TaIBRFLLVchuKM/Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938650; x=
	1760025050; bh=O97aGnnjHGEJBsppce1yK8nljxlpx6P6xJ/R/X2e9wE=; b=V
	B7HFq+EKm9q7r9Z8sYWYrCGdhLocAs0Ng8UYb+vz4IpVS8ucu1IQeKqtznVJPTIK
	vyyE8YbJ4UzRtP7kpKqriddntem2i4YfGBeb0BV8g6UPtWOil6pX6o3u9579W2xo
	mjXSPi9QZ6YWWvBYECV8h6FI61KQYEcN69LAiwSSju1vfyLWblJxSknjS6msKaIA
	pYtSa3hxtJFQUzhaxj60Li57oT6apQGf2okY9DnIS6708mIvZSovttVKQrE5grNF
	O+TPOX2KzyC6vD5WJCKL0/Ac9mKLllGGhRW2d5cQFKCppxlmBdqylfm90SnFA3XR
	nqJMo9NNZ9YVXJjcF586A==
X-ME-Sender: <xms:WojmaLZRUJHWN1U26uAaCz7D5uJEYS60gKVxU2KYrEj_2sEuN5HaWg>
    <xme:WojmaOGP1Sf2GuhTieG_OOMr6YacvwnqeuUP59inpdciUMu0Pwtbt-sKteNQqPGCi
    wPErvCr73orFakyTM_0lpP1wyLNyLlnROBfDSxRDf1Mm-AQ_DoXaQ>
X-ME-Received: <xmr:WojmaHzDYd_jCDeTs8PmmRLg3wpjJF3VRFEgIJqSoC3cFCQLX_S2crJH1200ZAA96LaO47qo9L7Mn0mUvaIV7ZZsnc1l6R9_fTWetQij>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WojmaIkTf5RDwMrMsYiFC9y3BxGB5v119vsgLPog1nWDr8vfUL_krQ>
    <xmx:WojmaIk2apxtLafJQ5nguv0beSm9JeBbbLAixs8xwbkzlSTFTo8Fsw>
    <xmx:WojmaCxttKnc1yhsJeFi_f6uFwP3ZCzF820VbN2YYFjW1v8l0mF9dA>
    <xmx:WojmaFp6gDZ_iC5NbmZE1O_S3K2CFC1R1FX-qMXOdETo8z_GTnDuPA>
    <xmx:WojmaIXtykzyGmfm4rbAGPrO6-NO75qZWQZkP3MaP1ODsN1BS1GNspLn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 143e0d17 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:23 +0200
Subject: [PATCH v2 08/14] builtin/show-ref: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-8-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The git-show-ref(1) command has multiple different modes:

  - It knows to show all references matching a pattern.

  - It knows to list all references that are an exact match to whatever
    the user has provided.

  - It knows to check for reference existence.

The first two commands use mostly the same infrastructure to print the
references via `show_one()`. But while the former mode uses a proper
iterator and thus has a `struct reference` available in its context, the
latter calls `refs_read_ref()` and thus doesn't. Consequently, we cannot
easily use `reference_get_peeled_oid()` to print the peeled value.

Adapt the code so that we manually construct a `struct reference` when
verifying refs. We wouldn't ever have the peeled value available anyway
as we're not using an iterator here, so we can simply plug in the values
we _do_ have.

With this change we now have a `struct reference` available at both
callsites of `show_one()` and can thus pass it, which allows us to use
`reference_get_peeled_oid()` instead of `peel_iterated_oid()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4803b5e598..4d4984e4e0 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,31 +31,31 @@ struct show_one_options {
 };
 
 static void show_one(const struct show_one_options *opts,
-		     const char *refname, const struct object_id *oid)
+		     const struct reference *ref)
 {
 	const char *hex;
 	struct object_id peeled;
 
-	if (!odb_has_object(the_repository->objects, oid,
+	if (!odb_has_object(the_repository->objects, ref->oid,
 			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
-		die("git show-ref: bad ref %s (%s)", refname,
-		    oid_to_hex(oid));
+		die("git show-ref: bad ref %s (%s)", ref->name,
+		    oid_to_hex(ref->oid));
 
 	if (opts->quiet)
 		return;
 
-	hex = repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
+	hex = repo_find_unique_abbrev(the_repository, ref->oid, opts->abbrev);
 	if (opts->hash_only)
 		printf("%s\n", hex);
 	else
-		printf("%s %s\n", hex, refname);
+		printf("%s %s\n", hex, ref->name);
 
 	if (!opts->deref_tags)
 		return;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled)) {
 		hex = repo_find_unique_abbrev(the_repository, &peeled, opts->abbrev);
-		printf("%s %s^{}\n", hex, refname);
+		printf("%s %s^{}\n", hex, ref->name);
 	}
 }
 
@@ -93,7 +93,7 @@ static int show_ref(const struct reference *ref, void *cbdata)
 match:
 	data->found_match++;
 
-	show_one(data->show_one_opts, ref->name, ref->oid);
+	show_one(data->show_one_opts, ref);
 
 	return 0;
 }
@@ -175,12 +175,18 @@ static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
 
 		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
 		    !refs_read_ref(get_main_ref_store(the_repository), *refs, &oid)) {
-			show_one(show_one_opts, *refs, &oid);
-		}
-		else if (!show_one_opts->quiet)
+			struct reference ref = {
+				.name = *refs,
+				.oid = &oid,
+			};
+
+			show_one(show_one_opts, &ref);
+		} else if (!show_one_opts->quiet) {
 			die("'%s' - not a valid ref", *refs);
-		else
+		} else {
 			return 1;
+		}
+
 		refs++;
 	}
 

-- 
2.51.0.764.g787ff6f08a.dirty

