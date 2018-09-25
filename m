Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC80C1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeIZEoV (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35633 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIZEoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id y21-v6so204826edr.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9yi4pehCrT28vEnrSBu3au5TlWfEPICxy1Qu0sGII2c=;
        b=Bc/6YL4ZU/Hjb5uVRqcuOU2ksXWCCkcjMeKhETfJNyAjRwj4btk2z3rky0hlz4KBlD
         G5YmLMjMEJaQXEqaFONVcr3cwn4GvRGOePC54Li5M6aWLTNH46+MNUL2fRh+fqNUEIZ4
         L6RwjJs9m2zZ66SY0GMIqXvY3siMRpKIAjTzPt47H721qVdeSJXVUd1yfagzrsyHuiWD
         Vh/cGSd3qdrbU7af5PT8xiKeD2tWgLRqCNmEWz+twYF4HeaMZz+rJNFdIrtrc9b+fcnJ
         zy023je5v988ZujUwVdk+svd9Symu10i+NgepBRJv2UNWoEMUd63WyRwDqDY7r4pK8O6
         /hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yi4pehCrT28vEnrSBu3au5TlWfEPICxy1Qu0sGII2c=;
        b=Tnj5myGcCIYHvijfQJdJBITtXl7qfxDY6rZkz1Mb0CFB37Pf0Nk9/IPj1BjFyygiXr
         50WgOLy3h/h9wiIkjPp2QkSC6hCgVZgetoH/XHB3RQtK6mwA56PXF9ITqruw5A28fcjj
         PhnJ1PWzeC2WYa4zWluKBD/vFVF695kPjOa1WkJwQ4MLhY6NBlO+cnMkiPcfJ/AW07LQ
         kgVslx75fddnWnw1mXa/dZGLC4zoC0mywVXMiAxbQQGzbNy7TRLIZyeC3XyeyPtZSPeX
         QL9S8NiuiKAZTWO1GceyU0ISuuaMBNQFlbPjSTLnV7kDNt6vNCSRlCsm+52R53QqWVcX
         DaJw==
X-Gm-Message-State: ABuFfojP8lxdZzMnIJsKsAN34nnBNd+YwmzMVl+KO28PU3gUaWaTwisE
        nFc4jiAb9hzrrC4hrPbrq3Q58QHS
X-Google-Smtp-Source: ACcGV61eKALrpOkzIPbA7rGwGmrnOrnnFOx3GIrBdgRV/AKleenC1EkfMs7hkFsKG4B5YqO6bXLvmQ==
X-Received: by 2002:a50:a5db:: with SMTP id b27-v6mr4760664edc.137.1537914873529;
        Tue, 25 Sep 2018 15:34:33 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:32 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 10/21] stash: convert pop to builtin
Date:   Wed, 26 Sep 2018 01:33:26 +0300
Message-Id: <716078e70b01febefd9bd5300ce60de6d5bbd6f4.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 38 ++++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 5841bd0e98..c1f78d3275 100644
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
@@ -542,6 +547,35 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
+		printf_ln(_("The stash entry is kept in case you need it again."));
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
@@ -606,6 +640,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g1fb9f40d88

