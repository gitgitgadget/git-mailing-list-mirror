Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D7359A7B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990491; cv=none; b=ZN92KIRUfZLrydi6ONQh/PE/5SID+7eNe1R10gvxznvbGsxwA07Lf001X4AXomlEcvvn3+z9+ox7HN8aK9lkrcA+xL7VI5keCskDMQcqAosPO1D5GUa0h9EqlJZxyxpScp/AP4d0/x4OwTkmtuktHCN0+mpqy/r+ETpxBVZnxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990491; c=relaxed/simple;
	bh=3hG5YkSt8OY4IJKiAi4f2Dj3Y5gYB2deqPJ9kic5wdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRVmyQxfVM4oiqZL9N4/EiIWQ40/45/VroUY61mBrZ0LsseEd4qh1RCFwgO+10leoj3YrNFJ4Db+IuvardJy+f0V4ENOw79ZCiTaz68y1YISgDrxghXkPVXKopJ1GWJTieX5uKJ+KGCv3Yp+OYIs3d4fhGWRv3lIAPjs4v/ZgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kjLq3ysL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJqW4iXp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kjLq3ysL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJqW4iXp"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 67BC91400008;
	Fri, 20 Mar 2026 03:08:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 20 Mar 2026 03:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990489;
	 x=1774076889; bh=4hlk680jubrd5iksA5QWjm8oUn/VTy3Z0wEw6KDFTLc=; b=
	kjLq3ysL58wBvWtx0US/jqcv++a1y+0zT/N4bVKUAa8fwVjzHcMXVfeth0BbuwnO
	mHuQiI/mNXcOQ43Y7jEM1dsuL/+D0aVEQeWbC+icvpS8PJUSeOTKFYY9FtcyOC5Z
	QeS4vsNZToNngjlU/EvglIOc4Trh2D6ghrcap/DTjoT83sIHWz1++a68c3XgdQAK
	cr6AWwjMITEqxJDfqWR0t75U3i9uAZQ60U3aWj6APnDfhjA8e1XdHzYNzpFMMs78
	AYd2zrynTCFK7RzZPY0Cp633N5+RbKbfN+fpdFjRC13JnW9q/E9pkDkFTVPYEP+R
	Q6uL0jOOdQpyH+M6Tqs0xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990489; x=
	1774076889; bh=4hlk680jubrd5iksA5QWjm8oUn/VTy3Z0wEw6KDFTLc=; b=e
	JqW4iXpUALAifrE7/yiPLLzeQ7Utt58XzBEHJE1tw8/0bxB2pX8Srj5PPOSjt2OE
	q9uiZi5tLuNHNmPnLEAtkejRsipSNzzB6DyKynw9uCz2NMOOE5TcNv6c8sNgR/5k
	CFRU5yaYQemyM+gMD+UeK/K9BxD6FgdWd+rN1UYXpuXDjudK+xvuwdpWpwCFtZ5F
	eUpwa7p6Dz5HbzMAXbr78poX96kiVgtqJNaM7T7nZSA/2tF4wopb3/Y8gLFLLST/
	w5lVtU7rqasrRad/PpTJmDRkeiZPvytul+qvBNdwjeLoF/0ousyVqWgDTl9xsPuI
	mHq4p/kQyU9P975OlOjRg==
X-ME-Sender: <xms:WfK8aRjFpdn1H2LwaV8b3u1iGKeN8EvG-5v807t3_CxOGEkwUjX7eA>
    <xme:WfK8addyms42pd8RrakWCtAny3TaJgeHJZMFA-_SuxNU-11J7S1PJNp3NYkpu8ken
    VxusG4hz6YJVCEyq4iAr_qqYEFYIGzGGEOaKhCrGuUUNShMt8-68Q>
X-ME-Received: <xmr:WfK8aecXoj8RnCCYBqcy9v3HaMYrYIqtlvlDgy8K-DGVBJ5dYdvG73TSWSw9xNCRMEx7iv3gth3jpePzkKlQq9kIa3ewa47toAaVBgjwdaB6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:WfK8af86PP1YY2lvzBuDhk2kIDjBySGQKwpGMREsoIIxZh1ZE8p2dw>
    <xmx:WfK8aSm0G9_FgFZqsIgZa5-jN5_ioF8n-_g73heMBelsj7eXv0xI8g>
    <xmx:WfK8aZ8MBpEBrvvJwjfvsViCaE0tntGHgWeZzSLuaKPedgFIks2Ouw>
    <xmx:WfK8aYlDUSEwcpufBuckxObLjnc58f69guf7Zchv88Ax_by0sfi21w>
    <xmx:WfK8addvDHg_rhR3qikIxpNNb8xmUFx3q3VZqGnFfwS8dW8OVG-5MxWk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:08:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d5c2de2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:08:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:36 +0100
Subject: [PATCH v2 10/14] object-name: abbreviate loose object names
 without `disambiguate_state`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-10-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `find_short_object_filename()` takes an object ID and
computes the minimum required object name length to make it unique. This
is done by reusing the object disambiguation infrastructure, where we
iterate through every loose object and then update the disambiguate
state one by one.

Ultimately, we don't care about the disambiguate state though. It is
used because this infrastructure knows how to enumerate only those
objects that match a given prefix. But now that we have extended the
`odb_for_each_object()` function to do this for us we have an easier way
to do this. Consequently, we really only use the disambiguate state now
to propagate `struct min_abbrev_data`.

Refactor the code and drop this indirection so that we use `struct
min_abbrev_data` directly. This also allows us to drop some now-unused
logic from the disambiguate infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/object-name.c b/object-name.c
index f55a332032..d82fb49f39 100644
--- a/object-name.c
+++ b/object-name.c
@@ -48,7 +48,6 @@ struct disambiguate_state {
 	unsigned candidate_ok:1;
 	unsigned disambiguate_fn_used:1;
 	unsigned ambiguous:1;
-	unsigned always_call_fn:1;
 };
 
 static int update_disambiguate_state(const struct object_id *current,
@@ -58,10 +57,6 @@ static int update_disambiguate_state(const struct object_id *current,
 	struct disambiguate_state *ds = cb_data;
 
 	/* The hash algorithm of current has already been filtered */
-	if (ds->always_call_fn) {
-		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
-		return ds->ambiguous;
-	}
 	if (!ds->candidate_exists) {
 		/* this is the first candidate */
 		oidcpy(&ds->candidate, current);
@@ -107,19 +102,6 @@ static int update_disambiguate_state(const struct object_id *current,
 	return 0;
 }
 
-static void find_short_object_filename(struct disambiguate_state *ds)
-{
-	struct odb_for_each_object_options opts = {
-		.prefix = &ds->bin_pfx,
-		.prefix_hex_len = ds->len,
-	};
-	struct odb_source *source;
-
-	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		odb_source_loose_for_each_object(source, NULL, update_disambiguate_state,
-						 ds, &opts);
-}
-
 static int finish_object_disambiguation(struct disambiguate_state *ds,
 					struct object_id *oid)
 {
@@ -632,11 +614,26 @@ static int extend_abbrev_len(const struct object_id *oid,
 	return 0;
 }
 
-static int repo_extend_abbrev_len(struct repository *r UNUSED,
-				  const struct object_id *oid,
-				  void *cb_data)
+static int extend_abbrev_len_loose(const struct object_id *oid,
+				   struct object_info *oi UNUSED,
+				   void *cb_data)
 {
-	return extend_abbrev_len(oid, cb_data);
+	struct min_abbrev_data *data = cb_data;
+	extend_abbrev_len(oid, data);
+	return 0;
+}
+
+static void find_abbrev_len_loose(struct min_abbrev_data *mad)
+{
+	struct odb_for_each_object_options opts = {
+		.prefix = mad->oid,
+		.prefix_hex_len = mad->cur_len,
+	};
+	struct odb_source *source;
+
+	for (source = mad->repo->objects->sources; source; source = source->next)
+		odb_source_loose_for_each_object(source, NULL, extend_abbrev_len_loose,
+						 mad, &opts);
 }
 
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
@@ -752,9 +749,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 {
 	const struct git_hash_algo *algo =
 		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
-	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
-	struct object_id oid_ret;
 	const unsigned hexsz = algo->hexsz;
 
 	if (len < 0) {
@@ -794,16 +789,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	mad.oid = oid;
 
 	find_abbrev_len_packed(&mad);
-
-	if (init_object_disambiguation(r, hex, mad.cur_len, algo, &ds) < 0)
-		return -1;
-
-	ds.fn = repo_extend_abbrev_len;
-	ds.always_call_fn = 1;
-	ds.cb_data = (void *)&mad;
-
-	find_short_object_filename(&ds);
-	(void)finish_object_disambiguation(&ds, &oid_ret);
+	find_abbrev_len_loose(&mad);
 
 	hex[mad.cur_len] = 0;
 	return mad.cur_len;

-- 
2.53.0.1055.ga2ffed1127.dirty

