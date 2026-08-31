Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9203BBFBB
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158792; cv=none; b=L68QHHyTyIXjG8a6XClUe7IUu27Uv90IdDy3a/UjvXBvWJB7K2weGS6WoFzK3GpwHSAujv1BmrhPtJcAAonpvTMDGYwC0No9vobwpa+FZxgaDwsJ3Vi10fvCyWNZnCVu/BHKK68e9okMBMnMipvs2kVHJM1O1TDcDAEtrgTePIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158792; c=relaxed/simple;
	bh=zXhuXXMQ9nnQi78gUztZSV868iGqRjCtzzkK/WidCMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BU7yzIjHxv8K2dc16dOJ/XMrnlBGMuPh6UupUvauTR46XXanV1ReK2jFD30yqFVytaHXObbZYtiEskrYVQBL5V5iaOWE2OPfgBA2v3ClH+IrmHU3ZeoXhoVxay4ZpoUkKUSsKclLz3AoE+8GoYy81loH++rwLcXYTYE43LroFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EtphmiD4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Omyowwhm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EtphmiD4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Omyowwhm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E92D81D00138;
	Mon, 31 Aug 2026 02:46:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158789;
	 x=1788245189; bh=hWSRjDaFJ9GRLWOZ+a/a3gAdPwpNlgHuQlsGRXBWEyw=; b=
	EtphmiD4wfNcLL5b3PHZjRHgG3bHdMKCdAFXYSpQX5Yx8mw/dgFr4BMPxymyDZ1C
	kJDPwL4kbh1jhw9rh2WgYsiD7Fm/FDnHX1N25gIVYjKBpoYQEe8c4nj642PcGaST
	HKjB1o0a8M4HKgNUHBRriPRdUlzU7/4N24+1+QETgNf2//SaLGFm1OkyVFoWJgZ8
	dadIz89KihgRRsCULgqhIWLJMpAf7YSpw/qfrp/gKNnlhh1bMap5WK+ccZdT3kXh
	tLsWlSKgNzHrQGI7XXBk7jE3kxvdRiBZ4P/NbUYVqRWa8il232rj+3VN9IV9+N63
	R4oPZ+F3RPE2FucEIdnMpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158789; x=
	1788245189; bh=hWSRjDaFJ9GRLWOZ+a/a3gAdPwpNlgHuQlsGRXBWEyw=; b=O
	myowwhmnBLgwoZpjTfvENU2mTr8h0YoYt5lkCQQQzKGdra6S2uTxTmzVlDDoo2Lb
	w9g4zVqRuVwbibfoQNXN7yyb11NTN1LTA2dEIs8/CQnmjRQCodIvfGFUvaV1MgNE
	bwBCuXf0ln3XO2Oa35iN7gG0b+C+/uUvp1+22VvV2D8ZycjcD/lUFrIc3EMEFFXL
	VkmNkvbZZK8JC40fL4Ie7ULhj0GUgB/iDak6WwMW3M2zQCChMe89IeW8CczUMGWC
	HWHd9nzEDUrpaITHlBe4XapkUaRyWfUWKMVaXSBKponmfeeWerGDsooycWinOumY
	SmjB2c/HGl5Xrot4Hpf9Q==
X-ME-Sender: <xms:RSOVaq6GluIRVPC3l4l1VvNhwJNH7mkMliaqh5oBnAzquPixkEu-Ew>
    <xme:RSOVap5LE5x5yToA-SC76cNhRZEGMBHX0m3BgSjG04WyZdT7pJXSqUpvfItOcx8ke
    24ZORIXYnzaaL_lEnAA1beoS3k4zXCiDyIxdcyYcvkSaRBRmzcIrCc>
X-ME-Received: <xmr:RSOVanEcGLjMt4INA6_N9FGRBOCxgzubyGzi-h0X8bTSD2iDRgVfu3-SzXBjMAJEVDonXw>
X-ME-Proxy-Cause: dmFkZTGLrLfDR2QysCD1sy02sCIscVXYgf7HnQNb0oRy2AstlcT8j//StZGRQxtK4z737z
    jEkccgktQSvlsoWH51ayjElXLfFiJlE9Ld2yCvQg9pvtZJRb0kuEjfTelMb298HIQ5Sap3
    OR/LCLdgHsRTUOb7siL+bdcMOFnTQzmurZWmfyQxXQ3aPeK+K3gFY+G88APxnURU4Y5rPW
    hkQfMtR+f0D5fYF7sGNl+qsWHb3/ITM4SpBPQfvcBFnrTlTuPZ7aQbNXxajOf/wPRVXwG4
    QPKJ5gzoK1oCCo/ATkfIKod9SoHmei4GGYxeSeqkDxcDnAScUkfEbZ5rhFXJGd1EX0vbTf
    S6G31DewSR5Nm+WXuVZR4ouiPSYjCQ/tb+Cd880gXgaRRK9ewWkgsVXSx9dkOIDcmGsMxx
    FufwibMPk6Wp8R9LrkJeBElvgdMMYkmuFCy25WydMLe2yTeZOIvxHmD9oz0u3tYAo7NiUo
    DvcYZ1gwex2OcDQ+EOVOhWRPAbJnJi6yaLG7bhBzbZHhjoN+e6coI5poR5+p2yPAEfmVlP
    pPsH0+PQk/OEr/rUIOR70UjqX+f10+rexJMo9dxie16b/MGQJS3OPCJUgJRX5MROyhwump
    O8ENgAxyudRfJnVmdv0gmyGScyQQgsYppPpVYZ8eMsxlMFjHS89h1M5Imhfw
X-ME-Proxy: <xmx:RSOVaiTr12na_IQv8ya6Ur9D_g6fmMDl3eNGbT4txX8MNlTUBbIx1w>
    <xmx:RSOVagv0J_UDpSdQHDJ2gGKHF5KUKH2eN7Q760wEg0PNZA4Tga3qiQ>
    <xmx:RSOVahy2AGlgaYqXp8VX_QtJ45E3n9SZo-2vFPZLwz66L7-3syjmhg>
    <xmx:RSOVaq5kT17v2pP7lE2A900iMJLhK9X-NlLOJhw8JLm1f2aiqM-ZWg>
    <xmx:RSOVaoq80eFdQC23tfVNvCWASTOVPuDXp7isBq7aMggFTg3WvEpYfeeM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23c9d7af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:17 +0200
Subject: [PATCH v2 03/10] builtin/fsck: de-globalize option handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-3-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.979.g7e5102b832.dirty

