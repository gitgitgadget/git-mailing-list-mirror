Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F71E376C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303580; cv=none; b=HIMojBAFaE2NEX5rtinkTY8LDBR2ayvEqVfzd/Y/FI2bD4wxlkcNleM6qUoOim8R7/ewCMXvPTP2ogZ9GH9Btyd/VMAFtF718VIssSAOAWgr2daDUZ02zywHbrswVnGODKgRtBcXMBo5iZ0ywFjZYjwO1DrT+6StUl6Cyjugaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303580; c=relaxed/simple;
	bh=979wxQD6r6ejArGgCz5iNVepA+e3cuPAoFdzON4lQjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLTW91jGDg2WDvYR4UvG+FojqjEI9xG14ZtZhOW8WFd/0Yrp/9z5cT4YVfOvVh2+xBRYVmY5kTy9F8Dta9c5hfWmA2dnTdiaaE5PuzRm8at93195hUa1/3+lV1qTtiyRfSAFrsXefvvhineEhbdibOLipemF7PA03MaLKflQaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lGwYprMk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLYbf/bG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lGwYprMk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLYbf/bG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB5237A01EA
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 08:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782303578;
	 x=1782389978; bh=39IXypJNrMMUvHY3E7K8YFyTDwAHgyKParHaKomWkUI=; b=
	lGwYprMkB2KLNHjaGN2JJAeAJ5qkK5hBvaZbOWgb63XXRugR61dRZqJ/3MPkmo/W
	YgSGvInPhpH0r3tEa6OtRCvwuYNcuz+eXlCUk7N1N5YRInpMkZN1KktHn78KfQQz
	36N0IabPVCngNibcYwZpLoRk/KPdD1gnuXpmOIXsnZf42WRHfw6B9XBxctfR3ZvP
	OGY8dczrIO+zSfF4/RGTjZmZ+jdB/RBijCXcs1r99P0ZCwegRN0EnNCZCnMAn60R
	enGuXYZhyCAThM/2aaOT7nkm6vhZwWKPVTROOrXdQdwao4sydtjmW3CHGd4zVpoY
	IyvJdAHdwqI6BJ86pmisTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782303578; x=
	1782389978; bh=39IXypJNrMMUvHY3E7K8YFyTDwAHgyKParHaKomWkUI=; b=F
	LYbf/bGrneE863hSp8uJtMT/u+4pxzRtHDv3j5WnsYGJh05T9cSuKN0F0waGiVfT
	HnDx6LR/qyUN3EKpq8vKGSzYd8YuBDZCs7zBSYAOwNojmlpZoBE2lgl7unfrzmvi
	Y3YKJ23yf3H5HEPmGe0CKvs7bs9KWm++lCCRflT8gEkC4MzkrJNaCRUdYPXiegMq
	/SoTyku5/DdVnRkoNG7RKQRIc/s6jlCsvXA4Z0AcerGRmr4wrtN4x7GaFKlKkn2R
	WgUPKj5yzhbCDrjwT9C1ixsnFTOFn81BMt0T8oIiXdAlGtGni7if3vUIbf0gAWuA
	x4eNqYPZqsaeCDeawwzmg==
X-ME-Sender: <xms:Wss7alw3BDpdInxDkjrvyiySDjOXOM3M4w4JOrqXNncP37yHTl0oHQ>
    <xme:Wss7asNO-PRpXzaUAlAv7huFAL8ZGlzAJF2gbUcnJVd3rM2R3xfH0985Bh_kAsRNq
    Gh-664PM66q4IXWrHGTE9QUUgTNuMXiQ8WOs5sSPR4YqwaL9QrSWg>
X-ME-Received: <xmr:Wss7ak8mY5bPd5tjHtMeTif9_ssaxBH-yqY95kn2IiRCqbK3iAaDj42KAJz4zRDZbk1DRBLt_f9r5FcP923JxE62SVrBuYqJY95lBq58>
X-ME-Proxy-Cause: dmFkZTG1EQtmOEZwQT28Mh0KvYQUMdhjD7eojiWG3PlO/9h4j4NutEfcg7BCaFGwjcQYpT
    TvxZi5sWS2LnJofAWlpIVhus7XnkMaqoSAST1OsXbGYGbJXivApQX2IcT77wO7lNMq8C4z
    qIDIw7B9Hk2fWrCoMYnHMUd7lKaAv7NUCwt6cmR0YE+TCZrveFJQTA/R4wBpaPSJ9Gq9ZM
    rlY2wAGkYb9PpVIeevgqMG3qjf0PsmTdi5CUTVSLxebETAMxBmDasjZV8oRhpQpQAmT+0g
    asl4RqXXV+rOsSQqSZMv0W4r4juFNhWp2e7MDjFJraGDgGA7j5DV8CSAGsAH5YKueD2iWq
    u9L29Bt+384U8diHTIutsCFZFa0U4I1x1ZArQaJKpHTiwx2q6aFOWXMAVlzYOjjgNqWUvB
    c5V4r+13EgdDhSKn00LZoVTfO1POfBysvD0BvV13glWa0TddYdoFQ8pO+FcNCCjljWb7Mg
    qtt2DHzZIo57MhtBPgh78NtrKUoqpC9/8pF+tbgmmB2E2qvj5EmPiE8zhhlxeryC7y7NY1
    3CXCGiQaQPhlE6ABSAKoBaNPSwU2iCwzSJ99amZlYRu7evo8BSHIAZgYe84O1BPvOLzyc6
    xAIK/boFD0Gg52Ypqo19WDZf7upkEnSCsIqhH5EwhLJTD8mF09pdUmiF6+0w
X-ME-Proxy: <xmx:Wss7asrK61fdTLwYF3VYr9Cw5KAXIn8CkOhh4Wg_3WeCHD098qBjqg>
    <xmx:Wss7am7J8wa9sfPFkwloyb9UDnr9idnN8QztSRB9SBRPfS-woLeeZg>
    <xmx:Wss7asOE2NOoMtUMY09zbnb1IVOWtIWH0bLMZY9CGrd8IFHu_bbPxA>
    <xmx:Wss7aoPCOkdp2AjwNV3dwji45734v9tOdjwbaTYKUprRRWTHcMffXA>
    <xmx:Wss7arxg8C91cf41zItyTZn6OruFYaiH5kbj2c5Sj_Kv_buxzK1Diwhj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d84fa7d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 14:19:17 +0200
Subject: [PATCH 4/6] treewide: convert users of `whence` to the new source
 field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-4-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `whence` field has become redundant now that callers can learn about
the exact source an object has been looked up from via the `struct
object_info_source::source` field.

Adapt callers to use the new field. Note that all callsites already set
up the `info.sourcep` request pointer, so the conversion is rather
straight-forward.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 2 +-
 builtin/index-pack.c   | 3 ++-
 builtin/pack-objects.c | 2 +-
 reachable.c            | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index adc626ce30..1b96150e5b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -834,7 +834,7 @@ static int batch_one_object_oi(const struct object_id *oid,
 			       void *_payload)
 {
 	struct for_each_object_payload *payload = _payload;
-	if (oi && oi->whence == OI_PACKED)
+	if (oi && oi->sourcep->source->type == ODB_SOURCE_PACKED)
 		return payload->callback(oid, oi->sourcep->u.packed.pack,
 					 oi->sourcep->u.packed.offset,
 					 payload->payload);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 77af26db8f..1b03b07e5e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1833,7 +1833,8 @@ static void repack_local_links(void)
 		if (odb_read_object_info_extended(the_repository->objects, oid, &info, 0))
 			/* Missing; assume it is a promisor object */
 			continue;
-		if (info.whence == OI_PACKED && info_source.u.packed.pack->pack_promisor)
+		if (info_source.source->type == ODB_SOURCE_PACKED &&
+		    info_source.u.packed.pack->pack_promisor)
 			continue;
 
 		if (!cmd.args.nr) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9deb37e9e8..d0fdfad750 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5010,7 +5010,7 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 
 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
 		BUG("should_include_obj should only be called on existing objects");
-	return info.whence != OI_PACKED || !info_source.u.packed.pack->pack_promisor;
+	return info_source.source->type != ODB_SOURCE_PACKED || !info_source.u.packed.pack->pack_promisor;
 }
 
 static int is_not_in_promisor_pack(struct commit *commit, void *data) {
diff --git a/reachable.c b/reachable.c
index 2fc5b82d62..123a658944 100644
--- a/reachable.c
+++ b/reachable.c
@@ -234,7 +234,7 @@ static int add_recent_object(const struct object_id *oid,
 
 	add_pending_object(data->revs, obj, "");
 	if (data->cb) {
-		if (oi->whence == OI_PACKED)
+		if (oi->sourcep->source->type == ODB_SOURCE_PACKED)
 			data->cb(obj, oi->sourcep->u.packed.pack,
 				 oi->sourcep->u.packed.offset, *oi->mtimep);
 		else

-- 
2.55.0.rc1.745.g43192e7977.dirty

