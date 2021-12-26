Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25029C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 04:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhLZE2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 23:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhLZE2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 23:28:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D502C061401
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 20:28:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o30so5064590wms.4
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 20:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=a4ttZt6Ef44XI97XdwGhYWOOM3TmqivkBrJnRuHXbIo=;
        b=PyjGnycveVar+yDc0O9KG3a/G6vHWCidlUeQ7WLDJGkfXw2YnB3ltr13tdofRbCUkx
         GasmKOlSuCbRhRDJ/xiFsDfvXg4OId7zxfIYx3bKg3AngaKVElnvYh0huyg4HeS1vukP
         3iSZsNcQ8HxIFme9+Qr9/Pg3RzQxAuaSgE3d6O/I7IydDeABw+LWnFdC0SmcY26s7VcA
         VQZrvyxX5AIJYljj4yFptKKlr1gpZoKBxfuGwGLvj3vxnjHOCJ5zn5meqWJc/E3SsbYB
         1hVfj5WqGlWPAZSxtdNlBpUEwRAzZWxl/K7Eujw+6eLsdwD3muH4vB/VFWroSnYcf6mP
         udkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a4ttZt6Ef44XI97XdwGhYWOOM3TmqivkBrJnRuHXbIo=;
        b=DZd/cjPow70w3hbXMpS+JbH4lm4y7RsbFDhXY/GZ/EXfZxdf470M6kzGUtws5UsT9z
         33ip/anGNEKr+E3lwPVcSL2Inl6ztBUsngLAoI7ePNTkvfPmwv+GjnyUxnQdQSTzTS8v
         wUTJdtgAG9BQiyKuf+dTMI0bG/M/YyKIXryQdicmLJFuq8S270QHSvTyIkxnW4lCnKmZ
         tUCtGAkNL+8ZgwhJLNiHdreMHhtPsNBsATpYUvBr5GKWg7USkWCZXeIFWOpI7BSEAl6z
         9ACkXLjnBQ3PGYR37/WObro1ZfqKE3IAsl/TiweLkAGhBDaV2MfBHWiR2yZHbhJA5e4U
         3q2Q==
X-Gm-Message-State: AOAM530lG9JUQOM6+UpMkE8PQprwIQ3C2mGDICSCOQ3oevGs6pdeLsse
        RXltm79i1/GmJKh6vfBCsHj5IVhjZD4=
X-Google-Smtp-Source: ABdhPJznPYFYZkCmNvRxsEpcWQbIBfN4PSx03KToTEpJQ8Zbp6P9L7VnXxb0JcT7wHetGiyr9HYXkA==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr9192091wmh.150.1640492911146;
        Sat, 25 Dec 2021 20:28:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k31sm12242919wms.21.2021.12.25.20.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 20:28:30 -0800 (PST)
Message-Id: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Dec 2021 04:28:30 +0000
Subject: [PATCH] name-rev: deprecate --stdin in favor of --annotate-text
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
    name-rev: deprecate --stdin in favor of --anotate-text
    
    Introduce a --anontate-text that is functionally equivalent of --stdin.
    --stdin does not behave as --stdin in other subcommands, such as
    pack-objects whereby it takes one argument per line. Since --stdin can
    be a confusing and misleading name, the goal is to rename it to
    --anotate-text.
    
    This is the first step in a process of eventually fully deprecating
    --stdin. This change also adds a warning to --stdin warning that it will
    be removed in the future.
    
    See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for
    discussion.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v1
Pull-Request: https://github.com/git/git/pull/1171

 Documentation/git-name-rev.txt | 29 ++++++++++++++++++++++++++++-
 builtin/name-rev.c             | 17 +++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5cb0eb0855f..64d59c6ee1a 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -43,10 +43,37 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
+	This option is deprecated in favor of 'git name-rev --annotate-text'.
+	They are functionally equivalent.
+
+--annotate-text::
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
+$ git name-rev --annotate-text < sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907
+(master),
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+
+$ git name-rev --name-only --annotate-text < sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name is master,
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+----------
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 27f60153a6c..73b244a5aac 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -527,7 +527,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
-	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
+	int all = 0, annotate_text = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
@@ -539,6 +539,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
+		OPT_BOOL(0, "annotate-text", &annotate_text, N_("annotate text text from stdin")),
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
+		warning("--stdin is deprecated. Please use --annotate-text instead, "
+					"which is functionally equivalent.\n"
+					"This option will be removed in a future release.");
+		annotate_text = 1;
+	}
+
+	if (all + annotate_text + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-	if (all || transform_stdin)
+	if (all || annotate_text)
 		cutoff = 0;
 
 	for (; argc; argc--, argv++) {
@@ -613,7 +622,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	for_each_ref(name_ref, &data);
 	name_tips();
 
-	if (transform_stdin) {
+	if (annotate_text) {
 		char buffer[2048];
 
 		while (!feof(stdin)) {

base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
-- 
gitgitgadget
