Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995532EBBA9
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224366; cv=none; b=oEwmZDJ4Cl09EFSaP6q06KaP0oJ3YUL+Px1dKr+2wyC14ooteQEnyGQcGptEDSBtlvITwnfiefa1vUj0OE3a8v+J58P9fDvoQtBYdgY7O0qRL2gEXw+PZ2uVVxH1/WDkPuXpJMIaEYlNTPhkwNacIdY39/q0nvir1MjUl/asgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224366; c=relaxed/simple;
	bh=ULSLg1fRVb4gEfgModArehstwZZ0yQ1Ek45SOYgoNYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erzuUmWS49U+1yfynSt4LZ0/DOqGApZTUtWwWHBy6eqbo/e0YYdA8zdTWIyh0Avye89QvA1QINIzuggGBmuds7wcCa+OWdbstewt16zERIhW6nheL58N3fMP38BawOLbdFpoqiNkcMcoJiFxzT4HYfdPKLv/DJ4B9vtQUw4YrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XooHTVy4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9ByVYjO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XooHTVy4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9ByVYjO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 845987A010D;
	Mon, 16 Feb 2026 01:46:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 01:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771224364;
	 x=1771310764; bh=JD8psSd9Q/bXqgPieDtUJvTFbp/X5kK8kvIb/MHeo6E=; b=
	XooHTVy42T77Sim8eh9UQHn2D7JvSxnRuWtnzhd23eKbu5RUQ5d1RRnlNCwieF3u
	MTD+PoanOBCwiXdRwBXY6PAWXfimo/gs9EpmVTAcR48RAYDsoxEfSiDsIesS3nH9
	64E0NdwCln8fE/jZgYf6aUO3V5XznFJR20u5rvQyOlaB1O3T+xt/RX+ON+LHqSf2
	e8MlxToZ3QtYB6IcFDijY/dWBocB9fCowPjldpX1UylnX3I6AF5pEmnUeV8Nhwzp
	kMyqpwQXZeRrUW3ZHKm/ZBlzsPC5CkJJ1kXj1HQ2pSBhxzF6zVRlaEgbuQMuQPF+
	+PiU0SJvUNEUtReM8zECkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771224364; x=
	1771310764; bh=JD8psSd9Q/bXqgPieDtUJvTFbp/X5kK8kvIb/MHeo6E=; b=S
	9ByVYjOASRUXvqgu8JxDW3A7Ygs5u4Iqwux6FGq5QwACOASUqsdhIy6Dn1/jAW6L
	bFc2gx5vA3TGqsOVXdVyYzI5Reo3nX5EhNFwqNsUvfE8WxLVF9NaOtMgSmh1BX1y
	FiN2M8A7zbeWp+y2QwecvDvgfUfsbcWc2Jf9kaArbOLZ5Dw5j8Ypp21GiRqeO+T6
	BhWhKukuOJm+9aOjXSBKuzU+dNmrKDcwklpsDG998tZPUGZ/wx0G4iGDl8HHan5F
	9iTXh+EcfiyoN0a67Hy0tSj56Ac5+uG8A2RKuc3iCZ3HndjD8cHz7bEwn7DFmgt1
	LsxB941Tt1NbAvmRqcO7w==
X-ME-Sender: <xms:LL2SaaWBuyMdSPE3t8L6T0aA-YKuqx5uGCo77kPx6xTa_XYJyF92Sg>
    <xme:LL2Sadkxm6r3fvuJg4z8i-IOgXAb4nnNHUrp6vlRFbtfclpmA4DfeqhRmOlcphgUa
    3lsZKw47WCNQgM5QIO-S-n0v_647uRLwzkc8xTWB42LqBRI0avoeA>
X-ME-Received: <xmr:LL2SaTY906Lpl1yDK8HgRVum3BQlR57j7THpBRAfnpxXbfc9zBpURrXaUxBbDkQr4OFgUWGj_DpESdA4gOeZq9Rr-ym0H6-kNIvgA1mmmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:LL2SaQOi1zcN_veBxA7iRnyLbINgCT31dPwQBblbkjVALWRhtHVslQ>
    <xmx:LL2SaQbjYyRL07ZEJgZfkFdm686_gELq2NI5YLrD4KoAbO4vsISkxg>
    <xmx:LL2SaW1bnQgD5Qmlob_oQLqmlVA4_1bV18i385D0hDJA0hzngEKe6A>
    <xmx:LL2SaefuimEkyCfw9OaVHPFk1S9d7kVwapw6G657Oj0gCoPpgXB6mA>
    <xmx:LL2Sae7C_GNgugYWYRtg-ZKByFoYhgGkuCb3bUBsrvzuIcJaD6SPLIQZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:46:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1d83b4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:46:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 07:45:47 +0100
Subject: [PATCH v3 4/5] builtin/history: rename "--ref-action=" to
 "--update-refs="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-b4-pks-history-dry-run-v3-4-c4db58a651fc@pks.im>
References: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
In-Reply-To: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

With the preceding commit we have changed "--ref-action=" to only
control which refs are supposed to be updated, not what happens with
them. As a consequence, the option is now somewhat misnamed, as we don't
control the action itself anymore.

Rename it to "--update-refs=" to better align it with its new use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc | 4 ++--
 builtin/history.c              | 8 ++++----
 t/t3451-history-reword.sh      | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index df2900ac2f..4dbe665ec4 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history reword <commit> [--dry-run] [--ref-action=(branches|head)]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 
 DESCRIPTION
 -----------
@@ -66,7 +66,7 @@ OPTIONS
 	objects will be written into the repository, so applying these printed
 	ref updates is generally safe.
 
-`--ref-action=(branches|head)`::
+`--update-refs=(branches|head)`::
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
diff --git a/builtin/history.c b/builtin/history.c
index c135361c67..1cf6c668cf 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -18,7 +18,7 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--dry-run] [--ref-action=(branches|head)]")
+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -258,7 +258,7 @@ static int setup_revwalk(struct repository *repo,
 			goto out;
 		} else if (!ret) {
 			ret = error(_("rewritten commit must be an ancestor "
-				      "of HEAD when using --ref-action=head"));
+				      "of HEAD when using --update-refs=head"));
 			goto out;
 		}
 
@@ -416,8 +416,8 @@ static int cmd_history_reword(int argc,
 	enum ref_action action = REF_ACTION_DEFAULT;
 	int dry_run = 0;
 	struct option options[] = {
-		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
-			       N_("control ref update behavior (branches|head)"),
+		OPT_CALLBACK_F(0, "update-refs", &action, N_("<action>"),
+			       N_("control which refs should be updated (branches|head)"),
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 702d40dc06..de7b357685 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -233,7 +233,7 @@ test_expect_success '--dry-run prints ref updates without modifying repo' '
 		test_commit theirs &&
 
 		git refs list >refs-expect &&
-		reword_with_message --dry-run --ref-action=head base >updates <<-\EOF &&
+		reword_with_message --dry-run --update-refs=head base >updates <<-\EOF &&
 		reworded commit
 		EOF
 		git refs list >refs-actual &&
@@ -258,7 +258,7 @@ test_expect_success '--dry-run prints ref updates without modifying repo' '
 	)
 '
 
-test_expect_success '--ref-action=head updates only HEAD' '
+test_expect_success '--update-refs=head updates only HEAD' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
 	(
@@ -271,10 +271,10 @@ test_expect_success '--ref-action=head updates only HEAD' '
 
 		# When told to update HEAD, only, the command will refuse to
 		# rewrite commits that are not an ancestor of HEAD.
-		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
+		test_must_fail git -c core.editor=false history reword --update-refs=head theirs 2>err &&
 		test_grep "rewritten commit must be an ancestor of HEAD" err &&
 
-		reword_with_message --ref-action=head base >updates <<-\EOF &&
+		reword_with_message --update-refs=head base >updates <<-\EOF &&
 		reworded base
 		EOF
 		expect_log HEAD <<-\EOF &&

-- 
2.53.0.352.gd1286b26eb.dirty

