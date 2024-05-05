Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C346D1A8
	for <git@vger.kernel.org>; Sun,  5 May 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934959; cv=none; b=TrlKvUVPSjXi/j3uQzkJlRV0/5lfBleNidApqrYN00Qj6F3JOeemBE5AZDYe+ozkLLJn7NGlQsECAmRDiE3zcg3Mtqn/LrY3MtzR0J9TaKRYltTRttNOiwbBtW57ZV6eMJLW4NlcWQ+r79wpIHw4w66hD6fm3piPFHovwUSOowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934959; c=relaxed/simple;
	bh=poaegycawdwBj3FTY1rXxGEDfXi/Olj0qrog+9FfMDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jf5lpjkz0/4wHAmuZ8ifh42opJxoLfLZzj1k4bq7yqMRicfhzGuXfoGpM8B4Lx2Err39u/aZckyQ76vAcotffUIaSrmFvB/FXE5e8i3KXsVbgmRpUh53gGkQr9AEoTTbNqyxyxCeFX/MBKN2SECQ1WhUaXyo8oFokpT7dTcycNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpRw2JkH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpRw2JkH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34db6a29998so750204f8f.0
        for <git@vger.kernel.org>; Sun, 05 May 2024 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714934956; x=1715539756; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH5bEnuYpOYbBHRAm5rTss0FWMHmjxB0ZCuo/ZueRdQ=;
        b=NpRw2JkH+Y/oQS+XZqSuiLnBuADADWYsj5Nr7G0UgCO/VLamZqdyalmYd4X22CZcRe
         XxG0j/jViuOGWEqFpghOYLUOwZG5EhPF7Nulsfhd94EjwDRiYDm+t5z8wJDt5XsZvDqT
         8jvqezgHzUWXbUjM/LjL/VI53xn6DoEOzADAFhW5qmPs3WDVfzgN2KToL78kAWEZNNHl
         pBzQ86RkmJZhOPxF0ZTH/0aVQW4T4sHeyFHK2UfX3iFFkCIVpAESCB11U9FECaQwkUnQ
         7niA+pIrEXoK1P5pALQzAD/AYAnjR/EEehva/t88hVxZ+g+AoaqYrOb1e99vCFLGmmbG
         Sz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934956; x=1715539756;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MH5bEnuYpOYbBHRAm5rTss0FWMHmjxB0ZCuo/ZueRdQ=;
        b=dHa+NXFVgG8vsQZzcgW25C3rpN6Mlb4CT/BUNayeGRq+YxW9ydvB16IlxYHcaf18Qa
         McSccbLWLckS725EeZTAnL5lbIqULm8cxJWgnB2BkEnBFb4w5JvYmyyhvgDfTO97eiRV
         OTyLEzP7hq7A+i2WosB/hAEHad57k0KEptkFj6rSPcUsVmJ4bh0GAdes2LzEER47SJOK
         XcsYmz7HmC3PnEkPQkAFWRD2FiEbOZNJKY3/+fNGx8QgmcUAHApUv1xoBeohEQitFqpF
         u0gvCbTq9ozepg7lHFFb5Tf4/fYjSztwJgAGZGp6Yh7nSmJxN4Vn6Sl3mJ31qmnMoMrW
         mwag==
X-Gm-Message-State: AOJu0Yy8OEz7GyMCYHuLxaM/j/iFrtDqevIV+XaP6OunHV5igKwYir0I
	XxMknwmpWY5Cwz3SL9uApdaHjpAydjMxGNTVqFLSgSkjm5watiYyGAhEFQ==
X-Google-Smtp-Source: AGHT+IE6sxQ6HC+Ur4oHroIIGtU5CxzpRNzyQOsiNjjsmDWj0tCs9gRqRzib7MOrOfBd79LB3Hji4Q==
X-Received: by 2002:adf:e586:0:b0:34d:a4b4:9f60 with SMTP id l6-20020adfe586000000b0034da4b49f60mr6222745wrm.52.1714934955719;
        Sun, 05 May 2024 11:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4303000000b0034f145b60ebsm1421475wrq.3.2024.05.05.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:49:15 -0700 (PDT)
Message-Id: <d8b3f6229bcdfb487bfb7941f54ce5cb6e44f088.1714934950.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
	<pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 May 2024 18:49:10 +0000
Subject: [PATCH v5 3/3] builtin/tag: add --trailer option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

git-tag supports interpreting trailers from an annotated tag message,
using --list --format="%(trailers)". However, the available methods to
add a trailer to a tag message (namely -F or --editor) are not as
ergonomic.

In a previous patch, we moved git-commit's implementation of its
--trailer option to the trailer.h API. Let's use that new function to
teach git-tag the same --trailer option, emulating as much of
git-commit's behavior as much as possible.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 Documentation/git-tag.txt |  16 +++++-
 builtin/tag.c             |  38 ++++++++++---
 t/t7004-tag.sh            | 114 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5fe519c31ec..4494729f5e1 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
+	[(--trailer <token>[(=|:)<value>])...]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
@@ -31,8 +32,8 @@ creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
 in the tag message.
 
-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
-are absent, `-a` is implied.
+If `-m <msg>` or `-F <file>` or `--trailer <token>[=<value>]` is given
+and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is implied.
 
 Otherwise, a tag reference that points directly at the given object
 (i.e., a lightweight tag) is created.
@@ -178,6 +179,17 @@ This option is only applicable when listing tags without annotation lines.
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g. `git tag --trailer "Custom-Key: value"`
+	will add a "Custom-Key" trailer to the tag message.)
+	The `trailer.*` configuration variables
+	(linkgit:git-interpret-trailers[1]) can be used to define if
+	a duplicated trailer is omitted, where in the run of trailers
+	each trailer would appear, and other details.
+	The trailers can be extracted in `git tag --list`, using
+	`--format="%(trailers)"` placeholder.
+
 -e::
 --edit::
 	The message taken from file with `-F` and command line with
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a33cb50b45..01b19a5b6c9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -28,9 +28,11 @@
 #include "date.h"
 #include "write-or-die.h"
 #include "object-file-convert.h"
+#include "trailer.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+	   "        [(--trailer <token>[(=|:)<value>])...]\n"
 	   "        <tagname> [<commit> | <object>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
@@ -290,10 +292,12 @@ static const char message_advice_nested_tag[] =
 static void create_tag(const struct object_id *object, const char *object_ref,
 		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       struct object_id *prev, struct object_id *result, char *path)
+		       struct object_id *prev, struct object_id *result,
+		       struct strvec *trailer_args, char *path)
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
+	int should_edit;
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
@@ -313,13 +317,15 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		    tag,
 		    git_committer_info(IDENT_STRICT));
 
-	if (!opt->message_given || opt->use_editor) {
+	should_edit = opt->use_editor || !opt->message_given;
+	if (should_edit || trailer_args->nr) {
 		int fd;
 
 		/* write the template message before editing: */
 		fd = xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
-		if (opt->message_given) {
+		if (opt->message_given && buf->len) {
+			strbuf_complete(buf, '\n');
 			write_or_die(fd, buf->buf, buf->len);
 			strbuf_reset(buf);
 		} else if (!is_null_oid(prev)) {
@@ -338,10 +344,19 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		}
 		close(fd);
 
-		if (launch_editor(path, buf, NULL)) {
-			fprintf(stderr,
-			_("Please supply the message using either -m or -F option.\n"));
-			exit(1);
+		if (trailer_args->nr && amend_file_with_trailers(path, trailer_args))
+			die(_("unable to pass trailers to --trailers"));
+
+		if (should_edit) {
+			if (launch_editor(path, buf, NULL)) {
+				fprintf(stderr,
+					_("Please supply the message using either -m or -F option.\n"));
+				exit(1);
+			}
+		} else if (trailer_args->nr) {
+			strbuf_reset(buf);
+			if (strbuf_read_file(buf, path, 0) < 0)
+				die_errno(_("failed to read '%s'"), path);
 		}
 	}
 
@@ -463,6 +478,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strvec trailer_args = STRVEC_INIT;
 	int icase = 0;
 	int edit_flag = 0;
 	struct option options[] = {
@@ -479,6 +495,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
+		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
+				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
@@ -548,7 +566,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
+	create_tag_object = (opt.sign || annotate || msg.given || msgfile ||
+			     edit_flag || trailer_args.nr);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -654,7 +673,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			opt.sign = 1;
 		path = git_pathdup("TAG_EDITMSG");
 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
-			   path);
+			   &trailer_args, path);
 	}
 
 	transaction = ref_transaction_begin(&err);
@@ -686,6 +705,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&msg.buf);
 	strbuf_release(&err);
+	strvec_clear(&trailer_args);
 	free(msgfile);
 	return ret;
 }
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 696866d7794..fa6336edf98 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -668,6 +668,115 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+# trailers
+
+test_expect_success 'create tag with -m and --trailer' '
+	get_tag_header tag-with-inline-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	create tag with trailers
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	git tag -m "create tag with trailers" \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-inline-message-and-trailers &&
+	get_tag_msg tag-with-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'list tag extracting trailers' '
+	cat >expect <<-\EOF &&
+	my-trailer: here
+	alt-trailer: there
+
+	EOF
+	git tag --list --format="%(trailers)" tag-with-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create tag with -F and --trailer' '
+	echo "create tag from message file using --trailer" >messagefilewithnotrailers &&
+	get_tag_header tag-with-file-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	create tag from message file using --trailer
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	git tag -F messagefilewithnotrailers \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-file-message-and-trailers &&
+	get_tag_msg tag-with-file-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create tag with -m and --trailer and --edit' '
+	write_script fakeeditor <<-\EOF &&
+	sed -e "1s/^/EDITED: /g" <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+	get_tag_header tag-with-edited-inline-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	EDITED: create tag with trailers
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	GIT_EDITOR=./fakeeditor git tag --edit \
+		-m "create tag with trailers" \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-edited-inline-message-and-trailers &&
+	get_tag_msg tag-with-edited-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create tag with -F and --trailer and --edit' '
+	echo "create tag from message file using --trailer" >messagefilewithnotrailers &&
+	get_tag_header tag-with-edited-file-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	EDITED: create tag from message file using --trailer
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	GIT_EDITOR=./fakeeditor git tag --edit \
+		-F messagefilewithnotrailers \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-edited-file-message-and-trailers &&
+	get_tag_msg tag-with-edited-file-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create annotated tag and force editor when only --trailer is given' '
+	write_script fakeeditor <<-\EOF &&
+	echo "add a line" >"$1-"
+	cat <"$1" >>"$1-"
+	mv "$1-" "$1"
+	EOF
+	get_tag_header tag-with-trailers-and-no-message $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	add a line
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	GIT_EDITOR=./fakeeditor git tag \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-trailers-and-no-message &&
+	get_tag_msg tag-with-trailers-and-no-message >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bad editor causes panic when only --trailer is given' '
+	test_must_fail env GIT_EDITOR=false git tag --trailer my-trailer=here tag-will-not-exist
+'
+
 # listing messages for annotated non-signed tags:
 
 test_expect_success \
@@ -810,6 +919,11 @@ test_expect_success 'git tag --format with ahead-behind' '
 	refs/tags/tag-lines 0 1 !
 	refs/tags/tag-one-line 0 1 !
 	refs/tags/tag-right 0 0 !
+	refs/tags/tag-with-edited-file-message-and-trailers 0 1 !
+	refs/tags/tag-with-edited-inline-message-and-trailers 0 1 !
+	refs/tags/tag-with-file-message-and-trailers 0 1 !
+	refs/tags/tag-with-inline-message-and-trailers 0 1 !
+	refs/tags/tag-with-trailers-and-no-message 0 1 !
 	refs/tags/tag-zero-lines 0 1 !
 	EOF
 	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&
-- 
gitgitgadget
