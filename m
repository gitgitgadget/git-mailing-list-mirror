Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B147D45C
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260983; cv=none; b=mdsMZdDMPlFpqDwbODySpu/TeEnOVy8gfm6wnKkTsB7iSQQgBQKY2LpHG8YY/p0SJxAWBjfDOuCY8/5uhii2LDvagqcQEuGJxPdNJOO5Mh2QAfL75uG1Qav11/BtRx7DEncykDeqDonjA71822wcjTNbq4GuTm8YjWCnMqOz2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260983; c=relaxed/simple;
	bh=A5bLQ6/VuwkQPQfoVxs3QRuXgUW6IJYRzj6dU6yHjn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elKbUMTpp11+7a0ofVy5Gok0aNxv4KN9ZK5cT478ki/KGq2rKul/gscL8OMehiXoL/rMG08CyNO1LXs+zkqqCNXcUozbczKsq4KjAUZ1tSSCchs4L811S5S6JXTb+AastoJKNXyYA3nK40m7Zt+H/yB4OPylyDGSQaQ914nUY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A65ylLNh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QBAMHl4U; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A65ylLNh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QBAMHl4U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0631BEC018A
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260981;
	 x=1788347381; bh=Dlognmgy6Q0uQ+R81oUOOjVNM/XsR2UDadp9F46EZC8=; b=
	A65ylLNhpzuZhhBea73yFa9oAXMoU7M4ie6v/i8Kz5yk+MhKcx9+mZBlIMi2P+/D
	MsLNwV3d1sxAmZ6p0miZxBvyAKPO8VG0k5J5VTG0pBSbBhHd5RqpEJ4Va6N1HX2u
	F+r0nRaNhJT8pF6M65HpaEukxsUF4yzhBQH/0BP9882ouqBuC60IGdj6GF8KCMGG
	z3K19j0y6a7ad0Y3LRtArOHgnWfaOM4LsdXqrVZB4hNC8Gj6PgHQ+XziPcqW2ZOW
	fWFbqno5DBHhTDBAYezSrJKvUzD4cnS1Afc5Pi87odOido4dW5excVZXxwfC++qg
	TUrrAPFzmvv0w50pzNS1Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260981; x=
	1788347381; bh=Dlognmgy6Q0uQ+R81oUOOjVNM/XsR2UDadp9F46EZC8=; b=Q
	BAMHl4UARn0hZiIK/vn/fP0owROuZclhVNWIuxYt+1eEwFzgMh/kGc74IneKdWCN
	y7gr1oUc8iWiLYxLQ7bGPxXWn3AHZA7fAz7Fx30UTu0WCfe0J/qZpbyxmXy6epEo
	0Zgmf2PPPiTwcECBWGY6W3Y2KpJ3ol3MXqhwulWQeNcXZZOX3owO6mHDmpzQHhc5
	VqLFcuuq3aCWNvIx4CO3g4BwdO5R/EHM3Iz1WffPneF4+u7SRMh+YyuBVhRtsytb
	o/wFS1cbes6Z2X32wdit9zawpuMqiOOVEW+/M7CwtcceRxIL/BDx2KMkLbEHnnmX
	GzIfCqg6Z04d4QOKn02lw==
X-ME-Sender: <xms:dLKWatCVP0xKGUU8DRlURF_A0Sr84EY_v5Iz200D-f37oX0CcGF8WA>
    <xme:dLKWaie-C7pq8K0wMmd_FVirEDrw-odhqD1iKWU5uYm7-FsGyWSp_Pb5hdi0-cVGp
    wLCr0RSLFe6eBftmICz9mcbTSegklWus3YMnXEhrGG3gDGEY218X10>
X-ME-Received: <xmr:dLKWauNr7V3jCRrBBzuxCMftk3-_2Uckb38JU50xDrp4gyvoqU7h4g>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNagK
    7t7V7Ltdu8kzvBzXDoXxHQkfr/vx0CgBysxP2SliCFiZtpAsrrT4kIudx8LokFWjNb/ksB
    FsHpeBQVbElI1Bi4s5VuGlIX081721dX6jfnm3vtDtQ6gB0ytR+FbQziugpW5iyK1ZSaN8
    sXKhjRWILyL9nkOoPIFDVDrdn5khU91TUps1bk3nyKLK0x4VZXTjgBNykSMLD8uKH4ciIq
    /Ur6SnVSVJapSeJBzuqxrZBipTtO/uv15IizAZEVPABBwjDIe5Np2T4pJDMro1gyGjL8Xy
    u9OScGg56L8cAGwTqnY7XocIF1X+lPgioWuE2K5ZuawQmkbSSJYXWR1LpfHg
X-ME-Proxy: <xmx:dLKWas5ivgQ92eSkA9fzIxSW3czlw8tt8hrkhrqWCRkp_Tvdm6OB-Q>
    <xmx:dLKWaiIb4mwFUtK3NGMs2Z-1Y0mZvkxItL5ncazMEi_s9Z2n2Z4WwQ>
    <xmx:dLKWamcGqcE6wo5MmUAXrTeHoI4jQpopwYvfanCfvemlSPiAHFsGJg>
    <xmx:dLKWaldNq5i5sTSdFPctfz58bBDpZ59746WIBCJhobD_02IRMhgpkw>
    <xmx:dbKWasABaRgv0jRipPuNfn0zrZH-E7XUbec8BQM3lufUr5rXu0lS4hum>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0452d5cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:02 +0200
Subject: [PATCH 03/12] submodule-config: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-3-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have two uses of `the_hash_algo` in "submodule-config.c":

  - One trivial use in `gitmodules_cb`, which we can convert to use the
    hash algorithm of the repository that's already available in the
    caller's context.

  - One use where we compute the hashmap key of an object ID. We should
    only ever get valid, populated object IDs here, and consequently we
    can easily adapt that function to use the hash algorithm of the
    passed-in object ID.

Adapt both sites accordingly. Safeguard us against the case where the
passed-in object ID is _not_ properly initialized. While this case
shouldn't ever happen, it doesn't hurt to be defensive.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index f8c2cf7a93..7c73fa108b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -133,7 +133,9 @@ void submodule_cache_free(struct submodule_cache *cache)
 static unsigned int hash_oid_string(const struct object_id *oid,
 				    const char *string)
 {
-	return memhash(oid->hash, the_hash_algo->rawsz) + strhash(string);
+	if (oid->algo == GIT_HASH_UNKNOWN)
+		BUG("hashing an object ID with unknown algorithm");
+	return memhash(oid->hash, hash_algos[oid->algo].rawsz) + strhash(string);
 }
 
 static void cache_put_path(struct submodule_cache *cache,
@@ -824,7 +826,7 @@ static int gitmodules_cb(const char *var, const char *value,
 
 	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
-	parameter.gitmodules_oid = null_oid(the_hash_algo);
+	parameter.gitmodules_oid = null_oid(repo->hash_algo);
 	parameter.overwrite = 1;
 
 	return parse_config(var, value, ctx, &parameter);

-- 
2.55.0.979.g7e5102b832.dirty

