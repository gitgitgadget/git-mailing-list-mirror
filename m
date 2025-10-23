Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B02DC332
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203806; cv=none; b=hFx/Q/lnq38Y0zkoBkI9fS9eArKVZIKTO82YKb9dyxl4kM6FPwxiizYvwGcErml5iKku+U/g59Vim9Df+YBBlYZPB7BFnADXqKsukhPrDHwnvYY5cB+RGJAaWo9dqluTPXmJlKNHOMziXqu5R2x7IbdOoYAusHqPJgUinYr+5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203806; c=relaxed/simple;
	bh=7cYFEJN9W3daYJwJ8DeKu68bscKLEdjgDTOTfKVvw24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuVnJasA+oJQnIu+oxw/8J+/GjEVlsq9pi1sTE+c10JuZGCYZTFVELiOj8qV5Fd4HHvybiFT0rHLH2LV2NpJgwNb9psvgEbwCRVf2xLA32IU/YrSp4QpCCvNYBYcaUHmPlc795798r4SxdEzrIP1OSTHwH0X0WOUf8O9yYmOHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ciWLZNyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EFuoiLT0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ciWLZNyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFuoiLT0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E076714001BD;
	Thu, 23 Oct 2025 03:16:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 03:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203802;
	 x=1761290202; bh=oiEBhjrq1g6zmQjOfAMBgnm2m5evSCZYiHTFZuAljdM=; b=
	ciWLZNycD5DrJWCadEhfRSf2T5562zTUpIFZlJ6jBAdLGWujW4iLU6eeEobieyg4
	iL96ZqhVWp8s3B75zENoBi850n+I3DdnaI5bWDUroSvZKek/lAzGTl1CIwlVlWbq
	TUK48qLBVh4Pl8Skejry4BKEeF9vRohcifIz7vdb+VZWmhmu70axn0X/VyRp8dPW
	YfHkZEVpoxE03ArrYXCccdjG5ct4SI59O1tvgvRSSat5DqPMGa2/wEhmHZj8B6eg
	eYfww5LDLmDd0C5xjGwje6B2lNrIRkg8o3YTZrMin59GB+5gaNDWfYS9pM2U+Jlo
	3XdD4K9Ax0OTgje1x3bNTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203802; x=
	1761290202; bh=oiEBhjrq1g6zmQjOfAMBgnm2m5evSCZYiHTFZuAljdM=; b=E
	FuoiLT0Q44SdGl4Wj5R1TbQqOb3gfbUADrToF4YxIlJXehj8OdTYCvXlFSRAroBw
	JHLmhNTUa5P3t7GD5ItEoQbgejcJetVLVfENSRHUUYxNC280BOZSQ6SlhTF04qhb
	G0ZNFdI3CoFgMrdo+uaHZTAaPhtrTV7HamUQvsZgWmKnO7Ie+KUeMPt3hwOEHOlv
	uQsjWE439iMGqHR/uxqYwfcEk/Ef2I0MLlpST8FPGvcWft4LoFKUDbCYx+Tr3qhz
	UtRmJWu0lkF1eNhQddxXKIgl36qZydCPKyTCKq1+Kl/NUrdgRjUSZd1a6M+sSzww
	dBBg7Et+nBk0zlqhvGdOg==
X-ME-Sender: <xms:Wtb5aKqmy0rTsoACLe8WBtyMULbW6wSoWk4DRxQKMjralB5PXzz_Qw>
    <xme:Wtb5aMXzm9hUXY1dYBNVY4Da-WjQeYDQwKDB4E1OJXWLv_HzxEF0EILgwGfKCvqI-
    nOFLdceqCtAaGl1k2n177iCTOdxD-WO4PDqLEaixkfVy_s-2R3Qww>
X-ME-Received: <xmr:Wtb5aJAjyS_ToV7jM0vsFtwvumz71IwwiyXV-bLGJFL6L2pIEmrARVdxRGLo58KBByia62kVE_s6VVKAaKdvyGHLLq0jDTNJhEskIkjEibu2lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Wtb5aA30RJspqJvqlrtq8WjqGaL4Ib1_gdONutDl3sMFe04Wo3E_hw>
    <xmx:Wtb5aL1mEbjfXo2kbs4HnRDPdaavt8yyhpelYbbJxzJ4lmYMXRljHQ>
    <xmx:Wtb5aFCrIi3b2uhfxErp_LJtV9VFfcI2tjITQnPsReIq8gS5ondNfA>
    <xmx:Wtb5aK5HdbnlK2n3nNUu0-VljTMreevbIJE5FsgJ7ZxWmh9X5pv8gQ>
    <xmx:Wtb5aDlD12Z0BLqeKPaqqiymMalKKv2EltRBEiSTiqmkUu8rZzR74_vA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63b853b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:17 +0200
Subject: [PATCH v4 08/14] builtin/show-ref: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-8-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
index 4803b5e5986..4d4984e4e0c 100644
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
2.51.1.930.gacf6e81ea2.dirty

