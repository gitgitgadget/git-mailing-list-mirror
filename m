Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30177EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjGESA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjGESAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:54 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE519AA
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:00:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b7541d885cso5729115a34.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688580041; x=1691172041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhHAAFNomLLemeXzx0+zZGIiImAlYqIrAFRmCBWhEq0=;
        b=fOpscigl4Nwyry7gm9rdnkNTLU6iyEGRScsxoC1MPArdxFUq6pPFjNXsCEiziz66g+
         k8VHR1yZo7sxz2eKAFlcpTj9vLWNt8rupd+kUDaBh8/VBN3oz2i4ZWUVRn0qSSPOItAk
         oP7TKqAcJ7KHsf8INRucIlQ7641WOf1iCT7Z9Gk7QuXZWQPmJhVGikNHiPkXrOml4wL5
         4t1zRdCjip9ku7so5io6TgAU3UTTAqBRKh1XCU7oymOnLO+5YC4DHFV2y4nEzUs+8Ihf
         jO81/OYkjYiuVWimyaXVMcuey7npQb1rAPEM5TW5gKPrIzkPKMorFEP0GXrlYy88LM/b
         muow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580041; x=1691172041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhHAAFNomLLemeXzx0+zZGIiImAlYqIrAFRmCBWhEq0=;
        b=LFV7nhO/MEvqm93ub2OSK+PNNJ/a1rx3Fw/gdhoNt0tcKEcc0vjQClpd0Ae5YJBnXK
         iePkoetxYPO/Jj1D872H0NJtRBwprmJAUy9wpsMQkLn+TfNkc22RXJoq+kmjZfXKLHve
         IS36NMeEWPwK/iVdZmaIIirJFwrIu5+ycOraW5h5bQNEaJ4myxG8AiCB6Upw5BPcPgC+
         PaQ9m8EZQ07DjOU+dwj8FYgUkhgitCnX6m1+gHyuv5VkZA5Njaoi6Y+CHLzyj732JCkE
         S4oLboq55UtMKUMpEB4glewwWtBsJxmndYG9/RWcyWguX2wpVjUSv/62uqxNFI1a0tmz
         hEuA==
X-Gm-Message-State: AC+VfDxwpty7bU6E35cqrj0PjNPxmiS8uIJxOITeaXhLmMIVSIXdGEsW
        7kgmVUHViZGeLfOuUHZ890s+tb+iR0e/yA==
X-Google-Smtp-Source: ACHHUZ6Kudtr8TE+FBxWLx73WHHk53z8oatMEV/sFXJUOajz/C10kuppdBW6NluEh9br6QdZPL9PhA==
X-Received: by 2002:a9d:69c5:0:b0:6b7:4b0e:6d48 with SMTP id v5-20020a9d69c5000000b006b74b0e6d48mr16053407oto.24.1688580041301;
        Wed, 05 Jul 2023 11:00:41 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.68])
        by smtp.gmail.com with ESMTPSA id 18-20020a631452000000b005539d676060sm18194010pgu.29.2023.07.05.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:00:41 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Rene Scharfe <l.s.r@web.de>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH 1/2] ref-filter: add new "describe" atom
Date:   Wed,  5 Jul 2023 23:27:11 +0530
Message-ID: <20230705175942.21090-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230705175942.21090-1-five231003@gmail.com>
References: <20230705175942.21090-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duplicate the logic of %(describe) and friends from pretty to
ref-filter. In the future, this change helps in unifying both the
formats as ref-filter will be able to do everything that pretty is doing
and we can have a single interface.

The new atom "describe" and its friends are equivalent to the existing
pretty formats with the same name.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |  19 ++++
 ref-filter.c                       | 144 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  85 +++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1e215d4e73..4ac5c3dac4 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -231,6 +231,25 @@ ahead-behind:<committish>::
 	commits ahead and behind, respectively, when comparing the output
 	ref to the `<committish>` specified in the format.
 
+describe[:options]:: human-readable name, like
+		     link-git:git-describe[1]; empty string for
+		     undescribable commits. The `describe` string may be
+		     followed by a colon and zero or more comma-separated
+		     options. Descriptions can be inconsistent when tags
+		     are added or removed at the same time.
++
+** tags=<bool-value>: Instead of only considering annotated tags, consider
+		      lightweight tags as well.
+** abbrev=<number>: Instead of using the default number of hexadecimal digits
+		    (which will vary according to the number of objects in the
+		    repository with a default of 7) of the abbreviated
+		    object name, use <number> digits, or as many digits as
+		    needed to form a unique object name.
+** match=<pattern>: Only consider tags matching the given `glob(7)` pattern,
+		    excluding the "refs/tags/" prefix.
+** exclude=<pattern>: Do not consider tags matching the given `glob(7)`
+		      pattern,excluding the "refs/tags/" prefix.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index e0d03a9f8e..6ec647c81f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -5,6 +5,7 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
@@ -146,6 +147,7 @@ enum atom_type {
 	ATOM_TAGGERDATE,
 	ATOM_CREATOR,
 	ATOM_CREATORDATE,
+	ATOM_DESCRIBE,
 	ATOM_SUBJECT,
 	ATOM_BODY,
 	ATOM_TRAILERS,
@@ -215,6 +217,13 @@ static struct used_atom {
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
+		struct {
+			enum { D_BARE, D_TAGS, D_ABBREV, D_EXCLUDE,
+			       D_MATCH } option;
+			unsigned int tagbool;
+			unsigned int length;
+			char *pattern;
+		} describe;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -462,6 +471,66 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
+static int parse_describe_option(const char *arg)
+{
+	if (!arg)
+		return D_BARE;
+	else if (starts_with(arg, "tags"))
+		return D_TAGS;
+	else if (starts_with(arg, "abbrev"))
+		return D_ABBREV;
+	else if(starts_with(arg, "exclude"))
+		return D_EXCLUDE;
+	else if (starts_with(arg, "match"))
+		return D_MATCH;
+	return -1;
+}
+
+static int describe_atom_parser(struct ref_format *format UNUSED,
+				struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	int opt = parse_describe_option(arg);
+
+	switch (opt) {
+	case D_BARE:
+		break;
+	case D_TAGS:
+		/*
+		 * It is also possible to just use describe:tags, which
+		 * is just treated as describe:tags=1
+		 */
+		if (skip_prefix(arg, "tags=", &arg)) {
+			if (strtoul_ui(arg, 10, &atom->u.describe.tagbool))
+				return strbuf_addf_ret(err, -1, _("boolean value "
+						"expected describe:tags=%s"), arg);
+
+		} else {
+			atom->u.describe.tagbool = 1;
+		}
+		break;
+	case D_ABBREV:
+		skip_prefix(arg, "abbrev=", &arg);
+		if (strtoul_ui(arg, 10, &atom->u.describe.length))
+			return strbuf_addf_ret(err, -1, _("positive value "
+					       "expected describe:abbrev=%s"), arg);
+		break;
+	case D_EXCLUDE:
+		skip_prefix(arg, "exclude=", &arg);
+		atom->u.describe.pattern = xstrdup(arg);
+		break;
+	case D_MATCH:
+		skip_prefix(arg, "match=", &arg);
+		atom->u.describe.pattern = xstrdup(arg);
+		break;
+	default:
+		return err_bad_arg(err, "describe", arg);
+		break;
+	}
+	atom->u.describe.option = opt;
+	return 0;
+}
+
 static int raw_atom_parser(struct ref_format *format UNUSED,
 			   struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
@@ -664,6 +733,7 @@ static struct {
 	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
 	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
 	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
@@ -1483,6 +1553,78 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 	}
 }
 
+static void grab_describe_values(struct atom_value *val, int deref,
+				 struct object *obj)
+{
+	struct commit *commit = (struct commit *)obj;
+	int i;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
+		struct atom_value *v = &val[i];
+		int opt;
+
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+
+		if (!skip_prefix(name, "describe", &name) ||
+		    (*name && *name != ':'))
+			    continue;
+		if (!*name)
+			name = NULL;
+		else
+			name++;
+
+		opt = parse_describe_option(name);
+		if (opt < 0)
+			continue;
+
+		cmd.git_cmd = 1;
+		strvec_push(&cmd.args, "describe");
+
+		switch(opt) {
+		case D_BARE:
+			break;
+		case D_TAGS:
+			if (atom->u.describe.tagbool)
+				strvec_push(&cmd.args, "--tags");
+			else
+				strvec_push(&cmd.args, "--no-tags");
+			break;
+		case D_ABBREV:
+			strvec_pushf(&cmd.args, "--abbrev=%d",
+				     atom->u.describe.length);
+			break;
+		case D_EXCLUDE:
+			strvec_pushf(&cmd.args, "--exclude=%s",
+				     atom->u.describe.pattern);
+			break;
+		case D_MATCH:
+			strvec_pushf(&cmd.args, "--match=%s",
+				     atom->u.describe.pattern);
+			break;
+		}
+
+		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
+		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
+			error(_("failed to run 'describe'"));
+			v->s = xstrdup("");
+			continue;
+		}
+		strbuf_rtrim(&out);
+		v->s = strbuf_detach(&out, NULL);
+
+		strbuf_release(&err);
+	}
+}
+
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
@@ -1592,12 +1734,14 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5c00607608..98ea37d336 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -561,6 +561,91 @@ test_expect_success 'color.ui=always does not override tty check' '
 	test_cmp expected.bare actual
 '
 
+test_expect_success 'describe atom vs git describe' '
+	test_when_finished "rm -rf describe-repo" &&
+
+	git init describe-repo &&
+	(
+		cd describe-repo &&
+
+		test_commit --no-tag one &&
+		git tag tagone &&
+
+		test_commit --no-tag two &&
+		git tag -a -m "tag two" tagtwo &&
+
+		git for-each-ref refs/tags/ --format="%(objectname)" >obj &&
+		while read hash
+		do
+			if desc=$(git describe $hash)
+			then
+				: >expect-contains-good
+			else
+				: >expect-contains-bad
+			fi &&
+			echo "$hash $desc" || return 1
+		done <obj >expect &&
+		test_path_exists expect-contains-good &&
+		test_path_exists expect-contains-bad &&
+
+		git for-each-ref --format="%(objectname) %(describe)" \
+			refs/tags/ >actual 2>err &&
+		test_cmp expect actual &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'describe:tags vs describe --tags' '
+	test_when_finished "git tag -d tagname" &&
+	git tag tagname &&
+	git describe --tags >expect &&
+	git for-each-ref --format="%(describe:tags)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
+	test_when_finished "git tag -d tagname" &&
+
+	# Case 1: We have commits between HEAD and the most
+	#         recent tag reachable from it
+	test_commit --no-tag file &&
+	git describe --abbrev=14 >expect &&
+	git for-each-ref --format="%(describe:abbrev=14)" \
+		refs/heads/ >actual &&
+	test_cmp expect actual &&
+
+	# Make sure the hash used is atleast 14 digits long
+	sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+	test 15 -le $(wc -c <hexpart) &&
+
+	# Case 2: We have a tag at HEAD, describe directly gives
+	#         the name of the tag
+	git tag -a -m tagged tagname &&
+	git describe --abbrev=14 >expect &&
+	git for-each-ref --format="%(describe:abbrev=14)" \
+		refs/heads/ >actual &&
+	test_cmp expect actual &&
+	test tagname = $(cat actual)
+'
+
+test_expect_success 'describe:match=... vs describe --match ...' '
+	test_when_finished "git tag -d tag-match" &&
+	git tag -a -m "tag match" tag-match &&
+	git describe --match "*-match" >expect &&
+	git for-each-ref --format="%(describe:match="*-match")" \
+		refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe:exclude:... vs describe --exclude ...' '
+	test_when_finished "git tag -d tag-exclude" &&
+	git tag -a -m "tag exclude" tag-exclude &&
+	git describe --exclude "*-exclude" >expect &&
+	git for-each-ref --format="%(describe:exclude="*-exclude")" \
+		refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<\EOF
 heads/main
 tags/main
-- 
2.41.0.237.g2d10a112d6.dirty

