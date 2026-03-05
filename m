Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D4246BD5
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720411; cv=none; b=N5kQlTwWvzUclrZRlbqZ7je8XmCz0hLUgaLkzjgtovFA5N6BQ/6CGV2476NlCTAUDb/DVyZhri5wP6QZXPCv2/5FV5LshiEIc0zmmSTLpTE+TObih4YOdC8yqf7MUBzxiSQQwccLvltiquiwJdA+fZcAWn9tBRMhVKe44sm9lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720411; c=relaxed/simple;
	bh=wGvD6hWbAqubYoDQ6jOezIaUr7ggzq7he4KMr1COoZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKeWLfwAhvEJvh8WBCvDJOopC1SsOBSFC18M7YBYdYRWt+pkz6Z5PRrxHQNvAq8j75X3M7tQVNkdRAZyjgB3Ptz52/c7i3QXkua6362BcU/v+PJcOAQ65DCvBoVhzbi1DKGTgKFkSJuzLwZCSLFpzK7q1C+T53seLhsnBrWznjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GgkhdS19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofqCwPL4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GgkhdS19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofqCwPL4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 674301D0016B;
	Thu,  5 Mar 2026 09:20:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Mar 2026 09:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720409;
	 x=1772806809; bh=9JwRlu+yuElpcYa4OfoLVrGicitDIMZwe0eecRhvRc8=; b=
	GgkhdS19r484CcSAYG/VqtzjZl30PaID2w5d/NVw1OkKbFkKatxH9VpsI9UFoZ00
	kMjFJ20IALimcHb3SIstHl4crlXBieepESLaUw605mE4xhQx9xtUiPrFnu32H5vS
	tR54D3OpiiHaXdCYmbBksPGycJ6g8WiwsCNJacC3nbwS2l8FDxguDBOeYqX66Zzs
	7SJpaWmb50xcPQ8EEDKFEfdTAh/Cx2GtIvJgim+E7NfO/tNWNRHDL+RkthUV+80W
	Kd85UpEUYd7EWyLmlKzbl1O6KQekY/dHT8ZU58MbSI7cduu9C69WHwHtOdg9a+Pe
	v6bLth2sKkMvETaoZmmNsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720409; x=
	1772806809; bh=9JwRlu+yuElpcYa4OfoLVrGicitDIMZwe0eecRhvRc8=; b=o
	fqCwPL49/DceabGcAP8vcClcICB4wjuaVQmZo7Va2t5WnW1pCAoEtehvg/EnjI38
	UP2rBIk9tm9LwygKklTdE7IwEL6y5cjyWgLCazbz3FkTc8winkPzLpLMUN/RumLW
	z9gRWOK7/Y17yFadzIwOdp9hhEPGgIuqOJ0WXGEFLVq8xy4Y5YI0zLJWQNV9+Abi
	C7+NZ0cpt5qKJ6Z4J2gq6+zRg5kWcfKEgDfzOCe2JZ4Ds47aEPoWpkqLdksckBpO
	GcSJw1wgZ1msfMI7JVjeJ/EVMaiDutaKbqoqWigHlF/JRYBtjrk+Bysu4L16w72l
	oP4XVKBq2HaTKGWNQBFxw==
X-ME-Sender: <xms:GZGpaWNuq1kETg4r9az8YBipenxgxeyPZRoE8fp60Zptss-632hvNA>
    <xme:GZGpab-ynTPATVfb-IXYUvpizUFMi6uJq9qzY_8TsgfwmFwG3W4-bBbI580qyMUMm
    62c8eOfLLI4QBZ67LQIdT0JbdnLxY2w6cmkUJlKcLGPTk75CQ1Eww>
X-ME-Received: <xmr:GZGpaSTDuoAq__KLgloOkWR4tbG75D0GVbmhu1OJWj8we9irRNL-_K49j6Q4VkM-sUqUpSD4HuzMJgOQQ7YDbT8uSaF8xOxzEHViKPZsTHLG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GZGpaVl8J5HtivlMxieP1olNiTeDfBXxZm9bSdsq05Ipl7jteOoEnQ>
    <xmx:GZGpaaQd1cQd7CnZn2CVO7MDlhDrQcyYdwZLFMnx3ISsxOtOFExktA>
    <xmx:GZGpabNEJSHt0asrAORn2i9kOX4qY8h5EgdNNAOJUI_TbLP4rjJ3kw>
    <xmx:GZGpabUlhq-q4LAxUjPOHUqJtEfGXu3yOwhT5lmXS8bkz6sXUZa-KA>
    <xmx:GZGpaVy-n4XEsCHU17Hr9DN6ZpZIFDX8QwsX7euc9obBISz8VkyOqg-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51310d09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:48 +0100
Subject: [PATCH v2 08/17] odb/source: make `close()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-8-3290bfd1f444@pks.im>
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
 odb.c              |  6 ++----
 odb/source-files.c |  7 +++++++
 odb/source.h       | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/odb.c b/odb.c
index 2cf6a53dc3..f7487eb0df 100644
--- a/odb.c
+++ b/odb.c
@@ -1062,10 +1062,8 @@ struct object_database *odb_new(struct repository *repo,
 void odb_close(struct object_database *o)
 {
 	struct odb_source *source;
-	for (source = o->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		packfile_store_close(files->packed);
-	}
+	for (source = o->sources; source; source = source->next)
+		odb_source_close(source);
 	close_commit_graph(o);
 }
 
diff --git a/odb/source-files.c b/odb/source-files.c
index d0f7ee072e..20a24f524a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -28,6 +28,12 @@ static void odb_source_files_free(struct odb_source *source)
 	free(files);
 }
 
+static void odb_source_files_close(struct odb_source *source)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	packfile_store_close(files->packed);
+}
+
 static void odb_source_files_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
@@ -47,6 +53,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
+	files->base.close = odb_source_files_close;
 	files->base.reprepare = odb_source_files_reprepare;
 
 	/*
diff --git a/odb/source.h b/odb/source.h
index 09cca839fe..0e6c6abdb1 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -58,6 +58,14 @@ struct odb_source {
 	 */
 	void (*free)(struct odb_source *source);
 
+	/*
+	 * This callback is expected to close any open resources, like for
+	 * example file descriptors or connections. The source is expected to
+	 * still be usable after it has been closed. Closed resources may need
+	 * to be reopened in that case.
+	 */
+	void (*close)(struct odb_source *source);
+
 	/*
 	 * This callback is expected to clear underlying caches of the object
 	 * database source. The function is called when the repository has for
@@ -103,6 +111,16 @@ void odb_source_free(struct odb_source *source);
  */
 void odb_source_release(struct odb_source *source);
 
+/*
+ * Close the object database source without releasing he underlying data. The
+ * source can still be used going forward, but it first needs to be reopened.
+ * This can be useful to reduce resource usage.
+ */
+static inline void odb_source_close(struct odb_source *source)
+{
+	source->close(source);
+}
+
 /*
  * Reprepare the object database source and clear any caches. Depending on the
  * backend used this may have the effect that concurrently-written objects

-- 
2.53.0.797.g7842e34a66.dirty

