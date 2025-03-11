Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38304264FB0
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728318; cv=none; b=eJY8N1DAGVvfOeJ5C5zCK9gheghuq59Ue4d2F9ZmuaZyAJA+o88IGIDYO++jL7NXUEiQQCuKhCmcOAabX9hP877W65DJGN5uxTVrrcWjnojVPcyp8rnQWRyDDTLf8yCdUVTJNWenY22WfRgmhLP4Q+IwdZpekAvX8DFE019HzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728318; c=relaxed/simple;
	bh=G2/7Z5lhoItwYx1evjzXBeW5CEZJmTlX1t4KvtgVOJE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dsy7C8SWVC9lZo2n0YeS4/7Nq5q+Rg5lGEfByrVRjMoIPn/Sto85+KCZiY1/WOPuoPgHXeExqy7p7U95Txf96sBPQ9fEnmQLTXrq29PzQvkaRNs8OQH6iBWHKJoV4D1gi37AHd59GME3nZ9Arg7/BUZZ25Lt4fcHaEIiympqA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwEwmQc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVCQFl8v; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwEwmQc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVCQFl8v"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80F4F1140152;
	Tue, 11 Mar 2025 17:25:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 11 Mar 2025 17:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728316; x=
	1741814716; bh=+/C4qFhKX9auRgj/DF2gGeWsvlJlW/aCjZyGFZr6CtU=; b=b
	wEwmQc6q7+wPBmqPCr7NCSvIdHU3h6bxIMo2N5qXCkU9kc777sjpaGzLsx0pmpVT
	UzPziaVg41dNyfZ7l6ZOm7aO44XtbgUL45+ZhgjXtC6Q/HVIb9sygt7JHTXXM7tN
	FPEQzPe/83adLtS6LOoFZIXO8V0/Q/DL0n+Fb7GJJqpKuPWAlfJTMq9MtzOPvJHF
	3dOs4zuxKGoDB3LxatxZY5nOA/IRmIPr454YJfoN3M9Nll73PO88idCm/OTSabaQ
	gzyajore7BV/vL1tNNN67PY8UQS0udiZpBdWvDYvgXMCQhC0tOzvyk8yIfQ6Efxg
	61j9KCIGGFHrytpV7QcOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728316; x=1741814716; bh=+/C4qFhKX9auRgj/DF2gGeWsvlJl
	W/aCjZyGFZr6CtU=; b=qVCQFl8vtV49MRYYZv+iKjJpTgNnhjmKRIVphbshbKEW
	g+ejhCmx9EIB1BcNVdBsm8EyCwLGwfuN0GZTjFNutoKt5KLRq4XGbDE6D+cUc7I0
	mzajBtZzqZoW+9cv7yiNVK3W7djdvw49C09+5GBKlyrZbqzkMI8wN1vynZgw+eFh
	dGlOYTs0iVgBP6hYjQf4jg/ZUmHP7rxjBUrMQlwdj5t1ckY0kKt1fZ8ngi6ApOZ/
	iRDnkL6xghxdY/jeePtUl9FBUi3sv9wqs2LZVxQMIwl3oin20UggH70V9MF+bI4x
	ob2vwJQN+OGt2wiEnxN3uW1yB0Uheg7MGAnlab5t3A==
X-ME-Sender: <xms:PKrQZxCrkwRZ8g-cAOKkiADQISc6uvNpoSNu1HNhKPc_a_dAQpKvZQ>
    <xme:PKrQZ_hRRnk7cpCAoDCJ8EedGQz8r8kcHlo_ew9mUmwsnIK_zSsf094XubHh6M87t
    Cp5xw05P0653fELKw>
X-ME-Received: <xmr:PKrQZ8kOlmjSabh4dI7PTNLmxrtkKUmnHU-KRAlxLQAVoXH0SbxdWh7iBAhxHEs3AaPrUGishDTH5vnQHp1O22ZevIM9v_8LeK8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PKrQZ7xNXI1_6UZEgDRr8Um5W-cCO3MUCCJ4pIaH7NWY94FfuLinvA>
    <xmx:PKrQZ2TFtwujINombxQQSlXVY8FiTjZ_l4sCqWW003EsLZ21AxQckg>
    <xmx:PKrQZ-Z_rUm9ut2IQQvGzNKLDWIERZPWvMmvNkxZ8ChS1xFKpU0YWA>
    <xmx:PKrQZ3SqbQ7dBPI_-DWHUgVb46-QoMEDAPqsfiY7w6mYfwq062OvDQ>
    <xmx:PKrQZxebiAbzLZJBn9JFKsswv_KWqRf2rGAxBDcFijPxl7yGSca_oRlH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 6/6] name-rev: remove "--stdin" support
Date: Tue, 11 Mar 2025 14:25:05 -0700
Message-ID: <20250311212505.2920181-7-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250311212505.2920181-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of Git 3.0, remove the hidden synonym for "--annotate-stdin"
for real.  As this does not change the fact that it used to be
called "--stdin" in older version of Git, keep that passage in the
documentation for "--annotate-stdin".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc |  6 ++++++
 builtin/name-rev.c                 | 10 +++++++++-
 t/t6120-describe.sh                | 10 ++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index bdfad29d8a..61bdd586b9 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -178,6 +178,12 @@ references.
 +
 These features will be removed.
 
+* Support for "--stdin" option in the "name-rev" command was
+  deprecated (and hidden from the documentation) in the Git 2.40
+  timeframe, in preference to its synonym "--annotate-stdin".  Git 3.0
+  removes the support for "--stdin" altogether.
+
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index beac166b5c..65f867d7a4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -567,7 +567,11 @@ int cmd_name_rev(int argc,
 {
 	struct mem_pool string_pool;
 	struct object_array revs = OBJECT_ARRAY_INIT;
-	int all = 0, annotate_stdin = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
+
+#ifndef WITH_BREAKING_CHANGES
+	int transform_stdin = 0;
+#endif
+	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
@@ -578,11 +582,13 @@ int cmd_name_rev(int argc,
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
+#ifndef WITH_BREAKING_CHANGES
 		OPT_BOOL_F(0,
 			   "stdin",
 			   &transform_stdin,
 			   N_("deprecated: use --annotate-stdin instead"),
 			   PARSE_OPT_HIDDEN),
+#endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
@@ -597,12 +603,14 @@ int cmd_name_rev(int argc,
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 
+#ifndef WITH_BREAKING_CHANGES
 	if (transform_stdin) {
 		warning("--stdin is deprecated. Please use --annotate-stdin instead, "
 					"which is functionally equivalent.\n"
 					"This option will be removed in a future release.");
 		annotate_stdin = 1;
 	}
+#endif
 
 	if (all + annotate_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 71e261394a..256ccaefb7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -300,8 +300,14 @@ test_expect_success 'name-rev --annotate-stdin' '
 
 test_expect_success 'name-rev --stdin deprecated' '
 	git rev-list --all >list &&
-	git name-rev --stdin <list 2>actual &&
-	test_grep "warning: --stdin is deprecated" actual
+	if ! test_have_prereq WITH_BREAKING_CHANGES
+	then
+		git name-rev --stdin <list 2>actual &&
+		test_grep "warning: --stdin is deprecated" actual
+	else
+		test_must_fail git name-rev --stdin <list 2>actual &&
+		test_grep "unknown option .stdin." actual
+	fi
 '
 
 test_expect_success 'describe --contains with the exact tags' '
-- 
2.49.0-rc2-181-g28e223d67e

