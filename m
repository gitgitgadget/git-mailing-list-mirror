Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF13112BA
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591598; cv=none; b=UIS42oKKp4ouhXOE2rAm3Ay/MmbPGsyctRNFp48Z2Y3KiVCVrGHrgIj2W/q0vkK/kKvBRS0z5GsxoHBKmKvWmGuUOP9bZeFVttBCRDfYpM8jWyuCzWsQBG1NvaNJgrEq8+VXhApJ2SHYH/XCITx8Df8MfDqUQEPYTugVTyZrs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591598; c=relaxed/simple;
	bh=aq9q2WdDJ1yhtSYX+VPrHhjhnqQ9SnfFp2KqwlCPabs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QD8GAaduPOpkKQj19iZLmLWgWQ1GjzWtztTBRgYFCs/7+RimrGsjU+9Eq+NjUjzXcg6Y4FsZV/MRPLZUGTDkXj2DR5rg2wL62cbc7W0QVH1TvXsRLUC18TWf3qIxPlbij/ShXnnlYZN+0HPleaKkn4x9XOgWrP07LghKieDYTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ORYn4VnW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQ5Y1GV0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ORYn4VnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQ5Y1GV0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97AA07A027C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Aug 2025 04:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591596;
	 x=1755677996; bh=x3gY6IEwkBsuR2uYGmv2daCygA8Pchrg85azRUsa2I8=; b=
	ORYn4VnW9o0yeEqkkv80XLPv2mViU32GJOljjFIWI9X4IG+GdGY5JI9sIb69psvD
	aBmMVXnoUl90P5NS1gHdKiCvlOvKlMDYLhe/naVa+nq6uwDDFQWMcJ8XWU4MEgyW
	C00EWxGkut7QreQjc9mLvXXHKIJ+YWO1zIdJB4o2XuspJ0dSHzrsrOGudDXREK8H
	UqgNeX1TWOZU80B7AjhSo5f8MISVbv7Q/WsbjxwuTvUYu/vLTybcGqoBVgpkdnmR
	NvvGYUtp9CpUjQsw+whNEBSo6YIKR1y45GFBdu+9gbaPXMotQGlHIfZVCmC3R8rO
	J+UtOjmSQjD/cC1DBydnZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591596; x=
	1755677996; bh=x3gY6IEwkBsuR2uYGmv2daCygA8Pchrg85azRUsa2I8=; b=k
	Q5Y1GV0pAL1C5cf70BgbIgfOHh0hHcWFd/q+IXyyfpWw6FSge3LhUX5+cR7+2YXs
	VEQvYj5G4kjhnyrhlI0gApmmfNL+GzZBMju4vCkle5IfT5jdaTfP1egSlBIQC9o1
	07EENAz6aiZZVd1RzhTHnWTawq+glhyTmBa6UiJGyFEKQAPH3O+4KwKIZG9Stcmy
	ktlo/L87ZCqUN0fFhR+B6XKb6Aq4YTinPJWW85ofpW/3DjTBXVZQa/mWFnEDyWKg
	PqoPSZbzT30Z6ntdKPCSk+MXjXE46+Z/AEG/4apY90KA66YpGLxJjAFqcYqiPPAW
	DsEpVAL0M0PljY22CTpqQ==
X-ME-Sender: <xms:rDOkaKymLEn6NXtNCrlBhPVB5xk6O27f3YzW10Nw1ZN4VRgnYk6AVw>
    <xme:rDOkaITqc5A_GlcDGj83axfeqTBu8jJD1WapHLwR956I6jqj4_7PiuLP44ELFl5FK
    JCshYRRlZaRGzjqPg>
X-ME-Received: <xmr:rDOkaFvzMrivActqh1ScHCfVXk_Pf0YEPXcAKBstQkvHlo4y-iVm4scVbi8H-x8kGhv7HCAE89cKc-HV6V3Suz1St18rKsI0Ha_VPqdhRmj1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:rDOkaCtVXhf1tzPJc3R6nrlp5ZWvSe3ketHpS2g0JgkeHswdvFjowA>
    <xmx:rDOkaDzS_ULm8TrHZnq-EwwpcMDIh3gXHAOOegzdECoehoBeCwRZdQ>
    <xmx:rDOkaAh1Q3epgFPyU-dyxJCveOKL6hO6Z2HicEouWBNAqYxYlsQHQw>
    <xmx:rDOkaPCj0Q7a85r1EoYy9vm6BBlZeFW443NSd9uz-5UIsaiwcF76gQ>
    <xmx:rDOkaNoaRTWYg4H6biR8zOiLmOrema443uxlSwSdL9pVkjwLgMXLMBVs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72be1b86 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:36 +0200
Subject: [PATCH 07/16] packfile: reorder functions to avoid function
 declaration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-7-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Reorder functions so that we can avoid an extra declaration of
`prepare_packed_git()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 67 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/packfile.c b/packfile.c
index f33445a5ff..99f2d20812 100644
--- a/packfile.c
+++ b/packfile.c
@@ -946,40 +946,6 @@ static void prepare_packed_git_one(struct odb_source *source, int local)
 	string_list_clear(data.garbage, 0);
 }
 
-static void prepare_packed_git(struct repository *r);
-/*
- * Give a fast, rough count of the number of objects in the repository. This
- * ignores loose objects completely. If you have a lot of them, then either
- * you should repack because your performance will be awful, or they are
- * all unreachable objects about to be pruned, in which case they're not really
- * interesting as a measure of repo size in the first place.
- */
-unsigned long repo_approximate_object_count(struct repository *r)
-{
-	if (!r->objects->approximate_object_count_valid) {
-		struct odb_source *source;
-		unsigned long count = 0;
-		struct packed_git *p;
-
-		prepare_packed_git(r);
-
-		for (source = r->objects->sources; source; source = source->next) {
-			struct multi_pack_index *m = get_multi_pack_index(source);
-			if (m)
-				count += m->num_objects;
-		}
-
-		for (p = r->objects->packfiles->packs; p; p = p->next) {
-			if (open_pack_index(p))
-				continue;
-			count += p->num_objects;
-		}
-		r->objects->approximate_object_count = count;
-		r->objects->approximate_object_count_valid = 1;
-	}
-	return r->objects->approximate_object_count;
-}
-
 DEFINE_LIST_SORT(static, sort_packs, struct packed_git, next);
 
 static int sort_pack(const struct packed_git *a, const struct packed_git *b)
@@ -1099,6 +1065,39 @@ struct list_head *get_packed_git_mru(struct repository *r)
 	return &r->objects->packfiles->mru;
 }
 
+/*
+ * Give a fast, rough count of the number of objects in the repository. This
+ * ignores loose objects completely. If you have a lot of them, then either
+ * you should repack because your performance will be awful, or they are
+ * all unreachable objects about to be pruned, in which case they're not really
+ * interesting as a measure of repo size in the first place.
+ */
+unsigned long repo_approximate_object_count(struct repository *r)
+{
+	if (!r->objects->approximate_object_count_valid) {
+		struct odb_source *source;
+		unsigned long count = 0;
+		struct packed_git *p;
+
+		prepare_packed_git(r);
+
+		for (source = r->objects->sources; source; source = source->next) {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				count += m->num_objects;
+		}
+
+		for (p = r->objects->packfiles->packs; p; p = p->next) {
+			if (open_pack_index(p))
+				continue;
+			count += p->num_objects;
+		}
+		r->objects->approximate_object_count = count;
+		r->objects->approximate_object_count_valid = 1;
+	}
+	return r->objects->approximate_object_count;
+}
+
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {

-- 
2.51.0.261.g7ce5a0a67e.dirty

