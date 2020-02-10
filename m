Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBAFC47409
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9352121739
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q10t/Zci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJAbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBJAbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so5415920wru.7
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k8tgdFvIaea/EUh1trQg/Jcnd/2uUJbrdJ7MXu61oDk=;
        b=Q10t/ZcityPwJEJBDOCE6xWKxHEvcbvMYY8AKY61uU8Hb7QQYiOmNM9HvIpki2U8d8
         to3o7sOPtHf80ksQOgJOPmnvLikIU6QaZN3mFA/zsBjNuDWimJPtFKignAUWemTqz/yH
         6qdcJRBPmMIfz4v9ytkdP+czE/zPU+wyoplIDFjX+Z1jAAnHG+Ja8gPcKStB2NYebcAU
         /khtbpw2dTec1F8tzuIOzxMzg+excBLcvjDBbnZSrNx0XbDzxNe9Ih8NVOv1mswlyY9X
         5XCHSCMx9kyTJ46HjKZq/u0LYgszdnSy1cdpmCirfU1irvW69u6GUVrh0PxEXhubZkzE
         N3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k8tgdFvIaea/EUh1trQg/Jcnd/2uUJbrdJ7MXu61oDk=;
        b=G7I1i/7VyixmXasBmTQfo3SJODHgoaW47HpM+ahP7jmFHVbHgU/mtIawfbRoiJ0ob3
         Fun5C+rvxWN3GeVHAC3pi4j+k1wYjiAGzO7/tEShtno9UH8ov/Rd3/qiCoOJJ93k+gdL
         vMmo29vYTbsIUSwq8XbMPn3699UzKKGRK7Z+0t9YeC6/a/wEJYHEfmavY1/f1oCJMYuF
         ySV+SRkBGR2oMuHxPzR1+AH4Cqbzo2wNwwIk1myqslRs/xcppiIK3JNhaobB67KKdGsr
         Y0XZWxpN8iKxLdqjnKW5FgguvZ7Y+w4N10oQfPT4+Bn9QorvJ1LWoXZY/6TnRM+Gczv1
         xjDQ==
X-Gm-Message-State: APjAAAWcdaRqJRJ0SkSZsu2GLObpN1VsBNV4vgOwbOn7U7g3wzpjZ6Dv
        wkHItVVINAeNQPwovXwtYlWN9d2D
X-Google-Smtp-Source: APXvYqwK2VdNC54nh3hYatiT5NqZwaFvS5phgUthQdLlnCT8NQ30KdarPYa/80NIil9K7z32KmbevQ==
X-Received: by 2002:adf:8b59:: with SMTP id v25mr13747434wra.419.1581294669371;
        Sun, 09 Feb 2020 16:31:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm13025993wmb.37.2020.02.09.16.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:08 -0800 (PST)
Message-Id: <f76463ee90c1bc294ed503af19a47190f72778a8.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:59 +0000
Subject: [PATCH v7 10/10] config: add '--show-scope' to print the scope of a
 config value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

When a user queries config values with --show-origin, often it's
difficult to determine what the actual "scope" (local, global, etc.) of
a given value is based on just the origin file.

Teach 'git config' the '--show-scope' option to print the scope of all
displayed config values.  Note that we should never see anything of
"submodule" scope as that is only ever used by submodule-config.c when
parsing the '.gitmodules' file.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 Documentation/git-config.txt | 15 ++++++---
 builtin/config.c             | 20 ++++++++++--
 t/t1300-config.sh            | 59 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 899e92a1c9..7573160f21 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,18 +9,18 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [--type=<type>] --add name value
 'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
+'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
@@ -222,6 +222,11 @@ Valid `<type>`'s include:
 	the actual origin (config file path, ref, or blob id if
 	applicable).
 
+--show-scope::
+	Similar to `--show-origin` in that it augments the output of
+	all queried config options with the scope of that value
+	(local, global, system, command).
+
 --get-colorbool name [stdout-is-tty]::
 
 	Find the color setting for `name` (e.g. `color.diff`) and output
diff --git a/builtin/config.c b/builtin/config.c
index 0a9778b714..ee4aef6a35 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -33,6 +33,7 @@ static int end_nul;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
+static int show_scope;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -155,6 +156,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
@@ -189,11 +191,23 @@ static void show_config_origin(struct strbuf *buf)
 	strbuf_addch(buf, term);
 }
 
+static void show_config_scope(struct strbuf *buf)
+{
+	const char term = end_nul ? '\0' : '\t';
+	const char *scope = config_scope_name(current_config_scope());
+
+	strbuf_addstr(buf, N_(scope));
+	strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
-	if (show_origin) {
+	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
-		show_config_origin(&buf);
+		if (show_scope)
+			show_config_scope(&buf);
+		if (show_origin)
+			show_config_origin(&buf);
 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
@@ -213,6 +227,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_scope)
+		show_config_scope(buf);
 	if (show_origin)
 		show_config_origin(buf);
 	if (show_keys)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e5fb9114f6..5464c46c18 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1771,6 +1771,65 @@ test_expect_success '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success '--show-scope with --list' '
+	cat >expect <<-EOF &&
+	global	user.global=true
+	global	user.override=global
+	global	include.path=$INCLUDE_DIR/absolute.include
+	global	user.absolute=include
+	local	user.local=true
+	local	user.override=local
+	local	include.path=../include/relative.include
+	local	user.relative=include
+	command	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success !MINGW '--show-scope with --blob' '
+	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	cat >expect <<-EOF &&
+	command	user.custom=true
+	EOF
+	git config --blob=$blob --show-scope --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --local' '
+	cat >expect <<-\EOF &&
+	local	user.local=true
+	local	user.override=local
+	local	include.path=../include/relative.include
+	EOF
+	git config --local --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope getting a single value' '
+	cat >expect <<-\EOF &&
+	local	true
+	EOF
+	git config --show-scope --get user.local >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --show-origin' '
+	cat >expect <<-EOF &&
+	global	file:$HOME/.gitconfig	user.global=true
+	global	file:$HOME/.gitconfig	user.override=global
+	global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+	global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
+	local	file:.git/config	user.local=true
+	local	file:.git/config	user.override=local
+	local	file:.git/config	include.path=../include/relative.include
+	local	file:.git/../include/relative.include	user.relative=include
+	command	command line:	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-origin --show-scope >output &&
+	test_cmp expect output
+'
+
 test_expect_success '--local requires a repo' '
 	# we expect 128 to ensure that we do not simply
 	# fail to find anything and return code "1"
-- 
gitgitgadget
