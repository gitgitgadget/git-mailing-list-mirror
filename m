Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1117363C61
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160306; cv=none; b=W8/gNt7GgnM7MUs7+QY7EBk1e8gWyH4g8sfzXVxTP4zXIVcoY0E9Cb6h8SYWXqNY5gRYlxBjif+wA1mdKnvfsTNtyJGzzYuBH3cFl98TlkSZcBbByf0EjZ/b31EbMm8IfRxogh3w1YqKp8StMC+8GJ+GevRwHY6M07aLI6I52K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160306; c=relaxed/simple;
	bh=KzOnvYNVQiSp8lS4AAHeB3XorKalgCHzokiWRJ30DHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfZ4woM1PlG4qbYWP6MdnIrfAVMtgVqMbhkP5Z0tBAz4idYbV9Dm4aW3Z4drMJtKEMzE26g2tYEqpxlRQ0KAogF2uNEIXp9bZgv8p5IyMe/eM+juDAwyQp2l9k8Usi7aavVwYEBB4gZb+Qm2ybBhXAaHrQC6sSnX1rS7rkMBMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lIttJlgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jkt89J02; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lIttJlgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jkt89J02"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A4E81D000B7;
	Thu, 11 Jun 2026 02:45:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 02:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160304;
	 x=1781246704; bh=crOyxTdqU0pZ1ZQswd/kBbvYYhxlTed7W4lXgcNdvck=; b=
	lIttJlgTN7CnNdykeHudGZqm+d/hWTBNEk3eAtAgopl+10Peu3rkEO0Uybio3FDt
	jsIcOZsceImfod1+tFn6mpBqhVZ3kmVyv5CY90I8cA7mqHQx3BXDEvxKv2k72S3T
	Ga2hp44v/JAir88NXtbZAzoEz55mKjoBMiSiCNavsz487d59LKysNCaeeZNtqXuB
	UC0Rtzm2qG2gnvOTGVqt+HpHyDEgdPiXhGBWbG7wlxFo9k2QzUFcvb7TAEqjJKB1
	lSp46tZKqCVc1j+BG1wXy23nrlTH+cwIB3w48dpdJhFlSnRUjhJei8XiQojPR8hb
	R7pP6r5s4Goa2mpMWOGE6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160304; x=
	1781246704; bh=crOyxTdqU0pZ1ZQswd/kBbvYYhxlTed7W4lXgcNdvck=; b=J
	kt89J02z5XmcuhFDEGBNnRZhaQ4OeyzrYRamqBwRwYmA/0ADgJT9volj8FGJdDRf
	EEIJl2bnOBTTX+GXtP8vz8EW9SKKy/5yDzv5o2Z705v4G2cMC/UKdEz5+GgW6Cv/
	kD8/Iu2ARL660+v3cUx50ezvfrMgxJ6JcvRpFl5lRFy7kFos984dyCqM0VXYJpsf
	H+y0AuKX7Vi/3q/XeIHjvxT38bP4ydGt0kGU1HPDxt81AdkLwysY8GzByP1dR+5z
	alomlZeFphB5Hx91QlerF35HQVS/ZgQ+X1HktMgZNWjJ9ofRgVjQZptvaNo+eInS
	EMz9FS2/Ao7W7kCIi6hFA==
X-ME-Sender: <xms:cFkqasp8GZaYkc-Dkokjhgrjt4hqwpiAQFXohHX5oF8VbbF8jP2ydA>
    <xme:cFkqaoo9w93FFnzZjEb6NtkCaZdGwAIk7i8Dv141mg1oCTQbtSX8NIh7XIbDDjjlu
    kSWV6GbTkfpiovOlrRPiqFYI9Py_GMuaByOufW8fLUqa7bbl2pL>
X-ME-Received: <xmr:cFkqau0l7HDXNlTqC2F3t3xiUdMm4sUKveZvgl_Obl1IW_i9XwvwOjeMGTwMEs5zzp036qI0bXwa7S-XwgeSizrHJLHnFgkofpmRrD0Somnx>
X-ME-Proxy-Cause: dmFkZTGxnf0yq9y4CA98HeNL8pKSne5zkerVp0CkwXSsp88a8Al42X8uRne13CjHPHJ8f8
    +Nyf/4ma0cT9+qqnEcpgWtemcGt6PSa2qX05MTkr8CFUnUooJ9M+LqkHqoZPWdKFo/bsyp
    QjZAWQpufRgGJI11KwHsy9cbozlzv30ioNFUKASdq6m8XLKn1e9v+HMG4e20O1zBt1Zqdw
    FX9JHpZAPGdwRh5N7SBR9tDCrZjDDKBJZFiOua2PGAaJiWMo0V8qKOZbPkz1xCCDEpdy3K
    aMZKE66YgH2Z8lowGtpmBXnsmx49Tod4tFLpKzOOiCkk/qvNIpRoQ+3o1Qvr9jkMXmlsd5
    bZ7qnkiXTxvD9NHKgilJlSn69jB6QmwfMcLOyGQll2t/xEIDTCkp/E3Fi3o4oeJVzJrnO0
    9uXUAwjYjfB6ye+pkO5XWR7+hbXAOHAyazYISULYFw8Qb5RKJwbshK2k9Q6NLI+ZFyPLQ1
    BJnzptI/ihqX1GCz2AF9G4Xq2s+//iPgiVJSbWEfkcEN978QvjQFJRS4M2JuioTJqvxCnE
    DEx0OcjwFnjADUhkJoC9ILObIKTF9p9sAL7iPmvHjNJqEdzd/PhtLhOdm2rb44e8nY28Fg
    cGGVCZi71bN9T/YqUWxOG44S5ZUN1HPQYbKmu40Kb+TopIdFV/gCzD8QS+/Q
X-ME-Proxy: <xmx:cFkqavBc9eLDPqj0hXIJGZWGdzZDg0mPXr0IB0a3IJwnJUwRCQtwSA>
    <xmx:cFkqauev_son8e61PgRLdJkLnUM6s4vq6wBCvjxMfEBZVihdK6GeFQ>
    <xmx:cFkqashaBlk_eA9Ge0FbxpgnHLRL3dqL5GpT1rVAhoeUatcbU13J1Q>
    <xmx:cFkqauoJOZnJgi-QiuKrnOk5aOAkX2Xox7kz3ax7tojL5tRcEEadzg>
    <xmx:cFkqama0_ZAmorZmgCmQrVg20fnjvQJiGDcA61sniDPW5W3hQltt7rZT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:45:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7154c641 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:45:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:45 +0200
Subject: [PATCH v2 7/7] treewide: drop USE_THE_REPOSITORY_VARIABLE
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-7-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Adapt a couple of trivial callers of `is_bare_repository()` to instead
use a repository available via the caller's context so that we can drop
the `USE_THE_REPOSITORY_VARIABLE` macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c        | 3 +--
 mailmap.c               | 6 ++----
 refs/reftable-backend.c | 4 +---
 setup.c                 | 3 +--
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bbc6f51639..d0465fb4f5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -265,7 +264,7 @@ int cmd_repack(int argc,
 
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
-		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository(the_repository)))
+		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository(repo)))
 			write_bitmaps = 0;
 	}
 	if (po_args.pack_kept_objects < 0)
diff --git a/mailmap.c b/mailmap.c
index 7d8590cdd6..2d5514f833 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "environment.h"
 #include "string-list.h"
@@ -219,10 +217,10 @@ int read_mailmap(struct repository *repo, struct string_list *map)
 	map->strdup_strings = 1;
 	map->cmp = namemap_cmp;
 
-	if (!mailmap_blob && is_bare_repository(the_repository))
+	if (!mailmap_blob && is_bare_repository(repo))
 		mailmap_blob = xstrdup("HEAD:.mailmap");
 
-	if (!startup_info->have_repository || !is_bare_repository(the_repository))
+	if (!startup_info->have_repository || !is_bare_repository(repo))
 		err |= read_mailmap_file(map, ".mailmap",
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 101ef29ac8..c151d331e7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
@@ -288,7 +286,7 @@ static int should_write_log(struct reftable_ref_store *refs, const char *refname
 {
 	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository(the_repository) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = is_bare_repository(refs->base.repo) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	switch (log_refs_cfg) {
 	case LOG_REFS_NONE:
diff --git a/setup.c b/setup.c
index e6db80ab07..65f4ac95a8 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -2610,7 +2609,7 @@ static int create_default_files(struct repository *repo,
 	}
 	repo_config_set(repo, "core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository(the_repository))
+	if (is_bare_repository(repo))
 		repo_config_set(repo, "core.bare", "true");
 	else {
 		repo_config_set(repo, "core.bare", "false");

-- 
2.54.0.1189.g8c84645362.dirty

