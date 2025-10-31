Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AA2F25F2
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891200; cv=none; b=VBia/1iwEWWSghL/2a17BjozthxPpSvmisE6f5mJCFsTpRGzpFh2H0MEgtoaWRExYkgo+tahBVaFmnS6aNlJmkBD2N96JxB+sY2jOAS87Ci42fRCrG8k/g5wvoKpIDofQH60oeVS6I+fiFxsAXrqA/GeLEKZSQWslrjyfhuIPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891200; c=relaxed/simple;
	bh=UyyD0LhhcyMybUGreDl1qyVCfM6S50XRRAb/35NUEm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxDaFF3z9BbRBEI/vYYNpkdxfeVx4LQ/6YnI8DJb3AO7plDiSJbDORchYYlXqLKy1WYYw04mkHj15pdczxx+f1yLE2NkEIWzhg626GoY49CjG+qA/LI7w1BckTLg9tu1fCldxl6C+0LV+lWcV5+cWKW6iiFAqMkkYLEJqtk/4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fqiHKV3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xqc/IE4K; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fqiHKV3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xqc/IE4K"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D415EEC0084;
	Fri, 31 Oct 2025 02:13:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 31 Oct 2025 02:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891197;
	 x=1761977597; bh=jVQ3KO+vRwBoUVxpt7YA73+TBG5mS3XjcmGXNbv2DrI=; b=
	fqiHKV3+4tO8Ic1ZvHdHornkodNTXonkb85RSAi5lBwI/rZoAuDv24ihYZt6hrTF
	j5TCyDVt6/nPpIPl5fqYfoAgArK0otBj8Nm/rHH04SDo80bLWSeKDOPCk7FjV2Vk
	p1u/6KnGBq6lFwzIPtHJmq/YLnnZl6HLw6kv95rBEwbrqM/1YASb47gZ4tjBRQHC
	jNW0CzZkqbSkTinnP+r+J1r3D5apfgUaNS+WuPF2ZXv+Pgu1esnGyVWbn5WQkGCG
	cE+YoJGcmU55E29r/PLZRHnJ+eLqq8fyrZbzGZ0mKxYBqI/O+m9TcZkQ3Bg/sqZ/
	yaiVIXo6uKsYI5wSxkEhcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891197; x=
	1761977597; bh=jVQ3KO+vRwBoUVxpt7YA73+TBG5mS3XjcmGXNbv2DrI=; b=X
	qc/IE4KOkeC1xqP5mEasjUTVR2Qn2Fzqdo0ZJWWR8nbDYzqLhjxEduTCcn1hzcL3
	W0SwWOFLpPbD3NiD0zhJmloViKcjjxgZvvPsTEOz3X9GuxkvB5BxZ+lQhs94eE+S
	Gnhbn3cNfxL7O/uRrP2JCYgUftUcBnCY5HXKZPCuehKIQVBA9or4KcuJf2AM6zqQ
	G83GfgIwskamIH7MlDQwnUygeD+n5KSGgiIpN6KCuUKef9rsYQP2WVX5RXjitVZS
	X/niJ+MsNyn8gLbhX1fP6KyNvkpr9Z2s/TLegOcEdqar0r7a2XXZWcLZQRRGWcaT
	S0F6rNZHFPUKnVcSVpDnQ==
X-ME-Sender: <xms:fVMEaWxwAkmx6LpZCxq_wLsHfkkJ8Fn1LPwXfq5YhNdjnZq9vJCnCw>
    <xme:fVMEaZvdbEQG4892d2YgY58wXH3thzNg8MG-iiDsVUhu2KozMQhsUP5fHplFa4lYr
    6r3YyJz0InOpId_iN_qTKuHZcv2eRSDK49DJarRIwbgSjvCN58>
X-ME-Received: <xmr:fVMEaVul1doOxtV5W5WZQgiIkVjkD2T-gUrkti3CXwGXzCjB95BLVSA4kdZVIPj_fknktuYZs1RCmfWJPyFljeCGZnPzh4f9GJtuu4GuDcoEsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:fVMEaWOtNWIQAa5qknPZzEI0R-0QX27a1IWPBdUzZ-oiH3ZlZGSrxA>
    <xmx:fVMEab1ARyZEvSaU4GZpgBOt4yqCClxtyvP7D0wkVEuyDgHAqIMPLA>
    <xmx:fVMEaaPfTe86AXDmu3KbrmYSeNHzU7rq4Y2bkDCmpSQO1iEhavz8fQ>
    <xmx:fVMEaT20K83oHwLlUV8Xb5g0bQpBfYKIRGR0FuAX_FoJcmXYTMlmgw>
    <xmx:fVMEaZt3wlevK0q8IQne8Si4P5_a3jzqcFhr2_HRLyEbbXPmg1TaBkbp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c622c03 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:46 +0100
Subject: [PATCH v2 10/13] object-file: rename `has_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-10-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Rename `has_loose_object()` to `odb_loose_source_has_object()` so that
it becomes clear that this is tied to a specific loose object source.
This matches our modern naming schema for functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  4 ++--
 object-file.c          |  6 +++---
 object-file.h          | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5bdc44fb2de..c09cb342ee9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1716,7 +1716,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		 */
 		struct odb_source *source = the_repository->objects->sources->next;
 		for (; source; source = source->next)
-			if (has_loose_object(source, oid))
+			if (odb_loose_source_has_object(source, oid))
 				return 0;
 	}
 
@@ -3980,7 +3980,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			int found = 0;
 
 			for (; !found && source; source = source->next)
-				if (has_loose_object(source, oid))
+				if (odb_loose_source_has_object(source, oid))
 					found = 1;
 
 			/*
diff --git a/object-file.c b/object-file.c
index 64a3d45376a..0255d757ba1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -99,8 +99,8 @@ static int check_and_freshen_source(struct odb_source *source,
 	return check_and_freshen_file(path.buf, freshen);
 }
 
-int has_loose_object(struct odb_source *source,
-		     const struct object_id *oid)
+int odb_loose_source_has_object(struct odb_source *source,
+				const struct object_id *oid)
 {
 	return check_and_freshen_source(source, oid, 0);
 }
@@ -1161,7 +1161,7 @@ int force_object_loose(struct odb_source *source,
 	int ret;
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next)
-		if (has_loose_object(s, oid))
+		if (odb_loose_source_has_object(s, oid))
 			return 0;
 
 	oi.typep = &type;
diff --git a/object-file.h b/object-file.h
index 58ec22d187e..e6daa566f32 100644
--- a/object-file.h
+++ b/object-file.h
@@ -51,6 +51,14 @@ void *odb_loose_source_map_object(struct odb_source *source,
 				  const struct object_id *oid,
 				  unsigned long *size);
 
+/*
+ * Return true iff an object database source has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+int odb_loose_source_has_object(struct odb_source *source,
+				const struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -66,14 +74,6 @@ const char *odb_loose_path(struct odb_source *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
-/*
- * Return true iff an object database source has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-int has_loose_object(struct odb_source *source,
-		     const struct object_id *oid);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:

-- 
2.51.2.1041.gc1ab5b90ca.dirty

