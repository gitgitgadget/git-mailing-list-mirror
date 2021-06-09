Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF6C48BD1
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A3F61375
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhFIQPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:15:01 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46703 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbhFIQPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 12:15:00 -0400
Received: by mail-wr1-f51.google.com with SMTP id a11so24250280wrt.13
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kqWel9z3Hvyqb4Y3h2V+hnS5XlLoK+zT/HLm6vFLVMM=;
        b=urnk6Nhty0oeoyFbwuiIKDnDnqXKe/a0WHdVPbrilo3h5wKblia7vKSpkHeXgfgOKS
         8ZpcqcA7BxAkoZUvpuLTUZCtnVSATsYYXfkxFCYNdqsD+hqTMSKhL8Jue9l32eaHt+MB
         rgA825qz6dfs9oeCY7xH/d/Q1q4Tq+C3iIFWCq925ZtbhwaUTpzTPh23ZJSTSswP3fHv
         fONHAL59lzYVh7kbS9rt8y7Nkk2Tu+RwXttyWMxM18uqlAyBOa9mD+CuFeaU7ndG2KOP
         BPWV5iiPhy8NpSMkqk7EO9hAi8aLEBpPh3et71gdvEjPvHnvJcz1gnCNSnkph5Sse8oJ
         WKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kqWel9z3Hvyqb4Y3h2V+hnS5XlLoK+zT/HLm6vFLVMM=;
        b=YqvtoheyI8hmxQXEuATUn+L3BYJDu6Wz9jsvMBVoQVgKW4b+9KvcKhejN8p2k0cgC9
         0jmkRbIbGde0noFq+Qq+PhpYwy45l2aRvUWwxGuKo0+Tt5uFk7V+8nULJ4Zx2WWJboH5
         S/ezTiXq02SN4OOMH2CW32b3k+EaLCHRnN1cp9sns8S6An66zTAs6I/rf8jlbsDUKBsP
         7MpXWdU1yywxRNBViOu68SPNwCnXWfGHrLlfe0wCLyUKABxDF29xEM/sRQUR0VLVQjsc
         GVg2CmBm/hsPmwk8eBODdrDmhlVh7VUdmrjZiMor35seAubp1q9K45ZpZ/Rrj38Eq4h6
         89wA==
X-Gm-Message-State: AOAM530q2Wg21q83kTKUDNuHnkbelihHzRW5xIQ01q2eakZlulLqdotY
        eP8GEvYaWXDhisXGgQqG64inAiDjsJw=
X-Google-Smtp-Source: ABdhPJwVCnayreBZHNvTDDibdn41hm8C0K58E6NB9HBT0ev5s+tNhjcR2X7FoWkkj5PxFJUJeG6Kyw==
X-Received: by 2002:adf:f946:: with SMTP id q6mr562445wrr.283.1623255125499;
        Wed, 09 Jun 2021 09:12:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm356655wrz.91.2021.06.09.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:12:05 -0700 (PDT)
Message-Id: <5a5b5f78aeeac1f541852dc219d617530fbe87ea.1623255121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.976.v2.git.1623255121.gitgitgadget@gmail.com>
References: <pull.976.git.1623163082.gitgitgadget@gmail.com>
        <pull.976.v2.git.1623255121.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 16:12:01 +0000
Subject: [PATCH v2 4/4] [GSOC] ref-filter: add %(rest) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let "cat-file --batch=%(rest)" use the ref-filter
interface, add %(rest) atom for ref-filter. "git for-each-ref",
"git branch", "git tag" and "git verify-tag" will reject %(rest)
by default.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c             | 21 +++++++++++++++++++++
 ref-filter.h             |  5 ++++-
 t/t3203-branch-output.sh |  4 ++++
 t/t6300-for-each-ref.sh  |  4 ++++
 t/t7004-tag.sh           |  4 ++++
 t/t7030-verify-tag.sh    |  4 ++++
 6 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index af8c15aef44d..8868cf98f090 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -157,6 +157,7 @@ enum atom_type {
 	ATOM_IF,
 	ATOM_THEN,
 	ATOM_ELSE,
+	ATOM_REST,
 };
 
 /*
@@ -559,6 +560,15 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
+static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
+			    const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
+	format->use_rest = 1;
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *unused_err)
 {
@@ -615,6 +625,7 @@ static struct {
 	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
 	[ATOM_THEN] = { "then", SOURCE_NONE },
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
+	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -1006,6 +1017,9 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		if (used_atom[at].atom_type == ATOM_REST)
+			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
+
 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
 		    used_atom[at].u.raw_data.option == RAW_BARE)
 			die(_("--format=%.*s cannot be used with"
@@ -1920,6 +1934,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			v->handler = else_atom_handler;
 			v->s = xstrdup("");
 			continue;
+		} else if (atom_type == ATOM_REST) {
+			if (ref->rest)
+				v->s = xstrdup(ref->rest);
+			else
+				v->s = xstrdup("");
+			continue;
 		} else
 			continue;
 
@@ -2137,6 +2157,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
+	ref->rest = NULL;
 
 	return ref;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 74fb423fc89f..9dc07476a584 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -38,6 +38,7 @@ struct ref_sorting {
 
 struct ref_array_item {
 	struct object_id objectname;
+	const char *rest;
 	int flag;
 	unsigned int kind;
 	const char *symref;
@@ -76,14 +77,16 @@ struct ref_format {
 	 * verify_ref_format() afterwards to finalize.
 	 */
 	const char *format;
+	const char *rest;
 	int quote_style;
+	int use_rest;
 	int use_color;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, 0, -1 }
+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 5325b9f67a00..2780ec8803fd 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -340,6 +340,10 @@ test_expect_success 'git branch --format option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch with --format=%(rest) must failed' '
+	test_must_fail git branch --format="%(rest)" >actual
+'
+
 test_expect_success 'worktree colors correct' '
 	cat >expect <<-EOF &&
 	* <GREEN>(HEAD detached from fromtag)<RESET>
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e2867de791e7..8c97c3b877c6 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1187,6 +1187,10 @@ test_expect_success 'basic atom: head contents:trailers' '
 	test_cmp expect actual.clean
 '
 
+test_expect_success 'basic atom: rest must failed' '
+	test_must_fail git for-each-ref --format="%(rest)" refs/heads/main
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2f72c5c6883e..9fc4c4323949 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1998,6 +1998,10 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git tag -l with --format="%(rest)" must failed' '
+	test_must_fail git tag -l --format="%(rest)" "v1*"
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 3cefde9602bf..785b32eb88f9 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -194,6 +194,10 @@ test_expect_success GPG 'verifying tag with --format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'verifying tag with --format="%(rest)" must failed' '
+	test_must_fail git verify-tag --format="%(rest)" "fourth-signed"
+'
+
 test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_must_be_empty actual-forged
-- 
gitgitgadget
