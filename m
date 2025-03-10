Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADB1F0991
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648623; cv=none; b=KTN8pyurSJ+jjj6Jl7tAMBxEw/XTCGhd0ujBPg3uxKWTNugVYifLylZAAyeylagk79hpDdiOhwbaCEmxBPXsojegbnGokIv9g3FGmu757gzsRlT/aOIlX8md/rLY0KQ2+kNc9fv2qNNojmMShL9gpYL1SwLFuhDnuzMbCnodupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648623; c=relaxed/simple;
	bh=n0271dI+mqJqih8xEW/ojnNzohEwVj4a/UCztLL+dM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd2LQZS8UNNqriJPAfViCxxq4pBm6YA6zqQ8KnyG3MHViLipfE3lK+KON/BGiveSsFJjb3XFQ37yLAtfUbLqsJVd9+VA/LpXKVlLOoBI03sMnp8q2iVQvS9UqFZgqkD7qGb0eCCM0K9h4XCWJ4haP0jCO4BVNmV32e6/ALAnI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ML019+Rp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7y/qL2CR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ML019+Rp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7y/qL2CR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 73D1B1140238;
	Mon, 10 Mar 2025 19:17:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Mar 2025 19:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741648621; x=
	1741735021; bh=2wcTrmozMzmNFpCwSKMwlDGaOPyPFEl0qkGRYWcyyRM=; b=M
	L019+RpZOF+4UAh3MzfX5VA9UVYd5XmEAB/99pwwSSphTdkGfFqGeasX19b5oxaq
	Hb/oUrkdgvnc9+X8Pa/k9BYUDUKATkXC4lv3pXMp9AW7BzRmVwqoqqqt2bo30HNY
	meoOYI4q8J8UWuZUjR74rQHsyMeqp7VeLi9qmjsMAm/Gb91tX3s7b2rZVTPLm6a8
	Xl7fwYR2BuXMfXlbP/h3lRESltQRIdqF1pK8QjMikfmOfeRfHZnP1EZ5OV9RmesX
	UGgKAqgK0Et8378lzssuDQ7ThEXvBXIVrJKwdJbop6oAeilLEtmGHJPdz8c8YOfp
	bjHxfE3GIIJsL8L9Np2GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741648621; x=1741735021; bh=2wcTrmozMzmNFpCwSKMwlDGaOPyP
	FEl0qkGRYWcyyRM=; b=7y/qL2CRUjKPW+tQEmzmp35jJuKTKLiJdbdpIbxTSNbX
	vtO8R9Dxl93WO2hfg5oJkikYEmSnPxC4MzMtoTAmjJ3sFACVGmO6NybarBTL1Lw2
	GBy78NpC3oEprnPOlKCyfD4ffOF5fOSbTULPrLQZCfPbROOKBlAuLtmmmWGi1HwP
	7GwLdIu1dNBVFWF44BZz+Am+CG1XlXKHgGbHEb9xhtOFnSvNkBPKlIXhQ5+yUVGc
	vLm/Bp2q9PmiFHa+4ycb3TveRh9b75o6/i0hJ4F2c8HSmpVMOaS3wdpdvf0wl+iT
	L5nJqGf/cQ1EQJFQPpoTPOX/UQukfkDwf0gtmqyP0w==
X-ME-Sender: <xms:7HLPZ6tIk6zF6fELQxzP4UtcXq4qCQjO6EaBh6EwSMAP1M58HxMbzA>
    <xme:7HLPZ_eumV33E-J7eHbSnHmTWX7MzL4i1h9wNfzGNyPnJY1tTZu2nB19qN7Y6GmC-
    JInieMViUM55vMIuQ>
X-ME-Received: <xmr:7HLPZ1zBtWLtPpe-djBF9IZR2Sjbxvr-M8H43Sngz0feXbGCUf-1jMJwqmHVd83O8EOOKPqMAjnzkU4CHzupcRtYYDmkxw1vMY98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7HLPZ1Noz6CzoWAh2lURqGjmSALZOPAkMhRg8ISxXDjAvC-XB4Pr4w>
    <xmx:7HLPZ6_B0TLVt8ooa8UFYKLkgUFrKqD-4_2TtUj7zIpd9NN2WVkPLA>
    <xmx:7HLPZ9VNjee4EI2oSPG21kl3ep_udSB7etmBaPYPyvnOTQpZfECudw>
    <xmx:7HLPZzcTEXQXVm9oM1qvRw7qynft8bMurRqAhZb_GB9mP_6hdMrziQ>
    <xmx:7XLPZ8K1a0DdnvMIEuDdxO-KfZu7f8VWcQUpVIHP8QXuW0ELwWHBDnYN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:17:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 4/4] name-rev: remove "--stdin" support
Date: Mon, 10 Mar 2025 16:16:52 -0700
Message-ID: <20250310231652.3742490-5-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-173-g4d16673c2b
In-Reply-To: <20250310231652.3742490-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
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
 builtin/name-rev.c                 |  2 ++
 t/t6120-describe.sh                | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

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
index beac166b5c..3f49138551 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -578,11 +578,13 @@ int cmd_name_rev(int argc,
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
2.49.0-rc2-173-g4d16673c2b

