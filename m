Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0D21F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439049AbeKWJsJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439027AbeKWJsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so10625361wrx.9
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbiZMxZ1VO+oq3PPG9CYoeHdONpyxtiR/dJlfWGOFuM=;
        b=T4K3az4t82i0Ac2r+BxmC0hPMQj4h+RNciDIZX0gor0KXnFbblv8jxEcp28kxkNQiS
         YBGqY4YwrbcgdnKxIM4/f6jemcAxYDRkP+r9cXmwruS7GqJxCkl0LhaoYBAG5NvFX3OB
         2ga0ssI9j6TolYHG74/Il5lVNbmaUyEyMeLSxohqxzfVLvcoL1yYxeI0C91MedUe5YH8
         E3Gphyn0zq/P4JqxmexXCAeNVmgEJ3ru0blPM6JTbt/ucKus+CGe1Yo4J07zIaxc4/XD
         H3jxLsPyZJ5dSMZ5K3/veTZZQte97YjUS3VLtQtDwfsaHp+zEEH5m4drQCMS6Kv/Tuqf
         eoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbiZMxZ1VO+oq3PPG9CYoeHdONpyxtiR/dJlfWGOFuM=;
        b=pPM59FU0tdGfKTaVLCtfSfbDFkdd0PgHw392hcJ58ctpdl73Y7corZIyO9BH9Fy0XB
         RRvwHmETOJ+9lL75qQKLQc5wROjrlvPWf7StZ07GGS29MgKPQZpO2/8ZT7aTFZIaarXn
         dMY7O/vnDeujKZCzxqkOI4757YC+fCzZoWnaYXNfmMKSUokY4E0Iw6sVczA4XShKyaKK
         E7qr72BVRri+fuplVveMoe+mDmpgSPALcB300QlUCe06tyKrZQB432Imr0KUJJT5FMt0
         pmj+MS8z0ywzm2522GXvPnp80UCZvz77/Jy/sBQv9RZvxIZH+CdezSe7F34Cy2GjC5+d
         Xuvw==
X-Gm-Message-State: AA+aEWZ/ccWu5sqarP27l84C269Vj6xEzDppUQhQVLzefE662CRYvIEO
        GGNQ8vaoU+TEPBvxSBbfAF2J+yAO
X-Google-Smtp-Source: AFSGD/XagGVspv3Y1vK1v62rjPkuhT8DmNrTrTf+OuIUiVKqyIC9nQ1T8kYQsfZ782hg2/YZqgfKWg==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr11189396wre.244.1542927983982;
        Thu, 22 Nov 2018 15:06:23 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:23 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 12/22] stash: convert pop to builtin
Date:   Fri, 23 Nov 2018 01:05:32 +0200
Message-Id: <3fef00c4cb29a9096eefd0ee1512b58a5b658ccc.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 39 +++++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 68b65165e4..d7ff78784b 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
@@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -543,6 +548,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	int index = 0;
+	int quiet = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			 N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
+		printf_ln(_("The stash entry is kept in case "
+			    "you need it again."));
+	else
+		ret = do_drop_stash(prefix, &info, quiet);
+
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	int ret;
@@ -607,6 +642,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 29d9f44255..8f2640fe90 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -554,50 +554,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -655,7 +611,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.19.1.878.g0482332a22

