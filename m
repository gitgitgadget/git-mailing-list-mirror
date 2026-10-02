Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31C47F2E3
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935738; cv=none; b=pWZ+1aXLv4EbTsUFauZrkrXuAS1FEliDe991dba6vZIfHU088bZ78fGVAe8MHPY+5MeyZQaSa7Mzum2DPX9RpGuqPOenKFvJs72bMgoG/pRlE3aJrliA+711OvdT2kvOhZLQmbFH5GMSND14N+tX8y0ugQpw8sJKhgNrEbJK87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935738; c=relaxed/simple;
	bh=zgQajFDIAB4Al7Y0ZMTCAAslSQzUCD37HyzPscqejpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq5udQgJ0O4Rj207mfLTKFE3UYG4QFJ7kTXvy+YX+ErVndmA0oKTibF+SLdCXuDbB9ueRUdbohLniOwtW44XTliWEtLf1pKBAjTTJocBMNLBdNEO/pI7+5ZZVo1LS2Al0zQHQm0eQArzEqd39Eia1I6LBknXOrq388FeZU+i9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ohd92+00; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUdmAi31; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ohd92+00";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUdmAi31"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C682EC008A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 06:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935734;
	 x=1791022134; bh=/yT6NXRn0ouyDrt5zUKY/VNLar25dYvHe0I8WAO3CCU=; b=
	ohd92+00vZ9F1SYcv9Uo4BOHmmkepH4r9oEHgOiaRpO9UZCt7/uaiDXntsHSmL4q
	e9sYoLR0YjwsVm4VH9t6JPhe4+dXDEVY3NnLt0VaSnyWL48fM50fPjcbfHzNtpDY
	mKreh3wtiKZT2ogZO24TRAA7OHq/WxX3fDtgHUoSfvRMSaIPkw62DsLhwmsRQVlT
	MCrY8pizCOAQHXYvyARpUMVJGq5T5MJH2+a62bzdNn/cWztnfcprseGljiOjHF9H
	VIa7J5S2ksfK/qEeXfCEqbyT/PjFGiB9/5nOmYU03fOvIEfMIMIBbMuLH1eGwtV2
	eoiSPlhSSD4VKpaIFFtzLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935734; x=
	1791022134; bh=/yT6NXRn0ouyDrt5zUKY/VNLar25dYvHe0I8WAO3CCU=; b=J
	UdmAi31Qe0KK+lIRxOjTeTyIqRiMLiRt2m8RbFqy4y1rB2aO0BOYFaPzyfymBVNs
	cwBJNiAkxBIaKzrPI+8sxqzqSg3aFIBszbqHB3FUgtewc2WwnT6HC3NV4KN9CfRQ
	kPn9VKQupo6Z15HHL9aQD9oTUUmBQGCjexK1ykureIFP/oYIW2MxQ3bQTfP8lRAS
	rgOEXoOM4Nyv+pRjtOAm45PrymOL4YZxzvGwn/JZ7ZuXWCVv04kX4ADAnRKNM8q/
	gXRTgMOYjkkBXaywR7TiCWChfpWg2V1kBudqZ31aNq100j5j5g7NK+FeuMQ8BMFO
	h8hltZJaR6jtCN/3wvHNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935734; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MaXXRniGqAp2XuYoM48zVOQ0PRUrILxyW+av6OWGUKVRikf
	UamUOYNKmzToUplscuefilHNzlI7JU4GQl43JLPV0puGSJC4LCdMqQDBNBbnt5z9
	IQs5r/3ler4lHnIG4nsZrAmfISqVMwliJp8nI/S5QYNJwIIJR65nc9fbfxuLh2cd
	fu/k+B5uw06akfO8+/mYTOrm2T9A8+S5rp4J4wiiNnQ7sbwfQThqABxsLuDAjBST
	+w0OSlcl7wRMjHKk4+PRlxpvg/W6HpK8lQJem2S8qVRLBGON/edx5RnFndSsk4Z5
	I1EdL+XNwCWVxJX0tQdwCleS3Xe3PVOoAHhg1rQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gmJiPbyNEFKEZgDldC+Ux/wOVRN6jeUFh9eG7TR6NEo=:zgQajFDIAB4Al7Y0ZMTCAAslSQzUCD37HyzPscqejpQ=;
X-ME-Sender: <xms:toK_ahtG-ZCm2pND1htTQpyRK3Hz3Qp3ezFy5onSBUYatdChEXpomg>
    <xme:toK_ahYwo2CNs_p2BhFK7HVvAgGWfdt_pErh5QcF7pTiroMccDgV64OdHKLsP7i5_
    VEb7yDVaPEO_GSwtjun9Qeiu9uSuMFLGcSpKaAKjlgK7GvptuaSNQ8>
X-ME-Received: <xmr:toK_aqaoGacykI-nlrrx2l6EbjIzMWCTfHlMtZ-yH0_CQ_PoHf-OgQ>
X-ME-Proxy-Cause: dmFkZTF34l82022tRH/XgLve1GnCAagsK1/sNQ03J1wZMCaKRfCFCANyInDwpxNlKo26XL
    EXnDaIhvf6eeyj8SFpLxHe7kMLyAMTddf/VH/Rk//b+JdUzKpEnqhJ/mj6T6WBc3r6ZJE/
    Hr1v675783mYwdLtIr+rwnhjt9V2Sg0kW0Y2Oh+akYz5iWsSjkq3O4mWIO7qqzL2LqWlBu
    4qb3Nz76srjHiKLX7WGKMZWL03bhjvTx5w07iAecZ2+wGDzrZnOrFMya6obWUIWKlk9RXi
    ATp2I5KNGIOri6x7B1ZipZsHWqVLLL4aev/pKUNaysgOv1nDj7mFcdqRSD+T2EP7frLRIU
    1y6CsOajmZkgFtq+PlPs2UERWqPdIo2EGXxsLArpv+bY3fGnYElrF9d1zS1pZKg2fbUNEz
    xNPvDbW+heZk8CWyrm4/NMP0OYya2HNPPwey65LeZWJIcOPJfNJrg6+wevMfj+aJOkn1j0
    lguyAdlBJHPjO+eCuralfgw17pMUOvu6LhAskxDyh1+1iyPm8E33Z9ztsoixCrZTmWZpEL
    PTaBx68jFKV/ks1O/v7AFNTM68lwE8vBnzHIwaLwRUxXwrBJxTFYaeupjUAEGZrHlqZQJ7
    CZOaml5drHgzqRlFh8YJ/0hKsYz4G0GxfIwwhq0Gc+owKHf9/fitJzAa997A
X-ME-Proxy: <xmx:toK_atVz7wgqxBG0z_k-kizrZLjyiCAVbiq5uB2CJg2rSDXUCHDHBw>
    <xmx:toK_ah2lhg975lVzHTNBCKpGQjxlVPtNHd8DR8dDI73XH5HqksGWqQ>
    <xmx:toK_akZIE7OYgC7aeTI2HJRG3-UanI8PObAs9_JvhXr9V2yrBjXEvQ>
    <xmx:toK_akqzq_VcZaVE2n9vObMUgEbhUvRTgWNE66CkttdlU3QxUA9qRQ>
    <xmx:toK_aodiLOKh9UdGzq0hMRV8K9m1ZJEm3CphUkTk9eJX-hE2AL99OqTS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d14d5a38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:21 +0200
Subject: [PATCH 10/13] odb/source: make `will_destroy` an implementation
 detail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-10-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct odb_source::will_destroy` flag tracks whether a source is
part of a transaction that we know we'll destruct anyway. If so, the
backend can optimize for that particular case, for example by not
flushing any data to disk.

While the intent is sensible, it assumes that transactions are backed by
a separate source that's being linked into the object database. But that
may or may not be true, as backends may have significantly better ways
to achieve the same. So the assumption doesn't make much sense in the
first place, as we're now tracking backend-specific details on the
generic `struct odb_source` level.

Move the field from the generic source into the "loose" source, as this
is the only source that ever makes use of it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c | 2 +-
 odb/source-loose.h | 3 +++
 odb/source.h       | 5 -----
 tmp-objdir.c       | 4 +---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3c9edba46a..b2fbccd3c0 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -599,7 +599,7 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 static void close_loose_object(struct odb_source_loose *loose,
 			       int fd, const char *filename)
 {
-	if (loose->base.will_destroy)
+	if (loose->will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 3cf2e1f8f1..7c7e845fe3 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -28,6 +28,9 @@ struct odb_source_loose {
 
 	/* Map between object IDs for loose objects. */
 	struct loose_object_map *map;
+
+	/* Whether this is a source that will never be committed to disk. */
+	int will_destroy;
 };
 
 struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
diff --git a/odb/source.h b/odb/source.h
index ea00873763..9fd2b2e5b5 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -81,11 +81,6 @@ struct odb_source {
 	 */
 	bool local;
 
-	/*
-	 * This object store is ephemeral, so there is no need to fsync.
-	 */
-	int will_destroy;
-
 	/*
 	 * Path to the source. If this is a relative path, it is relative to
 	 * the current working directory.
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 719b55e580..2f2ffbbc7d 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -14,7 +14,6 @@
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
-#include "odb/source-packed.h"
 #include "repository.h"
 
 struct tmp_objdir {
@@ -213,8 +212,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	 * since the objects in the database may roll back.
 	 */
 	t->temp_dir = odb_files_dir_new(t->repo->objects, t->path.buf, false);
-	t->temp_dir->loose->base.will_destroy = will_destroy;
-	t->temp_dir->packed->base.will_destroy = will_destroy;
+	t->temp_dir->loose->will_destroy = will_destroy;
 	t->temp_dir->next = files->dirs;
 
 	t->orig_dir = files->dirs;

-- 
2.56.0.379.gc618271300.dirty

