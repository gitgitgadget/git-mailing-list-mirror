Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A72EC562
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891171; cv=none; b=AWUlJP5PFfRRA9WAqfIkqPpOUFFuwNUU/uLo6SvmkqgD/Tv+M6qR0QSF/ILPe1XyQyg50d/Pv7ELf/WBMIqUk5icQthRH8wHAygFDPZpaht+PkgsGIIeLx1CSp2dAij3HIkwf98xfGyLEGaPsf6EPVB4INcLUsnZ+3Gcem310bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891171; c=relaxed/simple;
	bh=YaGpGqshHJCX6h/AdXsBiP9YNjiLBX0Kps4UsK5WFOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hErYqAdGC6G5i7QLtfQCXkt/q/92AT4REK7HAk5GSPVeCBbMrqOhiK/Ob5bF6SmRL1T5zNppQYDhIJI9yqLF4iJ4N7r6YVxy8XYC69S7ZbNkTxikuek3lwSX/WiOYqtwAq32Vs3OUp0BljKBEzoBxl39HnqI/ExksJ/O8QUtSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VGlLBiQg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qydjJT6C; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VGlLBiQg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qydjJT6C"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0E3D1400154;
	Fri, 31 Oct 2025 02:12:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 31 Oct 2025 02:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891167;
	 x=1761977567; bh=MVFL21p+p5P6qBD7XUyNoCnFOblEzznYEb3Aw4Pgoas=; b=
	VGlLBiQg6DXtFGdxi5xS9m9WlO/B8WmqaFc3aHo5ISwYRsQAHLzah1MkycqgNgZ3
	jPM9lGb1MiEmVnflq2xMDsurMmtSKRRfSaDS6h7uIN2HhHTBM0gj27+NHeFzsd9+
	UD26V41RlvGA+evTuNMA3g8eSYdfRXbI4yXwaqQ+iunGCA9Rv2Kyp69u5svoUI5f
	pZLSgsEJu2EtIxaRJdc9ZZEtUfo4SkWRFzJW90vQLnWVUck6g+v76cI6UZL8WlzO
	vsvCGc1xpwQbpSO1EeQWHbtlg/44XSZ9gyd5NDbTGZwXnKquApNSvZTTD/O0OX7D
	zFbvKDu0kmUT7BJ6QD7D8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891167; x=
	1761977567; bh=MVFL21p+p5P6qBD7XUyNoCnFOblEzznYEb3Aw4Pgoas=; b=q
	ydjJT6CHC3sjkGJDr3eiIhhROvnA+EiBgYrJEMHgqSu6Hq9OtTkA4SThhQ9yvZYW
	fk17Cl91uwRi9XftJkpbo/D6NLlrn7DdeKXuAUO5dYQF7b1ol8ocBrNRwsqoWmd2
	duMrWK57er5hK9FhkH8W8oK+KgWsy/pf60dE5GI7tTJ04vC8ykSUQCltTFtIFWpJ
	syBo6igk9+DmW+3tC6GFf6HxOwCSl+lBPRGMNL7zsSoxDIXrqkqiVH8TlWAoKFzE
	hKkKEOMhp2UcLXc4r2mUYGFKjj7t/1zfOSvUPN7XldsS1N7Rt4+zZS1jw7vEDz2u
	zHzON7lulaw40V/dXrV2w==
X-ME-Sender: <xms:X1MEaXP9IRJGS9PDA1_KVLY9it1k6loPIK0Qkc9OTUNMrRcnuxcLYg>
    <xme:X1MEaZYzBFSsorC79Kuq2AEvUf7_95Vluz3HYnlzIy7Y0JflyUnl_9Ox3rBp2vFln
    zlc6ztwEPaugz8jHt3kCYG8pMJhoxSjANNCjvKcJSZuDogpo6Y>
X-ME-Received: <xmr:X1MEaTrD6GK-ngHxII5fdwho9l5p_NpHgCoDoWDpuc77RwpjesExyM1oohZ-Qp6q0P81SVvnLdk3H7m6Huonv2GsWUgnGBsFqKdoBhZdxDXwiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:X1MEaVa_w2rPfJhGdZsZPtSO1k_2UX40oK51kQnHXzy7ukQNy02lAg>
    <xmx:X1MEaTQ36bS6ia9N6B7K3fCtU9bhaAa3xZ6garnnwTqij4J-VCcQjw>
    <xmx:X1MEaU66ZpXmRxo5zeSWUa8QIe1uiJun7Ak99TYZp8Vmx2Z0MTVtmg>
    <xmx:X1MEaQxx2rnWTDmcLVAxzzadbUCrGBb3QX54DgA5XCXWXXlk6wnl0A>
    <xmx:X1MEaVb1x-QY44roC_fMqH0P47L6Sym6OS6zkhsbxrbiuI3x6sqPiYn2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:12:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0cea311 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:12:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:37 +0100
Subject: [PATCH v2 01/13] odb: fix subtle logic to check whether an
 alternate is usable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-1-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
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

