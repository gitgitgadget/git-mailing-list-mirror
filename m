Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCB0CCA479
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiGRTvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiGRTvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:51:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CD32044
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so19221990pjo.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKCy/SfIGt6Fn8dq+wjVnzZz8PJRGxrn87FqhSSqHOQ=;
        b=eUNPpfgZje/w+WR5NHlLL3XcSogf75TjTcmmUhqdirNRGI+rY5y4aU4DmysVg2TJsv
         UYLaLxbZc8nE2RYVTXYWN00k3rU3VlGcu/UdroqSysZ8oe1hFg6bKgl4/VLJ7mwtHH9y
         ErsuVY4XonWwJYEftNEIR0//KjcwNs0EIJCFMxiqtu0Dhnt05l34vOcE1uojWSOs+TJ0
         juSSaSpQNOUtPt0zb43t6J3BQNje1IBS/4cyR9vx0CDvh19cyrUKtRTNpg7ktTJWfkEn
         ei2kV/JSGit9HNPwUsgAhuAqXOwxhsBjZ4nEeAF0SsPrzpNYrziv9TQ+cPdK5ivlsYx0
         PbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKCy/SfIGt6Fn8dq+wjVnzZz8PJRGxrn87FqhSSqHOQ=;
        b=YgPF/pQJK8tqUx634B8bDB0oWnNsgbepd1JLKqKJLxU6fOKGqXl89CxW7OnabBZKZx
         U9osOMTqi3RXK+OSQntwNiFp6g18w0JdFgYI8AYtqRZUijq4w1yQ8BiuEyBnBd4bMtPs
         pRBBjuNcsXD2gQPDyfOH9mvEIb6m+j2h6HzfFXG5J/4pVMzM3l9QP5oPorS0ozmMT0Ak
         33Bps6ef+ekNn7F43tT43aV2Tl2O4s6t1dYJ0KIZht3yrlN2pdzCDBcszxhZggSIU/Rr
         OwGKr3BUTT6DDafoKWYBQwwGA7nseHq1ozHOR7RxBo7CWUQAqX+/SXGS3frRfGSCVncS
         Px6w==
X-Gm-Message-State: AJIora8joe/YKF5siZQeoR+8eKpXK5BltW9nntaoicb5odeTwcC3VQg9
        VZ5sm7dOnLuheSWzvN/CdD1cB6IjqJvNgA==
X-Google-Smtp-Source: AGRyM1uOJZxKI2HIbPO3DL1+uxX0wtt8c8onZpqsBPMpZSFdV8JB0V+y60j1Sck6M5gYBYP9TKk1yg==
X-Received: by 2002:a17:90b:3b82:b0:1f0:73e1:8426 with SMTP id pc2-20020a17090b3b8200b001f073e18426mr35593651pjb.209.1658173894934;
        Mon, 18 Jul 2022 12:51:34 -0700 (PDT)
Received: from HB2.. ([106.212.244.137])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b0016c35b21901sm9855838plr.195.2022.07.18.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:51:34 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 4/4] cat-file: add mailmap support
Date:   Tue, 19 Jul 2022 01:21:02 +0530
Message-Id: <20220718195102.66321-5-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g63d6f8c201
In-Reply-To: <20220718195102.66321-1-siddharthasthana31@gmail.com>
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
 <20220718195102.66321-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-cat-file is used by tools like GitLab to get commit tag contents
that are then displayed to users. This content which has author,
committer or tagger information, could benefit from passing through the
mailmap mechanism before being sent or displayed.

This patch adds --[no-]use-mailmap command line option to the git
cat-file command. It also adds --[no-]mailmap option as an alias to
--[no-]use-mailmap.

This patch also introduces new test cases to test the mailmap mechanism in
git cat-file command.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  6 ++++
 builtin/cat-file.c             | 43 ++++++++++++++++++++++++-
 t/t4203-mailmap.sh             | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 24a811f0ef..1880e9bba1 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -63,6 +63,12 @@ OPTIONS
 	or to ask for a "blob" with `<object>` being a tag object that
 	points at it.
 
+--[no-]mailmap::
+--[no-]use-mailmap::
+       Use mailmap file to map author, committer and tagger names
+       and email addresses to canonical real names and email addresses.
+       See linkgit:git-shortlog[1].
+
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
 	`<object>` has to be of the form `<tree-ish>:<path>`, or `:<path>` in
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 50cf38999d..4b68216b51 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "mailmap.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -36,6 +37,22 @@ struct batch_options {
 
 static const char *force_path;
 
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+static int use_mailmap;
+
+static char *replace_idents_using_mailmap(char *, size_t *);
+
+static char *replace_idents_using_mailmap(char *object_buf, size_t *size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *headers[] = { "author ", "committer ", "tagger ", NULL };
+
+	strbuf_attach(&sb, object_buf, *size, *size + 1);
+	apply_mailmap_to_header(&sb, headers, &mailmap);
+	*size = sb.len;
+	return strbuf_detach(&sb, NULL);
+}
+
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
 			 char **buf, unsigned long *size)
@@ -152,6 +169,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
+		if (use_mailmap) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		/* otherwise just spit out the data */
 		break;
 
@@ -183,6 +206,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 		buf = read_object_with_reference(the_repository, &oid,
 						 exp_type_id, &size, NULL);
+
+		if (use_mailmap) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
 		break;
 	}
 	default:
@@ -348,11 +377,18 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		void *contents;
 
 		contents = read_object_file(oid, &type, &size);
+
+		if (use_mailmap) {
+			size_t s = size;
+			contents = replace_idents_using_mailmap(contents, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
 			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
+		if (data->info.sizep && size != data->size && !use_mailmap)
 			die("object %s changed size!?", oid_to_hex(oid));
 
 		batch_write(opt, contents, size);
@@ -843,6 +879,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
+		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
+		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		/* Batch mode */
 		OPT_GROUP(N_("Batch objects requested on stdin (or --batch-all-objects)")),
 		OPT_CALLBACK_F(0, "batch", &batch, N_("format"),
@@ -885,6 +923,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
+	if (use_mailmap)
+		read_mailmap(&mailmap);
+
 	/* --batch-all-objects? */
 	if (opt == 'b')
 		batch.all_objects = 1;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0b2d21ec55..cd1cab3e54 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -963,4 +963,63 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'prepare for cat-file --mailmap' '
+	rm -f .mailmap &&
+	git commit --allow-empty -m foo --author="Orig <orig@example.com>"
+'
+
+test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	A U Thor <author@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	author Orig <orig@example.com>
+	EOF
+	git cat-file --no-use-mailmap commit HEAD >log &&
+	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--use-mailmap enables mailmap in cat-file' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	A U Thor <author@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	author A U Thor <author@example.com>
+	EOF
+	git cat-file --use-mailmap commit HEAD >log &&
+	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-mailmap disables mailmap in cat-file for annotated tag objects' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	Orig <orig@example.com> C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	tagger C O Mitter <committer@example.com>
+	EOF
+	git tag -a -m "annotated tag" v1 &&
+	git cat-file --no-mailmap -p v1 >log &&
+	sed -n "/^tagger /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--mailmap enables mailmap in cat-file for annotated tag objects' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	Orig <orig@example.com> C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	tagger Orig <orig@example.com>
+	EOF
+	git tag -a -m "annotated tag" v2 &&
+	git cat-file --mailmap -p v2 >log &&
+	sed -n "/^tagger /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.37.1.120.g63d6f8c201

