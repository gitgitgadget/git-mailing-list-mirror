Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3653B6BFF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678423; cv=none; b=nAPp6kQ8bliJuQYaaORiU07OBQBQ8oVYrBs9MZNT6TExmZuBf8joqQ/xZ0p4lcX++oGzz6F8mubW8OUQDwtjR+Cz2/A/30idL9b3Vc0BjJ0dot2eyKNi1F+398LaJueNSn9w1FkNVcsQL4DXjYgb4XHdcOxHWZopWPs8BzRRVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678423; c=relaxed/simple;
	bh=lr0iPrlAbvYKcwdYDUN3t3YWB079ChgtaqVocS6K8Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmBbBFQrUz63tMh/9HqpUFUtVBr3Zp6t8xbLiIMNaM/Ee6dbrFmmU8+LlWHCsFLJzeDZAfYgL6EQ3ockgbxQsk7Yu4gMCXkU33o2By3BiQ2aQLwpN44v/wQ7Zx1WHpyb6J7gR2N9TeGE9qfIOZeJNiQ1PnND4bX7cr9TwmTSbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u4Ktghi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jT9V/7S+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u4Ktghi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jT9V/7S+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C0A97A00D0;
	Wed, 17 Jun 2026 02:40:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 17 Jun 2026 02:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678421;
	 x=1781764821; bh=8LBp2zpg9VdUESQambKK9aZKCJgj5NVX8zEjfKzSU8U=; b=
	u4Ktghi8aolATvO2mO7HTRHdxyvTz9ALN6UJlhzDqBldwMnAJuw5Q3EF2MOYhTdN
	jxD/WCz5/rtrwgPuUDOqFWP5W0uhJm8Wj6A7c/ln/31Xyuynb0qDKnm/kwF+pidp
	nty5s4Yd7+7HAtfuR2DU7O3OmzCxhP6CPqaP8noLR3+2zLT74IBWaJ3D83+fLux9
	677Oa0M7NMrw6LDf2VWHFUf4KAS0SDZkeM/tDnFsZ8W1Bv85plTGaTpOx05SytyV
	1l9oDpEHGBxsXFuvO0L40IUH4uDKv9zLZEtMmX+A+rlsD3Cb9PWyqUdgC9VEAbSY
	HvvhjSe24IH6xfEn6N2CEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678421; x=
	1781764821; bh=8LBp2zpg9VdUESQambKK9aZKCJgj5NVX8zEjfKzSU8U=; b=j
	T9V/7S+LoXXuL2HwzeZgOyBrhmAteWJMTXK7bRomwLV7DpwB9tYg8dk1s1lNa3zk
	f2zC0Ldu75RWDi8WC07ftwbTJHhB27Sjz10Qq+TCRsGU54J6YNIWKrw6nD406iGh
	o9UySMNeD4mUfj1vfmju/lYy7l6O5JKexwK7dteMzDlJiEvcYKsC8XXSZIkK0we6
	ZQDRFA89+puhT4fUFCOmK7pPHFxnvWoHrhCFM3CgJOriW8KZyxbiT6unwyNskZIC
	KlhwuYpadDQZJrldObUajLouEqG+B0kJ8JggjJGxKm7H+u/S3R2sPDWhN2atcNYg
	eEmEAP0EnCqCMKHcN6akg==
X-ME-Sender: <xms:VUEyam9nbWFmAKZ3U1ZTqGLJ0m42Bsc1dLAImDn6Twj4HeLCzukrSg>
    <xme:VUEyauK7qBTMAfPDfzaz4RanuSrVDvXB4DnrnP1PuJCbVc6qm1esVKfrjbm7yMR6L
    VOlTtH3AqkMKnmcPVTC_3-45_RG1HfqoEyqhR6X2hoKLjwpHjp6IA>
X-ME-Received: <xmr:VUEyapYTe8lKV0p-L3UUN5u9U4jXalJlef9n6nYcb8V8w_S5ZRmFKZtpS1N50Iw2URc3lZLH7EL5lD5b-wLKPOXjQ2TXMn91Kvxrns4>
X-ME-Proxy-Cause: dmFkZTGR+6fD6sF8kDvw0pfUKwXsPss2g5jLX9LdXMMlmWpDw4pAYwDgH4gaOHBtJ4+Vk7
    gLyAvhs3EZ6KLc5YOFlW5U1JexX5XChen62Ab6OOkAX+Roz5vxTAZP61GgQ/ZhpaNnPl7g
    Z3TBT2tPlfrRkzTm8fd9LBfs7DfcQ0jgrKEIZBXdCs+iU9IvQvvgDtLl+yS7reNy9LgWdS
    pNp3GsSdINDe+hfTG9Ltmn3PU1SyHK4WmiAOi8JEIHKKqr0e7ViJii5y7vOyP0LxEwJ2pm
    XJ2n3KSUsfvpUNalBeIn34RIWpR9v/FZ2Ajlu/ZmQKKhiitSPgJ7Mjwe0zdDZWGIFYfDg6
    81m1uvLHpx3FQ/ThQZMvgskScBumMESHceJlcwN9FU2bcV9pteIuxLE4h9qNMs3abfs1CY
    K/LS7l7yeZ72nnXe3HwBvjEU7W1721YCmd6j8/roHBnOWr+lgHgDqbb3AiwtD/efnLMoty
    9dy62oln/EtOOBOw6LHOGqI3+opYZ/9i1+pPVERUt9/5aBS3ldgN6WdOUauNi9oO1Pcqf8
    dq+FtngSIqcVQXxMtilmqB7fu4vcsq1LEjWaKPEWzdWR27M6I88LZW0pec+PRs8TU2dLRB
    nnKsakY9D455vzeiGDDm+XeQqaaDc9U5wsK9bZOlm39ikmp31klntj5MAUeQ
X-ME-Proxy: <xmx:VUEyaoKeEmiaTUFK-JY58PvZy5JQwzMa3ktKeH3DiGo6GcjbAZcAyQ>
    <xmx:VUEyavDEj1CPCNbbzP29SJauT5MuP-Wc5iS1pQ9WxayJhRoVbJBodQ>
    <xmx:VUEyalr79y8nrGDAlbeDUxLVnVxZxeanzlNMEYDxnR5po5ln_MeLEg>
    <xmx:VUEyaijrM2niwjixjQ7y1PNLpX1PFCHIUxz2FMTWa_6cof1IsONdyw>
    <xmx:VUEyakkC6hao6KoDTjLOvqXS8trfeG3T_wajknP1YO2H-yjePtjEcGmV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90941407 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:53 +0200
Subject: [PATCH v3 10/17] odb/source-packed: wire up `read_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-10-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Wire up the `read_object_stream()` callback for the packed source and
call it in the "files" source via the `odb_source_read_object_stream()`
interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 16 ++++++++++++++++
 packfile.c          | 12 ------------
 packfile.h          |  4 ----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 8cae35d25e..dff69d0e4e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -67,7 +67,7 @@ static int odb_source_files_read_object_stream(struct odb_read_stream **out,
 					       const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
+	if (!odb_source_read_object_stream(out, &files->packed->base, oid) ||
 	    !odb_source_read_object_stream(out, &files->loose->base, oid))
 		return 0;
 	return -1;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index f71a194739..23d7149fe3 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -2,9 +2,11 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
+#include "git-zlib.h"
 #include "mergesort.h"
 #include "midx.h"
 #include "odb/source-packed.h"
+#include "odb/streaming.h"
 #include "packfile.h"
 
 int find_pack_entry(struct odb_source_packed *store,
@@ -66,6 +68,19 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
+						struct odb_source *source,
+						const struct object_id *oid)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct pack_entry e;
+
+	if (!find_pack_entry(packed, oid, &e))
+		return -1;
+
+	return packfile_read_object_stream(out, oid, e.p, e.offset);
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -275,6 +290,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.close = odb_source_packed_close;
 	packed->base.reprepare = odb_source_packed_reprepare;
 	packed->base.read_object_info = odb_source_packed_read_object_info;
+	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 29530532ba..42c84397eb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2658,15 +2658,3 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 
 	return 0;
 }
-
-int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct odb_source_packed *store,
-				      const struct object_id *oid)
-{
-	struct pack_entry e;
-
-	if (!find_pack_entry(store, oid, &e))
-		return -1;
-
-	return packfile_read_object_stream(out, oid, e.p, e.offset);
-}
diff --git a/packfile.h b/packfile.h
index 25d458beb0..dd97684e70 100644
--- a/packfile.h
+++ b/packfile.h
@@ -124,10 +124,6 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 	     ((p) = (eack_pack_data.entry ? eack_pack_data.entry->pack : NULL)); \
 	     repo_for_each_pack_data_next(&eack_pack_data))
 
-int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct odb_source_packed *store,
-				      const struct object_id *oid);
-
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a

-- 
2.55.0.rc0.786.g65d90a0328.dirty

