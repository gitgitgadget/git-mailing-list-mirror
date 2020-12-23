Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B2C433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E9822571
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgLWBjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgLWBjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAEC0619D4
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so3976363wmz.0
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWx18jxWyxVp2Ztnq2TkFSIVS3GEDccOKICuIjaapIQ=;
        b=s/ZA/IAliTJOFm4aLPbXBynvioigjK3T2JmBBDe+V0jd0oNb527gDCcMNzB/TidjAO
         FXxe26g6eybFHAi7N4pg8+yF7ZEGrEJQOh3uLfXVLULGR2dj97QM2/W1Sbvxk6nx0YFI
         u4O9N4hAb5B7S7VkikroEkxDzSkMD3wjRDzmYVVGhOwszHE1eSuT5b9fnR0HqOnQuQ64
         9WqodcX8QKBMOvz1rN2MlL//IduDEgqCxH0XQUkpsRvnNXF+Nif3IsBE8rOKNDXqKtoo
         QmMTnc1Cj0E5tWrzCtpplRpJ5meiLhBEfT0SkHF4FK+tczPVB/ijLbh7G5MaS+YlLTUV
         9XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWx18jxWyxVp2Ztnq2TkFSIVS3GEDccOKICuIjaapIQ=;
        b=WKEkFWkPzGYr9LJ1x4aiYMTvXy0uEZ/vbyMnxFVVrPgA4aaKNTFyRky3FzrwCUSHld
         gWH8yaLx5VsBkvxlQYLTdeQ/j4AgyAdLIlg2R8O8g6v9BlLtvzIUL6P7TSnTOWziGYFG
         dB0HvbhLjb3ly6vRRRwKzDqWRvNu3jC7ZvHfCYx2MXBWtHyYkGoSdknJtM16IWHGIRDb
         ScIEAmzYJW0B32dSb51OXEeAVOYqp1BInK0dDCqmnrq3pfLd8aTI8LhFrCw8jUOjhpfz
         XG1dU/PYO4CQiHSi/RTmEM1nkuyKJGhSRP1kujI1S+lEMQ0RyDgw/4VCujxIGALPAA/p
         OzPg==
X-Gm-Message-State: AOAM5311cLmKufgEUBFAjcT6b30HQO9uvvb2W2yFBRyz2EAAvQfj1N0z
        sUc+qV1CbIHE6SbzmURH9v/JseLBCVp1ug==
X-Google-Smtp-Source: ABdhPJwxTq8mgepe22kg2GHMooNseKEa5ts+N/8QV+Ql0KC298GqezzCX0SVgs7ZrDl9owm6yrYA6w==
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr24446008wmc.105.1608687482053;
        Tue, 22 Dec 2020 17:38:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:38:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 20/20] mktag: add a --no-strict option
Date:   Wed, 23 Dec 2020 02:36:05 +0100
Message-Id: <20201223013606.7972-21-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that mktag has been migrated to use the fsck machinery to check
its input, it makes sense to teach it to run in the equivalent of "git
fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
do that and support the "--no-strict" option.

Since this is a new option we don't need to cater to parse-option.c's
default of automatically supporting --strict. So let's use
PARSE_OPT_NONEG, using a new trivial helper macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt |  7 +++++++
 builtin/mktag.c             |  9 +++++++++
 parse-options.h             |  1 +
 t/t3800-mktag.sh            | 35 ++++++++++++++++++++++++-----------
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index d04657b219..05e49b6787 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -11,6 +11,13 @@ SYNOPSIS
 [verse]
 'git mktag'
 
+OPTIONS
+-------
+
+--no-strict::
+	By default mktag turns on the equivalent of
+	linkgit:git-fsck[1] `--strict` mode. This disables it.
+
 DESCRIPTION
 -----------
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 9b04b61c2b..a6a4612247 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -10,6 +10,7 @@ static char const * const builtin_mktag_usage[] = {
 	N_("git mktag"),
 	NULL
 };
+static int option_no_strict;
 
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
@@ -25,6 +26,12 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 {
 	switch (msg_type) {
 	case FSCK_WARN:
+		if (option_no_strict) {
+			fprintf_ln(stderr, _("warning: tag input does not pass fsck: %s"), message);
+			return 0;
+
+		}
+		/* fallthrough */
 	case FSCK_ERROR:
 		/*
 		 * We treat both warnings and errors as errors, things
@@ -67,6 +74,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_mktag_options[] = {
+		OPT_NO_BOOL(0, "no-strict", &option_no_strict,
+			    N_("don't do strict fsck checks")),
 		OPT_END(),
 	};
 	struct strbuf buf = STRBUF_INIT;
diff --git a/parse-options.h b/parse-options.h
index 7030d8f3da..90d6a817d7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -166,6 +166,7 @@ struct option {
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
 #define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
+#define OPT_NO_BOOL(s, l, v, h)     OPT_BOOL_F(s, l, v, h, PARSE_OPT_NONEG)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 2e8b718379..b436ae1e44 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -12,12 +12,16 @@ test_description='git mktag: tag object verify test'
 # given in the expect.pat file.
 
 check_verify_failure () {
-	expect="$2"
-	test_expect_success "$1" '
+	test_expect_success "$1" "
 		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
 			git mktag <tag.sig 2>message &&
-		grep "$expect" message
-	'
+		grep '$2' message &&
+		if test '$3' != '--no-strict'
+		then
+			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
+			grep '$2' message.no-strict
+		fi
+	"
 }
 
 test_expect_mktag_success() {
@@ -49,7 +53,8 @@ test_expect_success 'basic usage' '
 	EOF
 	git mktag <tag.sig &&
 	git mktag --end-of-options <tag.sig &&
-	test_expect_code 129 git mktag --unknown-option
+	test_expect_code 129 git mktag --unknown-option &&
+	test_expect_code 129 git mktag --strict
 '
 
 ############################################################
@@ -60,7 +65,7 @@ too short for a tag
 EOF
 
 check_verify_failure 'Tag object length check' \
-	'^error:.* missingObject:'
+	'^error:.* missingObject:' 'strict'
 
 ############################################################
 #  2. object line label check
@@ -206,7 +211,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify tag-name check' \
-	'^error:.* badTagName:'
+	'^error:.* badTagName:' '--no-strict'
 
 ############################################################
 # 11. tagger line label check #1
@@ -220,7 +225,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error:.* missingTaggerEntry:'
+	'^error:.* missingTaggerEntry:' '--no-strict'
 
 ############################################################
 # 12. tagger line label check #2
@@ -235,7 +240,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error:.* missingTaggerEntry:'
+	'^error:.* missingTaggerEntry:' '--no-strict'
 
 ############################################################
 # 13. allow missing tag author name like fsck
@@ -264,7 +269,7 @@ tagger T A Gger <
 EOF
 
 check_verify_failure 'disallow malformed tagger' \
-	'^error:.* badEmail:'
+	'^error:.* badEmail:' '--no-strict'
 
 ############################################################
 # 15. allow empty tag email
@@ -388,13 +393,21 @@ this line should not be here
 EOF
 
 check_verify_failure 'detect invalid header entry' \
-	'^error:.* extraHeaderEntry:'
+	'^error:.* extraHeaderEntry:' '--no-strict'
 
 test_expect_success 'invalid header entry config & fsck' '
 	test_must_fail git mktag <tag.sig &&
+	git mktag --no-strict <tag.sig &&
+
 	test_must_fail git -c fsck.extraHeaderEntry=error mktag <tag.sig &&
+	test_must_fail git -c fsck.extraHeaderEntry=error mktag --no-strict <tag.sig &&
+
 	test_must_fail git -c fsck.extraHeaderEntry=warn mktag <tag.sig &&
+	git -c fsck.extraHeaderEntry=warn mktag --no-strict <tag.sig &&
+
 	git -c fsck.extraHeaderEntry=ignore mktag <tag.sig &&
+	git -c fsck.extraHeaderEntry=ignore mktag --no-strict <tag.sig &&
+
 	git fsck &&
 	env GIT_TEST_GETTEXT_POISON=false \
 		git -c fsck.extraHeaderEntry=warn fsck 2>err &&
-- 
2.29.2.222.g5d2a92d10f8

