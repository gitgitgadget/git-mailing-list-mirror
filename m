Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBE3148B1
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784213; cv=none; b=XrRjj88lGTSbLUlG1lUR8PdDIGD3wYsDsaCQFpk/GgWe72SbduIgSPi18wN4HDgFx28qAHJVbHh5q/d5VK5LydJV+EQantmRAKUAbjfcpUOhM8HdPqAceIlsOaHPRblRxIWrWV5MQgU5UqBAivbTdB2lzAMYxPuf9B6+IqLv97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784213; c=relaxed/simple;
	bh=yiq8G34pyar6cvTytkgxeB/0/Um2/KUJauGLSSz4fEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zqd6Xi+w8VrOS6EM/tuTh0+fzAOXNZoOtBhuGOqZc/1FQt4ZXg57gY5oZLILrF4sGKddVqwYscUJ221im1kSncWQICfjXTs7L/iP3g5Ze0Opi4jSu6EZIh/tKva8U2zeYx7bG20FkoXdmLsEmKf4eKczni0wMLG0J6gJwqjPjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZrLgfPTM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8gXgdws; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZrLgfPTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8gXgdws"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C2F0140013A
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 15 Dec 2025 02:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784206;
	 x=1765870606; bh=OVgoSiO4WeAhVVVmv0bSYc8Lkzq0fgjt4oJ61cqJyzM=; b=
	ZrLgfPTMGbKfKOzGMKeficS8WzlbW1Nhnjxd3N6Zgt03NRTcAIvFxEeLiA7wKf6C
	smNCHvLmE5YBbhBfaML1VC+q/P9JfNb45DOgYEQmftDVCgpKUOY/fVk8abt0RC1u
	JVfOonAQI0vLDqgcBuL1HnKQUl7jSARxAZBtppybRARLZ3mf6eT2+nEhATzLGLPi
	dHBEg9ZeadGVkply8JUyuYoChBcaiOoVC133f+nleDQ1uHNPCzF99CZoMyNjwFD5
	Wnw4Tp9oqsB2dCH6cCD8ZQlbSP01X3WevAWysCBA1GlSU98/g8hjuU3bwsSxDN3t
	PRxvLLdQZQLeTHmlKCt6vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784206; x=
	1765870606; bh=OVgoSiO4WeAhVVVmv0bSYc8Lkzq0fgjt4oJ61cqJyzM=; b=j
	8gXgdws3pEVqL4aSBlmomXYxICr3oQa/zZcc3dr8P/rV+NkPoeJGFQRpC36rigL6
	xVZjnzZlbPgcNEy095ysCQ4WB9eFDutDuIlM0C+C5COKn20em63DN9ity9ZJpFeH
	uoDoHe00JOkN5/n40j2cr5TAnmpdWQRULMsVkR5BZ9g2CKrhe9AxEUyM+O0Hpv/i
	Spt2Sgx90skPuhmWU1lgR6SspV8qe3FdYGLWqAIj/HiFp7JKrPo9Lq01VTHA6tpy
	j1kVsMMJMwZhnw9zS89B/uLeneqmX/0c5S+VjwCqXNUsCsJMjEeAwa4lZ6kkBPCy
	tzzPb8G6D8NQoHTUurWNw==
X-ME-Sender: <xms:jro_aReh8rnFiWLrj4Lj7BCU_5WJTvZoJLkQw2D4-0yZybTFrJZZJQ>
    <xme:jro_aWJV3UJp5YUOGLkolYWI9NePptrNItiye2sxStxdpBG4vFYF8en2C6vq6_JO1
    lzATZYWwf3ItNw43gG2iIHiaBTn_X4v2jA4WmJa2vGJ3sIr1lHb1Yg>
X-ME-Received: <xmr:jro_aQLSbYE-mvxlciFKC8q5r0KNW-anGU_tCD6q_-j7svnQJTlshZfeb9eo4nGoU7ZwFcmGJzfMZ1t9vcIDTGmgGTNyZ39cAMVCM92D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:jro_aQG4vYT4Z70a2ROdJvZZY8qYGH-jfAv3cm8xy5L7Llx9Fn-3XA>
    <xmx:jro_adkzKRg0epswF7yfbWDSkn9C2WI1nMNo-yWUnc5QgsI18QEA1g>
    <xmx:jro_aVL21gnIbn6U5HSePIKfKNqrqVqYPHqoZ1mwWZ4Cnt_VWjXq7g>
    <xmx:jro_aWaWa5BmfhfwyiWCthmrZJYt-IdvcrNH9p4J87UMZXengIJWRw>
    <xmx:jro_abMJBFJB4eyoQl28jUj0Lix2UgWEYiLr4JZeNun0a10yJ1XVe6Mo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1631f915 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:26 +0100
Subject: [PATCH 07/10] packfile: only prepare owning store in
 `packfile_store_prepare()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-7-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When calling `packfile_store_prepare()` we prepare not only the provided
packfile store, but also all those of all other sources part of the same
object database. This was required when the store was still sitting on
the object database level. But now that it sits on the source level it's
not anymore.

Refactor the code so that we only prepare the single packfile store
passed by the caller. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 14 ++++++++------
 packfile.c     | 19 +++++--------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4855b871dd..5b8b87b1ac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1213,12 +1213,14 @@ int cmd_grep(int argc,
 		 */
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
-		/*
-		 * Note: `packfile_store_prepare()` prepares stores from all
-		 * sources. This will be fixed in a subsequent commit.
-		 */
-		if (startup_info->have_repository)
-			packfile_store_prepare(the_repository->objects->sources->packfiles);
+
+		if (startup_info->have_repository) {
+			struct odb_source *source;
+
+			odb_prepare_alternates(the_repository->objects);
+			for (source = the_repository->objects->sources; source; source = source->next)
+				packfile_store_prepare(source->packfiles);
+		}
 
 		start_threads(&opt);
 	} else {
diff --git a/packfile.c b/packfile.c
index c46d53b75d..23d8f7cb93 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1063,16 +1063,11 @@ static int sort_pack(const struct packfile_list_entry *a,
 
 void packfile_store_prepare(struct packfile_store *store)
 {
-	struct odb_source *source;
-
 	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(store->source->odb);
-	for (source = store->source->odb->sources; source; source = source->next) {
-		prepare_multi_pack_index_one(source);
-		prepare_packed_git_one(source);
-	}
+	prepare_multi_pack_index_one(store->source);
+	prepare_packed_git_one(store->source);
 
 	sort_packs(&store->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
@@ -2098,15 +2093,11 @@ static int find_pack_entry(struct repository *r,
 {
 	struct odb_source *source;
 
-	/*
-	 * Note: `packfile_store_prepare()` prepares stores from all sources.
-	 * This will be fixed in a subsequent commit.
-	 */
-	packfile_store_prepare(r->objects->sources->packfiles);
-
-	for (source = r->objects->sources; source; source = source->next)
+	for (source = r->objects->sources; source; source = source->next) {
+		packfile_store_prepare(r->objects->sources->packfiles);
 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
+	}
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct packfile_list_entry *l;

-- 
2.52.0.351.gbe84eed79e.dirty

