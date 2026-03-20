Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503A356A3C
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990488; cv=none; b=Y3UJ/htuVxKwR2pFVJnlUzNPts7CUn5kY8ObnmvnKyOfk+oJE60kHCcjQNXF+wYnr5DMpxoUqQq/NSDUmv9xWdFMnp1/ODrx+mvz0j5bmu4b7yjVnhkhAjRD4irrjRzojv3Dz3S9kgjsSSJc1AwGapWkzNDX/+pjO98zgedBdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990488; c=relaxed/simple;
	bh=ZL6dQ8i+Q8U9Ory8Ef3joA4tWHqOYABBFB5AVGe2izk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCVjNI16hx6epavkPrFf/EsGnhpGEGsWPpnYMZbBxX1/cQeFKiBqrFWWUKDIX3oOjHr5fx5sXAi1CY3E51kD8vJQcY1NfaNzWMfr0sXkegBzoxpBtnYqK/OmGJGKc4xyWzTtveyxElNZeJ3FdpYg90vh1+LzVepsaN2paFnO5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzhhQ4zb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vlg1hh/O; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzhhQ4zb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vlg1hh/O"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7144FEC01E0;
	Fri, 20 Mar 2026 03:08:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 03:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990486;
	 x=1774076886; bh=JPMRqHpLZJ1ZFduEdvTEW9tHtXb2oSObnC2B3pZMDzQ=; b=
	NzhhQ4zbIiAzTYKqO/CyP3GjSrGQqExaCJgEPHrRs9NklLXCfUNKvkh9VtVCd+aU
	K5jnGwvmFg7hZq6yTB408WBHWNLCRKDvhojcW7WZzjA+Czus77EeDOcaybcK+SrF
	xc2YX/eoR89tekpJWORzrh4j5vW2QXKlPgX3CxFK+YXgP7+rCZ9vErcdZr6LHSkc
	0H5sq3qXn2Xaofz545OQvN/UDj9D04zmRyw5KLTZQgP6LRLPso8lc7B5N7VujG74
	U9w+3a1gWK8jH0brCOH/IpA1ldTO4bKyBCtSkP4tNcLxlU2yQFZbesoYnF73az6N
	Y6Zq4grlpPyEyDF8EZlg5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990486; x=
	1774076886; bh=JPMRqHpLZJ1ZFduEdvTEW9tHtXb2oSObnC2B3pZMDzQ=; b=V
	lg1hh/O4N+y3/q0S7nvq9mc2rRv3t9QVkx/OPajfJENfSI1ZsLPcKi/xkP9ETLjc
	Kmnhdeok3klI2vwQyNGO7AJDgRKSrSX8QExakJP36YN3jCl+N2n3MCFZHlxAZsg4
	1XwKxdi0nlizFq7zxngxENlZ2LFFWjj62OaY3H6UXuRIok1qzuOfPX7FpmRWn4H8
	VaDgKNfmXuS6s7oF8iKxTLxPegy2LichETJzGz8DMPmz1DF7ky+R8CXRPGsbUeKB
	13aOEvSN8E80T8a2z/ZVYrr2VY0LeQH07cSElzNUK6WRtOrGaZaE5YdRrwM5hL4W
	8RcVUDJJHNSjd54X6+sWA==
X-ME-Sender: <xms:VvK8ae4KCFRgbRGXKz_XYHdB5W6tgm5lySa_kUCi0T98bmpIZdbHCw>
    <xme:VvK8afVyeCqIIU-kCoPXcguboptCl4gMWNidznAfOCRBxSb5H6Gl8w6x6Kfss9I-8
    _LTxfdtKWsa-Cgh0G1QxDDb8Kw8NSKSH1vfHOBg0wVZVyfIU8Av>
X-ME-Received: <xmr:VvK8aa0Y6_C1dB-jnVFqUnMugnE5Tw__0Akyapkoo0p_NYPjYLh5Uc8ly5mNzJqe-KssaLaakC6quyhvc6HOt5vdNQEwn4Do4kiQAtrlMDMX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:VvK8aU1zi3pWNBXgE-cQDv5F7fOc2DF5EZv4NoIzPmJ0nRtRJJLbNw>
    <xmx:VvK8aV_BVPKw6DFfmkXnJZbHrclzE8SU-YIWQOdkYGCaiS5qWRe5lQ>
    <xmx:VvK8aZ0w9wMaCP40O_Ukw34pMozuaYZJqt-K9N89EOg4lvitHcBa6Q>
    <xmx:VvK8aa_Keyo_yjusZNyPd5ja5kvo7NE5aCGu4C22BjrF2lIOC473sQ>
    <xmx:VvK8aXWBgoagQ695vOfl5fCd-ENB1ssf6PKNLfN4tsFz_8ZHL2ANHeR9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:08:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 188b4aea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:08:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:35 +0100
Subject: [PATCH v2 09/14] object-name: merge `update_candidates()` and
 `match_prefix()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-9-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

There's only a single callsite for `match_prefix()`, and that function
is a rather trivial wrapper of `update_candidates()`. Merge these two
functions into a single `update_disambiguate_state()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/object-name.c b/object-name.c
index 7a224ab4af..f55a332032 100644
--- a/object-name.c
+++ b/object-name.c
@@ -51,27 +51,31 @@ struct disambiguate_state {
 	unsigned always_call_fn:1;
 };
 
-static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
+static int update_disambiguate_state(const struct object_id *current,
+				     struct object_info *oi UNUSED,
+				     void *cb_data)
 {
+	struct disambiguate_state *ds = cb_data;
+
 	/* The hash algorithm of current has already been filtered */
 	if (ds->always_call_fn) {
 		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
-		return;
+		return ds->ambiguous;
 	}
 	if (!ds->candidate_exists) {
 		/* this is the first candidate */
 		oidcpy(&ds->candidate, current);
 		ds->candidate_exists = 1;
-		return;
+		return 0;
 	} else if (oideq(&ds->candidate, current)) {
 		/* the same as what we already have seen */
-		return;
+		return 0;
 	}
 
 	if (!ds->fn) {
 		/* cannot disambiguate between ds->candidate and current */
 		ds->ambiguous = 1;
-		return;
+		return ds->ambiguous;
 	}
 
 	if (!ds->candidate_checked) {
@@ -84,7 +88,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 		/* discard the candidate; we know it does not satisfy fn */
 		oidcpy(&ds->candidate, current);
 		ds->candidate_checked = 0;
-		return;
+		return 0;
 	}
 
 	/* if we reach this point, we know ds->candidate satisfies fn */
@@ -95,17 +99,12 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 		 */
 		ds->candidate_ok = 0;
 		ds->ambiguous = 1;
+		return ds->ambiguous;
 	}
 
 	/* otherwise, current can be discarded and candidate is still good */
-}
 
-static int match_prefix(const struct object_id *oid, struct object_info *oi UNUSED, void *arg)
-{
-	struct disambiguate_state *ds = arg;
-	/* no need to call match_hash, oidtree_each did prefix match */
-	update_candidates(ds, oid);
-	return ds->ambiguous;
+	return 0;
 }
 
 static void find_short_object_filename(struct disambiguate_state *ds)
@@ -117,7 +116,8 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	struct odb_source *source;
 
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		odb_source_loose_for_each_object(source, NULL, match_prefix, ds, &opts);
+		odb_source_loose_for_each_object(source, NULL, update_disambiguate_state,
+						 ds, &opts);
 }
 
 static int finish_object_disambiguation(struct disambiguate_state *ds,
@@ -508,7 +508,8 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	opts.prefix = &ds.bin_pfx;
 	opts.prefix_hex_len = ds.len;
 
-	odb_for_each_object_ext(r->objects, NULL, match_prefix, &ds, &opts);
+	odb_for_each_object_ext(r->objects, NULL, update_disambiguate_state,
+				&ds, &opts);
 	status = finish_object_disambiguation(&ds, oid);
 
 	/*
@@ -518,7 +519,8 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	 */
 	if (status == MISSING_OBJECT) {
 		odb_reprepare(r->objects);
-		odb_for_each_object_ext(r->objects, NULL, match_prefix, &ds, &opts);
+		odb_for_each_object_ext(r->objects, NULL, update_disambiguate_state,
+					&ds, &opts);
 		status = finish_object_disambiguation(&ds, oid);
 	}
 

-- 
2.53.0.1055.ga2ffed1127.dirty

