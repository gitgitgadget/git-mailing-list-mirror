Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660262BD030
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503250; cv=none; b=YjsMd40xe2w+AmtS546fKSl6XsNglqY7Vo0uhscB0x11pvJ+94FeOWARu7/a5Qsz4Ytx9GBNp0Rl/lefmgCKvP7YUS1GkzST0g3Tl/U7OIj6Hrrdoyuwp1eZWZn86yDfxW3+5Av/lfT/FMuw5kwsKJqVEQlyOgtLKZ59UB90zds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503250; c=relaxed/simple;
	bh=GGrj1r1DzYJ3cL4NWlT2gbiSaQ+8Zz1qWQHJziC7gkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/F0Uj31Rb3TbBqKbo3JTCPlk2xmPvSIe3PsdB5d7gj9yJH09poJnzw35G+R3sf/xroBt4L7IMkfQS5ywG0VKiWHgxT65m2nUGx8G6KIzYS1g+8Y89lOJThJrACYkV7de2UQRULm8XzMwiOUuoeUYpc3+JxkjU+3DCGLq85xtI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qQGVD50r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcGcYwRl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qQGVD50r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcGcYwRl"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B48777A0079;
	Wed,  3 Jun 2026 12:14:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 12:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503248;
	 x=1780589648; bh=7CpPTZwpaBHO3foz0QJVh80jOky0KA/0n3xObVdzCxc=; b=
	qQGVD50raaGUJXGaAe02T3aUgdkmZlhACK7jOnj4V7m2Nsb+AodNPnJItwq0DEln
	P2aqadUTyaHHcYor1un0GPa1ysFVFDCsSMQvWC0utNUd2fu9V9BsxGYum+i7pXN3
	pX6lqcehOlaDWX4nEl/zH6ZYjr/DEvZzQNsVt9cIUl9WvPLX2qqELrp9Naod+MIb
	tF9qesac39gY/acL80nVcshaaFKW0t9bIONZ3PkZwK9VrpOvIqWWxNw+KFEgVlfU
	9nqzuzZbflvXV9nghAzuqkIAtSpnWIzqEM4cHLtOniZVBaeln9ZpOFND8itEr8GR
	jhfU/tl5+/+j4uYu71o3lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503248; x=
	1780589648; bh=7CpPTZwpaBHO3foz0QJVh80jOky0KA/0n3xObVdzCxc=; b=U
	cGcYwRlTMbpsCeB/DuLVaoIejD66WVsrgP9la5nhDBNYxVWJ8+F3J8DA1A2b4063
	hJ7+eHcZjVZwVwG4XvkZGnIhhe4tx1Ur14YIYuMK4dLL3B3KQLsVD7DC0KZXbiLM
	GzPRX2QVqV5t3wJLKfJweMOqvJnZDa7w0Blc6GoQqbR36PTN85cdC/akriQWCGcP
	BLcyBg4J6rdhZumlNEgI9IM360GN+abXhfbn7LXaM81/RouvkE2hHv0azwidwnS3
	v0rxnEbOnZxffKNDmdOu5NcS5XnMFgwZgvyH046ySg2J2vaIkXeIr/MtwkSoNqCJ
	yV5yHU/EhXTwzzI/eHkSg==
X-ME-Sender: <xms:0FIgarIL3cdCedUPGkNZXDufbaOEXpD2tAajqoaPLpmOBwaeFQG5JA>
    <xme:0FIgamneiYd7Un9LxS1WW55JdwQz6_8Ok-e1yAT73ubA4ScFY5Zyp7rYUibQ0hjWY
    EtYggX0gF3vLT9ssFfZhtj0yQ6PE5PV5dtU6ApZj4LCENAIojPqng>
X-ME-Received: <xmr:0FIgahER0N7-N6P0fMU2TzXDlP_VskDKhRxPgM1dao6ufQYOpStU6tLCLFbsy762V4L5d4i921yNzY7argDQoRCGU8WGW4helTYG-GThGt-U>
X-ME-Proxy-Cause: dmFkZTGdlIonfplKpFXa/+DN5l0Fb2humCV2KDAOVEKyP+YPvmRBKflqZmkwAq9rePEQEk
    tFWbGVHfEKLtOw94e3kwwUvfEq/biapgD0LFxEGjNoceagFbAdw8S44lP98A4A6KSEBzBI
    FK/Zaf4iM+7r9UuVe4A2HKmR8OR4YocvA/6wxorfK7uRUU2fV0yzyhSTCXmRlDtYfcUpDj
    W3y4seHxmmHClyvMTnpX7w52yD4rY/DK178Gw1HIPAoq8c0YVNdlYew0Ju9pKEwEpdY7jk
    aRnqh9h1yCWlfj/W0CqUM74g6F8iUs+FEHBRjFPLTPipkR6XYgqphPOg5F7L6g8vVu+vYB
    U6zxL4EaNL1crJw3uEVWhoHmzQSwF11CooGnt7mbeKgwZpl9pdX8DIXcHCKESn/PyKl4zU
    iWYUxWsLZVXDVqXQw+bFJBT8Zl4sMl7EWUfBZOu4M/YNnLseXnB4WOtiLxADkRwQLNPyx1
    Qw1qxYRaVEyWSrhG1JrUy58385ANwMSok7itj1ocSr22c0pczWJekH+HsLpqXmuY6smcvo
    iOfX6JjA1n/EfNr6Y/uk0o/6IY2G+ZzoOo3APHAymhKvom1QzNmUCb7lygvQZy9sfDyQJF
    TewiDSbAPOe2yFe2duxzNDkchV5xPuW5l49rI5xpdDDlLzhrX0AKsidUVqJQ
X-ME-Proxy: <xmx:0FIgauENYzBVEa96GlMQu0NnwXF19rrYnTWXptSAhW0s_Buko5Do1A>
    <xmx:0FIgamOKcuzw1uzkEkR30NQVcV7X7LQqiW1TYpgCPwnRzN1eqpY2yA>
    <xmx:0FIgalFf7wyNsQgjdMwBoOS3BgexEM23y80xrrNarq29PNpScSjtSA>
    <xmx:0FIgalNlDRyvs5K6UhQZvwYkwTVo2yugECJeoFJBeR-NdlThRT9AtQ>
    <xmx:0FIgaulFTWNXuij-gWA362ICVi_cS30aEJ32e8fxKKsO7oz-PwO3RC_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63633753 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:00 +0200
Subject: [PATCH v2 1/9] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-1-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In `repo_read_index_unmerged()` we read the index and then drop any
unmerged entries to stage 0. In a subsequent commit we'll want to
perform this operation on arbitrary indexes, not only the one of the
given repository.

Prepare for this by splitting out the functionality into a new function
that can act on an arbitrary index.

While at it, fix a signedness mismatch when iterating through the index
cache entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache-ll.h |  1 +
 read-cache.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..71b87615eb 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -309,6 +309,7 @@ int write_locked_index(struct index_state *, struct lock_file *lock, unsigned fl
 void discard_index(struct index_state *);
 void move_index_extensions(struct index_state *dst, struct index_state *src);
 int unmerged_index(const struct index_state *);
+int index_state_unmerged_to_stage0(struct index_state *istate);
 
 /**
  * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..799a5bc719 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3403,13 +3403,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  */
 int repo_read_index_unmerged(struct repository *repo)
 {
-	struct index_state *istate;
-	int i;
+	repo_read_index(repo);
+	return index_state_unmerged_to_stage0(repo->index);
+}
+
+int index_state_unmerged_to_stage0(struct index_state *istate)
+{
 	int unmerged = 0;
 
-	repo_read_index(repo);
-	istate = repo->index;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
 		int len;

-- 
2.54.0.1064.gd145956f57.dirty

