Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B83382397
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074635; cv=none; b=be6S8HNXmij0KLerPOusngnh8b+OZQ/nBk8xFRfu0CAKIG3JUPhrVo5/LIYlkhymUkxHg7mxcrayuNpo+nCMdHQjsKnBsWkYx2rQ0/lbgZKam2a9CpcFXih+a1aMk6fuDcvpUV/oaEP1mhthxH4g8IG3Ypp1t+V3RdgfEvFZb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074635; c=relaxed/simple;
	bh=TMzqZgioyIfU5ZC3oSsKg+M50EYdVBzTvtBtG+JGiZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfcAS9qJ38b2U3vaFsDUJfVP1vlvEY4Xgub7GOXBuEqObzJLzp/ThT2SlaFyfnuiiPPhCRHIE6BoGYScef0yalhk+020jHXe0jquDITnV/akzI0MBZluFt1r1l8AbGj0tL4diMtMClaJzSD43N85HzCVLiXFgIpwLBONiDqdKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XM0ccpUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxBsaSRr; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XM0ccpUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxBsaSRr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DE4001D00041
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 02:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074633;
	 x=1781161033; bh=LsrkSGJ/z3TggCj/gTD1iGuXjD9W1CatospArHB6HCM=; b=
	XM0ccpUO7FhrJX0fI1eGGxQ/Gb/QlIFrQrZNR6dqtxI2tG6xeGcaIm6Yx04ZqitK
	TXMHp+EdWca9t6iX/I64VUdxR6yw1Bttc/p7iP99R4YFPzidMixxK455WY3jAXJa
	4YBQpgpw+xeGTYHqY4G+vEKqzX8lUvY0FweChp5VGMdfNU0jWdspJkdjmh1FBemE
	u3P7A4bn/v2vfONDtE0gqvanmbiC8iKMkeKuqQLJW22gYZvsBg5xzRPCPoGQXGa7
	EM8wOqZ4/ocv5bUhCLFiNaSDy7jQOzV95NC1PmnLe7NDLUGkOZfFgg5GslmjvUNl
	cMleHWQmoWhw5Q6aQVEalQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074633; x=
	1781161033; bh=LsrkSGJ/z3TggCj/gTD1iGuXjD9W1CatospArHB6HCM=; b=k
	xBsaSRrAFLQ7mpZcouJvF1TcmPIEdZjFbH/P1JW1PXRJx3DareYZr8a56GKN33xw
	jZM4P0D0cC6Xu5WTMWj9pwYAq2SGzdd2lDre5dvzxnJQHbIJObDaoM3qPK2QbiFw
	Q9vfgWfpIWX7aESKtTy39LEiV7QxWbpRi/K5U3ht18M5Krw7SZvEBw6BjnIKw5xD
	unZBbmxtcxDp/pktdhgoKORwvzyjy+5Oy165TrPxXFxG5L86k/vIeZrUfmZzBciL
	2TEvlEOIzpxMsHCvteOYv/2YWO38yZ0XtHiAj11r1tt4IaShoKRnsfPqUL7R7kG8
	dgl6yas9XzVy/T4tCiT4Q==
X-ME-Sender: <xms:yQopajHpn8LMSs_MQjmzQ5UgbpCVk8SuU_sL0wLW-IVDt9wjmA-Vjg>
    <xme:yQopanRkZKczM-MJ8DKvzaZrxmoQE1ZuDwC0VneNVMo3fQ5da7KaT1CmZItfg12w9
    MkHjRWyD5vlPWtApcB0hDq7zghZRdxqeQ5ON_9Tr91srOTQKpStWQ>
X-ME-Received: <xmr:yQopaqxoESfrz-A0Ew_bIyDARL1l1c7CNAlOIB7_IC2fSgNrxrKkTg3b2K-TXv6QTgEyPxG_EXl-ReGK-8pNDg2oM2tCGKTP5Bj0Z6ENlg>
X-ME-Proxy-Cause: dmFkZTGgu8I9aylij29lUivizh19NuqJQIQPHddW/UL6vdKeSywxxCdKJVnMhmCoJwN26z
    oS3qVh4If98YZLDQ6N2TawrqcN/lDbfH4RyofQhruGXytK10gtMFWoalioZuMWPakTzJ+X
    J7/i+qhv6lavr55z9XBjJx8T1A5ATS51gNjWW1yehNxtd2SLuAi71eptf/BYGeuxkfBwxu
    GwhbgOFZXuNGvVtpMntj/fs/WEp8A7dxByfi94/jfetZ3BneTa4KWetdmz3JXKkZg8orCl
    c4gfru2TXj+IF8rWLSyixOnrNSwuVhn1wFHl0fSTzM9GRMuEjHW7Y3D5jNu+cz9/TTWaMx
    mm0Mc7a9k6fr1iFaoDsx1wgX9syRCecDcReCgFHdjn+3tGtq429HS0JflnJ+jSRkF7Rh6W
    RCip9go2kLJPONgugXGWKrfJNrnIYD3eSXibeEj5cOAd2bQZ7Fl+zsoXnhFZ+ASo0Cn5jz
    8pLCUC39v/C1jjoBMSF/fjM2kSkm66YSu1IupsoYd6o0fbF8BsIuj+WRmsvdyzvB0hwjnl
    +2M7KWpE76b2UWZi3OquPQylP94GMvE2YYjgYpwFJhQnJyDQWZCW3pdNgxYFgyjWyMtMKW
    O6fTBzpMg2ZWnYk1eB/e4gwaQ8BVwJkzJ7r+o1Dw7Y6ewPwn3Ujqb88kctcg
X-ME-Proxy: <xmx:yQopamOaeVWfQbfEX4XpMKb9rtECQfpU6s-FUgmt7W6RqtlJyQxbbQ>
    <xmx:yQopapOj5HN49KF7nzo3IDHSegs9SjHQh3-Qk_-_Y-OHIJoQg7A0nA>
    <xmx:yQopaoSkfsrI0_l5UzDA-C2F-88cAswmYGnvcpQC1djphNvDhj8glA>
    <xmx:yQoparCtaTA_vn6X68yZ5cHmD_q0Em8oWfsdPw7p1ZfyaFIvvleOcA>
    <xmx:yQopapVI5R3vC082rE_tDJVwWs4CD8NLueWXUomKaDoj_u98zkifzOMs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f69526e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:57:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:52 +0200
Subject: [PATCH 7/7] treewide: drop USE_THE_REPOSITORY_VARIABLE
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-7-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 6b95bf546d..f24a805658 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -2604,7 +2603,7 @@ static int create_default_files(struct repository *repo,
 	}
 	repo_config_set(repo, "core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository(the_repository))
+	if (is_bare_repository(repo))
 		repo_config_set(repo, "core.bare", "true");
 	else {
 		repo_config_set(repo, "core.bare", "false");

-- 
2.54.0.1189.g8c84645362.dirty

