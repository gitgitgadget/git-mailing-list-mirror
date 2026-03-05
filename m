Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C63822BC
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720408; cv=none; b=D9Ma13BC94xCR6zKsvMokm67PcZrKfhqPddsGn554/n7R9eCrB0gqG/lErInw0OtYWPCjWPqyYsImFYUspb71C68xeoz1eUpDS+OrgQOLJG1XUfq1/G+MdmSv33l+UDIdNILsokGMg36Owvja2gdo5rfY1gfsLIzX/8TrLk4LrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720408; c=relaxed/simple;
	bh=8qsPbo3KRupFWnlSpjSJj9vBQTrqP5CIdZAV6T/wO9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pt1Dx8BYXobRlkvTl3OvpaX/Yg5VwwCvWDiJoyBve8YJ89F7noEyagX+FNxQ02cqEdulxr2H6eMvTR5YjPvuzhcSgpmKwICICkdqQuk7ZWQQPGa4Zez0YsJEVVdsVx88lRXcRaW3Ked8dOTlKrtvZCfJjWfm1vZoeKHIMuxTHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iyPZ/4yy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tE6TJdJa; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iyPZ/4yy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tE6TJdJa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C2751D00173;
	Thu,  5 Mar 2026 09:20:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 09:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720406;
	 x=1772806806; bh=vdwHGJ44S/peQEjNDC+yio+fGhIrPQvrouGGWGiruo4=; b=
	iyPZ/4yydsP0ReA2HN+pQt4QxkqidtJxtxUqWZu5poRY4r0nwiSK3/KJhfvxBSJl
	d0td5G63fCOVeiGGVv6vmpREfb8udhY8QnEFt+hwThHLRajLJRYe/8xmIQVA6RiI
	azExMkK/PmNNs3Q50Ree6XxQE6Youk6lWwZ8gScVUfoJgvIZYbF6LvWguUG3XGIf
	pfVfozkH/+0PdiWpZU0oNJZMRrO1OxOoQQGkqj/4AURZKNQlxge8RxUBELa3vo/o
	v+aIVO36sly6+wHRbbucDLroqkgusVw+HVP3TYG0merhKR/vq1PWCkFmYHtGT8Hi
	Wl+p0uQZnzlpLVbKo3U0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720406; x=
	1772806806; bh=vdwHGJ44S/peQEjNDC+yio+fGhIrPQvrouGGWGiruo4=; b=t
	E6TJdJacdj1Dup7TsERDMCL5PHGrHMVgi2MJEQE4k2AZRQMhg1b/UEJNdpDbxk0k
	g4nPLx2K++kfXCERZympJzxw0o3BDjutongTWDAhCvwDLrDpoC3Zb38kygE+b2iE
	mpB+J3uyhehlorzqOXiJLBAeEUBWxO9qH1J481GekWHZFURlYN7kU7lGoGx1jxed
	CYhDLG5RPv9WuZoAYnGA0wqZIFB//5wXGNN9IuMB/oop3ERFTdDq21P62SNiOO3t
	4LqmW9bjHxLrjcjSjFvw3kTlKwvNeeGF/v7QInkznYsTKdC45EEPoIc617T0OeDv
	9on5TpHaYHjnDVAf23xQQ==
X-ME-Sender: <xms:FpGpaURcBtgN417XSBOWU37iFcqCCzii9bV7OxxDpSF5F8WSyltpxA>
    <xme:FpGpaYwheRswL0_UKCxPUYABHF3fT3TrRPteAaXvpFZ1xOYsaERSuCoxRjhZXHH6-
    Ta72aThnj1CXaE0Dpl7vX130xF0oyBnns9d8UiZ9IsJzlKAIQQTWcc>
X-ME-Received: <xmr:FpGpaW0esUmtlOYMI94gF_yYwhyO9x9ieepEgVKjbcoiiyidI99Eu5Go2oPU_XvZemn41it5CExILLyqpOrKiy3LGqHntiVCJgsDp8SqVRvS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FpGpaW7wW-3oZvV7lL-V_MeNcSDs9jczxzBmWUY99CcyydQ2tDYgbQ>
    <xmx:FpGpaZVo0WBDbtGVf5dW2vcqRTzJHFX7G6CrJRG1a1qGUhP9yK6hvg>
    <xmx:FpGpaVCzEUvKYMEFzkUePa0_rhMAAQphblFPNBZx89YbGUt3B5mEiA>
    <xmx:FpGpaY5MThNEhCXtf4noMl1CvUXbXUEeRzpd8711T2EJmNF4mlsE-g>
    <xmx:FpGpaeWu9GT0J757hPE463OEoPoJmcTsHAciZUQuEOUlzc9tgIl9nX51>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 802afaf3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:47 +0100
Subject: [PATCH v2 07/17] odb/source: make `reprepare()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-7-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  7 ++-----
 odb/source-files.c |  8 ++++++++
 odb/source.h       | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index 86f7cf70a8..2cf6a53dc3 100644
--- a/odb.c
+++ b/odb.c
@@ -1119,11 +1119,8 @@ void odb_reprepare(struct object_database *o)
 	o->loaded_alternates = 0;
 	odb_prepare_alternates(o);
 
-	for (source = o->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		odb_source_loose_reprepare(source);
-		packfile_store_reprepare(files->packed);
-	}
+	for (source = o->sources; source; source = source->next)
+		odb_source_reprepare(source);
 
 	o->approximate_object_count_valid = 0;
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 65d7805c5a..d0f7ee072e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -28,6 +28,13 @@ static void odb_source_files_free(struct odb_source *source)
 	free(files);
 }
 
+static void odb_source_files_reprepare(struct odb_source *source)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	odb_source_loose_reprepare(&files->base);
+	packfile_store_reprepare(files->packed);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -40,6 +47,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
+	files->base.reprepare = odb_source_files_reprepare;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 4973fb4251..09cca839fe 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -57,6 +57,13 @@ struct odb_source {
 	 * all associated resources. The function will never be called with a NULL pointer.
 	 */
 	void (*free)(struct odb_source *source);
+
+	/*
+	 * This callback is expected to clear underlying caches of the object
+	 * database source. The function is called when the repository has for
+	 * example just been repacked so that new objects will become visible.
+	 */
+	void (*reprepare)(struct odb_source *source);
 };
 
 /*
@@ -96,4 +103,14 @@ void odb_source_free(struct odb_source *source);
  */
 void odb_source_release(struct odb_source *source);
 
+/*
+ * Reprepare the object database source and clear any caches. Depending on the
+ * backend used this may have the effect that concurrently-written objects
+ * become visible.
+ */
+static inline void odb_source_reprepare(struct odb_source *source)
+{
+	source->reprepare(source);
+}
+
 #endif

-- 
2.53.0.797.g7842e34a66.dirty

