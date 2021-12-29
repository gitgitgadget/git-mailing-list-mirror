Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C07C433FE
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 06:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhL2GXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 01:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbhL2GXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 01:23:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD874C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:23:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t26so42447204wrb.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pDX3Gi8DkdnhZmn25zn+bLE7BwP9kqRagaRhQytA2uk=;
        b=Fl1KPPrpwyshddfVAjRHoPNGlCtiY4H/6HZf0097B0eAJwhByCCk7HIHtM+Gh6f5UL
         g2fVXVGPSup4404tXpjNIHHtKN5wgxatRB8n27obp3CZfuL8roc4bIKHSgXeXc1RpKEU
         Jzg4xSj3phKCuy92vpZd0vvhuMMmwHc5vx4WGcRs0s/Tod6PWbEqUAE2f9qwFfMKVbxE
         +viyEMx83oSHD64p2y+qEoev6lKwi5rEC4kTDXlkXrCuKUKzFYGm/xgnDOOMwRsN4czq
         9UuKPkoqT3nV85ZEz3l+pfmjdoiag38e8OY8g6yLDBa2Is9G0/IcbQOzDim9NQ5yBLJk
         vVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pDX3Gi8DkdnhZmn25zn+bLE7BwP9kqRagaRhQytA2uk=;
        b=d8FQxCE3N+RxuJu7JwqHimSdkVIgvi8adkwE6rGeLhoAJjKVMgMM/p8SnVnSFdLPfl
         oBT/oJ07hulWHd58Kq/+vJD9X727yBfU/CsCCRHk2oApbhOvmHgk/aNnddmScWcxLVPI
         JsjgFYmsyZjiiGsp8Qcwi6lDupapFf5VI+LrdtqzpXACXxXCzze1BfDjI+dr0bxAOGeb
         l8d5MOc/WCli67r6kr+fx8yCSw+UmpVpdvtIXM/7/MZKv42q70ctJDrQw1YyZiHlRIzv
         isZBPjfQvR338Z5buDC9LPSeY4/wj5X9xB5R2L9xQKR+6kvSm1oFu6+mXIkd0v8CTOLL
         +r3A==
X-Gm-Message-State: AOAM530fUh2U43++UUmglrA4PAx0i0fs/MuifEzwIl8BjEdYWdB4QwoC
        OdjItU8ssOcu10CR+a1iDQJ2x2shA14=
X-Google-Smtp-Source: ABdhPJw8C0Uy2CKqX9Hk+YgcFy5AT6UUnMovJbDw4M3Dfc8k2mrSuXtycEFMS7sHlYu+GYRWtIb21w==
X-Received: by 2002:adf:a111:: with SMTP id o17mr18708084wro.526.1640759023219;
        Tue, 28 Dec 2021 22:23:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm20365321wrc.1.2021.12.28.22.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:23:42 -0800 (PST)
Message-Id: <e8063284b4d0d410d1ee8337c60f5ce3b48efb11.1640759021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
        <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 06:23:40 +0000
Subject: [PATCH v2 1/2] name-rev: deprecate --stdin in favor of
 --annotate-text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Introduce a --annotate-text that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can
be a confusing and misleading name, rename it to --annotate-text.

This change adds a warning to --stdin warning that it will be removed in
the future.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 Documentation/git-name-rev.txt | 29 ++++++++++++++++++++++++++++-
 builtin/name-rev.c             | 19 ++++++++++++++-----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5cb0eb0855f..ee11b2ca9e7 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -43,10 +43,37 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
+	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
+	They are functionally equivalent.
+
+--annotate-stdin::
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	--name-only, substitute with "$rev_name", omitting $hex
-	altogether.  Intended for the scripter's use.
+	altogether.
+
+	For example:
++
+----------
+$ cat sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+
+$ git name-rev --annotate-stdin <sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907
+(master),
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+
+$ git name-rev --name-only --annotate-stdin <sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name is master,
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+----------
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 27f60153a6c..21370afdaf9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -527,7 +527,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
-	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
+	int all = 0, annotate_stdin = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
@@ -539,6 +539,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
+		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
@@ -554,11 +555,19 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	init_commit_rev_name(&rev_names);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (all + transform_stdin + !!argc > 1) {
+
+	if (transform_stdin) {
+		warning("--stdin is deprecated. Please use --annotate-stdin instead, "
+					"which is functionally equivalent.\n"
+					"This option will be removed in a future release.");
+		annotate_stdin = 1;
+	}
+
+	if (all + annotate_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-	if (all || transform_stdin)
+	if (all || annotate_stdin)
 		cutoff = 0;
 
 	for (; argc; argc--, argv++) {
@@ -613,8 +622,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	for_each_ref(name_ref, &data);
 	name_tips();
 
-	if (transform_stdin) {
-		char buffer[2048];
+	if (annotate_stdin) {
+		struct strbuf sb = STRBUF_INIT;
 
 		while (!feof(stdin)) {
 			char *p = fgets(buffer, sizeof(buffer), stdin);
-- 
gitgitgadget

