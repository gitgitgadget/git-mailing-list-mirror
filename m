Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8F3E6390
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096683; cv=none; b=DmQu8axYNRAU7dV5sW/shbbuWzmdQm0W6hcxM4h04uc5KFZgOEsTAMb0FBJMGX4ipaJcKYKhLikScKWXwIxhIFCDYjJDIb5IXP3HrV2chMy8WvLJybwWww0B93/WOLXqOHoqDj5uTPIk4uS54+ZixqyczoNC7NiGQiz9X9Z5txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096683; c=relaxed/simple;
	bh=SCSwPBjEc1UPeG+yp1H4P2zzxUf7wabtyk4DOcEeCng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWk8LcvtfhQUYsJy+JDZqfdAyp5WV22gZKOREaMon9IbSRxNdr6MYlCMPrpxaIkrp/V6Wz7yVKlYG0KjkjxmH8We2iQWkiSJFX+5TgGbi7Rzih8I5tl1iAnrpN57zo21kPnjoHvvwl6JG53fo84wGU0XboE6qz6CLrWQTxT78ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d53r3l6W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQitapJ0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d53r3l6W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQitapJ0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EE2381D00121;
	Mon, 18 May 2026 05:31:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 05:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096681;
	 x=1779183081; bh=5z3SlYXgqVUwWOrDysQn5x9FO+KUgyT+M2cd8n3029M=; b=
	d53r3l6WegY/6agCaIPa9CAiRf6v7LlGVzvowbRa2T9R0bBPMW7D4TkQZzOSyA6y
	igGfGinBM7peK9hX9iTupQ9PDixKWP/YYvVySDBKjwUZycUFHiYZOuPWvBl15TBI
	6t5VZwRoIEGgOS6ujawqdWVcEmFzPGhH5ilk8nh/Lk54DPiFQm2nLLpGlSibQxuq
	F72JcrDwwPk5A8LY1dJfoItAkoOivjNYJqbqTUyirDK8EPxhojr3lc8RPvj+sL4x
	Q0SBmhVziTZizIcVGWUwpieEtjK4M3/7NEpPMR1d4kfLr5s5Gcp1hlv9ngJ/K6r+
	4xeWCn1fsF7wdSZNDWUF7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096681; x=
	1779183081; bh=5z3SlYXgqVUwWOrDysQn5x9FO+KUgyT+M2cd8n3029M=; b=I
	QitapJ0v5FfJhgINzVoyLkezPKNVOc6oSPfnSvbPPtuJd5kCfMrj5Szylek0Hc0P
	Js9DRPZwDg69NFOinb56ivqoJC76VOAkxRlctThMTgTjLyTvH+wVZXXRe6GHvfGT
	zztacape2bvpKcSXvOAZqWC1nyBlrUVPy9fLb6yNnr7FvPixyM/81OOKM0iPo/nj
	2yyIpl0jvt3myku06I7838bhfog7ilCe5oBhGSHR6Ui/xL09/Gih/XNWE+rXpzbY
	Ux49HYJjaLxpVc859aIJQtpGN4kCKDM0RHUWq/J9JDNINFSifdEl7hZOEIKrqhdQ
	FHVqGldRWYpk1ptB7y2Yg==
X-ME-Sender: <xms:adwKajQZlyAy6hmSmcCd03MIBH2gLI7Tr0VCTGH9hByR4wCaSe4Gbg>
    <xme:adwKarpZFxAsIzLhUJIICzGMcqwV1f9PURrOEBWuADjAOSGH2Sm1c4pgSufdPH3cD
    W2gK15_Gp-BI3Ht5R9zCsvS2xGqq8ijoivJIx2EpSX6_ZYrDAqQOA>
X-ME-Received: <xmr:adwKahLjGHu98sslbzC8WVdZC9hF907vKbbb0LiGFSRz3Gcf46IcdvMPBW2Zwt3xKSrDOU-eNtLGiKw3qz1km-pxXhcjaaHMK_qCez0qew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggrthesmhgrlhhonhdruggvvh
X-ME-Proxy: <xmx:adwKauoE1DvoSKwcCEBsJVLZPzEwtTnNkyjr9ntgb1XzFLAWBT7f1Q>
    <xmx:adwKapwQfp53r5wy-KslaZ2s_awf0xh3df3n5GpjDiNixBEbJQTCiQ>
    <xmx:adwKaiOUZVp1lAjee-DsonJ0HciTB13EAc_VCZDYelQGZ19Fr2OZzA>
    <xmx:adwKau7M1AAxlmckXEjRMJ8mECWFu5XPB3Yvsda4XAf_wN3P2jmwsA>
    <xmx:adwKaq5ZMyOK1EGLZjIPvTtCFhtlE_y1AM1ofC9fmRCKC5NN9yE-gTyu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 642f6f6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:30:57 +0200
Subject: [PATCH v2 06/18] setup: stop using `the_repository` in
 `verify_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-6-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `verify_filename()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c      | 2 +-
 builtin/reset.c     | 2 +-
 builtin/rev-parse.c | 4 ++--
 revision.c          | 2 +-
 setup.c             | 5 +++--
 setup.h             | 3 ++-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e33285e5e6..b0e350cf89 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1163,7 +1163,7 @@ int cmd_grep(int argc,
 	if (!seen_dashdash) {
 		int j;
 		for (j = i; j < argc; j++)
-			verify_filename(prefix, argv[j], j == i && allow_revs);
+			verify_filename(the_repository, prefix, argv[j], j == i && allow_revs);
 	}
 
 	parse_pathspec(&pathspec, 0,
diff --git a/builtin/reset.c b/builtin/reset.c
index 3590be57a5..1ac374d31b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -285,7 +285,7 @@ static void parse_args(struct pathspec *pathspec,
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[0], 1);
+			verify_filename(the_repository, prefix, argv[0], 1);
 		}
 	}
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2fcd6851d1..8fdb75413d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -749,7 +749,7 @@ int cmd_rev_parse(int argc,
 
 		if (as_is) {
 			if (show_file(arg, output_prefix) && as_is < 2)
-				verify_filename(prefix, arg, 0);
+				verify_filename(the_repository, prefix, arg, 0);
 			continue;
 		}
 
@@ -1173,7 +1173,7 @@ int cmd_rev_parse(int argc,
 		as_is = 1;
 		if (!show_file(arg, output_prefix))
 			continue;
-		verify_filename(prefix, arg, 1);
+		verify_filename(the_repository, prefix, arg, 1);
 	}
 	strbuf_release(&buf);
 	if (verify) {
diff --git a/revision.c b/revision.c
index 599b3a66c3..5d53244379 100644
--- a/revision.c
+++ b/revision.c
@@ -3067,7 +3067,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			 * but the latter we have checked in the main loop.
 			 */
 			for (j = i; j < argc; j++)
-				verify_filename(revs->prefix, argv[j], j == i);
+				verify_filename(the_repository, revs->prefix, argv[j], j == i);
 
 			strvec_pushv(&prune_data, argv + i);
 			break;
diff --git a/setup.c b/setup.c
index 4ef6216e82..e673663cab 100644
--- a/setup.c
+++ b/setup.c
@@ -280,7 +280,8 @@ static int looks_like_pathspec(const char *arg)
  * diagnose_misspelt_rev == 0 for the next ones (because we already
  * saw a filename, there's not ambiguity anymore).
  */
-void verify_filename(const char *prefix,
+void verify_filename(struct repository *repo,
+		     const char *prefix,
 		     const char *arg,
 		     int diagnose_misspelt_rev)
 {
@@ -288,7 +289,7 @@ void verify_filename(const char *prefix,
 		die(_("option '%s' must come before non-option arguments"), arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
-	die_verify_filename(the_repository, prefix, arg, diagnose_misspelt_rev);
+	die_verify_filename(repo, prefix, arg, diagnose_misspelt_rev);
 }
 
 /*
diff --git a/setup.h b/setup.h
index c3247d7fc8..24a6f66629 100644
--- a/setup.h
+++ b/setup.h
@@ -142,7 +142,8 @@ char *prefix_path(struct repository *repo, const char *prefix, int len, const ch
 char *prefix_path_gently(struct repository *repo, const char *prefix, int len, int *remaining, const char *path);
 
 int check_filename(const char *prefix, const char *name);
-void verify_filename(const char *prefix,
+void verify_filename(struct repository *repo,
+		     const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);

-- 
2.54.0.771.g3ed373ac14.dirty

