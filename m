Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973593BBA05
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105924; cv=none; b=SM8kVR2puJWX0ley+4fM7n8eyQT7CrsQj/0sPfDroa+1f7p5Gt5nMDsX6/XdZSormRVOgQOeUDMf2qIgns95LMvkVPPv4Km7WXIz9Z3hqDmjzQyJcog16+mFVlX6eMKt13A+27qlwqrN9YyKYTrkW/5UPtAbp2QOQBzyTW59OhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105924; c=relaxed/simple;
	bh=7D/16R582nsziwIeV0Y2/5G5B7LeEgsoTmD4fF75lBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GC6d5Td4Rz/ssPQdXUdCeryI7oLoN+t6W/lwCZPKTmbu5PmhR+6Wdl1KG9WYCrOyVMDuswURp3W4TgN5mpjJo7m0u1sQywFytM3f2W+rcvBa4a+S98ptFRqkpnlMixam/i5qcrZRAV0L9mikmjwQ9th2QpH4mc/X+uYJ6+SDEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n+PYfX93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tnocsfo8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n+PYfX93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tnocsfo8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9372214000F9;
	Fri, 11 Sep 2026 01:51:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 01:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105919;
	 x=1789192319; bh=EGhTr5jAQjqB5PCWmQDFgkD20I59+aXvkMChvUA9gHY=; b=
	n+PYfX937mQDKkaaw8hVy96S8zy8+Um5oHhkAE2wp+qvRzxHX0JOpOCn7RZzDCWV
	N7Ef28W+B4rjYYGbjUVf8OjALtZ0QrYx2XirHYGzycZmOTaOz+aQtk6clunNjSDI
	uXOiYYopOHxwpX7Kj3ymagpOW7l3R0sle2WO/ZlG9pAouFDS4t0XyXhpAUr9eO0l
	MzQrHtgw8EX4tNHjWLEK9ZppWxR9z3KADuoh/k8KqQotB63C+lFKO7GCLS8hTLCR
	oYtWRQJJIkM9QltFVHmXyjGfgNUB+7J+XIaYNMwdoFezVRoi34HRBpx/k8GAr0yT
	PzAA85pQVxrcij6MNg4ebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105919; x=
	1789192319; bh=EGhTr5jAQjqB5PCWmQDFgkD20I59+aXvkMChvUA9gHY=; b=T
	nocsfo8RCwtkDJbxsj7+vFEkKj/qQAtHdMr07+TQhsEl5TbKmOXMMxHVsv9CAPGN
	aaSTBo5KJJYUjbnhVox4vkghCCf8AR7IB13JhRwYg0GOAtBxcbFJwZ5MWKvgGbUr
	P/bQUPY7j0DapIA4yiLb15kRJJK51abee1wQxeMiEGxkCtlNfM9mpfy5BxrQ81Tp
	0CXNgPX2Ab1Cx5xqdI1qqHuhytESDlTJPLknxaUv3LfB3QVo2vRJyOJjzA4gIQMG
	E5vyMp3wLhpIZHAmd6yGrV2NXWg350Y/zGTaBnT1qxWZpoLUsjDLjsodAChSItdu
	v8GxTvwYkRpSJaoDNzjaQ==
X-ME-Sender: <xms:_5ajaumsH7blpB8I-4YJuossY34F6m-hm_Y3EcL_bToymHgBdFmJaQ>
    <xme:_5ajatTscyf3UuKS24s43qyZHR85jfi63Q6TdiAgDwXamfV9dlHdFTLmlvSMvnQpl
    GkA3dQ05m_Ar8NtJfWBGkdXYnE0u3_QhnYOAycI8to2xEt4a-ZHcY8>
X-ME-Received: <xmr:_5ajaqBWEFOgOTv8ZMI-EEl2iq1OeZiFJXFNlnnJw52vjYh50nyiwX56uNufnvfaAGQ0zg>
X-ME-Proxy-Cause: dmFkZTFGFEz1AV46mB0H5IUnOtgcTKabM/fOWdn1U32UtnAQCX7C9Kwl1UF/lK3aecPx95
    pwrzbSMo0jFTe4y6M9wP3j4PvyZ/ZbEnXlwcVhCIODBJ2zHPDEgNd6iVKvcXKLFsvGHjJY
    vWs+JOO1zUtcRsF/A4WjHSwr6DdB/6IXCdE8e3Jyy4OKiwY0OVWLq9Z8TBsacm3WsPCloK
    ydyMq7csyq3iJZTpyMsmr5YvZ/wQUfMMCCzLj3JXj48UbmBWjnybLxvLJ7a8U/gD4J8oSE
    nUcFm76zJB8wqT3mqBkmo3OeFknnRDh7XPU0VX9uvjH+wWvsGiO52yVJkRj13Bl6YbnHos
    XRya04h//JUERH3r/nBzcun0LenHdmuX5m09gvMPUb4s4+HTcb7uKrjEuMOhmZ+dCzYs0v
    gkVY7BO3hwPmogUFl24qnvlo16gZmY26Rqa7IGoRkaIMhTPJ0G+mFa3o+5hYV/8y243WaW
    iYzzKWVLQExe1vcvgLHXz/zI6+58gOYxPhcSgthyn1Hw4StgXcDpbYKhygEhBvJ3ufH7b6
    2+QC3+FjOtaS5NnY5Ko+MjAMJlkhEHllL+Cj91LJ71ijqZcmV245vKBKkX2HOQuuzW6tIl
    ME8qD8HuILDwSiayG5E7TtkiJStrbmpVWFgFYaHn1ycQggVIklro7gfBdBBg
X-ME-Proxy: <xmx:_5ajasQlE5B-sL8IZTqqTq87GQ2WqsotP1mtpczVtlzOAllozH9PyA>
    <xmx:_5ajagqoJr_LlOlKCQnzJxY2JnJRdhb-ynEJKEPzNaO0o7bWjMK2Cw>
    <xmx:_5ajamwJOL4s4iJ-5mpVck7ALANHnHiKisWH4VnqgwM3Xz2G_DYknQ>
    <xmx:_5ajatIUthurUBMw2VNZ9PzfzmHtOVn9_EXipcgBqH06o79yetrO-w>
    <xmx:_5ajahRopj94MwxBLtWl7VxMiLP1cp_2aR2iaQ4OZsxtKSXjTkgMamDU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:51:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3eaf422 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:51:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:47 +0200
Subject: [PATCH v3 04/13] submodule-config: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-4-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
2.55.0.1074.ge7621b4bad.dirty

