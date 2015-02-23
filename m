From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] option-strings: use OPT_PATH
Date: Mon, 23 Feb 2015 17:17:45 +0100
Message-ID: <9030a1bb1e7a03eedfd65432fabf385f457419d6.1424707497.git.git@drmicha.warpmail.net>
References: <20150223144214.GA31624@peff.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:18:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvhw-0003pz-6T
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbbBWQRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:17:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47488 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752527AbbBWQRw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 11:17:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B7E2720825
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 11:17:51 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 23 Feb 2015 11:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=4L/4Bufvp16XBDuP7ZiEYx/anuY=; b=U5DOkmUemgUidUvYeHvU
	GVcSUKwqEURZ1lex71Y5z4XZRsSTqv8wGPwn1KJ4biHSqK/iPCIXYowO+fLWyYI7
	gLA9twtowKqYv6Ld77LLz2voWyvSP2y45GnYh2RoT4pKR8UzrwFDzi0NddG9oXHM
	D3jdXiDGIbLdyHdf7Jg8q0Y=
X-Sasl-enc: 42/xTu00GyTn9PJBhcNYR26cz+h+oI1jPbWJqukWXF52 1424708272
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 09EACC00295;
	Mon, 23 Feb 2015 11:17:51 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
In-Reply-To: <20150223144214.GA31624@peff.net>
In-Reply-To: <cover.1424707497.git.git@drmicha.warpmail.net>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264269>

Some commands use OPT_STRING to specify a path type argument. Let them
use OPT_PATH so that they can profit from path prefixing.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/clone.c   | 4 ++--
 builtin/init-db.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a9af3f2..15941c5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -80,7 +80,7 @@ static struct option builtin_clone_options[] = {
 		    N_("initialize submodules in the clone")),
 	OPT_BOOL(0, "recurse-submodules", &option_recursive,
 		    N_("initialize submodules in the clone")),
-	OPT_STRING(0, "template", &option_template, N_("template-directory"),
+	OPT_PATH(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
 	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
 		     N_("reference repository"), &opt_parse_reference),
@@ -94,7 +94,7 @@ static struct option builtin_clone_options[] = {
 		    N_("create a shallow clone of that depth")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
-	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
+	OPT_PATH(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6b7fa5f..262c9ae 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -477,7 +477,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const struct option init_db_options[] = {
-		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
+		OPT_PATH(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
 				N_("create a bare repository"), 1),
@@ -486,7 +486,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			N_("specify that the git repository is to be shared amongst several users"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
-		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
+		OPT_PATH(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
 		OPT_END()
 	};
-- 
2.3.0.296.g32c87e1
