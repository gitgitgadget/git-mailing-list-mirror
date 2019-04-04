Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F5020248
	for <e@80x24.org>; Thu,  4 Apr 2019 18:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfDDSZU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 14:25:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDSZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 14:25:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so1784520pfd.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=66rmuq/I87nnCpjZT+impxrxLiLggzofWwhXUPAIo60=;
        b=U5lcF+3ffsUmBE8QH8MVtnKnS1aV61cC/VrN6GuQ4tMp912WLA06lZlUAuxa9rkwzl
         FTO4QI4HV8GBGKLR895N748EpS6nQ4mqn5yIoLfJ4RF/AJpfBcTvt0O/k4aPhNo8tijO
         dZPY25WJ0mRh11XO8ktgkL/Rn1/+UhCaKEqFW0zM8LEGGFuYvkr/ekN02DOsASkf19fX
         t5dZ3CB+fy+w6sOM9plJmxv+BiWZMSq2Oa5ARpbKR0JQZqxvSTBr/R+6sRa+rDdWMuVI
         5Va5nNto1RkrbhTtcQgq+7b1gc44mZUik9Dhvv+iMg8e1QqSrocI7io7k6WtLVqG38hd
         GT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=66rmuq/I87nnCpjZT+impxrxLiLggzofWwhXUPAIo60=;
        b=Fhn1rrI3LaSHCGU9AXWVFCs+bDD6tL0yU/+rCY2gC2O7od0GnEo5pgxptZXL3T4MAa
         nTiiKXxjjpVcHzBdJBf19hhMlMSUlY1fSDmlvidNEs8aSYcQ/fusZa6eYIsgRoo2ZR/B
         tzw33o3JgteBFM2/t8jTetiI5TQHWaBcgSQPQZIrCRSpILoXc/uG1KNnYoJ4ypmFwuxP
         OPUvbh+2DR/eYlc1q0h+62b7QBuICrSF2M3Ivi7uei5IfowRM51ExVMoB7GY2RSqiljr
         CVMJGvtrsOopm+hKFt+/oz/nCgK4eXAN/Dl8f9aCpJEy/pkVNm4id8v8cn3cHKV640pa
         qphw==
X-Gm-Message-State: APjAAAUBDc/yTM26UtMcFn/AkvefqMb+ZHuRrf4uU9fACpdy52egDdJm
        r0APYZmvWsKyfmiW0QtjbVIavkIL
X-Google-Smtp-Source: APXvYqwv+SaBaNp5Alm1Cio45KnhB1msclOFnBnLUvd9RnuYf3AfkvixIZfJSDX0ykdhkFfIndWx/A==
X-Received: by 2002:a63:7885:: with SMTP id t127mr7128226pgc.338.1554402316636;
        Thu, 04 Apr 2019 11:25:16 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k75sm45820150pfj.46.2019.04.04.11.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:25:16 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:25:15 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] tag: advise on nested tags
Message-ID: <20190404182515.GA29754@dev-l>
References: <cover.1554183429.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1554183429.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey reported confusion on the mailing list about a nested tag
which was most likely created by mistake. Jeff King noted that this
isn't a very common case so, most likely, creating a tag-to-a-tag is a
user-error.

Prevent mistakes by providing advice on nested tags. Add tests to ensure
that advice is given for nested tags.

Reported-by: Robert Dailey <rcdailey.lists@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

The advice message probably needs more work. Also, we currently only
warn on nested tags because I agree with what Peff said here[1], but I
don't really have any strong opinions on the matter so I'm open to
changing it.

[1]: https://public-inbox.org/git/20190404122722.GA23024@sigill.intra.peff.net/

 Documentation/config/advice.txt |  2 ++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/tag.c                   | 14 ++++++++++++--
 t/t7004-tag.sh                  | 11 +++++++++++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 88620429ea..ec4f6ae658 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -90,4 +90,6 @@ advice.*::
 	waitingForEditor::
 		Print a message to the terminal whenever Git is waiting for
 		editor input from the user.
+	nestedTag::
+		Advice shown if a user attempts to recursively tag a tag object.
 --
diff --git a/advice.c b/advice.c
index 567209aa79..ce5f374ecd 100644
--- a/advice.c
+++ b/advice.c
@@ -26,6 +26,7 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
+int advice_nested_tag = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -81,6 +82,7 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
+	{ "nestedTag", &advice_nested_tag },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index f875f8cd8d..cb5d361614 100644
--- a/advice.h
+++ b/advice.h
@@ -26,6 +26,7 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
+extern int advice_nested_tag;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/tag.c b/builtin/tag.c
index faae364e0f..32948fade0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -206,7 +206,14 @@ struct create_tag_options {
 	} cleanup_mode;
 };
 
-static void create_tag(const struct object_id *object, const char *tag,
+static const char message_advice_nested_tag[] =
+	N_("You have created a nested tag. The object referred to by your new is\n"
+	   "already a tag. If you meant to tag the object that it points to, use:\n"
+	   "\n"
+	   "\tgit tag -f %s %s^{}");
+
+static void create_tag(const struct object_id *object, const char *object_ref,
+		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
 		       struct object_id *prev, struct object_id *result)
 {
@@ -218,6 +225,9 @@ static void create_tag(const struct object_id *object, const char *tag,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
+	if (type == OBJ_TAG && advice_nested_tag)
+		advise(_(message_advice_nested_tag), tag, object_ref);
+
 	strbuf_addf(&header,
 		    "object %s\n"
 		    "type %s\n"
@@ -551,7 +561,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
-		create_tag(&object, tag, &buf, &opt, &prev, &object);
+		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object);
 	}
 
 	transaction = ref_transaction_begin(&err);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0b01862c23..34c130ba1c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1700,6 +1700,17 @@ test_expect_success '--points-at finds annotated tags of tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'recursive tagging should give advice' '
+	cat <<-EOF >expected &&
+	hint: You have created a nested tag. The object referred to by your new is
+	hint: already a tag. If you meant to tag the object that it points to, use:
+	hint: 
+	hint: 	git tag -f nested annotated-v4.0^{}
+	EOF
+	git tag -m nested nested annotated-v4.0 2>actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'multiple --points-at are OR-ed together' '
 	cat >expect <<-\EOF &&
 	v2.0
-- 
2.21.0.843.gd0ae0373aa

