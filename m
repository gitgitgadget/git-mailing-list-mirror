Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A9C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiKQNsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiKQNsb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 08:48:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D547B1A5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 21so2612833edv.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoUMF7pET/Mzp377uQSgQS6Fa1wFTQJzJqfEg0bz9hg=;
        b=GBZFRJQd+FLfhPs2qCzUuuQyYk5EAq5azbgguZbKOQRawZA8tBeM3B5Nhql/Rp73FV
         wdhkojXArm0Kh2bEbWsen62gcUCyWTfa3Pig5q1OKbfZnsGPgyoH56GWJg+8RDQYz2mg
         wX46Rir/CEBsYKbbJXKPthJwcIsIQkz5MMcRndeduJEchZjFpRe3uroRWMRTdWmdJT8T
         CYs6Iyf0jXmc4oQIIgyNozuNGFs4mrc4lm+ZVc19pUX2aC0Wkq2gN5JttNzB8ir0dfs4
         HvMMnN0GS2ryhSFDNzg7spvQcJwRFPKJcj98bs7m0jtdiQj+rTH41uc/IaL+fxrlv8YC
         fLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoUMF7pET/Mzp377uQSgQS6Fa1wFTQJzJqfEg0bz9hg=;
        b=b1TXJgRjngEWZ/xoI0ep6h+HQ+ywNqerilrld17R5K8hTCOuqlR3wKQtPxKqv/uaIN
         TqGWiTjxUh1wJCmh+6a9EXwKGo7cbAPdLI+rlger7c8t7jZjO4o54W3pR8yzoRGDZ3nx
         Yd16fAKKbhurtxHhbCFQCDuY9Xz/UqzOjRE5GI1/R7AcCbbqZxnYHnmJ8+tYiQd7lz+Y
         gQa8sXbD8DQ5jcMxhivLTWJMaCVWU/45h9JeGzhyi8MLVKSsl3Kolcv7NqJ/3f7wyHob
         jA34HjBgdyc9ZI22y9S9BeNoX8HucIRZUFyAH+Ltx42lrvDAAclK7RfVnMrK2aFRewy7
         HY1A==
X-Gm-Message-State: ANoB5plu2ZKKGyjfFzsMgHQ3zhrLYjmV80nhdYp6fix5zMWZ34zmWG/w
        JfAkp6d0MEEa3zgt1bgh3bvx9afVbCHMJQ==
X-Google-Smtp-Source: AA0mqf73HkcE/wKdJOO5A/giwzeoTKnanWj1UPA+cZfT2bl2Z1z3Ga4p090YzChOTo+Nc6Mwydhrbg==
X-Received: by 2002:a05:6402:444a:b0:459:401:c23e with SMTP id o10-20020a056402444a00b004590401c23emr2344937edb.23.1668692905129;
        Thu, 17 Nov 2022 05:48:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906581b00b007ad9adabcd4sm379257ejq.213.2022.11.17.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:48:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/4] ls-tree: make "line_termination" less generic
Date:   Thu, 17 Nov 2022 14:48:17 +0100
Message-Id: <RFC-patch-4.4-6efba6223a2-20221117T134528Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
In-Reply-To: <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com> <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "ls-tree" command isn't capable of ending "lines" with anything
except '\n' or '\0', and in the latter case we can avoid calling
write_name_quoted_relative() entirely. Let's do that, less for
optimization and more for clarity, the write_name_quoted_relative()
API itself does much the same thing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 58 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index da664eecfb9..a743959f2b3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -39,7 +39,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 }
 
 struct ls_tree_options {
-	int line_termination;
+	unsigned null_termination:1;
 	int abbrev;
 	enum ls_tree_path_options {
 		LS_RECURSIVE = 1 << 0,
@@ -166,7 +166,7 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 
 	baselen = base->len;
 	strbuf_expand(&sb, options->format, expand_show_tree, &cb_data);
-	strbuf_addch(&sb, options->line_termination);
+	strbuf_addch(&sb, options->null_termination ? '\0' : '\n');
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
 	strbuf_setlen(base, baselen);
@@ -198,10 +198,22 @@ static void show_tree_common_default_long(struct ls_tree_options *options,
 					  const char *pathname,
 					  const size_t baselen)
 {
+	const char *prefix = options->chomp_prefix ? options->ls_tree_prefix : NULL;
+
 	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   options->chomp_prefix ? options->ls_tree_prefix : NULL, stdout,
-				   options->line_termination);
+
+	if (options->null_termination) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *name = relative_path(base->buf, prefix, &sb);
+
+		fputs(name, stdout);
+		fputc('\0', stdout);
+
+		strbuf_release(&sb);
+	} else {
+		write_name_quoted_relative(base->buf, prefix, stdout, '\n');
+	}
+
 	strbuf_setlen(base, baselen);
 }
 
@@ -264,15 +276,25 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 	int recurse;
 	const size_t baselen = base->len;
 	enum object_type type = object_type(mode);
+	const char *prefix;
 
 	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
+	prefix = options->chomp_prefix ? options->ls_tree_prefix : NULL;
 	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   options->chomp_prefix ? options->ls_tree_prefix : NULL,
-				   stdout, options->line_termination);
+	if (options->null_termination) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *name = relative_path(base->buf, prefix, &sb);
+
+		fputs(name, stdout);
+		fputc('\0', stdout);
+
+		strbuf_release(&sb);
+	} else {
+		write_name_quoted_relative(base->buf, prefix, stdout, '\n');
+	}
 	strbuf_setlen(base, baselen);
 	return recurse;
 }
@@ -285,12 +307,19 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 	int early;
 	int recurse;
 	enum object_type type = object_type(mode);
+	const char *str;
 
 	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	printf("%s%c", find_unique_abbrev(oid, options->abbrev), options->line_termination);
+	str = find_unique_abbrev(oid, options->abbrev);
+	if (options->null_termination) {
+		fputs(str, stdout);
+		fputc('\0', stdout);
+	} else  {
+		puts(str);
+	}
 	return recurse;
 }
 
@@ -342,9 +371,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	int i, full_tree = 0;
 	read_tree_fn_t fn = NULL;
 	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
-	struct ls_tree_options options = {
-		.line_termination = '\n',
-	};
+	int null_termination = 0;
+	struct ls_tree_options options = { 0 };
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -352,8 +380,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_RECURSIVE),
 		OPT_BIT('t', NULL, &options.ls_options, N_("show trees when recursing"),
 			LS_SHOW_TREES),
-		OPT_SET_INT('z', NULL, &options.line_termination,
-			    N_("terminate entries with NUL byte"), 0),
+		OPT_BOOL('z', NULL, &null_termination,
+			 N_("terminate entries with NUL byte")),
 		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
 			    MODE_LONG),
 		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
@@ -383,6 +411,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
+	options.null_termination = null_termination;
+
 	if (full_tree) {
 		options.ls_tree_prefix = prefix = NULL;
 		options.chomp_prefix = 0;
-- 
2.38.0.1473.g172bcc0511c

