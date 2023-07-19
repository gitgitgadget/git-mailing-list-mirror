Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA49C001DE
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 16:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGSQY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGSQY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 12:24:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DEE1734
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:24:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66869feb7d1so4830135b3a.3
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689783893; x=1692375893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbZn6gbhh/90Xwi93reMNeMrL7ZJf7X2/hS5ULsjP5Y=;
        b=RPjCwOj2z8p1AGIOpbjLXMASMwTWn0hPwmkqRkxAAHNGqhPmOjvs6IcyfVw3HER9TV
         C6rIWxKm2NeRcBIN1hi2Fw6iUmWLyvTGTYwnDSjnqRkQZ22c7H9opNz9vYrzmfk4//AE
         g7d6yktus3jxMwXsKN0cgf74RalZY0NN7y7DXaX4YKAxPuonXhPRv6+UC+ENiy4RavXm
         EOhbBMS6JOpmY6TcaEuhaL8A10U648zflsK0IlRu6f+dmY58eSReRggxu4wL11i4+gz1
         dVSZROXVEu+v4SwhTm06DeEpMzYj1hNuk6AUJ01nLvHhhjK9O8OtOWlDhzJsxjlrtjID
         T3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783893; x=1692375893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbZn6gbhh/90Xwi93reMNeMrL7ZJf7X2/hS5ULsjP5Y=;
        b=Iv0taTERL0ANhND8TJrSF9p3Z0MOmf43vdK5Odaj6zYUxPEKRIEFAQZbEeFnEU1uVB
         SHgutYiKxFqrzPqJcPcLVOLIPPyOrB1Wtd8Ljkr0L/31Eb+1JZ58HxiDkujrXjKNQMsx
         2xlpNSZx/qBoCJV5mEP1kHr2cfIebBEQoa9X3gJKyEXL75AEfjWdhw+pnrZyi3EtP/s5
         YNPx0Y+ooBjH2p97acliq+9jVodzNCuLmcAHgA0QAjNzP58fjhOz9W5HoDEqIA3Hc4XA
         fk5WRbA2XDaRy0+QOa6qBv4L1cgEH+GUlNp0W2UMf28P8FG9NNK2imZCZbbrz+jrs0Rv
         3DDw==
X-Gm-Message-State: ABy/qLayA5wTSpjDf3a8AeuHZI1dVott1fpp/TBZyuA3fn2Tt4CNGhyA
        ncRYg5VWSm8l7JluWOvSDcN1d132VcReiA+7
X-Google-Smtp-Source: APBJJlF5JU3AIyeJAzMLYJ35Bdrp2qHcaT9HFaeRLAMG89YGyUSnWoWkkBZAEuhq6JA43dbibzEo6Q==
X-Received: by 2002:a05:6a20:1589:b0:134:589a:c0fc with SMTP id h9-20020a056a20158900b00134589ac0fcmr3875013pzj.32.1689783893338;
        Wed, 19 Jul 2023 09:24:53 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.156.16])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0067b643b814csm3484907pfb.6.2023.07.19.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:24:53 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v3 2/2] ref-filter: add new "describe" atom
Date:   Wed, 19 Jul 2023 21:45:06 +0530
Message-ID: <20230719162424.70781-3-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.378.g42703afc1f.dirty
In-Reply-To: <20230719162424.70781-1-five231003@gmail.com>
References: <20230714194249.66862-1-five231003@gmail.com>
 <20230719162424.70781-1-five231003@gmail.com>
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
 Documentation/git-for-each-ref.txt |  23 +++++
 ref-filter.c                       | 130 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 114 +++++++++++++++++++++++++
 3 files changed, 267 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2e0318770b..395daf1b22 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -258,6 +258,29 @@ ahead-behind:<committish>::
 	commits ahead and behind, respectively, when comparing the output
 	ref to the `<committish>` specified in the format.
 
+describe[:options]:: Human-readable name, like
+		     link-git:git-describe[1]; empty string for
+		     undescribable commits. The `describe` string may be
+		     followed by a colon and zero or more comma-separated
+		     options. Descriptions can be inconsistent when tags
+		     are added or removed at the same time.
++
+--
+tags=<bool-value>;; Instead of only considering annotated tags, consider
+		    lightweight tags as well; see the corresponding option
+		    in linkgit:git-describe[1] for details.
+abbrev=<number>;; Use at least <number> hexadecimal digits; see
+		  the corresponding option in linkgit:git-describe[1]
+		  for details.
+match=<pattern>;; Only consider tags matching the given `glob(7)` pattern,
+		  excluding the "refs/tags/" prefix; see the corresponding
+		  option in linkgit:git-describe[1] for details.
+exclude=<pattern>;; Do not consider tags matching the given `glob(7)`
+		    pattern, excluding the "refs/tags/" prefix; see the
+		    corresponding option in linkgit:git-describe[1] for
+		    details.
+--
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index f64437e781..43316643be 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,9 +1,11 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
+#include "config.h"
 #include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
@@ -145,6 +147,7 @@ enum atom_type {
 	ATOM_TAGGERDATE,
 	ATOM_CREATOR,
 	ATOM_CREATORDATE,
+	ATOM_DESCRIBE,
 	ATOM_SUBJECT,
 	ATOM_BODY,
 	ATOM_TRAILERS,
@@ -219,6 +222,7 @@ static struct used_atom {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
+		const char **describe_args;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -554,6 +558,91 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
+static int describe_atom_option_parser(struct strvec *args, const char **arg,
+				       struct strbuf *err)
+{
+	const char *argval;
+	size_t arglen = 0;
+	int optval = 0;
+
+	if (match_atom_bool_arg(*arg, "tags", arg, &optval)) {
+		if (!optval)
+			strvec_push(args, "--no-tags");
+		else
+			strvec_push(args, "--tags");
+		return 1;
+	}
+
+	if (match_atom_arg_value(*arg, "abbrev", arg, &argval, &arglen)) {
+		char *endptr;
+
+		if (!arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("argument expected for %s"),
+					       "describe:abbrev");
+		if (strtol(argval, &endptr, 10) < 0)
+			return strbuf_addf_ret(err, -1,
+					       _("positive value expected %s=%s"),
+					       "describe:abbrev", argval);
+		if (endptr - argval != arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("cannot fully parse %s=%s"),
+					       "describe:abbrev", argval);
+
+		strvec_pushf(args, "--abbrev=%.*s", (int)arglen, argval);
+		return 1;
+	}
+
+	if (match_atom_arg_value(*arg, "match", arg, &argval, &arglen)) {
+		if (!arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("value expected %s="),
+					       "describe:match");
+
+		strvec_pushf(args, "--match=%.*s", (int)arglen, argval);
+		return 1;
+	}
+
+	if (match_atom_arg_value(*arg, "exclude", arg, &argval, &arglen)) {
+		if (!arglen)
+			return strbuf_addf_ret(err, -1,
+					       _("value expected %s="),
+					       "describe:exclude");
+
+		strvec_pushf(args, "--exclude=%.*s", (int)arglen, argval);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int describe_atom_parser(struct ref_format *format UNUSED,
+				struct used_atom *atom,
+				const char *arg, struct strbuf *err)
+{
+	struct strvec args = STRVEC_INIT;
+
+	for (;;) {
+		int found = 0;
+		const char *bad_arg = NULL;
+
+		if (!arg || !*arg)
+			break;
+
+		bad_arg = arg;
+		found = describe_atom_option_parser(&args, &arg, err);
+		if (found < 0)
+			return found;
+		if (!found) {
+			if (bad_arg && *bad_arg)
+				return err_bad_arg(err, "describe", bad_arg);
+			break;
+		}
+	}
+	atom->u.describe_args = strvec_detach(&args);
+	return 0;
+}
+
 static int raw_atom_parser(struct ref_format *format UNUSED,
 			   struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
@@ -756,6 +845,7 @@ static struct {
 	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
 	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
 	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
 	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
@@ -1662,6 +1752,44 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
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
+		enum atom_type type = atom->atom_type;
+		const char *name = atom->name;
+		struct atom_value *v = &val[i];
+
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		if (type != ATOM_DESCRIBE)
+			continue;
+
+		if (!!deref != (*name == '*'))
+			continue;
+
+		cmd.git_cmd = 1;
+		strvec_push(&cmd.args, "describe");
+		strvec_pushv(&cmd.args, atom->u.describe_args);
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
@@ -1771,6 +1899,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
@@ -1778,6 +1907,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
 		grab_signature(val, deref, obj);
+		grab_describe_values(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6e6ec852b5..4bbba76874 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -562,6 +562,120 @@ test_expect_success 'color.ui=always does not override tty check' '
 	test_cmp expected.bare actual
 '
 
+test_expect_success 'setup for describe atom tests' '
+	git init describe-repo &&
+	(
+		cd describe-repo &&
+
+		test_commit --no-tag one &&
+		git tag tagone &&
+
+		test_commit --no-tag two &&
+		git tag -a -m "tag two" tagtwo
+	)
+'
+
+test_expect_success 'describe atom vs git describe' '
+	(
+		cd describe-repo &&
+
+		git for-each-ref --format="%(objectname)" \
+			refs/tags/ >obj &&
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
+	(
+		cd describe-repo &&
+		git describe --tags >expect &&
+		git for-each-ref --format="%(describe:tags)" \
+				refs/heads/master >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
+	(
+		cd describe-repo &&
+
+		# Case 1: We have commits between HEAD and the most
+		#	  recent tag reachable from it
+		test_commit --no-tag file &&
+		git describe --abbrev=14 >expect &&
+		git for-each-ref --format="%(describe:abbrev=14)" \
+			refs/heads/master >actual &&
+		test_cmp expect actual &&
+
+		# Make sure the hash used is atleast 14 digits long
+		sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+		test 15 -le $(wc -c <hexpart) &&
+
+		# Case 2: We have a tag at HEAD, describe directly gives
+		#	  the name of the tag
+		git tag -a -m tagged tagname &&
+		git describe --abbrev=14 >expect &&
+		git for-each-ref --format="%(describe:abbrev=14)" \
+			refs/heads/master >actual &&
+		test_cmp expect actual &&
+		test tagname = $(cat actual)
+	)
+'
+
+test_expect_success 'describe:match=... vs describe --match ...' '
+	(
+		cd describe-repo &&
+		git tag -a -m "tag foo" tag-foo &&
+		git describe --match "*-foo" >expect &&
+		git for-each-ref --format="%(describe:match="*-foo")" \
+			refs/heads/master >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'describe:exclude:... vs describe --exclude ...' '
+	(
+		cd describe-repo &&
+		git tag -a -m "tag bar" tag-bar &&
+		git describe --exclude "*-bar" >expect &&
+		git for-each-ref --format="%(describe:exclude="*-bar")" \
+			refs/heads/master >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'deref with describe atom' '
+	(
+		cd describe-repo &&
+		cat >expect <<-\EOF &&
+
+		tagname
+		tagname
+		tagname
+
+		tagtwo
+		EOF
+		git for-each-ref --format="%(*describe)" >actual &&
+		test_cmp expect actual
+	)
+'
+
 cat >expected <<\EOF
 heads/main
 tags/main
-- 
2.41.0.378.g42703afc1f.dirty

