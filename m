Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0683E556D
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096676; cv=none; b=Bfp0Di4l+Oz/KO75DJxyk+RZjlFLRx770nLueavmr1tpCnellYNSmPcqqqkeFAN8QulwPvMFISz8rR7yQDoSxrzum0kyO9lNc1Y4Yw6iuTCKNsVtOmd6GjTh8IrQ/3TUWfgMQFOpAabSTF/GqI2fJVD0iDFWI8p+AOM0cSMXluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096676; c=relaxed/simple;
	bh=/CDYLFCsFAf1ttwh4n3WRX/xTFVj4+rS+p52iv1aT+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jfzrl/NLl54zgbJZh/94UkGtjjO7rdat19WVDuo5d95GOySuKhZ+5j75+SVsqCLx3NnfDLb/qTMhJzlkuvHxZksLgtgeWvdHJhq0Eaxqak01c1sK2LzouogNvteu5ALodyjIL36F0vPqBFoqg00ClCY6bY0YVTVlqOATnj1MmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmKqwdEK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6vCSqy8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmKqwdEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6vCSqy8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F02B7A0133;
	Mon, 18 May 2026 05:31:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 05:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096674;
	 x=1779183074; bh=FICEfSn9DT2REk8ccwcT/tPFAQhr8b1cG4V+ZsrwNr8=; b=
	OmKqwdEKe2yZ1STN6wTxh5Vzlo/uhX8949oipw/hbzOK/u+iBK9zwv2gPlFIltB+
	fYcqEy4FD/OkdezwQdNTSOpzr3+d8EtUMubMOvdfnodkJvT1VF1sUc7dH2vAmJCw
	2am7zo/Mfbv7enVQmHK5CQd9NDefHapBo019esFPdcthFOCXwxa1u6VMZ8QN6k2h
	3ToT79w0L7c/oulVa/i230CWvBlmHxQEb9/ckoZrA5bln3NthwMHjVHtpAbhEk26
	Zz6fopBOPgTNj2mDAWMGrlMCi4LuPLK4zVLW2CTOqcbUJBhBlCMJKChuoeMLcoil
	mSoq0Aurzu//i/iX0CZVIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096674; x=
	1779183074; bh=FICEfSn9DT2REk8ccwcT/tPFAQhr8b1cG4V+ZsrwNr8=; b=H
	6vCSqy8GahkELGr8cWGKvaoE8x3U9F+gGanJzaZuivk3cr3EUmYaVRutSoA4dABE
	VNBKhjXNpng8m7arubnbdwlNvZT2WznHYwQrvDlCD9/EXCOUnyWbzhJV1lHIFTDR
	CkowjLCW0tPdixmmP4cktLdBOdiMsrOBDBHxdxx5IEW7/1tZsVJOBd3eQj+0CnP2
	7JduDxUEltqqx/KEWgJRhZp2SDexz84wyaZNMu9QQHgNfM1sHX2rKboTliFkjWvz
	5ZkiJ+AP2KPIa1XbgXldAlr1hjP1B+lipJKme6xc4OwfY9wG+sPKlHKyUw7mNdRf
	1Pqk7tUDNIxwPWtqEAq6g==
X-ME-Sender: <xms:YdwKalS73BrtSMPEwZDUpBK9CqOMIjwMt1UzVvGOffhnGUeCtMPBQw>
    <xme:YdwKaloh5mSNEyowkHaoca6ssHHlzqo_mtxsI11e_dSsmZC562A2KcgCdlk2iyQCS
    TXLRZy7x1hRJk7NMZwQmpv8FgGD-Hwi9KpRW700P6OjgA_P2RRIlQ>
X-ME-Received: <xmr:YdwKajKi_SWzk0n2S3riFZTbLBECd9hOQSAYatdHkpA1A4V2Y33W4WSOcxM_vNI7D6zpE6wOHPBRNFgnnUHRrJJXxyJzDNeL2OhTs1XRNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggrthesmhgrlhhonhdruggvvh
X-ME-Proxy: <xmx:YtwKaoolcHRtxTd9ciDyfTXcoZQUtnMl3C7ghMzFiPnw-woBFE9lDg>
    <xmx:YtwKary0x9GSbQDwSXJ9MSLqnKkPw7HNhAdiGY_5YacZnpx06mjqzw>
    <xmx:YtwKasM1tWfN2QeCaSeUE730Xu0Yalx_k9TYjzyHTy0XOZ8AIF3Bkg>
    <xmx:YtwKag5ecvbOviYQl0d3Mz-2NVCLL5xm-qVg0k7VOYAMJM9BxcX1GQ>
    <xmx:YtwKasc3BoysqPZkKHnvsGdLsVz4mKHFhTi6FHSGM6SAo12Bpm-FO6gx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 892730d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:30:54 +0200
Subject: [PATCH v2 03/18] setup: stop using `the_repository` in
 `is_inside_git_dir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-3-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Similar as with the preceding commit, `is_inside_git_dir()` determines
whether the current working directory is located inside the gitdir of
`the_repository`. Perform the same refactoring by dropping the caching
mechanism and injecting the repository that shall be checked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  2 +-
 setup.c             | 14 ++++++--------
 setup.h             |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 52709ca69b..2fcd6851d1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1063,7 +1063,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
-				printf("%s\n", is_inside_git_dir() ? "true"
+				printf("%s\n", is_inside_git_dir(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/setup.c b/setup.c
index b316d9aaa8..041e08b98d 100644
--- a/setup.c
+++ b/setup.c
@@ -26,7 +26,6 @@
 #include "trace2.h"
 #include "worktree.h"
 
-static int inside_git_dir = -1;
 static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
@@ -298,7 +297,7 @@ void verify_filename(const char *prefix,
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree(the_repository) || is_inside_git_dir())
+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
 		return;
 	if (*arg == '-')
 		return; /* flag */
@@ -469,11 +468,12 @@ int is_nonbare_repository_dir(struct strbuf *path)
 	return ret;
 }
 
-int is_inside_git_dir(void)
+int is_inside_git_dir(struct repository *repo)
 {
-	if (inside_git_dir < 0)
-		inside_git_dir = is_inside_dir(repo_get_git_dir(the_repository));
-	return inside_git_dir;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
+	strbuf_release(&buf);
+	return ret;
 }
 
 int is_inside_work_tree(struct repository *repo)
@@ -1256,7 +1256,6 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
-	inside_git_dir = 0;
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1291,7 +1290,6 @@ static const char *setup_bare_git_dir(struct repository *repo,
 		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
-	inside_git_dir = 1;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
diff --git a/setup.h b/setup.h
index 7c0aa75319..71d3f91883 100644
--- a/setup.h
+++ b/setup.h
@@ -4,7 +4,7 @@
 #include "refs.h"
 #include "string-list.h"
 
-int is_inside_git_dir(void);
+int is_inside_git_dir(struct repository *repo);
 int is_inside_work_tree(struct repository *repo);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);

-- 
2.54.0.771.g3ed373ac14.dirty

