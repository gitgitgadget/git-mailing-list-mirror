Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FA37AA79
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903210; cv=none; b=TWPetySwuXxhBtdihCpfpeIhxW4vtdgqH5SAVaEezTsQC52DLFm4xmFsvMKEyAjOq7U7k5qUwHrbAArruU6z+QU3zUv/mGbbfZr05f62crldImRtZ00C2nW/Tkb8yvWgsvpROSPa2HfFrb8HO8XWoIckCYGJSL+CtJz0KdGqbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903210; c=relaxed/simple;
	bh=ZL6dQ8i+Q8U9Ory8Ef3joA4tWHqOYABBFB5AVGe2izk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K86oF7MwVvmcapZIaDCrZCmal7MPTZhDQi3IpcxVSggEF03nYkZeimGX4BULosLSA9g85GoK/ixstNQR6M0Bs8QX+33P+wTlXlJ+ruLzk5qIaGcm24ngXesjiAuerPsb2jTWeb+1bOXHI0tLhUHA5ka18A1xZwWrHXOjT2Q9zYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ez5aETA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZWzOz94; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ez5aETA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZWzOz94"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D0218EC027B
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 02:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903207;
	 x=1773989607; bh=JPMRqHpLZJ1ZFduEdvTEW9tHtXb2oSObnC2B3pZMDzQ=; b=
	ez5aETA81WUKYh6f/oCxnV408dydWdJ5fvN7q9iZwdam099pU5/lo8sdF/3R4t58
	Q16Sx9s25SZxZRiGsNrOK1Unk0d7gQITDjbSsFzTb7g2zZow8XqFRvhUJW92woZm
	Ck5OyQesxIQ0ABVBogRZ+1IWSftSqlM1tRFd46pg/U80wAWs2YuSfKiVH9/07hyq
	i5Rf5FOIkBTL9tVNoXVJRzcNrV4ar355INFtnlvCcPu5+A3OYy3sVusacXoorvV4
	7CjXusvUDYf6u7Vo9fJUjOm6SoL7UvgXNu4mSNBndOgBWpNYCdtNeTr7nDpQluUc
	x0zQczQh72XDLDKnl+i7kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903207; x=
	1773989607; bh=JPMRqHpLZJ1ZFduEdvTEW9tHtXb2oSObnC2B3pZMDzQ=; b=Q
	ZWzOz94cDPN610WPfiySKDZXYppverBznCOJwk35JrGgB5/NAL6WqLoA6LBy/PbX
	70PuAoeaL2emEy3kMI1E0unLpine/7LLZUwfTQhSI9foupDZie640kBxf3wfq6Du
	PafFlTgiXUqGTocVTlLQb/neuVnYfogRyDhphytLkbTlDY78ysETIXK1MdScVXw7
	wZKe4aYfk+C9T4vQgtVf1fnGIH789sjVFWEQPxf0jc6HbmMHtycfAFk/e011xK+P
	+hGg6fBk74FT9sERHvbY+m6YBpEZmc63speKcW+G1rwzFVW4OH54DZr1ZHfLIp34
	zsasJvND/AC9PFDNVjxXw==
X-ME-Sender: <xms:Z527aWj03kr7Y4axjRbgjGEwo6JRzawnqzcATWoYbUfMEg96-5_rqQ>
    <xme:Z527ad-UA1cI9Yr7xBMJh6UA9_KiwJ4K7NeKyxog6eeuTQOabo3d-qVH6P3U61h2U
    ROqPmrNN0UD2sla7OVP1m2nAM6da2dGxWBF72MYxmtV4peJiqqQ>
X-ME-Received: <xmr:Z527aTso_V8_SCg0_u_nSWxA-keZhmMzSwNKDvWI4hXBWsL0zKm57i9fIYDRj0VnYNLVWehV87oM3bIuGLFw2nzOdBqSb5T9Hm6BC1pr03VB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Z527aUakyPl1T8IyZ8RC4KM0L28QEO8B4z7zhNAds8xNLkcbEKAhPg>
    <xmx:Z527aTrLsWOAS0LY3hAsNokZoTq2qf7j1Us-FWlCYczYp9oXGFqtjg>
    <xmx:Z527aZ-QbJbOQm98vbE4Ye6vYLin8DB4Ety1Aj_Xdtvz0Rol1Uvx9A>
    <xmx:Z527aS93u9k2IPxLan3AkVm8lUqT6cydp9Rl7HUOiAjjQ1MCmoERXA>
    <xmx:Z527aTiR5g5UupoiR8tCfU-Bb4AifRyZU0Su3SxjduYU0THwODUJwvo_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cb5a00b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:07 +0100
Subject: [PATCH 09/14] object-name: merge `update_candidates()` and
 `match_prefix()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-9-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
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

