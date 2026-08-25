Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7241481652
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668224; cv=none; b=VmlJuTPI80SUEC7axLppzjhEz3Cq0greobIzVLGn483agHjdlzZynIxgE2cBb4/P2bP177Vz4+F/SucVTvMP+m8f35rVq8s4i2u7g4Wj2wjGy0eQOFpm/kJmjvyzTY10ant8G5aL4W3+T+7mcGt3wiIEn0+Nivv0KZQCAKZifrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668224; c=relaxed/simple;
	bh=/44TtHnlhdepxlEm5WkcpOdaQVuc4ClmG8QCW12MejU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFOqcvSUf9g6Cccz97Vw5DTaEmJHenlCXQ9aZu4G4H5Gg7v9LoGfXTUhZ4b9TGnQGfuRVALIfkR9E0fE+pVyrxm6TDuX9n+iI7espWnuP2SeUIqGFq9vKOh6TFlF+iwj3gBpHNnY27qjTf64coY458qqPFWq5U0taxKtmJtUYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LLthxqXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxsnTJSP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LLthxqXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxsnTJSP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1CB37A00FA
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 10:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668220;
	 x=1787754620; bh=DYFPcyxu+W0dDNY/d7iawhNCOdG0YS23WmvzjYmi10I=; b=
	LLthxqXh6Ss+goIg6uwu/SkLM27TuJjidYHrFVJERkFEPC8OvThsVG8LeqhLcfnr
	BXLyxOjnA3Xb5dMIT6MVOd8eLYx9cY/8JGNVGweqHv/iO7JboE/lD7iSOntJ7bID
	zy+CaD4mfyzw5Mj41y99QYAGS0kjkUtNVOwwR0HMiJ+i73MutjEfecD5HNcx69UR
	jJuouwiH9eOVrtW3nOism+LMw45/6f5SwVJUy7+pZKXnTCXO16cRUAcxn1S5PVMC
	tQN9tgGEyPkdatyBTNof7GjMP+mcK1ZrgvNJmo6FG25S6IK4IbHgSHdQk6x4dqjD
	P8IUgP/B5DFm9rD7U6NrFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668220; x=
	1787754620; bh=DYFPcyxu+W0dDNY/d7iawhNCOdG0YS23WmvzjYmi10I=; b=K
	xsnTJSPpX00I7vWFbyKBHD8R/Qk9x6jdZpOz3ZfML9sA0LuanTGPPD9dgvjhOnY2
	L+vl9WGe+IITxxkZvSjF53ZRYED3WNJjE0158WvLJF682UUOLF6paXM/OMkDQcqN
	3FYJavTBYcQiuYvRqfhPPVoTYJ145OPsvK6xP+W2znetYhBBPfjBYPApfO5dZnhB
	tos4DiyrOzNA97+apoWLJdtrv1/2R0Ko5+vQI6nRR0UrgI/EgeY3N3ZC3npiYhDl
	XUh6hs7ePdJ2ik0eEvWV5dLWXBi4Y5LItUPVS2zBNYxE5mSq3izes4MT1XxF3+cF
	SO9GJdYHkgFgsuBkhzyag==
X-ME-Sender: <xms:_KaNaoh5RzrIMRdFDGNwqzerxf75G2x0BQQTGvytpfejaF0xIArW1g>
    <xme:_KaNan8Dn6eaDdxi3MVX2U_v03n2xSpLeRZmeIzWWyToDlY0itH8wEPeNX3loE_nx
    hllUN-sOJCMQnF2-w-_AUB677OMPAcvt641Fh2rkutqP24YdH0YgQ>
X-ME-Received: <xmr:_KaNalsCDxN0sEMytQQVJgM2cP17pjOAOaXxHmSsCXp5TbiOf2h6LUPhYXPFBfxjc2LDH6ORejXn03Yw_XlfcG1MtzmBrGfOEOydg-q4bA>
X-ME-Proxy-Cause: dmFkZTF7di7P9fqeVtKyfLKbViZD7TBnl4srwz5Ve7VQBJmvFG7KMshIDpaCixvYPMRY1h
    MToVw8leZsp6NRTEnNkzR2GbnzhIeSkDMXyz6tF1rPG3WCmPgAfOp7w9ECiJnWNm3qggyf
    pLU70w6A34nyTdJBsTiO7P4+tQsyhOcfD6IbKuN50FcBA4BTbgRys6YYiGRQNZVpKGXBR8
    +Yz6NjycNLVfAEeHhUraj08VjNvG7b1J92ThlgvTW+tWd3AIJZcCqdUSRypwuSKWRIkp/w
    B5AADDwhd0O4ES96La8mcFBQZ+myORW03YyVssffHdRAHA1X5QkXTM5vsOoGZqFrWVlOgF
    vjEjUSW7jWbX6Apcpd9qROUvUNnwlUJpgen+Q6PkMcdkvRM3lY+EGsLlmz3OtddxdffH2f
    0uRy7tWOYnuj8tgFmBuUEbvSMOJkKkGiRe0Muvf0vPGC+6G3HMJawZ+GFzjfK4pG2oHVif
    8dUII847lVZznDxvvlAoq6ZjJ0CJgpyN53r93c7mcBBL6SMNtjp3e01288FWJry9XTk0Yi
    Ngc1KKwRaRvmX2WhPkYBeoenQhgeJc8wuWbseg66elnctlyO2t+bdGXMEjWMwPH2aSaKQY
    StzwEDWXGKxt+fHz59n13nAQnNEq6rakVnhFfM24vTd2Q4AQaFiS99x0yiFw
X-ME-Proxy: <xmx:_KaNauZD2xc8kO4k-bLn4dVe6gcijyq8MgNdJABFYxuXpEVGmUnfeg>
    <xmx:_KaNalqCidRo09noQO7rcsa_tcIdsw8ZSXmIcSxzYp8j0ws8OYii5A>
    <xmx:_KaNaj9JTALV8nXomDVivKuLDWNuy414u6OlQOUNfQU9yr4x7wxx9g>
    <xmx:_KaNak_TXLvj0hakvsg_KPsIkqBuXMfByZTz9NCahEMhPSthAWVhyw>
    <xmx:_KaNathYYCuIfjPwu0uuppHJ5fodHkbRbG5nmnneJ_neZD_5n3DhdZb_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc76ed7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:05 +0200
Subject: [PATCH 03/10] builtin/fsck: de-globalize option handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-3-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In subsequent commits we're about to rework some of the option handling
in git-fsck(1) a bit. It is currently a bit of a mess though due to lots
of global state that makes it hard to see which flags are used where
exactly.

Refactor the code by moving the fsck options into `cmd_fsck()`. This
allows us to convert some of the options into function-local variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bed8481893..5132ff0f15 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -37,10 +37,8 @@ static int show_root;
 static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
-static int check_full = 1;
 static int connectivity_only;
 static int check_strict;
-static int keep_cache_objects;
 static struct fsck_options fsck_walk_options;
 static struct fsck_options fsck_obj_options;
 static int errors_found;
@@ -48,8 +46,6 @@ static int write_lost_and_found;
 static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
-static int name_objects;
-static int check_references = 1;
 static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
@@ -964,30 +960,33 @@ static char const * const fsck_usage[] = {
 	NULL
 };
 
-static struct option fsck_opts[] = {
-	OPT__VERBOSE(&verbose, N_("be verbose")),
-	OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
-	OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
-	OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
-	OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
-	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
-	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
-	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
-	OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
-	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
-	OPT_BOOL(0, "lost-found", &write_lost_and_found,
-				N_("write dangling objects in .git/lost-found")),
-	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
-	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
-	OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
-	OPT_END(),
-};
-
 int cmd_fsck(int argc,
 	     const char **argv,
 	     const char *prefix,
 	     struct repository *repo)
 {
+	int check_full = 1;
+	int keep_cache_objects = 0;
+	int name_objects = 0;
+	int check_references = 1;
+	struct option fsck_opts[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
+		OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
+		OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
+		OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
+		OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
+		OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
+		OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+		OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
+		OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
+		OPT_BOOL(0, "lost-found", &write_lost_and_found,
+					N_("write dangling objects in .git/lost-found")),
+		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
+		OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
+		OPT_END(),
+	};
 	struct odb_source *source;
 	struct snapshot snap = {
 		.nr = 0,

-- 
2.55.0.822.g20453c30eb.dirty

