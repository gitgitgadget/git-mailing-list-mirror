Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFB2BEFE7
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155735; cv=none; b=d9Gxjt5tT8hwMNhV+Aa7UybOWb0NBhat1cGkRlBERrZN4DD6wmwhkWa8SndpdTgpWMEAkW1UfzIQoFA6r1GC9uWG//73stnjMd7T/gMrQu/2RkqEv3B+SGZD11HVYsx5AB/cZAKTP0IsMb+gZLETHuMlxbFQ7qLQVWU38dszj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155735; c=relaxed/simple;
	bh=YaGpGqshHJCX6h/AdXsBiP9YNjiLBX0Kps4UsK5WFOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEhbvoZFt5i1+toUG/ZQb73sEn+zdiyAH2+ZgPUyeF39/qi6ADun8kJEo3MNFwZwUzIqgkMBoF1OFq87Yz7XSk5YhzikEVslfaK8EqoFkKvUYfhiHaGpdhCkYpvjVU2VhEHNIDDqVJ8TeyVz8e3cDQIFDrNMRsxdiORHI01Wu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f0uWoQly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EE+hkpmG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f0uWoQly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EE+hkpmG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 763847A002F;
	Mon,  3 Nov 2025 02:42:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155732;
	 x=1762242132; bh=MVFL21p+p5P6qBD7XUyNoCnFOblEzznYEb3Aw4Pgoas=; b=
	f0uWoQlyf0Zp6GEGEF90J0qgv2QqwPqUcdP6lHjvH63qVe70M19b141K83PZtPnY
	i6G+q5arBTqCr6lxb4geKDGc/kg3ZO3F9sVzX34UFQ9kNQpLKS6qiCfHg+2zaA34
	KR0Hw6Z56D2o8QwY0cuiNCaxLhPEADPio27h8QlZc1dlbSUtcceBmkGNz2V++UDm
	hegfmBn4I1tIVxiuEx3ybS53vOx4kqVRTtCwXe1gabuRJA/QpEO9LWop3Xpwxl2+
	HrtKRrm+vxlYWiRdACdtR/2LLHH9QtIVscCgs4mAj/I5KPG/RBo7iFysG4jMPQxc
	5TuR7O/qNWCUVr3ZwRue2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155732; x=
	1762242132; bh=MVFL21p+p5P6qBD7XUyNoCnFOblEzznYEb3Aw4Pgoas=; b=E
	E+hkpmGdeH4aXA3yc/EseKpFb4VEXF3p9K0qpLUViTzg6vFbyMum63oxHIrjMEa3
	xXfp4AuR5f8RDk+Si+su5jRnWwsKw23Iw7J0PEe5oIrRXjQNwHBBsjchPMC4IrEM
	zfHYguIsp5E+lCkXXazd3ygpAVBQ2e1r5X0J+XErlMVPaBrC45d8aYQmSEtdj6CE
	VeL9pypHVcEyfNagTsxUZasTiCZqWX48ZIXPQ9Fwtl5hnS/+2I0Q+BsOmJaAOYOd
	hkw06j8okjyq7x8TUQ0Lmm/8qz+Dbd3nMnaVDu7ny7vyubVQF0rfNSdDr2NQkr1k
	ddnK8BLUUnngYB6jEEBUQ==
X-ME-Sender: <xms:1FwIaQpswU8tXobrDbow4JPxVTTBqEXAaFTCvaIs-67Tqx4afF6EbQ>
    <xme:1FwIaeHzdbNI4x_b74z926MSIsmpvrtqa6kTGxktBOdrB_7wRTUZ7HP5qpTtfAIdR
    NmqoR7OhFvZHDcfdIKkzs8TKkY-Vk4z8S-trLKkXqq54HJd-wIP>
X-ME-Received: <xmr:1FwIaSkFP4ir64R5TFBDYPS_uSbpdootxwOhnMOhNoVpvjrXYWApkBGo7wxb8LPlXkYWUirzEynAlosvXBHrgn5f3my6MxzO2_nwTQnizJCv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:1FwIaRmMDtouSscHRqmNAzy7dTDysrSnIJuL3c5m7LkzvdG_mQo24A>
    <xmx:1FwIaTuYfSkHp8_AmqMFGp74BWi50ZaFVFk8J0cTDz8RXbv8w2LEhA>
    <xmx:1FwIaUlUNAw_1ay9hr0OFL5COr8DDvQRI68lZ647WPLuEfhIZQ-DWQ>
    <xmx:1FwIaeuCIKW9AL-XS7b6TcfB3AqhrcJ9r79HSJ22mhXyjylVsPolHA>
    <xmx:1FwIaWHhpbaq3hwSJgKyNKez6qVdVt9I4C1ggmo2OQIWwJsp5QwpJHoO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e22005b9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:41:56 +0100
Subject: [PATCH v3 01/13] odb: fix subtle logic to check whether an
 alternate is usable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-1-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When adding an alternate to the object database we first check whether
or not the path is usable. A path is usable if:

  - It actually exists.

  - We don't have it in our object sources yet.

While the former check is trivial enough, the latter part is somewhat
subtle and prone for bugs. This is because the function doesn't only
check whether or not the given path is usable. But if it _is_ usable, we
also store that path in the map of object sources immediately.

The tricky part here is that the path that gets stored in the map is
_not_ copied. Instead, we rely on the fact that subsequent code uses
`strbuf_detach()` to store the exact same allocated memory in the
created object source. Consequently, the memory is owned by the source
but _also_ stored in the map. This subtlety is easy to miss, so if one
decides to refactor this code one can easily end up breaking this
mechanism.

Make the relationship more explicit by not storing the path as part of
`alt_odb_usable()`. Instead, store the path after we have created the
source so that we can use the source's path pointer directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/odb.c b/odb.c
index 00a6e71568b..57d85ed9505 100644
--- a/odb.c
+++ b/odb.c
@@ -86,17 +86,16 @@ int odb_mkstemp(struct object_database *odb,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct object_database *o,
-			  struct strbuf *path,
-			  const char *normalized_objdir, khiter_t *pos)
+static int alt_odb_usable(struct object_database *o, const char *path,
+			  const char *normalized_objdir)
 {
 	int r;
 
 	/* Detect cases where alternate disappeared */
-	if (!is_directory(path->buf)) {
+	if (!is_directory(path)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
-		      path->buf);
+		      path);
 		return 0;
 	}
 
@@ -113,11 +112,14 @@ static int alt_odb_usable(struct object_database *o,
 		assert(r == 1); /* never used */
 		kh_value(o->source_by_path, p) = o->sources;
 	}
-	if (fspatheq(path->buf, normalized_objdir))
+
+	if (fspatheq(path, normalized_objdir))
+		return 0;
+
+	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
 		return 0;
-	*pos = kh_put_odb_path_map(o->source_by_path, path->buf, &r);
-	/* r: 0 = exists, 1 = never used, 2 = deleted */
-	return r == 0 ? 0 : 1;
+
+	return 1;
 }
 
 /*
@@ -148,6 +150,7 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
+	int ret;
 
 	if (!is_absolute_path(dir) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
@@ -172,20 +175,21 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	strbuf_reset(&tmp);
 	strbuf_realpath(&tmp, odb->sources->path, 1);
 
-	if (!alt_odb_usable(odb, &pathbuf, tmp.buf, &pos))
+	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
 		goto error;
 
 	CALLOC_ARRAY(alternate, 1);
 	alternate->odb = odb;
 	alternate->local = false;
-	/* pathbuf.buf is already in r->objects->source_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
 	*odb->sources_tail = alternate;
 	odb->sources_tail = &(alternate->next);
-	alternate->next = NULL;
-	assert(odb->source_by_path);
+
+	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
+	if (!ret)
+		BUG("source must not yet exist");
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */

-- 
2.51.2.1041.gc1ab5b90ca.dirty

