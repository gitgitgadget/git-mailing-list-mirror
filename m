Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C338A721
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298089; cv=none; b=RHDWb2Ekp7kF1y9zYostTI5mNzrwhQCMyJ0cWP1YM8g6ACg4CoVgzF6/Q9kYOCcPEMWZ0Sm4TwsUVYeU4AA2eVX53xwoprFn/7MLgqCl3wpQyn4teZxPbld6PGwLYvkZ86YhKmYHEJKyJBDtt742DSQkxxGdU6SFd8R1mxqqnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298089; c=relaxed/simple;
	bh=I/ZDTWkvxekn8FYCvZazs9W6AEwAINAm/XHK3GSLWPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3ob7G6z0ke6+mEmQN3GOOmpN5gwMwUpLK1bxpG/JTVUZzJdx++9tpNSOooTiw8Ek95NJlO++CtNOAoppiMbboKDnnnOrhYswMM+V4NQYUJ+/CzFcNSjqxpiMPkglQi0aatThEhGbRHM7H3d4T6rKRNfCHtTdD7lO6HKmp4HznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iJwrhQ2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ms9HqeHr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iJwrhQ2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ms9HqeHr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2947DEC0241;
	Tue, 13 Jan 2026 04:54:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 04:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298087;
	 x=1768384487; bh=YdYIAcvZwr2+MYI7GtucjzpwipIQH4vX7Dh2XysX1D4=; b=
	iJwrhQ2NwKf3z8iuJuaZO0O93x28y968q7v2vPwfGX/XDW+amfi00gxfxVGboqrJ
	QkhbHZGE0xE+a+vV1HqAMUG3OFVb4iU8xbfdrzKMNWSHPgRCV3bAEUm8uU9EEKVU
	+n4RuymtVnMTZKth4iBcDoh/bnmyTQx9YkWZXJvHJE35hvzanH8fePzk4EuEfpQp
	uVqOD+6oPUn8/Ji2Js7icUXP5YNfsCxKXzKrHgWcliCT2Evb/umoFb6OpqwicTVS
	u26h0w8PJfnmkKfvR0pb+st2ho1Dww4iBYcC5vyBcfrdR3Ue2Nr5TTDpGbGHKQB7
	nC9A6N+xKH3fgkUUww892Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298087; x=
	1768384487; bh=YdYIAcvZwr2+MYI7GtucjzpwipIQH4vX7Dh2XysX1D4=; b=M
	s9HqeHrBz32hbyfGGwkYAcET8tQgb63cgyfBUWySpOtKn/gNEMeA2NOjt5/h1e2a
	bElRv73ExHftQXBckLVtWpuofSOs9jFqXP7BkFP6MFnCPclT8es56oJ+/dMJAXRP
	7lREKsaNRIUbZqBW5hkItGyDdSwTUWWuOsLk+9anKLA6mKKkLAxpEPuGfGbD2/Vt
	5y7PUVkGTZWE2oHtlxiI4LRFTDeP/ud5EF7/1N99wKK8EPEwotLXudksfs8Lv5xi
	TPid9EGI4/jKyB8gYdiLg7jY27QjBxmiNiYNEoT7ZzbdYAbfQGUvYPuvqCC5BFQs
	TWI3Ts3kk5G1pVJxxNXdQ==
X-ME-Sender: <xms:ZxZmaZDF4NOfjB_2X8rmfCKUHue_FMrd4GGZ1Qdad_xhup5AiiWYCQ>
    <xme:ZxZmaTXpJOYOM9I1mZo_0_o8vwHuXBj5d6p83sFc5W27AI65Yem0g5Ft4k6jMdLQh
    fFZoPe9ZI-loBRcac1kyg1v4GxZEhw_4pBfWLciBFx6-hrr-u3NrA>
X-ME-Received: <xmr:ZxZmaf8iauKwo0ssEac8dNBhaaUlNxZBmW-NguxdYxeOBzsi4T3CwfaE4DLaEYSKg2j2hB3nsSzqJaiNjlhIXhgNeLhIcE8i4MXehSwLdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehmrghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:ZxZmadQ9ZFryyrI5JkDkWdhwFoKiUlkP1PMGiHjnfk6zCWHSc3wGtw>
    <xmx:ZxZmacRhNarcC9b4Oub2T5XyFcu9buXKJbvLXgtdARfwq9-9huwiMg>
    <xmx:ZxZmaR6KP7ILSvatXPv91u-iUI1Gp-zFplaxeFPcWRzXRJYBbTAR8Q>
    <xmx:ZxZmaZXQZRzupqEqYMrm653yileF6dvByMZgXpc8g81IcZCUDICxiA>
    <xmx:ZxZmaRBKl-pUUpIpsIRfaR-_EtlasP_gv-s-6zEJlnod6Xm4QkB8WRVV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6afef259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:34 +0100
Subject: [PATCH v11 3/8] replay: small set of cleanups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-3-e74ebfa2652d@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

Perform a small set of cleanups so that the "replay" logic compiles with
"-Wsign-compare" and doesn't use `the_repository` anymore. Note that
there are still some implicit dependencies on `the_repository`, e.g.
because we use `get_commit_output_encoding()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/replay.c b/replay.c
index c580a9caa2..ae13b59abc 100644
--- a/replay.c
+++ b/replay.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -78,7 +77,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);
@@ -90,16 +89,14 @@ struct ref_info {
 	struct commit *onto;
 	struct strset positive_refs;
 	struct strset negative_refs;
-	int positive_refexprs;
-	int negative_refexprs;
+	size_t positive_refexprs;
+	size_t negative_refexprs;
 };
 
 static void get_ref_information(struct repository *repo,
 				struct rev_cmdline_info *cmd_info,
 				struct ref_info *ref_info)
 {
-	int i;
-
 	ref_info->onto = NULL;
 	strset_init(&ref_info->positive_refs);
 	strset_init(&ref_info->negative_refs);
@@ -121,7 +118,7 @@ static void get_ref_information(struct repository *repo,
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
 	 */
-	for (i = 0; i < cmd_info->nr; i++) {
+	for (size_t i = 0; i < cmd_info->nr; i++) {
 		struct rev_cmdline_entry *e = cmd_info->rev + i;
 		struct object_id oid;
 		const char *refexpr = e->name;

-- 
2.52.0.590.g1f87b77810.dirty

