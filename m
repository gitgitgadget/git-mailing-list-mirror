Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E941F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeKKQLJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:09 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43377 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeKKQLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:09 -0500
Received: by mail-oi1-f173.google.com with SMTP id j202-v6so4745526oih.10
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFevrcZ/T8fCkpNvRUt5EvBMQkHssSjGQ3IfS7WtzY4=;
        b=AM/y+awvC3p+T5AapK6N/7PilxV1HBNV5YRjvZHyatC+75ZnA4YGB2kcYzkXSgyQoK
         kUXC8yNpMZkMP1N9TNYf8oaAasYp39NpvRn+TGO7sxHpGV9tlBk/n+P5eQBctdW72i5l
         y0gFS3IDnS04AtZQXGI5DspY94Td2bzcGqW5PmyZ0wQPG0cl/vA8a6lWq63QYxtjwYuW
         RNjeH6HJBy14p03WHpM9wPlLws7uFx3At7Qn1nFjr1IUEgEaIRS3KJJWWhuHohjRjmk3
         V/7DOz2JoYUu2eeCB+p+JIdtn4zTHgLsmXPhERw1NYmH2CkprEkC37dyyggBayGmaZNC
         VNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFevrcZ/T8fCkpNvRUt5EvBMQkHssSjGQ3IfS7WtzY4=;
        b=OjvyrSrSdKZjeLl/OXGTdcTYRR7OD1NuzAf1bFvqqfFimNz5seKowL+oEXcdodTFHF
         fGvdk9zTQI7+u5kKo6EclP3/y/xOXS/S+QVXjee6wop/rSOHI06vfCwCYx2m97Wp5cz1
         iOARbFAjV5r88/wIuJGKcMNPW5GDRwtLwOqJxfOkAEkg4qCYg4OZHQkX7TSiKNIGbhXL
         PDAZnKFmBdy9wlpG7yaaUlzmLjDXMucb10qoK8XcCRKiAsTngUPlEm4ZS69zyZTwZlf2
         7bXmx8jQK1Y7YfzoePezttEsJQW8YyGVz9vK1+jk6Qs1pQ8Hi1URzA/vFVpZDEnOTzVS
         ensQ==
X-Gm-Message-State: AGRZ1gIGyP5r4OE/L8t2inHIrbt+Ysku5g9o4vjBy8M8JaQpiYHQJLt+
        6Y53hdTwHl/zwestbeX8T56zFFfz
X-Google-Smtp-Source: AJdET5f8j3lQdL/Jlqp9N++rxI5N9+/SI71kLayzHRTWhlETaQhwk0ZekCug+efIc/Oss+NkIW+4Mw==
X-Received: by 2002:aca:eb4b:: with SMTP id j72-v6mr7975171oih.306.1541917410315;
        Sat, 10 Nov 2018 22:23:30 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:29 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 09/10] fast-export: add a --show-original-ids option to show original names
Date:   Sat, 10 Nov 2018 22:23:11 -0800
Message-Id: <20181111062312.16342-10-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Knowing the original names (hashes) of commits, blobs, and tags can
sometimes enable post-filtering that would otherwise be difficult or
impossible.  In particular, the desire to rewrite commit messages which
refer to other prior commits (on top of whatever other filtering is
being done) is very difficult without knowing the original names of each
commit.

This commit teaches a new --show-original-ids option to fast-export
which will make it add a 'originally <hash>' line to blob, commits, and
tags.  It also teaches fast-import to parse (and ignore) such lines.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt |  7 +++++++
 builtin/fast-export.c             | 20 +++++++++++++++-----
 fast-import.c                     | 17 +++++++++++++++++
 t/t9350-fast-export.sh            | 17 +++++++++++++++++
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 2916096bdd..4e40f0b99a 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -121,6 +121,13 @@ marks the same across runs.
 	used by a repository which already contains the necessary
 	parent commits.
 
+--show-original-ids::
+	Add an extra directive to the output for commits and blobs,
+	`originally <SHA1SUM>`.  While such directives will likely be
+	ignored by importers such as git-fast-import, it may be useful
+	for intermediary filters (e.g. for rewriting commit messages
+	which refer to older commits, or for stripping blobs by id).
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ea9c5b1c00..cc01dcc90c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -38,6 +38,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static int reference_excluded_commits;
+static int show_original_ids;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
@@ -271,7 +272,10 @@ static void export_blob(const struct object_id *oid)
 
 	mark_next_object(object);
 
-	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
+	printf("blob\nmark :%"PRIu32"\n", last_idnum);
+	if (show_original_ids)
+		printf("originally %s\n", oid_to_hex(oid));
+	printf("data %lu\n", size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
 		die_errno("could not write blob '%s'", oid_to_hex(oid));
 	printf("\n");
@@ -628,8 +632,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		reencoded = reencode_string(message, "UTF-8", encoding);
 	if (!commit->parents)
 		printf("reset %s\n", refname);
-	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
-	       refname, last_idnum,
+	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
+	if (show_original_ids)
+		printf("originally %s\n", oid_to_hex(&commit->object.oid));
+	printf("%.*s\n%.*s\ndata %u\n%s",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer,
 	       (unsigned)(reencoded
@@ -807,8 +813,10 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
-	       name, tagged_mark,
+	printf("tag %s\nfrom :%d\n", name, tagged_mark);
+	if (show_original_ids)
+		printf("originally %s\n", oid_to_hex(&tag->object.oid));
+	printf("%.*s%sdata %d\n%.*s\n",
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
@@ -1089,6 +1097,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
 		OPT_BOOL(0, "reference-excluded-parents",
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by sha1sum")),
+		OPT_BOOL(0, "show-original-ids", &show_original_ids,
+			    N_("Show original sha1sums of blobs/commits")),
 
 		OPT_END()
 	};
diff --git a/fast-import.c b/fast-import.c
index 95600c78e0..232b6a8b8d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -14,11 +14,13 @@ Format of STDIN stream:
 
   new_blob ::= 'blob' lf
     mark?
+    originally?
     file_content;
   file_content ::= data;
 
   new_commit ::= 'commit' sp ref_str lf
     mark?
+    originally?
     ('author' (sp name)? sp '<' email '>' sp when lf)?
     'committer' (sp name)? sp '<' email '>' sp when lf
     commit_msg
@@ -49,6 +51,7 @@ Format of STDIN stream:
 
   new_tag ::= 'tag' sp tag_str lf
     'from' sp commit-ish lf
+    originally?
     ('tagger' (sp name)? sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::= data;
@@ -73,6 +76,8 @@ Format of STDIN stream:
   data ::= (delimited_data | exact_data)
     lf?;
 
+  originally ::= 'originally' sp not_lf+ lf
+
     # note: delim may be any string but must not contain lf.
     # data_line may contain any data but must not be exactly
     # delim.
@@ -1968,6 +1973,13 @@ static void parse_mark(void)
 		next_mark = 0;
 }
 
+static void parse_original_identifier(void)
+{
+	const char *v;
+	if (skip_prefix(command_buf.buf, "originally ", &v))
+		read_next_command();
+}
+
 static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
 	const char *data;
@@ -2110,6 +2122,7 @@ static void parse_new_blob(void)
 {
 	read_next_command();
 	parse_mark();
+	parse_original_identifier();
 	parse_and_store_blob(&last_blob, NULL, next_mark);
 }
 
@@ -2733,6 +2746,7 @@ static void parse_new_commit(const char *arg)
 
 	read_next_command();
 	parse_mark();
+	parse_original_identifier();
 	if (skip_prefix(command_buf.buf, "author ", &v)) {
 		author = parse_ident(v);
 		read_next_command();
@@ -2865,6 +2879,9 @@ static void parse_new_tag(const char *arg)
 		die("Invalid ref name or SHA1 expression: %s", from);
 	read_next_command();
 
+	/* originally ... */
+	parse_original_identifier();
+
 	/* tagger ... */
 	if (skip_prefix(command_buf.buf, "tagger ", &v)) {
 		tagger = parse_ident(v);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index c2f40d6a40..5ad6669910 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -77,6 +77,23 @@ test_expect_success 'fast-export --reference-excluded-parents master~2..master'
 		 test $MASTER = $(git rev-parse --verify refs/heads/rewrite))
 '
 
+test_expect_success 'fast-export --show-original-ids' '
+
+	git fast-export --show-original-ids master >output &&
+	grep ^originally output| sed -e s/^originally.// | sort >actual &&
+	git rev-list --objects master muss >objects-and-names &&
+	awk "{print \$1}" objects-and-names | sort >commits-trees-blobs &&
+	comm -23 actual commits-trees-blobs >unfound &&
+	test_must_be_empty unfound
+'
+
+test_expect_success 'fast-export --show-original-ids | git fast-import' '
+
+	git fast-export --show-original-ids master muss | git fast-import --quiet &&
+	test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	test $MUSS = $(git rev-parse --verify refs/tags/muss)
+'
+
 test_expect_success 'iso-8859-1' '
 
 	git config i18n.commitencoding ISO8859-1 &&
-- 
2.19.1.866.g82735bcbde

