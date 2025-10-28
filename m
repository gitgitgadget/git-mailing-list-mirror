Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4A3019A6
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649737; cv=none; b=PGQ+0b+SlC6JQnM48jgsg4Tddnykw5pMOMPm5RhiMScQs9tNuHm13e368soJ/GSc3CXvHnmwN7jdcQmD/6VLZuzYleJq0DS4h8oC3PrFDHO8CrZqGeD+onJsozi28fx9AYs/VpTHztskbRmbFBPJ9t8doH7fe3HKfP1HOCoGulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649737; c=relaxed/simple;
	bh=nxQxYxtGB/rp7eowD52Ch/D/Pjem0tGLVZl5gF9tIsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEZQVCkCjOMelN4gie6YWHPKWJeAUMT1h31/Y4OWPr9HvNlUfZOU4yXNtXwc8VTocal6UA2N7seJl8YG6lHbOSuxbWGXJcKqRGjpEtwx7vQLfIpA9NFConvO/unbRurrQshcUqGAZmrBher+AfTDn8ZxylHO8IiX8oCDhs4iUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RwoP1Rm6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqvAypTj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RwoP1Rm6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqvAypTj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AC7D1EC0375;
	Tue, 28 Oct 2025 07:08:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 07:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761649734;
	 x=1761736134; bh=UTGPDgX3uZpN2zSLYOLq4d+oAwpDe63aWInyXyoA4WU=; b=
	RwoP1Rm6N3ADadO8ABNhkWsy2Han2gfUPI8fSWIAaBO7OGZIYlLsyE7h/kiUiaMh
	hdL252ZDaGrgqTptp0EYrLbJeE4qooYNy14n0ru4NN7AOH2AZZegCzTO3LfGQ+Fw
	AM4NPJb9weE3SfgBQ/8BAJQQF8sJsFMF1kNdyyPuXooQglJ714opBmHn6MtK0Lgb
	Ddy0sAGWjAS/veGWqy4RtBreaBb2iHUKA75qqHGudLXur5h8StJmohoAommXbr/e
	YHM7QZjgCw04iaCn8wf7FOUxBfRirnJynXIITRtZbeAsDVOywBXFeWiRYrM5uioq
	wy/9P/gQvbXaCf6nlSk5lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761649734; x=
	1761736134; bh=UTGPDgX3uZpN2zSLYOLq4d+oAwpDe63aWInyXyoA4WU=; b=e
	qvAypTjCsk6CN2AMtLsc9ujBeUMhrrbsyB3pXqnt2BwtGtsQd+eaHcSPcMnWZINK
	U0S/zI5W5G0kwFO22Gve5h+792mhAqgP9B1qSKbeHuh86sQ/8V1rFxHaP1PVJWLg
	p3dkZJy1Txl6R9qJcizbOUm0DK4kbfp+jb2XJtxMvkzRQlI55g1/TCnKcI/l343s
	tnjJlKgT7i4oAIGR0FMCtyLHafqs8gkDMhL/SYpViBbuEXf1zwE+AyG2RmuqKCZi
	X7lmlFCGk09V0ihlIJw1a6NleKokZpIr5vjdmUb9oUhQ7Fe8eDx0Enw9omhas9u3
	MopZcXS+hlcPMqJ+PrzCg==
X-ME-Sender: <xms:RqQAaa89sl8L34RZudGbMHJkYpdeR31cF3eyJnm-NnPgfwhzIiw2qA>
    <xme:RqQAaSJ1dTPSqp9Pxn9XQXnFl20gFJY_7iU-dNrUkeQeP5tmUR1auZgN9iFdzyLPp
    v-7GZ-SaliG4NZKp5BZvOUlXf1zo6ybivPOyRbHOHL43-C4wL09TQ>
X-ME-Received: <xmr:RqQAadZzFRzKwW2HvQjsGHuydfv92VKUlcfOBymUVGUSPQ_CXcWX7cITr5NNndmGWHUcoZR6iKA03oIEZ3YAHzpTFrLr1ZkdrZK0PEFAOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RqQAacIZR4Fi36aVvD1wLBM5zcdBu-5xG8OIh8aDMOPZep4g8jM_BQ>
    <xmx:RqQAaTC_o1EpgHdmWLnMC5d2fzof_gcWck0W9H9m2uo2DHCgX5hkHA>
    <xmx:RqQAaZoIT8tb149JUCm2MmKasrPsR-yNHG_TzgZQ2y3ksMbohFBttw>
    <xmx:RqQAaWgPLHqC1HmHFtBXTXwnv0bJpqXQrv7aHTWbZKDV_a6XJoAPVQ>
    <xmx:RqQAacDewOm50digEd0n7CB5B7xOkQNoj-qWStrbS9sJIrQ7-awcisbd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:08:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8dd465ac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:08:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Oct 2025 12:08:35 +0100
Subject: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept or
 nonlocal objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

The function `has_sha1_pack_kept_or_nonlocal()` takes an object ID and
then searches through packed objects to figure out whether the object
exists in a kept or non-local pack. As a performance optimization we
remember the packfile that contains a given object ID so that the next
call to the function first checks that same packfile again.

The way this is written is rather hard to follow though, as the caching
mechanism is intertwined with the loop that iterates through the packs.
Consequently, we need to do some gymnastics to re-start the iteration if
the cached pack does not contain the objects.

Refactor this so that we check the cached packfile at the beginning. We
don't have to re-verify whether the packfile meets the properties as we
have already verified those when storing the pack in `last_found` in the
first place. So all we need to do is to use `find_pack_entry_one()` to
check whether the pack contains the object ID, and to skip the cached
pack in the loop so that we don't search it twice.

This refactoring significantly simplifies the logic and makes it much
easier to follow.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5348aebbe9f..861fef3f38a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4388,27 +4388,27 @@ static void add_unreachable_loose_objects(struct rev_info *revs)
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
 
-	p = (last_found != (void *)1) ? last_found :
-					packfile_store_get_packs(packs);
+	if (last_found != (void *)1 && find_pack_entry_one(oid, last_found))
+		return 1;
 
-	while (p) {
-		if ((!p->pack_local || p->pack_keep ||
-				p->pack_keep_in_core) &&
-			find_pack_entry_one(oid, p)) {
+	repo_for_each_pack(the_repository, p) {
+		if ((!p->pack_local || p->pack_keep || p->pack_keep_in_core) &&
+		    find_pack_entry_one(oid, p)) {
 			last_found = p;
 			return 1;
 		}
-		if (p == last_found)
-			p = packfile_store_get_packs(packs);
-		else
-			p = p->next;
-		if (p == last_found)
-			p = p->next;
+
+		/*
+		 * We have already checked `last_found`, so there is no need to
+		 * re-check here.
+		 */
+		if (p == last_found && last_found != (void *)1)
+			continue;
 	}
+
 	return 0;
 }
 

-- 
2.51.2.997.g839fc31de9.dirty

