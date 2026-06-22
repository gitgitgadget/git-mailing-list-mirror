Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491335201B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118091; cv=none; b=VEIX946GyUeqDoLEZxz/C7EhGx20KTZXN81HWiX16H6OwgL7WrNjL+X8wNxKfeDC5yc5XCxHLMdFJlzfNJ6Z/21jBoKwK8hjMxplBBgBnZcLn1TVb8+dsxEsobeIoyHTJYRTji6KWy101eDRn8Q1BinYmZgxgfCwyK20oHgjU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118091; c=relaxed/simple;
	bh=vrO9e9SYrUBnkK5Tu9JCFjsk2c+9eIdTwUNhSyUA4AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9FE07/xlTwXXCb4kpPux9oIW0kgRXB8s69z9A7GLAeF4QLGUF2is3prZd01ehbEHeDVKTr6yeR6bYSdKcxoEWmgfLJqDYZHE4W05CdQA2Ss+PAZQPmvF1/JbMnpcgvHdLvbz6oTnw/GNMFsCvGPIGKCwVmuvuAxB7euZmkKimY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W94JengO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VF669fhQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W94JengO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VF669fhQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B86E1D00099
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:48:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 22 Jun 2026 04:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782118089;
	 x=1782204489; bh=VGiQBO0RKo+8CKUz2Uw99iayMmgyUNrjCU5D+MURcEw=; b=
	W94JengON35Qr+0JNtsFcA+Yd1hjGdnNKYO/926CwGgc6Uj17IQEfQOXj3uavLIe
	BaPBKcdGopmII+pTTDUaknURLx16o+ZT5Cg5q22c6cKj061HTkazLEsuHaQBQGUK
	/scxCW5F74rOqqXoPtgu8y3EaIh8VA90H1r/SYzbZsRHta+5CCGnNiMXlVek6vNs
	DvblSbRkRe+TliHmnsRvAAaFKhSDuGH3pcyS+YF5AkkMay8JrChGCQvHIgUdbZMX
	F8bbxVElHMDP3zAp5C8EZoWofjwZOZvXFGTwviNnUPN0gCPsoig+rbZmuzyRUxqa
	6AMPLUtLu1Cd2YmGv7LLtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782118089; x=
	1782204489; bh=VGiQBO0RKo+8CKUz2Uw99iayMmgyUNrjCU5D+MURcEw=; b=V
	F669fhQ+qF7h58s1RGB+28s1+SBr/TMClF3iGa7YzYfXB6gIDOcSpBkUNoqp2SmO
	AewPBzGh2jt2FKCCe/ivlc5+GlIJ1osKEya6qSc20VAcWDMXUxHJgnjaVZZA+jFF
	4a+zF6rDrPZ3+H9RTsy42e6Kozg5GUniS0K7DWKRQ4VN900Y293FUiGiEKBHSkKK
	CO9WqYBKCQrCHJOJYu2KhFLRXqu4TpTeicvvlTYObPOL/Lj+uY9PDy65NZniyPyX
	3/PrFjLGkbX1/4E7eEcj2YJ8CspUgfKgNwO4TEG++4DB680iXiV4Lllen107UeEf
	cCmhY12Jg0KulLy/AR03g==
X-ME-Sender: <xms:yfY4agv_uCQ9Iww2b0FSDteQoBKmORYTjem1rXwL4IeNKOhAC-8Vcw>
    <xme:yfY4akaOrCbkOz_Rv2PDHT11wJEqzy3lyc-qcAyoFOuKhxx8N_oU19HaafHb2pqK6
    N8SY7yOqCcgIfmVrS8ORM55ZsLeqEYuFuGn7wylvwejhq6IAjnxtQ>
X-ME-Received: <xmr:yfY4ahbj9de-ZdgnOpqwgcpBUWSjui1kVnvcjLpIDIBuBblgZT6rG1BzfK-COTQ1i5_ULUOG4UKl6IiEY9jird-PXYsBFCbF_8Nen8d5Ng>
X-ME-Proxy-Cause: dmFkZTEOnajbKOjPDvzPIuSD6qi/CT4lxSKsp/grLoo+rkJBbIcbiK4GoLKyEODVuxYFKg
    Ua9MbapOYi58Bwzv0rDKaK6aGXCi6K3Uz/d7bTlu9te/pFqeZJ5TRoWQGRmLd1dVxgWmZn
    Vgb5EZZVJvJ7qbDwBkxlUt+c3nBAZJfAOe1r5YwrQDC5mIEpZTlaU1wiLGLBIVUJjiNYCX
    2PYvpXpc1EhP64Lnq4+sbRWpC+xDeUMiWDfLVCnHJN89DHIvNVfAIOZrKlZEA9lL6kicKx
    eUU1+iMrHMbXepB5nnaTwyeDj8GM+uEqMUbUnRU83HO6B8ETa8cKoDaUfnYHdN+vdmxeM0
    Gssrkm+no5PQJh8K2hnx0thehKj5PaV/ArppWfCLf4QBs31Zw/4V+/JpSurpEmFgt5IZhH
    lwP5qiSRQn1mknzqXjKgcxfJxgPtRDb4Cp0iJI917PycIMIQR2Z067Sv4Hi7Skof6StNtQ
    iLZXdLQUug/f7WWf26lV4ERtKcTOgOEBfasVhURzBNzWNyjOfCWK1WpTz4iz5sU4/3cuQW
    5dw59v/7UDr5CAfSmuwaqFYKz5JYT2p94eStC60faWJ04wYfMakEGmLhDS8tUE2x5hAPIq
    uwVdBlZ0XpNQ1eo4+CK/xgfbxQFWqeuJhd1+G7CEdTY9n4ohwfqiuZwgZP6A
X-ME-Proxy: <xmx:yfY4aoX1dLKobmkh-yFvaA7KmJ6Y7I9VfIbaXQUWqHCv10GYZUS-9w>
    <xmx:yfY4ag39Il4gN-NvOqcGaBf-SPPpx6J4lt-LZEeCel8P0713NZgjng>
    <xmx:yfY4anZZ5tP0fct1DJNd8pYb3hqWmCFsfgfwzh8hwiXKodWHr1t1Eg>
    <xmx:yfY4arokOwlfbGvcU7bOiDdhso-CsuRw7cLKsw1iSAwyK2XDs1ik7w>
    <xmx:yfY4ajew1bvBcslHwNQ--Cfj8-ZjudrzklRmMFW9-3LFQq9uYgpPHiPi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:48:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25c773da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:48:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:47:55 +0200
Subject: [PATCH 2/2] odb: introduce `odb_prepare()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-odb-generalize-prepare-v1-2-d2a5c5d13144@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
In-Reply-To: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Introduce `odb_prepare()` as a simple wrapper to prepare alternates and
then prepare each individual source. Adapt git-grep(1) to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c |  9 ++-------
 odb.c          | 18 ++++++++++++------
 odb.h          |  8 ++++++--
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7361bf071e..a7252d56a1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1356,13 +1356,8 @@ int cmd_grep(int argc,
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
 
-		if (startup_info->have_repository) {
-			struct odb_source *source;
-
-			odb_prepare_alternates(the_repository->objects);
-			for (source = the_repository->objects->sources; source; source = source->next)
-				odb_source_prepare(source, 0);
-		}
+		if (startup_info->have_repository)
+			odb_prepare(the_repository->objects, 0);
 
 		start_threads(&opt);
 	} else {
diff --git a/odb.c b/odb.c
index 7b45390e12..11414c49a8 100644
--- a/odb.c
+++ b/odb.c
@@ -1070,7 +1070,7 @@ void odb_free(struct object_database *o)
 	free(o);
 }
 
-void odb_reprepare(struct object_database *o)
+void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 {
 	struct odb_source *source;
 
@@ -1082,13 +1082,19 @@ void odb_reprepare(struct object_database *o)
 	 * the linked list, so existing odbs will continue to exist for
 	 * the lifetime of the process.
 	 */
-	o->loaded_alternates = 0;
-	odb_prepare_alternates(o);
+	if (flags & ODB_PREPARE_FLUSH_CACHES) {
+		o->loaded_alternates = 0;
+		o->object_count_valid = 0;
+	}
 
+	odb_prepare_alternates(o);
 	for (source = o->sources; source; source = source->next)
-		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
-
-	o->object_count_valid = 0;
+		odb_source_prepare(source, flags);
 
 	obj_read_unlock();
 }
+
+void odb_reprepare(struct object_database *o)
+{
+	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
+}
diff --git a/odb.h b/odb.h
index c14c9030e4..b1c0f3767b 100644
--- a/odb.h
+++ b/odb.h
@@ -133,9 +133,13 @@ enum odb_prepare_flags {
 };
 
 /*
- * Clear caches, reload alternates and then reload object sources so that new
- * objects may become accessible.
+ * Prepare the object database for use. Calling this function is generally not
+ * needed, but can be useful in case the caller wants to pre-open individual
+ * sources.
  */
+void odb_prepare(struct object_database *o, enum odb_prepare_flags flags);
+
+/* Equivalent to `odb_prepare(o, ODB_PREPARE_FLUSH_CACHES)`. */
 void odb_reprepare(struct object_database *o);
 
 /*

-- 
2.55.0.rc1.745.g43192e7977.dirty

